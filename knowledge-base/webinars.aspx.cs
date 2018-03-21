using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;
using System.Text.RegularExpressions;

public partial class knowledge_base_webinars : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    	((Inside)Master).AllowShareThisIcon=true;
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string output = "";
			string video = "";
			
			string SQL = "SELECT * FROM cpWebinar ORDER BY created_date DESC";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
                    while(dr.Read()) {
						
						video = dr["url"].ToString().Trim().Replace("https:", "");
						video = video.Replace("http:", "");
						video = video.Replace("watch?v=", "embed/");
						string pageURL = dr["title"].ToString().Trim().ToLower().Replace(" ", "-");
						Regex re = new Regex("[;\\\\/:*?\",<>|&']");
						pageURL = re.Replace(pageURL, "-");
						pageURL = pageURL.Replace("---","-");
						pageURL = pageURL.Replace("--","-");
						string noHTML = Regex.Replace(dr["abstract"].ToString(), @"<[^>]+>|&nbsp;", "").Trim();
						string noHTMLNormalised = Regex.Replace(noHTML, @"\s{2,}", " ");
							
						output += "<div id='col3_content'>" +
										"<div class='webinar-container'>" +
											"<div class='vid'>" +
												"<iframe allowfullscreen='' frameborder='0' height='184' src='" + video + "' width='329'></iframe>" +
											"</div>" +
											"<div class='meta'>" +
												"<span>" + dr["title"].ToString().Trim( ) + "</span><br /> <br />" +
												"<p class='desc-content'>" + noHTMLNormalised + "</p>" +
												"<ul class='watch-link'>" +
													"<li style='display:none'><a href='#'>Share &nbsp;<img src='/images/share.png'></a></li>" +
													"<li><a href='/webinar/" + pageURL + "'>Watch Video >></a></li>" +
												"</ul>" +
											"</div>" +
										"</div>" +
										"<div style='clear:both'></div>" +
									"</div>";
					}
					//ltrContent.Text = output;
                }
                cmd.Connection.Close();
            }
			
			string archive = "";
			
			SQL = "SELECT dateadd(month, datediff(month, 0, created_date),0) AS archivemonth, COUNT(*) AS archivemonthcount FROM cpWebinar WHERE YEAR(created_date) = " + DateTime.Now.Year + " GROUP BY dateadd(month, datediff(month, 0, created_date),0) ORDER BY dateadd(month, datediff(month, 0, created_date),0) DESC";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
                    while(dr.Read()) {
						archive += "<li><a href='/knowledge-base/webinar_archives.aspx?my=" + string.Format("{0:d}", dr["archivemonth"]) + "'>" + string.Format("{0:MMMM yyyy}", dr["archivemonth"]) + " (" + dr["archivemonthcount"].ToString().Trim() + ")</a></li>";
					}
                }
                cmd.Connection.Close();
            }
			ltrArchive.Text = archive;
			
			string oldArchive = "";
			
			SQL = "SELECT dateadd(year, datediff(year, 0, created_date),0) AS archivemonth, COUNT(*) AS archivemonthcount FROM cpWebinar WHERE YEAR(created_date) != " + DateTime.Now.Year + " GROUP BY dateadd(year, datediff(year, 0, created_date),0) ORDER BY dateadd(year, datediff(year, 0, created_date),0) DESC";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
                    while(dr.Read()) {
						oldArchive += "<li><a href='/knowledge-base/webinar_archives.aspx?y=" + string.Format("{0:yyyy}", dr["archivemonth"]) + "'>" + string.Format("{0:yyyy}", dr["archivemonth"]) + " (" + dr["archivemonthcount"].ToString().Trim() + ")</a></li>";
					}
                }
                cmd.Connection.Close();
            }
			ltrOldArchive.Text = oldArchive;
		
		}
        ltrHeadline.Text = "Webinars";
    }
	
	protected string getVidEmbed(string vidURL) {
		string video = "";
		video = vidURL.Trim().Replace("https:", "");
		video = video.Replace("http:", "");
		video = video.Replace("watch?v=", "embed/");
		return video;
	}
	
	protected string getPageURL(string title) {
		string pageURL = "";
		pageURL = title.Trim().ToLower().Replace(" ", "-");
		Regex re = new Regex("[;\\\\/:*?\",<>|&']");
		pageURL = re.Replace(pageURL, "-");
		pageURL = pageURL.Replace("---","-");
		pageURL = pageURL.Replace("--","-");
		return pageURL;
	}
	
	protected string getNormalised(string desc) {
		string noHTML = "";
		string noHTMLNormalised = "";
		noHTML = Regex.Replace(desc, @"<[^>]+>|&nbsp;", "").Trim();
		noHTMLNormalised = Regex.Replace(noHTML, @"\s{2,}", " ");
		return noHTMLNormalised;
	}
}