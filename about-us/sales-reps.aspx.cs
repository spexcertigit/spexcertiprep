using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class about_reps : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        clsUser myUser = new clsUser();

        clsContent myContent = new clsContent(6);

        Page.Title = "Sales Reps - About Us" + ConfigurationSettings.AppSettings["gsDefaultPageTitle"];
        ltrHeadline.Text = myContent.PageHeader;;
        ltrBody.Text = myContent.Contents;
        //ltrSubHeader.Text = myContent.SubHeader;




        if (myUser.Region == "UK" || myUser.Region == "OT") {
            // switch panels 1 and 2
            Panel P1 = pnlContent.FindControl("pnlUSMap") as Panel;
            Panel P2 = pnlContent.FindControl("pnlUK") as Panel;


            pnlContent.Controls.Remove(P1);


            int Index = pnlContent.Controls.IndexOf(P2);


            pnlContent.Controls.AddAt(Index + 1, P1);

        }



    }
}