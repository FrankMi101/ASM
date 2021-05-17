<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Security_RoleMatch.aspx.cs" Inherits="ASM.Security_RoleMatch" Async="true" %>

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
    <link href="../Content/BubbleHelp.css" rel="stylesheet" />
    <link href="../Content/ContentPage.css" rel="stylesheet" />
    <link href="../Content/ContentForms.css" rel="stylesheet" />

    <style type="text/css">
        table {
            width: 100%;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">

        <asp:ScriptManager runat="server">
            <Services>
                <asp:ServiceReference Path="~/Models/WebService.asmx" />
            </Services>
        </asp:ScriptManager>

        <%--<div style="overflow: scroll; width: 100%; height: 100%" onscroll="OnScrollDiv(this)" id="DivMainContent">    </div>--%>
        <div class="Edit-Content">
            <table>
                <tr>
                    <td>Match Type: </td>
                    <td>
                        <asp:Label ID="LabelMatchType" runat="server" Text="" ></asp:Label></td>
                </tr>
                <tr>
                    <td>Description:</td>
                    <td>
                        <asp:Label ID="LabelMatchDesc" runat="server" Text=""   Width="100%" ></asp:Label></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Match Role:</td>
                    <td>
                        <asp:DropDownList ID="ddlMatchRole" runat="server" Width="80%" CssClass="ddlControls"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>Match Scope: </td>
                    <td>
                        <asp:DropDownList ID="ddlMatchScope" runat="server" Width="80%" CssClass="ddlControls"></asp:DropDownList></td>
                </tr>
                <tr>
                    <td style="width:25%"></td>
                    <td style="width:75%">
                        <input id="btnSubmit" type="button" value="Submit" runat="server" class="action-button" style="width: 100px" />
                    </td>
                </tr>
                 
            </table>


        </div>


        <div>
            <asp:HiddenField ID="hfCategory" runat="server" />
            <asp:HiddenField ID="hfPageID" runat="server" />
            <asp:HiddenField ID="hfUserID" runat="server" />
            <asp:HiddenField ID="hfUserRole" runat="server" />
            <asp:HiddenField ID="hfMatchRole" runat="server" />
            <asp:HiddenField ID="hfMatchScope" runat="server" />
            <asp:HiddenField ID="hfAction" runat="server" />
            <asp:HiddenField ID="hfSchoolYear" runat="server" />
            <asp:HiddenField ID="hfUserLoginRole" runat="server" />
            <asp:HiddenField ID="hfRunningModel" runat="server" />

        </div>
    </form>
</body>
</html>

<script src="../Scripts/MoursPoint.js"></script>

<script type="text/javascript">

    var para = {
        Operate: "Edit",
        UserID: $("#hfUserID").val(),
        UserRole: $("#hfUserRole").val(),
        RoleID: $("#TextBoxRoleID").val(),
        MatchType: $("#LabelMatchType").val(),
        MatchDesc: $("#LabelMatchDesc").val(),
        MatchRole: $("#ddlMatchRole").val(),
        MatchScope: $("#ddlMatchScope").val()
    };

    function pageLoad(sender, args) {

        $(document).ready(function () {


            $("#btnSubmit").click(function (ev) {
                SaveDataToDatabase();
            });

        });
    }

    function SaveDataToDatabase() {
        try {
            para.MatchRole = $("#ddlMatchRole").val();
            para.MatchScope = $("#ddlMatchScope").val();

            var result = ASM.Models.WebService.SaveSecurityRoleMatch(para.Operate, para, onSuccess, onFailure);
        }
        catch (e) {
            alert(para.Operate + " Submit click something going wrong");
        }
    }
    function onSuccess(result) {
        alert(para.Operate + " " + para.RoleName + " was " + result);
        parent.location.reload();

    }
    function onFailure() {
        alert(para.Operate + " operation failed");
    }


</script>
