<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GroupMember_Student.aspx.cs" Inherits="ASM.PagesForms.GroupMember_Student" Async="true" %>

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
                <%-- <asp:ServiceReference Path="~/Models/WebService.asmx" /> --%>
            </Services>
        </asp:ScriptManager>  

                <table >
                    
                    <tr>
                        <td>
                           Group Type: 
                        </td>
                        <td >
                            <asp:Label ID="LabelGroupType" runat="server" Text="Label"></asp:Label>
                         
                            <asp:DropDownList ID="ddlStudentMemberID" runat="server" Width="150px" CssClass="ddlControls Edit-Content-Control"></asp:DropDownList>
                        </td>
                        
                    </tr>

                    <tr>
                        <td>Comments</td>
                        <td  >
                            <asp:TextBox ID="TextComments" runat="server" Width="100%" Height="100px" TextMode="MultiLine" placeholder="comments to add this group"  CssClass="Edit-Content-Control" ></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 20%"></td>
                        
                        
                        <td style="width: 80%; text-align:center">
                            <input id="btnSubmit" type="button" value="Submit" runat="server" class="action-button" style="width: 150px" /> 

                        </td>

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
        Comments: $("#TextComments").val(),
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
           
            para.Comments = $("#TextComments").val(); 
            para.MemberID = $("#ddlStudentMemberID").val();   

            var uri = "UserGroupStudent";
            if (para.Operate == "Add") SaveDataWebAPICall("POST", uri, para,"Parent");
            if (para.Operate == "Edit") SaveDataWebAPICall("PUT", uri, para,"Parent");
            if (para.Operate == "Delete") DeleteDataWebAPICall("DELETE",uri, para.IDs,"Parent");

         //   parent.location.reload();

        //     var result = SIC.Models.WebService.SaveSecurityGroupMember("Students", para.Operate, para, onSuccess, onFailure);
        }
        catch (e) {
            alert(para.Operate + " Submit click something going wrong");
        }
    }
    function onSuccess(result) {
        alert(para.Operate + " " + para.GroupName + " was " + result);
        parent.location.reload();
       // location.reload();
    }
    function onFailure() {
        alert(para.Operate + " operation failed");
    }

    function InitialDatePickerControl() {
        JDatePicker.Initial($("#dateStart"), minD, maxD, minD);
        JDatePicker.Initial($("#dateEnd"), minD, maxD, maxD);
    }
    //function DeleteDataWebAPICall(uri, id) {
    //    var myUrl = "https://webt.tcdsb.org/Webapi/ASM/api/" + uri + "id=" + id;
    //    // var JSONStr = JSON.stringify(paraObj);
    //    try {

    //        (async () => {
    //            const apiResponse = await fetch(myUrl, {
    //                method: 'DELETE',
    //                headers: {
    //                    'Accept': 'application/json',
    //                    'Content-Type': 'application/json'
    //                }
    //            });
    //            alert(result);
    //        })();
    //    }
    //    catch (ex) {
    //        alert(ex.message);
    //    }
    //}
    //function SaveDataWebAPICall(uri, paraObj) {
    //    var myUrl = "https://webt.tcdsb.org/Webapi/ASM/api/" + uri;
    //    var JSONStr = JSON.stringify(paraObj);
    //    try {

    //        (async () => {
    //            const apiResponse = await fetch(myUrl, {
    //                method: 'POST',
    //                headers: {
    //                    'Accept': 'application/json',
    //                    'Content-Type': 'application/json'
    //                },
    //                body: JSONStr
    //            });
    //            const result = await apiResponse.json();
    //             alert(result);
    //        })();
    //    }
    //    catch (ex) {
    //        alert(ex.message);
    //    }
    //}
</script>
