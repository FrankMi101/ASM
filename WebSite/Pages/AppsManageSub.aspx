<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppsManageSub.aspx.cs" Inherits="ASM.Pages.AppsManageSub" Async="true" %>

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
 
  
    </style>

</head>
<body>
    <form id="form1" runat="server">

        <asp:ScriptManager runat="server">
            <Services>
            <%-- <asp:ServiceReference Path="~/Models/WebService.asmx" /> --%>

            </Services>
        </asp:ScriptManager>

         <div class="MessageRow">
  
                    Apps ID:  
                    <asp:TextBox CssClass="SearchBox" ID="TextBoxAppsID" runat="server" Width="70px" ReadOnly="true" placeholder="User ID"></asp:TextBox>
                    Apps Name:<asp:TextBox CssClass="SearchBox" ID="TextBoxAppsName" Width="400px" ReadOnly ="true" runat="server" placeholder="Staff name"></asp:TextBox>
                 
        </div>
        <div class="staff-container" style="margin-top: 5px;">
            <div class="staff-list">
                <div class="List-Action">
                    <a class="List-Action-Title" href="javascript:AddDetail();">
                        <asp:ImageButton ID="ImageAdd" runat="server" src="../images/add.png" CssClass="List-Action-Image" />
                        Add New Model </a>
                </div>
 
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div  class="GridView-List-Containor"  style=" width: 750px; height: 500px" onscroll="OnScrollDiv(this)" id="DivMainContent">
                            <asp:GridView ID="GridView1" CssClass="GridView-List" runat="server" CellPadding="1" Height="100%" Width="100%" GridLines="Both" AutoGenerateColumns="False" BackColor="White" BorderColor="gray" BorderStyle="Ridge" BorderWidth="1px" CellSpacing="1" EmptyDataText="No Security group show" EmptyDataRowStyle-CssClass="emptyData" ShowHeaderWhenEmpty="true">
                                <Columns>
                                    <asp:BoundField DataField="RowNo" HeaderText="No." ItemStyle-CssClass="myRowNo">
                                        <ItemStyle Width="3%" />
                                    </asp:BoundField>

                                <%--    <asp:TemplateField HeaderText="" ItemStyle-CssClass="myAction">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="Link1" runat="server" Text='<%# Bind("Actions") %>'>  </asp:HyperLink>
                                        </ItemTemplate>
                                        <ItemStyle Width="3%" Wrap="False" />
                                    </asp:TemplateField>--%>
                                    
                                    <asp:BoundField DataField="ModelID" ReadOnly="True" HeaderText="Model ID">
                                        <ItemStyle Width="5%" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ModelName" ReadOnly="True" HeaderText="Model Name">
                                        <ItemStyle Width="20%" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Owners" ReadOnly="True" HeaderText="Owner">
                                        <ItemStyle Width="10%"   />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Developer" ReadOnly="True" HeaderText="Developer">
                                        <ItemStyle Width="10%"  />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="StartDate" ReadOnly="True" HeaderText="Start Date">
                                        <ItemStyle Width="8%" />
                                    </asp:BoundField>
                                     <asp:BoundField DataField="EndDate" ReadOnly="True" HeaderText="End Date">
                                        <ItemStyle Width="8%" />
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
          
        </div>
             <div id="Action-Page-Container"></div>
         
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

            $(".GridView-List img").click(function (en) {
                $(this).addClass("img-selected");
                var objC = $(this)[0].offsetParent; //$(this)[0].offsetParent.offsetLeft       // var objC = $(".myAction")[0]; // .offsetLeft              
                actionItemPosition = objC.offsetLeft + objC.offsetWidth;
            })
            $('.GridView-List tr').mouseenter(function (event) {
                newRowNo = $(this).closest('tr').find('td.myRowNo').text();
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

    var page = "AppsModel_Details.aspx";

    var arg = "";

    function AddDetail() {
        var schoolYear = $("#hfSchoolYear").val();
        var schoolCode = $("#hfSchoolCode").val();
        var appID = $("#TextBoxAppsID").val();
        var modelID = "Pages";
        var xType = $("#ddlRoleType").val();
        var xID = "0";
        var xName = "New Model";
        // var page = "../SICCommon/Security_Role.aspx"
        if ($("#hfUserRole").val() != "Admin") {
            alert("Current User is View Permission only");
        }
        else {
            arg = GetArg("Add", "0", schoolYear, schoolCode, appID, modelID, xID, xName, xType);
           // arg = "&Action=Add" + "&IDs=0" + "&SchoolYear=" + schoolYear + "&SchoolCode=" + schoolCode + "&AppID=" + appID + "&ModelID=" + modelID + "&xID=" + roleID + "&xName=" + xName + "&xType=" + roleType;
            OpenFormFromListPage(xName, page, arg, 400, 600);
        }
    }

    function OpenDetail(action, type, ids, schoolYear, schoolCode, appID, modelID, xID, xName, xType) {
        // var page = "../SICCommon/Security_Role.aspx"
        if ($("#hfUserRole").val() != "Admin") {
            alert("Current User is View Permission only");
        }
        else {
            arg = GetArg(action, ids, schoolYear, schoolCode, appID, modelID, xID, xName, xType);

         //   arg = "&Action=" + action + "&IDs=" + ids + "&SchoolYear=" + schoolYear + "&SchoolCode=" + schoolCode + "&AppID=" + appID + "&ModelID=" + modelID + "&xID=" + xID + "&xName=" + xName + "&xType=" + xType;
            OpenFormFromListPage(xName, page, arg, 400, 600);
        }

    }
 
</script>
