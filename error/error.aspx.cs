using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class error : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		Response.TrySkipIisCustomErrors = true;
		Server.ClearError();
		Response.Status = "404 not found";
		Response.StatusCode = 404;
    }
}