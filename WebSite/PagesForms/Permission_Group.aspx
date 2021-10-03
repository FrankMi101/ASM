﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Permission_Group.aspx.cs" Inherits="ASM.PagesForms.Permission_Group" Async="true" %>

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

        <%--<div style="overflow: scroll; width: 100%; height: 100%" onscroll="OnScrollDiv(this)" id="DivMainContent">    </div>--%>
        <div class="Edit-Content">
            <table>
                <tr>
                    <td>
                        <label>Group: </label>
                    </td>
                    <td colspan="4">
                        <asp:HiddenField ID="hfGroupID" runat="server" />

                        <asp:TextBox ID="TextBoxGroupName" runat="server" Width="90%" ReadOnly="true"></asp:TextBox>
                        (
                            <asp:Label ID="lblIDs" runat="server" Text="0"></asp:Label>
                        )
                    </td>

                </tr>

                <tr>
                    <td>
                        <label for="ddlApps">Apps Name: </label>
                    </td>
                    <td colspan="4">
                        <asp:DropDownList ID="ddlApps" runat="server" Width="100%" CssClass="ddlControls" AutoPostBack="true" OnSelectedIndexChanged="ddlApps_SelectedIndexChanged"></asp:DropDownList></td>

                </tr>
                <tr>
                    <td>
                        <label for="ddlModelID">Apps Model: </label>
                    </td>
                    <td colspan="4">
                        <asp:DropDownList ID="ddlModelID" runat="server" Width="80%" CssClass="ddlControls"></asp:DropDownList>

                    </td>
                </tr>



                <tr>
                    <td>
                        <label for="">
                            Permission:
                        </label>

                    </td>
                    <td colspan="4">
                        <asp:RadioButtonList ID="rblPermission" runat="server" RepeatDirection="Horizontal" Width="100%">
                            <asp:ListItem Selected="True">Read</asp:ListItem>
                            <asp:ListItem>Update</asp:ListItem>
                            <asp:ListItem>Deny</asp:ListItem>
                            <asp:ListItem>Super</asp:ListItem>
                        </asp:RadioButtonList>

                    </td>

                </tr>
                <tr>
                    <td>Access Scope</td>
                    <td colspan="4">
                        <asp:DropDownList ID="ddlScope" runat="server" Width="100%" CssClass="ddlControls"></asp:DropDownList>
                    </td>
                </tr>

                <tr>
                    <td>Comments</td>
                    <td colspan="4">
                        <asp:TextBox ID="TextComments" runat="server" Width="100%" Height="80px" TextMode="MultiLine" placeholder="Grant Permission Comments"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 15%"></td>
                    <td style="width: 15%"></td>
                    <td style="width: 20%">
                        <input id="btnSubmit" type="button" value="Submit" runat="server" class="action-button" style="width: 150px" /></td>

                    <td style="width: 15%"></td>
                    <td style="width: 35%"></td>
                </tr>
            </table>
        </div>


        <div>
            <asp:HiddenField ID="hfCategory" runat="server" />
            <asp:HiddenField ID="hfPageID" runat="server" />
            <asp:HiddenField ID="hfUserID" runat="server" />
            <asp:HiddenField ID="hfUserRole" runat="server" />
            <asp:HiddenField ID="hfRoleType" runat="server" />
            <asp:HiddenField ID="hfAppID" runat="server" />
            <asp:HiddenField ID="hfAction" runat="server" />
            <asp:HiddenField ID="hfSchoolYear" runat="server" />
            <asp:HiddenField ID="hfUserLoginRole" runat="server" />
            <asp:HiddenField ID="hfRunningModel" runat="server" />

        </div>
    </form>
</body>
</html>

<script src="../Scripts/MoursPoint.js"></script>
<script src="../Scripts/ActionWebApi.js"></script>

<script type="text/javascript">

    var para = {
        Operate: $("#hfAction").val(),
        UserID: $("#hfUserID").val(),
        IDs: $("#lblIDs").text(),
        SchoolCode: $("#hfSchoolCode").val(),
        AppID: $("#ddlApps").val(),
        ModelID: $("#ddlModelID").val(),
        GroupIDID: $("#hfGroupID").val(),
        Permission: $("input:radio[name='rblPermission']:checked").val(),
        AccessScope: $("#ddlScope").val(),
        Comments: $("#TextComments").val()
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
            para.ModelID = $("#ddlModelID").val();
            para.GroupID = $("#hfGroupID").val();
             para.Permission = $("input:radio[name='rblPermission']:checked").val();
            para.AccessScope = $("#ddlScope").val();
            para.Comments = $("#TextComments").val();

            var uri = "UserGroupPermission";
            alert(para.Operate + "  " + para.Comments);
            if (para.Operate == "Add") SaveDataWebAPICall("POST", uri, para, "Parent");
            if (para.Operate == "Edit") SaveDataWebAPICall("PUT", uri, para, "Parent");
            if (para.Operate == "Delete") DeleteDataWebAPICall("DELETE",uri, para.IDs, "Parent");

            // var result = SIC.Models.WebService.SaveSecurityRolePermission(para.Operate, para, onSuccess, onFailure);
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