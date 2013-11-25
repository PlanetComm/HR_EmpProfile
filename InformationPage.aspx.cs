using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.IO;
using System.Data.SqlClient;
using System.Data;
using System.Web.Caching;

namespace HR_EmpProfile
{
    public partial class InformationPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.imgCorrect.Visible = false;
                Binding();
                Clear();
                this.dtpBirth.MinDate = DateTime.Now.AddYears(-80);
                this.imgProfile.ImageUrl = "img/EmpImg/NoPic.png";
                this.txtEmpNameCode.Focus();
            }
        }
        void Binding()
        {
            DataSet dsBind = new DataSet(); DataRow dr;
            NP_Cls.sqlSelect = "SELECT GenderID AS ID, GenderDesc AS [DESC] FROM ep_EmpGender";
            dsBind = NP.Execute(NP_Cls.sqlSelect, ref NP_Cls.strErr);
            dr = dsBind.Tables[0].NewRow(); dr[0] = 0; dr[1] = string.Empty;
            dsBind.Tables[0].Rows.InsertAt(dr,0);
            this.cbGender.DataSource = dsBind; this.cbGender.DataBind();

            dsBind = new DataSet();
            NP_Cls.sqlSelect = "SELECT NationalityID AS ID, NationalityDesc AS [DESC] FROM ep_EmpNationality";
            dsBind = NP.Execute(NP_Cls.sqlSelect, ref NP_Cls.strErr);
            dr = dsBind.Tables[0].NewRow(); dr[0] = 0; dr[1] = string.Empty;
            dsBind.Tables[0].Rows.InsertAt(dr, 0);
            this.cbNationalily.DataSource = dsBind; this.cbNationalily.DataBind();

            dsBind = new DataSet();
            NP_Cls.sqlSelect = "SELECT RaceID AS ID, RaceDesc AS [DESC] FROM ep_EmpRace";
            dsBind = NP.Execute(NP_Cls.sqlSelect, ref NP_Cls.strErr);
            dr = dsBind.Tables[0].NewRow(); dr[0] = 0; dr[1] = string.Empty;
            dsBind.Tables[0].Rows.InsertAt(dr, 0);
            this.cbRace.DataSource = dsBind; this.cbRace.DataBind();

            dsBind = new DataSet();
            NP_Cls.sqlSelect = "SELECT ReligionID AS ID, ReligionDesc AS [DESC] FROM ep_EmpReligion";
            dsBind = NP.Execute(NP_Cls.sqlSelect, ref NP_Cls.strErr);
            dr = dsBind.Tables[0].NewRow(); dr[0] = 0; dr[1] = string.Empty;
            dsBind.Tables[0].Rows.InsertAt(dr, 0);
            this.cbReligion.DataSource = dsBind; this.cbReligion.DataBind();
        }
        private CacheItemRemovedCallback callBack;
        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    CheckID();

                    SqlCommand cmd = new SqlCommand();
                    SqlConnection oConn = new SqlConnection(NP_Cls.strconn);
                    if (oConn.State == ConnectionState.Open) { oConn.Close(); }
                    oConn.Open();

                    switch (string.IsNullOrEmpty(this.lblID.Text.Trim()))
                    {
                        case true:

                            NP_Cls.sqlInsert = "[stp_ep_insert_Infor]";
                            cmd.Parameters.Add("@EmployeeID", SqlDbType.NVarChar, 50).Value = this.txtEmpNameCode.Text.Trim();
                            cmd.Parameters.Add("@FirstNameEN", SqlDbType.NVarChar, 50).Value = this.txtNameEng.Text.Trim();
                            cmd.Parameters.Add("@MidNameEN", SqlDbType.NVarChar, 10).Value = this.txtMidNameEng.Text.Trim();
                            cmd.Parameters.Add("@LastNameEN", SqlDbType.NVarChar, 50).Value = this.txtLastNameEng.Text.Trim();
                            cmd.Parameters.Add("@FirstNameTH", SqlDbType.NVarChar, 50).Value = this.txtNameThai.Text.Trim();
                            cmd.Parameters.Add("@MidNameTH", SqlDbType.NVarChar, 10).Value = this.txtMidNameThai.Text.Trim();
                            cmd.Parameters.Add("@LastNameTH", SqlDbType.NVarChar, 50).Value = this.txtLastNameThai.Text.Trim();
                            cmd.Parameters.Add("@NickNameEN", SqlDbType.NVarChar, 10).Value = this.txtNickNameEng.Text.Trim();
                            cmd.Parameters.Add("@NickNameTH", SqlDbType.NVarChar, 10).Value = this.txtNickNameThai.Text.Trim();
                            cmd.Parameters.Add("@DateOfBirth", SqlDbType.DateTime).Value = this.dtpBirth.SelectedDate.Value;
                            cmd.Parameters.Add("@EmpStatus", SqlDbType.NVarChar, 10).Value = "F";
                            cmd.Parameters.Add("@Gender", SqlDbType.Int).Value = this.cbGender.SelectedValue;
                            cmd.Parameters.Add("@Nationality", SqlDbType.Int).Value = this.cbNationalily.SelectedValue;
                            cmd.Parameters.Add("@Race", SqlDbType.Int).Value = this.cbRace.SelectedValue;
                            cmd.Parameters.Add("@Religion", SqlDbType.Int).Value = this.cbReligion.SelectedValue;
                            cmd.Parameters.Add("@ImagePath", SqlDbType.NVarChar, 255).Value = (this.RadUpload1.UploadedFiles.Count > 0 ? this.txtEmpNameCode.Text.Trim() + this.RadUpload1.UploadedFiles[0].GetExtension() : string.Empty);

                            cmd.CommandText = NP_Cls.sqlInsert; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure;
                            cmd.ExecuteNonQuery();


                            File.Copy(Path.Combine(Server.MapPath(this.RadUpload1.TargetFolder), this.RadUpload1.UploadedFiles[0].GetName()), @"D:\ComPaq\Project\Web\HR_EmpProfile\img\EmpImg\" + this.txtEmpNameCode.Text.Trim() + this.RadUpload1.UploadedFiles[0].GetExtension(), true);
                            File.Delete(Path.Combine(Server.MapPath(this.RadUpload1.TargetFolder), this.RadUpload1.UploadedFiles[0].GetName()));

                            //AddDeleteDependencyForFile(this.RadUpload1.UploadedFiles);

                            Clear(); this.txtEmpNameCode.Focus();
                            this.NotifyInfo.Text = "Save Completed !!"; this.NotifyInfo.Show();
                            break;
                        case false:
                            //    NP_Cls.sqlUpdate = "[sp_Category_Update]";
                            //    cmd.Parameters.Add("@CategoryCode", SqlDbType.NVarChar, 10).Value = this.txtCode.Text.Trim();
                            //    cmd.Parameters.Add("@CategoryName", SqlDbType.NVarChar, 100).Value = this.txtName.Text.Trim();
                            //    cmd.Parameters.Add("@UserCreate", SqlDbType.NVarChar, 10).Value = ((DataSet)Session["USER"]).Tables[0].Rows[0]["UserID"].ToString();

                            //    cmd.CommandText = NP_Cls.sqlUpdate; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure;
                            //    cmd.ExecuteNonQuery();

                            //    DGV(1); Clear(); this.txtCode.Enabled = true;
                            //    this.NotifyInfo.Text = "แก้ไขเรียบร้อย !!"; this.NotifyInfo.Show();
                            break;
                    }

                 
                }
            }
            catch (Exception ex)
            {
                this.NotifyWarn.Text = "Err : " + ex.Message; this.NotifyWarn.Show();
                return;
            }
        }

        private void AddDeleteDependencyForFile(UploadedFileCollection uploadedFileCollection)
        {
            foreach (UploadedFile uploadedFile in uploadedFileCollection)
            {
                TimeSpan timeOut = TimeSpan.FromMinutes(5);

                callBack = new CacheItemRemovedCallback(delegate(string key, object path, CacheItemRemovedReason reason)
                {
                    //File.Delete((string)path);
                });

                string fullPath = Path.Combine(Server.MapPath(RadUpload1.TargetFolder), uploadedFile.GetName());
                Context.Cache.Insert(uploadedFile.FileName, fullPath, null, DateTime.Now.Add(timeOut), TimeSpan.Zero,
                CacheItemPriority.Default, callBack);

                File.Copy(Path.Combine(Server.MapPath(RadUpload1.TargetFolder), uploadedFile.GetName()), Path.Combine(@"D:\ComPaq\Project\Web\HR_EmpProfile\img\EmpImg\", "NP_" + uploadedFile.GetName()), true);
                uploadedFile.GetExtension(); 

                //File.Delete(Path.Combine(Server.MapPath(Session["tarFolder"].ToString()), uploadedFile.GetName()));
            }
        }
        private void Clear()
        {
            this.txtEmpNameCode.Text = string.Empty;
            this.txtNameThai.Text = string.Empty; this.txtMidNameThai.Text = string.Empty; this.txtLastNameThai.Text = string.Empty;
            this.txtNameEng.Text = string.Empty; this.txtMidNameEng.Text = string.Empty; this.txtLastNameEng.Text = string.Empty;
            this.txtNickNameThai.Text = string.Empty; this.txtNickNameEng.Text = string.Empty; this.dtpBirth.Clear(); this.txtAge.Text = string.Empty;
            this.cbGender.SelectedIndex = -1; this.cbNationalily.SelectedIndex = -1; this.cbRace.SelectedIndex = -1; this.cbReligion.SelectedIndex = -1;
            this.RadUpload1.UploadedFiles.Clear(); this.imgCorrect.Visible = false; this.lblID.Text = string.Empty; this.imgProfile.ImageUrl = @"~\img\EmpImg\NoPic.png";
        }
        protected void dtpBirth_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (this.dtpBirth.SelectedDate != null)
            {
                this.txtAge.Text = (DateTime.Now.Subtract(this.dtpBirth.SelectedDate.Value).TotalDays / 365).ToString().Split('.')[0].ToString();
                this.cbGender.Focus();
            }
            else
            {
                this.txtAge.Text = string.Empty;
            }
        }
    
        NP_Cls NP = new NP_Cls();
        protected void btnCheck_Click(object sender, ImageClickEventArgs e)
        {
            CheckID();
        }

        private void CheckID()
        {
            if (!string.IsNullOrEmpty(this.txtEmpNameCode.Text.Trim()))
            {
                SqlCommand cmd = new SqlCommand(); SqlDataAdapter da; DataSet ds = new DataSet();
                SqlConnection oConn = new SqlConnection(NP_Cls.strconn);
                if (oConn.State == ConnectionState.Open) { oConn.Close(); }
                oConn.Open();
                try
                {
                    NP_Cls.sqlSelect = "[stp_ep_check_InFor]";
                    cmd.Parameters.Add("@EmpID", SqlDbType.NVarChar, 50).Value = this.txtEmpNameCode.Text.Trim();
                    cmd.Parameters.Add("@Result", SqlDbType.NVarChar, 100).Direction = ParameterDirection.Output;

                    cmd.CommandText = NP_Cls.sqlSelect; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure;
                    da = new SqlDataAdapter(cmd); da.Fill(ds);

                    string strResult = cmd.Parameters["@Result"].Value.ToString();
                    if (string.IsNullOrEmpty(strResult.Trim()))
                    {
                        this.imgCorrect.Visible = true;
                        this.txtNameThai.Text = string.Empty; this.txtMidNameThai.Text = string.Empty; this.txtLastNameThai.Text = string.Empty;
                        this.txtNameEng.Text = string.Empty; this.txtMidNameEng.Text = string.Empty; this.txtLastNameEng.Text = string.Empty;
                        this.txtNickNameThai.Text = string.Empty; this.txtNickNameEng.Text = string.Empty; this.dtpBirth.Clear(); this.txtAge.Text = string.Empty;
                        this.cbGender.SelectedIndex = -1; this.cbNationalily.SelectedIndex = -1; this.cbRace.SelectedIndex = -1; this.cbReligion.SelectedIndex = -1;
                        this.RadUpload1.UploadedFiles.Clear(); this.imgProfile.ImageUrl = @"~\img\EmpImg\NoPic.png"; this.lblID.Text = string.Empty;
                        this.txtNameThai.Focus();
                    }
                    else
                    {
                        this.imgProfile.ImageUrl = @"~\img\EmpImg\" + ds.Tables[0].Rows[0]["ImagePath"].ToString();
                        this.txtNameThai.Text = ds.Tables[0].Rows[0]["FirstNameTH"].ToString();
                        this.txtMidNameThai.Text = ds.Tables[0].Rows[0]["MidNameTH"].ToString();
                        this.txtLastNameThai.Text = ds.Tables[0].Rows[0]["LastNameTH"].ToString();

                        this.txtNameEng.Text = ds.Tables[0].Rows[0]["FirstNameEN"].ToString();
                        this.txtMidNameEng.Text = ds.Tables[0].Rows[0]["MidNameEN"].ToString();
                        this.txtLastNameEng.Text = ds.Tables[0].Rows[0]["LastNameEN"].ToString();

                        this.txtNickNameThai.Text = ds.Tables[0].Rows[0]["NickNameTH"].ToString();
                        this.txtNickNameEng.Text = ds.Tables[0].Rows[0]["NickNameEN"].ToString();

                        this.dtpBirth.SelectedDate = DateTime.Parse(ds.Tables[0].Rows[0]["DateOfBirth"].ToString());
                        this.txtAge.Text = (DateTime.Now.Subtract(this.dtpBirth.SelectedDate.Value).TotalDays / 365).ToString().Split('.')[0].ToString();

                        this.cbGender.SelectedValue = ds.Tables[0].Rows[0]["Gender"].ToString();
                        this.cbNationalily.SelectedValue = ds.Tables[0].Rows[0]["Nationality"].ToString();
                        this.cbRace.SelectedValue = ds.Tables[0].Rows[0]["Race"].ToString();
                        this.cbReligion.SelectedValue = ds.Tables[0].Rows[0]["Religion"].ToString();

                        this.imgCorrect.Visible = false; this.lblID.Text = this.txtEmpNameCode.Text.Trim();
                        this.NotifyWarn.Text = "<b>Duplicate !!</b><br>Khun " + strResult.Trim(); this.NotifyWarn.Show();
                        this.txtEmpNameCode.SelectionOnFocus = SelectionOnFocus.SelectAll;
                        this.txtEmpNameCode.Focus();
                        return;
                    }
                }
                catch (Exception ex)
                {
                    this.imgCorrect.Visible = false;
                    this.NotifyWarn.Text = "Check : " + ex.Message; this.NotifyWarn.Show(); return;
                }
            }
            else
            {
                this.imgCorrect.Visible = false;
                this.NotifyWarn.Text = "Please entry Employee Code !"; this.NotifyWarn.Show();
                this.txtEmpNameCode.Focus();
                return;
            }
        }
        protected void txtEmpNameCode_TextChanged(object sender, EventArgs e)
        {
            CheckID();
        }
       
    }
}