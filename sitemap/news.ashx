<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using SitemapLib;

public class Handler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) 
    {
        SitemapLib.Sitemap sitemap = new SitemapLib.Sitemap();

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT id FROM news WHERE category IN ('1','2','3') AND active = '1' ORDER BY posteddate DESC";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;

                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                Random random = new Random();
                while (dr.Read()) {
                    int priority = random.Next(3, 9);
                    sitemap.AddLocation("http://www.spexcertiprep.com/news-and-events/news.aspx?id=" + dr["id"].ToString(), DateTime.Today, "0.5", ChangeFrequency.Monthly);
                }
            }
        }
        
        context.Response.ContentType = "text/xml";
        context.Response.Write(sitemap.GenerateSitemapXML());
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
}