
function myLeftNav(myMenuList) {
    //  var CurrentUserRole = $("#ctl00_hfCurrentUserRole").val();
    //  var menulist = myTopNavRecurse(myMenuList, "");
    var menulist = myNavLoop(myMenuList);
    $("#LeftMenuItems").html(menulist);
}

function myNavLoop(myMenuList) {
    var CurrentUserRole = $("#ctl00_hfCurrentUserRole").val();
    if (myMenuList.length > 0) {
        var menulist = '<ul class="Level1" id="' + 'UA-0' + '" > '; // "&nbsp |&nbsp";
        for (var i = 0; i < myMenuList.length; i++) {
            if (checkItemShowbyRole(CurrentUserRole, myMenuList[i].area) == "Show") {
                menulist += getMyALink(myMenuList, i, 'A')
                if (typeof (myMenuList[i].subItems) != 'undefined' && myMenuList[i].subItems.length > 0) {
                    var myMenuList2 = myMenuList[i].subItems;
                    var menulist2 = '<ul class="Level2" id="' + 'UA-' + myMenuList[i].ID + '" > ';
                    for (var j = 0; j < myMenuList2.length; j++) {
                        if (checkItemShowbyRole(CurrentUserRole, myMenuList[i].area) == "Show") {
                            menulist2 += getMyALink(myMenuList2, j, 'B')
                            if (typeof (myMenuList2[j].subItems) != 'undefined' && myMenuList2[j].subItems.length > 0) {
                                var myMenuList3 = myMenuList2[j].subItems;
                                var menulist3 = '<ul class="Level3" id="' + 'UB-' + myMenuList2[j].ID + '" > ';
                                for (var l = 0; l < myMenuList3.length; l++) {
                                    menulist3 += getMyALink(myMenuList3, l, 'C');
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


function getMyALink(myArray, k, level) {
    var myString = ' <li>' + '<img src="images/el_done1.bmp" runat="server"  /> '
                           + '<a ' + 'id="' + level + '-' + myArray[k].ID + '" '
                           + 'class="' + myArray[k].myClass + '" '
                           + 'href="' + getStr(myArray[k].subItems, "Href", myArray[k].url) + '" '
                           + 'target="' + getStr(myArray[k].subItems, "Target", myArray[k].target) + '" >'
                           + myArray[k].display + '</a> ' 
                           + getStr(myArray[k].subItems, "ImgStr", "</li>");


    //if (typeof (myArray[k].subItems) == 'undefined') {
    //    myString += ' </li> ';
    //}
    //else {
    //    myString += ' <img src="images/submenu.png" /> ';
    //}
    return myString;
}

function getStr(mySubItem, sType, pValue) {
    var rStr = ""
    if (typeof(mySubItem) == 'undefined') {       
                 rStr = pValue;
     }
    else {
        switch (sType) {
            case "ImgStr":
                rStr = '  <img src="images/submenu.png" /> ';
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

/* this is Recurse method to build menu list, but some how it does nt work.*/

function myTopNavRecurse(myMenuList, menulist) {
    var CurrentUserRole = $("#ctl00_hfCurrentUserRole").val();
    if (myMenuList.length > 0) {
        menulist += '<ul class="Level1" id="' + 'UA-0' + '" > '; // "&nbsp |&nbsp";
        for (var i = 0; i < myMenuList.length; i++) {
            if (checkItemShowbyRole(CurrentUserRole, myMenuList[i].role) == "Show") {
                menulist += getMyALink(myMenuList, i, 'A')
                if (typeof (myMenuList[i].subItems) == 'undefined') {
                    // menulist += '</ul>' + '</li> ';
                }
                else {
                    if (myMenuList[i].subItems.length > 0) {
                        myTopNavRecurse(myMenuList[i].subItems, menulist);
                    }
                }


            }
        }
        menulist += '</ul>';
    }
    return menulist;
}



function checkItemShowbyRole(CurrentUserRole, RoleItem) {
    var roleStr = ""
    switch (CurrentUserRole) {
        case "Admin":
            roleStr = "Access Admin, Principal,Teacher, APT, All"
            break;
        case "Teacher":
            roleStr = "Access Teacher, All"
        case "Principal":
            roleStr = "Access Principal,Teacher,All"
            break;
        case "APT/PAT":
            roleStr = "Access Principal,Teacher,APT,All"
            break;
        default:
            roleStr = "Access Principal,Teacher,All"
            break;
    }

    if (roleStr.indexOf(RoleItem) == -1)
    { return "Hide"; }
    else
    { return "Show"; }

}



function OpenPopPage(goPage) {
    if (goPage == "Feed Back") {
        window.open("CommonPage/BaseFeedBack.aspx", "FormFeedBack", "width=700 height=550, top=20, left=20, toolbars=no, scrollbars=no,status=no,resizable=no");
    }
    if (goPage == "User Guildline") {
        window.open("CommonPage/LoadingDocument.aspx?dID=SS Forms Guide 2010-2011.pdf", "FormFeedBack", "width=700 height=550, top=20, left=20, toolbars=no, scrollbars=no,status=no,resizable=no");
    }
    if (goPage == "School Security") {
        var UserID = $("#hfUserID").val();
        window.open("CommonPage/PageLoading.aspx?Page=https://webapp.tcdsb.org/ssm/SecurityManage.aspx?aID=IEP%26uID=" + UserID, "FormFeedBack", "width=750 height=650, top=20, left=20, toolbars=no, scrollbars=no,status=no,resizable=no");
    }
}

$(document).ready(function () {

    try {
        //$("#MenuItems").mouseleave(function (e) {

        //    if ($("#TopSubMenuItems")[0].style.display == "block") {
        //        $("#TopSubMenuItems").fadeToggle("fast");
        //    }
        //});

        $("#TopMenuItems a").hover(
           function (e) {
               var cEvantID = e.originalEvent.srcElement.id;
               var x = $("#" + cEvantID).position();
               openTopSubMenu(cEvantID, x.top, x.left);

           },
           function (e) {
               var cEvantID = e.originalEvent.srcElement.id;
               var x = $("#" + cEvantID).position();
               if (currentY > x.top)
               { $("#TopSubMenuItems").hide(); }

           }
        )

        $(".HeaderMaster").hover(function () {
            $("#TopSubMenuItems").hide();

        }
            )


        $("#TopSubMenuItems").hover(
         function (e) {
             var cEvantID = e.originalEvent.srcElement.id;


         },
         function (e) {
             $("#TopSubMenuItems").hide();
         });




        $("#ctl00_Header1_lblTCDSB").mouseout(function (e) {
            if ($("#SupportInfoDIV")[0].style.display == "block") {
                //   openSupportInformation();
                openSupportInformation("LoadingAppsInfo.aspx", 350, "out");
            }
        });

        $("#ctl00_Header1_lblTCDSB").mouseover(function (e) {
            if ($("#SupportInfoDIV")[0].style.display != "block") {
                //  openSupportInformation();
                openSupportInformation("LoadingAppsInfo.aspx", 350, "over");
            }
        });
        $("#ctl00_Header1_lblVersion").click(function (e) {
            //  openSupportInformationEdit();
            openSupportInformation("LoadingAppsInfo.aspx?aID=Edit", 550, "click");
        });
    }
    catch (e)
    { }
});


function openSupportInformation(vLoading, vH, actions) {

    if ($("#ctl00_IframeSupport").attr("src") == "#")
    { $("#ctl00_IframeSupport").attr("src", vLoading); }

    $("#SupportInfoDIV").css({
        top: mouse_y + 10,
        left: mouse_x - 420,
        height: vH,
        width: 400
    })
    $("#SupportInfoDIV").fadeToggle("fast");
}
function openTopSubMenu(cEventID, eY, eX) {

    var myArray = getmyJosnArrybyID(cEventID);
    myTopSubMenuList(myArray);
    var eH = getSubMenuListCount(myArray);
    $("#TopSubMenuItems").css({
        top: eY + 26,
        left: eX - 2,
        height: eH,
        width: 300
    })
    $("#TopSubMenuItems").show();
    currentY = eY;
    //  $("#TopSubMenuItems").fadeToggle("fast");
    //if (currentY != eY) {
    //    $("#TopSubMenuItems").fadeToggle("fast");
    //}

}