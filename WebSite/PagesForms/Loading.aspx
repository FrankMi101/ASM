<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Loading.aspx.cs" Inherits="ASM.PagesForms.Loading" %>


<!DOCTYPE  ">
<html >

<head runat="server">
    <title>Loading Page</title>
    <style>
        div {
             text-align: center;
            margin: 0 auto;
            padding-top: 20%;         
        }
      img {
          margin-bottom:-10px;
      }
      a {
            margin-left:20px;
        }
    </style>
</head>
<body>
    <div>
        Forms Loading Page <br />
        <img src="../images/Loading.gif" />
        <a id="PageURL" runat="server" href='#' target="_self">Loading ......</a>

    </div>

    <script type="text/javascript">
        var myHref = document.getElementById("PageURL").getAttribute("href");
        window.location.href = myHref;
    </script>

</body>
</html>
