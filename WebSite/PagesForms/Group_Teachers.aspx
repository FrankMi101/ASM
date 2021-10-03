<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Group_Teachers.aspx.cs" Inherits="ASM.PagesForms.Group_Teachers" %>

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
        <div id="DivRoot" style="width:99%; height: 500px">

            <div style="overflow: scroll; width: 99%; height:100%" onscroll="OnScrollDiv(this)" id="DivMainContent">
                <asp:GridView ID="GridView1" runat="server" CellPadding="1" Height="98%" Width="99%" GridLines="Both" AutoGenerateColumns="False" BackColor="White" BorderColor="gray" BorderStyle="Ridge" BorderWidth="1px" CellSpacing="1" EmptyDataText="No Appraisal Staff in current search condition" EmptyDataRowStyle-CssClass="emptyData" ShowHeaderWhenEmpty="true">
                    <Columns>
                        <asp:BoundField DataField="RowNo" HeaderText="No." ItemStyle-CssClass="myRowNo">
                            <ItemStyle Width="3%" />
                        </asp:BoundField>


                        <asp:BoundField DataField="MemberID" ReadOnly="True" HeaderText="Group Member">
                            <ItemStyle Width="25%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="MemberName" ReadOnly="True" HeaderText="Member Name">
                            <ItemStyle Width="35%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Permission" ReadOnly="True" HeaderText="Permission">
                            <ItemStyle Width="10%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="StartDate" ReadOnly="True" HeaderText="Start Date" ItemStyle-CssClass="StartDate">
                            <ItemStyle Width="10%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="EndDate" ReadOnly="True" HeaderText="End Date" ItemStyle-CssClass="EndDate">
                            <ItemStyle Width="10%" />
                        </asp:BoundField>

                        <asp:TemplateField HeaderText="Active">
                            <ItemTemplate>
                                <asp:CheckBox ID="chbActiveFlag" Checked='<%# Convert.ToBoolean(Eval("IsActive"))%>' runat="server" CssClass="myCheckActiveFlag"></asp:CheckBox>
                            </ItemTemplate>
                            <ItemStyle Width="7%" HorizontalAlign="center" />
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
    </form>
</body>
</html>
