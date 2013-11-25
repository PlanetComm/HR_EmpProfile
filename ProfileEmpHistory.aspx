<%@ Page Title="" Language="C#" MasterPageFile="~/HR_Profile.Master" AutoEventWireup="true" CodeBehind="ProfileEmpHistory.aspx.cs" Inherits="HR_EmpProfile.ProfileEmpHistory" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div style="vertical-align:top;">
    <asp:Panel ID="Panel1" runat="server">
   <table border="0" cellpadding="0" cellspacing="0" width="100%">
           <tr>
<td  colspan="2" align="right" style="background:#ffffff;padding-bottom:10px;"> 
    
    <img src="img/h_EmpHistory.png" />
    
</td>
</tr>
           <tr>
<td class="tdLeft">
    Company Name</td>
    <td class="tdRight">
     
     

        <telerik:RadTextBox ID="txtHisComName" Runat="server" MaxLength="100" 
            Skin="Metro" Width="750px">
        </telerik:RadTextBox>
     
     

        <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" 
            ControlToValidate="txtHisComName" Display="Dynamic" ErrorMessage="Company Name" 
            Font-Size="8px" ValidationGroup="His">**</asp:RequiredFieldValidator>
     
     

        &nbsp;
             
     

        </td>
</tr>
                    <tr>
                        <td class="tdLeft">
                            From</td>
                        <td class="tdRight">
                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td class="tdRightFM">
                                        <telerik:RadDatePicker ID="dtpHisFrom" Runat="server" Culture="en-US" 
                                            MinDate="1900-01-01" ShowPopupOnFocus="True" Skin="Metro" Width="255px">
                                            <Calendar Skin="Metro" UseColumnHeadersAsSelectors="False" 
                                                UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                                            </Calendar>
                                            <DateInput DateFormat="dd MMM yyyy" DisplayDateFormat="dd MMM yyyy" 
                                                DisplayText="" LabelWidth="40%" type="text" value="">
                                            </DateInput>
                                            <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                        </telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" 
                                            ControlToValidate="dtpHisFrom" Display="Dynamic" ErrorMessage="From" 
                                            Font-Size="8px" ValidationGroup="His">**</asp:RequiredFieldValidator>
                                    </td>
                                    <td class="tdLeftM">
                                        To</td>
                                    <td class="tdRightm">
                                        <telerik:RadDatePicker ID="dtpHisTo" Runat="server" Culture="en-US" 
                                            MinDate="1900-01-01" ShowPopupOnFocus="True" Skin="Metro" Width="255px">
                                            <Calendar Skin="Metro" UseColumnHeadersAsSelectors="False" 
                                                UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                                            </Calendar>
                                            <DateInput DateFormat="dd MMM yyyy" DisplayDateFormat="dd MMM yyyy" 
                                                DisplayText="" LabelWidth="40%" type="text" value="">
                                            </DateInput>
                                            <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                        </telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" 
                                            ControlToValidate="dtpHisTo" Display="Dynamic" ErrorMessage="To" 
                                            Font-Size="8px" ValidationGroup="His">**</asp:RequiredFieldValidator>
                                        <asp:CheckBox ID="chkPresent" runat="server" BackColor="#FFFFCC" 
                                            Font-Bold="True" Font-Size="13px" ForeColor="#333399" Text="Present" 
                                            AutoPostBack="True" oncheckedchanged="chkPresent_CheckedChanged" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdLeft">
                            Employment Type
                        </td>
                        <td class="tdRight">
                            <telerik:RadComboBox ID="cbEmpType" Runat="server" Skin="Metro" Width="250px">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="F - Full Time" Value="F" />
                                    <telerik:RadComboBoxItem runat="server" Text="T - Temporary" Value="T" />
                                    <telerik:RadComboBoxItem runat="server" Text="C - Contract" Value="C" />
                                </Items>
                            </telerik:RadComboBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator27" runat="server" 
                                ControlToValidate="numHisStart" Display="Dynamic" ErrorMessage="Salary Start" 
                                Font-Size="8px" ValidationGroup="His">**</asp:RequiredFieldValidator>
                        </td>
           </tr>
                    <tr>
                        <td class="tdLeft">
                            Address</td>
                        <td class="tdRight">
                           
                            <telerik:RadTextBox ID="txtHisAddress" Runat="server" MaxLength="100" 
                                Skin="Metro" Width="750px">
                            </telerik:RadTextBox>

                           </td>
                    </tr>
                    <tr>
                        <td class="tdLeft">
                            Salraly Start</td>
                        <td class="tdRight">
                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td class="tdRightFM">
                                        <telerik:RadNumericTextBox ID="numHisStart" Runat="server" Skin="Metro" 
                                            Width="350px">
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" 
                                            ControlToValidate="numHisStart" Display="Dynamic" 
                                            ErrorMessage="Salary Start" Font-Size="8px" ValidationGroup="His">**</asp:RequiredFieldValidator>
                                    </td>
                                    <td class="tdLeftM">
                                        Salraly End</td>
                                    <td class="tdRightm">
                                        <telerik:RadNumericTextBox ID="numHisEnd" Runat="server" Skin="Metro" 
                                            Width="230px">
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator24" runat="server" 
                                            ControlToValidate="numHisEnd" Display="Dynamic" ErrorMessage="Salary End" 
                                            Font-Size="8px" ValidationGroup="His">**</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            </table>
                        </td>
           </tr>
           <tr>
               <td class="tdLeft">
                   Position</td>
               <td class="tdRight">
                   <table border="0" cellpadding="0" cellspacing="0" width="100%">
                       <tr>
                           <td class="tdRightFM">
                               <telerik:RadTextBox ID="txtHisPosition" Runat="server" MaxLength="100" 
                                   Skin="Metro" Width="350px">
                               </telerik:RadTextBox>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator23" runat="server" 
                                   ControlToValidate="txtHisPosition" Display="Dynamic" 
                                   ErrorMessage="Position" Font-Size="8px" ValidationGroup="His">**</asp:RequiredFieldValidator>
                           </td>
                           <td class="tdLeftM">
                               Duties</td>
                           <td class="tdRightm">
                               <telerik:RadTextBox ID="txtHisDuties" Runat="server" MaxLength="100" 
                                   Skin="Metro" Width="230px">
                               </telerik:RadTextBox>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator25" runat="server" 
                                   ControlToValidate="txtHisDuties" Display="Dynamic" ErrorMessage="Duties" 
                                   Font-Size="8px" ValidationGroup="His">**</asp:RequiredFieldValidator>
                           </td>
                       </tr>
                   </table>
               </td>
           </tr>
           <tr>
               <td class="tdLeft">
                   Reason For Leaveing</td>
               <td class="tdRight">
                   <telerik:RadTextBox ID="txtHisReason" Runat="server" MaxLength="100" 
                       Skin="Metro" Width="750px">
                   </telerik:RadTextBox>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator26" runat="server" 
                       ControlToValidate="txtHisReason" Display="Dynamic" 
                       ErrorMessage="Reason for Leaving" Font-Size="8px" ValidationGroup="His">**</asp:RequiredFieldValidator>
               </td>
           </tr>
                    <tr>
                        <td class="tdLeft">
                            &nbsp;</td>
                        <td class="tdRight">
                           
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" Font-Size="10px" 
                                ValidationGroup="His" />

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
            onclick="btnAdd_Click" ValidationGroup="His" />
             
     

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
                        <td colspan="2">
                          
                          <div style="padding:5px 5px 5px 5px;">
                              <telerik:RadGrid ID="rgHis" runat="server" AutoGenerateColumns="False" 
                                  CellSpacing="0" GridLines="None" Skin="Office2010Silver" GroupingEnabled="False" 
                                  onitemcommand="rgEdu_ItemCommand">
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
                                          <telerik:GridBoundColumn DataField="HisComName" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Company name" 
                                              UniqueName="clnHisComName">
                                              <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                          </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="HisFrom" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="From" 
                                              UniqueName="clnHisFrom">
                                              <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                          </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="HisTo" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="To" 
                                              UniqueName="clnHisTo">
                                              <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                          </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="HisAddress" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Address" 
                                              UniqueName="clnHisAddress">
                                              <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                          </telerik:GridBoundColumn>

                                               <telerik:GridBoundColumn DataField="HisStart" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Start" DataType="System.Decimal" DataFormatString="{0:#,0}"
                                              UniqueName="clnHisStart">
                                              <HeaderStyle HorizontalAlign="Center" Width="120px" />
                                          </telerik:GridBoundColumn>

                                           <telerik:GridBoundColumn DataField="HisEnd" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="End" DataType="System.Decimal" DataFormatString="{0:#,0}"
                                              UniqueName="clnHisEnd">
                                              <HeaderStyle HorizontalAlign="Center" Width="120px" />
                                          </telerik:GridBoundColumn>

                                               <telerik:GridBoundColumn AllowFiltering="False" DataField="HisEmpType" 
                                              FilterControlAltText="Filter clnHisEmpType column" HeaderText="Type" 
                                              UniqueName="clnHisEmpType">
                                              <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                              <ItemStyle HorizontalAlign="Center" />
                                          </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="HisPosition" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Position" 
                                              UniqueName="clnHisPosition">
                                              <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                          </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="HisDuties" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Duties" 
                                              UniqueName="clnHisDuties">
                                              <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                          </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="HisReason" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Reason<br>For Leaving" 
                                              UniqueName="clnHisReason">
                                              <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                          </telerik:GridBoundColumn>

                                          <telerik:GridBoundColumn DataField="HisFromRe" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="From" Display="false"       
                                              UniqueName="clnHisFromRe" DataType="System.DateTime">
                                              <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                          </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="HisToRe" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="To" Display="false"
                                              UniqueName="clnHisToRe" DataType="System.DateTime">
                                              <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                          </telerik:GridBoundColumn>

                                              <telerik:GridBoundColumn DataField="IsPresent" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="IsPresent" Display="false" 
                                              UniqueName="clnIsPresent">
                                              <HeaderStyle HorizontalAlign="Center" Width="150px" />
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
