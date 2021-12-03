<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StaffRoleManage.aspx.cs" Inherits="ASM.PagesForms.StaffRoleManage" Async="true" %>

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
    <link href="../Content/ContentForms.css" rel="stylesheet" />


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

        .auto-style1 {
            height: 47px;
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

        <div class="Content-Area Content-Aeas-Grant">
            <div id="DIV_SAP" runat="server">
                <table style="width: 100%">
                    <tr>
                        <td colspan="3">Overwrite User SAP Role </td>
                        <td>User Login ID</td>
                        <td>
                            <asp:Label ID="labelStaffUserID" runat="server" Text="staff id"></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="auto-style1">User Profile:</td>
                        <td class="auto-style1" colspan="2"> Name: 
                            <asp:Label ID="labelStaffName" runat="server" Text="user name"></asp:Label>
                        </td>
                        <td class="auto-style1">CPNum:</td>
                        <td class="auto-style1">
                            <asp:Label ID="labelSatffCPnum" runat="server" Text="Cpnum"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td>Staff Role:</td>
                        <td>SAP Role:  </td>
                        <td>
                            <asp:Label ID="labelSAPRole" runat="server" Text="sap role"></asp:Label>
                        </td>
                        <td>Grant Role:</td>
                        <td>
                            <asp:DropDownList ID="ddlGrentRole" runat="server" Width="100%" CssClass="ddlControls Edit-Content-Control"></asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td>Application:</td>
                        <td colspan="4">
                            <asp:DropDownList ID="ddlApps" runat="server" Width="100%" CssClass="ddlControls Edit-Content-Control"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>Access Students:</td>
                        <td>Scope by:</td>
                        <td><asp:DropDownList ID="ddlScopeby" runat="server" Width="100%" CssClass="ddlControls Edit-Content-Control" OnSelectedIndexChanged="DDLScopeby_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem>Board</asp:ListItem>
                            <asp:ListItem>Panel</asp:ListItem>
                            <asp:ListItem>Area</asp:ListItem>
                            <asp:ListItem>District</asp:ListItem>
                            <asp:ListItem>School</asp:ListItem>
                            <asp:ListItem>Class</asp:ListItem>
                            <asp:ListItem>Grade</asp:ListItem>
                             <asp:ListItem>UserGroup</asp:ListItem>
                            </asp:DropDownList></td>
                        <td>Scope Value:</td>
                        <td>
                            <asp:DropDownList ID="ddlScopeByValue" runat="server" Width="100%" CssClass="ddlControls Edit-Content-Control"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>Active
                            <asp:CheckBox ID="chbActive" Checked="true" runat="server" />
                        </td>
                        <td>Start Date:</td>
                        <td>
                            <input runat="server" type="text" id="dateStart" size="9" class="Edit-Content-Control" />
                        </td>
                        <td>End Date:
                        </td>
                        <td>
                            <input runat="server" type="text" id="dateEnd" size="9"  class="Edit-Content-Control"/>
                        </td>

                    </tr>
                    <tr>
                        <td>
                            <label for="">Comments: </label>

                        </td>
                        <td colspan="4">
                            <asp:TextBox ID="TextComments" runat="server" Width="100%" Height="120px" Cssclass="Edit-Content-Control" TextMode="MultiLine" placeholder="Grant Permission Comments"></asp:TextBox>
                        </td>

                    </tr>
                    <tr>
                        <td colspan="5" style="text-align: center">
                            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                <ContentTemplate>
                                    <input id="btnSubmit" runat="server" type="button" value="Add User to New Role" class="action-button" title="" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>


                    </tr>

                    <tr>
                        <td style="width: 20%"></td>
                        <td style="width: 15%"></td>
                        <td style="width: 20%"></td>
                        <td style="width: 15%"></td>
                        <td style="width: 30%"></td>
                    </tr>
                </table>
            </div>
        </div>
        <div>
            <asp:HiddenField ID="hfCategory" runat="server" />
            <asp:HiddenField ID="hfPageID" runat="server" />
            <asp:HiddenField ID="hfUserID" runat="server" />
            <asp:HiddenField ID="hfUserRole" runat="server" />
            <asp:HiddenField ID="hfStaffUserID" runat="server" />
            <asp:HiddenField ID="hfStaffRole" runat="server" />
            <asp:HiddenField ID="hfAction" runat="server" />
            <asp:HiddenField ID="hfIDs" runat="server" />
            <asp:HiddenField ID="hfUserLoginRole" runat="server" />
            <asp:HiddenField ID="hfRunningModel" runat="server" />
            <asp:HiddenField ID="hfSchoolyearStartDate" runat="server" />
            <asp:HiddenField ID="hfSchoolyearEndDate" runat="server" />
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
<script src="../Scripts/ActionWebApi.js"></script>
<script type="text/javascript">

    var UserID = $("#hfUserID").val();
    var UserRole = $("#hfUserRole").val();
    var ItemCode = $("#hfCode").val();
    var minD = new Date($("#hfSchoolyearStartDate").val()); // today.getDate() - 90; //
    var maxD = new Date($("#hfSchoolyearEndDate").val());
    var Action = $("#hfAction").val();
    function pageLoad(sender, args) {

        $(document).ready(function () {

            InitialDatePickerControl();
            $("#btnSubmit").click(function (e) {
                SaveDataToDatabase();
            });

        });
    }

    function SaveDataToDatabase() {
        try {
            var para = {
                Operate: Action,
                UserID: $("#hfUserID").val(),
                IDs: $("#hfIDs").val(),
                StaffUserID: $("#labelStaffUserID").text(),
                WorkingRole: $("#ddlGrentRole").val(),
                AppID: $("#ddlApps").val(),
                ScopeBy: $("#ddlScopeby").val(),
                ScopeByValue: $("#ddlScopeByValue").val(),
                StaffName: $("#labelStaffName").text(),
                StartDate: $("#dateStart").val(),
                EndDate: $("#dateEnd").val(),
                ActiveFlag: $("#chbActive").val() ? "x" : "",
                Comments: $("#TextComments").val(),
            };

            //  alert("Save action");
            // var result = SIC.Models.WebService.SaveSecurityGroupMemberTeacher("Teachers", action, para, onSuccess, onFailure);

            var uri = "WorkingRole";
            alert("active : " + para.ActiveFlag + "  Staff ID: " + para.StaffUserID + "  New Role= " + para.WorkingRole + " Start Date:" + para.StartDate + " End Date: " + para.EndDate + "  Staff Name: " + para.StaffName);
            if (para.Operate == "Add") SaveDataWebAPICall("POST", uri, para, "Parent");
            if (para.Operate == "Edit") SaveDataWebAPICall("PUT", uri, para, "Parent");
            if (para.Operate == "Delete") DeleteDataWebAPICall("DELETE", uri, para.IDs, "Parent");

            event.stopPropagation();
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
