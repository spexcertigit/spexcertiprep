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
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Security.Cryptography;

public partial class forgotpassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
	public static string getMd5Hash(string input)
    {
        MD5CryptoServiceProvider md5Hasher = new MD5CryptoServiceProvider();

        byte[] data = md5Hasher.ComputeHash(Encoding.Default.GetBytes(input));

        StringBuilder sBuilder = new StringBuilder();

        for (int i = 0; i < data.Length; i++)
        {
            sBuilder.Append(data[i].ToString("x2"));
        }
        return sBuilder.ToString();
    }
	
    protected void cmdSubmit_Click(object sender, EventArgs e) {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
	        string FirstName = "";
	        string Web_user_id = "";
	        string Password = "";
	        string EmailAddress = "";
			string id = "";

            string SQL = "SELECT * FROM cp_roi_CONTACT_MASTER where Web_User_ID = @email";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@email", SqlDbType.VarChar, 60).Value = email_username.Text.Trim();
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                if (dr.HasRows) {
                    dr.Read();
					id = dr["ID"].ToString();
	                FirstName = dr["First_Name"].ToString();
	                Web_user_id = dr["Web_user_id"].ToString();
	                Password = dr["Web_Pw_Sql"].ToString();
	                EmailAddress = dr["Email_Addr"].ToString();
                }
                cmd.Connection.Close();
            }
            if (Password.Length == 0) {
                //Try the UK table
                SQL = "SELECT * FROM uk_roi_CONTACT_MASTER where Web_User_ID = @email";
                using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("@email", SqlDbType.VarChar, 60).Value = email_username.Text.Trim();
                    cmd.Connection.Open();
                    SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
						id = dr["ID"].ToString();
	                    FirstName = dr["First_Name"].ToString();
	                    Web_user_id = dr["Web_user_id"].ToString();
	                    Password = dr["Web_Pw_Sql"].ToString();
	                    EmailAddress = dr["Email_Addr"].ToString();
                    }
                    cmd.Connection.Close();
                }
            }
            if (Password.Length == 0) {
                lblNotFound.Visible = true;
            } else {
                // send email to Spex telling them a new user has registered
				string hashed = getMd5Hash(Web_user_id);
				
				SQL = "UPDATE cp_roi_CONTACT_MASTER SET fplink = @hashed WHERE ID = @id";
				using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("@hashed", SqlDbType.NVarChar, 32).Value = hashed;
					cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
                    cmd.Connection.Open();
					cmd.ExecuteNonQuery();
					cmd.Connection.Close();
				}
				
                StringBuilder sb = new StringBuilder();
               				
				sb.AppendLine("<html><body>");
				sb.AppendLine("<div style='padding:30px 25px; border: 1px solid #b9b9b9;width:525px;'><a href='http://www.spexcertiprep.com/'><img src='http://www.spexcertiprep.com/images/certiprep_logo_new.png' alt='SPEX CertiPrep'></a>");
				sb.AppendLine("<table border='0' style='margin:0 auto;'>");
				sb.AppendLine("<tr><td style='width:450px;padding:20px;font-size:24px;text-align:center;font-weight:bold;padding-top:40px'>Reset Password</td></tr>");
				sb.AppendLine("<tr><td style='padding:20px;font-size:18px;text-align:center;'>If you’ve lost or forgotten your password and wish to reset it,<br /> simply click the button below to get started.</td></tr>");
				sb.AppendLine("<tr><td style='padding:30px;text-align:center;padding-bottom:50px;'><a href='https://www.spexcertiprep.com/password-reset/" + hashed + "' style='padding:15px;font-size:18px;color:#ffffff;background-color:#5cb85c;font-weight:bold;text-decoration:none;'>Reset My Password</a></td></tr>");
				sb.AppendLine("</table></div>");
				sb.AppendLine("</body></html>");
                string strBody = sb.ToString();

                MailMessage mm = new MailMessage();
                mm.Subject = "SPEX CertiPrep Reset Password";
                mm.To.Add(new MailAddress(EmailAddress));

                mm.From = new MailAddress("contact@spexcsp.com", "SPEX CertiPrep Contact");
                mm.BodyEncoding = System.Text.Encoding.GetEncoding("utf-8");

                AlternateView plainView = AlternateView.CreateAlternateViewFromString(Regex.Replace(strBody, @"<(.|\n)*?>", string.Empty), System.Text.Encoding.GetEncoding("utf-8"), "text/plain");
                AlternateView htmlView = AlternateView.CreateAlternateViewFromString(strBody, System.Text.Encoding.GetEncoding("utf-8"), "text/html");
                mm.AlternateViews.Add(plainView);
                mm.AlternateViews.Add(htmlView);

                SmtpClient smtp = new SmtpClient();
                smtp.Send(mm);

                mvForm.SetActiveView(vwThank);

            }
        }
    }
}