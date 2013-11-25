<%@ Page Title="" Language="C#" MasterPageFile="~/HR_Profile.Master" AutoEventWireup="true" CodeBehind="InformationPage.aspx.cs" Inherits="HR_EmpProfile.InformationPage" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
     
<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Runat="server" 
            Skin="Sunset">
        </telerik:RadAjaxLoadingPanel>
   
        <telerik:RadNotification ID="NotifyInfo" runat="server" Height="150px" 
        OffsetY="-50" Position="BottomCenter" Skin="Windows7" Title="Information" 
        Width="350px">
    </telerik:RadNotification>
    <telerik:RadNotification ID="NotifyWarn" runat="server" Height="150px" 
        OffsetY="-50" Position="BottomCenter" Skin="Sunset" Title="Information" 
        Width="350px">
    </telerik:RadNotification>
   
   <table width="100%" border="0" cellpadding="1" cellspacing="1">
<tr>
<td class="tdLeftReq">
    Employee Code</td>
    <td class="tdRight">
        <asp:Panel ID="PanelCode" runat="server">
    <telerik:RadTextBox ID="txtEmpNameCode" Runat="server" Skin="Metro" 
           Width="230px" AutoPostBack="True" MaxLength="50" 
                ontextchanged="txtEmpNameCode_TextChanged">
        </telerik:RadTextBox>    
            <asp:Image ID="imgCorrect" runat="server" ImageUrl="~/img/check_.png" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="txtEmpNameCode" Display="Dynamic" 
                ErrorMessage="Employee Code" Font-Size="8px">**</asp:RequiredFieldValidator>
      
        </asp:Panel>      <asp:ImageButton ID="btnCheck" runat="server" ImageUrl="~/img/Check.png" 
                onclick="btnCheck_Click" ImageAlign="Bottom" 
            CausesValidation="False" />
        <asp:Label ID="lblID" runat="server" Visible="False"></asp:Label>
    </td>
    <td class="tdRightMore"  rowspan="12" valign="top" align="center">
     
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
    <td style="text-align:center;"> 
    <asp:Image ID="imgProfile" runat="server" Height="230px" ImageAlign="Middle" CssClass="currentImg"
            Width="200px" />
            </td>
    </tr>
       </table> 
        
    </td>
</tr>
<tr>
<td class="tdLeftReq">
    Employee Name (Thai)</td>
    <td class="tdRight">
        <telerik:RadTextBox ID="txtNameThai" Runat="server" Skin="Metro" Width="150px" 
            MaxLength="50">
        </telerik:RadTextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
            ControlToValidate="txtNameThai" Display="Dynamic" 
            ErrorMessage="Employee Name (Thai)" Font-Size="8px">**</asp:RequiredFieldValidator>
    <telerik:RadTextBox ID="txtMidNameThai" Runat="server" Skin="Metro" 
            Width="70px" MaxLength="10">
        </telerik:RadTextBox>
        <telerik:RadTextBox ID="txtLastNameThai" Runat="server" Skin="Metro" 
            Width="150px" MaxLength="50">
        </telerik:RadTextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
            ControlToValidate="txtLastNameThai" Display="Dynamic" 
            ErrorMessage="Employee LastName (Thai)" Font-Size="8px">**</asp:RequiredFieldValidator>
    </td>
</tr>
<tr>
<td class="tdLeftReq">
    Employee Name (Eng)</td>
    <td class="tdRight">
        <telerik:RadTextBox ID="txtNameEng" Runat="server" Skin="Metro" Width="150px" 
            MaxLength="50">
        </telerik:RadTextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
            ControlToValidate="txtNameEng" Display="Dynamic" 
            ErrorMessage="Employee Name (Eng)" Font-Size="8px">**</asp:RequiredFieldValidator>
    <telerik:RadTextBox ID="txtMidNameEng" Runat="server" Skin="Metro" 
            Width="70px" MaxLength="10">
        </telerik:RadTextBox>
        <telerik:RadTextBox ID="txtLastNameEng" Runat="server" Skin="Metro" 
            Width="150px" MaxLength="50">
        </telerik:RadTextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
            ControlToValidate="txtLastNameEng" Display="Dynamic" 
            ErrorMessage="Employee LastName (Eng)" Font-Size="8px">**</asp:RequiredFieldValidator>
    </td>
</tr>
<tr>
<td class="tdLeft">
    Nickname (Thai - Eng)</td>
    <td class="tdRight">
        <telerik:RadTextBox ID="txtNickNameThai" Runat="server" Skin="Metro" 
            Width="185px" MaxLength="10">
        </telerik:RadTextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
            ControlToValidate="txtNickNameThai" Display="Dynamic" 
            ErrorMessage="Nickname (Eng)" Font-Size="8px">**</asp:RequiredFieldValidator>
    &nbsp;<telerik:RadTextBox ID="txtNickNameEng" Runat="server" Skin="Metro" 
            Width="185px" MaxLength="10">
        </telerik:RadTextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
            ControlToValidate="txtNickNameEng" Display="Dynamic" ErrorMessage="Nickname (Eng)" 
            Font-Size="8px">**</asp:RequiredFieldValidator>
    </td>
</tr>
<tr>
<td class="tdLeft">
    Date of Birth</td>
    <td class="tdRight">
        <asp:Panel ID="PanelAge" runat="server">
        <telerik:RadDatePicker ID="dtpBirth" Runat="server" AutoPostBack="True" 
            Culture="en-US" Skin="Metro" Width="225px" 
            onselecteddatechanged="dtpBirth_SelectedDateChanged" MinDate="1900-01-01">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                ViewSelectorText="x" Skin="Metro"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" DisplayText="" 
                LabelWidth="40%" type="text" value="" AutoPostBack="True"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
        </telerik:RadDatePicker>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
            ControlToValidate="dtpBirth" Display="Dynamic" ErrorMessage="Date of Birth" 
            Font-Size="8px">**</asp:RequiredFieldValidator>
&nbsp;--&nbsp;
    <telerik:RadTextBox ID="txtAge" Runat="server" Skin="Metro" 
            Width="70px" BackColor="#FFFFCC">
        </telerik:RadTextBox>
                <asp:Label ID="Label1" runat="server" Font-Size="11px" Text="years old"></asp:Label>
                </asp:Panel>
    </td>
</tr>
<tr>
<td class="tdLeft">
    Gender</td>
    <td class="tdRight">
        <telerik:RadComboBox ID="cbGender" Runat="server" Skin="Metro" 
            DataTextField="DESC" DataValueField="ID">
        </telerik:RadComboBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" 
            ControlToValidate="cbGender" Display="Dynamic" ErrorMessage="Gender" 
            Font-Size="8px">**</asp:RequiredFieldValidator>
    </td>
</tr>
<tr>
<td class="tdLeft">
    Nationality</td>
    <td class="tdRight">
        <telerik:RadComboBox ID="cbNationalily" Runat="server" Skin="Metro" 
            DataTextField="DESC" DataValueField="ID">
        </telerik:RadComboBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" 
            ControlToValidate="cbNationalily" Display="Dynamic" ErrorMessage="Nationality" 
            Font-Size="8px">**</asp:RequiredFieldValidator>
    </td>
</tr>
<tr>
<td class="tdLeft">
    Race</td>
    <td class="tdRight">
        <telerik:RadComboBox ID="cbRace" Runat="server" Skin="Metro" 
            DataTextField="DESC" DataValueField="ID">
        </telerik:RadComboBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" 
            ControlToValidate="cbRace" Display="Dynamic" ErrorMessage="Race" 
            Font-Size="8px">**</asp:RequiredFieldValidator>
    </td>
</tr>
<tr>
<td class="tdLeft">
    <span id="result_box" class="short_text" lang="en"><span class="hps">Religion</span></span></td>
    <td class="tdRight">
        <telerik:RadComboBox ID="cbReligion" Runat="server" Skin="Metro" 
            DataTextField="DESC" DataValueField="ID">
        </telerik:RadComboBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" 
            ControlToValidate="cbReligion" Display="Dynamic" ErrorMessage="Religion" 
            Font-Size="8px">**</asp:RequiredFieldValidator>
    </td>
</tr>

<tr>
<td class="tdLeft">
    Employee Image</td>
    <td class="tdRight">
     <telerik:RadUpload ID="RadUpload1" runat="server" 
        ControlObjectsVisibility="None" MaxFileInputsCount="1" MaxFileSize="102400"  TargetFolder="~/img/EmpImg"
        Skin="Outlook" 
            onfileexists="RadUpload1_FileExists" EnableAjaxSkinRendering="False" 
            OverwriteExistingFiles="True"><Localization Select="Browse" />
    </telerik:RadUpload></td>
</tr>
<tr>
<td class="tdLeft">
    &nbsp;
    </td>
    <td class="tdRight">
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" Font-Size="10px" 
            HeaderText="Please entry field as below:" />
    </td>
</tr>
<tr>
<td class="tdLeft">
    &nbsp;</td>
    <td class="tdRight">
        <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/img/Save.png" 
            onclick="btnSave_Click" />
        &nbsp;<asp:ImageButton ID="btnReset" runat="server" ImageUrl="~/img/Reset.png" />
    </td>
</tr>
</table>

    </asp:Content>
