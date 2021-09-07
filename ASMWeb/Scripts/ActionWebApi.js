﻿var Url = "https://webt.tcdsb.org/Webapi/ASM/api/";
 
async function GetDataWebAPICall(uri, id) {
    var myUrl = Url + uri + "/" + id;
    // var JSONStr = JSON.stringify(paraObj);

    try {
            (async () => {
                const apiResponse = await fetch(myUrl);
                const result = await apiResponse.json();
                return result;
        })();

    }
    catch (ex) {
        alert(ex.message);
    }

    ////try {
    ////    alert(myUrl)
    ////    (async () => {
    ////        const apiResponse = await fetch(myUrl, {
    ////            method: 'GET',
    ////            headers: {
    ////                'Accept': 'application/json',
    ////                'Content-Type': 'application/json;charset=utf-8'
    ////            }
    ////        });
    ////        const result = await apiResponse.json();
    ////        console.log(result)
             
    ////        return result;
    ////    })();
    ////}
    ////catch (ex) {
    ////    alert(ex.message);
    ////}
}

function DeleteDataWebAPICall(uri, id,refreshPage) {
    var myUrl = Url + uri + "/" + id;
    // var JSONStr = JSON.stringify(paraObj);
    try {

        (async () => {
            const apiResponse = await fetch(myUrl, {
                method: 'DELETE',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                }
            });
            const result = await apiResponse.json();
            //.then(response => response.json())
            //   .then(data => console.log(data));

            alert(result);
            if (refreshPage == "Parent") { parent.location.reload(); }
            else { location.reload();}
        })();
    }
    catch (ex) {
        alert(ex.message);
    }
}

function SaveDataWebAPICall(verb, uri, paraObj, refreshPage) {
    var myUrl = Url + uri;
    var JSONStr = JSON.stringify(paraObj);
     try {
        (async () => {
            const apiResponse = await fetch(myUrl, {
                method: verb,
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                body: JSONStr
            });
            const result = await apiResponse.json();
            //.then(response => response.json())
            //   .then(data => console.log(data));
            alert(result);

            if (refreshPage == "Parent") { parent.location.reload(); }
            else { location.reload(); }

        })();

        //var myJSON = JSON.stringify(para);
        //var myObj = JSON.parse(myJSON);
        //var result = SIC.Models.WebService.PushGroupToAnotherApp('Push', para, onSuccess, onFailure);
    }
    catch (ex) {
        alert(ex.message);
    }
}

