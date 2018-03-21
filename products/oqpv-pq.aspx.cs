using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class products_iq : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        clsContent myContent = new clsContent(10);

        Page.Title = "SPEX CertiPrep IQ - Products" + ConfigurationSettings.AppSettings["gsDefaultPageTitle"];
        ltrHeadline.Text = myContent.PageHeader;;
        ltrBody.Text = myContent.Contents;
        ltrSubHeader.Text = myContent.SubHeader;
    }
    protected void cmdSubmit_Click(object sender, EventArgs e) {
    }
}