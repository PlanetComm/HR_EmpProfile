using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using Telerik.Web.UI;

namespace HR_EmpProfile
{
    public partial class ProfileWarning : System.Web.UI.Page
    {
        NP_Cls NP = new NP_Cls();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                RadUpload1.AllowedFileExtensions = new string[] { ".pdf", ".jpg", ".jpeg", ".png" };
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
                    this.Session["WN"] = NP.Execute("[stp_ep_inquiry_Wn] '" + this.Request.QueryString["E"].ToString() + "'", ref NP_Cls.strErr);
                }
            }
            else
            {
                this.Session["WN"] = NP.Execute("[stp_ep_inquiry_Wn] '" + (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString() + "'", ref NP_Cls.strErr);
            }

            this.rgWn.DataSource = this.Session["WN"];
            this.rgWn.DataBind();
        }
        private void Clear()
        {
            this.dtpStartDate.Clear(); this.txtDateExpire.Text = string.Empty; this.cbType.SelectedIndex = 0;
            this.numCount.Value = null; this.txtDetails.Text = string.Empty; this.RadUpload1.UploadedFiles.Clear();
        }
        protected void btnAdd_Click(object sender, ImageClickEventArgs e)
        {
            if (Page.IsValid)
            {
                if (this.Session["WN"] != null)
                {
                    DataSet ds = new DataSet();
                    ds = this.Session["WN"] as DataSet;
                    DataRow dr; dr = ds.Tables[0].NewRow();

                    dr["WnStartDate"] = this.dtpStartDate.SelectedDate.Value; dr["WnExpireDate"] = this.txtDateExpire.SelectedDate.Value;
                    dr["WnType"] = this.cbType.SelectedValue; dr["WnCount"] = this.numCount.Value;
                    dr["WnDetails"] = this.txtDetails.Text.Trim(); dr["WnAttachFile"] = this.RadUpload1.UploadedFiles[0].FileName;
                    ds.Tables[0].Rows.Add(dr); ds.AcceptChanges();
                    this.Session["WN"] = ds;

                    //Sort
                    DataTable dt = new DataTable();
                    dt = (this.Session["WN"] as DataSet).Tables[0].DefaultView.ToTable();
                    dt.DefaultView.Sort = "WnType, WnCount"; dt = dt.DefaultView.ToTable();
                    (this.Session["WN"] as DataSet).Tables.Clear();
                    (this.Session["WN"] as DataSet).Tables.Add(dt);

                    this.rgWn.DataSource = this.Session["WN"];
                    this.rgWn.DataBind();
                }
            }
        }

        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            if (Page.IsValid)
            {   
                if (RadUpload1.InvalidFiles.Count > 0)
                {
                    this.NotifyWarn.Text = "Please upload Only PDF file !!"; this.NotifyWarn.Show(); this.RadUpload1.Focus(); return;
                }
                //Upload File
                if (this.RadUpload1.UploadedFiles.Count == 0)
                {
                    this.NotifyWarn.Text = "Please upload [ PDF ] file !!"; this.NotifyWarn.Show(); this.RadUpload1.Focus(); return;
                }

             
              
                //if (this.rgWn.Items.Count == 0) { this.NotifyWarn.Text = "Data not found to Save !!"; this.NotifyWarn.Show(); return; }
                SqlConnection oConn = new SqlConnection(NP_Cls.strconn);
                if (oConn.State == ConnectionState.Open) { oConn.Close(); }
                oConn.Open();
                try
                {
                    SqlCommand cmd = new SqlCommand();
                    SqlTransaction TR;
                    TR = oConn.BeginTransaction();

                    //NP_Cls.sqlDelete = "[stp_ep_log]";
                    //cmd.Parameters.Add("@LogName", SqlDbType.NVarChar, 50).Value = "DELETE";
                    //cmd.Parameters.Add("@LogKey", SqlDbType.NVarChar, 50).Value = (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString();
                    //cmd.Parameters.Add("@LogTable", SqlDbType.NVarChar, 50).Value = "Evaluation";
                    //cmd.Parameters.Add("@LogUser", SqlDbType.NVarChar, 50).Value = this.Session["LU"].ToString();

                    //cmd.CommandText = NP_Cls.sqlDelete; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                    //cmd.ExecuteNonQuery();

                    //cmd.Parameters.Clear();

                    //NP_Cls.sqlDelete = "[stp_ep_delete_Eva]";
                    //cmd.Parameters.Add("@EmployeeID", SqlDbType.NVarChar, 50).Value = (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString();

                    //cmd.CommandText = NP_Cls.sqlDelete; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                    //cmd.ExecuteNonQuery();

                    //cmd.Parameters.Clear();

                    //for (int i = 0; i < this.rgEva.Items.Count; i++)
                    //{
                    //cmd.Parameters.Clear();
                    
                    NP_Cls.sqlInsert = "[stp_ep_insert_Wn]";
                    cmd.Parameters.Add("@EmployeeID", SqlDbType.NVarChar, 50).Value = (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString();
                    cmd.Parameters.Add("@WnStartDate", SqlDbType.Date).Value = this.dtpStartDate.SelectedDate.Value; //DateTime.Parse(this.rgEva.Items[i]["clnEvaDate"].Text.Trim());
                    cmd.Parameters.Add("@WnExpireDate", SqlDbType.Date).Value = this.txtDateExpire.SelectedDate.Value;
                    cmd.Parameters.Add("@WnType", SqlDbType.NVarChar, 1).Value = this.cbType.SelectedValue;
                    cmd.Parameters.Add("@WnCount", SqlDbType.Int).Value = this.numCount.Value;
                    cmd.Parameters.Add("@WnDetails", SqlDbType.NVarChar, 1000).Value = this.txtDetails.Text.Trim();
                    cmd.Parameters.Add("@WnAttachFile", SqlDbType.NVarChar, 100).Value = this.RadUpload1.UploadedFiles[0].GetName();
                    cmd.Parameters.Add("@CreateUser", SqlDbType.NVarChar, 50).Value = this.Session["LU"].ToString();

                    cmd.CommandText = NP_Cls.sqlInsert; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                    cmd.ExecuteNonQuery();
                    //}

                    //if (this.RadUpload1.UploadedFiles.Count > 0)
                    //{
                    //    File.Copy(Path.Combine(Server.MapPath(this.RadUpload1.TargetFolder), this.RadUpload1.UploadedFiles[0].GetName()), @"D:\ComPaq\Project\Web\HR_EmpProfile\img\EmpImg\" + this.txtEmpNameCode.Text.Trim() + this.RadUpload1.UploadedFiles[0].GetExtension(), true);
                    //    File.Delete(Path.Combine(Server.MapPath(this.RadUpload1.TargetFolder), this.RadUpload1.UploadedFiles[0].GetName()));
                    //}

                    TR.Commit();

                    DGV();
                    Clear(); this.dtpStartDate.Focus();
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
        }
        protected void btnReset_Click(object sender, ImageClickEventArgs e)
        {
            Clear(); this.dtpStartDate.Focus();
        }
        protected void rgWn_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.ToUpper() == "DELETE")
            {
                if (this.Session["WN"] != null)
                {

                    SqlConnection oConn = new SqlConnection(NP_Cls.strconn);
                    if (oConn.State == ConnectionState.Open) { oConn.Close(); }
                    oConn.Open();
                    try
                    {
                        SqlCommand cmd = new SqlCommand();
                        NP_Cls.sqlDelete = "[stp_ep_delete_Wn]";
                        cmd.Parameters.Add("@EmployeeID", SqlDbType.NVarChar, 50).Value = (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString();
                        cmd.Parameters.Add("@WnID", SqlDbType.Int).Value = Int32.Parse(this.rgWn.Items[e.Item.ItemIndex]["clnWnID"].Text.Trim());

                        cmd.CommandText = NP_Cls.sqlDelete; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure;
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        this.NotifyWarn.Text = "Delete :" + ex.Message; this.NotifyWarn.Show(); return;
                    }
                    DGV();
                    //(this.Session["WN"] as DataSet).Tables[0].Rows.RemoveAt(e.Item.ItemIndex);
                    //this.rgWn.DataSource = this.Session["WN"];
                    //this.rgWn.DataBind();
                }
            }
        }

        protected void dtpStartDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (this.dtpStartDate.SelectedDate != null)
            {
                this.txtDateExpire.SelectedDate = this.dtpStartDate.SelectedDate.Value.AddYears(1);
            }
        }
        protected void rgWn_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem DataItem = e.Item as GridDataItem;
                HyperLink hyAtt = (DataItem["clnWnAttachFile"].FindControl("HyperLink1") as HyperLink);
                Label lbl = (DataItem["clnWnAttachFile"].FindControl("WnAttachFileLabel") as Label);
                hyAtt.Text = lbl.Text.Trim(); hyAtt.NavigateUrl = "~/img/WarningPDF/" + lbl.Text.Trim(); hyAtt.Target = "_blank";

            }
        }

    }
}