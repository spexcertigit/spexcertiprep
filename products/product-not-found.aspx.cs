using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class products_product_not_found : System.Web.UI.Page
{

    public string searchTerm = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["part"] == null || Request.QueryString["part"].ToString().Length == 0) { 
            searchTerm = " "; 
        }
        else
        {
            searchTerm = Request.QueryString["part"].ToString();
        }

        ltrlSearchTerm.Text = searchTerm;
    }
}