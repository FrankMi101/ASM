var DOMaction = {
    CheckBoxList: function (obj, value) { OperationCheckBoxList(obj, value); },
    CheckBoxListValue: function (obj, type) { return OperationCheckBoxListSelectedStr(obj, type); },
    RadioButtonList: function (obj, value) { OperationRadioButtonList(obj, value); },
    RadioButtonListValue: function (obj, type) { return RadioButtonListSelectedValue(obj, type); },
    DropDownList: function (obj, value) { OperationDropDownList(obj, value); },
    InputText: function (obj, value) { OperationInputText(obj, value); },
    Button: function (obj, value) { OperationButton(obj, value); },
    DatePicker: function (obj, value) { OperationDatePicker(obj, value); },
    DatePickerInitial: function (objC, minD, maxD, value) { InitialJQueryDatePicker(objC, minD, maxD, value); }
};
function OperationCheckBoxList(obj, value) {
    try {
        obj.find('input:checkbox').each(function () {
            this.disabled = value;
        });
    }
    catch (ex) {
        var em = ex.message;
    }

}
function OperationCheckBoxListSelectedStr(obj, type) {
    try {
        var rVal = "";
        obj.find('input:checkbox').each(function () {
            if (this.checked) {
                if (type === "Code")
                    rVal += this.value + "; ";
                else
                    rVal += this.offsetParent.innerText + "; ";

            }

        });
        return rVal;
    }
    catch (ex) {
       var em = ex.message;
    }
}
function OperationRadioButtonList(obj, value) {
    try {
        obj.find('input:radio').each(function () {
            this.disabled = value;
        });
    }
    catch (ex)
    { var em = ex.message;}

}
function RadioButtonListSelectedValue(obj, type)
{
    try {
        if (type === "Text")
        { return $(obj + " input:checked").innerText(); }
        else 
            return $(obj + " input:checked").val();
    }
    catch (ex)
    { var em = ex.message;}
}
function OperationDropDownList(obj, value) {
    obj.prop("disabled", value);
}
function OperationInputText(obj, value) {
    obj.prop("readonly", value);
    obj.prop("disabled", value);
}
function OperationButton(obj, value) {
    try {
        obj.prop("disabled", value);
    }
    catch (ex)
    { var em = ex.message;}

}
function OperationDatePicker(obj, value) {
    try {
        obj.prop("disabled", value);
        obj.datepicker("disabled", value);
    }
    catch (ex)
    { var em = ex.message;}

}
var JDatePicker = {
    Initial: function (objC, minD, maxD, value) { InitialJQueryDatePicker(objC, minD, maxD, value); },
    InitialL: function (objC, value) { InitialJQueryDatePickerInSearchList(objC, value); },
    Enable: function (obj, value) { OperationDatePicker(obj, value); }
};
function InitialJQueryDatePicker(objC, minD, maxD, value) {

    objC.datepicker({
        dateFormat: 'yy-mm-dd',
        showOn: "button",
        buttonImage: "../images/calendar.gif",
        buttonImageOnly: true,
        changeMonth: true,
        changeYear: true
    });

    if (minD !== "undefined") objC.datepicker({ minDate: minD }); /*  IE 11 does not support this feature*/
    if (maxD !== "undefined") objC.datepicker({ maxDate: maxD }); /*  IE 11 does not support this feature*/
    if (value !== "undefined") objC.datepicker({ val: value }); /*  IE 11 does not support this feature*/
}
function InitialJQueryDatePickerInSearchList(objC,  value) {

   // InitialJQueryDatePicker(objC)    ;

    objC.datepicker({
        dateFormat: 'yy-mm-dd',
        showOn: "button",
        buttonImage: "../images/calendar.gif",
        buttonImageOnly: true,
        changeMonth: true,
        changeYear: true,
        beforeShow: function () {
            setTimeout(function () {
                $('#ui-datepicker-div').css('z-index', 999);
            }, 0);
        }
    });

    if (value !== "undefined") objC.datepicker({ val: value });/*  IE 11 does not support this feature*/

 

}