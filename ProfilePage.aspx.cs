using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Web.Caching;

namespace HR_EmpProfile
{
    public partial class ProfilePage : System.Web.UI.Page
    {
        NP_Cls NP = new NP_Cls(); SqlDateTime dNull = SqlDateTime.Null;
        private void Clear()
        {
            this.txtEmpNameCode.Text = string.Empty;
            this.txtNameThai.Text = string.Empty; this.txtMidNameThai.Text = string.Empty; this.txtLastNameThai.Text = string.Empty;
            this.txtNameEng.Text = string.Empty; this.txtMidNameEng.Text = string.Empty; this.txtLastNameEng.Text = string.Empty;

            this.txtID.Text = string.Empty; this.dtpDateIssued.Clear(); this.txtIssueAt.Text = string.Empty;
            this.txtTaxPayerID.Text = string.Empty; this.txtSocialSecNo.Text = string.Empty;

            this.txtNickNameThai.Text = string.Empty; this.txtNickNameEng.Text = string.Empty; this.dtpBirth.Clear(); this.txtAge.Text = string.Empty;
            this.cbGender.SelectedIndex = -1; this.cbNationalily.SelectedIndex = -1; this.cbRace.SelectedIndex = -1; this.cbReligion.SelectedIndex = -1;

            this.cbMarital.SelectedIndex = -1; this.txtChildren.Value = null; this.txtPresentAddress.Text = string.Empty; this.txtPermanentAddress.Text = string.Empty;
            this.txtEmail.Text = string.Empty; this.txtTel.Text = string.Empty; this.lblIImagePath.Text = string.Empty;

            this.dtpDateExpire.Clear(); this.txtPosition.Text = string.Empty; this.txtPCAEmail.Text = string.Empty; this.txtPCAExt.Text = string.Empty;

            this.RadUpload1.UploadedFiles.Clear(); this.imgCorrect.Visible = false; this.lblID.Text = string.Empty; this.imgProfile.ImageUrl = @"~\img\EmpImg\NoPic.png"; Session["PIC"] = "img/EmpImg/NoPic.png"; 
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.imgCorrect.Visible = false;
                Binding();
                Clear();
                this.dtpBirth.MinDate = DateTime.Now.AddYears(-80);
                this.imgProfile.ImageUrl = "img/EmpImg/NoPic.png";
                Session["PIC"] = "img/EmpImg/NoPic.png";
                this.txtEmpNameCode.Focus();

                if (Request.QueryString["E"] != null)
                {
                    CheckID();
                    this.btnInq.Visible = false;
                }
                else
                {
                    this.btnInq.Visible = true;
                }

                // Education
                //this.rgEdu.DataSource = GridEducation();
                //this.rgEdu.DataBind();
            }
        }
        void Binding()
        {
            DataSet dsBind = new DataSet(); DataRow dr;
            NP_Cls.sqlSelect = "SELECT GenderID AS ID, GenderDesc AS [DESC] FROM ep_EmpGender";
            dsBind = NP.Execute(NP_Cls.sqlSelect, ref NP_Cls.strErr);
            dr = dsBind.Tables[0].NewRow(); dr[0] = 0; dr[1] = string.Empty;
            dsBind.Tables[0].Rows.InsertAt(dr, 0);
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

            dsBind = new DataSet();
            NP_Cls.sqlSelect = "SELECT MaritalID AS ID, MaritalDesc AS [DESC] FROM ep_EmpMarital";
            dsBind = NP.Execute(NP_Cls.sqlSelect, ref NP_Cls.strErr);
            dr = dsBind.Tables[0].NewRow(); dr[0] = 0; dr[1] = string.Empty;
            dsBind.Tables[0].Rows.InsertAt(dr, 0);
            this.cbMarital.DataSource = dsBind; this.cbMarital.DataBind();
        }
        private CacheItemRemovedCallback callBack;
        protected void RadUpload1_FileExists(object sender, Telerik.Web.UI.Upload.UploadedFileEventArgs e)
        {
            int counter = 1; Session["Q"] = string.Empty;
            UploadedFile file = e.UploadedFile;

            string targetFolder = Server.MapPath(Session["tarFolder"].ToString());
            string targetFileName = Path.Combine(targetFolder,
                file.GetNameWithoutExtension() + counter.ToString() + file.GetExtension());

            while (System.IO.File.Exists(targetFileName))
            {
                counter++;
                targetFileName = Path.Combine(targetFolder,
                    file.GetNameWithoutExtension() + counter.ToString() + file.GetExtension());
            }
            //Session["FName"] = file.GetNameWithoutExtension() + counter.ToString() + file.GetExtension();
            file.SaveAs(targetFileName);
        }

        private void CheckID()
        {
            if ((!string.IsNullOrEmpty(this.txtEmpNameCode.Text.Trim())) || (Request.QueryString["E"] != null)) 
            {
                SqlCommand cmd = new SqlCommand(); SqlDataAdapter da; DataSet ds = new DataSet();
                SqlConnection oConn = new SqlConnection(NP_Cls.strconn);
                if (oConn.State == ConnectionState.Open) { oConn.Close(); }
                oConn.Open();
                try
                {
                    NP_Cls.sqlSelect = "[stp_ep_check_InFor]";
                    cmd.Parameters.Add("@EmpID", SqlDbType.NVarChar, 50).Value = (Request.QueryString["E"] == null ? this.txtEmpNameCode.Text.Trim() : Request.QueryString["E"].ToString());
                    cmd.Parameters.Add("@Result", SqlDbType.NVarChar, 100).Direction = ParameterDirection.Output;

                    cmd.CommandText = NP_Cls.sqlSelect; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure;
                    da = new SqlDataAdapter(cmd); da.Fill(ds);

                    string strResult = cmd.Parameters["@Result"].Value.ToString();
                    if (string.IsNullOrEmpty(strResult.Trim()))
                    {
                        this.imgCorrect.Visible = true;

                        this.txtNameThai.Text = string.Empty; this.txtMidNameThai.Text = string.Empty; this.txtLastNameThai.Text = string.Empty;
                        this.txtNameEng.Text = string.Empty; this.txtMidNameEng.Text = string.Empty; this.txtLastNameEng.Text = string.Empty;

                        this.txtID.Text = string.Empty; this.dtpDateIssued.Clear(); this.txtIssueAt.Text = string.Empty;
                        this.txtTaxPayerID.Text = string.Empty; this.txtSocialSecNo.Text = string.Empty;

                        this.txtNickNameThai.Text = string.Empty; this.txtNickNameEng.Text = string.Empty; this.dtpBirth.Clear(); this.txtAge.Text = string.Empty;
                        this.cbGender.SelectedIndex = -1; this.cbNationalily.SelectedIndex = -1; this.cbRace.SelectedIndex = -1; this.cbReligion.SelectedIndex = -1;

                        this.cbMarital.SelectedIndex = -1; this.txtChildren.Value = null; this.txtPresentAddress.Text = string.Empty; this.txtPermanentAddress.Text = string.Empty;
                        this.txtEmail.Text = string.Empty; this.txtTel.Text = string.Empty;

                        this.dtpDateExpire.Clear(); this.txtPosition.Text = string.Empty; this.txtPCAEmail.Text = string.Empty; this.txtPCAExt.Text = string.Empty; 

                        this.RadUpload1.UploadedFiles.Clear(); this.imgCorrect.Visible = false; this.lblID.Text = string.Empty; this.imgProfile.ImageUrl = @"~\img\EmpImg\NoPic.png";
                        Session["PIC"] = "img/EmpImg/NoPic.png";
                        this.txtNameThai.Focus();
                    }
                    else
                    {
                        if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["ImagePath"].ToString().Trim()))
                        {
                            this.imgProfile.ImageUrl = @"~\img\EmpImg\" + ds.Tables[0].Rows[0]["ImagePath"].ToString();
                            Session["PIC"] = "img/EmpImg/" + ds.Tables[0].Rows[0]["ImagePath"].ToString();
                        }
                        else
                        {
                            this.imgProfile.ImageUrl = @"~\img\EmpImg\NoPic.png"; Session["PIC"] = "img/EmpImg/NoPic.png";
                        }
                        this.txtEmpNameCode.Text = ds.Tables[0].Rows[0]["EmployeeID"].ToString();
                        this.txtNameThai.Text = ds.Tables[0].Rows[0]["FirstNameTH"].ToString();
                        this.txtMidNameThai.Text = ds.Tables[0].Rows[0]["MidNameTH"].ToString();
                        this.txtLastNameThai.Text = ds.Tables[0].Rows[0]["LastNameTH"].ToString();

                        this.txtNameEng.Text = ds.Tables[0].Rows[0]["FirstNameEN"].ToString();
                        this.txtMidNameEng.Text = ds.Tables[0].Rows[0]["MidNameEN"].ToString();
                        this.txtLastNameEng.Text = ds.Tables[0].Rows[0]["LastNameEN"].ToString();
                        this.txtNickNameThai.Text = ds.Tables[0].Rows[0]["NickNameTH"].ToString();
                        this.txtNickNameEng.Text = ds.Tables[0].Rows[0]["NickNameEN"].ToString();

                        this.dtpDateExpire.SelectedDate = Convert.ToDateTime(ds.Tables[0].Rows[0]["DateExpire"].ToString());
                        this.txtPosition.Text = ds.Tables[0].Rows[0]["PCAPosition"].ToString();
                        this.txtPCAEmail.Text = ds.Tables[0].Rows[0]["PCAEmail"].ToString();
                        this.txtPCAExt.Text = ds.Tables[0].Rows[0]["PCAExt"].ToString();

                        this.txtID.Text = ds.Tables[0].Rows[0]["IDCardNo"].ToString();
                        this.dtpDateIssued.SelectedDate = Convert.ToDateTime(ds.Tables[0].Rows[0]["DateIssued"].ToString());
                        this.txtIssueAt.Text = ds.Tables[0].Rows[0]["IssueAt"].ToString();
                        this.txtTaxPayerID.Text = ds.Tables[0].Rows[0]["TaxPayerIDNo"].ToString();
                        this.txtSocialSecNo.Text = ds.Tables[0].Rows[0]["SocialSecurityNo"].ToString();

                        if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["DateOfBirth"].ToString().Trim()))
                        {
                            this.dtpBirth.SelectedDate = DateTime.Parse(ds.Tables[0].Rows[0]["DateOfBirth"].ToString());
                            this.txtAge.Text = (DateTime.Now.Subtract(this.dtpBirth.SelectedDate.Value).TotalDays / 365).ToString().Split('.')[0].ToString();
                        }
                        else
                        {
                            this.txtAge.Text = string.Empty;
                            this.dtpBirth.MinDate = DateTime.Now.AddYears(-80);
                            this.dtpBirth.Clear();
                        }
                        

                        this.cbGender.SelectedValue = ds.Tables[0].Rows[0]["Gender"].ToString();
                        this.cbNationalily.SelectedValue = ds.Tables[0].Rows[0]["Nationality"].ToString();
                        this.cbRace.SelectedValue = ds.Tables[0].Rows[0]["Race"].ToString();
                        this.cbReligion.SelectedValue = ds.Tables[0].Rows[0]["Religion"].ToString();

                        this.cbMarital.SelectedValue = ds.Tables[0].Rows[0]["MaritalStatus"].ToString();
                        this.txtChildren.Value = (string.IsNullOrEmpty(ds.Tables[0].Rows[0]["NumberChild"].ToString().Trim()) ? 0 :  int.Parse(ds.Tables[0].Rows[0]["NumberChild"].ToString()));
                        this.txtPresentAddress.Text = ds.Tables[0].Rows[0]["PresentAddress"].ToString();
                        this.txtPermanentAddress.Text = ds.Tables[0].Rows[0]["PermanentAddress"].ToString();
                        this.txtEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                        this.txtTel.Text = ds.Tables[0].Rows[0]["Tel"].ToString();

                        this.imgCorrect.Visible = false; this.lblID.Text = this.txtEmpNameCode.Text.Trim(); this.lblIImagePath.Text = ds.Tables[0].Rows[0]["ImagePath"].ToString();
                        //this.NotifyWarn.Text = "<b>Duplicate !!</b><br>Khun " + strResult.Trim(); this.NotifyWarn.Show();
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
        protected void btnCheck_Click(object sender, ImageClickEventArgs e)
        {
            CheckID();
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

        private DataSet GridEducation()
        {
            DataSet ds = new DataSet();
            ds.Tables.Add();
            ds.Tables[0].Columns.Add(new DataColumn("EduLevel", typeof(System.String)));
            ds.Tables[0].Columns.Add(new DataColumn("EduName", typeof(System.String)));
            ds.Tables[0].Columns.Add(new DataColumn("EduFrom", typeof(System.DateTime)));
            ds.Tables[0].Columns.Add(new DataColumn("EduTo", typeof(System.DateTime)));
            ds.Tables[0].Columns.Add(new DataColumn("EduDegree", typeof(System.String)));
            ds.Tables[0].Columns.Add(new DataColumn("EduMojor", typeof(System.String)));
            ds.AcceptChanges();

            return ds;
        }
        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    SqlCommand cmd = new SqlCommand();
                    SqlConnection oConn = new SqlConnection(NP_Cls.strconn);
                    if (oConn.State == ConnectionState.Open) { oConn.Close(); }
                    oConn.Open();

                    switch (string.IsNullOrEmpty(this.lblID.Text.Trim()))
                    {
                        case true:

                            NP_Cls.sqlInsert = "[stp_ep_insert_InFor]";
                            cmd.Parameters.Add("@EmployeeID", SqlDbType.NVarChar, 50).Value = this.txtEmpNameCode.Text.Trim();
                            cmd.Parameters.Add("@FirstNameEN", SqlDbType.NVarChar, 50).Value = this.txtNameEng.Text.Trim();
                            cmd.Parameters.Add("@MidNameEN", SqlDbType.NVarChar, 10).Value = this.txtMidNameEng.Text.Trim();
                            cmd.Parameters.Add("@LastNameEN", SqlDbType.NVarChar, 50).Value = this.txtLastNameEng.Text.Trim();
                            cmd.Parameters.Add("@FirstNameTH", SqlDbType.NVarChar, 50).Value = this.txtNameThai.Text.Trim();
                            cmd.Parameters.Add("@MidNameTH", SqlDbType.NVarChar, 10).Value = this.txtMidNameThai.Text.Trim();
                            cmd.Parameters.Add("@LastNameTH", SqlDbType.NVarChar, 50).Value = this.txtLastNameThai.Text.Trim();
                            cmd.Parameters.Add("@NickNameEN", SqlDbType.NVarChar, 10).Value = this.txtNickNameEng.Text.Trim();
                            cmd.Parameters.Add("@NickNameTH", SqlDbType.NVarChar, 10).Value = this.txtNickNameThai.Text.Trim();

                            cmd.Parameters.Add("@IDCardNo", SqlDbType.NVarChar, 13).Value = this.txtID.Text.Trim();
                            cmd.Parameters.Add("@DateIssued", SqlDbType.Date).Value = this.dtpDateIssued.SelectedDate.Value;
                            cmd.Parameters.Add("@IssueAt", SqlDbType.NVarChar, 50).Value = this.txtIssueAt.Text.Trim();
                            cmd.Parameters.Add("@TaxPayerIDNo", SqlDbType.NVarChar, 50).Value = this.txtTaxPayerID.Text.Trim();
                            cmd.Parameters.Add("@SocialSecurityNo", SqlDbType.NVarChar, 50).Value = this.txtSocialSecNo.Text.Trim();

                            cmd.Parameters.Add("@DateExpire", SqlDbType.Date).Value = this.dtpDateExpire.SelectedDate.Value;
                            cmd.Parameters.Add("@PCAPosition", SqlDbType.NVarChar, 50).Value = this.txtPosition.Text.Trim();
                            cmd.Parameters.Add("@PCAEmail", SqlDbType.NVarChar, 50).Value = this.txtPCAEmail.Text.Trim();
                            cmd.Parameters.Add("@PCAExt", SqlDbType.NVarChar, 20).Value = this.txtPCAExt.Text.Trim();

                            cmd.Parameters.Add("@DateOfBirth", SqlDbType.DateTime).Value = (this.dtpBirth.SelectedDate == null ? dNull : this.dtpBirth.SelectedDate.Value);
                            cmd.Parameters.Add("@EmpStatus", SqlDbType.NVarChar, 10).Value = "A";
                            cmd.Parameters.Add("@Gender", SqlDbType.Int).Value = this.cbGender.SelectedValue;
                            cmd.Parameters.Add("@Nationality", SqlDbType.Int).Value = this.cbNationalily.SelectedValue;
                            cmd.Parameters.Add("@Race", SqlDbType.Int).Value = this.cbRace.SelectedValue;
                            cmd.Parameters.Add("@Religion", SqlDbType.Int).Value = this.cbReligion.SelectedValue;

                            cmd.Parameters.Add("@MaritalStatus", SqlDbType.Int).Value = this.cbMarital.SelectedValue;
                            cmd.Parameters.Add("@NumberChild", SqlDbType.Int).Value = (this.txtChildren.Value == null ? 0 : this.txtChildren.Value);
                            cmd.Parameters.Add("@PresentAddress", SqlDbType.NVarChar, 100).Value = this.txtPresentAddress.Text.Trim();
                            cmd.Parameters.Add("@PermanentAddress", SqlDbType.NVarChar, 100).Value = this.txtPermanentAddress.Text.Trim();
                            cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 50).Value = this.txtEmail.Text.Trim();
                            cmd.Parameters.Add("@Tel", SqlDbType.NVarChar, 20).Value = this.txtTel.Text.Trim();

                            cmd.Parameters.Add("@ImagePath", SqlDbType.NVarChar, 255).Value = (this.RadUpload1.UploadedFiles.Count > 0 ? this.txtEmpNameCode.Text.Trim() + this.RadUpload1.UploadedFiles[0].GetExtension() : string.Empty);

                            cmd.CommandText = NP_Cls.sqlInsert; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure;
                            cmd.ExecuteNonQuery();

                            if (this.RadUpload1.UploadedFiles.Count > 0)
                            {
                                File.Copy(Path.Combine(Server.MapPath(this.RadUpload1.TargetFolder), this.RadUpload1.UploadedFiles[0].GetName()), Path.Combine(Server.MapPath(this.RadUpload1.TargetFolder), this.txtEmpNameCode.Text.Trim() + this.RadUpload1.UploadedFiles[0].GetExtension()), true);
                                File.Delete(Path.Combine(Server.MapPath(this.RadUpload1.TargetFolder), this.RadUpload1.UploadedFiles[0].GetName()));

                            }

                            Clear(); this.txtEmpNameCode.Focus();
                            this.NotifyInfo.Text = "Save Completed !!"; this.NotifyInfo.Show();
                            break;
                        case false:

                            NP_Cls.sqlUpdate = "[stp_ep_update_InFor]";
                            cmd.Parameters.Add("@EmployeeID", SqlDbType.NVarChar, 50).Value = this.txtEmpNameCode.Text.Trim();
                            cmd.Parameters.Add("@FirstNameEN", SqlDbType.NVarChar, 50).Value = this.txtNameEng.Text.Trim();
                            cmd.Parameters.Add("@MidNameEN", SqlDbType.NVarChar, 10).Value = this.txtMidNameEng.Text.Trim();
                            cmd.Parameters.Add("@LastNameEN", SqlDbType.NVarChar, 50).Value = this.txtLastNameEng.Text.Trim();
                            cmd.Parameters.Add("@FirstNameTH", SqlDbType.NVarChar, 50).Value = this.txtNameThai.Text.Trim();
                            cmd.Parameters.Add("@MidNameTH", SqlDbType.NVarChar, 10).Value = this.txtMidNameThai.Text.Trim();
                            cmd.Parameters.Add("@LastNameTH", SqlDbType.NVarChar, 50).Value = this.txtLastNameThai.Text.Trim();
                            cmd.Parameters.Add("@NickNameEN", SqlDbType.NVarChar, 10).Value = this.txtNickNameEng.Text.Trim();
                            cmd.Parameters.Add("@NickNameTH", SqlDbType.NVarChar, 10).Value = this.txtNickNameThai.Text.Trim();

                            cmd.Parameters.Add("@IDCardNo", SqlDbType.NVarChar, 13).Value = this.txtID.Text.Trim();
                            cmd.Parameters.Add("@DateIssued", SqlDbType.Date).Value = this.dtpDateIssued.SelectedDate.Value;
                            cmd.Parameters.Add("@IssueAt", SqlDbType.NVarChar, 50).Value = this.txtIssueAt.Text.Trim();
                            cmd.Parameters.Add("@TaxPayerIDNo", SqlDbType.NVarChar, 50).Value = this.txtTaxPayerID.Text.Trim();
                            cmd.Parameters.Add("@SocialSecurityNo", SqlDbType.NVarChar, 50).Value = this.txtSocialSecNo.Text.Trim();

                            cmd.Parameters.Add("@DateOfBirth", SqlDbType.DateTime).Value = (this.dtpBirth.SelectedDate == null ? dNull : this.dtpBirth.SelectedDate.Value);
                            cmd.Parameters.Add("@EmpStatus", SqlDbType.NVarChar, 10).Value = "F";
                            cmd.Parameters.Add("@Gender", SqlDbType.Int).Value = this.cbGender.SelectedValue;
                            cmd.Parameters.Add("@Nationality", SqlDbType.Int).Value = this.cbNationalily.SelectedValue;
                            cmd.Parameters.Add("@Race", SqlDbType.Int).Value = this.cbRace.SelectedValue;
                            cmd.Parameters.Add("@Religion", SqlDbType.Int).Value = this.cbReligion.SelectedValue;

                            cmd.Parameters.Add("@DateExpire", SqlDbType.Date).Value = this.dtpDateExpire.SelectedDate.Value;
                            cmd.Parameters.Add("@PCAPosition", SqlDbType.NVarChar, 50).Value = this.txtPosition.Text.Trim();
                            cmd.Parameters.Add("@PCAEmail", SqlDbType.NVarChar, 50).Value = this.txtPCAEmail.Text.Trim();
                            cmd.Parameters.Add("@PCAExt", SqlDbType.NVarChar, 20).Value = this.txtPCAExt.Text.Trim();

                            cmd.Parameters.Add("@MaritalStatus", SqlDbType.Int).Value = this.cbMarital.SelectedValue;
                            cmd.Parameters.Add("@NumberChild", SqlDbType.Int).Value = (this.txtChildren.Value == null ? 0 : this.txtChildren.Value);
                            cmd.Parameters.Add("@PresentAddress", SqlDbType.NVarChar, 100).Value = this.txtPresentAddress.Text.Trim();
                            cmd.Parameters.Add("@PermanentAddress", SqlDbType.NVarChar, 100).Value = this.txtPermanentAddress.Text.Trim();
                            cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 50).Value = this.txtEmail.Text.Trim();
                            cmd.Parameters.Add("@Tel", SqlDbType.NVarChar, 20).Value = this.txtTel.Text.Trim();


                            cmd.Parameters.Add("@ImagePath", SqlDbType.NVarChar, 255).Value = (this.RadUpload1.UploadedFiles.Count > 0 ? this.txtEmpNameCode.Text.Trim() + this.RadUpload1.UploadedFiles[0].GetExtension() : this.lblIImagePath.Text.Trim());

                            cmd.CommandText = NP_Cls.sqlUpdate; cmd.Connection = oConn; cmd.CommandType = CommandType.StoredProcedure;
                            cmd.ExecuteNonQuery();

                            if (this.RadUpload1.UploadedFiles.Count > 0)
                            {
                                File.Copy(Path.Combine(Server.MapPath(this.RadUpload1.TargetFolder), this.RadUpload1.UploadedFiles[0].GetName()), Path.Combine(Server.MapPath(this.RadUpload1.TargetFolder), this.txtEmpNameCode.Text.Trim() + this.RadUpload1.UploadedFiles[0].GetExtension()), true);
                                File.Delete(Path.Combine(Server.MapPath(this.RadUpload1.TargetFolder), this.RadUpload1.UploadedFiles[0].GetName()));

                            }

                            Clear(); this.txtEmpNameCode.Focus();
                            this.NotifyInfo.Text = "Save Completed !!"; this.NotifyInfo.Show();
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
                string fullPath = Path.Combine(Server.MapPath(Session["tarFolder"].ToString()), uploadedFile.GetName());
                Context.Cache.Insert(uploadedFile.FileName, fullPath, null, DateTime.Now.Add(timeOut), TimeSpan.Zero,
                CacheItemPriority.Default, callBack);
                File.Copy(Path.Combine(Server.MapPath(Session["tarFolder"].ToString()), uploadedFile.GetName()), Path.Combine(@"D:\MilottFile\", uploadedFile.GetExtension()), true);
                uploadedFile.GetExtension(); Session["FName"] = "NP".ToString() + uploadedFile.GetExtension();

                File.Delete(Path.Combine(Server.MapPath(Session["tarFolder"].ToString()), uploadedFile.GetName()));
                //if (Session["Q"] == null) { Session["FName"] = uploadedFile.GetName(); }
            }
        }
        protected void RadUpload1_FileExists1(object sender, Telerik.Web.UI.Upload.UploadedFileEventArgs e)
        {
            //int counter = 1; Session["Q"] = string.Empty;
            //UploadedFile file = e.UploadedFile;

            //string targetFolder = Server.MapPath(Session["tarFolder"].ToString());
            //string targetFileName = Path.Combine(targetFolder,
            //    file.GetNameWithoutExtension() + counter.ToString() + file.GetExtension());

            //while (System.IO.File.Exists(targetFileName))
            //{
            //    counter++;
            //    targetFileName = Path.Combine(targetFolder,
            //        file.GetNameWithoutExtension() + counter.ToString() + file.GetExtension());
            //}
            //Session["FName"] = file.GetNameWithoutExtension() + counter.ToString() + file.GetExtension();
            //file.SaveAs(targetFileName);
        }
        protected void btnInq_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("ProfileInquiry.aspx");
        }
        
    }
}