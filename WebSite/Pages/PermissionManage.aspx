<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PermissionManage.aspx.cs" Inherits="ASM.Pages.PermissionManage" Async="true" %>

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
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/BubbleHelp.css" rel="stylesheet" />
    <link href="../Content/ListPage.css" rel="stylesheet" />
    <link href="../Content/ActionMenu.css" rel="stylesheet" />
    <link href="../Content/SearchArea.css" rel="stylesheet" />
    <link href="../Content/ContentPage.css" rel="stylesheet" />

    <style type="text/css">
        .function-list {
        }



        #SearchBar {
            position: absolute;
            top: 5px;
            left: 600px;
        }

        .highlightBoard {
            border: 2px #ff6a00 solid;
        }

        #editiFrame {
            width: 100%;
            height: 95%;
        }



        .EditPage {
            width: 100%;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">

        <asp:ScriptManager runat="server">
            <Services>
                <%-- <asp:ServiceReference Path="~/Models/WebService.asmx" /> --%>
            </Services>
        </asp:ScriptManager>
        <div class="SearchArea-SchoolRow">

            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    Role Type : 
            <asp:DropDownList ID="ddlRoleType" runat="server" Width="250px" AutoPostBack="True" OnSelectedIndexChanged="DDLRoleType_SelectedIndexChanged">
                <asp:ListItem Value="App">Application Role</asp:ListItem>
                <asp:ListItem Value="SAP" Selected="True">SAP Nature Role</asp:ListItem>
            </asp:DropDownList>
                    Apps: 
            <asp:DropDownList ID="ddlApps" runat="server" Width="250px" AutoPostBack="True" OnSelectedIndexChanged="DDLApps_SelectedIndexChanged">
            </asp:DropDownList>

                </ContentTemplate>
            </asp:UpdatePanel>

        </div>

        <div class="staff-container" style="margin-top: 5px;">
            <div class="staff-list">
                <div class="List-Action">
                    <a class="List-Action-Title" href="javascript:AddDetail();">
                        <asp:ImageButton ID="ImageNew" runat="server" src="../images/add.png" CssClass="List-Action-Image" />
                        Add New Model or Page Permission on the Role</a>
                </div>

                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="GridView-List-Containor" style="width: 800px; height: 500px" onscroll="OnScrollDiv(this)" id="DivMainContent">
                            <asp:GridView ID="GridView1" CssClass="GridView-List" runat="server" CellPadding="1" Height="100%" Width="100%" GridLines="Both" AutoGenerateColumns="False" BackColor="White" BorderColor="gray" BorderStyle="Ridge" BorderWidth="1px" CellSpacing="1" EmptyDataText="No Security group show" EmptyDataRowStyle-CssClass="emptyData" ShowHeaderWhenEmpty="true">
                                <Columns>
                                    <asp:BoundField DataField="RowNo" HeaderText="No." ItemStyle-CssClass="myRowNo">
                                        <ItemStyle Width="3%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="RoleID" HeaderText="Role ID">
                                        <ItemStyle Width="10%" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="RoleName" HeaderText="Role Name">
                                        <ItemStyle Width="25%" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="AppID" ReadOnly="True" HeaderText="App ID">
                                        <ItemStyle Width="10%" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ModelID" ReadOnly="True" HeaderText="Page or Model ID">
                                        <ItemStyle Width="15%" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Permission" ReadOnly="True" HeaderText="Permission">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="AccessScope" ReadOnly="True" HeaderText="Access Scope">
                                        <ItemStyle Width="10%" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Comments" ReadOnly="True" HeaderText="Comments">
                                        <ItemStyle Width="10%" />
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
                                <HeaderStyle CssClass="GridView-header" />
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
            <div class="function-list">
                <iframe id="IframeSubArea" name="IframeSubArea" style="height: 100%; width: 100%" frameborder="0" scrolling="no" src="" runat="server"></iframe>
            </div>
        </div>
           <div id="Action-Pgae-Container"></div>
 
        <div>
            <asp:HiddenField ID="hfSchoolYear" runat="server" />
            <asp:HiddenField ID="hfCategory" runat="server" />
            <asp:HiddenField ID="hfPageID" runat="server" />
            <asp:HiddenField ID="hfAppID" runat="server" />
            <asp:HiddenField ID="hfUserID" runat="server" />
            <asp:HiddenField ID="hfUserRole" runat="server" />
            <asp:HiddenField ID="hfUserLoginRole" runat="server" />
            <asp:HiddenField ID="hfRunningModel" runat="server" />
            <input id="clipboardText" type="text" style="position: absolute; top: 1px; left: -11px; width: 1px; height: 1px" />
        </div>
    </form>
</body>
</html>

<script src="../Scripts/MoursPoint.js"></script>
<script src="../Scripts/GridView.js"></script>
<script src="../Scripts/Appr_ListPage.js"></script>
<script src="../Scripts/Appr_Help.js"></script>

<script src="../Scripts/ActionMenu.js"></script>
<script src="../Scripts/ActionInPage.js"></script>

<script type="text/javascript">
    var UserID = $("#hfUserID").val();
    var UserRole = $("#hfUserRole").val();

    var myKey;
    var currentTR;
    var myIDs;
    var currentTR;
    var currentSearchBoxID;

    function pageLoad(sender, args) {

        $(document).ready(function () {

            $(".GridView-List img").click(function (en) {
                $(this).addClass("img-selected");
                var objC = $(this)[0].offsetParent; //$(this)[0].offsetParent.offsetLeft       // var objC = $(".myAction")[0]; // .offsetLeft              
                actionItemPosition = objC.offsetLeft + objC.offsetWidth;
            })
            $('.GridView-List tr').mouseenter(function (event) {
                if (currentTR !== undefined) { currentTR.removeClass("GridView-Selected"); }
                currentTR = $(this);
                currentTR.addClass("GridView-Selected");
                $("#ActionMenuDIV").hide();
            });
        });

    }
    var page = "Security_RoleP.aspx";
    function AddDetail() {
        if ($("#hfUserRole").val() == "Principal") {
            alert("Current User is View Permission only");
        }
        else {
            var schoolYear = $("#hfSchoolYear").val();
            var schoolCode = $("#hfSchoolCode").val();
            var appID = $("#ddlApps").val();
            var modelID = "Pages";
            var ids = 0;
            var xID = "0";
            var xName = "'New Security Role'"
            var xType = $("#ddlRoleType").val();
            //var arg = "&Action=Add" + "&IDs=" + ids + "&SchoolYear=" + schoolYear + "&SchoolCode=" + schoolCode + "&AppID=" + appID + "&ModelID=" + modelID + "&xID=" + xID + "&xName=" + xName + "&xType=" + roleType;
            var arg = GetArg("Add", "0", schoolYear, schoolCode, appID, modelID, xID, xName, xType);

            OpenFormFromListPage(xName, page, arg, 400, 550);
        }
    }
    function OpenDetail(action, type, ids, schoolYear, schoolCode, appID, modelID, xID, xName, xType) {
        arg = GetArg(action, ids, schoolYear, schoolCode, appID, modelID, xID, xName, xType);

     //   var arg = "&Action=" + action + "&IDs=" + ids + "&SchoolYear=" + schoolYear + "&SchoolCode=" + schoolCode + "&AppID=" + appID + "&ModelID=" + modelID + "&xID=" + xID + "&xName=" + xName + "&xType=" + xType;

        OpenFormFromListPage(xName, page, arg, 400, 550);
    }

</script>
