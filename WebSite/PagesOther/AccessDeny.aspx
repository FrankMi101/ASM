<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccessDeny.aspx.cs" Inherits="ASM.PagesOther.AccessDeny" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="../Scripts/jquery-3.4.1.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <%--    <link href="../Content/BubbleHelp.css" rel="stylesheet" />
    <link href="../Content/ListPage.css" rel="stylesheet" />--%>

    <style>
        .MessageDIV {
            margin: auto;
            margin-top: 8%;
            text-align: center;
        }

        .Messsage-Content {
            font-size: medium;
        }

        #editiFrame {
            width: 100%;
            height: 95%;
            overflow: auto;
        }

        .EditDIV {
            border: 2px solid salmon;
            border-radius: 10px;
            padding: 5px;
            display: none;
            position:absolute;
            background-color:cornsilk
        }
        .EditPage {
        width:100%;
        height:100%;
     
        }
        .EditDIV-Header {
            display: block;
            width: 100%;
            text-align: center;
            float: left;
        }

        .EditDIV-Header-Title {
            display: inline;
            float: left;
            font-size: 1.2em;
            font-weight: 600;
            color: darkred
        }

        .EditDIV-Header-Close {
            display: inline;
            float: right;
        }

        .EditDIV-Header-Close-Img {
            height: 20px;
            width: 20px;
            margin: -3px 0 -3px 0;
            border: 1px solid dodgerblue;
            border-radius: 5px;
            /*   background-image: url(../images/close.png);
    background: url('../images/close.png') no-repeat;*/
        }

            .EditDIV-Header-Close-Img:hover {
                filter: contrast(200%);
                border: 2px solid #0094ff;
                box-shadow: 0 0 0 3px rgba(24,117,255,0.25);
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="MessageDIV">
            <h1>Only Authrized User can access current Application or Page!
            </h1>
            <div class="Messsage-Content">
                You login as a 
                    <asp:Label ID="LabelUserRole" runat="server" Text="Label"></asp:Label>
                <br />
                with Login Identification (
                <asp:Label runat="server" ID="LabelUserID"> </asp:Label>
                <asp:Label runat="server" ID="LabeluserName"> </asp:Label>)
                    <br />
                is not allow runing current Application or Page!
                    <br />
                Current Permission:
                     <asp:Label runat="server" ID="LabelGetPermission"> </asp:Label>
                <br />
                You can request access permission by 
                     <a id="RequestLink" runat="server" href="../PagesForms/RequestAccessPermission.aspx">click on here </a>

                <br />
                You can request Class Match by 
                    <a id="RequestClassMatchLink" runat="server" href="../PagesForms/RequestClassMatch.aspx">click on here </a>
                <br />
                Make Feedback by 
                    <a id="FeedbackLinK" runat="server" href="../PagesForms/RequestClassMatch.aspx">click on here </a>
            </div>
            <asp:HiddenField ID="HiddenField1" runat="server" />
        </div>
        <div id="EditDIV" runat="server" class="EditDIV bubble">
            <div class="EditDIV-Header">
                <div id="EditTitle" class="EditDIV-Header-Title"></div>
                <div class="EditDIV-Header-Close">
                    <img id="closeMe" class="EditDIV-Header-Close-Img" onclick="CloseMe()" src="../images/close.png" />
                </div>
            </div>

            <iframe class="EditPage" id="editiFrame" name="editiFrame" frameborder="0" scrolling="no" src="" runat="server"></iframe>
        </div>


    </form>
    <script type="text/javascript">


        function CloseMe() {
            $("#EditDIV").hide();
        }

        function OpenForm(form, action, type, ids, schoolYear, schoolCode, appID, modelID, xID, xName, xType) {
            var arg ="?rID=" + form +  "&schoolYear=" + schoolYear + "&schoolCode=" + schoolCode + "&appID=" + appID + "&modelID=" + modelID + "&userID=" + xID + "&userRole=" + xType;
            var goPage = "https://webt.tcdsb.org/QA/SRS" + arg;
           
            OpenPageForm(goPage, GetTitle(form));
        }
       function OpenPageForm(goPage, title) {
            $("#editiFrame").attr('src', goPage);
            $("#EditTitle").html(title);
            $("#EditDIV").css({
                top: 10,
                left: 10,
                height: 450,
                width: 680
            });
            $("#EditDIV").fadeToggle("fast");
        }
   
        function GetrID(form) {
            switch (form) {
                case "Request": return "Permission";
                case "ClassMatch": return "ClassMatch";
                default: return "Feedback";
            }
        }
        function GetTitle(form) {
            switch (form) {
                case "Permission": return "Access Permission Request";
                case "ClassMatch": return "Request Class Match";
                default: return "Provide Feedback";
            }
        }
        //function OpenRequestForm(action, type, ids, schoolYear, schoolCode, appID, modelID, xID, xName, xType) {
        //    var arg = "&schoolYear=" + schoolYear + "&schoolCode=" + schoolCode + "&appID=" + appID + "&modelID=" + modelID + "&userID=" + xID + "&userRole=" + xType;
        //    var page = "https://webt.tcdsb.org/QA/SRS?rID=Permission";  // ../PagesForms/RequestAccessPermission.aspx";
        //    var goPage = page + arg;
        //    OpenForm(goPage, "Access Permission Request");
        //}

        //function OpenClassMatchForm(action, type, ids, schoolYear, schoolCode, appID, modelID, xID, xName, xType) {
        //    var arg = "&schoolYear=" + schoolYear + "&schoolCode=" + schoolCode + "&appID=" + appID + "&modelID=" + modelID + "&userID=" + xID + "&userRole=" + xType;
        //    var page = "https://webt.tcdsb.org/QA/SRS?rID=ClassMatch";  // ../PagesForms/RequestAccessPermission.aspx";
        //    var goPage = page + arg;
        //    OpenForm(goPage, "Class Match Request");
        //}
        //function OpenFeedBackForm(action, type, ids, schoolYear, schoolCode, appID, modelID, xID, xName, xType) {
        //    var arg = "&schoolYear=" + schoolYear + "&schoolCode=" + schoolCode + "&appID=" + appID + "&modelID=" + modelID + "&userID=" + xID + "&userRole=" + xType;
        //    var page = "https://webt.tcdsb.org/QA/SRS?rID=Feedback";  // ../PagesForms/RequestAccessPermission.aspx";
        //    var goPage = page + arg;
        //    OpenForm(goPage, "User Feedback");
        //}

 
    </script>
</body>
</html>

