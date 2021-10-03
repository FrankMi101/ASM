<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserAppGroup.aspx.cs" Inherits="ASM.PagesForms.UserAppGroup" Async="true" %>

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

        <div class="Content-Area Content-Aeas-Grant">

            <div id="DIV_APP" runat="server">
                <table>
                    <tr>
                        <td colspan="4">Add User to App Work Group</td>
                       <td> <asp:Label ID="labelStaffUserID" runat="server" Text="staff id"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            <label for="ddlApps">Apps Name: </label>
                        </td>
                        <td colspan="4">
                            <asp:DropDownList ID="ddlApps" runat="server" Width="400px" CssClass="ddlControls" OnSelectedIndexChanged="DDLApps_SelectedIndexChanged"></asp:DropDownList></td>

                    </tr>
                    <tr>
                        <td>
                            <label for="ddlGroupID">Group Name: </label>
                        </td>
                        <td colspan="4">
                            <asp:UpdatePanel ID="UpdatePanel24" runat="server">
                                <ContentTemplate>
                                    <asp:DropDownList ID="ddlGroupID" runat="server" Width="400px" CssClass="ddlControls"></asp:DropDownList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>

                    </tr>
                    <tr>
                        <td>
                            <label for="ddlSchool">School Name: </label>
                        </td>
                        <td colspan="4">
                            <asp:UpdatePanel ID="UpdatePanel23" runat="server">
                                <ContentTemplate>
                                    <asp:DropDownList ID="ddlSchoolCode" runat="server" Width="58px" AutoPostBack="true" CssClass="ddlControls" OnSelectedIndexChanged="DDLSchoolCode_SelectedIndexChanged"></asp:DropDownList>
                                    <asp:DropDownList ID="ddlSchool" runat="server" Width="337px" AutoPostBack="true" CssClass="ddlControls" OnSelectedIndexChanged="DDLSchool_SelectedIndexChanged"></asp:DropDownList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                     
                    <tr>
                        <td>  <label for="dateStart">Start Date: </label></td>
                       
                        <td colspan="4">
                            <input runat="server" type="text" id="dateStart" size="9" />
                        
                            <label for="dateEnd">End Date: </label>
                    
                            <input runat="server" type="text" id="dateEnd" size="9" /></td>
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
                        <td></td>
                        <td colspan="4">
                            <asp:TextBox ID="TextComments" runat="server" Width="100%" Height="80px" TextMode="MultiLine" placeholder="Grant Permission Comments"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5" style="text-align: center">
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                <ContentTemplate>
                                   <%-- <input id="btnAssignNew" type="button" value="Assign New School" class="action-button"  />--%>
                                    <input id="btnSubmit" runat="server" type="button" value="Add to Group" class="action-button" />

                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>

                    </tr>
                    <tr>
                        <td style="width: 20%"></td>
                        <td style="width: 20%"></td>
                        <td style="width: 20%"></td>
                        <td style="width: 20%"></td>
                        <td style="width: 20%"></td>
                    </tr>
                </table>
            </div>
        </div>


        <div>
            <asp:HiddenField ID="hfCategory" runat="server" />
            <asp:HiddenField ID="hfPageID" runat="server" />
            <asp:HiddenField ID="hfUserID" runat="server" />
            <asp:HiddenField ID="hfUserRole" runat="server" />
            <asp:HiddenField ID="hfAction" runat="server" />
            <asp:HiddenField ID="hfIDs" runat="server" />
           <asp:HiddenField ID="hfCPNum" runat="server" />
            <asp:HiddenField ID="hfUserLoginRole" runat="server" />
            <asp:HiddenField ID="hfRunningModel" runat="server" />
            <asp:HiddenField ID="hfSchoolyearStartDate" runat="server" />
            <asp:HiddenField ID="hfSchoolyearEndDate" runat="server" />
             <asp:HiddenField ID="hfStaffUserID" runat="server" />
            <asp:HiddenField ID="hfStaffRole" runat="server" />

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
<script src="../Scripts/ActionWebApi.js"></script>
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

            $("#btnSubmit").click(function (e) {
                var action = $("#hfAction").val();
                SaveDataToDatabase(action);
            });
            $("#btnAddToSchool").click(function (e) {
                SaveDataToDatabase("AddUserToSchool");
            });
            $("#btnAssignNew").click(function (e) {
                SaveDataToDatabase("AssignNewSchool");
            })

        });
    }

    function SaveDataToDatabase(action) {
        try {
            var para = {
                Operate: action,
                UserID: $("#hfUserID").val(),
                IDs: $("#hfIDs").val(),
                SchoolCode: $("#ddlSchool").val(),
                AppID: $("#ddlApps").val(),
                GroupID: $("#ddlGroupID").val(),
                MemberID: $("#labelStaffUserID").text(),
                StartDate: $("#dateStart").val(),
                EndDate: $("#dateEnd").val(),
                Comments: $("#TextComments").val()
            };
            //  alert("Save action");
            // var result = SIC.Models.WebService.SaveSecurityGroupMemberTeacher("Teachers", action, para, onSuccess, onFailure);

            var uri = "WorkingGroup";
           
            alert(para.Operate + " member  id =" + para.MemberID + "  Groupid= " + para.GroupID);
            if (para.Operate == "Add") SaveDataWebAPICall("POST", uri, para, "Parent");
            if (para.Operate == "Edit") SaveDataWebAPICall("PUT", uri, para, "Parent");
            if (para.Operate == "Delete") DeleteDataWebAPICall("DELETE", uri, para.IDs, "Parent");
            if (para.Operate == "AddUserToSchool") SaveDataWebAPICall("POST", uri, para, "Parent");
            if (para.Operate == "AssignNewSchool") SaveDataWebAPICall("POST", uri, para, "Parent");


            event.stopPropagation();
        }
        catch (e) {
            alert(action + " button click something going wrong " + e.message );
        }
    }


    function InitialDatePickerControl() {
        // var value = new Date().toDateString;
        // alert(minD);
        JDatePicker.Initial($("#dateStart"), minD, maxD, minD);
        JDatePicker.Initial($("#dateEnd"), minD, maxD, maxD);
    }

</script>
