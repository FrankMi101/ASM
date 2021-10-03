$(document).ready(function () {
    /* Vertical Tab click event */
    $(".spanTab").click(function (event) {
        var tabID = event.target.id;
        var aLinkID = tabID.replace("Span_", "");
        var tabText = preTitle + $("#" + tabID).text();
        setupFocusTab(tabID, tabText, aLinkID, "V");
    });

    $(".aLinkTab").click(function (event) {
        var tabID = event.target.id.replace("Span_", "");
        var tabText = preTitle + $("#Span_" + tabID).text();
        setupFocusTab(tabID, tabText, tabID, "V");
    });

    $(".aLinkTabS").click(function (event) {
        var tabID = event.target.id.replace("Span_", "");
        var tabText = preTitle + $("#Span_" + tabID).text();
        setupFocusTab2(tabID, tabText, tabID, "V", "aLinkTabS", "aLinkTab");
    });

    /* Horizontal Tab click event. Doesn't need Spane element  */
    $(".aLinkTabH").click(function (event) {
        var tabID = event.target.id;
        var tabText = preTitle + $("#" + tabID).text();
        setupFocusTab1(tabID, tabText, tabID, "H");
    });

    $(".aLinkTabHS").click(function (event) {
        var tabID = event.target.id;
        var tabText = preTitle + $("#" + tabID).text();
     //   setupFocusTab(tabID, tabText, tabID, "H");
        setupFocusTab2(tabID, tabText, tabID, "H", "aLinkTabHS", "aLinkTabH");
    });


});
function setupFocusTab(tabID, tabText, aLinkID, type) {
    var sTab = "";

    if (type === "V") {
       
        $("#" + preaLinkID).removeClass("aLinkTabS").addClass("aLinkTab");
        $("#" + aLinkID).removeClass("aLinkTab").addClass("aLinkTabS");
    }
    else {
 
        $("#" + preaLinkID).removeClass("aLinkTabHS").addClass("aLinkTabH");
        $("#" + aLinkID).removeClass("aLinkTabH").addClass("aLinkTabHS");

    }
    preaLinkID = aLinkID;
    /* setup the Navigation Area Title*/
   /*  try {
        $("#Header2N_lbl_Title").text(tabText);
        $("#Header2N_lbl_Title", parent.document).text(tabText);
    }
    catch (e)
    { }
    */

}
function setupFocusTab1(tabID, tabText, aLinkID, type ) {
    var sTab = "aLinkTabHS";
    var nTab = "aLinkTabH";

    if (type === "V") {
        sTab = "aLinkTabS";
        nTab = "aLinkTab";
    }
    $("#" + preaLinkID).removeClass(sTab).addClass(nTab);
    $("#" + aLinkID).removeClass(nTab).addClass(sTab);
    preaLinkID = aLinkID;
    /* setup the Navigation Area Title*/
    /*  try {
         $("#Header2N_lbl_Title").text(tabText);
         $("#Header2N_lbl_Title", parent.document).text(tabText);
     }
     catch (e)
     { }
     */

}
function setupFocusTab2(tabID, tabText, aLinkID, type, sTab, nTab) {
   
    $("#" + preaLinkID).removeClass(sTab).addClass(nTab);
    $("#" + aLinkID).removeClass(nTab).addClass(sTab);
    preaLinkID = aLinkID;
   
}