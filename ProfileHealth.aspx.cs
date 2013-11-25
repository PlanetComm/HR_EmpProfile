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
    public partial class ProfileHealth : System.Web.UI.Page
    {
        NP_Cls NP = new NP_Cls();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DGV();
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
                    this.Session["HE"] = NP.Execute("[stp_ep_inquiry_Hea] '" + this.Request.QueryString["E"].ToString() + "'", ref NP_Cls.strErr);
                }
            }
            else
            {
                this.Session["HE"] = NP.Execute("[stp_ep_inquiry_Hea] '" + (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString() + "'", ref NP_Cls.strErr);
            }

            this.rgHea.DataSource = this.Session["HE"];
            this.rgHea.DataBind();
        }
        private void Clear()
        {
            this.chkAnn.Checked = false; this.chkSelf.Checked = false; this.chkYes.Checked = false;
            this.dtpHeaFrom.Clear(); this.dtpHeaTo.Clear(); this.txtHospital.Text = string.Empty; this.txtComment.Text = string.Empty;
        }

        protected void btnAdd_Click(object sender, ImageClickEventArgs e)
        {
            if (Page.IsValid)
            {

                if (this.Session["HE"] != null)
                {
                    //// Duplicate
                    //for (int i = 0; i < (this.Session["HE"] as DataSet).Tables[0].Rows.Count; i++)
                    //{
                    //    if (this.dtpHeaFrom.SelectedDate.Value.ToString("dd MMM yyyy", NP_Cls.cul).Contains(DateTime.Parse((this.Session["SL"] as DataSet).Tables[0].Rows[i]["HeaFrom"].ToString().Trim()).ToString("dd MMM yyyy", NP_Cls.cul)))
                    //    {
                    //        this.NotifyWarn.Text = "Already Add " + this.dtpSalaryStart.SelectedDate.Value.ToString("dd MMM yyyy") + " in list !!"; this.NotifyWarn.Show(); return;
                    //    }
                    //}

                    if ((!this.chkAnn.Checked) && (!this.chkSelf.Checked)) { this.NotifyWarn.Text = "Please select Type !!"; this.NotifyWarn.Show(); return; }

                    DataSet ds = new DataSet();
                    ds = this.Session["HE"] as DataSet;
                    DataRow dr; dr = ds.Tables[0].NewRow();
                    dr["HeaTypeRE"] = (this.chkAnn.Checked ? 1 : 2);
                    dr["HeaUseRE"] = this.chkYes.Checked;

                    dr["HeaType"] = (this.chkAnn.Checked ? "Annual Check" : "Self Check");
                    dr["HeaUse"] = (this.chkYes.Checked ? "Yes" : "No");

                    dr["HeaFrom"] = this.dtpHeaFrom.SelectedDate.Value; dr["HeaTo"] = this.dtpHeaTo.SelectedDate.Value;
                    dr["HeaHospital"] = this.txtHospital.Text.Trim(); dr["HeaDetail"] = this.txtComment.Text.Trim();

                    ds.Tables[0].Rows.Add(dr); ds.AcceptChanges();
                    this.Session["HE"] = ds;

                    ////Sort
                    //DataTable dt = new DataTable();
                    //dt = (this.Session["SL"] as DataSet).Tables[0].DefaultView.ToTable();
                    //dt.DefaultView.Sort = "SalStartDate DESC"; dt = dt.DefaultView.ToTable();
                    //(this.Session["SL"] as DataSet).Tables.Clear();
                    //(this.Session["SL"] as DataSet).Tables.Add(dt);

                    this.rgHea.DataSource = this.Session["HE"];
                    this.rgHea.DataBind();
                }
            }
        }
        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            if (this.rgHea.Items.Count == 0) { this.NotifyWarn.Text = "Data not found to Save !!"; this.NotifyWarn.Show(); return; }
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
                cmd.Parameters.Add("@LogTable", SqlDbType.NVarChar, 50).Value = "Health";
                cmd.Parameters.Add("@LogUser", SqlDbType.NVarChar, 50).Value = this.Session["LU"].ToString();

                cmd.CommandText = NP_Cls.sqlDelete; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                cmd.ExecuteNonQuery();

                cmd.Parameters.Clear();

                NP_Cls.sqlDelete = "[stp_ep_delete_Hea]";
                cmd.Parameters.Add("@EmployeeID", SqlDbType.NVarChar, 50).Value = (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString();

                cmd.CommandText = NP_Cls.sqlDelete; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                cmd.ExecuteNonQuery();

                cmd.Parameters.Clear();

                for (int i = 0; i < this.rgHea.Items.Count; i++)
                {
                    cmd.Parameters.Clear();
                    NP_Cls.sqlInsert = "[stp_ep_insert_Hea]";
                    cmd.Parameters.Add("@EmployeeID", SqlDbType.NVarChar, 50).Value = (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString();
                    cmd.Parameters.Add("@HeaType", SqlDbType.Int).Value = int.Parse(this.rgHea.Items[i]["clnHeaTypeRE"].Text.Trim());
                    cmd.Parameters.Add("@HeaUse", SqlDbType.Bit).Value = bool.Parse(this.rgHea.Items[i]["clnHeaUseRE"].Text.Trim());
                    cmd.Parameters.Add("@HeaFrom", SqlDbType.Date).Value = DateTime.Parse(this.rgHea.Items[i]["clnHeaFrom"].Text.Trim());
                    cmd.Parameters.Add("@HeaTo", SqlDbType.Date).Value = DateTime.Parse(this.rgHea.Items[i]["clnHeaTo"].Text.Trim());
                    cmd.Parameters.Add("@HeaHospital", SqlDbType.NVarChar, 100).Value = this.rgHea.Items[i]["clnHeaHospital"].Text.Trim();
                    cmd.Parameters.Add("@HeaDetail", SqlDbType.NVarChar , 1000).Value = this.rgHea.Items[i]["clnHeaDetail"].Text.Trim();
                    cmd.Parameters.Add("@CreateUser", SqlDbType.NVarChar, 50).Value = this.Session["LU"].ToString();

                    cmd.CommandText = NP_Cls.sqlInsert; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                    cmd.ExecuteNonQuery();
                }

                TR.Commit();

                DGV();
                Clear(); this.chkAnn.Focus();
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
            Clear(); this.chkAnn.Focus();
        }
        protected void rgHea_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.ToUpper() == "DELETE")
            {
                if (this.Session["HE"] != null)
                {
                    (this.Session["HE"] as DataSet).Tables[0].Rows.RemoveAt(e.Item.ItemIndex);
                    this.rgHea.DataSource = this.Session["HE"];
                    this.rgHea.DataBind();
                }
            }
        }


    }
}