<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SecurityManageGroup.aspx.cs" Inherits="ASM.SecurityManageGroup" Async="true" %>

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
    <link href="Content/DefaultPage.css" rel="stylesheet" />
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


        .DataContentTile {
            font-family: Arial;
            font-size: small;
            font-weight: 300;
            color: blue;
            table-layout: auto;
            display: block;
            height: 99%;
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



        .hfSchoolYear, .hfSchoolCode, .hfEmployeeID, .hfTeacherName, .hfmyKey, .hfIDs {
            display: none;
            width: 0px;
        }



        .top5Row {
            border-top: 5px solid darkcyan;
        }

        .HideButton {
            margin: 0px;
            padding: 0px;
            border: 0px;
        }

        .staff-container {
            margin-top: 5px;
            display: grid;
            grid-template-columns: 44% auto;
            grid-template-rows: repeat(1,100%);
            margin: auto;
            text-align: left;
            width: 100%
        }

        .staff-list {
            text-align: left;
        }

        .function-list {
        }

        .SearchBox {
            width: 100px;
            height: 19px;
        }

            .SearchBox:focus {
                border: 1px solid dodgerblue;
            }

            .SearchBox:visited {
                border: 1px solid skyblue;
            }

        .img-selected {
            filter: contrast(300%);
        }

        #SearchBar {
            position: absolute;
            top: 5px;
            left: 700px;
        }

        .highlightBoard {
            border: 2px #ff6a00 solid;
        }
        #editiFrame {
        width:100%;
        height:95%;
        }
        #EditDIV {
            border:1px solid #ee7c40;
            border-radius:10px;
            padding:5px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">

        <asp:ScriptManager runat="server">
            <Services>
                <asp:ServiceReference Path="~/Models/WebService.asmx" />

            </Services>
        </asp:ScriptManager>
        <div class="SearchArea-SchoolRow">
            &nbsp;  &nbsp; School:
            <asp:DropDownList ID="ddlSchoolCode" runat="server" Width="60px" AutoPostBack="True" OnSelectedIndexChanged="DDLSchoolCode_SelectedIndexChanged">
            </asp:DropDownList>
            <asp:DropDownList ID="ddlSchool" runat="server" Width="480px" AutoPostBack="True" OnSelectedIndexChanged="DDLSchool_SelectedIndexChanged">
            </asp:DropDownList>

        </div>
        <div class="SearchAreaRow">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <div class="SearchAreaDIV Search-Area-Sigal" style="width: 625px; margin-top: -5px;">
                        &nbsp; 
                        <img class="imgHelp" src="../images/help2.png" title="Help Content" />

                        &nbsp;
                       Search Staff By: 
                        <asp:TextBox CssClass="SearchBox" ID="TextBoxFirstName" runat="server" placeholder="First name"></asp:TextBox>
                        <asp:ImageButton ID="btnSearchGoFirstName" CssClass="SearchGoButton hideMe" runat="server" ToolTip="Search ..." ImageUrl="../images/Go.png" OnClick="BtnSearchGo_Click" />
                        <asp:TextBox CssClass="SearchBox" ID="TextBoxLastName" runat="server" placeholder="Last name"></asp:TextBox>
                        <asp:ImageButton ID="btnSearchGoLastName" CssClass="SearchGoButton hideMe" runat="server" ToolTip="Search ..." ImageUrl="../images/Go.png" OnClick="BtnSearchGo_Click" />
                        <asp:TextBox CssClass="SearchBox" ID="TextBoxUserID" runat="server" placeholder="User ID"></asp:TextBox>
                        <asp:ImageButton ID="btnSearchGoUserID" CssClass="SearchGoButton hideMe" runat="server" ToolTip="Search ..." ImageUrl="../images/Go.png" OnClick="BtnSearchGo_Click" />
                        <asp:TextBox CssClass="SearchBox" ID="TextBoxCPNum" runat="server" placeholder="CP Number."></asp:TextBox>
                        <asp:ImageButton ID="btnSearchGoCPNum" CssClass="SearchGoButton hideMe" runat="server" ToolTip="Search ..." ImageUrl="../images/Go.png" OnClick="BtnSearchGo_Click" />
                        <asp:HiddenField ID="hfSearchby" runat="server" Value="SurName" />
                        <asp:HiddenField ID="hfSearchValue" runat="server" Value="" />
                        <asp:HiddenField ID="hfSelectedTab" runat="server" Value="" />

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
        <div class="staff-container" style="margin-top: 5px;">
            <div class="staff-list">
                <div>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div id="DivRoot" style="width: 650px; height: 540px">
                                <%--<div style="overflow: hidden;" id="DivHeaderRow">
                                    <table id="GridView2" style="border: 1px ridge gray; width: 100%; height: 100%; background-color: white;" rules="all" cellspacing="1" cellpadding="1">
                                    </table>
                                </div>--%>

                                <div style="overflow: scroll; width: 650px; height: 100%" onscroll="OnScrollDiv(this)" id="DivMainContent">
                                    <asp:GridView ID="GridView1"  CssClass="GridView-List" runat="server" CellPadding="1" Height="100%" Width="100%" GridLines="Both" AutoGenerateColumns="False" BackColor="White" BorderColor="gray" BorderStyle="Ridge" BorderWidth="1px" CellSpacing="1" EmptyDataText="No Appraisal Staff in current search condition" EmptyDataRowStyle-CssClass="emptyData" ShowHeaderWhenEmpty="true">
                                        <Columns>
                                            <asp:BoundField DataField="RowNo" HeaderText="No." ItemStyle-CssClass="myRowNo">
                                                <ItemStyle Width="3%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="UserID" HeaderText="UserID" ItemStyle-CssClass="myUserID">
                                                <ItemStyle Width="8%" Wrap="False" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Staff Name" ItemStyle-CssClass="myName">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="Link4" runat="server" Text='<%# Bind("StaffName") %>'>  </asp:HyperLink>
                                                </ItemTemplate>
                                                <ItemStyle Width="22%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Position">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="Link5" runat="server" Text='<%# Bind("Position") %>'>  </asp:HyperLink>
                                                </ItemTemplate>
                                                <ItemStyle Width="30%" Wrap="true" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="CPNum" ReadOnly="True" HeaderText="CP No." ItemStyle-CssClass="OEN">
                                                <ItemStyle Width="10%" Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="EmployeeRole" ReadOnly="True" HeaderText="Role" ItemStyle-CssClass="SchoolCode">
                                                <ItemStyle Width="10%" />
                                            </asp:BoundField>

                                            <asp:TemplateField HeaderText="GAL">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chbPickup" Checked='<%# Convert.ToBoolean(Eval("PickedForGAL"))%>' runat="server" CssClass="myCheckPickedForGAL"></asp:CheckBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="5%" HorizontalAlign="center" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="" ItemStyle-CssClass="myAction">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="Link1" runat="server" Text='<%# Bind("Actions") %>'>  </asp:HyperLink>
                                                </ItemTemplate>
                                                <ItemStyle Width="2%" Wrap="False" />
                                            </asp:TemplateField>

                                        </Columns>

                                        <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                                        <HeaderStyle BackColor="cornflowerblue" ForeColor="white" Height="25px" />
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
            <div class="function-list">
                <iframe id="IframeFunction" name="IframeFunction" style="height: 100%; width: 100%" frameborder="0" scrolling="no" src="" runat="server"></iframe>
            </div>
        </div>


        <div id="HelpDIV" class="bubble epahide">
            <asp:TextBox ID="HelpTextContent" runat="server" TextMode="MultiLine" CssClass="HelpTextBox" BackColor="transparent"></asp:TextBox>
        </div>
        <div id="PopUpDIV" class="bubble epahide"></div>

        <div id="EditDIV" runat="server" class="EditDIV bubble epahide">
            <div class="editTitle">
                <table>
                    <tr>
                        <td style="width: 90%">
                            <div id="EditTitle"></div>
                        </td>
                        <td style="text-align:right">
                            <img id="closeMe" src="../images/close.png" style="height: 25px; width: 25px; margin: -3px 0 -3px 0" /></td>
                    </tr>
                </table>
            </div>
            <iframe class="EditPage" id="editiFrame" name="editiFrame" frameborder="0"   scrolling="no" src="" runat="server"></iframe>
        </div>

        <div id="ActionMenuDIV" class="bubble epahide">
            <asp:Label runat="server" ID="LabelTeacherName" Text=""> </asp:Label>
            <div id="ActionMenuUL" class="LeftSideMenu">
            </div>
        </div>
        <div id="ActionPOPDIV" class="bubble epahide">
            <div class="editTitle" style="display: block; margin-top: 5px;">
                <div id="ActionTitle" style="display: inline; float: left; width: 96%"></div>
                <div style="display: inline; float: left;">
                    <img id="closeActionPOP" src="../images/close.ico" style="height: 25px; width: 25px; margin: -3px 0 -3px 0" />
                </div>
            </div>
            <iframe id="ActioniFramePage" name="ActioniFramePage" style="height: 425px; width: 99%" frameborder="0" scrolling="no" src="" runat="server"></iframe>
        </div>
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
<script src="../Scripts/Appr_ListPage.js"></script>
<script src="../Scripts/Appr_Help.js"></script>
<script src="../Scripts/Appr_textEdit.js"></script>
<script src="../Scripts/CommonListBuild.js"></script>
<script src="../Scripts/ActionMenu.js"></script>

<script type="text/javascript">
    var UserID = $("#hfUserID").val();
    var UserRole = $("#hfUserRole").val();
    var ItemCode = $("#hfCode").val();
    var preaLinkID;
    var stName;
    var stID;
    var scYear;
    var scCode;
    var Grade;
    var myKey;
    var currentTR;
    var myIDs; 
    var currentTR;
    var currentSearchBoxID;
    function pageLoad(sender, args) {

        $(document).ready(function () {
            var vHeight = window.innerHeight - 50;
            //  MakeStaticHeader("GridView1", vHeight, 1500, 20, false);

            $("#closeMe").click(function (event) {            
                $("#PopUpDIV").hide();  //.fadeToggle("fast");
                $("#EditDIV").hide();               
            });

           $(".GridView-List img").click(function (en) {
                $(this).addClass("img-selected");
            })
            $('.GridView-List tr').mouseenter(function (event) {
                 if (currentTR !== undefined) { currentTR.removeClass("GridView-Selected "); }
                currentTR = $(this);
                currentTR.addClass("GridView-Selected ");
            });

            try {
                //  $("#btnSearchGo" + $("#hfSearchby").val()).show();
                $("#btnSearchGo" + $("#hfSearchby").val()).removeClass("hideMe");

            }
            catch (e) { }

            $(".SearchBox").change(function (e) {
                var cEvantID = e.currentTarget.id;
                currentSearchBoxID = cEvantID;
                $("#hfSearchby").val(cEvantID.replace("TextBox", ""));
                $("#hfSearchValue").val(e.currentTarget.value);
                $("#hfSelectedTab").val("00");
            });
            $(".SearchBox").focus(function (e) {
                try {
                    var cEvantID = e.currentTarget.id;
                    var preBox = $("#hfSearchby").val();
                    $("#hfSearchby").val(cEvantID.replace("TextBox", ""));
                    if (preBox != "") {
                        $("#btnSearchGo" + preBox).addClass("hideMe"); // .hide();
                        $("#TextBox" + preBox).val("");
                        $("#TextBox" + preBox).removeClass("highlightSearchBox");

                    }

                    $("#" + cEvantID.replace("TextBox", "btnSearchGo")).removeClass("hideMe"); // .show();
                    $("#" + cEvantID).addClass("highlightSearchBox");
                    currentSearchBoxID = cEvantID;
                    $("#hfSearchValue").val("");
                }
                catch (e) {
                    alert("Something error");
                }
            });

        });
    }
    function openSMDetail(schoolYear, schoolCode, userID, cpnum, sName, uRole) {
        CopyKeyIDToClipboard(cpnum + '-' + sname);
        var goPage = "Loading.aspx?pID=SecurityManageDetails&nwuID=" + userID + "&CPNum=" + cpnum + "&sName=" + sName + "&sYear=" + schoolYear + "&sCode=" + schoolCode + "&uRole=" + uRole;
        location = goPage;
    }
    function onSuccess(result) {
        BuildingList.DropDown2($("#ddlSchool"), BuildingDropDownList(result), $("#ddlSchoolCode"), BuildingDropDownList1(result));

    }
    function onFailure() {
        alert("Get Menu Failed!");
    }


</script>
