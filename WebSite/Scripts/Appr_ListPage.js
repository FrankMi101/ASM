
function pageLoad(sender, args) {

    $(document).ready(function () {

    
        
        $("#ActionMenuDIV").mouseleave(function (event) {
            $("#ActionMenuDIV").hide();
        });
        $('td.myAction').click(function (event) {
            myKey = $(this).closest('tr').find('td.hfmyKey').text();
            myIDs = $(this).closest('tr').find('td.hfIDs').text();
            rowNo = $(this).closest('tr').find('td.myRowNo').text();
            //var vTop = event.currentTarget.offsetTop  ;
            //var vLeft = event.currentTarget.offsetLeft;
            //OpenMenu("", "", "", "", "","", vTop, vLeft);

        });
        $('td.myAction').mouseenter(function (event) {
            myKey = $(this).closest('tr').find('td.hfmyKey').text();
            myIDs = $(this).closest('tr').find('td.hfIDs').text();
            rowNo = $(this).closest('tr').find('td.myRowNo').text();
            //var vTop = event.currentTarget.offsetTop;
            //var vLeft = event.currentTarget.offsetLeft;
            //OpenMenu("", "", "", "", "", "", vTop, vLeft);
        });


        $('#GridView1 tr').mouseenter(function (event) {
            newRowNo = $(this).closest('tr').find('td.myRowNo').text();

            if (currentTR !== undefined)
            { currentTR.removeClass("highlightBoard"); }
            currentTR = $(this);

            currentTR.addClass("highlightBoard");
        });
        $('#ddlSchoolYear').change(function (enevt) {
            var newValue = $(this).find("option:selected").text();
            $("#LabelSchoolYear", parent.document).text(newValue);
        });
        $("#ddlSchool").change(function () {
            var newCode = $(this).find("option:selected").val();
            $("#ddlSchoolCode").val(newCode);
            var newText = $(this).find("option:selected").text();
            $("#LabelSchool", parent.document).text(newText);
            $("#LabelSchoolCode", parent.document).text(newCode);
        });
        $("#ddlSchoolCode").change(function () {
            var newCode = $(this).find("option:selected").val();
            $("#ddlSchool").val(newCode);
            var newText = $("#ddlSchool").find("option:selected").text();
            $("#LabelSchool", parent.document).text(newText);
            $("#LabelSchoolCode", parent.document).text(newCode);
        });

    });

}

function upDataTitel(oldSchool, newSchool) {
    $("#hfSchoolname").val(newSchool);
    var titleControl = $("#Header1_Label2", parent.document).text();
    var newTitle = titleControl.replace(oldSchool, newSchool);
    $("#Header1_Label2", parent.document).text(newTitle);
}


function OpenHistory(employeeID, schoolYear, schoolCode, apprType, apprPhase, teacherName) {

    window.location.href = "Loading.aspx?pID=AppraisalHistory&yID=" + schoolYear + "&cID=" + schoolCode + "&tID=" + employeeID + "&tName=" + teacherName + "&phase=" + apprPhase;
}
function OpenALP(employeeID, schoolYear, schoolCode, apprType, apprPhase, teacherName) {
    teachername = teacherName;
    schoolyear = schoolYear;
    schoolcode = schoolCode;
    employeeid = employeeID;
    category = apprType;
    phase = apprPhase;
    var goPage = "EPAappraisal/Loading.aspx?pID=Appraisal"; //&yID=" + schoolYear + "&dID=" + schoolCode + "&eID=" + employeeID + "&phase=" + apprPhase;
    var vHeight = screen.height-  210;
    var vWidth = screen.width-25;// - 500;
    var pTitle = "Appraisal Annual Learnning Plan";
    openEditPage2(vHeight, vWidth, goPage, pTitle);
}
function OpenAppraisal(employeeID, schoolYear, schoolCode, apprType, apprPhase, teacherName) {
    teachername = teacherName;
    schoolyear = schoolYear;
    schoolcode = schoolCode;
    employeeid = employeeID;
    category = apprType;
    phase = apprPhase;
    var goPage = "EPAappraisal/Loading.aspx?pID=Appraisal"; //&yID=" + schoolYear + "&dID=" + schoolCode + "&eID=" + employeeID + "&phase=" + apprPhase;
    var vHeight = screen.height- 210;
    var vWidth = screen.width-25;// - 500;
    var pTitle = "Appraisal";
    openEditPage2(vHeight, vWidth, goPage, pTitle);
}

function OpenStaffEdit1() { 
    var goPage = "../EPAManage/Loading.aspx?pID=EditStaffProfile"; //+ "&eID=" + employeeID + "&IDs=" + IDs + "&tName=" + tName + "&cID=" + cID;
    var vHeight = 470;
    var vWidth = 650;
    var pTitle = "Staff Profile Edit";
    openEditPage3(vHeight, vWidth, goPage, pTitle);
}
function OpenStaffEdit(employeeID, schoolYear, schoolCode, teacherName) {
    teachername = teacherName;
    schoolyear = schoolYear;
    schoolcode = schoolCode;
    employeeid = employeeID;
    sessionid = "";
    var goPage = "../EPAManage/Loading.aspx?pID=EditStaffProfile"; //+ "&eID=" + employeeID + "&IDs=" + IDs + "&tName=" + tName + "&cID=" + cID;
    var vHeight = 470;
    var vWidth = 650;
    var pTitle = "Staff Profile Edit";
    openEditPage3(vHeight, vWidth, goPage, pTitle);
}
function OpenMenu(id,employeeID, schoolYear, schoolCode, apprType, apprPhase,sessionID, teacherName) {
    teachername = teacherName;
    schoolyear = schoolYear;
    schoolcode = schoolCode;
    employeeid = employeeID;
    sessionid = sessionID;
    category = apprType;
    phase = apprPhase;
    myIDs = id;
    CopyKeyIDToClipboard(employeeID + " " + teacherName);
    if (category === "TPA") {
        $("#submenu5").show();
    }
    else
    {
        $("#submenu5").hide();
    }
    $("#LabelTeacherName").text(teacherName);
    var vTop = mousey;
    if (vTop > 500) {
        vTop = vTop - 150;
    }
    //  var vLeft = event.currentTarget.offsetLeft;
    $("#ActionMenuDIV").css({
        top: vTop + 15,
        left: 60

    });
    $("#ActionMenuDIV").fadeToggle("fast");
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
function openEditPage(vHeight, vWidth, goPage, pTitle) {
    var vLeft = (screen.width / 2) - (vWidth / 2) - 100;
    var vTop = (screen.height / 2) - (vHeight / 2) - 100;
    goPage = goPage  + "&yID=" + schoolyear + "&cID=" + schoolcode + "&tID=" + employeeid + "&phase=" + phase + "&tName=" + teachername + "&type=" + category;
    $(document).ready(function () {
        try {
            $("#editiFrame", parent.document).attr('src', goPage);
            $("#EditTitle", parent.document).html(pTitle);
            //$("#hfInvokePageFrom", parent.document).val("LTOHRStaffs/PublishedList2.aspx");
            $("#EditDIV", parent.document).css({
                top: vTop,
                left: vLeft,
                height: vHeight,
                width: vWidth
            });
            //   PopUpDIV2();
            $("#PopUpDIV", parent.document).fadeToggle("fast");
            $("#EditDIV", parent.document).fadeToggle("fast");
            $("#ActionMenuDIV").fadeToggle("fast");
        }

        catch (e)
        {
            window.alert(e.mess);
        }

    });
}
function openEditPage2(vHeight1, vWidth1, goPage, pTitle) {
    var vWidth = (window.innerWidth > 0) ? window.innerWidth : screen.width;
    var vHeight = (window.innerHeight > 0) ? window.innerHeight : screen.height;
     var vLeft = (vWidth - 1024) / 2; 
    var vTop = (vHeight - 760) / 2 + 50;
//   window.alert(vleft + "  top : " + vTop);
    if (vHeight < 760)
    { vTop = 1;}
    if (screen.width < 1024) {
        vLeft = 1;
        vWidth = screen.width;
    }
    else
    { vWidth = 1024;}

    goPage = goPage + "&yID=" + schoolyear + "&cID=" + schoolcode + "&tID=" + employeeid + "&phase=" + phase + "&tName=" + teachername + "&type=" + category;
    $(document).ready(function () {
        try {
            $("#appriFrame", parent.document).attr('src', goPage);
            $("#EditTitle", parent.document).html(pTitle);
            //$("#hfInvokePageFrom", parent.document).val("LTOHRStaffs/PublishedList2.aspx");
            $("#ApprDIV", parent.document).css({
                top: vTop,
                left: vLeft
                // height: vHeight 
                // width: vWidth
            });
            //$("#appriFrame", parent.document).css({
            //    top: vTop,
            //    left: vLeft 
            //   // height: vHeight  
            //    //width: 98%
            //})

             $("#PopUpDIV", parent.document).fadeToggle("fast");
            $("#ApprDIV", parent.document).fadeToggle("fast");
        }

        catch (e) {
            window.alert(e.mess);
        }

    });
}

function openEditPage3(vHeight, vWidth, goPage, pTitle) {
    var vLeft = (screen.width / 2) - (vWidth / 2) - 100;
    var vTop = (screen.height / 2) - (vHeight / 2) - 100;
    goPage = goPage + "&yID=" + schoolyear + "&cID=" + schoolcode + "&tID=" + employeeid + "&sID=" + sessionid + "&tName=" + teachername + "&IDs=" + myIDs;
      try {

            $("#ActionMenuDIV").hide();
            $("#editiFrame", parent.document).attr('src', goPage);
          $("#EditTitle", parent.document).html(pTitle);
            //$("#hfInvokePageFrom", parent.document).val("LTOHRStaffs/PublishedList2.aspx");

          $("#EditDIV", parent.document).css({
              top: 100,
              left: 100,
              height: vHeight,
              width: vWidth
          });
          $("#editiFrame", parent.document).css({
              height: vHeight,
              width: vWidth,
              border: 0
          });
            //   PopUpDIV2();
            $("#PopUpDIV", parent.document).fadeToggle("fast");
            $("#EditDIV", parent.document).fadeToggle("fast");
          //  $("#ActionMenuDIV").fadeToggle("fast");
        }

      catch (e) {
          window.alert(e.mess);
      }
    //$(document).ready(function () {
   
    //});
}
function openEditPage5(vHeight, vWidth, goPage, pTitle) {
    var vLeft = (screen.width / 2) - (vWidth / 2) - 100;
    var vTop = (screen.height / 2) - (vHeight / 2) - 100;
    goPage = goPage + "&yID=" + schoolyear + "&cID=" + schoolcode + "&tID=" + employeeid + "&sID=" + sessionid + "&tName=" + teachername;
    try {

        $("#ActionMenuDIV").hide();
        $("#ActioniFramePage", parent.document).attr('src', goPage);
        $("#ActionTitle", parent.document).html(pTitle);
        //$("#hfInvokePageFrom", parent.document).val("LTOHRStaffs/PublishedList2.aspx");

        $("#ActionPOPDIV", parent.document).css({
            top: 100,
            left: 100,
            height: vHeight,
            width: vWidth
        });
        $("#ActioniFramePage", parent.document).css({

            height: vHeight,
            width: vWidth,
            border: 0


        });
        //   PopUpDIV2();
        $("#PopUpDIV", parent.document).fadeToggle("fast");
        $("#ActionPOPDIV", parent.document).fadeToggle("fast");
        //  $("#ActionMenuDIV").fadeToggle("fast");
    }

    catch (e) {
        window.alert(e.mess);
    }
  
}


/*
   function pageLoad(sender, args) {

        $(document).ready(function () {
            MakeStaticHeader("GridView1", 650, 1300, 25, false);

            $('td.myAction').click(function (event) {
                myKey = $(this).closest('tr').find('td.hfmyKey').text();
                rowNo = $(this).closest('tr').find('td.myRowNo').text();
                //var vTop = event.currentTarget.offsetTop  ;
                //var vLeft = event.currentTarget.offsetLeft;
                //OpenMenu("", "", "", "", "","", vTop, vLeft);

            });
            $('td.myAction').mouseenter(function (event) {
                myKey = $(this).closest('tr').find('td.hfmyKey').text();
                rowNo = $(this).closest('tr').find('td.myRowNo').text();
                //var vTop = event.currentTarget.offsetTop;
                //var vLeft = event.currentTarget.offsetLeft;
                //OpenMenu("", "", "", "", "", "", vTop, vLeft);
            });


            $('#GridView1 tr').mouseenter(function (event) {
                newRowNo = $(this).closest('tr').find('td.myRowNo').text();

                if (currentTR != undefined)
                { currentTR.removeClass("highlightBoard"); }
                currentTR = $(this);

                currentTR.addClass("highlightBoard");
            });

        });

    }
 

    function OpenAppraisal(employeeID, schoolYear, schoolCode, apprType, apprPhase, teacherName) {
        teachername = teacherName;
        schoolyear = schoolYear;
        schoolcode = schoolCode;
        employeeid = employeeID;
        phase = apprPhase;
        category = apprType;
        var goPage = "./EPAappraisal/Loading.aspx?pID=Appraisal"; //&yID=" + schoolYear + "&dID=" + schoolCode + "&eID=" + employeeID + "&phase=" + apprPhase;
        var vHeight = screen.height - 180;
        var vWidth = screen.width - 500;
        var pTitle = "Appraisal";
        openEditPage2(vHeight, vWidth, goPage, pTitle);
    }
    function OpenALP(employeeID, schoolYear, schoolCode, apprType, apprPhase, teacherName) {
        teachername = teacherName;
        schoolyear = schoolYear;
        schoolcode = schoolCode;
        employeeid = employeeID;
        phase = apprPhase;
        category = apprType;
        var goPage = "./EPAappraisal/Loading.aspx?pID=Appraisal"; //&yID=" + schoolYear + "&dID=" + schoolCode + "&eID=" + employeeID + "&phase=" + apprPhase;
        var vHeight = screen.height - 180;
        var vWidth = screen.width - 500;
        var pTitle = "Appraisal Annual Learnning Plan";
        openEditPage2(vHeight, vWidth, goPage, pTitle);
    }
    function OpenMenu(employeeID, schoolYear, schoolCode, apprType, apprPhase, teacherName) {
        teachername = teacherName;
        schoolyear = schoolYear;
        schoolcode = schoolCode;
        employeeid = employeeID;
        phase = apprPhase;
        category = apprType;
        $("#LabelTeacherName").text(teacherName);
        var vTop = mousey;
        if (vTop > 450) {
            vTop = vTop - 180;
        }
        //  var vLeft = event.currentTarget.offsetLeft;
        $("#ActionMenuDIV").css({
            top: vTop + 15,
            left: 75

        })
        $("#ActionMenuDIV").fadeToggle("fast");
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
    function openEditPage(vHeight, vWidth, goPage, pTitle) {
        var vLeft = (screen.width / 2) - (vWidth / 2) - 100;
        var vTop = (screen.height / 2) - (vHeight / 2) - 100;
        goPage = goPage + "&yID=" + schoolyear + "&cID=" + schoolcode + "&tID=" + employeeid + "&phase=" + phase + "&tName=" + teachername;
        $(document).ready(function () {
            try {
                $("#editiFrame", parent.document).attr('src', goPage);
                $("#EditTitle", parent.document).html(pTitle);
                //$("#hfInvokePageFrom", parent.document).val("LTOHRStaffs/PublishedList2.aspx");
                $("#EditDIV", parent.document).css({
                    top: vTop,
                    left: vLeft,
                    height: vHeight,
                    width: vWidth
                })
                //   PopUpDIV2();
                $("#PopUpDIV", parent.document).fadeToggle("fast");
                $("#EditDIV", parent.document).fadeToggle("fast");
                $("#ActionMenuDIV").fadeToggle("fast");
            }

            catch (e) { }

        });
    }
    //function openEditPage2(vHeight, vWidth, goPage, pTitle) {
    //    var vLeft = 5;
    //    var vTop = 5;
    //    goPage = goPage + "&yID=" + schoolyear + "&cID=" + schoolcode + "&tID=" + employeeid + "&phase=" + phase + "&tName=" + teachername;
    //    $(document).ready(function () {
    //        try {
    //            $("#editiFrame", parent.document).attr('src', goPage);
    //            $("#EditTitle", parent.document).html(pTitle);
    //            //$("#hfInvokePageFrom", parent.document).val("LTOHRStaffs/PublishedList2.aspx");
    //            $("#EditDIV", parent.document).css({
    //                top: vTop,
    //                left: vLeft,
    //                height: vHeight,
    //                width: vWidth
    //            })
    //            $("#editiFrame", parent.document).css({
    //                top: vTop,
    //                left: vLeft,
    //                height: vHeight - 10,
    //                width: vWidth - 5
    //            })

    //            //   PopUpDIV2();
    //            $("#PopUpDIV", parent.document).fadeToggle("fast");
    //            $("#EditDIV", parent.document).fadeToggle("fast");

    //        }

    //        catch (e) { }

    //    });
    //}

    function openEditPage2(vHeight, vWidth, goPage, pTitle) {
        var vLeft = 1;
        var vTop = 1;
        goPage = goPage + "&yID=" + schoolyear + "&cID=" + schoolcode + "&tID=" + employeeid + "&phase=" + phase + "&tName=" + teachername + "&type=" + category;
        $(document).ready(function () {
            try {
                $("#appriFrame", parent.document).attr('src', goPage);
                $("#EditTitle", parent.document).html(pTitle);
                //$("#hfInvokePageFrom", parent.document).val("LTOHRStaffs/PublishedList2.aspx");
                $("#ApprDIV", parent.document).css({
                    top: vTop,
                    left: vLeft,
                    height: vHeight,
                    width: vWidth
                })
                $("#appriFrame", parent.document).css({
                    top: vTop,
                    left: vLeft,
                    height: vHeight - 2,
                    width: vWidth - 2
                })

                //   PopUpDIV2();
                $("#PopUpDIV", parent.document).fadeToggle("fast");
                $("#ApprDIV", parent.document).fadeToggle("fast");

            }

            catch (e) { }

        });
    }

 * 
 * 
 */