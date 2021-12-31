function pageLoad(sender, args) {
    $(document).ready(function () {

        $("#closeMe").click(function (event) {
             $("#PopUpDIV").hide();
            $("#EditDIV").hide();

        });

    });
}


function OpenActionNew() {
    var page = "../PagesForms/Security_Role.aspx"
    var schoolyear = $("#hfSchoolYear").val();
    var schoolcode = $("#hfSchoolCode").val();
    var appID = $("#ddlApps").val();
    var xType = $("#ddlRoleType").val();
    var userID = $("#hfUserID").val();
    var userrole = $("#hfUserRole").val();
    var modelID = "Pages";
    var para = "?UserID=" + userID + "&UserRole=" + userrole + "&AppID=" + appID + "&ModelID=" + modelID + "&xID=" + xID + "&xType=" + xType + "&Action=Add";
    OpenInPage('New Security Role', page, para, "New Role");
}

function OpenAction(action, goPage, target, pHeight, pWidth, userID, userRole, appID, modelID, xID, xName, xType) {
    // var page = "../SICCommon/Security_Role.aspx"
    if ($("#hfUserRole").val() != "Admin") {
        alert("Current User is View Permission only");
    }
    else {
        var para = "?UserID=" + userID + "&UserRole=" + userRole + "&AppID=" + appID + "&ModelID=" + modelID + "&xID=" + xID + "&xType=" + xType + "&Action=" + action;
        var goPage = goPage + para
        if (target == "EditDIV") {
            OpenInPage(xName, goPage, pHeight, pWidth);
        }
        else {
            $("#" + target).attr('src', goPage);
        }
    }


}
function OpenInPage(title, page, pHeight, pWidth) {
    var pTop = 100;
    var pLeft = 50;
    if (pHeight > 500) pTop = 50;
    //    if (pWidth > 600) pLeft = 10;
    if (mousex > pWidth) pLeft = mousex - pWidth - 30;
    //  alert("y:" + mousey + "x:" + mousex);
    alert (page)
    try {

        $("#editiFrame").attr('src', page);
        $("#EditTitle").html(title);
        $("#EditDIV").css({
            top: pTop,
            left: pLeft,
            height: pHeight - 50,
            width: pWidth - 50
        });
        $("#EditDIV").fadeToggle("fast");
    }

    catch (e) {
        window.alert("Error:" + e.mess);
    }

}

function OpenFormFromListPage(title, page, arg, pHeight, pWidth) {
    var pageTemplte = GetEditPageTemplate()
    $("#Action-Pgae-Container").html(pageTemplte);
    var pTop = 50;

    var pLeft = 50;
    if (pHeight > 500) pTop = 50; 
    if (mousex > pWidth) pLeft = mousex - pWidth - 30;

    var goPage = "../PagesForms/Loading.aspx?pID=" + page + arg

    try {

        $("#editiFrame").attr('src', goPage);
        $("#EditTitle").html(title);
        $("#EditDIV").css({
            top: pTop,
            left: pLeft,
            height: pHeight - 50,
            width: pWidth - 50
        });
        $("#EditDIV").fadeToggle("fast");
    }

    catch (e) {
        window.alert("Error:" + e.mess);
    }

}
function GetEditPageTemplate() {
      return `<div id="PopUpDIV" class="bubble epahide"></div>
                <div id="EditDIV" runat="server" class="EditDIV bubble epahide">
                <div class="EditDIV-Header">
                    <div id="EditTitle" class="EditDIV-Header-Title"></div>
                    <div class="EditDIV-Header-Close">
                        <img id="closeMe" class="EditDIV-Header-Close-Img" onclick="CloseEditPage()" src="../images/close.png" />
                    </div>
                </div>
                <iframe class="EditPage" id="editiFrame" name="editiFrame" frameborder="0" scrolling="no" src="" runat="server"></iframe>
            </div>`
}
function CloseEditPage() {
    $("#PopUpDIV").hide();
    $("#EditDIV").hide();
}