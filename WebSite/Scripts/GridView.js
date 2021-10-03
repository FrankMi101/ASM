function MakeStaticHeader(gridId, height, width, headerHeight, isFooter) {
    var tbl = document.getElementById(gridId);
    if (tbl) {
        var DivHR = document.getElementById('DivHeaderRow');
        var DivHeader = document.getElementById('GridView2');
        var DivMC = document.getElementById('DivMainContent');
       

        //*** Set divheaderRow Properties ****
        DivHR.style.height = headerHeight +5   + 'px';
        DivHR.style.width = '99%'; // (parseInt(width) - 16) + 'px';
        DivHR.style.position = 'relative';
        DivHR.style.top = '0px';
        DivHR.style.zIndex = '10';
        DivHR.style.verticalAlign = 'top';

        //*** Set divMainContent Properties ****
        DivMC.style.width = '100%'; // width + 'px';
        DivMC.style.height =   height + 'px';
        DivMC.style.position = 'relative';
        DivMC.style.marginTop = -5 + 'px';  
        DivMC.style.top = - headerHeight + 'px';
        DivMC.style.zIndex = '1';


        //*** Set divFooterRow Properties ****
        //DivFR.style.width = (parseInt(width) - 16) + 'px';
        //DivFR.style.position = 'relative';
        //DivFR.style.top = -headerHeight + 'px';
        //DivFR.style.verticalAlign = 'top';
        //DivFR.style.paddingtop = '2px';

        //if (isFooter) {
        //    var tblfr = tbl.cloneNode(true);
        //    tblfr.removeChild(tblfr.getElementsByTagName('tbody')[0]);
        //    var tblBody = document.createElement('tbody');
        //    tblfr.style.width = '100%';
        //    tblfr.cellSpacing = "0";
        //    tblfr.border = "0px";
        //    tblfr.rules = "none";
        //    //*****In the case of Footer Row *******
        //    tblBody.appendChild(tbl.rows[tbl.rows.length - 1]);
        //    tblfr.appendChild(tblBody);
        //    DivFR.appendChild(tblfr);
        //}
        //****Copy Header in divHeaderRow****
        //   DivHR.appendChild(tbl.cloneNode(true));

        //  DivHR.appendChild(tableH );
        DivHeader.appendChild(tbl.rows['0'].cloneNode(true));
        DivHeader.appendChild(tbl.rows['1'].cloneNode(true));
        //   DivHR.appendChild("</table>"  );
        //   div.insertAdjacentHTML('beforeend', str);

        //   addGridViewHeader();
    }
}

function addGridViewHeader() {
    var index = 0;


    $('#GridView1 > tbody  > tr:not(:first)').each(function () {
        var t1 = $(this).text();
        $(this).find('td').each(function (i, el) {
            var myHeaderStyle = this.style.cssText;
            window.alert(myHeaderStyle);
        });
        return false;
    });
}

function OnScrollDiv(Scrollablediv) {
    document.getElementById('DivHeaderRow').scrollLeft = Scrollablediv.scrollLeft;
}

