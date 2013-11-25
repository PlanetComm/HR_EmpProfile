<%@ Page Title="" Language="C#" MasterPageFile="~/HR_Profile.Master" AutoEventWireup="true" CodeBehind="ProfilePage.aspx.cs" Inherits="HR_EmpProfile.ProfilePage" %>
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
<td  colspan="3" align="right" style="background:#ffffff;padding-bottom:10px;"> 
    <img src="img/h_EmpProfile.png" />
</td>
</tr>

<tr>
<td class="tdLeftReq"> Employee Code</td>
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
        <asp:Label ID="lblID" runat="server" Visible="false"></asp:Label>
        <asp:Label ID="lblIImagePath" runat="server" Visible="false"></asp:Label>
    </td>
    <td class="tdRightMore"  rowspan="7" valign="top" align="center">
     
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
    <td style="text-align:center;" valign="middle">
    <a href='<%=Session["PIC"].ToString() %>' target="_blank"> 
    <asp:Image ID="imgProfile" runat="server" Height="230px" ImageAlign="Middle" CssClass="currentImg"
            Width="200px" /></a>
            </td>
    </tr>
       </table> 
        
    </td>
</tr>
<tr>
<td class="tdLeftReq">
    Employee Name (Thai)</td>
    <td class="tdRight">
        <telerik:RadTextBox ID="txtNameThai" Runat="server" Skin="Metro" Width="165px" 
            MaxLength="50">
        </telerik:RadTextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
            ControlToValidate="txtNameThai" Display="Dynamic" 
            ErrorMessage="Employee Name (Thai)" Font-Size="8px">**</asp:RequiredFieldValidator>
    <telerik:RadTextBox ID="txtMidNameThai" Runat="server" Skin="Metro" 
            Width="70px" MaxLength="10">
        </telerik:RadTextBox>
        <telerik:RadTextBox ID="txtLastNameThai" Runat="server" Skin="Metro" 
            Width="165px" MaxLength="50">
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
        <telerik:RadTextBox ID="txtNameEng" Runat="server" Skin="Metro" Width="165px" 
            MaxLength="50">
        </telerik:RadTextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
            ControlToValidate="txtNameEng" Display="Dynamic" 
            ErrorMessage="Employee Name (Eng)" Font-Size="8px">**</asp:RequiredFieldValidator>
    <telerik:RadTextBox ID="txtMidNameEng" Runat="server" Skin="Metro" 
            Width="70px" MaxLength="10">
        </telerik:RadTextBox>
        <telerik:RadTextBox ID="txtLastNameEng" Runat="server" Skin="Metro" 
            Width="165px" MaxLength="50">
        </telerik:RadTextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
            ControlToValidate="txtLastNameEng" Display="Dynamic" 
            ErrorMessage="Employee LastName (Eng)" Font-Size="8px">**</asp:RequiredFieldValidator>
    </td>
</tr>


<tr>
<td class="tdLeftReq">
  I.D Card No</td>
    <td class="tdRight">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
    <td class="tdRightFMMINI">
    <telerik:RadMaskedTextBox ID="txtID" Runat="server" DisplayText="" 
            LabelWidth="92px" Mask="#-####-#####-##-#" TextWithLiterals="----" value="" 
            Width="165px">
        </telerik:RadMaskedTextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" 
                ControlToValidate="txtID" Display="Dynamic" 
                ErrorMessage="Employee ID Card No." Font-Size="8px">**</asp:RequiredFieldValidator>
      
    </td>
       <td class="tdLeftMReq">
           Date Expire</td>
       <td class="tdRightm">
   &nbsp;<telerik:RadDatePicker ID="dtpDateExpire" Runat="server" 
            Culture="en-US" Skin="Metro" Width="190px" 
             MinDate="1900-01-01" ShowPopupOnFocus="True">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                ViewSelectorText="x" Skin="Metro"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" DisplayText="" 
                LabelWidth="40%" type="text" value="" ></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
        </telerik:RadDatePicker>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                ControlToValidate="dtpDateExpire" Display="Dynamic" 
                ErrorMessage="Date Expire" Font-Size="8px">**</asp:RequiredFieldValidator>
      
    </td>
    </tr>
    </table>
        
      
    </td>
</tr>
<tr>
<td class="tdLeftReq">
    Date Issued</td>
    <td class="tdRight">
     
     <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
    <td class="tdRightFMMINI">
    
      <telerik:RadDatePicker ID="dtpDateIssued" Runat="server" 
            Culture="en-US" Skin="Metro" Width="190px" 
             MinDate="1900-01-01" ShowPopupOnFocus="True">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                ViewSelectorText="x" Skin="Metro"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" DisplayText="" 
                LabelWidth="40%" type="text" value="" ></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
        </telerik:RadDatePicker>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" 
                ControlToValidate="dtpDateIssued" Display="Dynamic" 
                ErrorMessage="Date Issued" Font-Size="8px">**</asp:RequiredFieldValidator>
      
    </td>
       <td class="tdLeftMReq">
           Issued At</td>
       <td class="tdRightm">
   &nbsp;<telerik:RadTextBox ID="txtIssueAt" Runat="server" MaxLength="50" 
                        Skin="Metro" Width="165px">
                    </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" 
                ControlToValidate="txtIssueAt" Display="Dynamic" 
                ErrorMessage="Issued At" Font-Size="8px">**</asp:RequiredFieldValidator>
      
    </td>
    </tr>
    </table>

    </td>
</tr>
<tr>
<td class="tdLeft">
    Tax Payer I.D No</td>
    <td class="tdRight">
     
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="tdRightFMMINI">
                    <telerik:RadTextBox ID="txtTaxPayerID" Runat="server" MaxLength="50" 
                        Skin="Metro" Width="165px">
                    </telerik:RadTextBox>
                </td>
                <td class="tdLeftM">
                    Social Security No</td>
                <td class="tdRightm">
                    &nbsp;<telerik:RadTextBox ID="txtSocialSecNo" Runat="server" MaxLength="50" 
                        Skin="Metro" Width="165px">
                    </telerik:RadTextBox>
                </td>
            </tr>
        </table>

    </td>
</tr>

<tr>
<td class="tdLeft">
    Nickname (Thai)</td>
    <td class="tdRight">

    <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="tdRightFMMINI">
              <telerik:RadTextBox ID="txtNickNameThai" Runat="server" Skin="Metro" 
            Width="165px" MaxLength="10">
        </telerik:RadTextBox>
                </td>
                <td class="tdLeftM">
                  Nickname (Eng)</td>
                <td class="tdRightm">
            &nbsp;<telerik:RadTextBox ID="txtNickNameEng" Runat="server" Skin="Metro" 
            Width="165px" MaxLength="10">
        </telerik:RadTextBox>
                </td>
            </tr>
        </table>   
    </td>
</tr>
<tr>
<td class="tdLeft">
    Date of Birth</td>
    <td class="tdRight">
 <asp:Panel ID="PanelAge" runat="server">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="tdRightFMMINI">
      <telerik:RadDatePicker ID="dtpBirth" Runat="server" AutoPostBack="True" 
            Culture="en-US" Skin="Metro" Width="190px" 
            onselecteddatechanged="dtpBirth_SelectedDateChanged" MinDate="1900-01-01" 
                        ShowPopupOnFocus="True">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                ViewSelectorText="x" Skin="Metro"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" DisplayText="" 
                LabelWidth="40%" type="text" value="" AutoPostBack="True"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
        </telerik:RadDatePicker>
                </td>
                <td class="tdLeftM">
                  Age</td>
                <td class="tdRightm">
                    &nbsp;<telerik:RadTextBox ID="txtAge" Runat="server" Skin="Metro" 
            Width="70px" ReadOnly="True">
        </telerik:RadTextBox>
                <asp:Label ID="Label1" runat="server" Font-Size="11px" Text="years old"></asp:Label>
                </td>
            </tr>
        </table>
  </asp:Panel>
    </td>
    <td>&nbsp;</td>
</tr>
<tr>
<td class="tdLeft">
    Gender</td>
    <td class="tdRight">
        <telerik:RadComboBox ID="cbGender" Runat="server" Skin="Metro" 
            DataTextField="DESC" DataValueField="ID">
        </telerik:RadComboBox>
    </td>
    <td>&nbsp;</td>
</tr>
<tr>
<td class="tdLeft">
    Nationality</td>
    <td class="tdRight" colspan="2">
        
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
    <td class="tdRightFM">
      <telerik:RadComboBox ID="cbNationalily" Runat="server" Skin="Metro" 
            DataTextField="DESC" DataValueField="ID">
        </telerik:RadComboBox>
    </td>
       <td class="tdLeftM">
           Position</td>
       <td class="tdRightm">
              <telerik:RadTextBox ID="txtPosition" Runat="server" Skin="Metro" 
            Width="160px" MaxLength="10">
        </telerik:RadTextBox>
    </td>
    </tr>
    </table>
    </td>
</tr>
<tr>
<td class="tdLeft">
    Race</td>
    <td class="tdRight" colspan="2">

    <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
    <td class="tdRightFM">
      <telerik:RadComboBox ID="cbRace" Runat="server" Skin="Metro" 
            DataTextField="DESC" DataValueField="ID">
        </telerik:RadComboBox>
    </td>
       <td class="tdLeftM">
    Religion
    </td>
       <td class="tdRightm">
   &nbsp;<telerik:RadComboBox ID="cbReligion" Runat="server" Skin="Metro" Width="150px"
            DataTextField="DESC" DataValueField="ID">
        </telerik:RadComboBox>
    </td>
    </tr>
    </table>
    
        
        </td>
</tr>
<tr>
<td class="tdLeft">
    Marital Status</td>
    <td class="tdRight" colspan="2">
     
     <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
    <td class="tdRightFM">
      <telerik:RadComboBox ID="cbMarital" Runat="server" Skin="Metro" 
            DataTextField="DESC" DataValueField="ID">
        </telerik:RadComboBox>
    </td>
       <td class="tdLeftM">
           Number of Children</td>
       <td class="tdRightm">
   &nbsp;<telerik:RadNumericTextBox ID="txtChildren" Runat="server" 
               DataType="System.Int16" Skin="Metro" Width="156px">
<NumberFormat ZeroPattern="n" DecimalDigits="0"></NumberFormat>
           </telerik:RadNumericTextBox>
    </td>
    </tr>
    </table>

    </td>
</tr>

<tr>
<td class="tdLeft">
    Present Address</td>
    <td class="tdRight" colspan="2">
        <telerik:RadTextBox ID="txtPresentAddress" Runat="server"
            MaxLength="100" Skin="Metro" 
            Width="680px">
        </telerik:RadTextBox>
    </td>
    
</tr>

<tr>
<td class="tdLeft">
    Permanent Address</td>
    <td class="tdRight" colspan="2">
        <telerik:RadTextBox ID="txtPermanentAddress" Runat="server" 
           MaxLength="50"
            Skin="Metro" Width="680px">
        </telerik:RadTextBox>
    </td>
    
</tr>

<tr>
<td class="tdLeft">
    Email</td>
    <td class="tdRight" colspan="2">
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="tdRightFM">
                    <telerik:RadTextBox ID="txtEmail" Runat="server" MaxLength="100" Skin="Metro" 
                        Width="250px">
                    </telerik:RadTextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                        ControlToValidate="txtEmail" ErrorMessage="Valid Email" Font-Size="9px" 
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                </td>
                <td class="tdLeftM">
                    Tel</td>
                <td class="tdRightm">
        <telerik:RadMaskedTextBox ID="txtTel" Runat="server" DisplayText="" 
            LabelWidth="92px" Mask="(###) ###-####" TextWithLiterals="----" value="" 
            Width="160px" Skin="Metro">
        </telerik:RadMaskedTextBox>
                </td>
            </tr>
        </table>
    </td>
    
</tr>

<tr>
<td class="tdLeft">
  PlanetComm Email</td>
    <td class="tdRight" colspan="2">
   <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="tdRightFM">
                    <telerik:RadTextBox ID="txtPCAEmail" Runat="server" MaxLength="100" Skin="Metro" 
                        Width="250px">
                    </telerik:RadTextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                        ControlToValidate="txtPCAEmail" ErrorMessage="Valid Email" Font-Size="9px" 
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                </td>
                <td class="tdLeftM">
                    PlanetComm Ext.</td>
                <td class="tdRightm">
              <telerik:RadTextBox ID="txtPCAExt" Runat="server" Skin="Metro" 
            Width="160px" MaxLength="10">
        </telerik:RadTextBox>
                </td>
            </tr>
        </table>
   </td>
    
</tr>

<tr>
<td class="tdLeft">
    Employee Image</td>
    <td class="tdRight" colspan="2">
     <telerik:RadUpload ID="RadUpload1" runat="server" 
        ControlObjectsVisibility="None" MaxFileInputsCount="1"  TargetFolder="~/img/EmpImg"
        Skin="Outlook" InputSize="26" 
            onfileexists="RadUpload1_FileExists1"><Localization Select="Browse" />
    </telerik:RadUpload></td>
    
</tr>
<tr>
<td class="tdLeft">
    &nbsp;
    </td>
    <td class="tdRight" colspan="2">
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
    &nbsp;<asp:ImageButton ID="btnInq" runat="server" ImageUrl="~/img/inquiry.png" 
            onclick="btnInq_Click" CausesValidation="False" Visible="False" />
    </td>
    <td>&nbsp;</td>
</tr>
<tr>
<td  colspan="3">
        
        
    </td>
</tr>
</table>

</asp:Content>
