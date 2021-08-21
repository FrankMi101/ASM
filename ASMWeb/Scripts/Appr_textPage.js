$("#btnPrevious").click(function (event) {
    postBackAppraisalPage(); // save text change if Content hsas been Changed
  //  ChangeLeftMenuSelectedNode("Pre");
});
$("#btnNext").click(function (event) {
    postBackAppraisalPage(); // save text change if Content hsas been Changed
 //   ChangeLeftMenuSelectedNode("Next");
});

$("#myText").keydown(function (event) {
    CountTextBoxCharactors();
});
$("#myText").change(function (event) {
    if ($("#hfPageReadonly").val() !== "Yes")
    {
     $("#hfContentChange").val("1");
   }
});


$("#myText").on('paste', function (event) {
    if ($("#hfPageReadonly").val() !== "Yes")
    {
     $("#hfContentChange").val("1");
   }
});


function CountTextBoxCharactors() {
    try {
        $("#hfContentChange").val("1");
        var maxCount = $("#hfTextLength").val();
        var nCnt = $("#myText").val().length;
        if (nCnt > maxCount) {
            window.alert("Text longer than " + maxCount + " charaters");
        }
        else {
            $("#textCount").val(maxCount - nCnt);
        }
    }
    catch (ex)
    { var smg = ex.attr; }

}
function postBackAppraisalPage() {
    var appraisalPageTextChange = $("#hfContentChange").val();
    if (appraisalPageTextChange === "1") {
        var saveButton = $("#btnSave");
        saveButton.click();
    }
}
function ChangeLeftMenuSelectedNode(action) {
    try {
        selectedliCode = $("#hfCurrentli", parent.document).val();
      //  window.alert(selectedliCode);
       if (selectedliCode.length === 7) {
            selectedliCode = selectedliCode + "1";
        }
        if ($("#hfCurrentli", parent.document).val() !== "") {
            $("#" + $("#hfCurrentli", parent.document).val(), parent.document).removeClass("HighLightItem");
        }

        var newli;
        if (action === "Next") {
            newli = $("#" + selectedliCode, parent.document).next();
        }
        else {
            newli = $("#" + selectedliCode, parent.document).prev();
        }

        var newliNode;
        if (newli.length === 0) {
            var parentli = newli.prevObject[0].id; //parent;
            var parentnode = $("#" + parentli, parent.document).parent();
            var parentid = parentnode[0].parentNode.id;

            if (action === "Next")
            { newli = $("#" + parentid, parent.document).next(); }
            else
            { newli = $("#" + parentid, parent.document).prev(); }

            newliNode = newli[0].id;
        }
        else {
            newliNode = newli[0].id;
        }


        $("#hfCurrentli", parent.document).val(newliNode);
        $("#" + newliNode, parent.document).addClass('HighLightItem');
        window.alert("New Node:" + newliNode);
        event.stopPropagation();
    }
    catch (ex) {
        var smg = ex.attr;
    }

}

function Highlight_LeftMenuSelectNode() {
    try {
       /// selectedliCode = $("#hfCurrentli", parent.document).val();
        oldliCode = $("#hfCurrentli", parent.document).val();
        if (oldliCode !== "") {
            $("#" + oldliCode, parent.document).removeClass("HighLightItem");
        }
        newliCode = "li_" + ItemCode; 
        $("#hfCurrentli", parent.document).val(newliCode);
        $("#" + newliCode, parent.document).addClass('HighLightItem');
        event.stopPropagation();
    }
    catch (ex) {
        var smg = ex.attr;
    }

}
