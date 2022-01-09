<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GroupManage.aspx.cs" Inherits="ASM.Pages.GroupManage" Async="true" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>School Staff List</title>
    <meta http-equiv="Pragma" content="No-cache" />
    <meta http-equiv="Cache-Control" content="no-Store,no-Cache" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <script src="../Scripts/jquery-3.4.1.min.js"></script>
    <link href="../Content/BubbleHelp.css" rel="stylesheet" />
    <link href="../Content/ListPage.css" rel="stylesheet" />
    <link href="../Content/ContentPage.css" rel="stylesheet" />
    <link href="../Content/TabMenu.css" rel="stylesheet" />
    <link href="../Content/ActionMenu.css" rel="stylesheet" />
    <link href="../Content/SearchArea.css" rel="stylesheet" />

    <style type="text/css">
        body {
            height: 100%;
            width: 100%;
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
 
        .highlightBoard {
            border: 2px #ff6a00 solid;
        }
        .staff-container {
            grid-template-columns: 47% auto;
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
                    Apps: 
            <asp:DropDownList ID="ddlApps" runat="server" Width="200px" CssClass="SearchDDL">
            </asp:DropDownList>
                    School:
            <asp:DropDownList ID="ddlSchoolCode" runat="server" Width="60px" CssClass="SearchDDL" AutoPostBack="True" OnSelectedIndexChanged="DDLSchoolCode_SelectedIndexChanged">
            </asp:DropDownList>
                    <asp:DropDownList ID="ddlSchool" runat="server" Width="300px" CssClass="SearchDDL" AutoPostBack="True" OnSelectedIndexChanged="DDLSchool_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:ImageButton ID="btnSearchGo" CssClass="SearchGoButton" runat="server" ToolTip="Search ..." ImageUrl="../images/Go.png" OnClick="BtnSearchGo_Click" />

                </ContentTemplate>

            </asp:UpdatePanel>

        </div>

        <div class="staff-container" style="margin-top: 5px;">
            <div class="staff-list">
                <div class="List-Action">
                    <a class="List-Action-Title" href="javascript:AddDetail();">
                        <asp:ImageButton ID="ImageAdd" runat="server" src="../images/add.png" CssClass="List-Action-Image" />
                        Add New Security Group </a>
                </div>


                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="GridView-List-Containor" style="width: 700px; height: 500px" onscroll="OnScrollDiv(this)" id="DivMainContent">
                            <asp:GridView ID="GridView1" CssClass="GridView-List" runat="server" CellPadding="1" Height="100%" Width="100%" GridLines="Both" AutoGenerateColumns="False" BackColor="White" BorderColor="gray" BorderStyle="Ridge" BorderWidth="1px" CellSpacing="1" EmptyDataText="No Security group show" EmptyDataRowStyle-CssClass="emptyData" ShowHeaderWhenEmpty="true">
                                <Columns>
                                    <asp:BoundField DataField="RowNo" HeaderText="No." ItemStyle-CssClass="myRowNo">
                                        <ItemStyle Width="3%" />
                                    </asp:BoundField>

                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="myAction">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="Link1" runat="server" Text='<%# Bind("Actions") %>'>  </asp:HyperLink>
                                        </ItemTemplate>
                                        <ItemStyle Width="3%" Wrap="False" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="AppID" HeaderText="App ID" ItemStyle-CssClass="AppID">
                                        <ItemStyle Width="5%" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Group ID" ItemStyle-CssClass="myGroupID">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="Link2" runat="server" Text='<%# Bind("GroupID") %>'>  </asp:HyperLink>
                                        </ItemTemplate>
                                        <ItemStyle Width="22%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Group Name">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="Link3" runat="server" Text='<%# Bind("GroupName") %>'>  </asp:HyperLink>
                                        </ItemTemplate>
                                        <ItemStyle Width="30%" Wrap="true" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="GroupType" ReadOnly="True" HeaderText="Group Type" ItemStyle-CssClass="myGroupType">
                                        <ItemStyle Width="8%" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Permission" ReadOnly="True" HeaderText="Permission" ItemStyle-CssClass="Permission">
                                        <ItemStyle Width="8%" />
                                    </asp:BoundField>

                                    <asp:TemplateField HeaderText="Active">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chbPickup" Checked='<%# Convert.ToBoolean(Eval("IsActive"))%>' runat="server" CssClass="myCheckPickedForGAL"></asp:CheckBox>
                                        </ItemTemplate>
                                        <ItemStyle Width="3%" HorizontalAlign="center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="myEditAction">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="Link4" runat="server" Text='<%# Bind("EditAction") %>'>  </asp:HyperLink>
                                        </ItemTemplate>
                                        <ItemStyle Width="3%" Wrap="False" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="myViewAction">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="Link7" runat="server" Text='<%# Bind("ViewAction") %>'>  </asp:HyperLink>
                                        </ItemTemplate>
                                        <ItemStyle Width="3%" Wrap="False" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="myDeleteAction">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="Link5" runat="server" Text='<%# Bind("DeleteAction") %>'>  </asp:HyperLink>
                                        </ItemTemplate>
                                        <ItemStyle Width="3%" Wrap="False" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="mySubAction">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="Link6" runat="server" Text='<%# Bind("SubActions") %>'>  </asp:HyperLink>
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
        <div id="Action-Page-Container">
            <%--<div id="HelpDIV" class="bubble epahide">
                <asp:TextBox ID="HelpTextContent" runat="server" TextMode="MultiLine" CssClass="HelpTextBox" BackColor="transparent"></asp:TextBox>
            </div>
            <div id="PopUpDIV" class="bubble epahide"></div>--%>

            <%--<div id="EditDIV" runat="server" class="EditDIV bubble epahide">
                <div class="EditDIV-Header">
                    <div id="EditTitle" class="EditDIV-Header-Title"></div>
                    <div class="EditDIV-Header-Close">
                        <img id="closeMe" class="EditDIV-Header-Close-Img" onclick="CloseEditPage()" src="../images/close.png" />
                    </div>
                </div>
                <iframe class="EditPage" id="editiFrame" name="editiFrame" frameborder="0" scrolling="no" src="" runat="server"></iframe>
            </div>--%>
           <%-- <div id="ActionMenuDIV" class="bubble epahide">
                <asp:Label runat="server" ID="ActionMenuTitle" Text=""> </asp:Label>
                <div id="ActionMenuUL" class="LeftSideMenu">
                </div>
            </div>--%>
        </div>

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
<script src="../Scripts/Appr_textEdit.js"></script>
<script src="../Scripts/CommonListBuild.js"></script>
<script src="../Scripts/ActionMenu.js"></script>
<script src="../Scripts/ActionInPage.js"></script>

<script type="text/javascript">
    MenuDataSource = "JsonFile";
    var UserID = $("#hfUserID").val();
    var UserRole = $("#hfUserRole").val();
    var ItemCode = $("#hfCode").val();
    var SchoolYear = $("#hfSchoolYear").val();
    var myKey;
    var currentTR;
    var myIDs;
    var currentTR;
    var currentSearchBoxID;
    function pageLoad(sender, args) {

        $(document).ready(function () {

            // var vHeight = window.innerHeight - 50;
            //  MakeStaticHeader("GridView1", vHeight, 1500, 20, false);
 

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

    function onSuccess(result) {
        BuildingList.DropDown2($("#ddlSchool"), BuildingDropDownList(result), $("#ddlSchoolCode"), BuildingDropDownList1(result));

    }
    function onFailure() {
        alert("Get Menu Failed!");
    }
    function RemoveGroup(userid, allowDel, groupID) {

        if (allowDel == "Yes") {
            // DeleteActionService();
        }
        else {
            alert("The Group --" + groupID + " can not be delete.");
        }

    }
    var page = "Security_Group.aspx";

    function AddDetail() {
        var schoolYear = $("#hfSchoolYear").val();
        var schoolCode = $("#ddlSchool").val();
        var appID = $("#ddlApps").val();
        var modelID = "Pages";
        var xID = "0";
        var xName = "New Security Group";
        var xType = "APP";
        var ids = "0";
        var action = "Add";
        var arg = GetArg(action, ids, schoolYear, schoolCode, appID, modelID, xID, xName, xType);

        OpenFormFromListPage(xName, page, arg, 500, 650);
    }

    function OpenDetail(action, type, ids, schoolYear, schoolCode, appID, modelID, xID, xName, xType) {
        var arg = GetArg(action, ids, schoolYear, schoolCode, appID, modelID, xID, xName, xType);
        OpenFormFromListPage(xName, page, arg, 500, 650);
    }

    var pagesub = "GroupManageSub.aspx";
    function OpenSubPage(action, type, ids, schoolYear, schoolCode, appID, modelID, xID, xName, xType) {
        arg = GetArg(action, ids, schoolYear, schoolCode, appID, modelID, xID, xName, xType);
        var goPage = "Loading.aspx?pID=" + pagesub + arg;
        $("#IframeSubArea").attr('src', goPage);

    }

</script>
