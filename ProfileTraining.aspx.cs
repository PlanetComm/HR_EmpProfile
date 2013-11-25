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
    public partial class ProfileTraining : System.Web.UI.Page
    {
        NP_Cls NP = new NP_Cls();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DGV();
                this.dtpDate.Focus();
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
                    this.Session["TR"] = NP.Execute("[stp_ep_inquiry_Tra] '" + this.Request.QueryString["E"].ToString() + "'", ref NP_Cls.strErr);
                }
            }
            else
            {
                this.Session["TR"] = NP.Execute("[stp_ep_inquiry_Tra] '" + (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString() + "'", ref NP_Cls.strErr);
            }

            this.rgTr.DataSource = (this.Session["TR"] as DataSet).Tables[0];
            this.rgTr.DataBind();
        }
        private void Clear()
        {
            this.dtpDate.Clear(); this.txtName.Text = string.Empty; this.txtTeacher.Text = string.Empty;
            this.txtDetail.Text = string.Empty; 
        }

        protected void rgTr_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.ToUpper() == "DELETE")
            {
                if (this.Session["TR"] != null)
                {
                    (this.Session["TR"] as DataSet).Tables[0].Rows.RemoveAt(e.Item.ItemIndex);
                    this.rgTr.DataSource = this.Session["TR"];
                    this.rgTr.DataBind();
                }
            }
        }

        protected void btnAdd_Click(object sender, ImageClickEventArgs e)
        {
            if (Page.IsValid)
            {
                if (this.Session["TR"] != null)
                {
                    DataSet ds = new DataSet();
                    ds = this.Session["TR"] as DataSet;
                    DataRow dr; dr = ds.Tables[0].NewRow();
                    dr["TrYear"] = this.dtpDate.SelectedDate.Value;
                    dr["TrName"] = this.txtName.Text.Trim();
                    dr["TrDetails"] = this.txtDetail.Text.Trim();
                    dr["TrTeacher"] = this.txtTeacher.Text.Trim();
                    
                    ds.Tables[0].Rows.Add(dr); ds.AcceptChanges();
                    this.Session["TR"] = ds;

                    Clear();

                    this.rgTr.DataSource = this.Session["TR"];
                    this.rgTr.DataBind();
                }

            }
        }
        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            if (this.rgTr.Items.Count == 0) { this.NotifyWarn.Text = "Data not found to Save !!"; this.NotifyWarn.Show(); return; }
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
                cmd.Parameters.Add("@LogTable", SqlDbType.NVarChar, 50).Value = "Trianing";
                cmd.Parameters.Add("@LogUser", SqlDbType.NVarChar, 50).Value = this.Session["LU"].ToString();

                cmd.CommandText = NP_Cls.sqlDelete; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                cmd.ExecuteNonQuery();

                cmd.Parameters.Clear();

                NP_Cls.sqlDelete = "[stp_ep_delete_Tra]";
                cmd.Parameters.Add("@EmployeeID", SqlDbType.NVarChar, 50).Value = (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString();

                cmd.CommandText = NP_Cls.sqlDelete; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                cmd.ExecuteNonQuery();

                cmd.Parameters.Clear();

                for (int i = 0; i < this.rgTr.Items.Count; i++)
                {
                    cmd.Parameters.Clear();
                    NP_Cls.sqlInsert = "[stp_ep_insert_Tra]";
                    cmd.Parameters.Add("@EmployeeID", SqlDbType.NVarChar, 50).Value = (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString();
                    cmd.Parameters.Add("@TrYear", SqlDbType.Date).Value = DateTime.Parse(this.rgTr.Items[i]["clnTrYear"].Text.Trim());
                    cmd.Parameters.Add("@TrName", SqlDbType.NVarChar, 100).Value = this.rgTr.Items[i]["clnTrName"].Text.Trim();
                    cmd.Parameters.Add("@TrDetails", SqlDbType.NVarChar, 500).Value =this.rgTr.Items[i]["clnTrDetails"].Text.Trim();
                    cmd.Parameters.Add("@TrTeacher", SqlDbType.NVarChar, 50).Value = this.rgTr.Items[i]["clnTrTeacher"].Text.Trim();

                    cmd.Parameters.Add("@CreateUser", SqlDbType.NVarChar, 50).Value = this.Session["LU"].ToString();

                    cmd.CommandText = NP_Cls.sqlInsert; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                    cmd.ExecuteNonQuery();
                }

                TR.Commit();

                DGV();
                Clear(); this.rgTr.Focus();
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
            Clear(); this.dtpDate.Focus();
        }
    }
}