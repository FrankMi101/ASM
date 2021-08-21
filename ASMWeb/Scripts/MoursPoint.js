
var IE = document.all ? true : false;
document.onmousemove = getMousepoints;
var mousex = 0;
var mousey = 0;
function getMousepoints() {
    mousex = event.clientX + document.body.scrollLeft;
    mousey = event.clientY + document.body.scrollTop;
    return true;
}

function IECompatibility() {
    var agentStr = navigator.userAgent;
    this.IsIE = false;
    this.IsOn = undefined;  //defined only if IE
    this.Version = undefined;
    this.Compatible = undefined;

    if (agentStr.indexOf("compatible") > -1) {
        this.IsIE = true;
        this.IsOn = true;
        this.Compatible = true;
    }
    else {
        this.Compatible = false;
    }

}

function CopyKeyIDToClipboard(vID) {
    try {
       // alert(vID);
        $("#clipboardText").val(vID);
        var copyText = document.querySelector("#clipboardText");
        copyText.select();
        document.execCommand("copy");
    }
    catch (e) {
        alert("Copy Key value to Clipboard Action Error!");
    }
}
//** only works on IE 
function CopyKeyIDToClipboardIE(vID) {
    try {
        window.clipboardData.clearData();
        window.clipboardData.setData("Text", vID);

        if (window.clipboardData) {
            window.clipboardData.clearData();
            window.clipboardData.setData("Text", vID);

        }
        else if (navigator.userAgent.indexOf("Opera") != -1) { window.location = vID; }
        else if (window.netscape) {
            try {
                netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
            }
            catch (e) { }
        }
    }
    catch (e) { }
}