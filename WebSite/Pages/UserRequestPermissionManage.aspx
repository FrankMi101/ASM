<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserRequestPermissionManage.aspx.cs" Inherits="ASM.Pages.UserRequestPermissionManage" Async="true" EnableTheming="true" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>School Staff List</title>
    <meta http-equiv="Pragma" content="No-cache" />
    <meta http-equiv="Cache-Control" content="no-Store,no-Cache" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link href="../Content/bootstrap.min.css" rel="stylesheet" />

    <script src="../Scripts/jquery-3.4.1.min.js"></script>
     <link href="../Content/BubbleHelp.css" rel="stylesheet" />
     <link href="../Content/ListPage.css" rel="stylesheet" />
    <link href="../Content/ContentPage.css" rel="stylesheet" />
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
 
   
        .RightSide {
         margin-left: 180px;
        }
        .staff-container {
  
          grid-template-columns: 85% auto;
  
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

        <div class="SearchAreaRow" style="height: 30px;">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <div class="SearchAreaDIV Search-Area-Sigal" style="width: 625px;">
                        <div style="margin-top: -3px;">
                            <img class="imgHelp" src="../images/help2.png" title="Help Content" />
                            Search Staff By:  Grant Action:
                         <asp:DropDownList CssClass="SearchDDL" ID="ddlGrantAction" runat="server" Width="100px" AutoPostBack="True">
                         </asp:DropDownList>
                            &nbsp;&nbsp; &nbsp;&nbsp;
                            <asp:ImageButton ID="btnSearchGo" CssClass="SearchGoButton" runat="server" ToolTip="Search ..." ImageUrl="../images/Go.png" OnClick="BtnSearchGo_Click" />
                                <asp:CheckBox ID="CheckBoxBoard" runat="server" Checked="true" Text="Board" CssClass="RightSide" />
                          <%--  <div style="display:inline; text-align:right; margin-left:200px;">
                            </div>--%>


                            <asp:HiddenField ID="hfSearchby" runat="server" Value="SurName" />
                            <asp:HiddenField ID="hfSearchValue" runat="server" Value="" />
                            <asp:HiddenField ID="hfSelectedTab" runat="server" Value="" />
                        </div>


                    </div>
                    <div id="SearchBar">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <img src="../images/indicator.gif" alt="" />
                                <b>Searching.....</b>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>

                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="staff-container" style="margin-top: 15px;">
            <div class="staff-list">
                <div>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div id="DivRoot" style="width: 100%; height: 540px">


                                <div class="GridView-List-Containor" onscroll="OnScrollDiv(this)" id="DivMainContent">
                                    <asp:GridView ID="GridView1" CssClass="GridView-List" runat="server" CellPadding="1" Height="100%" Width="100%" GridLines="Both" AutoGenerateColumns="False" BackColor="White" BorderColor="gray" BorderStyle="Ridge" BorderWidth="1px" CellSpacing="1" EmptyDataText="No Appraisal Staff in current search condition" EmptyDataRowStyle-CssClass="emptyData" ShowHeaderWhenEmpty="true">
                                        <Columns>
                                            <asp:BoundField DataField="RowNo" HeaderText="No." ItemStyle-CssClass="myRowNo">
                                                <ItemStyle Width="2%" />
                                            </asp:BoundField>

                                            <asp:TemplateField HeaderText="Staff Name" ItemStyle-CssClass="myName">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="Link4" runat="server" Text='<%# Bind("UserName") %>'>  </asp:HyperLink>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="User Role">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="Link5" runat="server" Text='<%# Bind("UserRole") %>'>  </asp:HyperLink>
                                                </ItemTemplate>
                                                <ItemStyle Width="5%" Wrap="true" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="AppID" ReadOnly="True" HeaderText="Apps ID" ItemStyle-CssClass="AppsID">
                                                <ItemStyle Width="5%" Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ModelID" ReadOnly="True" HeaderText="Model ID" ItemStyle-CssClass="ModelID">
                                                <ItemStyle Width="10%" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="Permission" ReadOnly="True" HeaderText="Permission" ItemStyle-CssClass="Permission">
                                                <ItemStyle Width="8%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="RequestDate" ReadOnly="True" HeaderText="Request Date" ItemStyle-CssClass="RequestDate">
                                                <ItemStyle Width="8%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="StartDate" ReadOnly="True" HeaderText="Start Date" ItemStyle-CssClass="StartDate">
                                                <ItemStyle Width="8%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="EndDate" ReadOnly="True" HeaderText="End Date" ItemStyle-CssClass="EndDate">
                                                <ItemStyle Width="8%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="AccessScope" ReadOnly="True" HeaderText="Request Scope" ItemStyle-CssClass="AccessScope">
                                                <ItemStyle Width="8%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="RequestValue" ReadOnly="True" HeaderText="Request Value" ItemStyle-CssClass="RequestValue">
                                                <ItemStyle Width="8%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="GrantAction" ReadOnly="True" HeaderText="Result" ItemStyle-CssClass="Result">
                                                <ItemStyle Width="8%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Comments" ReadOnly="True" HeaderText="Comments" ItemStyle-CssClass="Comments">
                                                <ItemStyle Width="10%" />
                                            </asp:BoundField>


                                            <asp:TemplateField HeaderText="" ItemStyle-CssClass="myViewAction">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="Link1" runat="server" Text='<%# Bind("EditAction") %>'>  </asp:HyperLink>
                                                </ItemTemplate>
                                                <ItemStyle Width="2%" Wrap="False" />
                                            </asp:TemplateField>


                                        </Columns>
                                        <RowStyle  Height="25px" />
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
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
   
        </div>
        <div id="Action-Page-Container"></div>

       
         <div>
            <asp:HiddenField ID="hfCategory" runat="server" />
            <asp:HiddenField ID="hfPageID" runat="server" />
            <asp:HiddenField ID="hfCode" runat="server" />
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
<script src="../Scripts/ActionMenu.js"></script>
<script src="../Scripts/ActionInPage.js"></script>
<script src="../Scripts/ActionWebApi.js"></script>

<script type="text/javascript">
    var UserID = $("#hfUserID").val();
    var UserRole = $("#hfUserRole").val();
    var ItemCode = $("#hfCode").val();
    var currentTR;
    function pageLoad(sender, args) {

        $(document).ready(function () {
            var vHeight = window.innerHeight - 50;
    

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
    function OpenDetail(action, type, ids, schoolYear, schoolCode, appID, modelID, xID, xName, xType) {
        var arg = "&Action=" + action + "&IDs=" + ids + "&SchoolYear=" + schoolYear + "&SchoolCode=" + schoolCode + "&AppID=" + appID + "&ModelID=" + modelID + "&xID=" + xID + "&xName=" + xName + "&xType=" + xType;
        var page = "RequestAccessPermission.aspx";
      //  window.alert(arg);
        var title = "Grant Apps Access Permission by Request";
        OpenFormFromListPage(title, page, arg, 500, 700);
         
    }


</script>
