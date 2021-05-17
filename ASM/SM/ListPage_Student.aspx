<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListPage_Student.aspx.cs" Inherits="ASM.ListPage_Student" Async="true" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ASM Student List</title>
    <meta http-equiv="Pragma" content="No-cache" />
    <meta http-equiv="Cache-Control" content="no-Store,no-Cache" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <script src="../Scripts/jquery-3.4.1.min.js"></script>
<%--    <script src="../Scripts/bootstrap.min.js"></script>
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />--%>
    <link href="../Content/BubbleHelp.css" rel="stylesheet" />
    <link href="../Content/ListPage.css" rel="stylesheet" />
    <link href="../Content/ContentPage.css" rel="stylesheet" />
    <link href="../Content/TabMenu.css" rel="stylesheet" />
    <link href="../Content/TopNavList.css" rel="stylesheet" />
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



        .hfSchoolYear, .hfSchoolCode, .hfEmployeeID, .hfTeacherName, .hfmyKey, .hfIDs {
            display: none;
            width: 0px;
        }

        img {
            border-color: yellow
        }

        .label1 {
            font-family: Arial;
            font-size: 13px;
        }



        .top5Row {
            border-top: 5px solid darkcyan;
        }

        .HideButton {
            margin: 0px;
            padding: 0px;
            border: 0px;
        }
 
        #SearchingBar {
            position: absolute;
            top: 35px;
            left: 1010px;
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
        <div class="SearchAreaRow" style="height: 60px;">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <div class="SearchAreaDIV">
                        <img class="imgHelp" src="../images/help2.png" title="Help Content" />
                        <asp:Label ID="Label3" runat="server" Text="School Year: " CssClass="label1"></asp:Label>
                        <asp:DropDownList ID="ddlSchoolYear" runat="server" Width="85px" AutoPostBack="False" OnSelectedIndexChanged="DDLSchoolYear_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:Label ID="Label1" runat="server" Text="Panel: " CssClass="label1"></asp:Label>

                        <asp:DropDownList ID="DDLPanel" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DDLPanel_SelectedIndexChanged">
                            <asp:ListItem Selected="True" Value="E">Elementary</asp:ListItem>
                            <asp:ListItem Value="S">Secondary</asp:ListItem>
                        </asp:DropDownList>

                        <asp:Label ID="Label2" runat="server" Text="School" CssClass="label1"></asp:Label>
                        <asp:DropDownList ID="ddlSchoolCode" runat="server" Width="60px" AutoPostBack="True" OnSelectedIndexChanged="DDLSchoolCode_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlSchool" runat="server" Width="400px" AutoPostBack="True" OnSelectedIndexChanged="DDLSchool_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:Label ID="Searchby" runat="server" Text="Search by" CssClass="label1" Visible="false"></asp:Label>
                        <asp:HiddenField ID="hfSearchby" runat="server" Value="SurName" />
                        <%--<asp:DropDownList ID="ddlSearchby" runat="server" Width="100px" AutoPostBack="true" OnSelectedIndexChanged="DDLSearchBy_SelectedIndexChanged">
                            <asp:ListItem Value="SurName" Selected="True"> SurName</asp:ListItem>
                            <asp:ListItem Value="Age">Age</asp:ListItem>
                            <asp:ListItem Value="Grade">Grade</asp:ListItem>
                            <asp:ListItem Value="OEN">OEN</asp:ListItem>
                            <asp:ListItem Value="StudentNo">StudentNo.</asp:ListItem>
                            <asp:ListItem Value="Program">Program</asp:ListItem>
                            <asp:ListItem Value="Courses">Course List</asp:ListItem>
                        </asp:DropDownList>--%>
                        <asp:HiddenField ID="hfSearchValue" runat="server" Value="" />
                        <%--<asp:TextBox ID="TextSearch" runat="server" Width="80px" Height="19px" placeholder="Surname"></asp:TextBox>--%>

                        <%--<asp:DropDownList ID="ddlSearchValue" runat="server" Width="100px" AutoPostBack="false">
                        </asp:DropDownList>--%>
                       &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp; IN 
                    <asp:DropDownList ID="ddlScope" runat="server" Width="70px" AutoPostBack="false">
                        <asp:ListItem Value="School" Selected="True"> School</asp:ListItem>
                        <asp:ListItem Value="Board">Board</asp:ListItem>
                    </asp:DropDownList>
                        <%--  <asp:Button ID="btnSearch" runat="server" Text="Go" OnClick="BtnSearch_Click" CssClass="Gobutton" Visible="false" />--%>
                        <asp:Button ID="btnGradeTab" runat="server" Text="" Height="0px" Width="0px" CssClass="HideButton" OnClick="BtnGradeTab_Click" />
                        <asp:ImageButton ID="btnSearchGo" CssClass="SearchGoButton" runat="server" ToolTip="Search ..." ImageUrl="../images/Go.png" OnClick="BtnSearchGo_Click" />


                        <div id="SearchingBar">
                            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                <ProgressTemplate>
                                    <img src="../images/indicator.gif" alt="" />
                                    <b>Searching.....</b>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </div>
                        &nbsp;&nbsp;  &nbsp;&nbsp; 
                        With Program:
                     <asp:DropDownList ID="ddlProgram" runat="server" Width="100px" AutoPostBack="false">
                         <asp:ListItem Value="All" Selected="True"> All</asp:ListItem>
                         <asp:ListItem Value="IEP">IEP Student</asp:ListItem>
                         <asp:ListItem Value="IPRC">IPRC Student</asp:ListItem>
                         <asp:ListItem Value="Gift">Gift Student</asp:ListItem>
                         <asp:ListItem Value="Autism">Autism Student</asp:ListItem>
                         <asp:ListItem Value="Alternative">Alternative Student</asp:ListItem>
                     </asp:DropDownList>
                        <div class="term">
                            S:
                      <asp:DropDownList ID="ddlSemester" runat="server" Width="40px" AutoPostBack="false">
                          <asp:ListItem Value="1" Selected="True"> 1</asp:ListItem>
                          <asp:ListItem Value="2">2</asp:ListItem>
                      </asp:DropDownList>
                            T:
                      <asp:DropDownList ID="ddlTerm" runat="server" Width="40px" AutoPostBack="false">
                          <asp:ListItem Value="P"> School</asp:ListItem>
                          <asp:ListItem Value="1" Selected="True">1</asp:ListItem>
                          <asp:ListItem Value="2">2</asp:ListItem>
                          <asp:ListItem Value="3">3</asp:ListItem>
                      </asp:DropDownList>
                        </div>

                    </div>
                    <div style="margin-top: 5px; width:1000px;" class="Search-Area-Sigal ">
                          &nbsp;  Search Student By: &nbsp;
                        <asp:TextBox CssClass="SearchTextBox" ID="TextBoxFirstName" runat="server"  placeholder="First name"></asp:TextBox>
                        <asp:ImageButton ID="btnSearchGoFirstName" CssClass="SearchGoButton hideMe" runat="server" ToolTip="Search ..." ImageUrl="../images/Go.png" OnClick="BtnSearchGo_Click" />
                        <asp:TextBox CssClass="SearchTextBox" ID="TextBoxLastName" runat="server"  placeholder="Last name"></asp:TextBox>
                        <asp:ImageButton ID="btnSearchGoLastName" CssClass="SearchGoButton hideMe" runat="server" ToolTip="Search ..." ImageUrl="../images/Go.png" OnClick="BtnSearchGo_Click" />
                        &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;
                        <asp:TextBox CssClass="SearchTextBox" ID="TextBoxOEN" runat="server" placeholder="OEN Number"></asp:TextBox>
                        <asp:ImageButton ID="btnSearchGoOEN" CssClass="SearchGoButton hideMe" runat="server" ToolTip="Search ..." ImageUrl="../images/Go.png" OnClick="BtnSearchGo_Click" />
                        <asp:TextBox CssClass="SearchTextBox" ID="TextBoxStudentNo" runat="server"  placeholder="Student No."></asp:TextBox>
                        <asp:ImageButton ID="btnSearchGoStudentNo" CssClass="SearchGoButton hideMe" runat="server" ToolTip="Search ..." ImageUrl="../images/Go.png" OnClick="BtnSearchGo_Click" />
                        &nbsp; &nbsp;  &nbsp;&nbsp; &nbsp;
                         <asp:TextBox CssClass="SearchTextBox" ID="TextBoxClass" runat="server"   placeholder="Class Code"></asp:TextBox>
                        <asp:ImageButton ID="btnSearchGoClass" CssClass="SearchGoButton hideMe" runat="server" ToolTip="Search ..." ImageUrl="../images/Go.png" OnClick="BtnSearchGo_Click" />
                        <asp:TextBox CssClass="SearchTextBox" ID="TextBoxAge" runat="server"   placeholder="Age"></asp:TextBox>
                        <asp:ImageButton ID="btnSearchGoAge" CssClass="SearchGoButton hideMe" runat="server" ToolTip="Search ..." ImageUrl="../images/Go.png" OnClick="BtnSearchGo_Click" />

                    </div>
                    <%-- <div style="margin-top:5px;">
                        &nbsp; &nbsp; Search Student By: &nbsp;
                        <asp:Label ID="LabelFirstName" runat="server" Text="First Name:" AssociatedControlID ="TextBoxFirstName"></asp:Label>
                        <asp:TextBox CssClass="SearchBox" ID="TextBoxFirstName" runat="server" Width="100px" Height="19px" placeholder="First name"></asp:TextBox>
                        &nbsp; &nbsp; 
                        <asp:Label ID="LabelLastName" runat="server" Text="Last Name:" AssociatedControlID ="TextBoxLastName"></asp:Label>
                        <asp:TextBox CssClass="SearchBox" ID="TextBoxLastName" runat="server" Width="100px" Height="19px" placeholder="Last name"></asp:TextBox>
                        <asp:ImageButton ID="btnSearchGo" runat="server" ToolTip="Search ..." ImageUrl="../images/Go.png" OnClick="BtnSearchGo_Click" />
                        &nbsp; &nbsp;
                        <asp:Label ID="LabelOEN" runat="server" Text="OEN:" AssociatedControlID ="TextBoxOEN"></asp:Label>
                        <asp:TextBox CssClass="SearchBox" ID="TextBoxOEN" runat="server" Width="100px" Height="19px" placeholder="OEN Number"></asp:TextBox>
                        &nbsp; &nbsp;  
                        <asp:Label ID="LabelStudentNo" runat="server" Text="Student No.:" AssociatedControlID ="TextBoxStudentNo"></asp:Label>
                        <asp:TextBox CssClass="SearchBox" ID="TextBoxStudentNo" runat="server" Width="100px" Height="19px" placeholder="Student No."></asp:TextBox>
                       <asp:ImageButton ID="btnSearchGo2" runat="server" ToolTip="Search ..." ImageUrl="../images/Go.png" OnClick="BtnSearchGo_Click" />
                        &nbsp; &nbsp; 
                        <asp:Label ID="LabelClass" runat="server" Text="Class:" AssociatedControlID ="TextBoxClass"></asp:Label>
                        <asp:TextBox CssClass="SearchBox"  ID="TextBoxClass" runat="server" Width="100px" Height="19px" placeholder="Class Code"></asp:TextBox>
                        &nbsp; &nbsp;  
                        <asp:Label ID="LabelAge" runat="server" Text="Age:" AssociatedControlID ="TextBoxAge"></asp:Label>
                        <asp:TextBox CssClass="SearchBox" ID="TextBoxAge" runat="server" Width="80px" Height="19px" placeholder="Age"></asp:TextBox>

                    </div>--%>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div style="margin-top:5px">
            <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                <ContentTemplate>
                    <div class="Horizontal_Tab" id="GradeTab" runat="server"></div>
                    <asp:HiddenField ID="hfSelectedTab" runat="server" />
                    <asp:HiddenField ID="hfSelectedTabL" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div id="DivRoot" style="width: 100%;">
                        <div style="overflow: hidden;" id="DivHeaderRow">
                            <table id="GridView2" style="border: 1px ridge gray; width: 100%; height: 100%; background-color: white;" rules="all" cellspacing="1" cellpadding="1">
                            </table>
                        </div>

                        <div style="overflow: scroll; width: 100%; height: 100%" onscroll="OnScrollDiv(this)" id="DivMainContent">
                            <asp:GridView ID="GridView1" runat="server" CellPadding="1" Height="100%" Width="100%" GridLines="Both" AutoGenerateColumns="False" BackColor="White" BorderColor="gray" BorderStyle="Ridge" BorderWidth="1px" CellSpacing="1"
                                EmptyDataText="No Students in current search condition" EmptyDataRowStyle-CssClass="emptyData" ShowHeaderWhenEmpty="true">
                                <Columns>
                                    <asp:BoundField DataField="RowNo" HeaderText="No." ItemStyle-CssClass="myRowNo">
                                        <ItemStyle Width="30px" />
                                    </asp:BoundField>

                                    <asp:TemplateField HeaderText="Menu" ItemStyle-CssClass="myAction">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="Link1" runat="server" Text='<%# Bind("Actions") %>'>  </asp:HyperLink>
                                        </ItemTemplate>
                                        <ItemStyle Width="40px" Wrap="False" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Student Name" ItemStyle-CssClass="myName">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="Link4" runat="server" Text='<%# Bind("StudentName") %>'>  </asp:HyperLink>
                                        </ItemTemplate>
                                        <ItemStyle Width="150px" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Grade" HeaderText="Grade" ItemStyle-CssClass="myGrade">
                                        <ItemStyle Width="50px" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Gender" HeaderText="Gender" ItemStyle-CssClass="visible-sm visible-md visible-lg" HeaderStyle-CssClass="visible-sm visible-md visible-lg">
                                        <ItemStyle Width="50px" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="BirthDate" HeaderText="Birth Date">
                                        <ItemStyle Width="100px" Wrap="true" />
                                    </asp:BoundField>
                                     <asp:BoundField DataField="HomeRoom" HeaderText="Home Room">
                                        <ItemStyle Width="100px" Wrap="true" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Exceptionality">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="Link5" runat="server" Text='<%# Bind("Exceptionality") %>'>  </asp:HyperLink>
                                        </ItemTemplate>
                                        <ItemStyle Width="120px" Wrap="true" />
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="StudentNo" HeaderText="Student No." ReadOnly="True" ItemStyle-CssClass="StudentNo">
                                        <ItemStyle Width="80px" Wrap="False" />
                                    </asp:BoundField>


                                    <asp:BoundField DataField="OEN" ReadOnly="True" HeaderText="OEN Number" ItemStyle-CssClass="OEN">
                                        <ItemStyle Width="80px" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SchoolName" ReadOnly="True" HeaderText="School" ItemStyle-CssClass="School">
                                        <ItemStyle Width="250px" />
                                    </asp:BoundField>

                                    <asp:TemplateField HeaderText="Gift">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chbGift" Checked='<%# Convert.ToBoolean(Eval("IsGift"))%>' runat="server" CssClass="myCheckGift"></asp:CheckBox>
                                        </ItemTemplate>
                                        <ItemStyle Width="30px" HorizontalAlign="center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="IPRC">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chbIPRC" Checked='<%# Convert.ToBoolean(Eval("IsIPRC"))%>' runat="server" CssClass="myCheckIPRC"></asp:CheckBox>
                                        </ItemTemplate>
                                        <ItemStyle Width="30px" HorizontalAlign="center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="IEP">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chbIEP" Checked='<%# Convert.ToBoolean(Eval("IsIEP"))%>' runat="server" CssClass="myCheckIEP"></asp:CheckBox>
                                        </ItemTemplate>
                                        <ItemStyle Width="30px" HorizontalAlign="center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Alternative">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chbAlternative" Checked='<%# Convert.ToBoolean(Eval("IsAlternative"))%>' runat="server" CssClass="myCheckAlternative"></asp:CheckBox>
                                        </ItemTemplate>
                                        <ItemStyle Width="50px" HorizontalAlign="center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SSN">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chbSSN" Checked='<%# Convert.ToBoolean(Eval("IsSSN"))%>' runat="server" CssClass="myCheckSSN"></asp:CheckBox>
                                        </ItemTemplate>
                                        <ItemStyle Width="30px" HorizontalAlign="center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ESL">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chbESL" Checked='<%# Convert.ToBoolean(Eval("IsESL"))%>' runat="server" CssClass="myCheckSSN"></asp:CheckBox>
                                        </ItemTemplate>
                                        <ItemStyle Width="30px" HorizontalAlign="center" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Comments" HeaderText="Comments" ItemStyle-CssClass="visible-sm visible-md visible-lg" HeaderStyle-CssClass="visible-sm visible-md visible-lg">
                                        <ItemStyle Width="20%" Wrap="True" />
                                    </asp:BoundField>


                                    <asp:BoundField DataField="StudentID" ReadOnly="True" ItemStyle-CssClass="StudentID" Visible="false">

                                        <%-- <ItemStyle Width="0px" />--%>
                                    </asp:BoundField>

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
        <div id="alphabateSearch">
            <ul>
                <li class="alphabateKey"><a href="#" class="alphabateLink">A</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">B</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">C</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">D</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">E</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink"></a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">F</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">G</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">H</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">I</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">J</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink"></a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">K</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">L</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">M</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">N</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">O</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink"></a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">P</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">Q</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">R</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">S</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">T</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink"></a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">U</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">V</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">W</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">X</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">Y</a></li>
                <li class="alphabateKey"><a href="#" class="alphabateLink">Z</a></li>
            </ul>
        </div>

        <div id="HelpDIV" class="bubble epahide">
            <asp:TextBox ID="HelpTextContent" runat="server" TextMode="MultiLine" CssClass="HelpTextBox" BackColor="transparent"></asp:TextBox>

        </div>

        <div id="ActionMenuDIV" class="bubble epahide">
            <asp:Label runat="server" ID="LabelTeacherName" Text=""> </asp:Label>

            <div id="ActionMenuUL" class="LeftSideMenu">

              <%--  <ul class="Top_ul" id="NUA-1">
                    <li id="TopItem_13" class="ItemLevel0"><a id="B-13" class="Level-2" href="#" target="">User Management</a>
                        <img style="height: 25px; width: 30px; float: right; padding-top: -3px;" src="images/submenu.png">
                        <ul class="ItemLevel1_ul hideMenuItem" id="NUA-13">
                            <li id="TopItem_131" class="ItemLevel1"><a id="C-131" class="Level-3" href="SICSetup/Loading.aspx?pID=ApplicationRole" target="GoList">User Role Setup</a> </li>
                            <li id="TopItem_132" class="ItemLevel1"><a id="C-132" class="Level-3" href="SICSetup/Loading.aspx?pID=UserManagement" target="GoList">User Management</a> </li>
                            <li id="TopItem_133" class="ItemLevel1"><a id="C-133" class="Level-3" href="SICSetup/Loading.aspx?pID=MultipleSchoolUser" target="GoList">Multiple School Work User Management</a> </li>
                        </ul>
                    </li>
                    <li id="TopItem_14" class="ItemLevel0"><a id="B-14" class="Level-2" href="#" target="GoList">Example Page</a>
                        <img style="height: 25px; width: 30px; float: right; padding-top: -3px;" src="images/submenu.png">
                        <ul class="ItemLevel1_ul hideMenuItem" id="NUA-14">
                            <li id="TopItem_141" class="ItemLevel1"><a id="C-141" class="Level-3" href="SICSetup/Loading.aspx?pID=ClientPage" target="GoList">Client Call Web Service</a> </li>
                            <li id="TopItem_142" class="ItemLevel1"><a id="C-142" class="Level-3" href="SICSetup/Loading.aspx?pID=ClientPageApi" target="GoList">Client Call Web API</a> </li>
                        </ul>
                    </li>
                    <li id="TopItem_15" class="ItemLevel0"><a id="B-15" class="Level-2" href="#" target="">School Management</a>
                        <img style="height: 25px; width: 30px; float: right; padding-top: -3px;" src="images/submenu.png">
                        <ul class="ItemLevel1_ul hideMenuItem" id="NUA-15">
                            <li id="TopItem_151" class="ItemLevel1"><a id="C-151" class="Level-3" href="SICSetup/Loading.aspx?pID=SchoolDistrictSetup" target="GoList">School District Setup</a> </li>
                            <li id="TopItem_152" class="ItemLevel1"><a id="C-152" class="Level-3" href="SICSetup/Loading.aspx?pID=SchoolRegionSetup" target="GoList">School Region Setup</a> </li>
                            <li id="TopItem_153" class="ItemLevel1"><a id="C-153" class="Level-3" href="SICSetup/Loading.aspx?pID=SchoolManagement" target="GoList">School Department Management</a> </li>
                        </ul>
                    </li>
                </ul>--%>



                <%-- <ul id="ActionMenuULsub">
                    <li id="submenu1"><a class="menuLink" href="javascript:openPage(5,10,750,1000,'IEPForm');">IEP Form </a></li>
                    <li id="submenu2"><a class="menuLink" href="javascript:openPage(5,10,750,1000,'IEPReport');">IEP Report </a></li>
                    <li id="submenu3"><a class="menuLink" href="javascript:openPage(5,10,750,1000,'GiftForm');">Gift Form </a></li>
                    <li id="submenu4"><a class="menuLink" href="javascript:openPage(5,10,750,1000,'GiftReport');">Gift Report </a></li>
                    <li id="submenu5"><a class="menuLink" href="javascript:openPage(5,10,750,1000,'AlterRCForm');">Alternative Report Card</a></li>
                    <li id="submenu6"><a class="menuLink" href="javascript:openPage(5,10,750,1000,'AlterRCReport');">Alternative Report Card Report </a></li>

                </ul>--%>
            </div>


        </div>
        <div id="PopUpDIV" class="bubble epahide"></div>
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
            <asp:HiddenField ID="hfArea" runat="server" />
            <asp:HiddenField ID="hfItemCode" runat="server" />
            <asp:HiddenField ID="hfUserID" runat="server" />
            <asp:HiddenField ID="hfUserRole" runat="server" />
            <asp:HiddenField ID="hfUserLoginRole" runat="server" />
            <asp:HiddenField ID="hfRunningModel" runat="server" />
            <asp:HiddenField ID="hfSearchTextFields" runat="server" />
            <input id ="clipboardText" type ="text" style="position:absolute;top:10px;left:-500px;" />
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

    var BaseParaDDL = {
        Operate: "Get",
        UserID: $("#hfUserID").val(),
        UserRole: $("#hfUserRole").val(),
        SchoolYear: $("#ddlSchoolYear").val(),
        SchoolCode: $("#ddlSchool").val(),
        Para1: "",
        Para2: "",
        Para3: "",
    };

    var stName;
    var stID;
    var scYear;
    var scCode;
    var Grade;
    var myKey;
    var currentTR;
    var myIDs;
    var currentSearchBoxID = "";

    function pageLoad(sender, args) {
        $(document).ready(function () {
            // currentSearchBoxID = "TextBoxAge";
            //$("#btnSearchGoLastName").hide();
            //$("#btnSearchGoFirstName").hide();
            //$("#btnSearchGoOEN").hide();
            //$("#btnSearchGoStudentNo").hide();
            //$("#btnSearchGoClass").hide();
            //$("#btnSearchGoAge").hide();
            try {
              //  $("#btnSearchGo" + $("#hfSearchby").val()).show();
                $("#btnSearchGo" + $("#hfSearchby").val()).removeClass("hideMe");

            }
            catch (e) { }
            var vHeight = window.innerHeight - 120;
            MakeStaticHeader("GridView1", vHeight, 1500, 20, false);
            preaLinkID = $("#hfSelectedTabL").val();
            ChangeHeaderSchoolName();
            // CheckSearchControl()

            $("#GridView1 tr").mouseenter(function (event) {
                //if (currentTR != undefined) { currentTR.removeClass("highlightRow"); }
                //currentTR = $(this)
                //currentTR.addClass("highlightRow");
                if ($("#ActionMenuDIV").is(":visible")) $("#ActionMenuDIV").hide();
            });
            $("#GradeTab").click(function (e) {
                var cEvantID = e.originalEvent.srcElement.id;
                $("#hfSelectedTab").val(cEvantID);
                $("#hfSelectedTabL").val(e.originalEvent.srcElement.parentNode.id);
                $("#btnGradeTab").click();
                preaLinkID = $("#hfSelectedTabL").val();
            });
            $(".alphabateLink").click(function (e) {

                var cEvantID = e.currentTarget.innerText;
                $("#hfSearchby").val("LastName");
                $("#hfSearchValue").val(cEvantID);
                $("#btnGradeTab").click();
            });
            $(".SearchTextBox").change(function (e) {
                var cEvantID = e.currentTarget.id;
                currentSearchBoxID = cEvantID;
                $("#hfSearchby").val(cEvantID.replace("TextBox", ""));
                $("#hfSearchValue").val(e.currentTarget.value);
                $("#hfSelectedTab").val("00");
            });
            $(".SearchTextBox").focus(function (e) {
                try {
                    var cEvantID = e.currentTarget.id;
                    var preBox = $("#hfSearchby").val();
                    $("#hfSearchby").val(cEvantID.replace("TextBox", ""));
                    if (preBox != "") {
                        $("#btnSearchGo" + preBox).addClass("hideMe"); // .hide();
                        $("#TextBox" + preBox).val("");
                        $("#TextBox" + preBox).removeClass("highlightSearchBox");
                      

                        //  $("#" + currentSearchBoxID).val("");
                        //  $("#" + currentSearchBoxID.replace("TextBox", "btnSearchGo")).hide();
                    }

                  //  $("#" + cEvantID.replace("TextBox", "btnSearchGo")).show();
                    $("#" + cEvantID.replace("TextBox", "btnSearchGo")).removeClass("hideMe"); // .show();
                    $("#" + cEvantID).addClass("highlightSearchBox");
                    currentSearchBoxID = cEvantID;

                }
                catch (e) {
                    alert("Something error");
                }
            });
            // after client assibling the DDL control, the page event does not work **************** 
            //$("#DDLPanel").change(function () {
            //    BuildingSchoolList();
            //});
            //$("#ddlSearchby").change(function (e) {
            //    CheckSearchControl();
            //});
            // **************************************************************************************
        });
    }
    function clearSearhBox() {
        $("#" + currentSearchBoxID).val("");
    }
    function openTopSubMenu(cEventID, eY, eX) {


        $("#TopSubMenuItems").css({
            top: eY + 26,
            left: eX - 2,
            height: eH,
            width: 300
        })
        $("#TopSubMenuItems").show();
        currentY = eY;
        //  $("#TopSubMenuItems").fadeToggle("fast");
        //if (currentY != eY) {
        //    $("#TopSubMenuItems").fadeToggle("fast");
        //}

    }

    function BuildingSchoolList() {
        BaseParaDDL.Operate = "SchoolList";
        BaseParaDDL.SchoolYear = $("#ddlSchoolYear").val();
        BaseParaDDL.SchoolCode = $("#DDLPanel").val();

        var ddlList = ASM.Models.WebService.CommonLists(BaseParaDDL.Operate, BaseParaDDL, onSuccessSchoolList, onFailure);
    }
    function onSuccessSchoolList(result) {
        BuildingList.DropDown2($("#ddlSchool"), BuildingDropDownList(result), $("#ddlSchoolCode"), BuildingDropDownList1(result));

    }

    function CheckSearchControl() {
        var value = $("#ddlSearchby").val();
        var txtValue = $("#hfSearchTextFields").val();
        if (txtValue.indexOf(value) != -1) {
            $("#TextSearch").show();
            $("#ddlSearchValue").hide();
        }
        else {
            $("#TextSearch").hide();
            $("#ddlSearchValue").show();
            ChangeSearchValueList();
        }
    }
  
    function ChangeSearchValueList() {
        BaseParaDDL.Operate = $("#ddlSearchby").val();
        BaseParaDDL.SchoolYear = $("#ddlSchoolYear").val();
        BaseParaDDL.SchoolCode = $("#ddlSchool").val();
        BaseParaDDL.Para1 = $("#ddlSemester").val();
        BaseParaDDL.Para2 = $("#ddlTerm").val();
        var ddlList = ASM.Models.WebService.CommonLists(BaseParaDDL.Operate, BaseParaDDL, onSuccessDDL, onFailure);
    }

    function onSuccessDDL(result) {
        BuildingList.DropDown($("#ddlSearchValue"), BuildingDropDownList(result));
    }


    var DataUrl = {
        "myUrl": "https://webt.tcdsb.org/Webapi/ASM/Api/ASM/"
    }

    function getUrl() {
        return DataUrl.myUrl + "?Operate=" + BaseParaDDL.Operate + "&UserID=" + BaseParaDDL.UserID + "&UserRole=" + BaseParaDDL.UserRole + "&SchoolYear=" + BaseParaDDL.SchoolYear + "&SchoolCode=" + BaseParaDDL.SchoolCode + "&Para1=1&Para2=2&Para3=1";
    }

    function ChangeSearchValueListAPI() {
        BaseParaDDL.Operate = $("#ddlSearchby").val();
        BaseParaDDL.SchoolYear = $("#ddlSchoolYear").val();
        BaseParaDDL.SchoolCode = $("#ddlSchool").val();
        var myUrl = getUrl();
        $.get(myUrl, function (data, status) {
            // alert("Data: " + data + "\nStatus: " + status);
            var objControl = $("#ddlSearchValue");
            var myData = JSON.parse(data);
            BuildingDDList(myData, objControl);
        });
        //$.getJSON(myUrl, function (result) {
        //    $.each(result, function (i, field) {
        //        $("div").append(field + " ");
        //    });
        //});
    }

</script>
