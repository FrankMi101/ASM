<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppsModel_Details.aspx.cs" Inherits="ASM.PagesForms.AppsModel_Details" Async="true" %>

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
                    <td>Apps ID:</td>
                    <td colspan="4" >
                         <asp:TextBox ID="TextBoxAppID" runat="server" Width="100%" placeholder="App ID"  ReadOnly="true"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="TextBoxModelID">Model ID: </label>
                        (
                            <asp:Label ID="lblIDs" runat="server" Text="0"></asp:Label>
                        )
                    </td>
                    <td colspan="4">
                        <asp:TextBox ID="TextBoxModelID" runat="server" Width="100%" placeholder="Model ID" CssClass="Edit-Content-Control"></asp:TextBox>

                    </td>

                </tr>
                <tr>
                    <td>
                        <label for="TextBoxModelName">Apps Name: </label>
                    </td>
                    <td colspan="4">
                        <asp:TextBox ID="TextBoxModelName" runat="server" Width="100%" placeholder="Model Name" CssClass="Edit-Content-Control"></asp:TextBox>
                    </td>

                </tr>
                <tr>
                    <td>
                        <label for="TextBoxAOwner" class="label-right">Owner: </label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="TextBoxOwner" runat="server" Width="100%" AutoPostBack="true" CssClass="ddlControls Edit-Content-Control"></asp:TextBox>
                    </td>
                    <td>
                        <label for="TextBoxDeveloper">Developer:  </label>
                    </td>
                    <td >

                        <asp:TextBox ID="TextBoxDeveloper" runat="server" Width="100%" AutoPostBack="true" CssClass="ddlControls Edit-Content-Control"></asp:TextBox>
                    </td>

                </tr>


                <tr>
                    <td>Apps Date:</td>
                    <td colspan="4">
                        <label for="dateStart">Start Date: </label>
                        <input runat="server" type="text" id="dateStart" size="9" class="Edit-Content-Control" />
                        <label for="dateEnd">End Date: </label>
                        <input runat="server" type="text" id="dateEnd" size="9" class="Edit-Content-Control" />

                    </td>
                </tr>


                <tr>
                    <td>Comments</td>
                    <td colspan="4">
                        <asp:TextBox ID="TextComments" runat="server" Width="100%" Height="100px" TextMode="MultiLine" placeholder="Grant Permission Comments" CssClass="Edit-Content-Control"></asp:TextBox>
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
            <asp:HiddenField ID="hfUserLoginRole" runat="server" />
            <asp:HiddenField ID="hfRunningModel" runat="server" />
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

    var para = {
        Operate: $("#hfAction").val(),
        UserID: $("#hfUserID").val(),
        IDs: $("#hfIDs").val(),


    };

    function pageLoad(sender, args) {

        $(document).ready(function () {
           
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
                AppID: $("#TextBoxAppID").val(),
                ModelID: $("#TextBoxModelID").val(),
                ModelName: $("#TextBoxModelName").val(),
                Owners: $("#TextBoxOwner").val(),
                Developer: $("#TextBoxDeveloper").val(),
                StartDate: $("#dateStart").val(),
                EndDate: $("#dateEnd").val(),
                Comments: $("#TextComments").val(),
            };

            var uri = "AppsModel";
            console.log (para)
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
   
    function InitialDatePickerControl() {
        JDatePicker.Initial($("#dateStart"), minD, maxD, minD);
        JDatePicker.Initial($("#dateEnd"), minD, maxD, maxD);
    }

</script>
