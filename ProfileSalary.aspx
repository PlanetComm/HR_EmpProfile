<%@ Page Title="" Language="C#" MasterPageFile="~/HR_Profile.Master" AutoEventWireup="true" CodeBehind="ProfileSalary.aspx.cs" Inherits="HR_EmpProfile.ProfileSalary" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div style="vertical-align:top;">
    <asp:Panel ID="Panel1" runat="server">
   <table border="0" cellpadding="0" cellspacing="0" width="100%">
           <tr>
<td  colspan="2" align="right" style="background:#ffffff;padding-bottom:10px;"> 
    
    <img src="img/h_EmpSalary.png" />
    
</td>
</tr>
           <tr>
<td class="tdLeft">
    Salary Start Date</td>
    <td class="tdRight">
     
     

        <telerik:RadDatePicker ID="dtpSalaryStart" Runat="server" Culture="en-US" 
            MinDate="1900-01-01" ShowPopupOnFocus="True" Skin="Metro" Width="250px">
            <Calendar Skin="Metro" UseColumnHeadersAsSelectors="False" 
                UseRowHeadersAsSelectors="False" ViewSelectorText="x">
            </Calendar>
            <DateInput DateFormat="dd MMM yyyy" DisplayDateFormat="dd MMM yyyy" 
                DisplayText="" LabelWidth="40%" type="text" value="">
            </DateInput>
  
        </telerik:RadDatePicker>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator23" runat="server" 
            ControlToValidate="dtpSalaryStart" Display="Dynamic" ErrorMessage="Salary Start Date" 
            Font-Size="8px" ValidationGroup="Sal">**</asp:RequiredFieldValidator>
             
     

        </td>
</tr>
                    <tr>
                        <td class="tdLeft">
                            Salary Amount</td>
                        <td class="tdRight">
                            <telerik:RadNumericTextBox ID="numSalary" Runat="server" Culture="en-US" 
                                DbValueFactor="1" LabelWidth="64px" MinValue="0" Width="245px">
                            </telerik:RadNumericTextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator24" runat="server" 
                                ControlToValidate="numSalary" Display="Dynamic" ErrorMessage="Salary Amount" 
                                Font-Size="8px" ValidationGroup="Sal">**</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdLeft">
                            &nbsp;</td>
                        <td class="tdRight">
                           
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" Font-Size="10px" 
                                ValidationGroup="Sal" />

                           </td>
                    </tr>
                    <tr>
                        <td class="tdLeft">
                            &nbsp;</td>
                        <td class="tdRight">
                        
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                        <td align="left" style="width:50%;"> 
             
     

        <asp:ImageButton ID="btnAdd" runat="server" ImageUrl="~/img/add.png" 
            onclick="btnAdd_Click" ValidationGroup="Sal" />
             
     

                  </td>
                        <td align="right" style="width:50%;"><asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/img/Save.png" 
            onclick="btnSave_Click" />
                            &nbsp;<asp:ImageButton ID="btnReset" runat="server" ImageUrl="~/img/Reset.png" 
                                onclick="btnReset_Click" /></td>
                        </tr>
                        </table>   
       

                           </td>
                    </tr>
                    <tr>
                        <td class="tdLeft">
                            &nbsp;</td>
                        <td class="tdRight">
                           
                            <br />

                           </td>
                    </tr>
                    <tr>
                        <td  colspan="2">
                          
                          <div style="padding:5px 5px 5px 5px;">
                              <telerik:RadGrid ID="rgSal" runat="server" AutoGenerateColumns="False" 
                                  CellSpacing="0" GridLines="None" GroupingEnabled="False" 
                                  onitemcommand="rgSal_ItemCommand" Skin="Office2010Silver" 
                                  onitemdatabound="rgSal_ItemDataBound">
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
                                       
                                          <telerik:GridBoundColumn DataField="SalStartDate" DataFormatString="{0:dd MMM yyyy}" 
                                              DataType="System.DateTime" FilterControlAltText="Filter clnLevel column" 
                                              HeaderText="Start Date" UniqueName="clnSalStartDate">
                                              <HeaderStyle HorizontalAlign="Center" Width="120px" />
                                          </telerik:GridBoundColumn>
                                        
                                          <telerik:GridBoundColumn DataField="SalaryAmount" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Salary Amount" 
                                              UniqueName="clnSalaryAmount" DataType="System.Double" DataFormatString="{0:#,#0.00}">
                                              <HeaderStyle HorizontalAlign="Center" Width="120px" />
                                          </telerik:GridBoundColumn>
                                          <telerik:GridBoundColumn DataField="SalaryPercentage" 
                                              FilterControlAltText="Filter clnLevel column" DataType="System.Double"
                                              HeaderText="Percentage (%)" UniqueName="clnSalaryPercentage" DataFormatString="{0:#0.00}">
                                              <HeaderStyle HorizontalAlign="Center" Width="100px" />
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
                                  </MasterTableView>
                                  <FilterMenu EnableImageSprites="False">
                                  </FilterMenu>
                              </telerik:RadGrid>
                          </div>

                          
                          </td>
                    </tr>
     </table>
       </asp:Panel>
       </div>
       <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Panel1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="NotifyInfo" />
                    <telerik:AjaxUpdatedControl ControlID="NotifyWarn" />
                    <telerik:AjaxUpdatedControl ControlID="Panel1" 
                        LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
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
