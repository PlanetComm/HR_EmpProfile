<%@ Page Title="" Language="C#" MasterPageFile="~/HR_Profile.Master" AutoEventWireup="true" CodeBehind="ProfileEducation.aspx.cs" Inherits="HR_EmpProfile.ProfileEducation" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    
    <div style="vertical-align:top;">
    <asp:Panel ID="Panel1" runat="server">
   <table border="0" cellpadding="0" cellspacing="0" width="100%">
           <tr>
<td  colspan="2" align="right" style="background:#ffffff;padding-bottom:10px;"> 
    
    <img src="img/h_EmpEdu.png" />
    
</td>
</tr>
           <tr>
<td class="tdLeft">
    Level </td>
    <td class="tdRight">
     
     

        <telerik:RadComboBox ID="cbEduLevel" Runat="server" DataTextField="DESC" 
            DataValueField="ID" Skin="Metro" Width="255px">
        </telerik:RadComboBox>
     
     

        <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" 
            ControlToValidate="cbEduLevel" Display="Dynamic" ErrorMessage="Level" 
            Font-Size="8px" ValidationGroup="Edu">**</asp:RequiredFieldValidator>
     
     

        &nbsp;
             
     

        </td>
</tr>
                    <tr>
                        <td class="tdLeft">
                            Name of Institution</td>
                        <td class="tdRight">
                            <telerik:RadTextBox ID="txtEduName" Runat="server"  
                                MaxLength="100" Skin="Metro" 
                                Width="680px">
                            </telerik:RadTextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" 
                                ControlToValidate="txtEduName" Display="Dynamic" ErrorMessage="Name of Institution" 
                                Font-Size="8px" ValidationGroup="Edu">**</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdLeft">
                            From</td>
                        <td class="tdRight">
                            
                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
    <td class="tdRightFM">
        <telerik:RadDatePicker ID="dtpEduFrom" Runat="server" 
            Culture="en-US" MinDate="1900-01-01" Skin="Metro" 
            Width="255px" ShowPopupOnFocus="True">
            <Calendar Skin="Metro" UseColumnHeadersAsSelectors="False" 
                UseRowHeadersAsSelectors="False" ViewSelectorText="x">
            </Calendar>
            <DateInput DateFormat="dd MMM yyyy" 
                DisplayDateFormat="dd MMM yyyy" DisplayText="" LabelWidth="40%" type="text" 
                value="">
            </DateInput>
            <DatePopupButton HoverImageUrl="" ImageUrl="" />
        </telerik:RadDatePicker>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" 
            ControlToValidate="dtpEduFrom" Display="Dynamic" ErrorMessage="From" 
            Font-Size="8px" ValidationGroup="Edu">**</asp:RequiredFieldValidator>
        </td>
       <td class="tdLeftM">
           To</td>
       <td class="tdRightm">
           <telerik:RadDatePicker ID="dtpEduTo" Runat="server" 
               Culture="en-US" MinDate="1900-01-01" Skin="Metro" 
               Width="255px" ShowPopupOnFocus="True">
               <Calendar Skin="Metro" UseColumnHeadersAsSelectors="False" 
                   UseRowHeadersAsSelectors="False" ViewSelectorText="x">
               </Calendar>
               <DateInput DateFormat="dd MMM yyyy" 
                   DisplayDateFormat="dd MMM yyyy" DisplayText="" LabelWidth="40%" type="text" 
                   value="">
               </DateInput>
               <DatePopupButton HoverImageUrl="" ImageUrl="" />
           </telerik:RadDatePicker>
           <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" 
               ControlToValidate="dtpEduTo" Display="Dynamic" ErrorMessage="To" 
               Font-Size="8px" ValidationGroup="Edu">**</asp:RequiredFieldValidator>
        </td>
    </tr>
    </table>
                            
                            </td>
                    </tr>
                    <tr>
                        <td class="tdLeft">
                            Diploma / Degree</td>
                        <td class="tdRight">
                           
                           <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
    <td class="tdRightFM">
        <telerik:RadTextBox ID="txtEduDegree" Runat="server" MaxLength="100" Skin="Metro" 
            Width="255px">
        </telerik:RadTextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" 
            ControlToValidate="txtEduDegree" Display="Dynamic" ErrorMessage="Diploma / Degree" 
            Font-Size="8px" ValidationGroup="Edu">**</asp:RequiredFieldValidator>
        </td>
       <td class="tdLeftM">
           Detail (Major/Honour/Etc)</td>
       <td class="tdRightm">
           <telerik:RadTextBox ID="txtEduMajor" Runat="server" MaxLength="100" Skin="Metro" 
               Width="255px">
           </telerik:RadTextBox>
           <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" 
               ControlToValidate="txtEduMajor" Display="Dynamic" ErrorMessage="Details (Major/Honour/Etc)" 
               Font-Size="8px" ValidationGroup="Edu">**</asp:RequiredFieldValidator>
        </td>
    </tr>
    </table>

                           </td>
                    </tr>
                    <tr>
                        <td class="tdLeft">
                            &nbsp;</td>
                        <td class="tdRight">
                           
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" Font-Size="10px" 
                                ValidationGroup="Edu" />

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
            onclick="btnAdd_Click" ValidationGroup="Edu" />
             
     

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
                              <telerik:RadGrid ID="rgEdu" runat="server" AutoGenerateColumns="False" 
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
                                          <telerik:GridBoundColumn DataField="EduLevelDesc" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Level" 
                                              UniqueName="clnEduLevel">
                                              <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                          </telerik:GridBoundColumn>

                                              <telerik:GridBoundColumn DataField="EduName" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Name of Institution" 
                                              UniqueName="clnEduName">
                                              <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                          </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="EduFrom" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="From" 
                                              UniqueName="clnEduFrom" DataFormatString="{0:dd MMM yyyy}" 
                                              DataType="System.DateTime">
                                              <HeaderStyle HorizontalAlign="Center" Width="70px" />
                                          </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="EduTo" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="To" 
                                              UniqueName="clnEduTo" DataFormatString="{0:dd MMM yyyy}" 
                                              DataType="System.DateTime">
                                              <HeaderStyle HorizontalAlign="Center" Width="70px" />
                                          </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="EduDegree" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Diploma / Degree" 
                                              UniqueName="clnEduDegree">
                                              <HeaderStyle HorizontalAlign="Center" Width="120px" />
                                          </telerik:GridBoundColumn>

                                               <telerik:GridBoundColumn DataField="EduMajor" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Details (Major/Honour/Etc)" 
                                              UniqueName="clnEduMajor">
                                              <HeaderStyle HorizontalAlign="Center" Width="120px" />
                                          </telerik:GridBoundColumn>

                                          <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" 
                                              ConfirmText="Do you want to Delete ?" 
                                              FilterControlAltText="Filter clnDel column" UniqueName="clnDel">
                                              <HeaderStyle Width="30px" />
                                              <ItemStyle HorizontalAlign="Center" />
                                          </telerik:GridButtonColumn>

                                          <telerik:GridBoundColumn DataField="EduSort" Display="False" 
                                              FilterControlAltText="Filter clnSort column" HeaderText="Sort" 
                                              UniqueName="clnEduSort">
                                          </telerik:GridBoundColumn>

                                          <telerik:GridBoundColumn DataField="EduLevelID" Display="False" 
                                              FilterControlAltText="Filter clnLevelID column" HeaderText="LevelID" 
                                              UniqueName="clnEduLevelID">
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
