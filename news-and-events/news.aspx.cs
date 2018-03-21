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
        if (Request.QueryString["id"] == null) {
            Response.Redirect("/news-and-events/news_updates.aspx");
        } else {
            int id = 0;
            if (Int32.TryParse(Request.QueryString["id"].ToString(), out id)) {
                if (id > 0) {
                    using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
                        string SQL = "SELECT news.title, news.body, news_uploads.filename " +
                                    "FROM news LEFT JOIN news_uploads ON news.id = news_uploads.related_article " +
                                    "WHERE news.id = @id";
                        using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                            cmd.CommandType = CommandType.Text;
                            cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
                            cmd.Connection.Open();
                            SqlDataReader dr = cmd.ExecuteReader();

                            if (dr.HasRows) {
                                dr.Read();
	  		                    string Headline = dr["title"].ToString();
			                    string NewsBody = dr["body"].ToString();
                                string TheFile = dr["filename"].ToString();

                                ltrHeadline.Text = ltrBreadcrumb.Text = Headline;
                                Page.Title = "SPEX CertiPrep - News & Events - " + Headline;

                                ltrBody.Text = NewsBody;
                                if (TheFile.Length > 0) {
                                    hlTheFile.Visible = true;
                                    hlTheFile.Text = TheFile;
                                    hlTheFile.NavigateUrl = "/uploads/" + TheFile;
                                } else {
                                    hlTheFile.Visible = false;
                                }
                            }
                        }
                    }
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
}