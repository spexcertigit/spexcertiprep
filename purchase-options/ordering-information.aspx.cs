using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;

public partial class purchase_ordering : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    	((Inside)Master).AllowShareThisIcon=true;
        clsContent myContent = new clsContent(8);

        Page.Title = "Ordering Information - Purchasing Options" + ConfigurationSettings.AppSettings["gsDefaultPageTitle"];
        ltrHeadline.Text = myContent.PageHeader;;
        ltrBody.Text = myContent.Contents;
        ltrSubHeader.Text = myContent.SubHeader;
    }
}