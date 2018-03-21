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

		Page.Title = "Contact Us" + ConfigurationSettings.AppSettings["gsDefaultPageTitle"];
    }
    protected void cmdSubmit_Click(object sender, EventArgs e) {
        // send email to Spex telling them a new user has registered
        StringBuilder sb = new StringBuilder();
		sb.AppendLine("<html><body>");
		sb.AppendLine("<div style='padding:30px 25px; border: 1px solid #b9b9b9;width:525px;'><a href='http://www.spexcertiprep.com/'><img src='http://www.spexcertiprep.com/images/certiprep_logo_new.png' alt='SPEX CertiPrep'></a>");
		sb.AppendLine("<table border='0'>");
        sb.AppendLine("<tr><td style='width:135px;padding:10px'>Contact name:</td><td style='font-weight:bold;padding:10px'>" + first_name.Text.Trim() + " " + last_name.Text.Trim() + "</td></tr>");
        sb.AppendLine("<tr><td style='padding:10px'>Job Title:</td><td style='font-weight:bold;padding:10px'>" + txtTitle.Text.Trim() + "</td></tr>");
        sb.AppendLine("<tr><td style='padding:10px'>Company name:</td><td style='font-weight:bold;padding:10px'>" + company_name.Text.Trim() + "</td></tr>");
        sb.AppendLine("<tr><td style='padding:10px'>Address:</td><td style='font-weight:bold;padding:10px'>" + company_address.Text.Trim() + ", " + city.Text.Trim() + ", " + state_region.Text.Trim() + ", " + zip.Text.Trim() + ", " + Country.SelectedItem.Text + "</td></tr>");
        sb.AppendLine("<tr><td style='padding:10px'>Phone:</td><td style='font-weight:bold;padding:10px'>" + phone_number.Text.Trim() + "</td></tr>");
        sb.AppendLine("<tr><td style='padding:10px'>Email:</td><td style='font-weight:bold;padding:10px'>" + email.Text.Trim() + "</td></tr>");
        sb.AppendLine("<tr><td style='padding:10px'>Inquiry:</td><td style='font-weight:bold;padding:10px'>" + Inquiry.Text.Trim() + "</td></tr>");
		sb.AppendLine("</table></div>");
        sb.AppendLine("</body></html>");
        string strBody = sb.ToString();

        MailMessage mm = new MailMessage();
        mm.Subject = "Contact Request from SPEX CertiPrep";
		mm.To.Add(new MailAddress("crmsales@spex.com"));
		mm.CC.Add(new MailAddress("crmsales@spexcsp.com"));
		mm.Bcc.Add(new MailAddress("spexcertiprepmarcom@gmail.com"));

        mm.From = new MailAddress("CRMSales@spex.com", "SPEX CertiPrep Contact");
        mm.BodyEncoding = System.Text.Encoding.GetEncoding("utf-8");

        AlternateView plainView = AlternateView.CreateAlternateViewFromString(Regex.Replace(strBody, @"<(.|\n)*?>", string.Empty), System.Text.Encoding.GetEncoding("utf-8"), "text/plain");
        AlternateView htmlView = AlternateView.CreateAlternateViewFromString(strBody, System.Text.Encoding.GetEncoding("utf-8"), "text/html");
        mm.AlternateViews.Add(plainView);
        mm.AlternateViews.Add(htmlView);

        SmtpClient smtp = new SmtpClient();
        
        InsertSubmissionIntoDB();


        smtp.Send(mm);
		Session["thankyou-redirect"] = HttpContext.Current.Request.Url.AbsolutePath;
		Response.Redirect("contact_us_thankyou.aspx");
        mvForm.SetActiveView(vwThank);

    }



    public void InsertSubmissionIntoDB()
    {
            
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString))
        {
            string SQL = "EXEC [cp_InsertContactUsSubmission] 'ContactUs', '" + HttpUtility.HtmlEncode(first_name.Text.ToString()) + "', '" + HttpUtility.HtmlEncode(last_name.Text.ToString()) + "', '" + HttpUtility.HtmlEncode(txtTitle.Text.ToString()) + "', '" + HttpUtility.HtmlEncode(company_name.Text.ToString()) + "', '" + HttpUtility.HtmlEncode(company_address.Text.ToString()) + "', '" + HttpUtility.HtmlEncode(city.Text.ToString()) + "', '" + HttpUtility.HtmlEncode(state_region.Text.ToString()) + "', '" + HttpUtility.HtmlEncode(zip.Text.ToString()) + "', '" + HttpUtility.HtmlEncode(Country.SelectedItem.ToString()) + "', '" + HttpUtility.HtmlEncode(phone_number.Text.ToString()) + "', '" + HttpUtility.HtmlEncode(email.Text.ToString()) + "', '" + HttpUtility.HtmlEncode(Inquiry.Text.ToString()) + "'";
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