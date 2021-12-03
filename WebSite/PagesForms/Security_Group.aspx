<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Security_Group.aspx.cs" Inherits="ASM.PagesForms.Security_Group" Async="true" %>

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
    <link href="../Content/ContentPage.css" rel="stylesheet" />
    <link href="../Content/ContentForms.css" rel="stylesheet" />

    <style type="text/css">
        .content-addition {
            background: linear-gradient(lightskyblue, white);
            color: black;
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
                <%--  <asp:ServiceReference Path="~/Models/WebService.asmx" />--%>
            </Services>
        </asp:ScriptManager>

        <%--<div style="overflow: scroll; width: 100%; height: 100%" onscroll="OnScrollDiv(this)" id="DivMainContent">    </div>--%>
        <div class="Edit-Content">
            <table>
                <tr>
                    <td>
                        <label for="ddlApps">Apps Name: </label>
                    </td>
                    <td colspan="3">
                        <asp:DropDownList ID="ddlApps" runat="server" Width="400px" CssClass="ddlControls Edit-Content-Control"></asp:DropDownList></td>
                    <td>Active Flag:
                            <asp:Label ID="LabelActive" runat="server" Text="X"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="ddlGroupID">Group ID: </label>
                        (
                            <asp:Label ID="lblIDs" runat="server" Text="0"></asp:Label>
                        )
                    </td>
                    <td colspan="4">
                        <asp:TextBox ID="TextBoxGroupID" runat="server" Width="100%" placeholder="Group ID" CssClass="Edit-Content-Control"></asp:TextBox>

                    </td>

                </tr>
                <tr>
                    <td>
                        <label for="TextBoxGroupName">Group Name: </label>
                    </td>
                    <td colspan="4">
                        <asp:TextBox ID="TextBoxGroupName" runat="server" Width="100%" placeholder="Group Name"  CssClass="Edit-Content-Control" ></asp:TextBox>
                    </td>

                </tr>
                <tr>
                    <td>
                        <label for="ddlSchoolYear">Group Type: </label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlGroupType" runat="server" Width="100px" AutoPostBack="true" CssClass="ddlControls Edit-Content-Control" OnSelectedIndexChanged="DdlGroupType_SelectedIndexChanged"></asp:DropDownList>
                    </td>
                    <td colspan="2">Student Member:
                  
                        <asp:DropDownList ID="ddlStudentMemberID" runat="server" Width="100px" CssClass="ddlControls Edit-Content-Control"></asp:DropDownList>
                    </td>
                    <td>
                        <asp:CheckBox ID="chbTeachers" runat="server" Text="Techer Members:" Enabled="false" />
                    </td>
                </tr>

                <tr>
                    <td>
                        <label for="">
                            Permission:
                        </label>

                    </td>
                    <td colspan="2">
                        <asp:RadioButtonList ID="rblPermission" runat="server" RepeatDirection="Horizontal" Width="100%"  CssClass="Edit-Content-Control" >
                            <asp:ListItem Selected="True">Read</asp:ListItem>
                            <asp:ListItem>Update</asp:ListItem>
                            <asp:ListItem>Super</asp:ListItem>
                            <asp:ListItem>Deny</asp:ListItem>
                        </asp:RadioButtonList>

                    </td>
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td>Working Date:</td>
                    <td colspan="4">
                        <label for="dateStart">Start Date: </label>
                        <input runat="server" type="text" id="dateStart" size="9" class ="Edit-Content-Control" />
                        <label for="dateEnd">End Date: </label>
                        <input runat="server" type="text" id="dateEnd" size="9" class ="Edit-Content-Control" />

                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="ddlSchool">School Name: </label>
                    </td>
                    <td colspan="4">
                        <asp:DropDownList ID="ddlSchoolCode" runat="server" Width="58px" CssClass="ddlControls Edit-Content-Control"></asp:DropDownList>
                        <asp:DropDownList ID="ddlSchool" runat="server" Width="400px" CssClass="ddlControls Edit-Content-Control"></asp:DropDownList></td>
                </tr>


                <tr>
                    <td>Comments</td>
                    <td colspan="4">
                        <asp:TextBox ID="TextComments" runat="server" Width="100%" Height="100px" TextMode="MultiLine" placeholder="Grant Permission Comments"  CssClass="Edit-Content-Control" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 20%"></td>
                    <td style="width: 15%"></td>
                    <td style="width: 15%">
                        <input id="btnSubmit" type="button" value="Submit" runat="server" class="action-button" style="width: 150px" /></td>

                    <td style="width: 15%"></td>
                    <td style="width: 35%"></td>
                </tr>
                <tr class="content-addition" id="CopyToAnotherAppRow">
                    <td>Copy Current Group To
                    </td>
                    <td colspan="4">
                        <div>
                            <asp:DropDownList ID="ddlAppsTo" runat="server" Width="400px" CssClass="ddlControls Edit-Content-Control"></asp:DropDownList>

                            <input id="btnPush" type="button" value="Push" runat="server" class="action-button" style="width: 80px" />
                        </div>
                        <div>
                            <asp:CheckBox ID="chbMemberSInclude" runat="server" Text="Include Student Group Member" />
                            <asp:CheckBox ID="chbMemberTInclude" runat="server" Text="Include Teacher Group Member" />
                        </div>

                    </td>

                </tr>

            </table>
        </div>


        <div>
            <asp:HiddenField ID="hfCategory" runat="server" />
            <asp:HiddenField ID="hfIDs" runat="server" />
            <asp:HiddenField ID="hfPageID" runat="server" />
            <asp:HiddenField ID="hfUserID" runat="server" />
            <asp:HiddenField ID="hfUserRole" runat="server" />
            <asp:HiddenField ID="hfAppID" runat="server" />
            <asp:HiddenField ID="hfAction" runat="server" />
            <asp:HiddenField ID="hfSchoolYear" runat="server" />
            <asp:HiddenField ID="hfSchoolCode" runat="server" />
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
<script src="../Scripts/ActionWebApi.js"></script>

<script type="text/javascript">

    var minD = new Date($("#hfSchoolyearStartDate").val()); // today.getDate() - 90; //
    var maxD = new Date($("#hfSchoolyearEndDate").val());
    var uri = "usergroup";

    var para = {
        Operate: $("#hfAction").val(),
        UserID: $("#hfUserID").val(),
        IDs: $("#hfIDs").val(),
        SchoolYear: $("#hfSchoolYear").val(),
        SchoolCode: $("#ddlSchool").val(),
        AppID: $("#ddlApps").val(),
        GroupID: $("#TextBoxGroupID").val(),
        GroupName: $("#TextBoxGroupName").val(),
        GroupType: $("#ddlGroupType").val(),

        //  StartDate: $("#dateStart").val(),
        //  EndDate: $("#dateEnd").val
        Permission: $("input:radio[name='rblPermission']:checked").val(),
        IsActive: $("#LabelActive").text(),
        Comments: $("#TextComments").val(),
        MemberID: $("#ddlStudentMemberID").val(),

    };

    function pageLoad(sender, args) {

        $(document).ready(function () {
            if ($("#hfAction").val() != "Edit")
                $("#CopyToAnotherAppRow").addClass("epahide");
            if ($("#hfAction").val() == "View") GetFormData();

            InitialDatePickerControl();

            $("#btnSubmit").click(function (ev) {

                SaveDataToDatabase();
            });

            $("#btnPush").click(function (ev) {
                PushAppGroupToAnotherApp();
            });
        });
    }
    function BindFormData(data) {
        var userGD = data[0];
          $("#lblIDs").html(userGD.IDs);
          $("#TextBoxGroupID").val(userGD.GroupID);
          $("#TextBoxGroupName").val(userGD.GroupName);
          $("#TextComments").val(userGD.Comments);
          $("#ddlApps").val(userGD.AppID);
          $("#ddlSchool").val(userGD.SchoolCode);
    }

    async function GetFormData() {
        var myUrl = "https://webt.tcdsb.org/Webapi/ASM/api/" + uri + "/" + para.IDs;
        try {
            const response = await fetch(myUrl);
            const data = await response.json();
            BindFormData(data); // this function must be inside async function
        }
        catch (ex) {
            alert(ex.message);
        }
    }

    function SaveDataToDatabase() {
        try {
            var para = {
                Operate: $("#hfAction").val(),
                UserID: $("#hfUserID").val(),
                IDs: $("#hfIDs").val(),
                SchoolCode: $("#ddlSchool").val(),
                AppID: $("#ddlApps").val(),
                GroupID: $("#TextBoxGroupID").val(),
                GroupName: $("#TextBoxGroupName").val(),
                GroupType: $("#ddlGroupType").val(),
                Permission: $("input:radio[name='rblPermission']:checked").val(),
                IsActive: "x",
                Comments: $("#TextComments").val(),
            };

            //if (para.Operate == "Add") SaveDataWebAPICall("POST", uri, para,"Parent");
            //if (para.Operate == "Edit") SaveDataWebAPICall("PUT", uri, para, "Parent");
            //if (para.Operate == "Delete") DeleteDataWebAPICall(uri, para.IDs, "Parent");

            if (para.Operate == "Add") WebAPICall.AddData(uri, para, "Parent"); 
            if (para.Operate == "Edit") WebAPICall.EditData(uri, para, "Parent"); 
            if (para.Operate == "Delete") WebAPICall.DeletData(uri, para.IDs, "Parent"); 

      

            //  var result = SIC.Models.WebService.SaveSecurityGroup(para.Operate, para, onSuccess, onFailure);

        }
        catch (e) {
            alert(para.Operate + " Submit click something going wrong");
        }
    }
    function onSuccess(result) {
        alert(para.Operate + " " + para.GroupName + " was " + result);
        parent.location.reload();
        location.reload();
    }
    function onFailure() {
        alert(para.Operate + " operation failed");
    }
    function PushAppGroupToAnotherApp() {
        var para = {
            Operate: "Push",
            UserID: $("#hfUserID").val(),
            SchoolCode: $("#ddlSchool").val(),
            AppID: $("#ddlApps").val(),
            GroupID: $("#TextBoxGroupID").val(),
            AppIDTo: $("#ddlAppsTo").val(),
            IncludeStudent: $("input[type=checkbox][name='chbMemberSInclude']").prop("checked"),
            IncludeTeacher: $("input[type=checkbox][name='chbMemberTInclude']").prop("checked")
        };
        var uri = "usergroup/push";
 
        SaveDataWebAPICall("POST", uri, para,"Self");
    }


    function InitialDatePickerControl() {
        JDatePicker.Initial($("#dateStart"), minD, maxD, minD);
        JDatePicker.Initial($("#dateEnd"), minD, maxD, maxD);
    }

</script>
