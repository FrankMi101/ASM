<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GroupMember_Teacher.aspx.cs" Inherits="ASM.PagesForms.GroupMember_Teacher" Async="true" %>

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

        <table class="Edit-Content">

            <tr>
                <td>Staff Name
                </td>
                <td>
                    <asp:DropDownList ID="ddlStaff" runat="server" Width="300px"></asp:DropDownList>
                </td>

            </tr>

            <tr>
                <td>Working Date:

                </td>
                <td>
                    <label for="dateStart">Start Date: </label>
                    <input runat="server" type="text" id="dateStart" size="9" />
                    <label for="dateEnd">End Date: </label>
                    <input runat="server" type="text" id="dateEnd" size="9" />

                </td>
            </tr>
            <tr>
                <td>Comments</td>
                <td>
                    <asp:TextBox ID="TextComments" runat="server" Width="100%" Height="150px" TextMode="MultiLine" placeholder="add Comments to here"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 20%"></td>
                <td style="width: 80%">
                    <input id="btnSubmit" type="button" value="Submit" runat="server" class="action-button" style="width: 150px" /></td>
            </tr>

        </table>

        <div>
            <asp:HiddenField ID="hfCategory" runat="server" />
            <asp:HiddenField ID="hfIDs" runat="server" />
            <asp:HiddenField ID="hfPageID" runat="server" />
            <asp:HiddenField ID="hfUserID" runat="server" />
            <asp:HiddenField ID="hfUserRole" runat="server" />
            <asp:HiddenField ID="hfAppID" runat="server" />
            <asp:HiddenField ID="hfGroupID" runat="server" />
            <asp:HiddenField ID="hfAction" runat="server" />
            <asp:HiddenField ID="hfSchoolYear" runat="server" />
            <asp:HiddenField ID="hfSchoolCode" runat="server" />
            <asp:HiddenField ID="hfUserLoginRole" runat="server" />
            <asp:HiddenField ID="hfRunningModel" runat="server" />
            <asp:HiddenField ID="hfSchoolyearStartDate" runat="server" />
            <asp:HiddenField ID="hfSchoolyearEndDate" runat="server" />
            <input id="clipboardText" type="text" style="position: absolute; top: 1px; left: -50px; width: 1px; height: 1px" />
        </div>
        <div id="BubbleHelpDIV" class="bubble epahide" style="overflow: hidden; border: none; text-align: left; vertical-align: top; padding: 0px">
            <table>
                <tr style="height: 100%">
                    <td style="width: 100%; height: 100%; vertical-align: top; text-align: left">
                        <iframe id="iframeHelpText" name="iframeHelpText" frameborder="0" src=""
                            scrolling="no" runat="server" style="font-size: small; font-family: Arial; table-layout: auto; width: 100%; height: 300px;"
                            allowtransparency="true" atomicselection="true"></iframe>
                    </td>
                </tr>
            </table>

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
 
    var para = {
        Operate: $("#hfAction").val(),
        UserID: $("#hfUserID").val(),
        IDs: $("#hfIDs").val(),
        SchoolCode: $("#hfSchoolCode").val(),
        AppID: $("#hfAppID").val(),
        GroupID: $("#hfGroupID").val(),
        MemberID: $("#ddlStudentMemberID").val(),
        GroupType: $("#LabelGroupType").text(),
        StartDate: $("#dateStart").val(),
        EndDate: $("#dateEnd").val(),
        Comments: $("#TextComments").val(),
    };

    function pageLoad(sender, args) {

        $(document).ready(function () {

            InitialDatePickerControl();

            $("#btnSubmit").click(function (ev) {
                SaveDataToDatabase();
            });
            $("#lblTeacherName").click(function (e) {
                var ev = window.event;
                var vTop = $('#lblTeacherName').offset().top - 10;  // ev.clientY - 20;
                var vLeft = $('#lblTeacherName').offset().left - 10;  //ev.clientX - 190; var vTop = $('#ddlQualification').offset().top - 20;  // ev.clientY - 20;

                ShowSelectTeacherList(vTop, vLeft, "Click");
            });
            $("#lblTeacherName").keyup(function (e) {
                var ev = window.event;
                var vTop = $('#lblTeacherName').offset().top - 10;  // ev.clientY - 20;
                var vLeft = $('#lblTeacherName').offset().left - 10;  //ev.clientX - 190; var vTop = $('#ddlQualification').offset().top - 20;  // ev.clientY - 20;

                ShowSelectTeacherList(vTop, vLeft, "Keyup");
            });

        });
    }

    function SaveDataToDatabase() {
        try {

            para.StartDate = $("#dateStart").val();
            para.EndDate = $("#dateEnd").val();
            para.Comments = $("#TextComments").val();
            para.MemberID = $("#ddlStaff").val();
            para.GroupName = $("#ddlStaff option:selected").text();

            var uri = "UserGroupMember/Teacher";
            if (para == "Delete")
                DeleteDataWebAPICall(uri, para.IDs);
            else
                SaveDataWebAPICall(uri, para);


         //   var result = SIC.Models.WebService.SaveSecurityGroupMember("Teachers", para.Operate, para, onSuccess, onFailure);
        }
        catch (e) {
            alert(para.Operate + " Submit click something going wrong");
        }
    }
    function onSuccess(result) {
        alert(para.Operate + " " + para.GroupName + " was " + result);
        parent.location.reload();
    }
    function onFailure() {
        alert(para.Operate + " operation failed");
    }

    function InitialDatePickerControl() {
        JDatePicker.Initial($("#dateStart"), minD, maxD, minD);
        JDatePicker.Initial($("#dateEnd"), minD, maxD, maxD);
    }

    function ShowSelectTeacherList(vTop, vLeft, action) {
        var searchValue = $("#lblTeacherName").val();
        var goPage = "RequestTeachers.aspx?SearchVal=" + searchValue;
        var vHeight = 300;
        var vWidth = 350;

        $("#iframeHelpText").attr('src', goPage);

        $("#BubbleHelpDIV").css({
            top: vTop + 32,
            left: vLeft + 8,
            height: vHeight,
            width: vWidth,
            board: 0
        })
        if (action == "Click") { $("#BubbleHelpDIV").fadeToggle("fast"); }
    }
    function DeleteDataWebAPICall(uri, id) {
        var myUrl = "https://webt.tcdsb.org/Webapi/ASM/api/" + uri + "id=" + id;
        // var JSONStr = JSON.stringify(paraObj);
        try {

            (async () => {
                const apiResponse = await fetch(myUrl, {
                    method: 'DELETE',
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json'
                    }
                });
                alert(result);
            })();
        }
        catch (ex) {
            alert(ex.message);
        }
    }
    function SaveDataWebAPICall(uri, paraObj) {
        var myUrl = "https://webt.tcdsb.org/Webapi/ASM/api/" + uri;
        var JSONStr = JSON.stringify(paraObj);
        try {

            (async () => {
                const apiResponse = await fetch(myUrl, {
                    method: 'POST',
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json'
                    },
                    body: JSONStr
                });
                const result = await apiResponse.json();
                alert(result);
            })();
        }
        catch (ex) {
            alert(ex.message);
        }
    }
</script>
