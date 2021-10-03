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