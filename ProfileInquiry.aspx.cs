using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace HR_EmpProfile
{
    public partial class ProfileInqury : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DGV(1);
            }
        }
        NP_Cls NP = new NP_Cls();
        private void DGV(byte type)
        {
            NP_Cls.sqlSelect = "[stp_ep_inquiry_InFor]";
            this.RadGrid1.DataSource = NP.Execute(NP_Cls.sqlSelect, ref NP_Cls.strErr);

            if (type == 1)
            {
                this.RadGrid1.DataBind();
            }
        }

        protected void RadGrid1_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                Image img1 = dataItem["clnImagePath"].FindControl("Image1") as Image;
                Label lbl1 = dataItem["clnImagePath"].FindControl("Label1") as Label;
                if (string.IsNullOrEmpty(lbl1.Text.Trim()))
                {
                    img1.ImageUrl = @"~\img\EmpImg\NoPic.png";
                }
                else
                {
                    img1.ImageUrl = @"~\img\EmpImg\" + lbl1.Text.Trim();
                }

                //Infor
                HyperLink HyInfor = dataItem["clnInfor"].FindControl("HyInfor") as HyperLink;
                HyInfor.Text = "Manage"; HyInfor.NavigateUrl = "ProfilePage.aspx?E=" + dataItem["clnEmpID"].Text.Trim();
                
                //Edu
                HyperLink HyEdu = dataItem["clnEdu"].FindControl("HyperLink1") as HyperLink;
                HyEdu.Text = "Manage"; HyEdu.NavigateUrl = "ProfileEducation.aspx?E=" + dataItem["clnEmpID"].Text.Trim();

                //Tra
                HyperLink HyTra = dataItem["clnTra"].FindControl("HyTra") as HyperLink;
                HyTra.Text = "Manage"; HyTra.NavigateUrl = "ProfileTraining.aspx?E=" + dataItem["clnEmpID"].Text.Trim();

                //His
                HyperLink HyHis = dataItem["clnHis"].FindControl("HyHis") as HyperLink;
                HyHis.Text = "Manage"; HyHis.NavigateUrl = "ProfileEmpHistory.aspx?E=" + dataItem["clnEmpID"].Text.Trim();

                //Gen
                HyperLink HyGen = dataItem["clnGen"].FindControl("HyGen") as HyperLink;
                HyGen.Text = "Manage"; HyGen.NavigateUrl = "ProfileGeneral.aspx?E=" + dataItem["clnEmpID"].Text.Trim();

                //Ref
                HyperLink HyRef = dataItem["clnRef"].FindControl("HyRef") as HyperLink;
                HyRef.Text = "Manage"; HyRef.NavigateUrl = "ProfileReferences.aspx?E=" + dataItem["clnEmpID"].Text.Trim();

                //
                RadMenu RadMenu = dataItem["clnLink"].FindControl("MenuLink") as RadMenu;
                RadMenu.Items[0].Text = "Other ..";
                for (int i = 0; i < RadMenu.Items[0].Items.Count; i++)
                {
                    RadMenu.Items[0].Items[i].NavigateUrl = RadMenu.Items[0].Items[i].NavigateUrl + "?E=" + dataItem["clnEmpID"].Text.Trim();
                }
                
            }
        }

        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            DGV(0);
        }

        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("ProfilePage.aspx");
        }

     
    }
}