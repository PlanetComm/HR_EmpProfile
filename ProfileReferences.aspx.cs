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
    public partial class ProfileReferences : System.Web.UI.Page
    {
        NP_Cls NP = new NP_Cls();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DGV();
                this.cbRefType.Focus();
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
                    this.Session["RF"] = NP.Execute("[stp_ep_inquiry_Ref] '" + this.Request.QueryString["E"].ToString() + "'", ref NP_Cls.strErr);
                }
            }
            else
            {
                this.Session["RF"] = NP.Execute("[stp_ep_inquiry_Ref] '" + (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString() + "'", ref NP_Cls.strErr);
            }

            this.rgRef.DataSource = this.Session["RF"];
            this.rgRef.DataBind();
        }
        private void Clear()
        {
            this.cbRefType.SelectedIndex = -1; this.txtRefName.Text = string.Empty; this.txtRefAddress.Text = string.Empty;
            this.lblCh.Text = string.Empty; this.txtRefCh.Text = string.Empty; this.txtRefTel.Text = string.Empty;
        }
        protected void btnAdd_Click(object sender, ImageClickEventArgs e)
        {
            if (Page.IsValid)
            {

                if (this.Session["RF"] != null)
                {
                    DataSet ds = new DataSet();
                    ds = this.Session["RF"] as DataSet;
                    DataRow dr; dr = ds.Tables[0].NewRow();
                    dr["RefType"] = this.cbRefType.SelectedValue.Trim();
                    dr["RefName"] = this.txtRefName.Text.Trim();
                    dr["RefAddress"] = this.txtRefAddress.Text.Trim();
                    dr["RefCh"] = this.txtRefCh.Text.Trim();
                    dr["RefTel"] = this.txtRefTel.Text.Trim();

                    ds.Tables[0].Rows.Add(dr); ds.AcceptChanges();
                    this.Session["RF"] = ds;

                    this.rgRef.DataSource = this.Session["RF"];
                    this.rgRef.DataBind();
                }
            }
        }

        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            if (this.rgRef.Items.Count == 0) { this.NotifyWarn.Text = "Data not found to Save !!"; this.NotifyWarn.Show(); return; }
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
                cmd.Parameters.Add("@LogTable", SqlDbType.NVarChar, 50).Value = "References";
                cmd.Parameters.Add("@LogUser", SqlDbType.NVarChar, 50).Value = this.Session["LU"].ToString();

                cmd.CommandText = NP_Cls.sqlDelete; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                cmd.ExecuteNonQuery();

                cmd.Parameters.Clear();

                NP_Cls.sqlDelete = "[stp_ep_delete_Ref]";
                cmd.Parameters.Add("@EmployeeID", SqlDbType.NVarChar, 50).Value = (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString();

                cmd.CommandText = NP_Cls.sqlDelete; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                cmd.ExecuteNonQuery();

                cmd.Parameters.Clear();

                for (int i = 0; i < this.rgRef.Items.Count; i++)
                {
                    cmd.Parameters.Clear();
                    NP_Cls.sqlInsert = "[stp_ep_insert_Ref]";
                    cmd.Parameters.Add("@EmployeeID", SqlDbType.NVarChar, 50).Value = (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString();
                    cmd.Parameters.Add("@RefType", SqlDbType.NVarChar, 20).Value = this.rgRef.Items[i]["clnRefType"].Text.Trim();
                    cmd.Parameters.Add("@RefName", SqlDbType.NVarChar, 50).Value = this.rgRef.Items[i]["clnRefName"].Text.Trim();
                    cmd.Parameters.Add("@RefAddress", SqlDbType.NVarChar, 500).Value = this.rgRef.Items[i]["clnRefAddress"].Text.Trim();
                    cmd.Parameters.Add("@RefCh", SqlDbType.NVarChar, 50).Value = this.rgRef.Items[i]["clnRefCh"].Text.Trim();
                    cmd.Parameters.Add("@RefTel", SqlDbType.NVarChar, 50).Value = this.rgRef.Items[i]["clnRefTel"].Text.Trim();
                    cmd.Parameters.Add("@CreateUser", SqlDbType.NVarChar, 50).Value = this.Session["LU"].ToString();

                    cmd.CommandText = NP_Cls.sqlInsert; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                    cmd.ExecuteNonQuery();
                }

                TR.Commit();

                DGV();
                Clear(); this.cbRefType.Focus();
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
            Clear(); this.cbRefType.Focus();
        }
        protected void rgRef_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.ToUpper() == "DELETE")
            {
                if (this.Session["RF"] != null)
                {
                    (this.Session["RF"] as DataSet).Tables[0].Rows.RemoveAt(e.Item.ItemIndex);
                    this.rgRef.DataSource = this.Session["RF"];
                    this.rgRef.DataBind();
                }
            }
        }

        protected void cbRefType_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if (this.cbRefType.SelectedValue.Trim().StartsWith("B"))
            {
                this.lblCh.Text = "Position"; this.reqCh.ErrorMessage = "Position";
            }
            else if (this.cbRefType.SelectedValue.Trim().StartsWith("P"))
            {
                this.lblCh.Text = "Relationship"; this.reqCh.ErrorMessage = "Relationship";
            }
            else
            {
                this.lblCh.Text = ""; this.reqCh.ErrorMessage = "**";
            }
        }
    }
}