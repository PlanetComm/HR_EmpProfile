<%@ Page Title="" Language="C#" MasterPageFile="~/HR_Profile.Master" AutoEventWireup="true" CodeBehind="ProfileWarning.aspx.cs" Inherits="HR_EmpProfile.ProfileWarning" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">


<div style="vertical-align:top;">
    <asp:Panel ID="Panel1" runat="server">
   <table border="0" cellpadding="0" cellspacing="0" width="100%">
           <tr>
<td  colspan="2" align="right" style="background:#ffffff;padding-bottom:10px;"> 
    
    <img src="img/h_EmpWarning.png" />
    
</td>
</tr>
           <tr>
                        <td class="tdLeft">
                            Warning Start Date</td>
                        <td class="tdRight">
                           
                           <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
    <td class="tdRightFM">
        <telerik:RadDatePicker ID="dtpStartDate" Runat="server" Culture="en-US" 
            MinDate="1900-01-01" ShowPopupOnFocus="True" Skin="Metro" Width="255px" 
            AutoPostBack="True" onselecteddatechanged="dtpStartDate_SelectedDateChanged">
            <Calendar Skin="Metro" UseColumnHeadersAsSelectors="False" 
                UseRowHeadersAsSelectors="False" ViewSelectorText="x">
            </Calendar>
            <DateInput DateFormat="dd MMM yyyy" DisplayDateFormat="dd MMM yyyy" 
                DisplayText="" LabelWidth="40%" type="text" value="" AutoPostBack="True">
            </DateInput>
            <DatePopupButton HoverImageUrl="" ImageUrl="" />
        </telerik:RadDatePicker>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
            ControlToValidate="dtpStartDate" Display="Dynamic" ErrorMessage="Warning Start Date" 
            Font-Size="8px" ValidationGroup="Wn">**</asp:RequiredFieldValidator>
        </td>
       <td class="tdLeftM">
           Warning Expire Date</td>
       <td class="tdRightm">
           <telerik:RadDateInput ID="txtDateExpire" Runat="server" 
               DateFormat="dd MMM yyyy" Skin="Metro" Width="250px">
           </telerik:RadDateInput>
           <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
               ControlToValidate="txtDateExpire" Display="Dynamic" ErrorMessage="Warning Expire Date" 
               Font-Size="8px" ValidationGroup="Wn">**</asp:RequiredFieldValidator>
        </td>
    </tr>
    </table>

                           </td>
                    </tr>
                    <tr>
                        <td class="tdLeft">
                            Type of Warning</td>
                        <td class="tdRight">
                           
                           <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
    <td class="tdRightFM">
        <telerik:RadComboBox ID="cbType" Runat="server" Skin="Metro" Width="250px">
            <Items>
                <telerik:RadComboBoxItem runat="server" Selected="True" Value="0" />
                <telerik:RadComboBoxItem runat="server" Text="ORAL (ด้วยวาจา)" Value="O" />
                <telerik:RadComboBoxItem runat="server" Text="WRITTIN (ลายลักษณ์อักษร)" 
                    Value="W" />
            </Items>
        </telerik:RadComboBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
            ControlToValidate="cbType" Display="Dynamic" ErrorMessage="Type of Warning" 
            Font-Size="8px" ValidationGroup="Wn">**</asp:RequiredFieldValidator>
        </td>
       <td class="tdLeftM">
           Number of Count</td>
       <td class="tdRightm">
           <telerik:RadNumericTextBox ID="numCount" Runat="server" DataType="System.Int32" 
               MaxValue="5" MinValue="1" Width="250px">
               <NumberFormat DecimalDigits="0" ZeroPattern="n" />
           </telerik:RadNumericTextBox>
           <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
               ControlToValidate="numCount" Display="Dynamic" ErrorMessage="Number of Count" 
               Font-Size="8px" ValidationGroup="Wn">**</asp:RequiredFieldValidator>
        </td>
    </tr>
    </table>

                           </td>
                    </tr>
                    <tr>
                        <td class="tdLeft" valign="top">
                            Details</td>
                        <td class="tdRight">
                            <telerik:RadTextBox ID="txtDetails" Runat="server" MaxLength="1000" Rows="4" 
                                Skin="Metro" TextMode="MultiLine" Width="770px">
                            </telerik:RadTextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                ControlToValidate="txtDetails" Display="Dynamic" ErrorMessage="Details" 
                                Font-Size="8px" ValidationGroup="Wn">**</asp:RequiredFieldValidator>
                        </td>
           </tr>
                </table>
       </asp:Panel>
    
       <table border="0" cellpadding="0" cellspacing="0" width="100%">
           <tr>
               <td class="tdLeft" valign="top">
                   Attachment file</td>
               <td class="tdRight">
                   
                   <telerik:RadUpload ID="RadUpload1" runat="server" 
                       ControlObjectsVisibility="None" InputSize="26" MaxFileInputsCount="1" Skin="Metro" 
                       TargetFolder="~/img/WarningPDF" 
                       OverwriteExistingFiles="True">
                       <Localization Select="Browse" />
                   </telerik:RadUpload>
                   <asp:Label ID="Label1" runat="server" 
                       Text="Allow file .pdf, .jpg, .jpeg, .png" Font-Size="11px" ForeColor="Red"></asp:Label>
               </td>
           </tr>
           </table>
    

<asp:Panel ID="Panel2" runat="server">
   <table border="0" cellpadding="0" cellspacing="0" width="100%">
           <tr>
               <td class="tdLeft" valign="top">
                   &nbsp;</td>
               <td class="tdRight">
                   <asp:ValidationSummary ID="ValidationSummary1" runat="server" Font-Size="10px" 
                       ValidationGroup="Wn" />
               </td>
           </tr>
                    <tr>
                        <td class="tdLeft">
                            &nbsp;</td>
                        <td class="tdRight">
                        
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                        <td align="left" style="width:100%;" colspan="2">         
     
                            <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/img/Save.png" 
            onclick="btnSave_Click" ValidationGroup="Wn" />
                            &nbsp;<asp:ImageButton ID="btnReset" runat="server" ImageUrl="~/img/Reset.png" 
                                onclick="btnReset_Click" /></td>
                        </tr>
                        </table>   
       

                           </td>
                    </tr>
                    <tr>
                        <td  colspan="2">
                          
                          <div style="padding:5px 5px 5px 5px;">
                              <telerik:RadGrid ID="rgWn" runat="server" AutoGenerateColumns="False" 
                                  CellSpacing="0" GridLines="None" GroupingEnabled="False" 
                                  onitemcommand="rgWn_ItemCommand" Skin="Office2010Silver" 
                                  onitemdatabound="rgWn_ItemDataBound">
                                  <MasterTableView>
                                      <CommandItemSettings ExportToPdfText="Export to PDF" />
                                      <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" 
                                          Visible="True">
                                          <HeaderStyle Width="20px" />
                                      </RowIndicatorColumn>
                                      <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" 
                                          Visible="True">
                                          <HeaderStyle Width="20px" />
                                      </ExpandCollapseColumn>
                                      <Columns>

                                        <telerik:GridBoundColumn DataField="WnStartDate" DataFormatString="{0:dd MMM yyyy}" 
                                              DataType="System.DateTime" FilterControlAltText="Filter clnLevel column" 
                                              HeaderText="Start Date" UniqueName="clnWnStartDate">
                                              <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                          </telerik:GridBoundColumn>

                                          <telerik:GridBoundColumn DataField="WnExpireDate" DataFormatString="{0:dd MMM yyyy}" 
                                              DataType="System.DateTime" FilterControlAltText="Filter clnLevel column" 
                                              HeaderText="Expire Date" UniqueName="clnWnExpireDate">
                                              <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                          </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="WnTypeRe" Display="false"
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Type" 
                                              UniqueName="clnWnTypeRe" >
                                              <HeaderStyle HorizontalAlign="Center" Width="80px" />
                                          </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="WnType" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Type" 
                                              UniqueName="clnWnType" >
                                              <HeaderStyle HorizontalAlign="Center" Width="80px" />
                                          </telerik:GridBoundColumn>

                                          <telerik:GridBoundColumn DataField="WnCount" DataType="System.Int32" DataFormatString="{0:#0}"
                                              FilterControlAltText="Filter clnLevel column" HeaderText="#Count" 
                                              UniqueName="clnWnCount" >
                                              <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                          </telerik:GridBoundColumn>
                                        
                                          <telerik:GridBoundColumn DataField="WnDetails" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Details" 
                                              UniqueName="clnWnDetails" >
                                              <HeaderStyle HorizontalAlign="Center" Width="250px" />
                                          </telerik:GridBoundColumn>

                                          <telerik:GridTemplateColumn DataField="WnAttachFile" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Attach" 
                                              UniqueName="clnWnAttachFile">
                                              <ItemTemplate>
                                                  <asp:Label ID="WnAttachFileLabel" runat="server" Visible="false"
                                                      Text='<%# Eval("WnAttachFile") %>'></asp:Label>
                                                  <asp:HyperLink ID="HyperLink1" runat="server"></asp:HyperLink>
                                              </ItemTemplate>
                                              <HeaderStyle HorizontalAlign="center" />
                                              <ItemStyle Width="100px" />
                                          </telerik:GridTemplateColumn>

                                          <telerik:GridBoundColumn DataField="WnID" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="ID" Display="false" 
                                              UniqueName="clnWnID" >                                              
                                          </telerik:GridBoundColumn>

                                          <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" 
                                              ConfirmText="Do you want to Delete ?" 
                                              FilterControlAltText="Filter clnDel column" UniqueName="clnDel">
                                              <HeaderStyle Width="30px" />
                                              <ItemStyle HorizontalAlign="Center" />
                                          </telerik:GridButtonColumn>

                                      </Columns>
                                      <EditFormSettings>
                                          <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                          </EditColumn>
                                      </EditFormSettings>
                                      <PagerStyle PageSizeControlType="RadComboBox" />
                                  </MasterTableView>
                                  <PagerStyle PageSizeControlType="RadComboBox" />
                                  <FilterMenu EnableImageSprites="False">
                                  </FilterMenu>
                              </telerik:RadGrid>
                          </div>

                          
                          </td>
                    </tr>
     </table>
       </asp:Panel>
       </div>
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
    

</asp:Content>
