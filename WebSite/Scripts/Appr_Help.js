var HelpPara = {
    Operate: "Get",
    UserID: $("#hfUserID").val(),
    Category: $("#hfCategory").val(),
    Area: $("#hfArea").val(),
    ItemCode: $("#hfItemCode").val(),
    ContentType: "Help",
    Value: ""
}
var helpDiv = $("#HelpDIV");
$(".imgHelp").mouseleave(function (event) {
    closeHelp();
});
$(".imgEP").mouseleave(function (event) {
    closeHelp();
});

function closeHelp() {
    if (helpDiv.css('display') === "block") {
        helpDiv.fadeToggle("fast");
        ItemCode = $("#hfCode").val();
    }
}
$(".imgHelp").dblclick(function (event) {

    EditPageItemTitle();
});


$(".imgEP").mouseenter(function (event) {
    //if ($(this)[0].id !== "") { ItemCode = $(this)[0].id.replace("img_", ""); }
    var vTop = event.currentTarget.offsetTop;
    var vLeft = event.currentTarget.offsetLeft;
    getHelp("EP", vTop, vLeft);
});
$(".imgHelp").mouseenter(function (event) {
    // if ($(this)[0].id !== "") { ItemCode = $(this)[0].id.replace("img_", ""); }
    var vTop = event.currentTarget.offsetTop;
    var vLeft = event.currentTarget.offsetLeft;
    getHelp("Help", vTop, vLeft);
});
function getHelp(type, vTop, vLeft) {
    //  if ($(this)[0].id !== "") { ItemCode = $(this)[0].id.replace("img_", ""); }
    HelpPara.ItemCode = $("#hfItemCode").val();
    HelpPara.HelpType = type;
    var helptext = SIC.Models.WebService.GetHelpContentByHelpPara("Read", HelpPara, onSuccessHelp, onFailureHelp);

    if (vLeft < 100) { vLeft = vLeft + 20; }
    else {
        if (vLeft - 300 < 0) { vLeft = vLeft - 100; }
        else {
            vLeft = vLeft - 300;
        }
    }
    if (window.innerWidth < 481) {
        vLeft = (window.innerWidth - 300) / 2;
        vTop = (window.innerHeight - 180) / 2;
    }
    else {
        if (vTop + 180 > window.innerHeight) {
            vTop = vTop - 180 - 25;
        }
    }
    helpDiv.css({
        top: vTop + 25,
        left: vLeft
    });
    helpDiv.fadeToggle("fast");

}
function onFailureHelp() {

}
function onSuccessHelp(result) {
    // $("#textHelp").text(result);

    var helpBox = $(".HelpTextBox");
    try {
        $("#HelpTextContent").val(result);
    }
    catch (ex) {
        var se = "";
    }
    try { $("#textHelp").html(result); }
    catch (ex) { var ex = ""; }


    helpBox.css({
        width: "98%"
    });
    var n = result.length;

    if (n > 1250) {
        helpDiv.css({
            height: 500,
            width: 650
        });
        helpBox.css({
            width: "99%"
        });
    }
    else {
        if (n > 1000) {
            helpDiv.css({
                height: 450,
                width: 550
            });
            helpBox.css({
                width: "99%"
            });
        } else {
            if (n > 750) {
                helpDiv.css({
                    height: 400,
                    width: 500
                });
            }
            else {
                if (n > 500) {
                    helpDiv.css({
                        height: 350,
                        width: 450
                    });
                }
                else {
                    if (n > 250) {
                        helpDiv.css({
                            height: 250,
                            width: 350
                        });
                    }
                    else {
                        helpDiv.css({
                            height: 150,
                            width: 200
                        });
                    }
                }
            }
        }
    }
}

function EditPageItemTitle() {

    if ($("#hfRunningModel").val() === "Design") {
        if ($("#ActionPOPDIV").css('display') === "block")             //TitleEditDIV
        {
            $("#ActionPOPDIV").fadeToggle("fast");
        }
        else {
            var pTitle = "Title and Help Conetent Edit";
            $("#ActioniFramePage").css({
                height: 490
            });
            goPage = "../Common/HelpEdit.aspx?type=" + CategoryID + "&aID=" + AreaID + "&iCode=" + ItemCode;
            $("#ActioniFramePage").attr('src', goPage);
            $("#ActionTitle").html(pTitle);
            $("#ActionPOPDIV").css({
                top: 50,
                left: 5,
                height: 520,
                width: 700
            });
            $("#ActionPOPDIV").fadeToggle("fast");
        }
    }
}

$(".labelTitle").dblclick(function (event) {
    ItemCode = $("#hfCode").val() + $(this)[0].id.replace("labelTitle", "");
    EditPageItemTitle();
});
$(".labelTitleX").dblclick(function (event) {
    ItemCode = $("#hfCode").val() + $(this)[0].id.replace("labelTitle", "");
    EditPageItemTitle();
});
$("#closeActionPOP").click(function (event) {
    $("#ActionPOPDIV").hide(); // .fadeToggle("fast");
});