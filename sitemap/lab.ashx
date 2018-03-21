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
            string SQL = "SELECT cp.cpPart AS PartNumber FROM  cp_roi_Prods cp WHERE cp.cpType = 6 AND cp.For_Web = 'Y' ORDER BY cp.cpPart";

            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;

                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read()) {
                    sitemap.AddLocation("http://www.spexcertiprep.com/products/product_labstuff.aspx?part=" + dr["partnumber"].ToString(), DateTime.Today, "0.5", ChangeFrequency.Monthly);
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