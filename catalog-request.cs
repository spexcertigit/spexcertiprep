using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;
using System.Net.Mail;
using System.Net;
using System.Web.Script.Serialization;
using System.Text.RegularExpressions;

public partial class knowledge_base_Presentations : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
			
    }
	protected void cmdSubmit_Click(object sender, EventArgs e) {
		int surID = 0;
					
			/*using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
				string SQL = "INSERT INTO cp_Surveyee" +
					"(FName, LName, Company, Address, City, State, ZipCode, Phone, EmailAdd, DateAnswered, Ratings) " +
					"VALUES (@FName, @LName, @Company, @Address, @City, @State, @ZipCode, @Phone, @EmailAdd, @DateAnswered, @Ratings)";
				using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
					DateTime dateNow = DateTime.Now;
					cmd.CommandType = CommandType.Text;
					cmd.Parameters.Add("@FName", SqlDbType.NVarChar, 150).Value = FName.Text.Trim();
					cmd.Parameters.Add("@LName", SqlDbType.NVarChar, 150).Value = LName.Text.Trim();
					cmd.Parameters.Add("@Company", SqlDbType.NVarChar, 150).Value = RCompany.Text.Trim();
					cmd.Parameters.Add("@Address", SqlDbType.Text).Value = Address1.Text.Trim();
					cmd.Parameters.Add("@City", SqlDbType.NVarChar, 100).Value = City.Text.Trim();
					cmd.Parameters.Add("@State", SqlDbType.NVarChar, 50).Value = State.Text.Trim();
					cmd.Parameters.Add("@ZipCode", SqlDbType.Int).Value = Zip.Text.Trim();
					cmd.Parameters.Add("@Phone", SqlDbType.NVarChar, 200).Value = Phone.Text.Trim();
					cmd.Parameters.Add("@EmailAdd", SqlDbType.NVarChar, 256).Value = REmail.Text.Trim();
					cmd.Parameters.Add("@DateAnswered", SqlDbType.DateTime).Value = dateNow;
					cmd.Parameters.Add("@Ratings", SqlDbType.Int).Value = RateScore.Value;

					cmd.Connection.Open();
					cmd.ExecuteNonQuery();
					cmd.Connection.Close();
				}
				
			}*/
			
			StringBuilder sb = new StringBuilder();
			sb.AppendLine("<html><body>");
			sb.AppendLine("Name: " + FName.Text.Trim() + " " + LName.Text.Trim() + "<br>");
			sb.AppendLine("Company name: " + RCompany.Text.Trim() + "<br>");
			sb.AppendLine("Email: " + REmail.Text.Trim() + "<br>");
			sb.AppendLine("Address: " + Address1.Text.Trim() + " " + Address2.Text.Trim() + ", " + City.Text.Trim() + ", " + State.SelectedItem.Text + " " + Zip.Text.Trim() + " " + Country.SelectedItem.Text + "<br>");
			string str = "";
			if (rblCopy.Items[0].Selected) {
				sb.AppendLine("Download: " + FName.Text.Trim() + " " + LName.Text.Trim() + " has downloaded the file.<br>");
			}
			if (rblCopy.Items[1].Selected) {
				str += (string)rblCopy.Items[1].Value;
				sb.AppendLine("Request: " + qty.SelectedItem.Value + " " + str + " <br>");
			}
			
			sb.AppendLine("</body></html>");
			string strBody = sb.ToString();

			MailMessage mm = new MailMessage();
			mm.Subject = "NEW SPEX CertiPrep Product Catalog Request";
			//mm.To.Add(new MailAddress("crmsales@spex.com"));
			mm.To.Add(new MailAddress("jbrady@spex.com"));
			//mm.CC.Add(new MailAddress("jbrady@spex.com"));
			//mm.CC.Add(new MailAddress("aevans@spex.com"));
			//mm.CC.Add(new MailAddress("DPetro@spex.com"));
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
			
			if (rblCopy.Items[0].Selected) {
				Response.Redirect("/catalog-request-thank-you.aspx?download=true");
			}else {
				Response.Redirect("/catalog-request-thank-you.aspx");
			}
	}
	
	
}

