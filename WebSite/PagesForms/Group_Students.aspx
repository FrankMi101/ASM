<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Group_Students.aspx.cs" Inherits="ASM.PagesForms.Group_Students" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Group Teacher List</title>
    <meta http-equiv="Pragma" content="No-cache" />
    <meta http-equiv="Cache-Control" content="no-Store,no-Cache" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="../Content/ListPage.css" rel="stylesheet" />
    <link href="../Content/ContentPage.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <%--<div id="DivRoot" style="width: 100%; height: 400px">   </div>--%>

            <div style="overflow: scroll; width: 100%; height:500px" onscroll="OnScrollDiv(this)" id="DivMainContent">
        <asp:GridView ID="GridView1" runat="server" CellPadding="1" Height="100%" Width="100%" GridLines="Both" AutoGenerateColumns="False" BackColor="White" BorderColor="gray" BorderStyle="Ridge" BorderWidth="1px" CellSpacing="1" EmptyDataText="No Students in current search condition" EmptyDataRowStyle-CssClass="emptyData" ShowHeaderWhenEmpty="true">
            <Columns>
                <asp:BoundField DataField="RowNo" HeaderText="No." ItemStyle-CssClass="myRowNo">
                    <ItemStyle Width="3%" />
                </asp:BoundField>
                <asp:BoundField DataField="StudentName" HeaderText="Student Name" ItemStyle-CssClass="myGrade">
                    <ItemStyle Width="30%" Wrap="True" />
                </asp:BoundField>
                <asp:BoundField DataField="Grade" HeaderText="Grade" ItemStyle-CssClass="myGrade">
                    <ItemStyle Width="5%" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="Gender" HeaderText="Gender" ItemStyle-CssClass="myGender">
                    <ItemStyle Width="5%" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="BirthDate" HeaderText="Birth Date">
                    <ItemStyle Width="10%" Wrap="true" />
                </asp:BoundField>

                <asp:BoundField DataField="StudentNo" HeaderText="Student No." ReadOnly="True" ItemStyle-CssClass="StudentNo">
                    <ItemStyle Width="11%" Wrap="False" />
                </asp:BoundField>

                <asp:BoundField DataField="OEN" ReadOnly="True" HeaderText="OEN" ItemStyle-CssClass="OEN">
                    <ItemStyle Width="11%" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="Status" ReadOnly="True" HeaderText="Status" ItemStyle-CssClass="Status">
                    <ItemStyle Width="10%" Wrap="False" />
                </asp:BoundField>

                <asp:BoundField DataField="ClassCode" ReadOnly="True" HeaderText="ClassCode" ItemStyle-CssClass="ClassCode">
                    <ItemStyle Width="15%" Wrap="False" />
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
    </form>
</body>
</html>
