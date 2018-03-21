using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;

public partial class news_and_events_rss : System.Web.UI.Page
{
	protected void Page_Load(object sender, EventArgs e)
	{
		StringBuilder sb = new StringBuilder();
		string feedtitle = "Latest News from SPEX CertiPrep";
		sb.AppendLine("<?xml version='1.0' encoding='utf-8'?>");
		sb.AppendLine("<?xml-stylesheet type='text/xsl' href='/site/rss.xsl' media='screen'?>");
		sb.AppendLine("<rss version='2.0' xmlns:dc='http://purl.org/dc/elements/1.1/' xmlns:atom='http://www.w3.org/2005/Atom'>");
		sb.AppendLine("  <channel>");
		sb.AppendLine("    <title>" + feedtitle + "</title>");
		sb.AppendLine("    <link>http://www.spexcsp.com/news-and-events/</link>");
		sb.AppendLine("    <description>Inorganic and Organic Certified Reference Materials</description>");
		sb.AppendLine("    <language>en-us</language>");
		sb.AppendLine("    <atom:link href='" + Request.Url.OriginalString + "' rel='self' type='application/rss+xml' />");

		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT     id, 'news.aspx?guid=' + cast(NEWID() AS varchar(36)) AS ItemGUID, title  COLLATE DATABASE_DEFAULT AS title, 'news.aspx?id=' + cast(id AS varchar(5)) AS link, CAST(body AS varchar(max)) AS excerpt, 'news' AS [type], posteddate, posteddate AS ActionDate " +
							"FROM          news " +
							"WHERE     category IN ('1', '2', '3') " +
							"UNION " +
							//"SELECT     id, 'careers.aspx?guid=' + cast(NEWID() AS varchar(36)) AS ItemGUID, 'New Career Posting: ' + title, 'careers.aspx?id=' + cast(id AS varchar(5)) AS link, CAST(description AS varchar(max) )AS excerpt, 'jobs' AS [type], posteddate, posteddate AS ActionDate " +
							//"FROM          jobs " +
							//"WHERE     active = 1 " +
							//"UNION " +
							"SELECT     EventSerial AS id, 'tradeshow-calendar.aspx?guid=' + cast(EventGUID AS varchar(36)) AS ItemGUID, Headline AS title, 'tradeshow-calendar.aspx?id=' + cast(EventSerial AS varchar(5)) AS link, CAST(FullDescription AS varchar(max)) AS excerpt, 'event' AS [type], CreateDate AS posteddate, EventDate AS ActionDate " +
							"FROM          [cms_Event] " +
							"WHERE     [Site] = 'cp' AND IsActive = 1 " +
							"ORDER BY posteddate DESC";

			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				while (dr.Read()) {

					string NewsID = dr["id"].ToString();
					string NewsTitle = dr["title"].ToString();
					string NewsLink = dr["link"].ToString();
					string GUIDLink = dr["ItemGUID"].ToString();
					string PostedDate1 = dr["posteddate"].ToString().Replace("/", "-");
					string NewsType = dr["type"].ToString();
					string PostedDate = string.Format("{0:yyyy-MM-dd}", dr["posteddate"]) + "T" + string.Format("{0:HH:mm}", dr["posteddate"]) + "-05:00"; // PostedDate1 + "T10:00:00-05:00";
					string Folder = "";
					string Description = dr["excerpt"].ToString(); ;
					//string Body = 
					sb.AppendLine("<item>");

					if (NewsType.ToLower() == "jobs") {
						Folder = "about-us";
						//Description = "Job update from SPEX CertiPrep";
						sb.AppendLine("<title><![CDATA[" + NewsTitle + "]]></title>");
					} else if (NewsType.ToLower() == "event") {
						Folder = "news-and-events";
						Description = "<img src=\"http://www.spexcertiprep.com/uploads/images/Tradeshows.jpg\" alt=\"Trade Show Image\"/> <br />" + Description;
						sb.AppendLine("<title><![CDATA[" + NewsTitle + " (" + string.Format("{0:MMM dd, yyyy}", dr["ActionDate"]) + ") " + "]]></title>");
					} else {
						Folder = "news-and-events";
						Description = "<img src=\"http://www.spexcertiprep.com/images/page-photos/60th-Anniversary-Logo.jpg\" alt=\"News Image\"/> <br />" + Description;
						sb.AppendLine("<title><![CDATA[" + NewsTitle + "]]></title>");
					}

					sb.AppendLine("<link>http://" + Request.Url.Host + "/" + Folder + "/" + NewsLink + "</link>");
					sb.AppendLine("<guid>http://" + Request.Url.Host + "/" + Folder + "/" + GUIDLink + "</guid>");
					sb.AppendLine("<description><![CDATA[" + Description + "]]></description>");
					//sb.AppendLine("<body>" + Body + "</body>");
					sb.AppendLine("<dc:date>" + PostedDate + "</dc:date>");
					sb.AppendLine("</item>");
				}
				cmd.Connection.Close();
			}
		}
		sb.AppendLine("  </channel>");
		sb.AppendLine("</rss>");

		Response.ContentType="text/xml";
		Response.Write (sb.ToString());
	}
}