<%@ Page Title="" Language="C#" MasterPageFile="~/HR_Profile.Master" AutoEventWireup="true" CodeBehind="ProfileEva.aspx.cs" Inherits="HR_EmpProfile.ProfileEva" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

<div style="vertical-align:top;">
    <asp:Panel ID="Panel1" runat="server">
   <table border="0" cellpadding="0" cellspacing="0" width="100%">
           <tr>
<td  colspan="2" align="right" style="background:#ffffff;padding-bottom:10px;"> 
    
    <img src="img/h_EmpEvaluation.png" />
    
</td>
</tr>
           <tr>
<td class="tdLeft">
    Date of Evaluation</td>
    <td class="tdRight">
     
     

        <telerik:RadDatePicker ID="dtpEvaDate" Runat="server" Culture="en-US" 
            MinDate="1900-01-01" ShowPopupOnFocus="True" Skin="Metro" Width="255px">
            <Calendar Skin="Metro" UseColumnHeadersAsSelectors="False" 
                UseRowHeadersAsSelectors="False" ViewSelectorText="x">
            </Calendar>
            <DateInput DateFormat="dd MMM yyyy" DisplayDateFormat="dd MMM yyyy" 
                DisplayText="" LabelWidth="40%" type="text" value="">
            </DateInput>
            <DatePopupButton HoverImageUrl="" ImageUrl="" />
        </telerik:RadDatePicker>
             
     

        <asp:RequiredFieldValidator ID="RequiredFieldValidator23" runat="server" 
            ControlToValidate="dtpEvaDate" Display="Dynamic" ErrorMessage="Evaluation Date" 
            Font-Size="8px" ValidationGroup="Eva">**</asp:RequiredFieldValidator>
             
     

        </td>
</tr>
                    <tr>
                        <td class="tdLeft">
                            Type of Evaluation</td>
                        <td class="tdRight" >
                            <telerik:RadTextBox ID="txtEvaType" Runat="server" MaxLength="100" Skin="Metro" 
                                Width="250px">
                            </telerik:RadTextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator24" runat="server" 
                                ControlToValidate="txtEvaType" Display="Dynamic" ErrorMessage="Evaluation Type" 
                                Font-Size="8px" ValidationGroup="Eva">**</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdLeft">
                            Evaluation Point</td>
                        <td class="tdRight">
                           
                           <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
    <td class="tdRightFM">
        <telerik:RadNumericTextBox ID="numPoint" Runat="server" Width="250px">
            <NumberFormat DecimalDigits="3" ZeroPattern="n" />
        </telerik:RadNumericTextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" 
            ControlToValidate="numPoint" Display="Dynamic" ErrorMessage="Evaluation Point" 
            Font-Size="8px" ValidationGroup="Eva">**</asp:RequiredFieldValidator>
        </td>
       <td class="tdLeftM">
           Evaluation Grade</td>
       <td class="tdRightm">
           <telerik:RadTextBox ID="txtEvaGrade" Runat="server" MaxLength="100" 
               Skin="Metro" Width="250px">
           </telerik:RadTextBox>
           <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" 
               ControlToValidate="txtEvaGrade" Display="Dynamic" ErrorMessage="Evaluation Grade" 
               Font-Size="8px" ValidationGroup="Eva">**</asp:RequiredFieldValidator>
        </td>
    </tr>
    </table>

                           </td>
                    </tr>
                    <tr>
                        <td class="tdLeft" valign="top">
                            Comment</td>
                        <td class="tdRight">
                            <telerik:RadTextBox ID="txtEvaRemark" Runat="server" MaxLength="1000" Rows="4" 
                                Skin="Metro" TextMode="MultiLine" Width="770px">
                            </telerik:RadTextBox>
                        </td>
           </tr>
           <tr>
               <td class="tdLeft" valign="top">
                   &nbsp;</td>
               <td class="tdRight">
                   <asp:ValidationSummary ID="ValidationSummary1" runat="server" Font-Size="10px" 
                       ValidationGroup="Eva" />
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
            onclick="btnAdd_Click" ValidationGroup="Eva" />
             
     

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
                              <telerik:RadGrid ID="rgEva" runat="server" AutoGenerateColumns="False" 
                                  CellSpacing="0" GridLines="None" GroupingEnabled="False" 
                                  onitemcommand="rgEva_ItemCommand" Skin="Office2010Silver">
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

                                        <telerik:GridBoundColumn DataField="EvaDate" DataFormatString="{0:dd MMM yyyy}" 
                                              DataType="System.DateTime" FilterControlAltText="Filter clnLevel column" 
                                              HeaderText="Date" UniqueName="clnEvaDate">
                                              <HeaderStyle HorizontalAlign="Center" Width="120px" />
                                          </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="EvaType" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Type" 
                                              UniqueName="clnEvaType" >
                                              <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                          </telerik:GridBoundColumn>

                                          <telerik:GridBoundColumn DataField="EvaPoint" DataType="System.Double" DataFormatString="{0:0.000}"
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Point" 
                                              UniqueName="clnEvaPoint" >
                                              <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                          </telerik:GridBoundColumn>
                                       
                                        
                                          <telerik:GridBoundColumn DataField="EvaGrade" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Grade" 
                                              UniqueName="clnEvaGrade" >
                                              <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                          </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="EvaRemark" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Remark" 
                                              UniqueName="clnEvaRemark" >
                                              <HeaderStyle HorizontalAlign="Center" Width="180px" />
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
