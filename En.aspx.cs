using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HR_EmpProfile
{
    public partial class En : System.Web.UI.Page
    {
        NP_Cls NP = new NP_Cls();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["E"] == null)
            {
                Response.Redirect("http://pca-erp");
            }
            else
            {
                try
                {
                    string EID = Request.QueryString["E"].ToString();
                    Response.Redirect("ViewEmpTimeAttendance.aspx?E=" + NP.EnText(EID));
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }
            }
        }
    }
}