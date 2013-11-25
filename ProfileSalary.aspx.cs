using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Telerik.Web.UI;
using System.Drawing;

namespace HR_EmpProfile
{
    public partial class ProfileSalary : System.Web.UI.Page
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
                    this.Session["SL"] = NP.Execute("[stp_ep_inquiry_Sal] '" + this.Request.QueryString["E"].ToString() + "'", ref NP_Cls.strErr);
                }
            }
            else
            {
                this.Session["SL"] = NP.Execute("[stp_ep_inquiry_Sal] '" + (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString() + "'", ref NP_Cls.strErr);
            }

            this.rgSal.DataSource = this.Session["SL"];
            this.rgSal.DataBind();
        }
        private void Clear()
        {
            this.dtpSalaryStart.Clear();
            this.numSalary.Value = null;
        }

        protected void btnAdd_Click(object sender, ImageClickEventArgs e)
        {
            if (Page.IsValid)
            {

                if (this.Session["SL"] != null)
                {
                    // Duplicate
                    for (int i = 0; i < (this.Session["SL"] as DataSet).Tables[0].Rows.Count; i++)
                    {
                        if (this.dtpSalaryStart.SelectedDate.Value.ToString("dd MMM yyyy", NP_Cls.cul).Contains(DateTime.Parse((this.Session["SL"] as DataSet).Tables[0].Rows[i]["SalStartDate"].ToString().Trim()).ToString("dd MMM yyyy", NP_Cls.cul)))
                        {
                            this.NotifyWarn.Text = "Already Add " + this.dtpSalaryStart.SelectedDate.Value.ToString("dd MMM yyyy") + " in list !!"; this.NotifyWarn.Show(); return;
                        }
                    }

                    DataSet ds = new DataSet();
                    ds = this.Session["SL"] as DataSet;
                    DataRow dr; dr = ds.Tables[0].NewRow();
                    dr["SalStartDate"] = this.dtpSalaryStart.SelectedDate.Value;
                    dr["SalaryAmount"] = this.numSalary.Value;
                    dr["SalaryPercentage"] = (this.rgSal.Items.Count == 0 ? 100 : ((this.numSalary.Value - double.Parse(this.rgSal.Items[this.rgSal.Items.Count - 1]["clnSalaryAmount"].Text.Trim())) / double.Parse(this.rgSal.Items[this.rgSal.Items.Count - 1]["clnSalaryAmount"].Text.Trim())) * 100);
                    
                    ds.Tables[0].Rows.Add(dr); ds.AcceptChanges();
                    this.Session["SL"] = ds;

                    //Sort
                    DataTable dt = new DataTable();
                    dt = (this.Session["SL"] as DataSet).Tables[0].DefaultView.ToTable();
                    dt.DefaultView.Sort = "SalStartDate DESC"; dt = dt.DefaultView.ToTable();
                    (this.Session["SL"] as DataSet).Tables.Clear();
                    (this.Session["SL"] as DataSet).Tables.Add(dt);

                    this.rgSal.DataSource = this.Session["SL"];
                    this.rgSal.DataBind();
                }
            }
        }
        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            if (this.rgSal.Items.Count == 0) { this.NotifyWarn.Text = "Data not found to Save !!"; this.NotifyWarn.Show(); return; }
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
                cmd.Parameters.Add("@LogTable", SqlDbType.NVarChar, 50).Value = "Salary";
                cmd.Parameters.Add("@LogUser", SqlDbType.NVarChar, 50).Value = this.Session["LU"].ToString();

                cmd.CommandText = NP_Cls.sqlDelete; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                cmd.ExecuteNonQuery();

                cmd.Parameters.Clear();

                NP_Cls.sqlDelete = "[stp_ep_delete_Sal]";
                cmd.Parameters.Add("@EmployeeID", SqlDbType.NVarChar, 50).Value = (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString();

                cmd.CommandText = NP_Cls.sqlDelete; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                cmd.ExecuteNonQuery();

                cmd.Parameters.Clear();

                for (int i = 0; i < this.rgSal.Items.Count; i++)
                {
                    cmd.Parameters.Clear();
                    NP_Cls.sqlInsert = "[stp_ep_insert_Sal]";
                    cmd.Parameters.Add("@EmployeeID", SqlDbType.NVarChar, 50).Value = (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString();
                    cmd.Parameters.Add("@SalStartDate", SqlDbType.Date).Value = DateTime.Parse(this.rgSal.Items[i]["clnSalStartDate"].Text.Trim());
                    cmd.Parameters.Add("@SalaryAmount", SqlDbType.Decimal).Value = double.Parse(this.rgSal.Items[i]["clnSalaryAmount"].Text.Trim());
                    cmd.Parameters.Add("@SalaryPercentage", SqlDbType.Decimal).Value = double.Parse(this.rgSal.Items[i]["clnSalaryPercentage"].Text.Trim());
                    cmd.Parameters.Add("@CreateUser", SqlDbType.NVarChar, 50).Value = this.Session["LU"].ToString();

                    cmd.CommandText = NP_Cls.sqlInsert; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                    cmd.ExecuteNonQuery();
                }

                TR.Commit();

                DGV();
                Clear(); this.dtpSalaryStart.Focus();
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
            Clear(); this.dtpSalaryStart.Focus();
        }

        protected void rgSal_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.ToUpper() == "DELETE")
            {
                if (this.Session["SL"] != null)
                {
                    (this.Session["SL"] as DataSet).Tables[0].Rows.RemoveAt(e.Item.ItemIndex);
                    this.rgSal.DataSource = this.Session["SL"];
                    this.rgSal.DataBind();
                }
            }
        }

        protected void rgSal_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                dataItem["clnSalaryPercentage"].ForeColor = ColorTranslator.FromHtml("#FF8000"); 
            }
        }
    }
}