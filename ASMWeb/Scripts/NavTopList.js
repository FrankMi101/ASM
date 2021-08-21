function myTopNav(myMenuList) {
    //  var CurrentUserRole = $("#ctl00_hfCurrentUserRole").val();
    //  var menulist = myTopNavRecurse(myMenuList, "");
    var menulist = myTopNavLoopRecurse(myMenuList, "N");
    $("#TopNav").html("");
    $("#TopNav").html(menulist);
    var menulistM = myTopNavLoopRecurse(myMenuList, "M");
    $("#TopNavM").html("");
    $("#TopNavM").html(menulistM);

}
function myTopNavM(myMenuList) {
    var menulistM = myTopNavLoopRecurse(myMenuList, "M");
    $("#TopNavM").html("");
    $("#TopNavM").html(menulistM);
}

var ctlID = "";
function myTopNavLoop(myMenuList, mobile) {
    var CurrentUserRole = $("#" + ctlID + "hfCurrentUserRole").val();
    if (myMenuList.length > 0) {
        var menulist = '<ul class="Level1" id="' + mobile + 'UA0' + '" > '; // "&nbsp |&nbsp";
        for (var i = 0; i < myMenuList.length; i++) {
            if (checkItemShowbyRole(CurrentUserRole, myMenuList[i].role) === "Show") {
                menulist += getMyALink(myMenuList, i, 'A', mobile);
                if (typeof (myMenuList[i].subItems) !== 'undefined' && myMenuList[i].subItems.length > 0) {
                    var myMenuList2 = myMenuList[i].subItems;
                    var menulist2 = '<ul class="' + getULclass("Level2", mobile, 'UA' + myMenuList[i].ID) + '" id="' + mobile + 'UA' + myMenuList[i].ID + '" > ';
                    for (var j = 0; j < myMenuList2.length; j++) {
                        if (checkItemShowbyRole(CurrentUserRole, myMenuList2[j].role) === "Show") {
                            menulist2 += getMyALink(myMenuList2, j, 'B', mobile);
                            if (typeof (myMenuList2[j].subItems) !== 'undefined' && myMenuList2[j].subItems.length > 0) {
                                var myMenuList3 = myMenuList2[j].subItems;
                                var menulist3 = '<ul class="' + getULclass("Level3", mobile, 'UA' + myMenuList2[j].ID) + '" id="' + mobile + 'UB' + myMenuList2[j].ID + '" > ';
                                for (var l = 0; l < myMenuList3.length; l++) {
                                    menulist3 += getMyALink(myMenuList3, l, 'C', mobile);
                                }
                                menulist2 += menulist3 + '</ul>' + '</li> ';
                            }
                        }
                    }
                    menulist += menulist2 + '</ul>' + '</li> ';
                }
            }
        }
        menulist += '</ul>';
    }
    return menulist;
}
function myTopNavLoop2(myMenuList1, mobile) {
    var CurrentUserRole = $("#" + ctlID + "hfCurrentUserRole").val();
    if (myMenuList1.length > 0) {
        var menulist1 = GetUL("Level1", 0, mobile); // '<ul class="Level1" id="' + mobile + 'UA0' + '" > '; // "&nbsp |&nbsp";
        for (var i = 0; i < myMenuList1.length; i++) {
            if (checkItemShowbyRole(CurrentUserRole, myMenuList1[i].role) === "Show") {
                menulist1 += getMyALink(myMenuList1, i, 'A', mobile);
                if (typeof myMenuList1[i].subItems !== 'undefined' && myMenuList1[i].subItems.length > 0) {
                    var myMenuList2 = myMenuList1[i].subItems;
                    var menulist2 = GetUL("Level2", myMenuList1[i].ID, mobile);  // '<ul class="' + getULclass("Level2", mobile, 'UA' + myMenuList1[i].ID) + '" id="' + mobile + 'UA' + myMenuList1[i].ID + '" > ';
                    for (var j = 0; j < myMenuList2.length; j++) {
                        if (checkItemShowbyRole(CurrentUserRole, myMenuList2[j].role) === "Show") {
                            menulist2 += getMyALink(myMenuList2, j, 'B', mobile);
                            if (typeof myMenuList2[j].subItems !== 'undefined' && myMenuList2[j].subItems.length > 0) {
                                var menulist3 = GetUL("Level3", myMenuList2[j].ID, mobile);  // '<ul class="' + getULclass("Level3", mobile, 'UA' + myMenuList2[j].ID) + '" id="' + mobile + 'UB' + myMenuList2[j].ID + '" > ';
                                var myMenuList3 = myMenuList2[j].subItems;
                                menulist2 += menulist3 + '</ul>' + '</li> ';
                                for (var l = 0; l < myMenuList3.length; l++) {
                                    menulist3 += getMyALink(myMenuList3, l, 'C', mobile);
                                }
                                menulist2 += menulist3 + '</ul>' + '</li> ';
                            }
                        }
                    }
                    menulist1 += menulist2 + '</ul>' + '</li> ';
                }
            }
        }
        menulist1 += '</ul>';
    }
    return menulist1;
}
function myTopNavLoop3(myMenuList1, mobile) {
    let userRole = $("#" + ctlID + "hfCurrentUserRole").val();
    if (myMenuList1.length > 0) {

        var menulist1 = GetUL("Level-1", 0, mobile); // '<ul class="Level1" id="' + mobile + 'UA0' + '" > '; // "&nbsp |&nbsp";
        for (var i = 0; i < myMenuList1.length; i++) {
            if (checkItemShowbyRole(userRole, myMenuList1[i].role) === "Show") {
                menulist1 += getMyALink(myMenuList1, i, "A", mobile);
                if (typeof myMenuList1[i].subItems !== 'undefined' && myMenuList1[i].subItems.length > 0) {
                    menulist1 += NodeStrRecurse(userRole, myMenuList1[i].ID, myMenuList1[i].subItems, mobile, myMenuList1[i].myClass) + '</ul>' + '</li> ';
                }
            }
        }
        menulist1 += '</ul>';

    }
    return menulist1;
}


function myTopNavLoopRecurse(myMenuList1, mobile) {

    if (myMenuList1.length > 0) {
        var menulist1 = "";
        menulist1 += NodeStrRecursion(0, myMenuList1, mobile, "Level-1") + '</ul>';
    }
    return menulist1;
}

function NodeStrRecursion(id, myMenuList, mobile, level) {
    const userRole = $("#" + ctlID + "hfCurrentUserRole").val();
    let nodeStr2 = GetUL(level, id, mobile);
    for (var j = 0; j < myMenuList.length; j++) {
        if (checkItemShowbyRole(userRole, myMenuList[j].role) === "Show") {
            nodeStr2 += getMyALink(myMenuList, j, mobile);
            if (typeof myMenuList[j].subItems !== 'undefined' && myMenuList[j].subItems.length > 0) {
                nodeStr2 += NodeStrRecursion(myMenuList[j].ID, myMenuList[j].subItems, mobile, myMenuList[j].myClass) + '</ul>' + '</li> ';
            }
        }
    }
    return nodeStr2;
}

function GetUL(classLevel, id, mobile) {
    if (classLevel === "Level-1")
        return '<ul class="' + classLevel + '" id="' + mobile + 'UA0' + '" > ';
    else
        return '<ul class="' + getULclass(classLevel, mobile, 'UA' + id) + '" id="' + mobile + 'UA-' + id + '" > ';

}

function getULclass(level, mobile, id) {
    var rClass = level;
    if (mobile === "M") {
        rClass = level + " hideMenuItem";
    }
    return rClass;
}

function checkItemShowbyRole(CurrentUserRole, RoleItem) {
    var roleStr = "";
    switch (CurrentUserRole) {
        case "Admin":
            roleStr = "Access, Admin, Principal, Teacher, All";
            break;
        case "Teacher":
            roleStr = "Access, Teacher, All";
            break;
        case "Secretary":
            roleStr = "Access ,Secretary, Teacher, All";
            break;
        case "Principal":
            roleStr = "Access ,Principal, Teacher, All";
            break;
        case "VicePrincipal":
            roleStr = "Access ,Principal, Teacher, All";
            break;
        default:
            roleStr = "Access, Principal, All";
            break;
    }
    return roleStr.indexOf(RoleItem) === -1 ? "Hide" : "Show";
}

function getShortLevel(myClass) {
    switch (myClass) {
        case "Level-1":
            return "A";
        case "Level-2":
            return "B";
        case "Level-3":
            return "C";
        default:
            return "A";
    }
}

function getMyALink(myArray, index, mobile) {
    var myString = ' <li id = "TopItem_' + myArray[index].ID + '" class= "TopMenuItem" > ' + aLinkStrTop(myArray, index, mobile);
    if (typeof myArray[index].subItems === 'undefined') {
        myString += '</li> ';
    }
    else {
        if (myArray[index].myClass === "Level-2") {
            myString += ' <img style ="height:25px; width:30px; float:right; padding-top:-3px;" src="images/submenu.png" /> ';
        }
    }
    return myString;
}

function aLinkStrTop(myArray, index, mobile) {
    return '<a id = "' + getShortLevel(myArray[index].myClass) + '-' + myArray[index].ID + '" '
            + 'class="' + myArray[index].myClass + '" '
            + 'href="' + getUrl(myArray[index].url, myArray[index].subItems, mobile) + '" '
            + 'target="' + getTarget(myArray[index].target, myArray[index].subItems, mobile) + '" >'
            + myArray[index].display + '</a> ';
}

//function getMyALinkOld(myArray, k, level, mobile) {
//    var myString = ' <li> <a ' + 'id="' + getShortLevel(myArray[k].myClass) + '-' + myArray[k].ID + '" '
//        + 'class="' + myArray[k].myClass + '" '
//        + 'href="' + getUrl(myArray[k].url, myArray[k].subItems, mobile) + '" '
//        + 'target="' + getTarget(myArray[k].target, myArray[k].subItems, mobile) + '" >'
//        + myArray[k].display + '</a> ';
//    //    + getStr(myArray[k].subItems, "ImgStr", "</li>", level);
//    if (typeof myArray[k].subItems === 'undefined') {
//        myString += '</li> ';
//    }
//    else {
//        if (myArray[k].myClass === "Level-2") {
//            myString += ' <img style ="height:25px; width:30px; float:right; padding-top:-3px;" src="images/submenu.png" /> ';
//        }
//    }
//    return myString;
//}

function getTarget(target, subitem, mobile) {
    if (mobile === "M" && typeof subitem === "undefined") {
        target = "GoList";
    }

    return target;
}

function getUrl(url, subitem, mobile) {
    var rUrl = url;
    if (mobile === "M") {
        rUrl = typeof subitem === "undefined" ? url : "#";
    }

    return rUrl;
}


function getStr(mySubItem, sType, pValue, level) {
    var rStr = pValue;
    if (typeof mySubItem !== 'undefined' && level !== "A") {
        switch (sType) {
            case "ImgStr":
                rStr = '  <img src="images/submenu.png" /> ' + pValue;
                break;
            case "Href":
                rStr = '#';
                break;
            case "Target":
                rStr = '_self';
                break;
            default:
                rStr = '_self';
                break;
        }

    }
    return rStr;

}

function OpenPopPage(goPage) {
    if (goPage === "Feed Back") {
        window.open("CommonPage/BaseFeedBack.aspx", "FormFeedBack", "width=700 height=550, top=20, left=20, toolbars=no, scrollbars=no,status=no,resizable=no");
    }
    if (goPage === "User Guildline") {
        window.open("CommonPage/LoadingDocument.aspx?dID=SS Forms Guide 2010-2011.pdf", "FormFeedBack", "width=700 height=550, top=20, left=20, toolbars=no, scrollbars=no,status=no,resizable=no");
    }
    if (goPage === "School Security") {
        var UserID = $("#" + ctlID + "hfUserID").val();
        window.open("CommonPage/PageLoading.aspx?Page=https://webapp.tcdsb.org/ssm/SecurityManage.aspx?aID=IEP%26uID=" + UserID, "FormFeedBack", "width=750 height=650, top=20, left=20, toolbars=no, scrollbars=no,status=no,resizable=no");
    }
}

var topSelectedMenuItem;
function HighLightTopWorkingMenu() {
    if (topSelectedMenuItem != 'undefined') $("#" + topSelectedMenuItem).addClass("TopSelectItem");
}
function SetWorkingMenuCell(cID) {
    if (cID.substring(0, 8) == "TopItem_" && cID.length == 9) {
        if (topSelectedMenuItem != "undefined") $("#" + topSelectedMenuItem).removeClass("TopSelectItem");
        topSelectedMenuItem = cID;
    }
}

$(document).ready(function () {

    try {
        //$(".Level-1").mouseover(function (e) { 
        //        var cID = e.originalEvent.srcElement.id;
        //        SetWorkingMenuCell(cID);
        //    });

        $("#TopItem_1").mouseover(function (e) { SetWorkingMenuCell("TopItem_1"); });
        $("#TopItem_2").mouseover(function (e) { SetWorkingMenuCell("TopItem_2"); });
        $("#TopItem_3").mouseover(function (e) { SetWorkingMenuCell("TopItem_3"); });
        $("#TopItem_4").mouseover(function (e) { SetWorkingMenuCell("TopItem_4"); });
        $("#TopItem_5").mouseover(function (e) { SetWorkingMenuCell("TopItem_5"); });
        $("#TopItem_9").mouseover(function (e) { SetWorkingMenuCell("TopItem_9"); });


        //$(".Level-2").click(function (e) {
        //    HighLightTopWorkingMenu();
        //});
        //$(".Level-3").click(function (e) {
        //    HighLightTopWorkingMenu();
        //    event.stopPropagation();
        //});
        $("#TopNav").mouseout(function (e) {
            HighLightTopWorkingMenu();
            event.stopPropagation();
        });
        $(".TopMenuItems a").hover(
            function (e) {
                var cEvantID = e.originalEvent.srcElement.id;
                var x = $("#" + cEvantID).position();
                openTopSubMenu(cEvantID, x.top, x.left);
            },
            function (e) {
                var cEvantID = e.originalEvent.srcElement.id;
                var x = $("#" + cEvantID).position();
                if (currentY > x.top) {
                    $("#TopSubMenuItems").hide();
                }
            }
        );
        $(".TopMenuItem").click( function (e) { 
           // alert( this.id);  
            $("#" + currentMenuID).removeClass("TopSelectItem");
            var cID =  this.id;
            if (cID.length == 10) currentMenuID = cID;
         });

        $("#TopNav .Level-2").click(function (e) {
           // alert("Class Level-2 click :" + e.currentTarget.innerText);
            var title = "Working Area: " + this.innerText; //   e.currentTarget.innerText;
            $("#LabelPageTitle").text(title);
        });
        $("#TopNav .Level-3").click(function (e) {
           // alert("Class Level-3 click :" + e.currentTarget.innerText);
            var parentID =   this.id.replace("C", "B").substring(0, 4);
            var pNode = document.getElementById(parentID);
            var pTitle = pNode.innerText;
            var title = "Working Area: " + pTitle + " >> " + this.innerText; // e.currentTarget.innerText;
            $("#LabelPageTitle").text(title);
            event.stopPropagation();

        });

        $("#TopNavM ul li").click(function (event) {

            var cEventID = "";
            var level = "1";
            try {
                cEventID = event.currentTarget.childNodes['3'].id;    //event.currentTarget.children['1'].id;// event.originalEvent.srcElement.id;
                if (cEventID === "") {
                    cEventID = event.currentTarget.childNodes['5'].id;    //event.currentTarget.children['1'].id;// event.originalEvent.srcElement.id;
                    level = "2";
                }
                //  window.alert(cEventID + " " + level + " " + currentNodeLevel1 + " " + currentNodeLevel2);
                openTopSubMenuM(cEventID, level);

                if (event.target.target === "GoList") {
                    $("#TopNavM").hide();
                    $("#" + currentNodeLevel1).removeClass("showMenuItem").addClass("hideMenuItem");
                    $("#" + currentNodeLevel2).removeClass("showMenuItem").addClass("hideMenuItem");
                }
              
                event.stopPropagation();
            }
            catch (e) {
                var k = "";
            }
        });


    }
    catch (ex) {
        var exm = ex;
    }
});

var mouse_x = 0;
var mouse_y = 0;
function getMousepoints() {
    mouse_x = event.clientX + document.body.scrollLeft;//to get client window X axis 
    mouse_y = event.clientY + document.body.scrollTop; //to get client window Y axis 
    return true;
}

function openSupportInformation(vLoading, vH, actions) {

    if ($("#ctl00_IframeSupport").attr("src") === "#") { $("#ctl00_IframeSupport").attr("src", vLoading); }

    $("#SupportInfoDIV").css({
        top: mouse_y + 10,
        left: mouse_x - 420,
        height: vH,
        width: 400
    });
    $("#SupportInfoDIV").fadeToggle("fast");
}
function openTopSubMenu(cEventID, eY, eX) {

   // alert("item hover" + cEvantID);

    var myArray = getmyJosnArrybyID(cEventID);
    myTopSubMenuList(myArray);
    var eH = getSubMenuListCount(myArray);
    $("#TopSubMenuItems").css({
        top: eY + 26,
        left: eX - 2,
        height: eH,
        width: 300
    });
    $("#TopSubMenuItems").show();
    currentY = eY;
    //  $("#TopSubMenuItems").fadeToggle("fast");
    //if (currentY != eY) {
    //    $("#TopSubMenuItems").fadeToggle("fast");
    //}

    alert("opeen submenu action");

}
function openTopSubMenuM(cEventID, Level) {

    //var cName = event.currentTarget.childNodes['3'].className;
    //cName = cName.replace("hideMenuItem", "showMenuItem")
    //event.currentTarget.childNodes['3'].className = cName;
    // window.alert(event.currentTarget.childNodes['3'].className);
    try {
        // window.alert( "F=" +currentNodeLevel1 + " S= " + currentNodeLevel2 + " Level= " + Level);
        if (Level === "1") {
            if (currentNodeLevel1 === cEventID) {
                $("#" + cEventID).removeClass("showMenuItem").addClass("hideMenuItem");
                currentNodeLevel1 = "";
            }
            else {
                if (currentNodeLevel1 !== "") {
                    $("#" + currentNodeLevel1).removeClass("showMenuItem").addClass("hideMenuItem");
                }
                $("#" + cEventID).removeClass("hideMenuItem").addClass("showMenuItem");
                currentNodeLevel1 = cEventID;
            }
        }
        else {
            if (currentNodeLevel2 === cEventID) {
                $("#" + cEventID).removeClass("showMenuItem").addClass("hideMenuItem");
                currentNodeLevel2 = "";
            }
            else {
                if (currentNodeLevel2 !== "") {
                    $("#" + currentNodeLevel2).removeClass("showMenuItem").addClass("hideMenuItem");
                }
                $("#" + cEventID).removeClass("hideMenuItem").addClass("showMenuItem");
                currentNodeLevel2 = cEventID;
            }
        }

    }
    catch (e) {
        var k = "";
    }
    // window.alert(event.currentTarget.childNodes['3'].className);
    //window.alert(openObj[0].className);
    //window.alert(openObj[0].className);
    //  window.alert($("#" + cEventID)[0].className);
    //  currentY = eY;

}