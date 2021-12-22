<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StaffManageSub2.aspx.cs" Inherits="ASM.Pages.StaffManageSub2" Async="true" EnableTheming="true" %>

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
    <link href="../Content/ListPage.css" rel="stylesheet" />
    <link href="../Content/ContentPage.css" rel="stylesheet" />
    <link href="../Content/TabMenu.css" rel="stylesheet" />
    <link href="../Content/ActionMenu.css" rel="stylesheet" />
    <link href="../Content/SearchArea.css" rel="stylesheet" />

    <style type="text/css">
        body {
            height: 100%;
            width: 99%;
        }

        div {
            font-family: Arial;
            font-size: small;
        }
 
        .SubstituedCell {
            color: red;
            text-decoration: underline;
        }

        .emptyData {
            font-size: xx-large;
            text-align: center;
            color: blue;
        }


        .FixedHeader {
            position: absolute;
            font-weight: bold;
            width: 100%;
            display: block;
        }

        .highlightBoard {
            border: 1px blue solid;
            color: white;
        }

        .highlightRow {
            background-image: url(images/highLightRow.png);
        }

        .defaultBoard {
            border: 1px blue none;
        }
 
        .top5Row {
            border-top: 5px solid darkcyan;
        }

        .HideButton {
            margin: 0px;
            padding: 0px;
            border: 0px;
        }
 

        .MessageRow {
            background: dodgerblue; /* For browsers that do not support gradients */
            background: -webkit-linear-gradient(dodgerblue, lightblue); /* For Safari 5.1 to 6.0 */
            background: -o-linear-gradient(dodgerblue, lightblue); /* For Opera 11.1 to 12.0 */
            background: -moz-linear-gradient(dodgerblue, lightblue); /* For Firefox 3.6 to 15 */
            background: linear-gradient(dodgerblue, lightblue); /* Standard syntax */
        }

        .content-grid th {
            background: linear-gradient(lightskyblue, white);
            color: black;
            font-size: 12px;
        }

        .ddlControls {
            height: 20px;
        }
        .centerDIV {
            height:20px;
            margin:10px;
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
               <%-- <asp:ServiceReference Path="~/Models/WebService.asmx" /> --%>
            </Services>
        </asp:ScriptManager>
        <div class="MessageRow">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    User ID:  
                    <asp:TextBox CssClass="SearchBox" ID="TextBoxUserID" runat="server" Width="70px" placeholder="User ID"></asp:TextBox>
                    Staff Name:<asp:TextBox CssClass="SearchBox" ID="TextBoxStaffName" Width="120px" runat="server" placeholder="Staff name"></asp:TextBox>
                    CPNum:    
                    <asp:TextBox CssClass="SearchBox" ID="TextBoxCPNum" runat="server" Width="70px" placeholder="CP Number."></asp:TextBox>
                    SAP Role:
                    <asp:TextBox CssClass="SearchBox" ID="TextBoxStaffRole" runat="server" Width="80px"   placeholder="SAP Role"></asp:TextBox>
                    SAP Unit:<asp:TextBox CssClass="SearchBox" ID="TextBoxUnit" Width="100px" runat="server" placeholder="SAP Unit"></asp:TextBox>
                    <asp:Button ID="btnGradeTab" runat="server" Text="" Height="0px" Width="0px" CssClass="HideButton" OnClick="BtnGradeTab_Click" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="centerDIV">
            Application:
            <asp:DropDownList ID="ddlApps" runat="server" Width="300px" CssClass="SearchDDL">
            </asp:DropDownList>
            App Role:
            <asp:DropDownList ID="ddlAppRole" runat="server" Width="180px" CssClass="SearchDDL">
            </asp:DropDownList>
        </div>
        <div style="margin-left: -2px;">
            <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                <ContentTemplate>
                    <div class="Horizontal_Tab" id="GradeTab" runat="server"></div>
                    <asp:HiddenField ID="hfSelectedTab" runat="server" />
                    <asp:HiddenField ID="hfSelectedTabL" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="Content-Area Content-Area-SAP">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="GridView-List-Containor" style=" height: 500px" onscroll="OnScrollDiv(this)" id="DivMainContent-sap">
                        <asp:GridView ID="GridView1" CssClass="content-grid" runat="server" CellPadding="1" Height="100%" Width="100%" GridLines="Both" AutoGenerateColumns="False" BackColor="White" BorderColor="gray" BorderStyle="Ridge" BorderWidth="1px" CellSpacing="1" EmptyDataText="No Apps security setup for the user" EmptyDataRowStyle-CssClass="emptyData" ShowHeaderWhenEmpty="true">
                            <Columns>
                                <asp:BoundField DataField="RowNo" HeaderText="No." ItemStyle-CssClass="myRowNo">
                                    <ItemStyle Width="5%" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Selected">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chbPickup" Checked='<%# Convert.ToBoolean(Eval("Selected"))%>' runat="server" CssClass="mySelected"></asp:CheckBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" HorizontalAlign="center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="SchoolCode" ReadOnly="True" HeaderText="School Code" ItemStyle-CssClass="mySchoolCode">
                                    <ItemStyle Width="10%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="SchoolName" ReadOnly="True" HeaderText="School Name">
                                    <ItemStyle Width="75%" />
                                </asp:BoundField>
                            </Columns>
                            <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                            <HeaderStyle CssClass="GridView-header" />
                            <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />

                            <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#594B9C" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#33276A" />
                        </asp:GridView>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

        <div id="ActionMenuDIV" class="bubble epahide">
            <asp:Label runat="server" ID="LabelTeacherName" Text=""> </asp:Label>
            <div id="ActionMenuUL" class="LeftSideMenu">
            </div>

        </div>
        <div id="PopUpDIV" class="bubble epahide"></div>
       <div id="EditDIV" runat="server" class="EditDIV bubble epahide">
            <div class="EditDIV-Header">
                <div id="EditTitle" class="EditDIV-Header-Title"></div>
                <div class="EditDIV-Header-Close">
                    <img id="closeMe"  class="EditDIV-Header-Close-Img"  src="../images/close.png" />
                </div>
            </div>

            <iframe class="EditPage" id="editiFrame" name="editiFrame" frameborder="0" scrolling="no" src="" runat="server"></iframe>
        </div>
        <div>
            <asp:HiddenField ID="hfCategory" runat="server" />
            <asp:HiddenField ID="hfPageID" runat="server" />
            <asp:HiddenField ID="hfUserID" runat="server" />
            <asp:HiddenField ID="hfUserRole" runat="server" />
            <asp:HiddenField ID="hfCode" runat="server" />
            <asp:HiddenField ID="hfCPNum" runat="server" />
            <asp:HiddenField ID="hfSchoolYear" runat="server" />
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

    var UserID = $("#hfUserID").val();
    var UserRole = $("#hfUserRole").val();
    var ItemCode = $("#hfCode").val();
    var minD = new Date($("#hfSchoolyearStartDate").val()); // today.getDate() - 90; //
    var maxD = new Date($("#hfSchoolyearEndDate").val());
    var preaLinkID;
    var Action;
    function pageLoad(sender, args) {

        $(document).ready(function () {



            $("#GridView tr").mouseenter(function (event) {
                //if ($("#ActionMenuDIV", parent.document).is(":visible")) $("#ActionMenuDIV", parent.document).hide();
                if ($("#ActionMenuDIV").is(":visible")) $("#ActionMenuDIV").hide();
            });

            preaLinkID = $("#hfSelectedTabL").val();

            $("#GradeTab").click(function (e) {

                var cEvantID = e.originalEvent.srcElement.id;
                $("#hfSelectedTab").val(cEvantID);
                $("#hfSelectedTabL").val(e.originalEvent.srcElement.parentNode.id);
                $("#btnGradeTab").click();
                preaLinkID = $("#hfSelectedTabL").val();

            });

            $('td > .mySelected').click(function (event) {
                try {
                    var eventCell = $(this);
                    var check = eventCell[0].childNodes['0'].checked;
                    var action = "Edit";
                    if (check) { action = "1"; }
                    var staffuserID = $("#TextBoxUserID").val();
                    var schoolcode = $(this).closest('tr').find('td.mySchoolCode').text();
                    SaveDataToDatabase(action, staffuserID, schoolcode)
                }
                catch (e) {
                    alert("select school error ");
                }
            });
        });
    }

    function SaveDataToDatabase(action, staffuserID, schoolcode) {
        try {
            var para = {
                Operate: action,
                UserID: $("#hfUserID").val(),
                IDs: "0",
                SchoolYear: $("#hfSchoolYear").val(),
                SchoolCode: schoolcode,
                StaffUserID: staffuserID,
                AppID: $("#ddlApps").val(),
                AppRole:$("#ddlAppRole").val()
            };
            alert(para.AppID +  "  " + para.AppRole);
            var uri = "WorkingSchool";
           // alert(para.Operate + " StaffUserID =" + para.StaffUserID + "  School select = " + para.SchoolCode);
           // SaveDataWebAPICall("POST", uri, para, "Self");
            WebAPICall.AddData(uri, para, "Self");

            event.stopPropagation();
        }
        catch (e) {
            alert(action + " button click something going wrong");
        }
    }

</script>
