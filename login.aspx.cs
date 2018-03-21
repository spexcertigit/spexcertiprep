using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Text;

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["error"] != null) {
            errorbox.Visible = true;
            ltrErrorMessage.Text = Request.QueryString["error"].ToString();
        }

        if (Request.QueryString["redirect"] != null) {
            redirect.Value = Request.QueryString["redirect"].ToString();
        }
        
    }
    protected void cmdLogin_Click(object sender, EventArgs e) {
        if (Page.IsValid) {
            clsUser myUser = new clsUser();

			//Response.Write("<!-- (RT) " + Email.Text.Trim() + " " + login_password.Text.Trim());
            if (!myUser.DoLogin(Email.Text.Trim(), login_password.Text.Trim())) {
                errorbox.Visible = true;
                ltrErrorMessage.Text = "User details not recognised.";
            } else {
                string RedirectedFrom = redirect.Value.Trim();
                if (RedirectedFrom.Length == 0) {
                    Response.Redirect("/default.aspx");
                } else {
                    if (RedirectedFrom.Contains("?oh=")) {
                        Response.Redirect("/" + RedirectedFrom);
                    } else if (RedirectedFrom.Contains(".aspx")) {
                        Response.Redirect(RedirectedFrom);
                    } else {
                        Response.Redirect("/" + RedirectedFrom + ".aspx");
                    }
                }
            }
        }



    }
    protected void cmdNew_Click(object sender, EventArgs e) {
        clsUser myUser = new clsUser();
        myUser.CreateAccount(lastname.Text.Trim(), firstname.Text.Trim(), password.Text.Trim(),
			email_check.Text.Trim(), Company.Text.Trim(), Refer.SelectedValue, Country.SelectedValue);
		
        // send email to Spex telling them a new user has registered
        StringBuilder sb = new StringBuilder();
        sb.AppendLine("<html><body>");
        sb.AppendLine("Contact name: " + firstname.Text.Trim() + " " + lastname.Text.Trim() + "<br>");
		sb.AppendLine("Company: " + Company.Text.Trim() + "<br>");
		sb.AppendLine("Country: " + Country.SelectedItem.Text + "<br>");
		sb.AppendLine("Email: " + email_check.Text.Trim() + "<br>");
		sb.AppendLine("How did you hear about us? " + Refer.SelectedValue + "<br>");
		if (first_time_online.Checked) {
            sb.AppendLine("Existing SPEX customer? Yes - first time online<br>");
            sb.AppendLine("ROI Web ID: " + myUser.ForROI_ID + "<br>");
            sb.AppendLine("Current account number: " + account_number.Text.Trim() + "<br>");
        } else {
            sb.AppendLine("Existing SPEX customer? No<br>");
            sb.AppendLine("ROI Web ID: " + myUser.ForROI_ID + "<br>");
		}
        sb.AppendLine("</body></html>");
        string strBody = sb.ToString();

        MailMessage mm = new MailMessage();
        mm.Subject = "New user registration on SPEX CertiPrep";
        mm.To.Add(new MailAddress("crmsales@spexcsp.com"));
		mm.CC.Add("peskow@spexcsp.com");
		//mm.Bcc.Add("tom@eerieglow.com");
		mm.From = new MailAddress("contact@spexcsp.com", "SPEX CertiPrep Contact");
        mm.BodyEncoding = System.Text.Encoding.GetEncoding("utf-8");

        AlternateView plainView = AlternateView.CreateAlternateViewFromString(Regex.Replace(strBody, @"<(.|\n)*?>", string.Empty), System.Text.Encoding.GetEncoding("utf-8"), "text/plain");
        AlternateView htmlView = AlternateView.CreateAlternateViewFromString(strBody, System.Text.Encoding.GetEncoding("utf-8"), "text/html");
        mm.AlternateViews.Add(plainView);
        mm.AlternateViews.Add(htmlView);

        SmtpClient smtp = new SmtpClient();
        smtp.Send(mm);

        // Log the new user in and redirect
        if (!myUser.DoLogin(email_check.Text.Trim(), password.Text.Trim())) {
            errorbox.Visible = true;
            ltrErrorMessage.Text = "User details not recognised.";
        } else {
            string RedirectedFrom = redirect.Value.Trim();
            if (RedirectedFrom.Length == 0) {
                Response.Redirect("/default.aspx");
            } else {
                if (RedirectedFrom.Contains("?oh=")) {
                    Response.Redirect("/" + RedirectedFrom);
                } else if (RedirectedFrom.Contains(".aspx")) {
                    Response.Redirect(RedirectedFrom);
                } else {
                    Response.Redirect("/" + RedirectedFrom + ".aspx");
                }
            }
        }
    }
}