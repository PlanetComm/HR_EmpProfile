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
    public partial class ProfileEducation : System.Web.UI.Page
    {
        NP_Cls NP = new NP_Cls();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DGV();

                DataSet dsBind = new DataSet();
                DataRow dr;
                NP_Cls.sqlSelect = "SELECT CAST(EduLevelID AS varchar) + ':' + CAST(EduSort AS varchar) AS ID, EduLevelDesc AS [DESC] FROM ep_EduLevel Order By EduSort ";
                dsBind = NP.Execute(NP_Cls.sqlSelect, ref NP_Cls.strErr);
                dr = dsBind.Tables[0].NewRow(); dr[0] = 0; dr[1] = string.Empty;
                dsBind.Tables[0].Rows.InsertAt(dr, 0);
                this.cbEduLevel.DataSource = dsBind; this.cbEduLevel.DataBind();
            }
        }
        private DataSet GridEducation()
        {
            DataSet ds = new DataSet();
            ds.Tables.Add();
            ds.Tables[0].Columns.Add(new DataColumn("EduLevelDesc", typeof(System.String)));
            ds.Tables[0].Columns.Add(new DataColumn("EduName", typeof(System.String)));
            ds.Tables[0].Columns.Add(new DataColumn("EduFrom", typeof(System.DateTime)));
            ds.Tables[0].Columns.Add(new DataColumn("EduTo", typeof(System.DateTime)));
            ds.Tables[0].Columns.Add(new DataColumn("EduDegree", typeof(System.String)));
            ds.Tables[0].Columns.Add(new DataColumn("EduMajor", typeof(System.String)));
            ds.Tables[0].Columns.Add(new DataColumn("EduSort", typeof(System.Double)));
            ds.Tables[0].Columns.Add(new DataColumn("EduLevelID", typeof(System.Int16)));
            ds.AcceptChanges();

            return ds;
        }
        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            if (this.rgEdu.Items.Count == 0) { this.NotifyWarn.Text = "Data not found to Save !!"; this.NotifyWarn.Show(); return; }
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
                cmd.Parameters.Add("@LogTable", SqlDbType.NVarChar, 50).Value = "Education";
                cmd.Parameters.Add("@LogUser", SqlDbType.NVarChar, 50).Value = this.Session["LU"].ToString();

                cmd.CommandText = NP_Cls.sqlDelete; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                cmd.ExecuteNonQuery();

                cmd.Parameters.Clear();

                NP_Cls.sqlDelete = "[stp_ep_delete_Edu]";
                cmd.Parameters.Add("@EmployeeID", SqlDbType.NVarChar, 50).Value = (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString();

                cmd.CommandText = NP_Cls.sqlDelete; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                cmd.ExecuteNonQuery();

                cmd.Parameters.Clear();

                for (int i = 0; i < this.rgEdu.Items.Count; i++)
                {
                    cmd.Parameters.Clear();
                    NP_Cls.sqlInsert = "[stp_ep_insert_Edu]";
                    cmd.Parameters.Add("@EmployeeID", SqlDbType.NVarChar, 50).Value = (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString();
                    cmd.Parameters.Add("@EduLevelID", SqlDbType.Int).Value = int.Parse(this.rgEdu.Items[i]["clnEduLevelID"].Text.Trim());
                    cmd.Parameters.Add("@EduName", SqlDbType.NVarChar, 100).Value = this.rgEdu.Items[i]["clnEduName"].Text.Trim();
                    cmd.Parameters.Add("@EduFrom", SqlDbType.Date).Value = DateTime.Parse(this.rgEdu.Items[i]["clnEduFrom"].Text.Trim());
                    cmd.Parameters.Add("@EduTo", SqlDbType.Date).Value = DateTime.Parse(this.rgEdu.Items[i]["clnEduTo"].Text.Trim());
                    cmd.Parameters.Add("@EduDegree", SqlDbType.NVarChar, 100).Value = this.rgEdu.Items[i]["clnEduDegree"].Text.Trim();
                    cmd.Parameters.Add("@EduMajor", SqlDbType.NVarChar, 100).Value = this.rgEdu.Items[i]["clnEduMajor"].Text.Trim();
                    cmd.Parameters.Add("@CreateUser", SqlDbType.NVarChar, 50).Value = this.Session["LU"].ToString();

                    cmd.CommandText = NP_Cls.sqlInsert; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                    cmd.ExecuteNonQuery();
                }

                TR.Commit();

                DGV();
                Clear(); this.cbEduLevel.Focus();
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
                    this.Session["DS"] = NP.Execute("[stp_ep_inquiry_Edu] '" + this.Request.QueryString["E"].ToString() + "'", ref NP_Cls.strErr);
                }
            }
            else
            {
                this.Session["DS"] = NP.Execute("[stp_ep_inquiry_Edu] '" + (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString() + "'", ref NP_Cls.strErr);
            }
            
            this.rgEdu.DataSource = this.Session["DS"];
            this.rgEdu.DataBind();
        }
        private void Clear()
        {
            this.cbEduLevel.SelectedIndex = -1; this.txtEduName.Text = string.Empty;
            this.dtpEduFrom.Clear(); this.dtpEduTo.Clear();
            this.txtEduDegree.Text = string.Empty; this.txtEduMajor.Text =string.Empty;
        }

        protected void rgEdu_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.ToUpper() == "DELETE")
            {
                if (this.Session["DS"] != null)
                {
                    (this.Session["DS"] as DataSet).Tables[0].Rows.RemoveAt(e.Item.ItemIndex);
                    this.rgEdu.DataSource = this.Session["DS"];
                    this.rgEdu.DataBind();
                }
            }
        }
        protected void btnAdd_Click(object sender, ImageClickEventArgs e)
        {
            if (Page.IsValid)
            {
                
                if (this.Session["DS"] != null)
                {
                    // Duplicate
                    for (int i = 0; i < (this.Session["DS"] as DataSet).Tables[0].Rows.Count; i++)
                    {
                        if (this.cbEduLevel.Text.Trim().Contains((this.Session["DS"] as DataSet).Tables[0].Rows[i]["EduLevelDesc"].ToString().Trim()))
                        {
                            this.NotifyWarn.Text = "Already Add " + this.cbEduLevel.Text.Trim() + " in list !!"; this.NotifyWarn.Show(); return;
                        }
                    }

                    DataSet ds = new DataSet();
                    ds = this.Session["DS"] as DataSet;
                    DataRow dr; dr = ds.Tables[0].NewRow();
                    dr["EduLevelDesc"] = this.cbEduLevel.Text.Trim(); dr["EduName"] = this.txtEduName.Text.Trim();
                    dr["EduFrom"] = this.dtpEduFrom.SelectedDate.Value; dr["EduTo"] = this.dtpEduTo.SelectedDate.Value;
                    dr["EduDegree"] = this.txtEduDegree.Text.Trim(); dr["EduMajor"] = this.txtEduMajor.Text.Trim(); 
                    dr["EduSort"] = double.Parse(this.cbEduLevel.SelectedValue.ToString().Trim().Split(':')[1]);
                    dr["EduLevelID"] = int.Parse(this.cbEduLevel.SelectedValue.ToString().Trim().Split(':')[0]);
                    ds.Tables[0].Rows.Add(dr); ds.AcceptChanges();
                    this.Session["DS"] = ds;

                    DataTable dt = new DataTable();
                    dt = (this.Session["DS"] as DataSet).Tables[0].DefaultView.ToTable();
                    dt.DefaultView.Sort = "EduSort ASC"; dt = dt.DefaultView.ToTable();
                    (this.Session["DS"] as DataSet).Tables.Clear();
                    (this.Session["DS"] as DataSet).Tables.Add(dt);

                    this.rgEdu.DataSource = this.Session["DS"];
                    this.rgEdu.DataBind();
                }
            }
        }

        protected void btnReset_Click(object sender, ImageClickEventArgs e)
        {
            Clear(); this.cbEduLevel.Focus();
        }
    }
}