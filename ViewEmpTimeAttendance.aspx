<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewEmpTimeAttendance.aspx.cs" Inherits="HR_EmpProfile.ViewEmpTimeAttendance" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>[ Finger Scan Checking ]</title>
</head>
<body style="font-family:Tahoma;font-size:12px;">
    <form id="form1" runat="server">
   <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
    </telerik:RadScriptManager>
            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Runat="server" 
                 Skin="Simple">
             </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
                 <AjaxSettings>
                     <telerik:AjaxSetting AjaxControlID="btnSubmit">
                         <UpdatedControls>
                             <telerik:AjaxUpdatedControl ControlID="RadGrid1" 
                                 LoadingPanelID="RadAjaxLoadingPanel1" />
                         </UpdatedControls>
                     </telerik:AjaxSetting>
                     <telerik:AjaxSetting AjaxControlID="RadGrid1">
                         <UpdatedControls>
                             <telerik:AjaxUpdatedControl ControlID="RadGrid1" 
                                 LoadingPanelID="RadAjaxLoadingPanel1" />
                         </UpdatedControls>
                     </telerik:AjaxSetting>
                 </AjaxSettings>
             </telerik:RadAjaxManager>
  <div align="center">
   <table border="0" cellpadding="0" cellspacing="0" width="1300px" style="background-color:#D24726;" id="myTable">
    <tr>
    <td align="center" style="width:auto;height:50px;" colspan="2">
   
    <asp:Label ID="Label1" runat="server" Text="Finger Scan Checking" Font-Bold="True" Font-Names="Tahoma" Font-Size="25px" ForeColor="#FFFFFF"></asp:Label> 
        </td>
    </tr>
    <tr>
    <td align="left" style="width:auto;" colspan="2">
     <!-- Start New -->
     <div style="padding:10px 10px 5px 10px;">
     <table border="0" cellpadding="1" cellspacing="4" width="100%">
     
     <tr>
         <td style="background-color:#FFFFFF;">
 <div style="padding:5px 5px 5px 5px;">
     <asp:Panel ID="PanelCommand" runat="server">
     <table border="0" width="100%">
     <tr>
     <td>    <asp:Label ID="Label2" runat="server" Text="Select Employee : "></asp:Label>
         <telerik:RadComboBox ID="ddlEmp" Runat="server" Filter="Contains" 
             MaxHeight="500px" Skin="Outlook" Width="350px">
         </telerik:RadComboBox>
         &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
             ControlToValidate="ddlEmp" Display="Dynamic" ErrorMessage="** Please Select " 
             Font-Size="10px"></asp:RequiredFieldValidator>
         &nbsp;--  <asp:Label ID="Label3" runat="server" Text="Month : "></asp:Label>&nbsp;<telerik:RadMonthYearPicker
             ID="RadMonthYearPicker1" runat="server" Culture="en-US" 
             HiddenInputTitleAttibute="Visually hidden input created for functionality purposes." 
             Skin="Outlook">
             <DateInput DateFormat="MMM, yyyy" DisplayDateFormat="MMM, yyyy" 
                 LabelWidth="40%">
             </DateInput>
             <DatePopupButton HoverImageUrl="" ImageUrl="" />
         </telerik:RadMonthYearPicker>
         <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
             ControlToValidate="RadMonthYearPicker1" Display="Dynamic" 
             ErrorMessage="** Please Select " Font-Size="10px"></asp:RequiredFieldValidator>
         &nbsp;&nbsp;
         <telerik:RadButton ID="btnSubmit" runat="server" 
                 BackColor="White" BorderColor="#D24726" BorderStyle="Solid" BorderWidth="2px" 
                 ButtonType="LinkButton" Font-Size="11px" 
                 Skin="Office2010Silver" Text="Submit" Visible="true" Width="150px" 
             onclick="btnSubmit_Click"            >
             </telerik:RadButton>
                         &nbsp;<telerik:RadButton ID="btnExport" runat="server" 
                 BackColor="White" BorderColor="#D24726" BorderStyle="Solid" BorderWidth="2px" 
                 ButtonType="LinkButton" Font-Size="11px"
                 Skin="Office2010Silver" Text="Export to Excel" Width="150px" 
             CausesValidation="False" onclick="btnExport_Click">
             </telerik:RadButton></td>
     </tr>
     </table>
     
     </asp:Panel></div>
         </td>
     </tr>
     
     <tr>
     <td style="background-color:#FFFFFF;" >
     <div style="padding:5px 5px 5px 5px;">
         <telerik:RadGrid ID="RadGrid1" runat="server" 
             AutoGenerateColumns="False" CellSpacing="0" 
             GridLines="None" Skin="Simple" ongridexporting="RadGrid1_GridExporting">
             <GroupingSettings CaseSensitive="False" />
             <ExportSettings FileName="TimeChecking">
             </ExportSettings>
             <ClientSettings>
                 <Selecting AllowRowSelect="True" />
             </ClientSettings>
<MasterTableView>
<CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

<RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>

    <Columns>
        <telerik:GridBoundColumn AllowSorting="False" AutoPostBackOnFilter="True" 
            CurrentFilterFunction="Contains" DataField="EmpID" Display="false"
            FilterControlAltText="Filter clnLogTime column" HeaderText="" 
            ReadOnly="True" UniqueName="clnEmpID">
            <ItemStyle Width="200px" />
        </telerik:GridBoundColumn>

             <telerik:GridBoundColumn AllowSorting="False" AutoPostBackOnFilter="True" 
            CurrentFilterFunction="Contains" DataField="DD" Display="true"
            FilterControlAltText="Filter clnLogTime column" HeaderText="Date"
            ReadOnly="True" UniqueName="clnDate">
            <ItemStyle Width="200px" />
        </telerik:GridBoundColumn>

           <telerik:GridBoundColumn AllowSorting="False" AutoPostBackOnFilter="True" 
            CurrentFilterFunction="Contains" DataField="DoorFirstIN" Display="true"
            FilterControlAltText="Filter clnLogTime column" HeaderText="Door First IN"
            ReadOnly="True" UniqueName="clnDoorIN">
            <ItemStyle Width="200px" />
        </telerik:GridBoundColumn>
        
          <telerik:GridBoundColumn AllowSorting="False" AutoPostBackOnFilter="True" 
            CurrentFilterFunction="Contains" DataField="MINDATE" Display="true" DataFormatString="{0:dd-MMM-yyyy HH:mm:ss}"
            FilterControlAltText="Filter clnLogTime column" HeaderText="First IN" DataType="System.DateTime"
            ReadOnly="True" UniqueName="clnFirstIN">
            <ItemStyle Width="200px" />
        </telerik:GridBoundColumn>

            <telerik:GridBoundColumn AllowSorting="False" AutoPostBackOnFilter="True" 
            CurrentFilterFunction="Contains" DataField="DoorLastOUT" Display="true"
            FilterControlAltText="Filter clnLogTime column" HeaderText="Door Last OUT"
            ReadOnly="True" UniqueName="clnDoorOUT">
            <ItemStyle Width="200px" />
        </telerik:GridBoundColumn>
        
          <telerik:GridBoundColumn AllowSorting="False" AutoPostBackOnFilter="True" 
            CurrentFilterFunction="Contains" DataField="MAXDATE" Display="true" DataFormatString="{0:dd-MMM-yyyy HH:mm:ss}"
            FilterControlAltText="Filter clnLogTime column" HeaderText="Last OUT" DataType="System.DateTime"
            ReadOnly="True" UniqueName="clnLastOUT">
            <ItemStyle Width="200px" />
        </telerik:GridBoundColumn>

   
    </Columns>

<EditFormSettings>
<EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
</EditFormSettings>

<PagerStyle PageSizeControlType="RadComboBox"></PagerStyle>
</MasterTableView>

<PagerStyle PageSizeControlType="RadComboBox"></PagerStyle>

<FilterMenu EnableImageSprites="False"></FilterMenu>
         </telerik:RadGrid>
     </div>
         
     </td>
     </tr>
     </table>
     </div>
     <!-- End New -->
     </td>
    </tr>
    <tr align="center">
    <td  style="width:475px;font-family: Tahoma; font-size: small; font-weight: bold;" valign="top" >
        &nbsp;</td>
         <td style="width:475px;" valign="top">

        </td>
    </tr>
    </table>
    </div>
    </form>
</body>
</html>
