using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;

public partial class news_news : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //int NumberToDisplay = 5;
        //int Offset = 1;

        //if (Request.QueryString["start"] != null) {
        //    Int32.TryParse(Request.QueryString["start"].ToString(), out Offset);
        //    if (Offset == 0) { Offset = 1; }
        //}
        //string SQL = "";
        //string SQL2 = "";
        if (Request.QueryString["category"] == null) {
            ltrSubHeader.Text = "News";
            lvNews.DataSource = dataNews;
            lvNews.DataBind();
        } else {
            int cat = 0;
            if (Int32.TryParse(Request.QueryString["category"].ToString(), out cat)) {
                if (cat > 0) {
                    ltrSubHeader.Text = "News - " + TranslateCategory(cat.ToString());
                    lvNews.DataSource = dataNewsbyCat;
                    lvNews.DataBind();

					Page.Title = TranslateCategory(cat.ToString()) + " - News and Events" + ConfigurationSettings.AppSettings["gsDefaultPageTitle"];

                } else {
                    Response.Redirect("/news-and-events/news_updates.aspx");
                }
            } else {
                Response.Redirect("/news-and-events/news_updates.aspx");
            }
        }            
    }
    protected string TranslateCategory(string cat) {
        switch (cat) {
            case "1":
                return "CertiPrep General Updates"; 
            case "2":
                return "CertiPrep Newsletters"; 
            case "3":
                return"CertiPrep Press Releases"; 
            case "4":
                return"SamplePrep General Updates"; 
            case "5":
                return "SamplePrep Newsletters"; 
            default:
                return "SamplePrep Press Releases"; 
        }
    }
    protected void dataNews_Selected(object sender, SqlDataSourceStatusEventArgs e) {
        ProductListPagerSimple.Visible = (e.AffectedRows > 5 && Request.QueryString["category"] == null);
    }
    protected void dataNewsbyCat_Selected(object sender, SqlDataSourceStatusEventArgs e) {
        ProductListPagerSimple.Visible = (e.AffectedRows > 5 && Request.QueryString["category"] != null);
    }
}