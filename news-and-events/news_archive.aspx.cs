using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;

public partial class news_archive : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["d"] != null) {
            DateTime d = new DateTime();
            if (DateTime.TryParse(Request.QueryString["d"].ToString(), out d)) {
                ltrSubHeader.Text = "News - " + string.Format("{0:MMMM}", d) + " " + d.Year.ToString();
                dataNews.SelectParameters["month"].DefaultValue = d.Month.ToString();
                dataNews.SelectParameters["year"].DefaultValue = d.Year.ToString();
                lvNews.DataBind();

				Page.Title = string.Format("{0:MMMM}", d) + " " + d.Year.ToString() + " - News and Events" + ConfigurationSettings.AppSettings["gsDefaultPageTitle"];

            } else {
                Response.Redirect("/news-and-events/news_updates.aspx");
            }
        } else {
            Response.Redirect("/news-and-events/news_updates.aspx");
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
        NewsPager.Visible = (e.AffectedRows > 5);
    }
}