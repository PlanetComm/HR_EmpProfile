<%@ Page Title="" Language="C#" MasterPageFile="~/HR_Profile.Master" AutoEventWireup="true" CodeBehind="ProfileReferences.aspx.cs" Inherits="HR_EmpProfile.ProfileReferences" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div style="vertical-align:top;">
    <asp:Panel ID="Panel1" runat="server">
   <table border="0" cellpadding="0" cellspacing="0" width="100%">
           <tr>
<td  colspan="2" align="right" style="background:#ffffff;padding-bottom:10px;"> 
    
    <img src="img/h_EmpRefer.png" />
    
</td>
</tr>
                    <tr>
                        <td class="tdLeft">
                            References Type
                        </td>
                        <td class="tdRight">
                           
                            <telerik:RadComboBox ID="cbRefType" Runat="server" Skin="Metro" Width="250px" 
                                AutoPostBack="True" onselectedindexchanged="cbRefType_SelectedIndexChanged">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Value="0" />
                                    <telerik:RadComboBoxItem runat="server" Text="Business" Value="Business" 
                                        Owner="cbRefType" />
                                    <telerik:RadComboBoxItem runat="server" Text="Personal" Value="Personal" 
                                        Owner="cbRefType" />
                                </Items>
                            </telerik:RadComboBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator27" runat="server" 
                                ControlToValidate="cbRefType" Display="Dynamic" ErrorMessage="References Type" 
                                Font-Size="8px" ValidationGroup="Ref">**</asp:RequiredFieldValidator>
                           
                        </td>
           </tr>
                    <tr>
                        <td class="tdLeft">
                            Name</td>
                        <td class="tdRight">
                           
                            <telerik:RadTextBox ID="txtRefName" Runat="server" MaxLength="100" 
                                Skin="Metro" Width="680px">
                            </telerik:RadTextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator28" runat="server" 
                                ControlToValidate="txtRefName" Display="Dynamic" ErrorMessage="Name" 
                                Font-Size="8px" ValidationGroup="Ref">**</asp:RequiredFieldValidator>

                           </td>
                    </tr>
                    <tr>
                        <td class="tdLeft">
                            Address</td>
                        <td class="tdRight">
                            <telerik:RadTextBox ID="txtRefAddress" Runat="server" MaxLength="100" 
                                Skin="Metro" Width="680px">
                            </telerik:RadTextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator29" runat="server" 
                                ControlToValidate="txtRefAddress" Display="Dynamic" ErrorMessage="Address" 
                                Font-Size="8px" ValidationGroup="Ref">**</asp:RequiredFieldValidator>
                        </td>
           </tr>
           <tr>
               <td class="tdLeft">
               
                   <asp:Label ID="lblCh" runat="server"></asp:Label>
  
               </td>
               <td class="tdRight">
              
                   <table border="0" cellpadding="0" cellspacing="0" width="100%">
                       <tr>
                           <td class="tdRightFM">
                               <telerik:RadTextBox ID="txtRefCh" Runat="server" MaxLength="100" 
                                   Skin="Metro" Width="350px">
                               </telerik:RadTextBox>
                               <asp:RequiredFieldValidator ID="reqCh" runat="server" 
                                   ControlToValidate="txtRefCh" Display="Dynamic" 
                                   ErrorMessage="Position" Font-Size="8px" ValidationGroup="Ref">**</asp:RequiredFieldValidator>
                           </td>
                           <td class="tdLeftM">
                               Telephone</td>
                           <td class="tdRightm">
                               <telerik:RadTextBox ID="txtRefTel" Runat="server" MaxLength="100" 
                                   Skin="Metro" Width="350px">
                               </telerik:RadTextBox>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator25" runat="server" 
                                   ControlToValidate="txtRefTel" Display="Dynamic" ErrorMessage="Telephone" 
                                   Font-Size="8px" ValidationGroup="Ref">**</asp:RequiredFieldValidator>
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
                                ValidationGroup="Ref" />

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
            onclick="btnAdd_Click" ValidationGroup="Ref" />
             
     

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
                              <telerik:RadGrid ID="rgRef" runat="server" AutoGenerateColumns="False" 
                                  CellSpacing="0" GridLines="None" Skin="Office2010Silver" GroupingEnabled="False" 
                                  onitemcommand="rgRef_ItemCommand">
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
                                          <telerik:GridBoundColumn DataField="RefType" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="References Type" 
                                              UniqueName="clnRefType">
                                              <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                          </telerik:GridBoundColumn>

                                                     <telerik:GridBoundColumn DataField="RefName" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Name" 
                                              UniqueName="clnRefName">
                                              <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                          </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="RefAddress" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Address" 
                                              UniqueName="clnRefAddress">
                                              <HeaderStyle HorizontalAlign="Center" Width="200px" />
                                          </telerik:GridBoundColumn>
                                                                                       
                                               <telerik:GridBoundColumn AllowFiltering="False" DataField="RefCh" 
                                              FilterControlAltText="Filter clnHisEmpType column" HeaderText="Position / Relationship" 
                                              UniqueName="clnRefCh">
                                              <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                              <ItemStyle HorizontalAlign="Center" />
                                          </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="RefTel" 
                                              FilterControlAltText="Filter clnLevel column" HeaderText="Telephone" 
                                              UniqueName="clnRefTel">
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
       <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
                                <AjaxSettings>
                                    <telerik:AjaxSetting AjaxControlID="Panel1">
                                        <UpdatedControls>
                                            <telerik:AjaxUpdatedControl ControlID="Panel1" 
                                                LoadingPanelID="RadAjaxLoadingPanel1" />
                                            <telerik:AjaxUpdatedControl ControlID="NotifyInfo" />
                                            <telerik:AjaxUpdatedControl ControlID="NotifyWarn" />
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
       </div>

</asp:Content>
