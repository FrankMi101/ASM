var actionItemPosition;
var actionItemTitle;
var MenuDataSource;
var BasePara = {
    Operate: $("#hfPageID").val(),
    UserID: $("#hfUserID").val(),
    UserRole: $("#hfUserRole").val(),
    SchoolYear: "",
    SchoolCode: "",
    TabID: $("#hfSelectedTab").val(),
    ObjID: "",
    Semester: "",
    Term: "",
    Source: "InApp",
    AppID: "",
    GroupID: "",
    MemberID: "",
    MemberType: ""
};
function FetchMethod() {
    var url = "";
    fetch(url)
        .then(function (response) {
            response.text()
                .then(function (text) {
                    poemDisplay.textContent = text;
                });
        });
    /*
     The first line is saying "fetch the resource located at URL" (fetch(url)) and "then run the specified function 
     when the promise resolves" (.then(function() { ... })). "Resolve" means "finish performing the specified operation
     at some point in the future". The specified operation, in this case, is to fetch a resource from a specified URL
     (using an HTTP request), and return the response for us to do something with.
     Because the fetch() method returns a promise that resolves to the HTTP response, 
     any function you define inside a .then() chained onto the end of it will automatically be given the response as a parameter.
     You can call the parameter anything you like — the below example would still work:
   */
}

async function OpenMenu(dataSource, type, ids, schoolYear, schoolCode, appID, modelID, xID, xName, xType) {
    BasePara.Semester = $("#ddlSemester").val();
    BasePara.Term = $("#ddlTerm").val();
    BasePara.SchoolYear = schoolYear;
    BasePara.SchoolCode = schoolCode;
    BasePara.TabID = $("#hfSelectedTab").val();
    BasePara.ObjID = xID;
    BasePara.AppID = appID;
    actionItemTitle = xName;
    //  $("#ActionMenuTitle").text(xName);
    CopyKeyIDToClipboard(xID + " " + xName);
    var myUrl = "";
    var data;
    try {
        if (MenuDataSource == "JavaScriptJson") {
            data = myActionMenuData;
        }
        else {
            if (MenuDataSource == "WebApi") {
                var para = "Operate=" + BasePara.Operate + "&UserID=" + BasePara.UserID + "&UserRole=" + BasePara.UserRole + "&SchoolYear=" + schoolYear + "&SchoolCode=" + schoolCode + "&TabID=" + BasePara.TabID + "&ObjID=" + xID + "&AppID=" + appID;
                myUrl = "https://webt.tcdsb.org/Webapi/SIC/api/Menu/?" + para;
            }
            else if (MenuDataSource == "JsonFile") {
                myUrl = "../Scripts/ActionMenu.json";
            }
            const response = await fetch(myUrl);
            data = await response.json();
        }

        BuildingListMenuAction(data);
    }
    catch (ex) {
        alert(ex.message);
    }
}

async function OpenMenuWSAsync(action, type, ids, schoolYear, schoolCode, appID, modelID, xID, xName, xType) {
    // this async function dose not work
    BasePara.Semester = $("#ddlSemester").val();
    BasePara.Term = $("#ddlTerm").val();
    BasePara.SchoolYear = sYear;
    BasePara.SchoolCode = sCode;
    BasePara.TabID = $("#hfSelectedTab").val();
    BasePara.ObjID = objID;
    BasePara.AppID = oen;
    $("#ActionMenuTitle").text(sName);
    CopyKeyIDToClipboard(objID + " " + sName);

    // var para = "Operate=" + BasePara.Operate + "&UserID=" + BasePara.UserID + "&UserRole=" + BasePara.UserRole + "&SchoolYear=" + sYear + "&SchoolCode=" + sCode + "&TabID=" + BasePara.TabID + "&ObjID=" + objID + "&AppID=" + oen;
    var myUrl = "SIC.Models.WebService/ActionMenuListService(" + "Get" + BasePara + ")"


    //$.get(myUrl, function (data, status) {
    //    var myData = JSON.parse(data);
    //    BuildingListMenuAction(myData);
    //});
    try {
        const response = await fetch(myUrl);
        const data = await response.json();
        BuildingListMenuAction(data);
    }
    catch (ex) {
        alert(ex.message);
    }
}
function OpenMenuWS(sYear, sCode, tabID, objID, oen, sName) {
    BasePara.Semester = $("#ddlSemester").val();
    BasePara.Term = $("#ddlTerm").val();
    BasePara.SchoolYear = sYear;
    BasePara.SchoolCode = sCode;
    BasePara.TabID = $("#hfSelectedTab").val()
    BasePara.ObjID = objID;
    BasePara.AppID = oen;
    $("#ActionMenuTitle").text(sName);
    CopyKeyIDToClipboard(objID + " " + sName);
    var menuList = SIC.Models.WebService.ActionMenuListService("Get", BasePara, onSuccessMenuList, onFailure);
}
function OpenMenu2(userID, userRole, sYear, sCode, appID, groupID, memberID, memberType) {
    BasePara.Semester = $("#ddlSemester").val();
    BasePara.Term = $("#ddlTerm").val();
    BasePara.SchoolYear = sYear;
    BasePara.SchoolCode = sCode;
    BasePara.TabID = $("#hfSelectedTab").val()
    BasePara.ObjID = groupID;
    BasePara.AppID = appID;
    BasePara.GroupID = groupID;
    BasePara.MemberID = memberID;
    BasePara.MemberType = memberType;
    // $("#LabelTeacherName").text(sName);
    // CopyKeyIDToClipboard(objID + " " + sName);
    var menuList = SIC.Models.WebService.ActionMenuListService("Get", BasePara, onSuccessMenuList, onFailure);
}
function onFailure() {
    alert("Get Menu Failed!");
}

var ActionMenuLevel1Length;

function onSuccessMenuList(result) {

    BuildingListMenuAction(result);
}
function BuildingListMenuAction(menuData) {
    // console.log(result);
    var actionTemplate = GetActionMenuTemplate('ActionMenu');
    $("#Action-Page-Container").html(actionTemplate);

    BuildingList.ULList($("#ActionMenuUL"), BuildingActionMenuList(menuData));

    var menulength = ActionMenuLevel1Length * 40; //if (menulength < 150) menulength = 180 ;
    var menuWidth = 200; //215;

    if (ActionMenuLevel1Length == 1) {
        menulength = 100;
        menuWidth = 300;
    }

    ShowBuildingMenuList(menuWidth, menulength);
}
function BuildingActionMenuList(DataSet) {
    var Submenuimg = '<img class ="SubmenuImg" src="../images/submenu.png" />'; //'<img style="height: 25px; width: 25px; float:right; padding-top: -1px; " src="../images/submenu.png" />';
    var list = '<ul';
    var tabData = getTabData(DataSet);
    ActionMenuLevel1Length = tabData.length;
    if (ActionMenuLevel1Length === 1) {
        list += ' class="Top_ul_W" >';
        list += MenuItem.loop(DataSet, "Tab_1", '0');
    }
    else {
        list += ' class="Top_ul" >';
        tabData.forEach((item, index) => {
            var tabItemID = + "Tab_" + index.toString();
            list += MenuItem.li0(tabItemID, Submenuimg, item);
            list += MenuItem.ul();
            list += MenuItem.loop(DataSet, tabItemID, item);
            list += '</ul></li>';
        });
    }
    list += '</ul>';
   return list;
}

var MenuItem = {
    loop: function (data, tabid, item) { return loopMenu(data, tabid, item) },
    menu: function (data, tabid, item) { return menuElement(data, tabid, item); },
    li0: function (id, img, name) { return `<li id="${id}" class="ItemLevel0"> ${img} <a  href="#" target="">${name}</a>` },
    li: function (value) { return `<li id="${value}" class="ItemLevel1" >`; },
    img: function (img) { return `<img class="ItemImg" src="../images/${img}"/>`; },
    a: function (para, name) { return `<a class="menuLink" href=" ${para} "> ${name} </a>`; },
    ul: function () { return `<ul class="ItemLevel1_ul hideMenuItem" >` },
};

function loopMenu(Nodes, tabItemID, item) {
    var list = "";
    for (x in Nodes) {
        if (tabItemID === "Tab_1" && item === "0") { item = Nodes[x].Category };
        // var item = DataSet[x].Category;
        list += MenuItem.menu(Nodes[x], tabItemID, item);
    };
    return list
}

function menuElement(Node, tabItemID, item) {
    var list = ""
    var itemID = tabItemID + '_menu_' + x.toString();
    var category = Node.Category;
    var para = GetPara(Node);
    if (item == category)
        list += MenuItem.li(itemID) + MenuItem.img(Node.Image) + MenuItem.a(para, Node.Name) + '</li >';
    return list;
}
function GetPara(Node) {
    var para = "javascript:openPage(" + Node.Ptop + "," + Node.Pleft + "," + Node.Pheight + "," + Node.Pwidth + ",'" + Node.MenuID + "','" + Node.Category + "','" + Node.Area + "','" + Node.Type + "','" + Node.AppSource + "','" + Node.AppID + "')";
    return para
}
//function menuElement4(DataSet, tabItemID, item) {
//    var list = ""
//    var itemID = tabItemID + '_menu_' + x.toString();
//    var category = DataSet[x].Category;
//    var para = "javascript:openPage(" + DataSet[x].Ptop + "," + DataSet[x].Pleft + "," + DataSet[x].Pheight + "," + DataSet[x].Pwidth + ",'" + DataSet[x].MenuID + "','" + DataSet[x].Category + "','" + DataSet[x].Area + "','" + DataSet[x].Type + "','" + DataSet[x].AppSource + "','" + DataSet[x].AppID + "')";
//    if (item == category)
//        list += MenuItem.li(itemID) + MenuItem.img(DataSet[x].Image) + MenuItem.a(para, DataSet[x].Name) + '</li >';


//    return list;
//}
// function liElement(itemID) {
//    return `<li id="${itemID}" class="ItemLevel1" >`;
// }
// function imgElement(image) {
//    return `<img style="height: 18px; width: 18px; border: 0px; margin-top:auto;" src="../images/${image}"/>`;
// }
// function aLinkElement(para, name) {
//    return `<a class="menuLink" href=" ${para} "> ${name} </a>`;
// }

function ShowBuildingMenuList(width, length) {
    var vTop = mousey;
    if (vTop + length > 500) {
        vTop = vTop - length + 20;
    }
    var Objcontrol = $("#ActionMenuDIV");
    Objcontrol.css({
        top: vTop - 12,
        left: actionItemPosition,
        width: width,
        height: length
    });
    $('.ItemLevel1_ul').css('left', width - 19);

    Objcontrol.fadeToggle("fast");

}
function openPage(vTop, vLeft, vHeight, vWidth, menuID, category, area, type, source, appID) {
    if (vHeight == 999) vHeight = parent.window.innerHeight;
    if (vWidth == 9999) vWidth = parent.window.innerWidth;
    alert(" ActionMenu.js  --> H=" + vHeight + " : W= " + vWidth + " : Source =" + source + " : AppID =" + appID + " : Area =" + area + " : Category  =" + category);

    var para = "?pageID=" + menuID + "&uRole=" + BasePara.UserRole + "&sYear=" + BasePara.SchoolYear + "&sCode=" + BasePara.SchoolCode + "&grade=" + BasePara.TabID + "&sID=" + BasePara.ObjID + "&type=" + type + "&source=" + source + "&area=" + area + "&category=" + category + "&appID=" + appID + "&groupID=" + BasePara.GroupID + "&memberID=" + BasePara.MemberID;

    var goPage = "../Loading3.aspx"
    if (type == "PDF") goPage = "../Loading3Report.aspx";


    var goPage = goPage + para;

    try {
        $("#ActionMenuDIV").hide();
        $("#editiFrame", parent.document).attr('src', goPage);
        $("#EditTitle", parent.document).html(menuID + " " + BasePara.ObjID);
        $("#EditDIV", parent.document).css({
            top: vTop,
            left: vLeft,
            height: vHeight - 50,
            width: vWidth - 50
        });
        //   PopUpDIV2();
        $("#PopUpDIV", parent.document).fadeToggle("fast");
        $("#EditDIV", parent.document).fadeToggle("fast");

    }

    catch (e) {
        window.alert(e.mess + " Open Page Function Error.");
    }
}

function ChangeHeaderSchoolName() {
    var schoolcode = $("#ddlSchool").val();
    var schoolName = $("#ddlSchool option:selected").text();
    $("#LabelSchool", parent.document).text(schoolName);
    $("#LabelSchoolCode", parent.document).text(schoolcode);
    $("#LabelSchoolYear", parent.document).text($("#ddlSchoolYear").val());
}

function BuildingSchoolList() {
    BaseParaDDL.Operate = "SchoolList";
    BaseParaDDL.SchoolYear = $("#ddlSchoolYear").val();
    BaseParaDDL.SchoolCode = $("#DDLPanel").val();

    var ddlList = SIC.Models.WebService.CommonLists(BaseParaDDL.Operate, BaseParaDDL, onSuccessSchoolList, onFailure);
}
function onSuccessSchoolList(result) {
    BuildingList.DropDown2($("#ddlSchool"), BuildingDropDownList(result), $("#ddlSchoolCode"), BuildingDropDownList1(result));

}

function GO_ReportPrint(reportName) {
    if (reportName == "IEPPDF")

        var repara = {
            "PersonID": BasePara.PersonID,
            "SchoolYear": BasePara.SchoolYear,
            "SchoolCode": BasePara.SchoolCode,
            "Term": $("#ddlTerm").val()
        }
    var ddlList = SIC.Models.WebService.PrintReportService(reportName, repara, onSuccessPrintReport, onFailure);
}
function onSuccessPrintReport(result) {
    window.open(result);
}

function GetActionMenuTemplate(actionType) {
    if (actionType == "ActionMenu")
        return `<div id="ActionMenuDIV" class="bubble epahide">
                ${actionItemTitle} <div id="ActionMenuUL" class="LeftSideMenu"></div></div>`
    else
        return `<div id="HelpDIV" class="bubble epahide">
                <asp:TextBox ID="HelpTextContent" runat="server" TextMode="MultiLine" CssClass="HelpTextBox" BackColor="transparent"></asp:TextBox></div>`
}
var myActionMenuData = [
    {
        "Ptop": 5,
        "Pleft": 10,
        "Pwidth": 700,
        "Pheight": 600,
        "Area": "SecurityContentList",
        "Category": "Class Information",
        "Name": "View Class Students",
        "MenuID": "View Class Students",
        "AppID": null,
        "Type": "Form",
        "AppSource": "InApp",
        "Image": "list32.ico",
        "Orderby": "1-1"
    },

    {
        "Ptop": 5,
        "Pleft": 10,
        "Pwidth": 700,
        "Pheight": 600,
        "Area": "SecurityContentList",
        "Category": "Class Information",
        "Name": "View Group Member of Students",
        "MenuID": "Member of Stuents",
        "AppID": null,
        "Type": "Form",
        "AppSource": "InApp",
        "Image": "list32.ico",
        "Orderby": "2-1"
    }

]