using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;

public partial class thank_you : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		HttpContext.Current.Response.Clear();
		HttpContext.Current.Response.ClearHeaders();
		HttpContext.Current.Response.ClearContent();
		HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=pdf-sample.pdf"); 
		HttpContext.Current.Response.ContentType = "Application/pdf"; 
		HttpContext.Current.Response.Flush();
		HttpContext.Current.Response.TransmitFile(HttpContext.Current.Server.MapPath("/uploads/pdf-sample.pdf")); 
		HttpContext.Current.Response.End(); 
		HttpContext.Current.Response.Clear();
    }
}