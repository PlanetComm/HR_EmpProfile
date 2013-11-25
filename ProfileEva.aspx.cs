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
    public partial class ProfileEva : System.Web.UI.Page
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
                    this.Session["EV"] = NP.Execute("[stp_ep_inquiry_Eva] '" + this.Request.QueryString["E"].ToString() + "'", ref NP_Cls.strErr);
                }
            }
            else
            {
                this.Session["EV"] = NP.Execute("[stp_ep_inquiry_Eva] '" + (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString() + "'", ref NP_Cls.strErr);
            }

            this.rgEva.DataSource = this.Session["EV"];
            this.rgEva.DataBind();
        }
        private void Clear()
        {
            this.dtpEvaDate.Clear(); this.txtEvaType.Text = string.Empty; this.numPoint.Value = null;
            this.txtEvaGrade.Text = string.Empty; this.txtEvaRemark.Text = string.Empty;
        }

        protected void btnAdd_Click(object sender, ImageClickEventArgs e)
        {
            if (Page.IsValid)
            {

                if (this.Session["EV"] != null)
                {
                    //// Duplicate
                    //for (int i = 0; i < (this.Session["HE"] as DataSet).Tables[0].Rows.Count; i++)
                    //{
                    //    if (this.dtpHeaFrom.SelectedDate.Value.ToString("dd MMM yyyy", NP_Cls.cul).Contains(DateTime.Parse((this.Session["SL"] as DataSet).Tables[0].Rows[i]["HeaFrom"].ToString().Trim()).ToString("dd MMM yyyy", NP_Cls.cul)))
                    //    {
                    //        this.NotifyWarn.Text = "Already Add " + this.dtpSalaryStart.SelectedDate.Value.ToString("dd MMM yyyy") + " in list !!"; this.NotifyWarn.Show(); return;
                    //    }
                    //}

                    DataSet ds = new DataSet();
                    ds = this.Session["EV"] as DataSet;
                    DataRow dr; dr = ds.Tables[0].NewRow();

                    dr["EvaType"] = this.txtEvaType.Text.Trim();
                    dr["EvaDate"] = this.dtpEvaDate.SelectedDate.Value;
                    dr["EvaPoint"] = this.numPoint.Value; dr["EvaGrade"] = this.txtEvaGrade.Text.Trim(); dr["EvaRemark"] = this.txtEvaRemark.Text.Trim();

                    ds.Tables[0].Rows.Add(dr); ds.AcceptChanges();
                    this.Session["EV"] = ds;

                    ////Sort
                    //DataTable dt = new DataTable();
                    //dt = (this.Session["SL"] as DataSet).Tables[0].DefaultView.ToTable();
                    //dt.DefaultView.Sort = "SalStartDate DESC"; dt = dt.DefaultView.ToTable();
                    //(this.Session["SL"] as DataSet).Tables.Clear();
                    //(this.Session["SL"] as DataSet).Tables.Add(dt);

                    this.rgEva.DataSource = this.Session["EV"];
                    this.rgEva.DataBind();
                }
            }
        }
        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            if (this.rgEva.Items.Count == 0) { this.NotifyWarn.Text = "Data not found to Save !!"; this.NotifyWarn.Show(); return; }
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
                cmd.Parameters.Add("@LogTable", SqlDbType.NVarChar, 50).Value = "Evaluation";
                cmd.Parameters.Add("@LogUser", SqlDbType.NVarChar, 50).Value = this.Session["LU"].ToString();

                cmd.CommandText = NP_Cls.sqlDelete; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                cmd.ExecuteNonQuery();

                cmd.Parameters.Clear();

                NP_Cls.sqlDelete = "[stp_ep_delete_Eva]";
                cmd.Parameters.Add("@EmployeeID", SqlDbType.NVarChar, 50).Value = (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString();

                cmd.CommandText = NP_Cls.sqlDelete; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                cmd.ExecuteNonQuery();

                cmd.Parameters.Clear();

                for (int i = 0; i < this.rgEva.Items.Count; i++)
                {
                    cmd.Parameters.Clear();
                    NP_Cls.sqlInsert = "[stp_ep_insert_Eva]";
                    cmd.Parameters.Add("@EmployeeID", SqlDbType.NVarChar, 50).Value = (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString();
                    cmd.Parameters.Add("@EvaDate", SqlDbType.Date).Value = DateTime.Parse(this.rgEva.Items[i]["clnEvaDate"].Text.Trim());
                    cmd.Parameters.Add("@EvaType", SqlDbType.NVarChar, 100).Value = this.rgEva.Items[i]["clnEvaType"].Text.Trim();
                    cmd.Parameters.Add("@EvaPoint", SqlDbType.Decimal).Value = Double.Parse(this.rgEva.Items[i]["clnEvaPoint"].Text.Trim());
                    cmd.Parameters.Add("@EvaGrade", SqlDbType.NVarChar, 10).Value = this.rgEva.Items[i]["clnEvaGrade"].Text.Trim();
                    cmd.Parameters.Add("@EvaRemark", SqlDbType.NVarChar, 100).Value = this.rgEva.Items[i]["clnEvaRemark"].Text.Trim();
                    cmd.Parameters.Add("@CreateUser", SqlDbType.NVarChar, 50).Value = this.Session["LU"].ToString();

                    cmd.CommandText = NP_Cls.sqlInsert; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                    cmd.ExecuteNonQuery();
                }

                TR.Commit();

                DGV();
                Clear(); this.dtpEvaDate.Focus();
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
            Clear(); this.dtpEvaDate.Focus();
        }
        protected void rgEva_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.ToUpper() == "DELETE")
            {
                if (this.Session["EV"] != null)
                {
                    (this.Session["EV"] as DataSet).Tables[0].Rows.RemoveAt(e.Item.ItemIndex);
                    this.rgEva.DataSource = this.Session["EV"];
                    this.rgEva.DataBind();
                }
            }
        }
    }
}