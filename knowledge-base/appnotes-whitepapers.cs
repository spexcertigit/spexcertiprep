using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;


public partial class knowledge_base_appnotes_whitepapers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.RedirectPermanent("appnotes-whitepapers"); 
           
           
        //   clsContent myContent = new clsContent(17);


        //Page.Title = "Application Notes & White Papers - Knowledge Base" + ConfigurationSettings.AppSettings["gsDefaultPageTitle"];
        //ltrHeadline.Text = myContent.PageHeader; ;
        //ltrBody.Text = myContent.Contents;
        //ltrSubHeader.Text = myContent.SubHeader;

    }
}