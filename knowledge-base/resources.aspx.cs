using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;

public partial class knowledge_resources : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.RedirectPermanent("resources"); 

        //clsContent myContent = new clsContent(3);

        //Page.Title = "Resources - Knowledge Base" + ConfigurationSettings.AppSettings["gsDefaultPageTitle"];
        //ltrHeadline.Text = myContent.PageHeader;;
        //ltrBody.Text = myContent.Contents;
        //ltrSubHeader.Text = myContent.SubHeader;
    }
}