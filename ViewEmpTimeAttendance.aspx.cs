using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

namespace HR_EmpProfile
{
    public partial class ViewEmpTimeAttendance : System.Web.UI.Page
    {
        NP_Cls NP = new NP_Cls();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["E"] != null)
                {
                    switch (NP.DeText(Request.QueryString["E"].ToString().Trim()))
                    {
                        case "203":
                        case "066":
                        case "149":
                        case "234":
                        case "039":
                        case "016":
                        case "246":
                            NP_Cls.sqlSelect = "SELECT     EmployeeID, '(' + EmployeeID + ')' + '- ' + FirstName + '_' + LastName AS sName FROM         Employee WHERE     (EmpStatus <> 'R') ";
                            NP_Cls.sqlSelect += " ORDER BY EmployeeID";

                            break;
                        default:
                            NP_Cls.sqlSelect = "SELECT     EmployeeID, '(' + EmployeeID + ')' + '- ' + FirstName + '_' + LastName AS sName FROM         Employee WHERE     (EmpStatus <> 'R') ";
                            NP_Cls.sqlSelect += " AND (EmployeeID = '" + NP.DeText(Request.QueryString["E"].ToString().Trim()) + "') ";
                            NP_Cls.sqlSelect += " ORDER BY EmployeeID";
                            break;
                    }

                    DataSet dsIT = new DataSet();
                    dsIT = NP.ExecuteIT(NP_Cls.sqlSelect, ref NP_Cls.strErr);
                    this.ddlEmp.DataSource = dsIT.Tables[0]; this.ddlEmp.DataTextField = "sName"; this.ddlEmp.DataValueField = "EmployeeID"; this.ddlEmp.DataBind();

                    DGV(0);
                }
                else
                {
                    //Response.Redirect("http://192.168.73.39/MainMenu.asp");
                }
            }
        }

        private void DGV(int p)
        {
          
            if (p == 0)
            {
                NP_Cls.sqlSelect = "SELECT     View_Data.EmpID, View_Data.DD, View_SubData.sName AS DoorFirstIN, View_Data.MINDATE, View_SubData_1.sName AS DoorLastOUT,    View_Data.MAXDATE FROM         View_Data INNER JOIN                       View_SubData ON View_Data.MINDATE = View_SubData.dLogDate AND View_Data.EmpID = View_SubData.EmpID INNER JOIN                       View_SubData AS View_SubData_1 ON View_Data.MAXDATE = View_SubData_1.dLogDate AND View_Data.EmpID = View_SubData_1.EmpID WHERE     (View_Data.EmpID = N'X') ORDER BY View_Data.ST";
            }
            else
            {
                NP_Cls.sqlSelect = "SELECT     View_Data.EmpID, View_Data.DD, View_SubData.sName AS DoorFirstIN, View_Data.MINDATE, View_SubData_1.sName AS DoorLastOUT,    View_Data.MAXDATE FROM         View_Data INNER JOIN                       View_SubData ON View_Data.MINDATE = View_SubData.dLogDate AND View_Data.EmpID = View_SubData.EmpID INNER JOIN                       View_SubData AS View_SubData_1 ON View_Data.MAXDATE = View_SubData_1.dLogDate AND View_Data.EmpID = View_SubData_1.EmpID WHERE     (View_Data.EmpID = N'" + this.ddlEmp.SelectedValue.ToString().Trim() + "') AND (CAST(View_Data.ST AS int) > '" + this.RadMonthYearPicker1.SelectedDate.Value.ToString("yyyyMM", NP_Cls.cul) + "00" + "') AND (CAST(View_Data.ST AS int) < '" + this.RadMonthYearPicker1.SelectedDate.Value.ToString("yyyyMM", NP_Cls.cul) + "32" + "')   ";
                switch (this.ddlEmp.SelectedValue.ToString().Trim())
                {
                    case "027":
                        NP_Cls.sqlSelect += " AND (View_SubData.nEventIdn IN ('23')) ORDER BY View_Data.ST";
                        break;
                    default:
                        NP_Cls.sqlSelect += " AND (View_SubData.nEventIdn IN ('55')) ORDER BY View_Data.ST";
                        break;
                }
            }
            this.RadGrid1.DataSource = NP.ExecuteBio(NP_Cls.sqlSelect, ref NP_Cls.strErr).Tables[0];
            this.RadGrid1.DataBind();
        }
        private void ConfigureExport()
        {
            //this.rgProd.MasterTableView.HierarchyLoadMode = GridChildLoadMode.ServerBind;
            this.RadGrid1.ExportSettings.ExportOnlyData = true;
            this.RadGrid1.ExportSettings.Excel.Format = GridExcelExportFormat.Html;
            this.RadGrid1.ExportSettings.IgnorePaging = true;
            this.RadGrid1.ExportSettings.FileName = this.RadGrid1.ExportSettings.FileName + "_" + DateTime.Now.ToString("ddMMMyy", NP_Cls.cul);
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            DGV(1);
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            ConfigureExport();
            this.RadGrid1.MasterTableView.ExportToExcel();
        }

        protected void RadGrid1_GridExporting(object sender, GridExportingArgs e)
        {
            string customHTML = "<table><tr><td><b> "+ this.ddlEmp.SelectedItem.Text.Trim() +"</b></td><td>Finger Scan Checking on "+ DateTime.Now.ToString("dd MMM yyy", NP_Cls.cul) +"</td></tr><table>";
            e.ExportOutput = e.ExportOutput.Replace("<body>", String.Format("<body>{0}", customHTML));
        }

    }
}