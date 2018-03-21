using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class about_directions : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

		Page.Title = "Directions - About Us" + ConfigurationSettings.AppSettings["gsDefaultPageTitle"];
    }
}