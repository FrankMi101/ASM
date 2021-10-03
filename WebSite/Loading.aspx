<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Loading.aspx.cs" Inherits="ASM.Loading" %>

<!DOCTYPE  ">
<html >

<head runat="server">
    <title>Loading Page</title>
    <style>
        div {
      /*      height: 99.5%;
            width: 99.5%;*/
            text-align: center;
            margin: 0 auto;
            padding-top: 15%;
        }
    </style>
</head>
<body>
    <div>
        Home Loading Page <br />
        <img src="images/Loading.gif" />
        <a id="PageURL" runat="server" href='#' target="_self">Loading ......</a>

    </div>

    <script type="text/javascript">
        var myHref = document.getElementById("PageURL").getAttribute("href");
        window.location.href = myHref;
    </script>

</body>
</html>

