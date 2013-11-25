using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace HR_EmpProfile
{
    public partial class HR_Profile : System.Web.UI.MasterPage
    {
        NP_Cls NP = new NP_Cls();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.Session["LU"] = "203";

                if (Request.QueryString["E"] != null)
                {
                    this.RadMenu1.Visible = true;
                    NP_Cls.sqlSelect = "[stp_ep_inquiry_user] '" + Request.QueryString["E"].ToString() + "'";
                    this.Session["USER"] = NP.Execute(NP_Cls.sqlSelect, ref NP_Cls.strErr);

                    // RadMenu
                    HyperLink lblUser = this.RadMenu1.Items[0].FindControl("lblUser") as HyperLink;
                    Image img = this.RadMenu1.Items[0].FindControl("imgPro") as Image;

                    lblUser.Text = string.Format("{0}-{1}_{2}", (this.Session["USER"] as DataSet).Tables[0].Rows[0]["EmployeeID"].ToString().Trim(), (this.Session["USER"] as DataSet).Tables[0].Rows[0]["FirstNameEN"].ToString().Trim(), (this.Session["USER"] as DataSet).Tables[0].Rows[0]["LastNameEN"].ToString().Trim());
                    lblUser.NavigateUrl = "ProfileInquiry.aspx";
                    img.ImageUrl = "img/EmpImg/" + (this.Session["USER"] as DataSet).Tables[0].Rows[0]["ImagePath"].ToString().Trim();

                    //Navigate
                    for (int i = 0; i < this.RadMenu1.Items[0].Items.Count; i++)
                    {
                        this.RadMenu1.Items[0].Items[i].NavigateUrl = this.RadMenu1.Items[0].Items[i].NavigateUrl.ToString() + "?E=" + Request.QueryString["E"].ToString();
                    }                    

                }
                else
                {
                    this.RadMenu1.Visible = false;
                }

                //Response.Write(this.Session["LU"].ToString());
              
                //if (Request.QueryString["LU"] == null)
                //{
                //    Response.Write("You do not have Perrmission !!");
                //    Response.End();
                //}
                //else
                //{
                //    this.Session["LU"] = Request.QueryString["LU"].ToString().Trim();
                //    Response.AddHeader("refresh", "2;url=ProfileInquiry.aspx?S=0");
                //}
            }
        }
    }
}