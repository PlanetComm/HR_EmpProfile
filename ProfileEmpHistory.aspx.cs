using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace HR_EmpProfile
{
    public partial class ProfileEmpHistory : System.Web.UI.Page
    {
        NP_Cls NP = new NP_Cls();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DGV();

                this.txtHisComName.Focus();
            }
        }

        private void DGV()
        {
            if (this.Session["USER"] == null)
            {
                if (Request.QueryString["E"] == null)
                {
                    Response.Redirect("ProfileInquiry.aspx");
                }
                else
                {
                    this.Session["HS"] = NP.Execute("[stp_ep_inquiry_His] '" + this.Request.QueryString["E"].ToString() + "'", ref NP_Cls.strErr);
                }
            }
            else
            {
                this.Session["HS"] = NP.Execute("[stp_ep_inquiry_His] '" + (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString() + "'", ref NP_Cls.strErr);
            }

            this.rgHis.DataSource = this.Session["HS"];
            this.rgHis.DataBind();
        }
        private void Clear()
        {
            this.txtHisComName.Text = string.Empty; this.dtpHisFrom.Clear(); this.dtpHisTo.Clear();
            this.txtHisAddress.Text = string.Empty; this.numHisStart.Value = null; this.numHisEnd.Value = null; this.chkPresent.Checked = false; 
            this.txtHisPosition.Text = string.Empty; this.txtHisDuties.Text = string.Empty; this.txtHisReason.Text = string.Empty;
            this.cbEmpType.SelectedIndex = 0;
        }
        protected void btnAdd_Click(object sender, ImageClickEventArgs e)
        {
            if (Page.IsValid)
            {

                if (this.Session["HS"] != null)
                {

                    if (Duplicate()) { this.NotifyWarn.Text = "You already save the Present time for this employee !!"; this.NotifyWarn.Show(); return; }

                    DataSet ds = new DataSet();
                    ds = this.Session["HS"] as DataSet;
                    DataRow dr; dr = ds.Tables[0].NewRow();
                    dr["HisComName"] = this.txtHisComName.Text.Trim();
                    dr["HisFrom"] = this.dtpHisFrom.SelectedDate.Value.ToString("dd MMM yyyy");
                    dr["HisTo"] = (this.chkPresent.Checked ? "Present" : this.dtpHisTo.SelectedDate.Value.ToString("dd MMM yyyy"));

                    dr["HisFromRe"] = this.dtpHisFrom.SelectedDate.Value;
                    dr["HisToRe"] = this.dtpHisTo.SelectedDate.Value;
                    dr["IsPresent"] = this.chkPresent.Checked;

                    dr["HisAddress"] = this.txtHisAddress.Text.Trim();
                    dr["HisStart"] = this.numHisStart.Value;
                    dr["HisEnd"] = this.numHisEnd.Value;
                    dr["HisPosition"] = this.txtHisPosition.Text.Trim();
                    dr["HisDuties"] = this.txtHisDuties.Text.Trim();
                    dr["HisReason"] = this.txtHisReason.Text.Trim();
                    dr["HisEmpType"] = this.cbEmpType.SelectedValue.Trim();

                    ds.Tables[0].Rows.Add(dr); ds.AcceptChanges();
                    this.Session["HS"] = ds;

                    this.rgHis.DataSource = this.Session["HS"];
                    this.rgHis.DataBind();
                }
            }
        }

        private bool Duplicate()
        {
            for (int i = 0; i < (this.Session["HS"] as DataSet).Tables[0].Rows.Count; i++)
            {
                if (this.chkPresent.Checked)
                {
                    if (Convert.ToBoolean((this.Session["HS"] as DataSet).Tables[0].Rows[i]["IsPresent"].ToString()))
                    {
                        return true;
                    }
                }
            }

            return false;

        }
        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            if (this.rgHis.Items.Count == 0) { this.NotifyWarn.Text = "Data not found to Save !!"; this.NotifyWarn.Show(); return; }
            SqlConnection oConn = new SqlConnection(NP_Cls.strconn);
            if (oConn.State == ConnectionState.Open) { oConn.Close(); }
            oConn.Open();
            try
            {
                SqlCommand cmd = new SqlCommand();
                SqlTransaction TR;
                TR = oConn.BeginTransaction();

                NP_Cls.sqlDelete = "[stp_ep_log]";
                cmd.Parameters.Add("@LogName", SqlDbType.NVarChar, 50).Value = "DELETE";
                cmd.Parameters.Add("@LogKey", SqlDbType.NVarChar, 50).Value = (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString();
                cmd.Parameters.Add("@LogTable", SqlDbType.NVarChar, 50).Value = "EmpHistory";
                cmd.Parameters.Add("@LogUser", SqlDbType.NVarChar, 50).Value = this.Session["LU"].ToString();

                cmd.CommandText = NP_Cls.sqlDelete; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                cmd.ExecuteNonQuery();

                cmd.Parameters.Clear();

                NP_Cls.sqlDelete = "[stp_ep_delete_His]";
                cmd.Parameters.Add("@EmployeeID", SqlDbType.NVarChar, 50).Value = (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString();

                cmd.CommandText = NP_Cls.sqlDelete; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                cmd.ExecuteNonQuery();

                cmd.Parameters.Clear();

                for (int i = 0; i < this.rgHis.Items.Count; i++)
                {
                    cmd.Parameters.Clear();
                    NP_Cls.sqlInsert = "[stp_ep_insert_His]";
                    cmd.Parameters.Add("@EmployeeID", SqlDbType.NVarChar, 50).Value = (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString();
                    cmd.Parameters.Add("@HisComName", SqlDbType.NVarChar, 100).Value = this.rgHis.Items[i]["clnHisComName"].Text.Trim();
                    cmd.Parameters.Add("@HisFrom", SqlDbType.Date).Value = DateTime.Parse(this.rgHis.Items[i]["clnHisFromRe"].Text.Trim());
                    cmd.Parameters.Add("@HisTo", SqlDbType.Date).Value = DateTime.Parse(this.rgHis.Items[i]["clnHisToRe"].Text.Trim());
                    cmd.Parameters.Add("@IsPresent", SqlDbType.Bit).Value = Convert.ToBoolean(this.rgHis.Items[i]["clnIsPresent"].Text.Trim());
                    cmd.Parameters.Add("@HisAddress", SqlDbType.NVarChar, 500).Value = this.rgHis.Items[i]["clnHisAddress"].Text.Trim();
                    cmd.Parameters.Add("@HisStart", SqlDbType.Decimal).Value = decimal.Parse(this.rgHis.Items[i]["clnHisStart"].Text.Trim());
                    cmd.Parameters.Add("@HisEnd", SqlDbType.Decimal).Value = decimal.Parse(this.rgHis.Items[i]["clnHisEnd"].Text.Trim());
                    cmd.Parameters.Add("@HisPosition", SqlDbType.NVarChar, 50 ).Value = this.rgHis.Items[i]["clnHisPosition"].Text.Trim();
                    cmd.Parameters.Add("@HisDuties", SqlDbType.NVarChar, 500).Value = this.rgHis.Items[i]["clnHisDuties"].Text.Trim();
                    cmd.Parameters.Add("@HisReason", SqlDbType.NVarChar, 500).Value = this.rgHis.Items[i]["clnHisReason"].Text.Trim();
                    cmd.Parameters.Add("@CreateUser", SqlDbType.NVarChar, 50).Value = this.Session["LU"].ToString();
                    cmd.Parameters.Add("@HisEmpType", SqlDbType.NVarChar, 1).Value = this.rgHis.Items[i]["clnHisEmpType"].Text.Trim();

                    cmd.CommandText = NP_Cls.sqlInsert; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                    cmd.ExecuteNonQuery();
                }

                TR.Commit();

                DGV();
                Clear(); this.txtHisComName.Focus();
                this.NotifyInfo.Text = "Save Completed !!"; this.NotifyInfo.Show();

            }
            catch (Exception ex)
            {
                this.NotifyWarn.Text = "Err : " + ex.Message; this.NotifyWarn.Show();
                return;
            }
            finally
            {
                if (oConn.State == ConnectionState.Open) { oConn.Close(); }
            }
        }
        protected void btnReset_Click(object sender, ImageClickEventArgs e)
        {
            Clear(); this.txtHisComName.Focus();
        }

        protected void rgEdu_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.ToUpper() == "DELETE")
            {
                if (this.Session["HS"] != null)
                {
                    (this.Session["HS"] as DataSet).Tables[0].Rows.RemoveAt(e.Item.ItemIndex);
                    this.rgHis.DataSource = this.Session["HS"];
                    this.rgHis.DataBind();
                }
            }
        }
        protected void chkPresent_CheckedChanged(object sender, EventArgs e)
        {
            if (this.chkPresent.Checked)
            {
                this.dtpHisTo.SelectedDate = DateTime.Now;
            }
            else
            {
                this.dtpHisTo.Clear();
            }
        }
    }
}