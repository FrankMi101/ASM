<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppRoleManageSub.aspx.cs" Inherits="ASM.Pages.AppRoleManageSub" Async="true" %>

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
        .defaultBoard {
            border: 1px blue none;
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

        .Content-Area-SAP img {
            height: 18px;
            width: 18px;
            margin-top: -2px;
            margin-left: 5px;
        }

        #btnGradeTab {
            display: none;
        }

        .EditPage {
            width: 100%;
            height: 100%;
        }

        .Gridview-title {
            margin-top: 5px;
            display: block;
            width: 100%;
        }

            .Gridview-title img {
                height: 18px;
                width: 18px;
                margin-top: -3px;
                margin-left: 5px;
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
                <asp:ServiceReference Path="~/Models/WebService.asmx" />
            </Services>
        </asp:ScriptManager>
        <div class="MessageRow">
            User SAP Role:  
                     <asp:Label ID="LabelPositionRole" runat="server" Text="Position Role"></asp:Label>
            <asp:Button ID="btnGradeTab" runat="server" Text="" Height="0px" Width="0px" CssClass="HideButton" OnClick="BtnGradeTab_Click" />
        </div>
        <div style="margin-left: -2px;">
            <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                <ContentTemplate>
                    <div class="Horizontal_Tab" id="GradeTab" runat="server"></div>
                    <asp:HiddenField ID="hfSelectedTab" runat="server" />
                    <asp:HiddenField ID="hfSelectedTabL" runat="server" />
                    <%-- <asp:CheckBox ID="chbNomatch" runat="server" Text="No Matched Position Description" />--%>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="Content-Area Content-Area-SAP">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div style="overflow: scroll; width: 100%; height: 250px" onscroll="OnScrollDiv(this)" id="DivMainContent-sap">
                        <asp:GridView ID="GridView_SAP" CssClass="GridView-List content-grid" runat="server" CellPadding="1" Height="100%" Width="100%" GridLines="Both" AutoGenerateColumns="False" BackColor="White" BorderColor="gray" BorderStyle="Ridge" BorderWidth="1px" CellSpacing="1" EmptyDataText="No Appraisal Staff in current search condition" EmptyDataRowStyle-CssClass="emptyData" ShowHeaderWhenEmpty="true">
                            <Columns>
                                <asp:BoundField DataField="RowNo" HeaderText="No." ItemStyle-CssClass="myRowNo">
                                    <ItemStyle Width="3%" />
                                </asp:BoundField>

                                <asp:BoundField DataField="MatchDesc" ReadOnly="True" HeaderText="Position/Class Description">
                                    <ItemStyle Width="64%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="MatchRole" ReadOnly="True" HeaderText="Match Role">
                                    <ItemStyle Width="15%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="MatchScope" ReadOnly="True" HeaderText="Match Scope">
                                    <ItemStyle Width="15%" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="myEditAction">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="Link1" runat="server" Text='<%# Bind("EditAction") %>'>  </asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle Width="3%" Wrap="False" />
                                </asp:TemplateField>

                            </Columns>

                            <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                            <HeaderStyle BackColor="cornflowerblue" ForeColor="white" Height="25px" />
                            <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle Height="25px" />
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
        <div class="Gridview-title">
            <a href="javascript:OpenAddPermission('Role')">
                <img src="../images/add.png" border="0" />
                Manage SAP Role Permission</a>
        </div>
        <div class="Content-Area Content-Area-SAP">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <div style="overflow: scroll; width: 100%; height: 250px" onscroll="OnScrollDiv(this)" id="DivMainContent-permission">
                        <asp:GridView ID="GridView_Permission" CssClass="GridView-List content-grid" runat="server" CellPadding="1" Height="100%" Width="100%" GridLines="Both" AutoGenerateColumns="False" BackColor="White" BorderColor="gray" BorderStyle="Ridge" BorderWidth="1px" CellSpacing="1" EmptyDataText="No Appraisal Staff in current search condition" EmptyDataRowStyle-CssClass="emptyData" ShowHeaderWhenEmpty="true">
                            <Columns>
                                <asp:BoundField DataField="RowNo" HeaderText="No." ItemStyle-CssClass="myRowNo">
                                    <ItemStyle Width="3%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="AppName" HeaderText="Application Name">
                                    <ItemStyle Width="40%" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ModelID" HeaderText="Model">
                                    <ItemStyle Width="21%" Wrap="False" />
                                </asp:BoundField>

                                <asp:BoundField DataField="AccessScope" ReadOnly="True" HeaderText="Access Scope">
                                    <ItemStyle Width="15%" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Permission" ReadOnly="True" HeaderText="Permission">
                                    <ItemStyle Width="15%" />
                                </asp:BoundField>


                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="myEditAction">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="Link4" runat="server" Text='<%# Bind("EditAction") %>'>  </asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle Width="3%" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="myDeleteAction">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="Link5" runat="server" Text='<%# Bind("DeleteAction") %>'>  </asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle Width="3%" Wrap="False" />
                                </asp:TemplateField>


                            </Columns>

                            <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                            <HeaderStyle BackColor="cornflowerblue" ForeColor="white" Height="25px" />
                            <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle Height="25px" />
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
        <div id="EditDIV" runat="server" class="EditDIV bubble epahide">
            <div class="editTitle">
                <table>
                    <tr>
                        <td style="width: 90%">
                            <div id="EditTitle"></div>
                        </td>
                        <td style="text-align: right">
                            <img id="closeMe" src="../images/close.png" style="height: 25px; width: 25px; margin: -3px 0 -3px 0" /></td>
                    </tr>
                </table>
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
<script src="../Scripts/ActionMenu.js"></script>
<script src="../Scripts/ActionInPage.js"></script>

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

            $("#closeMe").click(function (event) {
                $("#EditDIV").hide();
            });

            preaLinkID = $("#hfSelectedTabL").val();

            $("#GradeTab").click(function (e) {

                var cEvantID = e.originalEvent.srcElement.id;
                $("#hfSelectedTab").val(cEvantID);
                $("#hfSelectedTabL").val(e.originalEvent.srcElement.parentNode.id);
                $("#btnGradeTab").click();
                preaLinkID = $("#hfSelectedTabL").val();

            });
            $(".GridView-List img").click(function (en) {
                $(this).addClass("img-selected");
            })
            $('.GridView-List tr').mouseenter(function (event) {
                newRowNo = $(this).closest('tr').find('td.myRowNo').text();

                if (currentTR !== undefined) { currentTR.removeClass("GridView-Selected "); }
                currentTR = $(this);

                currentTR.addClass("GridView-Selected ");
            });
        });
    }

    function OpenAddPermission(xType) {
        var para = {
            UserID: $("#hfUserID").val(),
            UserRole: $("#hfUserRole").val(), 
            xID: $("#LabelPositionRole").text(),
            AppID: "SIC",
            ModelID :"Pages",
            IDs :"0"
        }
        var page = "../PagesForms/Permission_Role.aspx";
        var arg = "?UserID=" + para.UserID + "&UserRole=" + para.UserRole + "&AppID=" +  para.AppID + "&ModelID=" + para.ModelID + "&xID=" + para.xID + "&xType=" + xType + "&Action=" + "Add" + "&IDs=" + "0";

        OpenInPage('App Role Permission', page, arg, para.xID);

    }
    function OpenPermissionActionPage(action, goPage, target, pHeight, pWidth, userID, userRole, appID, modelID, xID, xType, IDs) {
        var page = goPage;
        var arg = "?UserID=" + userID + "&UserRole=" + userRole + "&AppID=" + appID + "&ModelID=" + modelID + "&xID=" + xID + "&xType=" + xType + "&Action=" + action + "&IDs=" + IDs;

        OpenInPage('App Role Permission', page, arg, xID);

    }
    function OpenInPage(title, page, para, RoleID) {

        var goPage = page + para;
        var vTop = 50;
        var vLeft = 50;
        var vHeight = 350;
        var vWidth = 550;
        try {

            $("#editiFrame").attr('src', goPage);
            $("#EditTitle").html(title + " " + RoleID);
            $("#EditDIV").css({
                top: vTop,
                left: vLeft,
                height: vHeight - 50,
                width: vWidth - 50
            });
            $("#EditDIV").fadeToggle("fast");
        }

        catch (e) {
            window.alert("Error:" + e.mess);
        }

    }



</script>
