<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Search_Staff.aspx.cs" Inherits="ASM.PagesForms.Search_Staff" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Chose a Teacher</title>
    <base target="_self" />
    <meta http-equiv="Pragma" content="No-cache" />


    <link href="../Styles/BubbleHelp.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/TabMenu.css" rel="stylesheet" type="text/css" />
    
    <script src="../Scripts/jQuery/jquery-1.11.2.min.js" type="text/javascript"></script>
    <script src="../JQuery-UI/jquery-ui-1.11.4.min.js" type="text/javascript"></script>
    <script src="../Scripts/HelpShow.min.js" type="text/javascript">  </script>
    <script src="../Scripts/TabMenu.js" type="text/javascript">  </script>


    <style type="text/css">
        body {
            margin: 0 0 0 0;
        }

        table {
            border-collapse: collapse;
            border-spacing: 0; /* cellspacing="0" */
            border-width: 0px;
        }

        .DivOver {
            border-bottom-style: solid;
            border-bottom-width: 1px;
            color: Purple;
            font-weight: bold;
            padding-left: 10px;
        }

        .DivOut {
            border-bottom-style: none;
            color: Black;
            font-weight: normal;
            padding-left: 30px;
        }
    </style>
    <script type="text/javascript">

        function setSearchFocus() {
            var searchVal = $('#hftxtSearch').val();
            $("#txtSearch").focus().val("").val(searchVal);
        }
    </script>
</head>
<body>
    <form id="Form1" method="post" runat="server">

        <div style="height: 300px; width: 100%; overflow: auto">
            <asp:HiddenField ID="hfMySchoolTeacherCount" runat="server" />
            <asp:HiddenField ID="hfcurrentTab" runat="server" />
            <asp:HiddenField ID="hfcurrentDiv" runat="server" />
            <asp:HiddenField ID="hftxtSearch" runat="server" />

            <table class="TableBlank" style="height: 99.5%; width: 99.5%">
                <tr>
                    <td nowrap="nowrap" class="TDFrame2" id="Tab1" runat="server">
                        <asp:Label ID="LabelFunctionName1" runat="server" Text="TabFunction1" Width="100px"> </asp:Label>
                    </td>
                    <td nowrap="nowrap" class="TDFrame4" id="Tab2" runat="server">
                        <asp:Label ID="LabelFunctionName2" runat="server" Text="TabFunction2" Width="100px"> </asp:Label>
                    </td>
                    <td nowrap="nowrap" class="TDFrame4" id="Tab3" runat="server">
                        <asp:Label ID="LabelFunctionName3" runat="server" Text="TabFunction3" Width="95%"> </asp:Label>
                    </td>
                    <td nowrap="nowrap" class="TDFrame4" id="Tab4" runat="server">
                        <asp:Label ID="LabelFunctionName4" runat="server" Text="TabFunction4" Width="95%"> </asp:Label>
                    </td>
                    <td nowrap="nowrap" class="TDFrame3" style="width: 100%; vertical-align: middle">
                        <table>
                            <tr>
                                <td align="right" style="width: 100%">Search by Surname
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSearch" runat="server" Width="60px"></asp:TextBox>
                                </td>
                                <td align="left" style="width: 20%">
                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="../images/search1.bmp" Height="20px"  />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="height: 95%;">
                    <td colspan="5" class="TDFrame1">
                        <div style="height: 265px; overflow: auto">



                            <div id="myDIVList_1" runat="server" style="overflow: auto; height: 97%">
                            </div>
                            <div id="myDIVList_2" runat="server" style="overflow: auto; height: 1px">
                            </div>
                            <div id="myDIVList_3" runat="server" style="overflow: auto; height: 1px">
                            </div>
                            <div id="myDIVList_4" runat="server" style="overflow: auto; height: 1px">
                            </div>
                        </div>

                    </td>
                </tr>

            </table>
        </div>
    </form>
</body>
</html>


    <script type="text/javascript">


        var cTab = $("#hfcurrentTab").val();
        var cDIV = $("#hfcurrentDiv").val();
        var currentTab = document.getElementById(cTab);
        var currentDIV = document.getElementById(cDIV);
        var oldDIV;
        var oldTab;
        setTabMouseEnter(currentTab, "TDFrame2", "TDFrame4", cDIV);


        function pageLoad(sender, args) {         
        }
        $(document).ready(function () {
            var mySchoolTeacherCount = $("#hfMySchoolTeacherCount").val();
            //  alert(mySchoolTeacherCount);
            if (mySchoolTeacherCount == 0) {
                currentTab = document.getElementById("Tab2");
                currentDIV = document.getElementById("myDIVList_2");
            }
            else {
                currentTab = document.getElementById("Tab1");
                currentDIV = document.getElementById("myDIVList_1");
            }

            //$("#txtSearch").keydown(function () {
            //    var searchBtn = $("#ImageButton1");
            //    searchBtn.click();
            //   // $("txtSearch").focus().val("").val(searchVal);

              
            //});
            $("#txtSearch").keyup(function () {               
                var searchBtn = $("#ImageButton1");
                searchBtn.click();
            

            });

        });
 
        function setDIV() {
            var ev = window.event;
            var obj = ev.srcElement.id;
            vDIV = document.getElementById(obj);
            if (vDIV.className == "DivOut")
                vDIV.className = "DivOver";
            else
                vDIV.className = "DivOut";
        }
        function setTabMouseEnter(sender, oCSS, oCSS1, cPage) {
            try {

                if (currentTab == null) {
                    currentTab = document.getElementById("Tab1");
                    currentDIV = document.getElementById("myDIVList_1");
                }
                currentTab.className = oCSS1;
                sender.className = oCSS;
               // currentTab = sender;
               // currentDIV.style.height = "1px";
                var showDIV = document.getElementById(cPage);
                showDIV.style.height = "97%";
                currentDIV = showDIV; 
                
                if (sender.id == "Tab2") {
                    oldDIV = document.getElementById("myDIVList_1");
                    oldTab = document.getElementById("Tab1");
                 }
                else {
                    oldDIV = document.getElementById("myDIVList_2");
                    oldTab = document.getElementById("Tab2");
                 }
                oldDIV.style.height = "1px";
                oldTab.className = oCSS1;



                //if (currentTab != sender) {

                //    currentTab.className = oCSS1;
                //    sender.className = oCSS;
                //    currentTab = sender;
                //    currentDIV.style.height = "1px";
                //    var showDIV = document.getElementById(cPage);
                //    showDIV.style.height = "97%";
                //    currentDIV = showDIV;
                //}
            }
            catch (e) { }
        }

        function setTabMouseOut(sender, oCSS) {
            try {
                sender.className = oCSS;
                cueentDIV.visible = false;

            }
            catch (e) { }
        }
        function Close() {
            window.close();
        }

        function Subject_ClickHandler() {
            try {
                var ev = window.event;

                var oDIV = ev.srcElement;
                var selectedName = oDIV.innerHTML;
                var selectedCPNum = oDIV.id;
                try {

                    $("#hfAutoCompletSelectedID", parent.document).val(selectedCPNum);
                    $("#hfAutoCompletSelectedName", parent.document).val(selectedName);
                    $("#lblTeacherName", parent.document).val(selectedName);
                    $("#BubbleHelpDIV", parent.document).fadeToggle("fast");

                }
                catch (e) {

                }
                // window.returnValue = mentor;
                return 0;

            }
            catch (e) { }
        }
        function refreshMe() {
            var vbutton = document.getElementById("ImageButton1").click();
            vbutton.click();
        }

        function CallShowMessage(action, message) {
            window.alert(action + " " + message);
        }
    </script>

