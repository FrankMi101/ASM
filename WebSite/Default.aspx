<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ASM.Default" %>

<!DOCTYPE html>


<html>
<head id="Head1" runat="server">
    <title>Applicaiotn Security Manage</title>
    <meta http-equiv="Pragma" content="No-cache" />
    <meta http-equiv="Cache-Control" content="no-Store,no-Cache" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link href="Content/DeviceMedia.css" rel="stylesheet" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/BubbleHelp.css" rel="stylesheet" />

    <link href="Content/TopLink.css" rel="stylesheet" />
    <link href="Content/TopNavList.css" rel="stylesheet" />
    <link href="Content/TopNavListM.css" rel="stylesheet" />
    <link href="Content/DefaultPage.css" rel="stylesheet" />

    <script src="Scripts/jquery-3.4.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>

    <style>
        html, body {
            height: 100%;
            width: 100%;
            margin: auto;
        }

        /*.iFrameDIV {
            height: 100%;
            width: 100%;
            float: left;
            table-layout: auto;
            margin-bottom:-15px; 
        }*/

        #GoList {
         
            height: 600px;
            width: 100%;
            border: 0px solid red;
            margin: auto;
            margin-bottom: -20px;
            margin-top: 0px;
        }

        .CenterDIV {
            width: 300px;
            margin: auto;
            background-color: azure;
            border: 2px blue outset;
            padding: 30px;
        }

        header {
            height:125px;
        }

        .appheader {
            /*height: 100px;*/
            width: 100%;
            border-top: 2px solid #56c0e9;
            height: 95px;
        }

        #appriFrame {
            margin-bottom: -2px;
            width: 100%;
            height: 100%;
        }

        .inVisibleBtn {
            display: none;
        }

        #TableVersion {
            margin-right: 0px;
            margin-top: 0px;
        }

        #rblLoginAS input {
            font-family: Arial;
            font-size: smaller;
            font-weight: 100;
        }

        #rblLoginAS label:hover {
            text-decoration: underline;
            color: purple;
        }

        .LinkCell {
            font-size: smaller;
        }

        #MobileMenu {
            margin-top: 0px;
            margin-bottom: 1px;
            height: 32px;
            width: 43px;
            color: yellow;
        }

        .epahide {
            display: none;
        }

        #rblLoginAS label {
            font-family: Arial, sans-serif;
            font-size: smaller;
            padding: 1px;
            margin: -1px;
        }

        .hideme {
            display: none;
        }

        .EditPage {
            height: 95%
        }

        .Page-title-label {
            width: 100%;
            height: 50px;
            background: linear-gradient(lightsalmon, white);  
            display: block;
            text-wrap: avoid;
            margin-top:-20px;
            padding-top:15px;
            color:dodgerblue;
            text-align:left;
            font-size:small;  
            margin-bottom:-5px;
        }
        .messageSchoolArea {
        color: brown;
        }
    </style>



</head>
<body>
    <form id="form2" runat="server">
        <header>
            <div class="appheader">
                <div id="LogoCol" style="display: inline; width: 7%; float: left;" class="pull-left visible-sm visible-md visible-lg">
                    <img id="Image3" src="images/boardLogo.gif" alt="TCDSB Logo" border="0" style="width: 200px; height: 90px" />
                </div>
                <div id="messageCol" style="display: inline; text-align: right; width: 50%; float: left" class="visible-md visible-lg">

                    <asp:Button ID="btnLogout" CssClass="inVisibleBtn" runat="server" Text="" OnClick="btnLogout_Click" Visible="true" Height="0px" Width="0px" />
                    <asp:Label ID="LabelTrain" runat="server" Height="20px" Visible="False"
                        Font-Size="Large" ForeColor="#00C000"> Training</asp:Label>
                    <br />
                    <br />
                    <br />
                    <div class="messageSchoolArea" style="vertical-align: baseline; font-size: smaller; text-wrap: avoid;">

                        <a href="javascript:openParameter();">School Year:</a>
                        <asp:Label ID="LabelSchoolYear" runat="server" BackColor="Transparent"
                            ForeColor="purple"> </asp:Label>
                        <a href="javascript:openParameter();">School:   </a>

                        <asp:Label ID="LabelSchoolCode" runat="server" BackColor="Transparent"
                            ForeColor="purple"> </asp:Label>
                        <asp:Label ID="LabelSchool" runat="server" BackColor="Transparent"
                            ForeColor="purple"> </asp:Label>
                         <asp:Label ID="LabelUserIdentified" runat="server" BackColor="Transparent"
                            ForeColor="purple"> </asp:Label>
                    </div>

                </div>
                <div id="linkCol" style="display: inline; width: 400px; float: right;">
                    <table cellspacing="0" cellpadding="0" width="400px" align="right" style="display: inline-block;"
                        border="0" id="TableVersion" runat="server">
                        <tr style="height: 30px;">
                            <td style="text-align: right; vertical-align: top; width: 30px" class="visible-sm visible-md visible-lg">
                                <img height="30" src="images/curve.png" width="50" alt="" />
                            </td>

                            <td class="LinkCell" style="width: 400px">

                                <ul id="navlistLink" style="margin-right: 10px;">
                                    <li>
                                        <img id="LoginUserIcon" style="margin-bottom: 5px" src="images/user.png" width="20" height="20" />
                                        <a href="#" id="LoginUserRole" runat="server">UserRole </a>
                                        <asp:HiddenField ID="hfCurrentUserRole" runat="server" />

                                    </li>

                                    <li><a href="javascript:logoutApp()" id="Logout" runat="server">Log out </a>

                                    </li>

                                </ul>
                            </td>
                        </tr>
                        <tr>

                            <td class="messageSchoolArea" style="height: 20px; margin-right: 20px; text-align: right;  font-size: large;" colspan="3">

                                <asp:Label ID="lblApplication" runat="server" Text="Application Security Manage"></asp:Label>
                                (<a id="appLink" runat="server" href="~/Default.aspx">ASM</a>) 
                                <br />
                                <asp:Label ID="lblTCDSB" runat="server" Text="TCDSB " ForeColor="#CC0033" ToolTip="Show Application Support" Font-Size="small"></asp:Label>
                                <asp:Label ID="lblVersion" runat="server" Text=" (Version 1.0.1 )" ToolTip="Edit Application Support" Font-Size="small"></asp:Label>
                            </td>
                        </tr>
                        <tr class=" visible-sm visible-md visible-lg">
                            <td></td>
                        </tr>

                    </table>
                </div>
                <div id="LoginAsDIV" class="bubble epahide" style="height:180px; overflow:auto">
                    <asp:RadioButtonList ID="rblLoginAS" runat="server" AutoPostBack="true"  Height="200px" OnSelectedIndexChanged="RblLoginAS_SelectedIndexChanged" RepeatColumns="1"></asp:RadioButtonList>
                </div>
            </div>

            <div class="TopMenubar">
                <nav id="TopNav" class="pull-left visible-sm visible-md visible-lg">
                </nav>

                <div class="navbar-header pull-left visible-xs hideme">

                    <button id="MobileMenu" type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#collapsable-nav" aria-expanded="false">

                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <div id="collapsable-nav" class="collapse navbar-collapse" style="margin-top: -10px; margin-left: 0px; padding: 0px;">
                        <nav id="TopNavM">
                        </nav>
                    </div>
                </div>

            </div>

        </header>

        <section style="text-align: center;">
            <div class="Page-title-label">
                <%--<img src="images/finger.png" height="25" width="50" style="background-color:transparent" />--%>  
                <asp:Label ID="LabelPageTitle" CssClass="Page-title-label" runat="server" Text=""></asp:Label>
            </div>
            <div class="iFrameDIV">
                <iframe id="GoList" name="GoList" frameborder="0" scrolling="auto" src="" runat="server" style="border: 1px, red,solid"></iframe>
            </div>


        </section>
        <div>
            <asp:HiddenField ID="hfUserID" runat="server" />
            <asp:HiddenField ID="hfPageID" runat="server" />
            <asp:HiddenField ID="hfUserLoginRole" runat="server" />
            <asp:HiddenField ID="hfRunningModel" runat="server" />
            <asp:HiddenField ID="hfApprYear" runat="server" />
            <asp:HiddenField ID="hfApprSchool" runat="server" />
            <asp:HiddenField ID="hfApprEmployeeID" runat="server" />
            <asp:HiddenField ID="hfTeacherName" runat="server" />
            <asp:HiddenField ID="hfSchoolArea" runat="server" />
            <asp:HiddenField ID="hfTopMenuArea" runat="server" />
              <asp:HiddenField ID="hfLevel1MenuArea" runat="server" />

        </div>
        <div id="EditDIV" runat="server" class="EditDIV bubble epahide">
            <div class="editTitle">
                <table>
                    <tr>
                        <td style="width: 98%">
                            <div id="EditTitle"></div>
                        </td>
                        <td>
                            <img id="closeMe" src="images/close.png" style="height: 30px; width: 30px; margin: -3px 0 -3px 0" /></td>
                    </tr>
                </table>
            </div>
            <iframe class="EditPage" id="editiFrame" name="editiFrame" frameborder="0" scrolling="auto" src="" runat="server"></iframe>
        </div>
        <div style="width: 100%; height: 100%; align-content: center">
            <div id="ApprDIV" runat="server" class="ApprDIV bubble epahide" tabindex="998" style="height: 100%; width: 100%; text-align: center">

                <iframe class="ApprPage" id="appriFrame" name="appriFrame" frameborder="0" scrolling="auto" src="" runat="server" style="height: 100%"></iframe>
            </div>
        </div>

        <div id="PopUpDIV" class="bubble epahide"></div>
        <div id="ActionPOPDIV" class="bubble epahide">
            <div class="editTitle" style="display: block">
                <div id="ActionTitle" style="display: inline; float: left; width: 92%; font-weight: 600;"></div>
                <div style="display: inline; float: right; width: 30px;">
                    <img id="closeActionPOP" src="images/close.ico" style="height: 25px; width: 25px; margin: -3px 0 -3px 0" />
                </div>
            </div>
            <iframe id="ActioniFramePage" name="ActioniFramePage" style="height: 420px; width: 99%" frameborder="0" scrolling="auto" src="" runat="server"></iframe>
        </div>


    </form>
</body>
</html>

    <script src="Scripts/NavTopListData.js"></script>
    <script src="Scripts/NavTopList.js"></script>
    <script src="Scripts/ActionWebApi.js"></script>

<script type="text/javascript">
    var currentY = 0;
    var currentNodeLevel1;
    var currentNodeLevel2;
    var topMenuID = $("#hfTopMenuArea").val();

    var level1MenuID = $("#hfLevel1MenuArea").val();
    var currentMenuID = level1MenuID; 
    //var menuData = JSON.parse(TopMenuListData);
    //myTopNav(mydata[0]value);
  //  debugger;
    var menuData = myTopMenuData;
  //  alert(menuData);
    myTopNav(menuData);
</script>

<script type="text/javascript">
    $(document).ready(function () {
       GetJWTTokenAndSaveToLocalStorage();
        topSelectedMenuItem = topMenuID ;
        var vHeight = window.innerHeight - 140;
        $("#" + topMenuID).addClass("TopSelectItem");
        $("#" + level1MenuID).addClass("TopSelectItem");
        $("#GoList").css("height", vHeight);

        $("#LoginUserRole").click(function (event) {
            OpenLoginUserRolePage();
        });

        $("#LoginUserIcon").click(function (event) {
            OpenLoginUserRolePage();
        });

        $("#closeMe").click(function (event) {

            $("#PopUpDIV").fadeToggle("fast");

            if ($("#EditDIV").css('display') === "block") { $("#EditDIV").fadeToggle("fast"); }

            if ($("#ApprDIV").css('display') === "block") { $("#ApprDIV").fadeToggle("fast"); }
        });

        $("#closeActionPOP").click(function (event) {

            if ($("#PopUpDIV").css('display') === "block") $("#PopUpDIV").fadeToggle("fast");

            if ($("#ActionPOPDIV").css('display') === "block") { $("#ActionPOPDIV").fadeToggle("fast"); }

        });

        $("#MobileMenu").click(function (event) {
            if ($("#GoList").attr("src") === "") {
                $("#TopNavM").hide();
                $("#GoList").attr("src", "DefaultSummary.aspx");
            }
            else {
                $("#TopNavM").show();
                $("#GoList").attr("src", "");
            }
        });

        $("#LabelTrain").click(function () {
            if ($("#hfUserID").val() == "mif") {
                teachername = $("#hfTeacherName").val();
                schoolyear = $("#hfApprYear").val();
                schoolcode = $("#hfApprSchool").val();
                employeeid = $("#hfApprEmployeeID").val();
                sessionid = "";
                pageid = $("#hfPageID").val();
                userid = $("#hfUserID").val();
                openEditPageA('450', '800', 'SICSetup/Loading.aspx?pID=Encryption', 'Encription String');
            }
        });
    });
    function OpenLoginUserRolePage() {
        if ($("#hfUserLoginRole").val() === "Admin") {
            var vTop = $("#LoginUserRole")[0].offsetParent.offsetTop + 25;      // event.originalEvent.clientY +5;
            var vLeft = $("#LoginUserRole")[0].offsetParent.offsetLeft + 135;    //    event.originalEvent.clientX + 50;
            $("#LoginAsDIV").css({
                top: vTop,
                left: vLeft - 100,
                height: 350,
                width: 150
            });

            $("#LoginAsDIV").fadeToggle("fast");
        }
    }
    function changeAppsRole() {
        if ($("#hfUserLoginRole").val() === "Admin") {
            var vTop = $("#LoginUserRole")[0].offsetParent.offsetTop + 25;
            var vLeft = $("#LoginUserRole")[0].offsetParent.offsetLeft + 150;
            window.alert($("#hfUserLoginRole").val());
            window.alert($(vTop + "  " + vLeft).val());
            $("#LoginAsDIV").css({
                top: vTop,
                left: vLeft - 100,
                height: 150,
                width: 150
            });

            $("#LoginAsDIV").fadeToggle("fast");
        }

    }
    function logoutApp() {
        $("#btnLogout").click();
    }
    function OpenPopPage(type) {
        teachername = $("#hfTeacherName").val();
        schoolyear = $("#hfApprYear").val();
        schoolcode = $("#hfApprSchool").val();
        employeeid = $("#hfApprEmployeeID").val();
        sessionid = "";
        pageid = $("#hfPageID").val();
        userid = $("#hfUserID").val();
        $(".editTitle").css({ "display": "none" });
        openEditPageA('600', '800', 'EPAmanage/Loading2.aspx?pID=Feedback', 'FeedBack');
    }
    function openEditPageA(vHeight, vWidth, goPage, pTitle) {
        var vLeft = (screen.width / 2) - (vWidth / 2) - 100;
        var vTop = (screen.height / 2) - (vHeight / 2) - 100;
        goPage = goPage + "&yID=" + schoolyear + "&cID=" + schoolcode + "&tID=" + employeeid + "&sID=" + sessionid + "&tName=" + teachername + "&pageID=" + pageid;
        $(document).ready(function () {
            try {
                $("#ActioniFramePage").attr('src', goPage);
                $("#ActionTitle").html(pTitle);
                $("#ActionPOPDIV").css({
                    top: 100,
                    left: 200,
                    height: vHeight,
                    width: vWidth,
                    "border-width": "2px",
                    "border-color": "Orange",
                    "border-style": "solid"
                })
                $("#ActioniFramePage").css({
                    height: vHeight - 3,
                    width: vWidth - 5,
                    border: 0
                })
                $("#ActionPOPDIV").fadeToggle("fast");
            }
            catch (e) { }
        });
    }

    function GetJWTTokenAndSaveToLocalStorage() {
        // use  JWT token to authticatio the user to Call Web API from client Restful API HTTP POST verb 
        // Get JWT token and save to local storage of browser
         var para = {
             UserName: $("#hfUserID").val(),
             UserRole: $("#hfUserLoginRole").val(),
             Password: "1234"
        };
 
        var uri = "token";
         var token = WebAPICall.JWToken(uri, para);
    }

    function Logout() {
        WebAPICall.Logout();
    }
</script>
