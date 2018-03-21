using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class about_corporate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        clsContent myContent = new clsContent(4);

        Page.Title = "Corporate Profile - About Us" + ConfigurationSettings.AppSettings["gsDefaultPageTitle"];
        ltrHeadline.Text = myContent.PageHeader;;
        ltrBody.Text = myContent.Contents;
        ltrSubHeader.Text = myContent.SubHeader;
    }
}