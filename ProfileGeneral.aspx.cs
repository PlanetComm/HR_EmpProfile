using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;

namespace HR_EmpProfile
{
    public partial class ProfileGeneral : System.Web.UI.Page
    {
        NP_Cls NP = new NP_Cls();  SqlDateTime DBNull; 
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DGV(); this.txtGerLang.Focus();
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
                    this.Session["GE"] = NP.Execute("[stp_ep_inquiry_Gen] '" + this.Request.QueryString["E"].ToString() + "'", ref NP_Cls.strErr);
                }
            }
            else
            {
                this.Session["GE"] = NP.Execute("[stp_ep_inquiry_Gen] '" + (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString() + "'", ref NP_Cls.strErr);
            }

            this.rgGe.DataSource = (this.Session["GE"] as DataSet).Tables[0];
            this.rgGe.DataBind();

            DBNull = SqlDateTime.Null;

            if ((this.Session["GE"] as DataSet).Tables[0].Rows.Count > 0)
            {
                this.chkToeic.Checked = Convert.ToBoolean((this.Session["GE"] as DataSet).Tables[0].Rows[0]["IsToeic"].ToString());
                this.numToeic.Value = (string.IsNullOrEmpty((this.Session["GE"] as DataSet).Tables[0].Rows[0]["PointToeic"].ToString()) ? 0 : Convert.ToDouble((this.Session["GE"] as DataSet).Tables[0].Rows[0]["PointToeic"].ToString()));
                
                this.chkToelf.Checked = Convert.ToBoolean((this.Session["GE"] as DataSet).Tables[0].Rows[0]["IsToelf"].ToString());
                this.numToelf.Value = (string.IsNullOrEmpty((this.Session["GE"] as DataSet).Tables[0].Rows[0]["PointToelf"].ToString()) ? 0 : Convert.ToDouble((this.Session["GE"] as DataSet).Tables[0].Rows[0]["PointToelf"].ToString())); 
                
                this.chkIelts.Checked = Convert.ToBoolean((this.Session["GE"] as DataSet).Tables[0].Rows[0]["IsIelts"].ToString());
                this.numIelts.Value = (string.IsNullOrEmpty((this.Session["GE"] as DataSet).Tables[0].Rows[0]["PointIelts"].ToString()) ? 0 : Convert.ToDouble((this.Session["GE"] as DataSet).Tables[0].Rows[0]["PointIelts"].ToString()));

                this.chkCPA.Checked = Convert.ToBoolean((this.Session["GE"] as DataSet).Tables[0].Rows[0]["IsCPA"].ToString());
                this.txtCPANo.Text = (this.Session["GE"] as DataSet).Tables[0].Rows[0]["NoCPA"].ToString();

                if (!string.IsNullOrEmpty((this.Session["GE"] as DataSet).Tables[0].Rows[0]["ExpCPA"].ToString()))
                    this.dtpCPAExp.DbSelectedDate = Convert.ToDateTime((this.Session["GE"] as DataSet).Tables[0].Rows[0]["ExpCPA"].ToString());

                this.chkLPP.Checked = Convert.ToBoolean((this.Session["GE"] as DataSet).Tables[0].Rows[0]["IsLPP"].ToString());
                this.txtLPPNo.Text = (this.Session["GE"] as DataSet).Tables[0].Rows[0]["NoLPP"].ToString();

                if (!string.IsNullOrEmpty((this.Session["GE"] as DataSet).Tables[0].Rows[0]["ExpLPP"].ToString()))
                    this.dtpLPPExp.DbSelectedDate = Convert.ToDateTime((this.Session["GE"] as DataSet).Tables[0].Rows[0]["ExpLPP"].ToString());

                this.chkWP.Checked = Convert.ToBoolean((this.Session["GE"] as DataSet).Tables[0].Rows[0]["IsWP"].ToString());
                this.txtWPNo.Text = (this.Session["GE"] as DataSet).Tables[0].Rows[0]["NoWP"].ToString();

                if (!string.IsNullOrEmpty((this.Session["GE"] as DataSet).Tables[0].Rows[0]["ExpWP"].ToString()))
                    this.dtpWPExp.DbSelectedDate = Convert.ToDateTime((this.Session["GE"] as DataSet).Tables[0].Rows[0]["ExpWP"].ToString());
            }
        }
        private void Clear()
        {
            this.txtGerLang.Text = string.Empty; this.txtSpec.Text = string.Empty;
            this.ratSpeaking.Value = 0; this.ratReading.Value = 0; this.ratWriting.Value = 0; this.ratUnderstanding.Value = 0;
        }
        protected void btnAdd_Click(object sender, ImageClickEventArgs e)
        {
            if (Page.IsValid)
            {
                if (this.Session["GE"] != null)
                {
                    DataSet ds = new DataSet();
                    ds = this.Session["GE"] as DataSet;
                    DataRow dr; dr = ds.Tables[0].NewRow();
                    dr["GenForeLang"] = this.txtGerLang.Text.Trim();
                    dr["GenSpeaking"] = this.ratSpeaking.Value;
                    dr["GenReading"] = this.ratReading.Value;
                    dr["GenWriting"] = this.ratWriting.Value;
                    dr["GenUnderstanding"] = this.ratUnderstanding.Value;
                    dr["GenSpecialSkill"] = this.txtSpec.Text.Trim();

                    ds.Tables[0].Rows.Add(dr); ds.AcceptChanges();
                    this.Session["GE"] = ds;

                    Clear();

                    this.rgGe.DataSource = this.Session["GE"];
                    this.rgGe.DataBind();
                }

            }
        }

        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            if (this.rgGe.Items.Count == 0) { this.NotifyWarn.Text = "Data not found to Save !!"; this.NotifyWarn.Show(); return; }
            SqlConnection oConn = new SqlConnection(NP_Cls.strconn);
            if (oConn.State == ConnectionState.Open) { oConn.Close(); }
            oConn.Open();
            try
            {
                SqlCommand cmd = new SqlCommand();
                SqlTransaction TR;
                TR = oConn.BeginTransaction(); DBNull = SqlDateTime.Null;  

                NP_Cls.sqlDelete = "[stp_ep_log]";
                cmd.Parameters.Add("@LogName", SqlDbType.NVarChar, 50).Value = "DELETE";
                cmd.Parameters.Add("@LogKey", SqlDbType.NVarChar, 50).Value = (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString();
                cmd.Parameters.Add("@LogTable", SqlDbType.NVarChar, 50).Value = "GeneralInformation";
                cmd.Parameters.Add("@LogUser", SqlDbType.NVarChar, 50).Value = this.Session["LU"].ToString();

                cmd.CommandText = NP_Cls.sqlDelete; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                cmd.ExecuteNonQuery();

                cmd.Parameters.Clear();

                NP_Cls.sqlDelete = "[stp_ep_delete_Gen]";
                cmd.Parameters.Add("@EmployeeID", SqlDbType.NVarChar, 50).Value = (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString();

                cmd.CommandText = NP_Cls.sqlDelete; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                cmd.ExecuteNonQuery();

                cmd.Parameters.Clear();

                for (int i = 0; i < this.rgGe.Items.Count; i++)
                {
                    cmd.Parameters.Clear();
                    NP_Cls.sqlInsert = "[stp_ep_insert_Gen]";
                    cmd.Parameters.Add("@EmployeeID", SqlDbType.NVarChar, 50).Value = (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString();
                    cmd.Parameters.Add("@GenForeLang", SqlDbType.NVarChar, 50).Value = this.rgGe.Items[i]["clnGenForeLang"].Text.Trim();
                    cmd.Parameters.Add("@GenSpeaking", SqlDbType.Int).Value = int.Parse(this.rgGe.Items[i]["clnGenSpeaking"].Text.Trim());
                    cmd.Parameters.Add("@GenReading", SqlDbType.Int).Value = int.Parse(this.rgGe.Items[i]["clnGenReading"].Text.Trim());
                    cmd.Parameters.Add("@GenWriting", SqlDbType.Int).Value = int.Parse(this.rgGe.Items[i]["clnGenWriting"].Text.Trim());
                    cmd.Parameters.Add("@GenUnderstanding", SqlDbType.Int).Value = int.Parse(this.rgGe.Items[i]["clnGenUnderstanding"].Text.Trim());
                    cmd.Parameters.Add("@GenSpecialSkill", SqlDbType.NVarChar, 100).Value = this.rgGe.Items[i]["clnGenSpecialSkill"].Text.Trim();

                    cmd.Parameters.Add("@IsToeic", SqlDbType.Bit).Value = this.chkToeic.Checked;
                    cmd.Parameters.Add("@PointToeic", SqlDbType.Decimal).Value = (this.numToeic.Value == null ? 0 : this.numToeic.Value);

                    cmd.Parameters.Add("@IsToelf", SqlDbType.Bit).Value = this.chkToelf.Checked;
                    cmd.Parameters.Add("@PointToelf", SqlDbType.Decimal).Value = (this.numToelf.Value == null ? 0 : this.numToelf.Value);

                    cmd.Parameters.Add("@IsIelts", SqlDbType.Bit).Value = this.chkIelts.Checked;
                    cmd.Parameters.Add("@PointIelts", SqlDbType.Decimal).Value = (this.numIelts.Value == null ? 0 : this.numIelts.Value);

                    cmd.Parameters.Add("@IsCPA", SqlDbType.Bit).Value = this.chkCPA.Checked;
                    cmd.Parameters.Add("@NoCPA", SqlDbType.NVarChar, 100).Value = this.txtCPANo.Text.Trim();

                    if (this.dtpCPAExp.SelectedDate == null)
                        cmd.Parameters.Add("@ExpCPA", SqlDbType.Date).Value = DBNull;
                    else
                        cmd.Parameters.Add("@ExpCPA", SqlDbType.Date).Value = this.dtpCPAExp.SelectedDate.Value;

                    cmd.Parameters.Add("@IsLPP", SqlDbType.Bit).Value = this.chkLPP.Checked;
                    cmd.Parameters.Add("@NoLPP", SqlDbType.NVarChar, 100).Value = this.txtLPPNo.Text.Trim();

                    if (this.dtpLPPExp.SelectedDate == null)
                        cmd.Parameters.Add("@ExpLPP", SqlDbType.Date).Value = DBNull;
                    else
                        cmd.Parameters.Add("@ExpLPP", SqlDbType.Date).Value = this.dtpLPPExp.SelectedDate.Value;

                    cmd.Parameters.Add("@IsWP", SqlDbType.Bit).Value = this.chkWP.Checked;
                    cmd.Parameters.Add("@NoWP", SqlDbType.NVarChar, 100).Value = this.txtWPNo.Text.Trim();

                    if (this.dtpWPExp.SelectedDate == null)
                        cmd.Parameters.Add("@ExpWP", SqlDbType.Date).Value = DBNull;
                    else
                        cmd.Parameters.Add("@ExpWP", SqlDbType.Date).Value = this.dtpWPExp.SelectedDate.Value;


                    cmd.Parameters.Add("@CreateUser", SqlDbType.NVarChar, 50).Value = this.Session["LU"].ToString();

                    cmd.CommandText = NP_Cls.sqlInsert; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure; cmd.Transaction = TR;
                    cmd.ExecuteNonQuery();
                }

                TR.Commit();

                DGV();
                Clear(); this.txtGerLang.Focus();
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
            Clear(); this.txtGerLang.Focus();
        }
        protected void rgTr_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.ToUpper() == "DELETE")
            {
                if (this.Session["GE"] != null)
                {
                    (this.Session["GE"] as DataSet).Tables[0].Rows.RemoveAt(e.Item.ItemIndex);
                    this.rgGe.DataSource = this.Session["GE"];
                    this.rgGe.DataBind();
                }
            }
        }
    }
}