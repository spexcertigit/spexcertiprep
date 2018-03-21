using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Services;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;
using System.Net.Mail;
using System.Text.RegularExpressions;

public partial class knowledge_base_webinars : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e) {
	((Inside)Master).AllowShareThisIcon=true;
		List<String> vidnames = new List<String>(); 
		string[] compare;
		string[] stringSeparators = new string[] {"::"};
		string output = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT id, title FROM cpWebinar";			
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
                    while(dr.Read()) {
						string vidName = dr["title"].ToString().Trim().ToLower().Replace(" ", "-");
						Regex re = new Regex("[;\\\\/:*?\",<>|&']");
						vidName = re.Replace(vidName, "-");
						vidName = vidName.Replace("---","-");
						vidName = vidName.Replace("--","-");
						vidnames.Add(dr["id"].ToString() + "::" + vidName);
					}
                }
                cmd.Connection.Close();
            }
			foreach (string videoName in vidnames) {
				compare = videoName.Split(stringSeparators, StringSplitOptions.RemoveEmptyEntries);
				if (compare[1] == Page.RouteData.Values["webinar"].ToString()) {
					output = compare[0];
				}
			}
		}
		if (output == null) {
            Response.Redirect("/knowledge-base/webinars.aspx");
        } else {
			using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			
				string video = "";
				string vidID = output;
										
				string SQL = "SELECT * FROM cpWebinar WHERE id = " + vidID;
				 using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
					cmd.CommandType = CommandType.Text;
					cmd.Connection.Open();
					SqlDataReader dr = cmd.ExecuteReader();
					if (dr.HasRows) {
						dr.Read();
						video = dr["url"].ToString().Trim().Replace("https:", "");
						video = video.Replace("http:", "");
						video = video.Replace("watch?v=", "embed/");
				
						ltrTitle.Text = dr["title"].ToString().Trim();
						ltrVideo.Text = "<iframe allowfullscreen='' frameborder='0' height='390' src='" + video + "' width='100%'></iframe>";
						
						if (dr["abstract"].ToString().Trim() != "") {
							ltrAbstract.Text = "<h2 class='subtitle'>Abstract</h2>" + dr["abstract"].ToString().Trim();
						}
						
						if (dr["description"].ToString().Trim() != "") {
							ltrDesc.Text = "<h2 class='subtitle'>Transcription</h2>" + dr["description"].ToString().Trim();
						}
						
						
						Page.Header.Title = "Webinar | " + dr["title"].ToString().Trim() + " | SPEX CertiPrep";
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
		}
    }
	
}