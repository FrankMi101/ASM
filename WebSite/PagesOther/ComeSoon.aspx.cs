using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASM.PagesOther
{
    public partial class ComeSoon : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string pageName = Page.Request.QueryString["pID"].ToString();
            pageName = pageName.Replace(".aspx", "");
           // FunctionName.Value = pageName;
            Label1.Text = pageName;
        }
    }
}