<%@ Page Title="" Language="C#" MasterPageFile="~/HR_Profile.Master" AutoEventWireup="true" CodeBehind="ProfileGeneral.aspx.cs" Inherits="HR_EmpProfile.ProfileGeneral" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    
    <div style="vertical-align:top;">
    <asp:Panel ID="Panel1" runat="server">
   <table border="0" cellpadding="0" cellspacing="0" width="100%">
           <tr>
<td  colspan="2" align="right" style="background:#ffffff;padding-bottom:10px;"> 
    
    <img src="img/h_EmpGer.png" />
    
</td>
</tr>
           <tr>
<td class="tdLeft">
    Foreign Language</td>
    <td class="tdRight">

        <telerik:RadTextBox ID="txtGerLang" Runat="server" MaxLength="100" Skin="Metro" 
            Width="680px">
        </telerik:RadTextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" 
            ControlToValidate="txtGerLang" Display="Dynamic" ErrorMessage="Foreign Language" 
            Font-Size="8px" ValidationGroup="Ge">**</asp:RequiredFieldValidator>
             
     

        </td>
</tr>
                    <tr>
                        <td class="tdLeft">
                            Speaking</td>
                        <td class="tdRight">
                            <telerik:RadRating ID="ratSpeaking" Runat="server" Skin="Office2007">
                            </telerik:RadRating>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdLeft" valign="top">
                            Reading</td>
                        <td class="tdRight">
                            
                            <telerik:RadRating ID="ratReading" Runat="server" Skin="Office2007">
                            </telerik:RadRating>
                            
                            </td>
                    </tr>
                    <tr>
                        <td class="tdLeft" valign="top">
                            Writing</td>
                        <td class="tdRight">
                            <telerik:RadRating ID="ratWriting" Runat="server" Skin="Office2007">
                            </telerik:RadRating>
                        </td>
           </tr>
           <tr>
               <td class="tdLeft" valign="top">
                   Understanding</td>
               <td class="tdRight">
                   <telerik:RadRating ID="ratUnderstanding" Runat="server" Skin="Office2007">
                   </telerik:RadRating>
               </td>
           </tr>
                    <tr>
                        <td class="tdLeft" valign="top">
                            Special Skill</td>
                        <td class="tdRight">
                            <telerik:RadTextBox ID="txtSpec" Runat="server" MaxLength="100" Skin="Metro" 
                                Width="680px">
                            </telerik:RadTextBox>
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
            onclick="btnAdd_Click" ValidationGroup="Ge" />
             
     

                  </td>
                        <td align="right" style="width:50%;">&nbsp;</td>
                        </tr>
                        </table>   
       

                           </td>
                    </tr>
                    
                    <tr>
                        <td colspan="2">
                          
                          <div style="padding:5px 5px 5px 5px;">
                              <telerik:RadGrid ID="rgGe" runat="server" AutoGenerateColumns="False" 
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
                                     
                                              <telerik:GridBoundColumn DataField="GenForeLang" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Foreign Language" 
                                              UniqueName="clnGenForeLang">
                                              <HeaderStyle HorizontalAlign="Center" Width="200px" />
                                          </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="GenSpeaking" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Speaking" 
                                              UniqueName="clnGenSpeaking">
                                              <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                          </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="GenReading" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Reading" 
                                              UniqueName="clnGenReading">
                                              <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                          </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="GenWriting" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Writing" 
                                              UniqueName="clnGenWriting">
                                              <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                          </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="GenUnderstanding" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Understanding" 
                                              UniqueName="clnGenUnderstanding">
                                              <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                          </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="GenSpecialSkill" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Special Skill" 
                                              UniqueName="clnGenSpecialSkill">
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

                    <tr>
                        <td colspan="2" align="right">
                            <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/img/Save.png" 
                                onclick="btnSave_Click" />
                            &nbsp;<asp:ImageButton ID="btnReset" runat="server" ImageUrl="~/img/Reset.png" 
                                onclick="btnReset_Click" />
                          
                          </td>
                    </tr>
           <tr>
               <td colspan="2">
                   <br />
                   <table border="0" cellpadding="0" cellspacing="0" width="100%">
                       <tr>
                           <td class="tdLeftHD" valign="top">
                               Certificate<br />
                               <br />
                           </td>
                           <td class="tdRight">
                               <asp:CheckBox ID="chkToeic" runat="server" Text="Toeic" />
                               &nbsp;&nbsp;&nbsp;<asp:Label ID="Label1" runat="server" Text="คะแนน"></asp:Label>
                               &nbsp;<telerik:RadNumericTextBox ID="numToeic" Runat="server" Skin="Metro" 
                                   Width="60px">
                               </telerik:RadNumericTextBox>
                               <asp:Label ID="Label2" runat="server" Text="/ 990"></asp:Label>
                               <br />
                               <asp:CheckBox ID="chkToelf" runat="server" Text="Toelf" />
                               &nbsp;&nbsp;&nbsp;<asp:Label ID="Label3" runat="server" Text="คะแนน"></asp:Label>
                               &nbsp;<telerik:RadNumericTextBox ID="numToelf" Runat="server" Skin="Metro" 
                                   Width="60px">
                               </telerik:RadNumericTextBox>
                               <asp:Label ID="Label4" runat="server" Text="/ 677"></asp:Label>
                               <br />
                               <asp:CheckBox ID="chkIelts" runat="server" Text="Ielts" />
                               &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label5" runat="server" Text="คะแนน"></asp:Label>
                               &nbsp;<telerik:RadNumericTextBox ID="numIelts" Runat="server" Skin="Metro" 
                                   Width="60px">
                               </telerik:RadNumericTextBox>
                               <asp:Label ID="Label6" runat="server" Text="/ 9"></asp:Label>
                           </td>
                       </tr>
                       <tr>
                           <td class="tdLeft" valign="top">
                               &nbsp;</td>
                           <td class="tdRight">
                               &nbsp;</td>
                       </tr>
                       <tr>
                           <td class="tdLeftHD" valign="top">
                               Professional License / Certificate</td>
                           <td class="tdRight">
                               <asp:CheckBox ID="chkCPA" runat="server" 
                                   Text="CPA : Certified Public Accountant" />
                               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label7" runat="server" Text="No."></asp:Label>
                               &nbsp;<telerik:RadTextBox ID="txtCPANo" Runat="server" Skin="Metro" Width="150px">
                               </telerik:RadTextBox>
                               &nbsp;<asp:Label ID="Label8" runat="server" Text="Exp.Date"></asp:Label>
                               &nbsp;<telerik:RadDatePicker ID="dtpCPAExp" Runat="server" Skin="Metro">
                                   <Calendar Skin="Metro" UseColumnHeadersAsSelectors="False" 
                                       UseRowHeadersAsSelectors="False">
                                   </Calendar>
                                   <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" 
                                       LabelWidth="40%">
                                   </DateInput>
                                   <DatePopupButton HoverImageUrl="" ImageUrl="" />
                               </telerik:RadDatePicker>
                               <br />
                               <asp:CheckBox ID="chkLPP" runat="server" 
                                   Text="License for Professional Practice " />
                               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label9" runat="server" Text="No."></asp:Label>
                               &nbsp;<telerik:RadTextBox ID="txtLPPNo" Runat="server" Skin="Metro" Width="150px">
                               </telerik:RadTextBox>
                               &nbsp;<asp:Label ID="Label10" runat="server" Text="Exp.Date"></asp:Label>
                               &nbsp;<telerik:RadDatePicker ID="dtpLPPExp" Runat="server" Skin="Metro">
                                   <Calendar Skin="Metro" UseColumnHeadersAsSelectors="False" 
                                       UseRowHeadersAsSelectors="False">
                                   </Calendar>
                                   <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" 
                                       LabelWidth="40%">
                                   </DateInput>
                                   <DatePopupButton HoverImageUrl="" ImageUrl="" />
                               </telerik:RadDatePicker>
                               &nbsp;<br /><asp:CheckBox ID="chkWP" runat="server" Text="Work Permit" />
                               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label11" runat="server" 
                                   Text="No."></asp:Label>
                               &nbsp;<telerik:RadTextBox ID="txtWPNo" Runat="server" Skin="Metro" Width="150px">
                               </telerik:RadTextBox>
                               &nbsp;<asp:Label ID="Label12" runat="server" Text="Exp.Date"></asp:Label>
                               &nbsp;<telerik:RadDatePicker ID="dtpWPExp" Runat="server" Skin="Metro">
                                   <Calendar Skin="Metro" UseColumnHeadersAsSelectors="False" 
                                       UseRowHeadersAsSelectors="False">
                                   </Calendar>
                                   <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" 
                                       LabelWidth="40%">
                                   </DateInput>
                                   <DatePopupButton HoverImageUrl="" ImageUrl="" />
                               </telerik:RadDatePicker>
                               &nbsp;</td>
                       </tr>
                   </table>
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
