
var IE = document.all ? true : false;
document.onmousemove = getMousepoints;
var mousex = 0;
var mousey = 0;
function getMousepoints() {
    mousex = event.clientX + document.body.scrollLeft;
    mousey = event.clientY + document.body.scrollTop;
    return true;
}