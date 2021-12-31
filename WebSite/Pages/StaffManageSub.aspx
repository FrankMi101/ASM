<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StaffManageSub.aspx.cs" Inherits="ASM.Pages.StaffManageSub" Async="true" EnableTheming="true" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>School Staff List</title>
    <meta http-equiv="Pragma" content="No-cache" />
    <meta http-equiv="Cache-Control" content="no-Store,no-Cache" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <script src="../Scripts/jquery-3.4.1.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <script src="../Scripts/JqueryUI/jquery-ui.min.js"></script>

    <link href="../Scripts/JqueryUI/jquery-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/BubbleHelp.css" rel="stylesheet" />
    <link href="../Content/ListPage.css" rel="stylesheet" />
    <link href="../Content/ContentPage.css" rel="stylesheet" />
    <link href="../Content/TabMenu.css" rel="stylesheet" />
    <link href="../Content/ActionMenu.css" rel="stylesheet" />
    <link href="../Content/SearchArea.css" rel="stylesheet" />

    <style type="text/css">
        body {
            height: 100%;
            width: 99%;
        }


        .MessageRow {
            height: 25px;
            background: dodgerblue; /* For browsers that do not support gradients */
            background: -webkit-linear-gradient(dodgerblue, lightblue); /* For Safari 5.1 to 6.0 */
            background: -o-linear-gradient(dodgerblue, lightblue); /* For Opera 11.1 to 12.0 */
            background: -moz-linear-gradient(dodgerblue, lightblue); /* For Firefox 3.6 to 15 */
            background: linear-gradient(dodgerblue, lightblue); /* Standard syntax */
        }

        .SearchBox {
            margin-top: 5px;
            height: 18px;
        }

        .content-grid th {
            background: linear-gradient(lightskyblue, white);
            color: black;
            font-size: 12px;
        }
 
        #btnGradeTab {
            display: none;
        }

        .EditPage {
            width: 100%;
            height: 100%;
        }

        #editiFrame {
            width: 100%;
            height: 95%;
        }


 
    </style>
    <script type="text/javascript">

        function ShowSaveMessage(action, result) {
            alert(action + " operation was " + result);
            location.reload();
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">

        <asp:ScriptManager runat="server">
        </asp:ScriptManager>
        <div class="MessageRow">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    Staff ID:  
                    <asp:TextBox CssClass="SearchBox" ID="TextBoxUserID" runat="server" Width="70px" placeholder="User ID"></asp:TextBox>
                    Staff Name:<asp:TextBox CssClass="SearchBox" ID="TextBoxStaffName" Width="120px" runat="server" placeholder="Staff name"></asp:TextBox>
                    CPNum:    
                    <asp:TextBox CssClass="SearchBox" ID="TextBoxCPNum" runat="server" Width="70px" placeholder="CP Number."></asp:TextBox>
                    SAP Role:
                    <asp:TextBox CssClass="SearchBox" ID="TextBoxStaffRole" runat="server" Width="80px" placeholder="SAP Role"></asp:TextBox>
                    SAP Unit:<asp:TextBox CssClass="SearchBox" ID="TextBoxUnit" Width="100px" runat="server" placeholder="SAP Unit"></asp:TextBox>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

        <div class="Content-Area Content-Area-SAP">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="List-Action-Containor">
                        <div class="List-Action">
                            <a class="List-Action-Title" href="javascript:AddDetail('SAP');" title=" Function about Apps access permission group ">
                                <asp:ImageButton ID="ImgSAP" runat="server" src="../images/add.png" CssClass="List-Action-Image" />
                                Assign the Staff to New Role Overwrite SAP Role </a>
                        </div>
                        <div class="List-Action" style="margin-left:70px;" >
                            <a class="List-Action-Title" href="javascript:AddDetail('SAP');" title="Grant User Apps access permission by Request ">
                                <asp:ImageButton ID="ImageGrant" runat="server" src="../images/add.png" CssClass="List-Action-Image" />
                                Grant User Apps access permission by Request </a>
                        </div>
                       <%-- <table style="width: 100%;">
                            <tr>
                                <td style="width: 50%; font-size: 1em;"></td>
                                <td style="width: 50%; font-size: 1em;"></td>
                            </tr>
                        </table>--%>
                    </div>
                    <div class="GridView-List-Containor" style=" height: 150px" onscroll="OnScrollDiv(this)" id="DivMainContent">

                        <asp:GridView ID="GridView_SAP" CssClass="GridView-List" runat="server" CellPadding="1" Height="100%" Width="100%" GridLines="Both" AutoGenerateColumns="False" BackColor="White" BorderColor="gray" BorderStyle="Ridge" BorderWidth="1px" CellSpacing="1" EmptyDataText="No Appraisal Staff in current search condition" EmptyDataRowStyle-CssClass="emptyData" ShowHeaderWhenEmpty="true">
                            <Columns>
                                <asp:BoundField DataField="RowNo" HeaderText="No." ItemStyle-CssClass="myRowNo">
                                    <ItemStyle Width="3%" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Active">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chbPickup" Checked='<%# Convert.ToBoolean(Eval("PickedForGAL"))%>' runat="server" CssClass="myCheckPickedForGAL"></asp:CheckBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="5%" HorizontalAlign="center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="EmployeeRole" ReadOnly="True" HeaderText="Employee Role" ItemStyle-CssClass="EmployeeRole">
                                    <ItemStyle Width="15%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="SchoolName" ReadOnly="True" HeaderText="School Name" ItemStyle-CssClass="UnitName">
                                    <ItemStyle Width="20%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="JobDesc" ReadOnly="True" HeaderText="Job Description" ItemStyle-CssClass="SchoolCode">
                                    <ItemStyle Width="25%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Comments" ReadOnly="True" HeaderText="Comment" ItemStyle-CssClass="OEN">
                                    <ItemStyle Width="26%" Wrap="False" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Edit" ItemStyle-CssClass="myEdit">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="Link1" runat="server" Text='<%# Bind("EditAction") %>'>  </asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle Width="3%" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Del" ItemStyle-CssClass="myDelAction">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="Link2" runat="server" Text='<%# Bind("DeleteAction") %>'>  </asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle Width="3%" Wrap="False" />
                                </asp:TemplateField>


                            </Columns>


                            <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                            <HeaderStyle CssClass="GridView-header" />
                            <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle Height="26px" />
                            <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#594B9C" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#33276A" />
                        </asp:GridView>
                    </div>
                    <div class="List-Action">
                        <a class="List-Action-Title" href="javascript:AddDetail('APP');" title=" Function about User access student group ">
                            <asp:ImageButton ID="ImgAPP" runat="server" src="../images/add.png" CssClass="List-Action-Image" />
                            Assign the Staff to App Group </a>

                        <div class="List-Action-Title-Alter">
                            (User access student group)
                        </div>
                    </div>

                    <div class="GridView-List-Containor" style=" height: 150px" onscroll="OnScrollDiv(this)" id="DivMainContent2">

                        <asp:GridView ID="GridView_APP" CssClass="GridView-List" runat="server" CellPadding="1" Height="150px" Width="100%" GridLines="Both" AutoGenerateColumns="False" BackColor="White" BorderColor="gray" BorderStyle="Ridge" BorderWidth="1px" CellSpacing="1" EmptyDataText="No Apps security setup for the user" EmptyDataRowStyle-CssClass="emptyData" ShowHeaderWhenEmpty="true">
                            <Columns>
                                <asp:BoundField DataField="RowNo" HeaderText="No." ItemStyle-CssClass="myRowNo">
                                    <ItemStyle Width="3%" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Menu" ItemStyle-CssClass="myAction">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="Link21" runat="server" Text='<%# Bind("Actions") %>'>  </asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle Width="3%" Wrap="False" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="App ID">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="Link25" runat="server" Text='<%# Bind("AppID") %>'>  </asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" Wrap="true" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="GroupID" ReadOnly="True" HeaderText="Group ID">
                                    <ItemStyle Width="20%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="GroupType" ReadOnly="True" HeaderText="Type">
                                    <ItemStyle Width="10%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="MemberID" ReadOnly="True" HeaderText="Group Member">
                                    <ItemStyle Width="13%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Permission" ReadOnly="True" HeaderText="Permission">
                                    <ItemStyle Width="10%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="StartDate" ReadOnly="True" HeaderText="Start Date" ItemStyle-CssClass="StartDate">
                                    <ItemStyle Width="10%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="EndDate" ReadOnly="True" HeaderText="End Date" ItemStyle-CssClass="EndDate">
                                    <ItemStyle Width="10%" />
                                </asp:BoundField>

                                <asp:TemplateField HeaderText="Active">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chbActiveFlag" Checked='<%# Convert.ToBoolean(Eval("IsActive"))%>' runat="server" CssClass="myCheckActiveFlag"></asp:CheckBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="5%" HorizontalAlign="center" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Edit" ItemStyle-CssClass="myEdit">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="Link22" runat="server" Text='<%# Bind("EditAction") %>'>  </asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle Width="3%" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Del" ItemStyle-CssClass="myDelAction">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="Link23" runat="server" Text='<%# Bind("DeleteAction") %>'>  </asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle Width="3%" Wrap="False" />
                                </asp:TemplateField>
                            </Columns>

                            <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                            <HeaderStyle CssClass="GridView-header" Height="25px" />
                            <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle Height="28px" />
                            <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#594B9C" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#33276A" />
                        </asp:GridView>
                    </div>

                    <div class="List-Action">
                        <a class="List-Action-Title" href="javascript:AddDetail('SIS');" title="Function about Teacher access student group by class">
                            <asp:ImageButton ID="ImgSIS" runat="server" src="../images/add.png" CssClass="List-Action-Image" />
                            Assign the Staff to SIS Class Group </a>

                        <div class="List-Action-Title-Alter">
                            (Assign the Staff to SIS Class Group)
                        </div>

                    </div>

                    <div class="GridView-List-Containor" style=" height: 150px" onscroll="OnScrollDiv(this)" id="DivMainContent3">

                        <asp:GridView ID="GridView_SIS" CssClass="GridView-List" runat="server" CellPadding="1" Height="150px" Width="100%" GridLines="Both" AutoGenerateColumns="False" BackColor="White" BorderColor="gray" BorderStyle="Ridge" BorderWidth="1px" CellSpacing="1" EmptyDataText="No SIS class information for selected user " EmptyDataRowStyle-CssClass="emptyData" ShowHeaderWhenEmpty="true">
                            <Columns>
                                <asp:BoundField DataField="RowNo" HeaderText="No." ItemStyle-CssClass="myRowNo">
                                    <ItemStyle Width="3%" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Menu" ItemStyle-CssClass="myAction">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="Link31" runat="server" Text='<%# Bind("Actions") %>'>  </asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle Width="3%" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Class">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="Link35" runat="server" Text='<%# Bind("ClassCode") %>'>  </asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle Width="20%" Wrap="true" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="ClassName" ReadOnly="True" HeaderText="Class Description" ItemStyle-CssClass="ClassName ">
                                    <ItemStyle Width="20%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Semester" ReadOnly="True" HeaderText="Semester" ItemStyle-CssClass="Semester">
                                    <ItemStyle Width="9%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Term" ReadOnly="True" HeaderText="Term" ItemStyle-CssClass="Term">
                                    <ItemStyle Width="9%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="StartDate" ReadOnly="True" HeaderText="Start Date" ItemStyle-CssClass="StartDate">
                                    <ItemStyle Width="10%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="EndDate" ReadOnly="True" HeaderText="End Date" ItemStyle-CssClass="EndDate">
                                    <ItemStyle Width="10%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ClassType" ReadOnly="True" HeaderText="HomeClass" ItemStyle-CssClass="HomeClass">
                                    <ItemStyle Width="10%" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Edit" ItemStyle-CssClass="myEdit">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="Link32" runat="server" Text='<%# Bind("EditAction") %>'>  </asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle Width="3%" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Del" ItemStyle-CssClass="myDelAction">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="Link33" runat="server" Text='<%# Bind("DeleteAction") %>'>  </asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle Width="3%" Wrap="False" />
                                </asp:TemplateField>
                            </Columns>

                            <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                            <HeaderStyle CssClass="GridView-header" Height="25px" />
                            <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />

                            <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#594B9C" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#33276A" />
                        </asp:GridView>

                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
           <div id="Action-Pgae-Container"></div>
  
        <div>
            <asp:HiddenField ID="hfAppID" runat="server" />
            <asp:HiddenField ID="hfCategory" runat="server" />
            <asp:HiddenField ID="hfPageID" runat="server" />
            <asp:HiddenField ID="hfUserID" runat="server" />
            <asp:HiddenField ID="hfUserRole" runat="server" />
            <asp:HiddenField ID="hfCode" runat="server" />
            <asp:HiddenField ID="hfCPNum" runat="server" />
            <asp:HiddenField ID="hfUserLoginRole" runat="server" />
            <asp:HiddenField ID="hfRunningModel" runat="server" />
            <asp:HiddenField ID="hfSchoolyearStartDate" runat="server" />
            <asp:HiddenField ID="hfSchoolyearEndDate" runat="server" />
            <asp:HiddenField ID="hfSchoolyear" runat="server" />
            <input id="clipboardText" type="text" style="position: absolute; top: 1px; left: -50px; width: 1px; height: 1px" />
        </div>
    </form>
</body>
</html>

<script src="../Scripts/MoursPoint.js"></script>
<script src="../Scripts/CommonDOM.js"></script>
<script src="../Scripts/GridView.js"></script>
<script src="../Scripts/Appr_ListPage.js"></script>
<%--<script src="../Scripts/Appr_Help.js"></script>
<script src="../Scripts/Appr_textEdit.js"></script>--%>
<script src="../Scripts/CommonListBuild.js"></script>
<script src="../Scripts/ActionMenu.js"></script>
<script src="../Scripts/ActionInPage.js"></script>
<script src="../Scripts/ActionWebApi.js"></script>
<script type="text/javascript">

    var UserID = $("#hfUserID").val();
    var UserRole = $("#hfUserRole").val();
    var ItemCode = $("#hfCode").val();
    var preaLinkID;
    var Action;

    function pageLoad(sender, args) {

        $(document).ready(function () {

            // InitialDatePickerControl();
            //  preaLinkID = $("#hfSelectedTabL").val();

            //$("#closeMe").click(function (event) {
            //    $("#EditDIV").hide();
            //});

            $("#GridView_APP tr").mouseenter(function (event) {
                if ($("#ActionMenuDIV").is(":visible")) $("#ActionMenuDIV").hide();
            });
            $("#GridView_SIS tr").mouseenter(function (event) {
                if ($("#ActionMenuDIV").is(":visible")) $("#ActionMenuDIV").hide();
            });
        });
    }
    var page = "";
    var title = "";
    var xheight = 400;
    var xwidth = 650;


    function GoPage(type, action) {
        if (type == 'SAP') {
            page = "StaffRoleManage.aspx";
            switch (action) {
                case "Add":
                    title = 'Add Staff to New App Role';
                    break;
                case "Edit":
                    title = 'Edit App Role of User';
                    break;
                default:
                    title = 'Remove Staff from the App Role';
            }
        }
        if (type == 'APP') {
            page = "UserAppGroup.aspx";
            switch (action) {
                case "Add":
                    title = 'Add Staff to New App Group';
                    break;
                case "Edit":
                    title = 'Edit App Group of User';
                    break;
                default:
                    title = 'Remove Staff from the App Group';
            }
        }

        if (type == 'SIS') {
            page = "UserSISClass.aspx";
            switch (action) {
                case "Add":
                    title = 'Add Staff to SIS Class Operation';
                    break;
                case "Edit":
                    title = 'Edit SIS Class Operation of User';
                    break;
                default:
                    title = 'Remove Staff from the SIS Class Operation';
            }
        }
        if (type == 'Grant') {
            page = "RequestAccessPermission.aspx";
            title = 'Grant Apps Access Permission by Request';
            xheight = 500;
            xwidth = 700;
        }
        else {
            xheight = 400;
            xwidth = 600;
        }
    }
    function AddDetail(type) {
        GoPage(type, "Add");
        var staffID = $("#TextBoxUserID").val();
        var staffRole = $("#TextBoxStaffRole").val();
        var staffName = $("#TextBoxStaffName").val();
        var appID = $("#hfAppID").val();
        var modelID = $("#TextBoxCPNum").val();
        var schoolCode = $("#TextBoxUnit").val();
        var schoolYear = $("#hfSchoolyear").val();
        if (type == "Grant") {
            modelID = "Pages";
            xheight = 500;
            xwidth = 700;
        }
        var arg = "&Type=" + type + GetArg("Add", "0", schoolYear, schoolCode, appID, modelID, staffID, staffName, staffRole);

      //  var arg = "&Action=Add" + "&Type=" + type + "&IDs=0" + "&SchoolYear=" + schoolYear + "&SchoolCode=" + schoolCode + "&AppID=" + appID + "&ModelID=" + modelID + "&xID=" + staffID + "&xName=" + staffName + "&xType=" + staffRole;
        // OpenInPage(title, page + arg, 400, 650);
        OpenFormFromListPage(title, page, arg, xheight, 700);
    }

    function OpenDetail(action, type, ids, schoolYear, schoolCode, appID, modelID, xID, xName, xType) {
        GoPage(type, action);
        //  arg = "?StaffID=" + xID + "&StaffRole=" + xType + "&StaffName=" + groupID + "&CPNum=" + appID + "&Action=" + action + "&IDs=" + ids;
       // var arg = "&Action=" + action + "&IDs=" + ids + "&SchoolYear=" + schoolYear + "&SchoolCode=" + schoolCode + "&AppID=" + appID + "&ModelID=" + modelID + "&xID=" + xID + "&xName=" + xName + "&xType=" + xType;
        var arg = GetArg(action, ids, schoolYear, schoolCode, appID, modelID, xID, xName, xType);
        if (type == "Grant") {

        }
        OpenFormFromListPage(title, page, arg, xheight, 700);
    }

</script>
