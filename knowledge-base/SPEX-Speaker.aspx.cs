﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Configuration;
using System.Text;
using System.Net.Mail;
using System.Text.RegularExpressions;

public partial class knowledge_base_SPEX_Speaker : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Response.RedirectPermanent("spex-speaker"); 

        //clsContent myContent = new clsContent(18);
        //Page.Title = "SPEX Speaker - Knowledge Base" + ConfigurationSettings.AppSettings["gsDefaultPageTitle"];
        //ltrHeadline.Text = myContent.PageHeader; ;
        //ltrBody.Text = myContent.Contents;
        //ltrSubHeader.Text = myContent.SubHeader;
    }
	protected void cmdSubmit_Click(object sender, EventArgs e) {
		string fullAdd = "";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "INSERT INTO cp_spexspeaker_request" +
                "(fname, company, email, address, requestdate) " +
                "VALUES (@fname,  @company, @email, @address, @currdate)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				DateTime dateNow = DateTime.Now;
				fullAdd = address.Text.Trim() + ", " + city.Text.Trim() + ", " + state_region.Text.Trim() + ", " + zip.Text.Trim() + ", " + Country.SelectedItem.Text;
				
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@fname", SqlDbType.NVarChar, 50).Value = fullname.Text.Trim();
				cmd.Parameters.Add("@company", SqlDbType.NVarChar, 100).Value = Company.Text.Trim();
				cmd.Parameters.Add("@email", SqlDbType.NVarChar, 100).Value = email_check.Text.Trim();
				cmd.Parameters.Add("@address", SqlDbType.Text).Value = fullAdd;
				cmd.Parameters.Add("@currdate", SqlDbType.DateTime).Value = dateNow;

                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
        }
		
        StringBuilder sb = new StringBuilder();
		sb.AppendLine("<html><body>");
		sb.AppendLine("<div style='padding:30px 25px; border: 1px solid #b9b9b9;width:525px;'><a href='http://www.spexcertiprep.com/'><img src='http://www.spexcertiprep.com/images/certiprep_logo_new.png' alt='SPEX CertiPrep'></a>");
		sb.AppendLine("<table border='0'>");
        sb.AppendLine("<tr><td style='width:135px;padding:10px'>Contact name:</td><td style='font-weight:bold;padding:10px'>" + fullname.Text.Trim()  + "</td></tr>");
        sb.AppendLine("<tr><td style='padding:10px'>Company name:</td><td style='font-weight:bold;padding:10px'>" + Company.Text.Trim() + "</td></tr>");
        sb.AppendLine("<tr><td style='padding:10px'>Address:</td><td style='font-weight:bold;padding:10px'>" + fullAdd + "</td></tr>");
        sb.AppendLine("<tr><td style='padding:10px'>Email:</td><td style='font-weight:bold;padding:10px'>" + email_check.Text.Trim() + "</td></tr>");
		sb.AppendLine("</table></div>");
        sb.AppendLine("</body></html>");
        string strBody = sb.ToString();

        MailMessage mm = new MailMessage();
        mm.Subject = "Request a Physical Copy of SPEX Speaker Issue";
        mm.To.Add(new MailAddress("crmsales@spex.com"));
		mm.To.Add(new MailAddress("AEvans@spex.com"));
		mm.Bcc.Add(new MailAddress("spexcertiprepmarcom@gmail.com"));

        mm.From = new MailAddress("contact@spexcsp.com", "SPEX CertiPrep Contact");
        mm.BodyEncoding = System.Text.Encoding.GetEncoding("utf-8");

        AlternateView plainView = AlternateView.CreateAlternateViewFromString(Regex.Replace(strBody, @"<(.|\n)*?>", string.Empty), System.Text.Encoding.GetEncoding("utf-8"), "text/plain");
        AlternateView htmlView = AlternateView.CreateAlternateViewFromString(strBody, System.Text.Encoding.GetEncoding("utf-8"), "text/html");
        mm.AlternateViews.Add(plainView);
        mm.AlternateViews.Add(htmlView);

        SmtpClient smtp = new SmtpClient();
        smtp.Send(mm);
		Session["thankyou-redirect"] = HttpContext.Current.Request.Url.AbsolutePath;
		Response.Redirect("spex-speaker-thankyou.aspx");
	}
	
	public string get2Issues() {
		string output = "";
		string issue = "Current";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT TOP 2 * FROM cp_speaker ORDER BY id DESC";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				while(dr.Read()) {
				output += 	"<div id='speaker_2_portion'>" +
								"<div id='speaker_issue_div'>" +
									"<img src='/images/" + dr["thumbnail"].ToString() + "' />" +
								"</div>" +
								"<div id='speaker_evol_div'>" +
									"<h2 class='speaker_title'>" + issue+ " Issue:</h2>" +
									"<p class='speaker_subtitle'>" + dr["title"].ToString() + "</p>" +
									"<p style='margin-bottom:8px'>Abstract:</p>" +
									"<p>" + dr["abstract"].ToString() + "</p>" +
									"<a class='speakerLinks'  href='" + dr["filePDF"].ToString() + "' target='_blank'>Download the " + dr["fileTitle"].ToString() + "</a>" +
								"</div>" +
								"<div style='clear: both'></div>" +
							"</div>";
						issue = "Previous";
                    }
				cmd.Connection.Close();
			}
        }
		
		return output;
	}
	
	public string getLatestIssue() {
		string output = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT * FROM cp_speaker ORDER BY id DESC";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				if (dr.HasRows) {
					dr.Read();
					output = dr["filePDF"].ToString();
				}
			}
        }
		
		return output;
	}
}