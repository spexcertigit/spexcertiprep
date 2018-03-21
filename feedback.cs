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
					
			using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
				string SQL = "INSERT INTO cp_Surveyee" +
					"(FName, LName, Company, Address, City, State, ZipCode, Phone, EmailAdd, DateAnswered, Ratings) " +
					"VALUES (@FName, @LName, @Company, @Address, @City, @State, @ZipCode, @Phone, @EmailAdd, @DateAnswered, @Ratings)";
				using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
					DateTime dateNow = DateTime.Now;
					cmd.CommandType = CommandType.Text;
					cmd.Parameters.Add("@FName", SqlDbType.NVarChar, 150).Value = FName.Text.Trim();
					cmd.Parameters.Add("@LName", SqlDbType.NVarChar, 150).Value = LName.Text.Trim();
					cmd.Parameters.Add("@Company", SqlDbType.NVarChar, 150).Value = RCompany.Text.Trim();
					cmd.Parameters.Add("@Address", SqlDbType.Text).Value = Address.Text.Trim();
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
				
				SQL = "SELECT TOP 1 id FROM cp_Surveyee ORDER BY id DESC";
				using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
					cmd.CommandType = CommandType.Text;
					cmd.Connection.Open();
					SqlDataReader dr = cmd.ExecuteReader();
					if (dr.HasRows) {
						dr.Read();
						surID = Convert.ToInt32(dr["id"]);
						saveAnswers(surID, "1", txtProductType.SelectedItem.Text.Trim(), "");
						saveAnswers(surID, "2", rblQue2.SelectedItem.Value, Que2.Text.Trim());
						saveAnswers(surID, "3", rblQue3.SelectedItem.Value, Que3.Text.Trim());
						saveAnswers(surID, "4", "", Que4.Text.Trim());
						saveAnswers(surID, "4a", rblQue4Ans1.SelectedItem.Value, "");
						saveAnswers(surID, "4b", rblQue4Ans2.SelectedItem.Value, "");
						saveAnswers(surID, "4c", rblQue4Ans3.SelectedItem.Value, "");
						saveAnswers(surID, "4d", rblQue4Ans4.SelectedItem.Value, "");
						saveAnswers(surID, "4e", rblQue4Ans5.SelectedItem.Value, "");
						saveAnswers(surID, "5", "", Que5.Text.Trim());
						saveAnswers(surID, "5a", rblQue5Ans1.SelectedItem.Value, "");
						saveAnswers(surID, "5b", rblQue5Ans2.SelectedItem.Value, "");
						saveAnswers(surID, "5c", rblQue5Ans3.SelectedItem.Value, "");
						saveAnswers(surID, "5d", rblQue5Ans4.SelectedItem.Value, "");
						saveAnswers(surID, "5e", rblQue5Ans5.SelectedItem.Value, "");
						saveAnswers(surID, "5f", rblQue5Ans6.SelectedItem.Value, "");
						saveAnswers(surID, "6", rblQue6.SelectedItem.Value, "");
						saveAnswers(surID, "7", rblQue7.SelectedItem.Value, "");
						saveAnswers(surID, "8", rblQue8.SelectedItem.Value, "");
						saveAnswers(surID, "9", Que9.Text.Trim(), "");
					}
					cmd.Connection.Close();
				}
			}
			
			int ranks = getRanks();
			
			StringBuilder sb = new StringBuilder();
			sb.AppendLine("<html><body>");
			sb.AppendLine("Name: " + FName.Text.Trim() + " " + LName.Text.Trim() + "<br>");
			sb.AppendLine("Company name: " + RCompany.Text.Trim() + "<br>");
			sb.AppendLine("Email: " + REmail.Text.Trim() + "<br>");
			sb.AppendLine("Rate: " + RateScore.Value + "<br>");
			sb.AppendLine("Rankings: " + ranks + "<br>");
			
			sb.AppendLine("</body></html>");
			string strBody = sb.ToString();

			MailMessage mm = new MailMessage();
			mm.Subject = "A Survey has been completed!";
			
			mm.To.Add(new MailAddress("crmsales@spex.com"));
			mm.CC.Add(new MailAddress("jbrady@spex.com"));
			mm.CC.Add(new MailAddress("aevans@spex.com"));
			mm.CC.Add(new MailAddress("DPetro@spex.com"));
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
			Response.Redirect("/feedback-thank-you.aspx");
	}
	
	public static void saveAnswers(int surID, string queNum, string queAns, string queCom) {
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = 	"INSERT INTO cp_Survey(surveyeeID, QuestionNumber, QuestionAnswer, QuestionComment) " +
							"VALUES (@surID, @queNum, @queAns, @queCom)";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@surID", SqlDbType.Int).Value = surID;
				cmd.Parameters.Add("@queNum", SqlDbType.NVarChar, 20).Value = queNum;
				cmd.Parameters.Add("@queAns", SqlDbType.Text).Value = queAns;
				cmd.Parameters.Add("@queCom", SqlDbType.Text).Value = queCom;

				cmd.Connection.Open();
				cmd.ExecuteNonQuery();
				cmd.Connection.Close();
			}
		}
	}
	
	public int getRanks() {
		int total = 0;
		total += getScore(rblQue2.SelectedItem.Value) + getScore(rblQue3.SelectedItem.Value) + getScore(rblQue4Ans1.SelectedItem.Value) + getScore(rblQue4Ans2.SelectedItem.Value) + getScore(rblQue4Ans3.SelectedItem.Value) + getScore(rblQue4Ans4.SelectedItem.Value) + getScore(rblQue4Ans5.SelectedItem.Value) + getScore(rblQue5Ans1.SelectedItem.Value) + getScore(rblQue5Ans2.SelectedItem.Value) + getScore(rblQue5Ans3.SelectedItem.Value) + getScore(rblQue5Ans4.SelectedItem.Value) + getScore(rblQue5Ans5.SelectedItem.Value) + getScore(rblQue5Ans6.SelectedItem.Value);
		
		return total;
	}
	public int getScore(string ans) {
		int score = 0;
		if (ans == "Very Satisfied") {
			score = 5;
		}else if (ans == "Satisfied") {
			score = 4;
		}else if (ans == "Neither satisfied nor dissatisfied") {	
			score = 3;
		}else if (ans == "Dissatisfied") {
			score = 2;
		}else if (ans == "Very dissatisfied") {
			score = 1;
		}else if (ans == "Definitely") {
			score = 5;
		}else if (ans == "Probably") {
			score = 4;
		}else if (ans == "Might or might not") {	
			score = 3;
		}else if (ans == "Probably Not") {
			score = 2;
		}else if (ans == "Definitely not") {
			score = 1;
		}
		return score;
	}
}

