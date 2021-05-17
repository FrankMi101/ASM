<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Loading3Report.aspx.cs" Inherits="ASM.Loading3Report" %>


<!DOCTYPE  ">
<html>

<head runat="server">
    <title>Loading Page</title>
    <style>
        body {
        height:500px;
        width:100%;
        margin:auto;
        }
        div { 
            text-align: center;
            margin:auto;
            padding-top: 20%;
        }
    </style>
</head>
<body>
    <div>
        <img src="../images/Loading.gif" />
        <a id="PageURL" runat="server" href='#' target="_self">Loading ......</a>
        <br />
        <br />
      <h2> 
            <asp:Label ID="NotPDFReport" runat="server" Text="No PDF report has been created" Visible="false" ForeColor="red"></asp:Label>
        </h2>
    </div>
   

    <script type="text/javascript">
        var myHref = document.getElementById("PageURL").getAttribute("href");
        window.location.href = myHref;
    </script>

</body>
</html>
