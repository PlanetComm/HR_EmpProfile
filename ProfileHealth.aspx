<%@ Page Title="" Language="C#" MasterPageFile="~/HR_Profile.Master" AutoEventWireup="true" CodeBehind="ProfileHealth.aspx.cs" Inherits="HR_EmpProfile.ProfileHealth" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
<div style="vertical-align:top;">
    <asp:Panel ID="Panel1" runat="server">
   <table border="0" cellpadding="0" cellspacing="0" width="100%">
           <tr>
<td  colspan="2" align="right" style="background:#ffffff;padding-bottom:10px;"> 
    
    <img src="img/h_EmpHealth.png" />
    
</td>
</tr>
           <tr>
<td class="tdLeft">
    Type</td>
    <td class="tdRight" style="height:25px;">
     
     

        <asp:RadioButton ID="chkAnn" runat="server" Font-Bold="True" Font-Size="12px" 
            Text="Annual Check" GroupName="Check" />
        &nbsp;<asp:RadioButton ID="chkSelf" runat="server" Font-Bold="True" Font-Size="12px" 
            Text="Self Check" GroupName="Check" />
             
     

        </td>
</tr>
                    <tr>
                        <td class="tdLeft">
                            Use Visit</td>
                        <td class="tdRight" style="height:25px;">
                            <asp:CheckBox ID="chkYes" runat="server" Font-Bold="True" Font-Size="15px" 
                                ForeColor="#333399" Text="   Yes" />
                        </td>
                    </tr>
                    <tr>
                        <td class="tdLeft">
                            From</td>
                        <td class="tdRight">
                           
                           <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
    <td class="tdRightFM">
        <telerik:RadDatePicker ID="dtpHeaFrom" Runat="server" Culture="en-US" 
            MinDate="1900-01-01" ShowPopupOnFocus="True" Skin="Metro" Width="255px">
            <Calendar Skin="Metro" UseColumnHeadersAsSelectors="False" 
                UseRowHeadersAsSelectors="False" ViewSelectorText="x">
            </Calendar>
            <DateInput DateFormat="dd MMM yyyy" DisplayDateFormat="dd MMM yyyy" 
                DisplayText="" LabelWidth="40%" type="text" value="">
            </DateInput>
            <DatePopupButton HoverImageUrl="" ImageUrl="" />
        </telerik:RadDatePicker>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" 
            ControlToValidate="dtpHeaFrom" Display="Dynamic" ErrorMessage="From" 
            Font-Size="8px" ValidationGroup="Hea">**</asp:RequiredFieldValidator>
        </td>
       <td class="tdLeftM">
           To</td>
       <td class="tdRightm">
           <telerik:RadDatePicker ID="dtpHeaTo" Runat="server" Culture="en-US" 
               MinDate="1900-01-01" ShowPopupOnFocus="True" Skin="Metro" Width="255px">
               <Calendar Skin="Metro" UseColumnHeadersAsSelectors="False" 
                   UseRowHeadersAsSelectors="False" ViewSelectorText="x">
               </Calendar>
               <DateInput DateFormat="dd MMM yyyy" DisplayDateFormat="dd MMM yyyy" 
                   DisplayText="" LabelWidth="40%" type="text" value="">
               </DateInput>
               <DatePopupButton HoverImageUrl="" ImageUrl="" />
           </telerik:RadDatePicker>
           <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" 
               ControlToValidate="dtpHeaTo" Display="Dynamic" ErrorMessage="To" 
               Font-Size="8px" ValidationGroup="Hea">**</asp:RequiredFieldValidator>
        </td>
    </tr>
    </table>

                           </td>
                    </tr>
                    <tr>
                        <td class="tdLeft">
                            Hospital</td>
                        <td class="tdRight">
                           
                            <telerik:RadTextBox ID="txtHospital" Runat="server" MaxLength="100" 
                                Skin="Metro" Width="255px">
                            </telerik:RadTextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator23" runat="server" 
                                ControlToValidate="txtHospital" Display="Dynamic" ErrorMessage="Hospital" 
                                Font-Size="8px" ValidationGroup="Hea">**</asp:RequiredFieldValidator>

                           </td>
                    </tr>
                    <tr>
                        <td class="tdLeft" valign="top">
                            Comment</td>
                        <td class="tdRight">
                            <telerik:RadTextBox ID="txtComment" Runat="server" MaxLength="1000" Rows="4" 
                                Skin="Metro" TextMode="MultiLine" Width="770px">
                            </telerik:RadTextBox>
                        </td>
           </tr>
           <tr>
               <td class="tdLeft" valign="top">
                   &nbsp;</td>
               <td class="tdRight">
                   <asp:ValidationSummary ID="ValidationSummary1" runat="server" Font-Size="10px" 
                       ValidationGroup="Hea" />
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
            onclick="btnAdd_Click" ValidationGroup="Hea" />
             
     

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
                        <td  colspan="2">
                          
                          <div style="padding:5px 5px 5px 5px;">
                              <telerik:RadGrid ID="rgHea" runat="server" AutoGenerateColumns="False" 
                                  CellSpacing="0" GridLines="None" GroupingEnabled="False" 
                                  onitemcommand="rgHea_ItemCommand" Skin="Office2010Silver">
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

                                             <telerik:GridBoundColumn DataField="HeaType" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Type" 
                                              UniqueName="clnHeaType" >
                                              <HeaderStyle HorizontalAlign="Center" Width="80px" />
                                          </telerik:GridBoundColumn>

                                          <telerik:GridBoundColumn DataField="HeaUse" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Visit" 
                                              UniqueName="clnHeaUse" >
                                              <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                          </telerik:GridBoundColumn>
                                       
                                          <telerik:GridBoundColumn DataField="HeaFrom" DataFormatString="{0:dd MMM yyyy}" 
                                              DataType="System.DateTime" FilterControlAltText="Filter clnLevel column" 
                                              HeaderText="From" UniqueName="clnHeaFrom">
                                              <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                          </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="HeaTo" DataFormatString="{0:dd MMM yyyy}" 
                                              DataType="System.DateTime" FilterControlAltText="Filter clnLevel column" 
                                              HeaderText="To" UniqueName="clnHeaTo">
                                              <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                          </telerik:GridBoundColumn>
                                        
                                          <telerik:GridBoundColumn DataField="HeaHospital" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Hostipal" 
                                              UniqueName="clnHeaHospital" >
                                              <HeaderStyle HorizontalAlign="Center" Width="120px" />
                                          </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="HeaDetail" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Detail" 
                                              UniqueName="clnHeaDetail" >
                                              <HeaderStyle HorizontalAlign="Center" Width="180px" />
                                          </telerik:GridBoundColumn>

                                          <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" 
                                              ConfirmText="Do you want to Delete ?" 
                                              FilterControlAltText="Filter clnDel column" UniqueName="clnDel">
                                              <HeaderStyle Width="30px" />
                                              <ItemStyle HorizontalAlign="Center" />
                                          </telerik:GridButtonColumn>

                                              <telerik:GridBoundColumn DataField="HeaTypeRE" 
                                              FilterControlAltText="Filter clnLevel column" Display="false"
                                              UniqueName="clnHeaTypeRE" >
                                          </telerik:GridBoundColumn>

                                              <telerik:GridBoundColumn DataField="HeaUseRE" 
                                              FilterControlAltText="Filter clnLevel column" Display="false"
                                              UniqueName="clnHeaUseRE" >
                                          </telerik:GridBoundColumn>
                                        
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
