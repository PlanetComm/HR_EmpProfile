<%@ Page Title="" Language="C#" MasterPageFile="~/HR_Profile.Master" AutoEventWireup="true" CodeBehind="ProfileInquiry.aspx.cs" Inherits="HR_EmpProfile.ProfileInqury" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
       <AjaxSettings>
           <telerik:AjaxSetting AjaxControlID="chkIg">
               <UpdatedControls>
                   <telerik:AjaxUpdatedControl ControlID="RadGrid1" 
                       LoadingPanelID="RadAjaxLoadingPanel1" />
               </UpdatedControls>
           </telerik:AjaxSetting>
           <telerik:AjaxSetting AjaxControlID="RadGrid1">
               <UpdatedControls>
                   <telerik:AjaxUpdatedControl ControlID="RadGrid1" 
                       LoadingPanelID="RadAjaxLoadingPanel1" />
               </UpdatedControls>
           </telerik:AjaxSetting>
       </AjaxSettings>
    </telerik:RadAjaxManager>
<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Runat="server" 
            Skin="Sunset">
        </telerik:RadAjaxLoadingPanel>
    <asp:Panel ID="PanelMain" runat="server">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color:#ffffff;">
        <tr>
        <td style="width:150px;" valign="bottom" align="left">
            &nbsp;</td>
        <td style="width:auto;" align="right" >
            <img alt="" src="img/h_EmpInquiry.png" />
            </td>
        </tr>
        <tr>
        <td align="left">
        
            <asp:CheckBox ID="chkIg" runat="server" AutoPostBack="True" Font-Bold="True" 
                Font-Size="12px" Text="Ignore Paging" />
        
        </td>
        <td align="right">
        
            <asp:ImageButton ID="btnNew" runat="server" ImageUrl="~/img/new.png" 
                onclick="btnNew_Click" />
        
        </td>
        </tr>
          <tr>
        <td colspan="2">
          
            <telerik:RadGrid ID="RadGrid1" runat="server" AllowFilteringByColumn="True" 
                AutoGenerateColumns="False" CellSpacing="0" GridLines="None" Skin="Windows7" 
                onitemdatabound="RadGrid1_ItemDataBound" 
                onneeddatasource="RadGrid1_NeedDataSource">
                <GroupingSettings CaseSensitive="False" />
                <ClientSettings>
                    <Selecting AllowRowSelect="True" />
                </ClientSettings>
                <MasterTableView AllowSorting="True">
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

                        <telerik:GridBoundColumn DataField="EmployeeID" 
                            FilterControlAltText="Filter clnEmpID column" HeaderText="Employee Code" 
                            UniqueName="clnEmpID" AutoPostBackOnFilter="True" 
                            CurrentFilterFunction="Contains">
                            <ItemStyle Width="100px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="FirstNameEN" 
                            FilterControlAltText="Filter clnEmpID column" HeaderText="First Name" 
                            UniqueName="clnFirstName" FilterControlWidth="170px"
                            AutoPostBackOnFilter="True" CurrentFilterFunction="Contains">
                            <ItemStyle Width="200px" />
                        </telerik:GridBoundColumn>
                          <telerik:GridBoundColumn DataField="LastNameEN" 
                            FilterControlAltText="Filter clnEmpID column" HeaderText="Last Name" 
                            UniqueName="clnLastName" FilterControlWidth="170px" 
                            AutoPostBackOnFilter="True" CurrentFilterFunction="Contains">
                            <ItemStyle Width="200px" />
                        </telerik:GridBoundColumn>

                        <telerik:GridTemplateColumn AllowFiltering="False" DataField="ImagePath" 
                            FilterControlAltText="Filter clnImagePath column" HeaderText="Image" 
                            UniqueName="clnImagePath">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%#Eval("ImagePath") %>' Visible="false"></asp:Label>
                                <asp:Image ID="Image1" runat="server" Height="35px" Width="30px" />
                             
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle Width="200px" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn AllowFiltering="False" 
                            FilterControlAltText="Filter clnEdu column" HeaderText="Information" 
                            UniqueName="clnInfor">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyInFor" runat="server" Font-Size="10px"></asp:HyperLink>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" Font-Size="10px" />
                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn AllowFiltering="False" 
                            FilterControlAltText="Filter clnEdu column" HeaderText="Education" 
                            UniqueName="clnEdu">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server" Font-Size="10px"></asp:HyperLink>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" Font-Size="10px" />
                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                        </telerik:GridTemplateColumn>

                           <telerik:GridTemplateColumn AllowFiltering="False" 
                            FilterControlAltText="Filter clnEdu column" HeaderText="Training" 
                            UniqueName="clnTra" Display="false">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyTra" runat="server" Font-Size="10px"></asp:HyperLink>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" Font-Size="10px"  />
                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                        </telerik:GridTemplateColumn>

                                 <telerik:GridTemplateColumn AllowFiltering="False" 
                            FilterControlAltText="Filter clnEdu column" HeaderText="Employment<br>History" 
                            UniqueName="clnHis">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyHis" runat="server" Font-Size="10px"></asp:HyperLink>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" Font-Size="10px" />
                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                        </telerik:GridTemplateColumn>

                                 <telerik:GridTemplateColumn AllowFiltering="False" 
                            FilterControlAltText="Filter clnEdu column" HeaderText="General<br>Information" 
                            UniqueName="clnGen" Display="false">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyGen" runat="server" Font-Size="10px"></asp:HyperLink>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" Font-Size="10px"  />
                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                        </telerik:GridTemplateColumn>

                             <telerik:GridTemplateColumn AllowFiltering="False" 
                            FilterControlAltText="Filter clnEdu column" HeaderText="References" 
                            UniqueName="clnRef">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyRef" runat="server" Font-Size="10px"></asp:HyperLink>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" Font-Size="10px"  />
                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn AllowFiltering="False" 
                            FilterControlAltText="Filter clnLink column" HeaderText="Other" 
                            UniqueName="clnLink">
                            <ItemTemplate>
                            <div style="width:100px;font-size:9px;" align="left">
                                <telerik:RadMenu ID="MenuLink" Runat="server" Flow="Vertical" Skin="Transparent" 
                                    Width="100px" Font-Size="10px">
                                    <Items>
                                        <telerik:RadMenuItem runat="server" Text="Link">
                                            <Items>
                                                <telerik:RadMenuItem runat="server" NavigateUrl="~/ProfileTraining.aspx" 
                                                    Text="Training">
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem runat="server" NavigateUrl="~/ProfileGeneral.aspx" 
                                                    Text="General Information">
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem runat="server" NavigateUrl="~/ProfileSalary.aspx" 
                                                    Text="Salary">
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem runat="server" NavigateUrl="~/ProfileHealth.aspx" 
                                                    Text="Health">
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem runat="server" NavigateUrl="~/ProfileEva.aspx" 
                                                    Text="Evaluation">
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem runat="server" NavigateUrl="~/ProfileWarning.aspx" 
                                                    Text="Warning">
                                                </telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                                </div>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" Font-Size="10px" />
                            <ItemStyle HorizontalAlign="Center" Width="100px" />
                        </telerik:GridTemplateColumn>

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
              </td>
        </tr>
        </table>    
    </asp:Panel>
</asp:Content>
