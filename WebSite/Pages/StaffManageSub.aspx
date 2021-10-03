<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StaffManageSub.aspx.cs" Inherits="ASM.Pages.StaffManageSub" Async="true" %>

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

        .Content-Area-SAP img {
            height: 18px;
            width: 18px;
            margin-top: -2px;
            margin-left: 5px;
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

        .Gridview-title {
            height: 25px;
            margin-top: 5px;
            margin-bottom: -5px;
            display: block;
            width: 100%;
        }

            .Gridview-title img {
                height: 18px;
                width: 18px;
                margin-top: -7px;
                margin-left: 5px;
            }

        .GridView-header {
            font-family: Cambria;
            font-size: 10px;
            background:  linear-gradient(lightskyblue, white);
            Color: darkblue;
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
                    <asp:TextBox CssClass="SearchBox" ID="TextBoxStaffRole" runat="server" Width="80px" Visible="false" placeholder="SAP Role"></asp:TextBox>
                    SAP Unit:<asp:TextBox CssClass="SearchBox" ID="TextBoxUnit" Width="200px" runat="server" placeholder="SAP Unit"></asp:TextBox>
                    <%--                    <asp:Button ID="btnGradeTab" runat="server" Text="" Height="0px" Width="0px" CssClass="HideButton" OnClick="BtnGradeTab_Click" />--%>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <%--  <div style="margin-left: -2px;">
            <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                <ContentTemplate>
                    <div class="Horizontal_Tab" id="GradeTab" runat="server"></div>
                    <asp:HiddenField ID="hfSelectedTab" runat="server" />
                    <asp:HiddenField ID="hfSelectedTabL" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>--%>
        <div class="Content-Area Content-Area-SAP">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>

                    <div class="Gridview-title" id="SAP_Add" runat="server">
                        <a href="javascript:AddDetail('SAP')">
                            <img src="../images/add.png" border="0" width="16" height="16" />
                            Assign the User to New Role Overwrite SAP Role</a>
                    </div>
                    <div style="overflow: scroll; width: 100%; height: 150px" onscroll="OnScrollDiv(this)" id="DivMainContent">

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
                                <asp:BoundField DataField="SchoolName" ReadOnly="True" HeaderText="Unit Name" ItemStyle-CssClass="UnitName">
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
                            <HeaderStyle Height="25px" CssClass="GridView-header" />
                            <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle Height="26px" />
                            <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#594B9C" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#33276A" />
                        </asp:GridView>
                    </div>
                    <div class="Gridview-title" id="APP_Add" runat="server">
                        <a href="javascript:AddDetail('APP')">
                            <img src="../images/add.png" border="0" width="16" height="16" />
                            Assign the User to App Group </a>
                    </div>
                    <div style="overflow: scroll; width: 100%; height: 150px" onscroll="OnScrollDiv(this)" id="DivMainContent2">

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
                    <div class="Gridview-title" id="SIS_Add" runat="server">
                        <a href="javascript:AddDetail('SIS')">
                            <img src="../images/add.png" border="0" width="16" height="16" />
                            Assign the User to SIS Class</a>
                    </div>
                    <div style="overflow: scroll; width: 100%; height: 150px" onscroll="OnScrollDiv(this)" id="DivMainContent3">

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

        <div id="EditDIV" runat="server" class="EditDIV bubble epahide">
            <div class="editTitle">
                <table>
                    <tr>
                        <td style="width: 90%">
                            <div id="EditTitle"></div>
                        </td>
                        <td style="text-align: right">
                            <img id="closeMe" src="../images/close.png" style="height: 25px; width: 25px; margin: -3px 0 -3px 0" /></td>
                    </tr>
                </table>
            </div>
            <iframe class="EditPage" id="editiFrame" name="editiFrame" frameborder="0" scrolling="no" src="" runat="server"></iframe>
        </div>

        <div id="ActionMenuDIV" class="bubble epahide">
            <asp:Label runat="server" ID="LabelTeacherName" Text=""> </asp:Label>
            <div id="ActionMenuUL" class="LeftSideMenu">
            </div>

        </div>
        <div id="PopUpDIV" class="bubble epahide"></div>
        <div id="ActionPOPDIV" class="bubble epahide">
            <div class="editTitle" style="display: block; margin-top: 5px;">
                <div id="ActionTitle" style="display: inline; float: left; width: 96%"></div>
                <div style="display: inline; float: left;">
                    <img id="closeActionPOP" src="../images/close.ico" style="height: 25px; width: 25px; margin: -3px 0 -3px 0" />
                </div>
            </div>
            <iframe id="ActioniFramePage" name="ActioniFramePage" style="height: 425px; width: 99%" frameborder="0" scrolling="no" src="" runat="server"></iframe>
        </div>

        <div>
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
            <input id="clipboardText" type="text" style="position: absolute; top: 1px; left: -50px; width: 1px; height: 1px" />
        </div>
    </form>
</body>
</html>

<script src="../Scripts/MoursPoint.js"></script>
<script src="../Scripts/CommonDOM.js"></script>
<script src="../Scripts/GridView.js"></script>
<script src="../Scripts/Appr_ListPage.js"></script>
<script src="../Scripts/Appr_Help.js"></script>
<script src="../Scripts/Appr_textEdit.js"></script>
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

            $("#closeMe").click(function (event) {
                $("#EditDIV").hide();
            });

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
    function GoPage(type, action) {
        if (type == 'SAP') {
            page = "../PagesForms/Loading.aspx?pID=StaffRoleManage.aspx";
            switch (action) {
                case "Add":
                    title = 'Add User to New App Role';
                    break;
                case "Edit":
                    title = 'Edit App Role of User';
                    break;
                default:
                    title = 'Remove User from the App Role';
            }
        }
        if (type == 'APP') {
            page = "../PagesForms/Loading.aspx?pID=UserAppGroup.aspx";
            switch (action) {
                case "Add":
                    title = 'Add User to New App Group';
                    break;
                case "Edit":
                    title = 'Edit App Group of User';
                    break;
                default:
                    title = 'Remove User from the App Group';
            }
        }

        if (type == 'SIS') {
            page = "../PagesForms/Loading.aspx?pID=UserSISClass.aspx";
            switch (action) {
                case "Add":
                    title = 'Add User to SIS Class Operation';
                    break;
                case "Edit":
                    title = 'Edit SIS Class Operation of User';
                    break;
                default:
                    title = 'Remove User from the SIS Class Operation';
            }
        }
    }
    function AddDetail(type) {
        GoPage(type, "Add");
        var staffID = $("#TextBoxUserID").val();
        var staffRole = $("#TextBoxUserRole").val();
        var staffName = $("#TextBoxStaffName").val();
        var CPNum = $("#TextBoxCPNum").val();
        var schoolCode = $("#TextBoxUnit").val();
        var arg = "&Action=Add" + "&IDs=0" + "&SchoolYear=20202021"  + "&SchoolCode=" + schoolCode + "&AppID=SIC" + "&ModelID=" + staffID + "&xID=" + CPNum + "&xName=" + staffName + "&xType=" + staffRole;
        OpenInPage(title, page + arg, 400, 650);
    }

    function OpenDetail(action, type, ids, schoolYear, schoolCode, appID, modelID, xID, xName, xType) {
        GoPage(type, action);
       //  arg = "?StaffID=" + xID + "&StaffRole=" + xType + "&StaffName=" + groupID + "&CPNum=" + appID + "&Action=" + action + "&IDs=" + ids;
        var  arg = "&Action=" + action + "&IDs=" + ids + "&SchoolYear=" + schoolYear + "&SchoolCode=" + schoolCode + "&AppID=" + appID + "&ModelID=" + modelID + "&xID=" + xID + "&xName=" + xName + "&xType=" + xType;
        OpenInPage(title, page + arg, 400, 650);  
    }

    //function OpenInMyPage() {
    //    var goPage = page + para;
    //    alert(goPage);

    //    var vTop = 50;
    //    var vLeft = 5;
    //    var vHeight = 400;
    //    var vWidth = 600;
    //    try {

    //        $("#editiFrame").attr('src', goPage);
    //        $("#EditTitle").html(title + " ");
    //        $("#EditDIV").css({
    //            top: vTop,
    //            left: vLeft,
    //            height: vHeight - 50,
    //            width: vWidth - 50
    //        });
    //        $("#EditDIV").fadeToggle("fast");
    //    }

    //    catch (e) {
    //        window.alert("Error:" + e.mess);
    //    }

    //}
</script>
