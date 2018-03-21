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
using System.Text.RegularExpressions;

public partial class about_contact : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

		Page.Title = "Contact Us - About Us" + ConfigurationSettings.AppSettings["gsDefaultPageTitle"];
    }
    protected void cmdSubmit_Click(object sender, EventArgs e) {
        // send email to Spex telling them a new user has registered
        StringBuilder sb = new StringBuilder();
        sb.AppendLine("<html><body>");
        sb.AppendLine("Contact name: " + first_name.Text.Trim() + " " + last_name.Text.Trim() + "<br>");
        sb.AppendLine("Job Title: " + txtTitle.Text.Trim() + "<br>");
        sb.AppendLine("Company name: " + company_name.Text.Trim() + "<br>");
        sb.AppendLine("Address: " + company_address.Text.Trim() + ", " + city.Text.Trim() + ", " + state_region.Text.Trim() + ", " + zip.Text.Trim() + ", " + Country.SelectedItem.Text + "<br>");
        sb.AppendLine("Phone: " + phone_number.Text.Trim() + "<br>");
        sb.AppendLine("Email: " + email.Text.Trim() + "<br>");
        sb.AppendLine("Inquiry: " + Inquiry.Text.Trim() + "<br>");
        sb.AppendLine("</body></html>");
        string strBody = sb.ToString();

        MailMessage mm = new MailMessage();
        mm.Subject = "Contact Request from SPEX CertiPrep";
        //mm.To.Add("crmsales@spexcsp.com");
        //mm.To.Add("peskow@spexcsp.com");
        ////mm.CC.Add("sgeiger@spexcsp.com");
		mm.To.Add("spexcertiprepmarcom@gmail.com");

        mm.From = new MailAddress("contact@spexcsp.com", "SPEX CertiPrep Contact");
        mm.BodyEncoding = System.Text.Encoding.GetEncoding("utf-8");

        AlternateView plainView = AlternateView.CreateAlternateViewFromString(Regex.Replace(strBody, @"<(.|\n)*?>", string.Empty), System.Text.Encoding.GetEncoding("utf-8"), "text/plain");
        AlternateView htmlView = AlternateView.CreateAlternateViewFromString(strBody, System.Text.Encoding.GetEncoding("utf-8"), "text/html");
        mm.AlternateViews.Add(plainView);
        mm.AlternateViews.Add(htmlView);

        SmtpClient smtp = new SmtpClient();
        
        InsertSubmissionIntoDB();


        smtp.Send(mm);

        mvForm.SetActiveView(vwThank);

    }



    public void InsertSubmissionIntoDB()
    {
            
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString))
        {
            string SQL = "EXEC [cp_InsertContactUsSubmission] 'ContactUs', '" + first_name.Text.ToString() + "', '" + last_name.Text.ToString() + "', '" + txtTitle.Text.ToString() + "', '" + company_name.Text.ToString() + "', '" + company_address.Text.ToString() + "', '" + city.Text.ToString() + "', '" + state_region.Text.ToString() + "', '" + zip.Text.ToString() + "', '" + Country.SelectedItem.ToString() + "', '" + phone_number.Text.ToString() + "', '" + email.Text.ToString() + "', '" + Inquiry.Text.ToString() + "'";
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
        }
    }

}