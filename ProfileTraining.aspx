<%@ Page Title="" Language="C#" MasterPageFile="~/HR_Profile.Master" AutoEventWireup="true" CodeBehind="ProfileTraining.aspx.cs" Inherits="HR_EmpProfile.ProfileTraining" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div style="vertical-align:top;">
    <asp:Panel ID="Panel1" runat="server">
   <table border="0" cellpadding="0" cellspacing="0" width="100%">
           <tr>
<td  colspan="2" align="right" style="background:#ffffff;padding-bottom:10px;"> 
    
    <img src="img/h_EmpTr.png" />
    
</td>
</tr>
           <tr>
<td class="tdLeft">
    Date of Training</td>
    <td class="tdRight">

        <telerik:RadDatePicker ID="dtpDate" Runat="server" Skin="Metro" Width="250px">
            <Calendar Skin="Metro" UseColumnHeadersAsSelectors="False" 
                UseRowHeadersAsSelectors="False">
            </Calendar>
            <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" 
                LabelWidth="40%">
            </DateInput>
            <DatePopupButton HoverImageUrl="" ImageUrl="" />
        </telerik:RadDatePicker>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" 
            ControlToValidate="dtpDate" Display="Dynamic" ErrorMessage="Date of Training" 
            Font-Size="8px" ValidationGroup="Tr">**</asp:RequiredFieldValidator>
             
     

        </td>
</tr>
                    <tr>
                        <td class="tdLeft">
                            Name of Teacher / Institution</td>
                        <td class="tdRight">
                            <telerik:RadTextBox ID="txtTeacher" Runat="server" MaxLength="50" Skin="Metro" 
                                Width="400px">
                            </telerik:RadTextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" 
                                ControlToValidate="txtTeacher" Display="Dynamic" ErrorMessage="Teacher" 
                                Font-Size="8px" ValidationGroup="Tr">**</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdLeft">
                            Name of Institution</td>
                        <td class="tdRight">
                            <telerik:RadTextBox ID="txtName" Runat="server" MaxLength="100" Skin="Metro" 
                                Width="680px">
                            </telerik:RadTextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" 
                                ControlToValidate="txtName" Display="Dynamic" 
                                ErrorMessage="Name of Institution" Font-Size="8px" ValidationGroup="Tr">**</asp:RequiredFieldValidator>
                        </td>
           </tr>
                    <tr>
                        <td class="tdLeft" valign="top">
                            Courses / Details</td>
                        <td class="tdRight">
                            
                            <telerik:RadTextBox ID="txtDetail" Runat="server" MaxLength="100" Rows="3" 
                                Skin="Metro" TextMode="MultiLine" Width="680px">
                            </telerik:RadTextBox>
                            
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" 
                                ControlToValidate="txtDetail" Display="Dynamic" 
                                ErrorMessage="Courses / Details" Font-Size="8px" ValidationGroup="Tr">**</asp:RequiredFieldValidator>
                            
                            </td>
                    </tr>
                    <tr>
                        <td class="tdLeft">
                            &nbsp;</td>
                        <td class="tdRight">
                           
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" Font-Size="10px" 
                                ValidationGroup="Tr" />

                           </td>
                    </tr>
                    <tr>
                        <td class="tdLeft">
                            &nbsp;</td>
                        <td align="left">
                        
                        <table border="0" cellpadding="0" cellspacing="0" width="800px">
                        <tr>
                        <td align="left" style="width:50%;"> 
             
     

        <asp:ImageButton ID="btnAdd" runat="server" ImageUrl="~/img/add.png" 
            onclick="btnAdd_Click" ValidationGroup="Tr" />
             
     

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
                              <telerik:RadGrid ID="rgTr" runat="server" AutoGenerateColumns="False" 
                                  CellSpacing="0" GridLines="None" Skin="Office2010Silver" GroupingEnabled="False" 
                                  onitemcommand="rgTr_ItemCommand">
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
                                          <telerik:GridBoundColumn DataField="TrYear" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Date of Training / Year" 
                                              UniqueName="clnTrYear" DataFormatString="{0:dd MMM yyyy}" 
                                              DataType="System.DateTime">
                                              <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                          </telerik:GridBoundColumn>

                                                   <telerik:GridBoundColumn DataField="TrTeacher" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Name of Teacher" 
                                              UniqueName="clnTrTeacher">
                                              <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                          </telerik:GridBoundColumn>

                                              <telerik:GridBoundColumn DataField="TrName" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Name of Institution" 
                                              UniqueName="clnTrName">
                                              <HeaderStyle HorizontalAlign="Center" Width="200px" />
                                          </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="TrDetails" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Details (Major/Honour/Etc)" 
                                              UniqueName="clnTrDetails">
                                              <HeaderStyle HorizontalAlign="Center" Width="200px" />
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
