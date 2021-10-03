var BuildingList =
{
    DropDown: function (ObjControl, ObjData) { BindingList(ObjControl, ObjData); },
    DropDown2: function (ObjControl, ObjData, ObjControl2, ObjData2) { BindingList2(ObjControl, ObjData, ObjControl2, ObjData2); },
    CheckBox: function (ObjControl, ObjData) { BindingList(ObjControl, ObjData); },
    RaidoButton: function (ObjControl, ObjData) { BindingList(ObjControl, ObjData); },
    ListBox: function (ObjControl, ObjData) { BindingList(ObjControl, ObjData); },
    ULList: function (ObjControl, ObjData) { BindingList(ObjControl, ObjData); },
};

function BindingList(ObjControl, ObjHtml) {
    ObjControl.html("");
    ObjControl.html(ObjHtml);
}

function BindingList2(ObjControl, ObjHtml, ObjControl2, ObjHtml2) {
    BindingList(ObjControl, ObjHtml);
    BindingList(ObjControl2, ObjHtml2);

}

function BuildingULList(DataSet) {
    var list = "";
    for (x in DataSet) {
        var para = "javascript:openPage(" + DataSet[x].Value + "," + DataSet[x].Name + "')";
        list += ' <li><a class="menuLink" href="' + para + '">' + DataSet[x].Name + ' </a></li>';
    }
    return list;
}
function BuildingULList6(DataSet) {
    var list = "";
    for (x in DataSet) {
        var para = "javascript:openPage(" + DataSet[x].Ptop + "," + DataSet[x].Pleft + "," + DataSet[x].Pheight + "," + DataSet[x].Pwidth + ",'" + DataSet[x].MenuID + "','" + DataSet[x].Type + "')";
        list += ' <li><a class="menuLink" href="' + para + '">' + DataSet[x].Name + ' </a></li>';
    }
    return list;

}
function BuildingULListWithTab(DataSet) {
    var img = '<img style="height: 25px; width: 30px; float:right; padding-top: -3px; " src="../images/submenu.png">'
    var list = '<ul class="Top_ul" >';
    var tabData = getTabData(DataSet);
    var cData = "";

    tabData.forEach((item, index) => {
        var tabItemID = + "Tab_" + index.toString();
        list += '<li id="' + tabItemID + '"  class="ItemLevel0">' + img + '<a  href="#" target="">' + item + '</a>';
        list += '<ul class="ItemLevel1_ul hideMenuItem" >';
        for (x in DataSet) {
            var xItemID = tabItemID + '_menu_' + x.toString();
            var category = DataSet[x].Category;
            var para = "javascript:openPage(" + DataSet[x].Ptop + "," + DataSet[x].Pleft + "," + DataSet[x].Pheight + "," + DataSet[x].Pwidth + ",'" + DataSet[x].MenuID + "','" + DataSet[x].Type + "')";
            if (item == category)
                list += ' <li id="' + xItemID + '" class="ItemLevel1" >'
                    + '<img style="height: 18px; width: 18px; border="0" padding-top: -3px; src="../images/' + DataSet[x].Image + '"/>'
                    + '<a class="menuLink" href="' + para + '">'
                    + DataSet[x].Name + ' </a> </li>';
        };
        list += '</ul></li>';
    });
    list += '</ul>';
    return list;
}
function getTabData(DataSet) {
    var tabData = [];
    var cData = "";
    for (x in DataSet) {
        var category = DataSet[x].Category;
        if (cData !== category) tabData.push(category);
        cData = category;
    }
    //   alert(tabData);
    return tabData;
}

function BuildingDropDownList(DataSet) {
    var list = "";
    for (x in DataSet) {
        list += "<option value ='" + DataSet[x].Value + "'>" + DataSet[x].Name + "</option>";
    }
    return list;
}
function BuildingDropDownList1(DataSet) {
    var list = "";
    for (x in DataSet) {
        list += "<option value ='" + DataSet[x].Value + "'>" + DataSet[x].Value + "</option>";
    }
    return list;
}
function BuildingCheckBoxList(DataSet) {
    var list = "";
    var checkBoxListlist = "";
    for (x in DataSet) {
        var checkStr = GetCheckBoxElement(x, DataSet[x].Value, DataSet[x].Name, 0);
        checkBoxListlist += checkStr;
    }
    list = '<table><tbody>' + checkBoxListlist + '</tbody></table>';
    return list;
}
function BuildingRadioButtonList(DataSet) {
    var list = "";
    var radiobuttonlist = "";
    for (x in DataSet) {
        var radiobuttonStr = GetRadioListElement(x, DataSet[x].Value, DataSet[x].Name, 0);
        radiobuttonlist += radiobuttonStr;
    }
    list = "<tbody>" + radiobuttonlist + "</tbody>";
    return list;

}
function BuildingListBoxList(DataSet) {
    var list = "";
    for (x in DataSet) {
        list += "<option value ='" + DataSet[x].Value + "'>" + DataSet[x].Name + "</option>";
    }
    return list;
}
function GetCheckBoxElement(x, value, name, checked) {
    var addEvent = "onclick ='javascript:getSelected()'";
    var controlId = "cbl_" + x;
    var controlName = "cbl$" + x;
    var checkedStr = "";
    if (checked == "1")
        checkedStr = 'checked="checked"'
    var inputStr = '<input type="checkbox" class ="qualClick" id ="' + controlId + '" name="' + controlName + '" value="' + value + '"' + checkedStr + '> ';
    var labelStr = '<label class ="qualClick"' + addEvent + ' for= "' + controlId + '" > ' + name + '</label > ';
    return '<tr><td>' + inputStr + labelStr + '</td></tr>';
}
function GetRadioListElement(x, value, name, checked) {
    var addEvent = "onclick ='javascript:getSelected()'";
    var controlId = "radio_" + x;
    var controlName = "radio$" + x;
    var checkedStr = "";
    if (checked == "1")
        checkedStr = 'checked="checked"'
    var inputStr = '<input type="radio"  id ="' + controlId + '" name="' + controlName + '" value="' + value + '"' + checkedStr + '> ';
    var labelStr = '<label class ="qualClick"' + addEvent + ' for= "' + controlId + '" > ' + name + '</label > ';
    return '<tr><td>' + inputStr + labelStr + '</td></tr>';
}