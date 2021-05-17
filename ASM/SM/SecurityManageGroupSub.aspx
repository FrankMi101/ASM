<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SecurityManageGroupSub.aspx.cs" Inherits="ASM.SecurityManageGroupSub" Async="true" %>

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

        div {
            font-family: Arial;
            font-size: small;
        }


        .DataContentTile {
            font-family: Arial;
            font-size: small;
            font-weight: 300;
            color: blue;
            table-layout: auto;
            display: block;
            height: 99%;
        }



        .SubstituedCell {
            color: red;
            text-decoration: underline;
        }

        .emptyData {
            font-size: xx-large;
            text-align: center;
            color: blue;
        }


        .FixedHeader {
            position: absolute;
            font-weight: bold;
            width: 100%;
            display: block;
        }

        .highlightBoard {
            border: 1px blue solid;
            color: white;
        }

        .highlightRow {
            background-image: url(images/highLightRow.png);
        }

        .defaultBoard {
            border: 1px blue none;
        }



        .hfSchoolYear, .hfSchoolCode, .hfEmployeeID, .hfTeacherName, .hfmyKey, .hfIDs {
            display: none;
            width: 0px;
        }



        .top5Row {
            border-top: 5px solid darkcyan;
        }

        .HideButton {
            margin: 0px;
            padding: 0px;
            border: 0px;
        }

        .SearchBox {
            background-color: transparent;
            border: 0px solid blue;
            color: white;
        }

        .MessageRow {
            background: dodgerblue; /* For browsers that do not support gradients */
            background: -webkit-linear-gradient(dodgerblue, lightblue); /* For Safari 5.1 to 6.0 */
            background: -o-linear-gradient(dodgerblue, lightblue); /* For Opera 11.1 to 12.0 */
            background: -moz-linear-gradient(dodgerblue, lightblue); /* For Firefox 3.6 to 15 */
            background: linear-gradient(dodgerblue, lightblue); /* Standard syntax */
        }

        .content-grid th {
            background: linear-gradient(lightskyblue, white);
            color: black;
            font-size: 12px;
        }

        .ddlControls {
            height: 20px;
        }

        .Content-Aeas-Grant img {
            height: 20px;
            width: 22px;
            margin-bottom: 0px;
            margin-top: -4px;
        }

        .Content-Area-SAP img {
            height: 18px;
            width: 18px;
            margin-top: -5px;
            margin-left: 5px;
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
            <Services>
                <asp:ServiceReference Path="~/Models/WebService.asmx" />
            </Services>
        </asp:ScriptManager>
        <div class="MessageRow">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    User ID:  
                    <asp:TextBox CssClass="SearchBox" ID="TextBoxUserID" runat="server" Width="70px" placeholder="User ID"></asp:TextBox>
                    Staff Name:<asp:TextBox CssClass="SearchBox" ID="TextBoxStaffName" Width="120px" runat="server" placeholder="Staff name"></asp:TextBox>
                    CPNum:    
                    <asp:TextBox CssClass="SearchBox" ID="TextBoxCPNum" runat="server" Width="70px" placeholder="CP Number."></asp:TextBox>
                    <asp:TextBox CssClass="SearchBox" ID="TextBoxUserRole" runat="server" Width="80px" Visible="false" placeholder="SAP Role"></asp:TextBox>
                    SAP Unit:<asp:TextBox CssClass="SearchBox" ID="TextBoxUnit" Width="200px" runat="server" placeholder="SAP Unit"></asp:TextBox>
                    <asp:Button ID="btnGradeTab" runat="server" Text="" Height="0px" Width="0px" CssClass="HideButton" OnClick="BtnGradeTab_Click" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div style ="margin-left:-2px;">
            <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                <ContentTemplate>
                    <div class="Horizontal_Tab" id="GradeTab" runat="server"></div>
                    <asp:HiddenField ID="hfSelectedTab" runat="server" />
                    <asp:HiddenField ID="hfSelectedTabL" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="Content-Area Content-Area-SAP">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div style="overflow: scroll; width: 100%; height: 250px" onscroll="OnScrollDiv(this)" id="DivMainContent-sap">
                        <asp:GridView ID="GridView_SAP" CssClass="content-grid" runat="server" CellPadding="1" Height="100%" Width="100%" GridLines="Both" AutoGenerateColumns="False" BackColor="White" BorderColor="gray" BorderStyle="Ridge" BorderWidth="1px" CellSpacing="1" EmptyDataText="No Appraisal Staff in current search condition" EmptyDataRowStyle-CssClass="emptyData" ShowHeaderWhenEmpty="true">
                            <Columns>
                                <asp:BoundField DataField="RowNo" HeaderText="No." ItemStyle-CssClass="myRowNo">
                                    <ItemStyle Width="30px" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Pickup">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chbPickup" Checked='<%# Convert.ToBoolean(Eval("PickedForGAL"))%>' runat="server" CssClass="myCheckPickedForGAL"></asp:CheckBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="50px" HorizontalAlign="center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="CPNum" ReadOnly="True" HeaderText="CP No." ItemStyle-CssClass="OEN">
                                    <ItemStyle Width="100px" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="SchoolName" ReadOnly="True" HeaderText="Unit Name" ItemStyle-CssClass="UnitName">
                                    <ItemStyle Width="300px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="JobDesc" ReadOnly="True" HeaderText="Job Description" ItemStyle-CssClass="SchoolCode">
                                    <ItemStyle Width="200px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="EmployeeRole" ReadOnly="True" HeaderText="Employee Role" ItemStyle-CssClass="EmployeeRole">
                                    <ItemStyle Width="100px" />
                                </asp:BoundField>


                            </Columns>

                            <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                            <HeaderStyle BackColor="cornflowerblue" ForeColor="white" Height="25px" />
                            <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />

                            <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#594B9C" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#33276A" />
                        </asp:GridView>
                        <asp:GridView ID="GridView_SIS" CssClass="content-grid" runat="server" CellPadding="1" Height="100%" Width="100%" GridLines="Both" AutoGenerateColumns="False" BackColor="White" BorderColor="gray" BorderStyle="Ridge" BorderWidth="1px" CellSpacing="1" EmptyDataText="No SIS class information for selected user " EmptyDataRowStyle-CssClass="emptyData" ShowHeaderWhenEmpty="true">
                            <Columns>
                                <asp:BoundField DataField="RowNo" HeaderText="No." ItemStyle-CssClass="myRowNo">
                                    <ItemStyle Width="20px" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Menu" ItemStyle-CssClass="myAction">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="Link1" runat="server" Text='<%# Bind("Actions") %>'>  </asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle Width="30px" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Class">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="Link5" runat="server" Text='<%# Bind("ClassCode") %>'>  </asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle Width="160px" Wrap="true" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="ClassName" ReadOnly="True" HeaderText="Class Description" ItemStyle-CssClass="ClassName ">
                                    <ItemStyle Width="250px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Semester" ReadOnly="True" HeaderText="Semester" ItemStyle-CssClass="Semester">
                                    <ItemStyle Width="60px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Term" ReadOnly="True" HeaderText="Term" ItemStyle-CssClass="Term">
                                    <ItemStyle Width="50px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="StartDate" ReadOnly="True" HeaderText="Start Date" ItemStyle-CssClass="StartDate">
                                    <ItemStyle Width="60px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="EndDate" ReadOnly="True" HeaderText="End Date" ItemStyle-CssClass="EndDate">
                                    <ItemStyle Width="60px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ClassType" ReadOnly="True" HeaderText="HomeClass" ItemStyle-CssClass="HomeClass">
                                    <ItemStyle Width="50px" />
                                </asp:BoundField>

                            </Columns>

                            <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                            <HeaderStyle BackColor="cornflowerblue" ForeColor="white" Height="25px" />
                            <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />

                            <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#594B9C" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#33276A" />
                        </asp:GridView>
                        <asp:GridView ID="GridView_APP" CssClass="content-grid" runat="server" CellPadding="1" Height="100%" Width="100%" GridLines="Both" AutoGenerateColumns="False" BackColor="White" BorderColor="gray" BorderStyle="Ridge" BorderWidth="1px" CellSpacing="1" EmptyDataText="No Apps security setup for the user" EmptyDataRowStyle-CssClass="emptyData" ShowHeaderWhenEmpty="true">
                            <Columns>
                                <asp:BoundField DataField="RowNo" HeaderText="No." ItemStyle-CssClass="myRowNo">
                                    <ItemStyle Width="30px" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Menu" ItemStyle-CssClass="myAction">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="Link1" runat="server" Text='<%# Bind("Actions") %>'>  </asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle Width="30px" Wrap="False" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="App ID">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="Link5" runat="server" Text='<%# Bind("AppID") %>'>  </asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle Width="60px" Wrap="true" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="GroupID" ReadOnly="True" HeaderText="Group ID">
                                    <ItemStyle Width="250px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="GroupType" ReadOnly="True" HeaderText="Type">
                                    <ItemStyle Width="80px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="MemberID" ReadOnly="True" HeaderText="Group Member">
                                    <ItemStyle Width="200px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Permission" ReadOnly="True" HeaderText="Permission">
                                    <ItemStyle Width="100px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="StartDate" ReadOnly="True" HeaderText="Start Date" ItemStyle-CssClass="StartDate">
                                    <ItemStyle Width="80px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="EndDate" ReadOnly="True" HeaderText="End Date" ItemStyle-CssClass="EndDate">
                                    <ItemStyle Width="80px" />
                                </asp:BoundField>

                                <asp:TemplateField HeaderText="Active">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chbActiveFlag" Checked='<%# Convert.ToBoolean(Eval("IsActive"))%>' runat="server" CssClass="myCheckActiveFlag"></asp:CheckBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="50px" HorizontalAlign="center" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Del" ItemStyle-CssClass="myDelAction">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="Link2" runat="server" Text='<%# Bind("DeleteAction") %>'>  </asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle Width="30px" Wrap="False" />
                                </asp:TemplateField>
                            </Columns>

                            <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                            <HeaderStyle BackColor="cornflowerblue" ForeColor="white" Height="25px" />
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
        <div class="Content-Area Content-Aeas-Grant">
            <table>
                <tr>
                    <td>
                        <label for="ddlApps">Apps Name: </label>
                    </td>
                    <td colspan="4">
                        <asp:DropDownList ID="ddlApps" runat="server" Width="400px" CssClass="ddlControls" OnSelectedIndexChanged="DDLApps_SelectedIndexChanged"></asp:DropDownList></td>
                    <td rowspan="5">
                        <asp:TextBox ID="TextComments" runat="server" Width="100%" Height="100%" TextMode="MultiLine" placeholder="Grant Permission Comments"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="ddlGroupID">Group Name: </label>
                    </td>
                    <td colspan="4">
                        <asp:DropDownList ID="ddlGroupID" runat="server" Width="400px" CssClass="ddlControls"></asp:DropDownList></td>

                </tr>
                <tr>
                    <td>
                        <label for="ddlSchool">School Name: </label>
                    </td>
                    <td colspan="4">
                        <asp:DropDownList ID="ddlSchoolCode" runat="server" Width="58px" CssClass="ddlControls" OnSelectedIndexChanged="DDLSchoolCode_SelectedIndexChanged"></asp:DropDownList>
                        <asp:DropDownList ID="ddlSchool" runat="server" Width="337px" CssClass="ddlControls" OnSelectedIndexChanged="DDLSchool_SelectedIndexChanged"></asp:DropDownList></td>

                </tr>
                <tr>
                    <td>
                        <label for="ddlSchoolYear">School Year: </label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlSchoolYear" runat="server" CssClass="ddlControls"></asp:DropDownList></td>


                    <td colspan="3">
                        <label for="dateStart">Start Date: </label>
                        <input runat="server" type="text" id="dateStart" size="9" />
                        <label for="dateEnd">End Date: </label>
                        <input runat="server" type="text" id="dateEnd" size="9" />
                    </td>

                </tr>
                <tr>
                    <td>
                        <label for="">Permission: </label>

                    </td>
                    <td colspan="4">
                        <asp:RadioButtonList ID="rblPermission" runat="server" Width="180px" RepeatDirection="Horizontal">
                            <asp:ListItem Selected="True">Read</asp:ListItem>
                            <asp:ListItem>Update</asp:ListItem>
                            <asp:ListItem>Super</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>



                </tr>
                <tr>
                    <td style="width: 8%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 10%">
                        <input id="btnSubmit" type="button" value="Add to Group" class="action-button" /></td>
                    <td style="width: 15%">

                        <input id="btnAddToSchool" type="button" value="Add To School" class="action-button" />
                        <%--  <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="action-button" OnClick="BtnSubmit_Click" />
                        <asp:Button ID="btnAddToSchool" runat="server" Text="Add To School" CssClass="action-button" OnClick="BtnAddToSchool_Click" />--%>

                    </td>
                    <td style="width: 47%"></td>
                </tr>

            </table>
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
            <iframe id="ActioniFramePage" name="ActioniFramePage" style="height: 425px; width: 99%" frameborder="0" scrolling="no" src="iBlankPage.html" runat="server"></iframe>
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

<script type="text/javascript">

    var UserID = $("#hfUserID").val();
    var UserRole = $("#hfUserRole").val();
    var ItemCode = $("#hfCode").val();
    var minD = new Date($("#hfSchoolyearStartDate").val()); // today.getDate() - 90; //
    var maxD = new Date($("#hfSchoolyearEndDate").val());
    var preaLinkID;
    var Action;
    function pageLoad(sender, args) {

        $(document).ready(function () {

            InitialDatePickerControl();
            preaLinkID = $("#hfSelectedTabL").val();

            $("#GradeTab").click(function (e) {

                var cEvantID = e.originalEvent.srcElement.id;
                $("#hfSelectedTab").val(cEvantID);
                $("#hfSelectedTabL").val(e.originalEvent.srcElement.parentNode.id);
                $("#btnGradeTab").click();
                preaLinkID = $("#hfSelectedTabL").val();

            });

            //$(".Horizontal_Tab").click(function (e) {
            //    alert("tab click");
            //})
            $(".SearchBox").mouseover(function (e) {
                try {

                    var cEvantID = e.currentTarget.id;
                    var value = e.currentTarget.value;// cEvantID.value;
                    if (cEvantID == "TextBoxUserID" || cEvantID == "TextBoxCPNum") {
                        value = value + " " + $("#TextBoxStaffName").val();
                    }
                    CopyKeyIDToClipboard(value);
                }
                catch (e) {
                    alert("Something error");
                }
            });

            $("#btnSubmit").click(function (e) {
                SaveDataToDatabase("Add");
            });
            $("#btnAddToSchool").click(function (e) {
                SaveDataToDatabase("AddUserToSchool");
            });

            $("#GridView_APP tr").mouseenter(function (event) {
                //if ($("#ActionMenuDIV", parent.document).is(":visible")) $("#ActionMenuDIV", parent.document).hide();
                if ($("#ActionMenuDIV").is(":visible")) $("#ActionMenuDIV").hide();
            });
            $("#GridView_SIS tr").mouseenter(function (event) {
                // if ($("#ActionMenuDIV", parent.document).is(":visible")) $("#ActionMenuDIV", parent.document).hide();
                if ($("#ActionMenuDIV").is(":visible")) $("#ActionMenuDIV").hide();
            });
        });
    }

    function SaveDataToDatabase(action) {
        try {
            Action = action;
            var para = {
                Operate: action,
                UserID: $("#hfUserID").val(),
                UserRole: $("#hfUserRole").val(),
                SchoolYear: $("#ddlSchoolYear").val(),
                SchoolCode: $("#ddlSchoolCode").val(),
                AppID: $("#ddlApps").val(),
                GroupID: $("#ddlGroupID").val(),
                MemberID: $("#TextBoxCPNum").val(),
                StartDate: $("#dateStart").val(),
                EndDate: $("#dateEnd").val(),
                Comments: $("#TextComments").val(),
                Permission: $("input:radio[name='rblPermission']:checked").val()
            };

            var result = ASM.Models.WebService.SaveSecurityGroupMember("Teachers", action, para, onSuccess, onFailure);
        }
        catch (e) {
            alert(action + " button click something going wrong");
        }
    }
    function onSuccess(result) {
        alert(Action + " save was " + result);
        location.reload();
    }
    function onFailure() {
        alert(Action + " operation failed");
    }

    function RemoveUserFromGroup(userID, userRole, schoolYear, schoolCode, appID, groupID, memberID) {
        try {
                 Action = "Remove the User from Group";
           var result = confirm("Going to delete" + memberID + " ?");
            if (result) {
                var para = {
                    Operate: "Delete",
                    UserID: userID,
                    UserRole: userRole,
                    SchoolYear: schoolYear,
                    SchoolCode: schoolCode,
                    AppID: appID,
                    GroupID: groupID,
                    MemberID: memberID
                };
                var result = ASM.Models.WebService.SaveSecurityGroupMember("Teachers", "Delete", para, onSuccess, onFailure);
            }


        }
        catch (e) {
            alert(action + " button click something going wrong");
        }
    }
    function InitialDatePickerControl() {
        // var value = new Date().toDateString;
        // alert(minD);
        JDatePicker.Initial($("#dateStart"), minD, maxD, minD);
        JDatePicker.Initial($("#dateEnd"), minD, maxD, maxD);
    }

</script>
