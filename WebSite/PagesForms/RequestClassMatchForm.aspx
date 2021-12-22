<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RequestClassMatchForm.aspx.cs" Inherits="ASM.PagesForms.RequestClassMatchForm" EnableTheming="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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

    <style>
        body {
            width: 600px;
        }

        .NameColumn {
            width: 20%;
        }

        .ContentColum {
            width: 30%
        }

        .center-table {
            width: 600px;
        }
         .Content-Aeas-Grant img {
            height: 20px;
            width: 22px;
            margin-bottom: 0px;
            margin-top: -4px;
        }
        div {
            margin-left: auto;
            margin-right: auto;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="Content-Area Content-Aeas-Grant">
            
            <table>
                <tr>
                    <td>
                        <label for="ddlApps">Application:</label></td>
                    <td colspan="3">
                        <asp:DropDownList runat="server" ID="ddlApps"  SkinID="LockText" AutoPostBack="true" Width="100%" OnSelectedIndexChanged="ddlApps_SelectedIndexChanged"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="ddlModel">Model Name:</label></td>
                    <td colspan="3">
                        <asp:DropDownList runat="server" ID="ddlModel" Width="100%" SkinID="LockText" ></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="TextUserName">User Name:</label></td>
                    <td>
                        <asp:TextBox runat="server" ID="TextUserID" SkinID="LockText"> </asp:TextBox>
                    </td>
                    <td colspan="2">

                        <asp:TextBox runat="server" ID="TextUserName" Width="98%" SkinID="LockText" ReadOnly="true"> </asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="TextUserRole">User Role:</label></td>
                    <td colspan="3">
                        <asp:TextBox runat="server" ID="TextUserRole" Width="99%" SkinID="LockText" ReadOnly="true"> </asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        <label for="ddlSchool">School:</label></td>
                    <td colspan="3">
                        <asp:DropDownList runat="server" ID="ddlSchoolCode" SkinID="LockText" AutoPostBack="true" Width="60px" OnSelectedIndexChanged="ddlSchoolCode_SelectedIndexChanged"></asp:DropDownList>
                        <asp:DropDownList runat="server" ID="ddlSchool"  SkinID="LockText" AutoPostBack="true" Width="430px" OnSelectedIndexChanged="ddlSchool_SelectedIndexChanged"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="ddlMatchType">Match Type:</label></td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlMatchType" Width="100px" AutoPostBack="true" OnSelectedIndexChanged="ddlMatchType_SelectedIndexChanged">
                            <asp:ListItem>Grade</asp:ListItem>
                            <asp:ListItem Selected="True">Class</asp:ListItem>
                        </asp:DropDownList>

                    </td>
                    <td>
                        <label for="ddlClassCode">Class/Grade:</label></td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlMatchValue" Width="250px"></asp:DropDownList>

                    </td>
                </tr>
                 <tr>
                    <td>
                        <label for="ddlSemester">Semester:</label></td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlSemester" Width="100px">
                            <asp:ListItem>1</asp:ListItem>
                            <asp:ListItem>2</asp:ListItem>

                        </asp:DropDownList>

                    </td>
                    <td>
                        <label for="ddlTerm">Term:</label></td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlTerm" Width="100px">
                            <asp:ListItem>1</asp:ListItem>
                            <asp:ListItem>2</asp:ListItem>
                        </asp:DropDownList>

                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="dateStart">Start Date:</label></td>
                    <td>
                        <input runat="server" type="text" id="dateStart" size="9" class="Calendar-Control Edit-Content-Control" />

                    </td>
                    <td>
                        <label for="dateEnd">End Date:</label></td>
                    <td>
                        <input runat="server" type="text" id="dateEnd" size="9" class="Calendar-Control Edit-Content-Control" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="TetComments">Comments:</label>
                    </td>
                    <td colspan="3">
                        <asp:TextBox runat="server" ID="TextComments" Width="99%" Height="80px" TextMode="MultiLine"> </asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="4"></td>
                </tr>
                <tr>
                    <td colspan="4" style="text-align: center">
                        <asp:Button runat="server" ID="btnRequest" Text="Request Permission" OnClick="btnRequest_Click" />
                        <asp:Button runat="server" ID="btnGrant" Text="Grant Permission" OnClick="btnGrant_Click" />

                    </td>
                </tr>
                <tr>
                    <td class="NameColumn"></td>
                    <td class="ContentColum"></td>
                    <td class="NameColumn"></td>
                    <td class="ContentColum"></td>
                </tr>

            </table>
            <asp:HiddenField ID="hfSchoolyearStartDate" runat="server" />
            <asp:HiddenField ID="hfSchoolyearEndDate" runat="server" />
            <asp:HiddenField ID="hfIDs" runat="server" />
            <asp:HiddenField ID="hfCategory" runat="server" />
            <asp:HiddenField ID="hfPageID" runat="server" />
            <asp:HiddenField ID="hfUserID" runat="server" />
            <asp:HiddenField ID="hfUserRole" runat="server" />
            <asp:HiddenField ID="hfAppID" runat="server" />
            <asp:HiddenField ID="hfModelID" runat="server" />
            <asp:HiddenField ID="hfAction" runat="server" />
            <asp:HiddenField ID="hfSchoolYear" runat="server" />
            <asp:HiddenField ID="hfSchoolCode" runat="server" />
            <asp:HiddenField ID="hfUserLoginRole" runat="server" />
            <asp:HiddenField ID="hfRunningModel" runat="server" />


        </div>
    </form>
</body>
</html>
<script src="../Scripts/MoursPoint.js"></script>
<script src="../Scripts/CommonDOM.js"></script>
<script src="../Scripts/ActionMenu.js"></script>
<script src="../Scripts/ActionWebApi.js"></script>

<script type="text/javascript">

    $(document).ready(function () {

        InitialDatePickerControl();

        $("#btnSubmit").click(function (e) {
            SaveDataToDatabase();
        });

    });

    function BindFormData(data) {
        var userGD = data[0];
        $("#lblIDs").html(userGD.IDs);

    }

    function SaveDataToDatabase() {
        try {
            var para = {
                Operate: $("#hfAction").val(),
                UserID: $("#hfUserID").val(),
                IDs: $("#hfIDs").val(),
                SchoolYear: $("#hfSchoolYear").val(),
                SchoolCode: $("#ddlSchool").val(),
                AppID: $("#ddlApps").val(),
                ModelID: $("#ddlModel").val(),
                StaffUserID: $("#TextUserID").val(),
                UserRole: $("#TextUserRole").val(),
                Semester: $("#ddlSemester").val(),
                Term: $("#ddlTerm").val(),
                MatchType: $("#ddlMatchTypee").val(),
                MatchValue: $("#ddlMatchValue").val() ,
                StartDate: $("#dateStart").val(),
                EndDate: $("#dateEnd").val(),
                Comments: $("#TextComments").val(),
            };

            var uri = "RequestClassMatch";
            console.log(para)


            if (para.Operate == "Add") WebAPICall.AddData(uri, para, "Parent");
            if (para.Operate == "Edit") WebAPICall.EditData(uri, para, "Parent");
            if (para.Operate == "Delete") WebAPICall.DeletData(uri, para.IDs, "Parent");

        }
        catch (e) {
            alert(para.Operate + " Submit click something going wrong");
        }
    }

    function InitialDatePickerControl() {
        var minD = new Date($("#hfSchoolyearStartDate").val());
        var maxD = new Date($("#hfSchoolyearEndDate").val());
         JDatePicker.Initial($("#dateStart"), minD, maxD, minD);
        JDatePicker.Initial($("#dateEnd"), minD, maxD, maxD);
    }

</script>
