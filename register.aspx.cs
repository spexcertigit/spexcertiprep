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
		/*
        if (Request.QueryString["redirect"] != null) {
            redirect.Value = Request.QueryString["redirect"].ToString();
        }*/
        
    }
	/*
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
	*/
    protected void cmdNew_Click(object sender, EventArgs e) {
        clsUser myUser = new clsUser();
        myUser.CreateAccount(lastname.Text.Trim(), firstname.Text.Trim(), password.Text.Trim(), email_check.Text.Trim(), Company.Text.Trim(), DropDownList1.SelectedValue, Country.SelectedValue, PhoneNbr.Text.Trim(), Add1.Text.Trim(), Add2.Text.Trim(), City.Text.Trim(), State.Text.Trim(), Zip.Text.Trim());
		
        // send email to Spex telling them a new user has registered
        StringBuilder sb = new StringBuilder();
        sb.AppendLine("<html><body>");
		sb.AppendLine("<div style='padding:30px 25px; border: 1px solid #b9b9b9;width:525px;'><a href='http://www.spexcertiprep.com/'><img src='http://www.spexcertiprep.com/images/certiprep_logo_new.png' alt='SPEX CertiPrep'></a>");
		sb.AppendLine("<table border='0'>");
        sb.AppendLine("<tr><td style='width:198px;padding:10px'>Contact name:</td><td style='font-weight:bold;padding:10px'>" + firstname.Text.Trim() + " " + lastname.Text.Trim() +"</td></tr>");
		sb.AppendLine("<tr><td style='padding:10px'>Address:</td><td style='font-weight:bold;padding:10px'>" + Add1.Text.Trim() + ", " + Add2.Text.Trim() + ", " + City.Text.Trim() + ", " + State.Text.Trim() + " " + Zip.Text.Trim() + "</td></tr>");
		sb.AppendLine("<tr><td style='padding:10px'>Company:</td><td style='font-weight:bold;padding:10px'>" + Company.Text.Trim() + "</td></tr>");
		sb.AppendLine("<tr><td style='padding:10px'>Country:</td><td style='font-weight:bold;padding:10px'>" + Country.SelectedItem.Text + "</td></tr>");
		sb.AppendLine("<tr><td style='padding:10px'>Email:</td><td style='font-weight:bold;padding:10px'>" + email_check.Text.Trim() + "</td></tr>");
		sb.AppendLine("<tr><td style='padding:10px'>How did you hear about us?</td><td style='font-weight:bold;padding:10px'>" + DropDownList1.SelectedValue + "</td></tr>");
		sb.AppendLine("<tr><td style='padding:10px'>Phone:</td><td style='font-weight:bold;padding:10px'>" + PhoneNbr.Text.Trim() + "</td></tr>");
		if (first_time_online.Checked) {
            sb.AppendLine("<tr><td style='padding:10px'>Existing SPEX customer?</td><td style='padding:10px'>Yes - first time online</td></tr>");
            sb.AppendLine("<tr><td style='padding:10px'>ROI Web ID:</td><td style='font-weight:bold;padding:10px'>" + myUser.ForROI_ID + "</td></tr>");
            sb.AppendLine("<tr><td style='padding:10px'>Current account number:</td><td style='font-weight:bold;padding:10px'>" + account_number.Text.Trim() + "</td></tr>");
        } else {
            sb.AppendLine("<tr><td style='padding:10px'>Existing SPEX customer?</td><td style='padding:10px'>No</td></tr>");
            sb.AppendLine("<tr><td style='padding:10px'>ROI Web ID:</td><td style='font-weight:bold;padding:10px'>" + myUser.ForROI_ID + "</td></tr>");
		}
		sb.AppendLine("</table></div>");
        sb.AppendLine("</body></html>");
        string strBody = sb.ToString();

        MailMessage mm = new MailMessage();
        mm.Subject = "New user registration on SPEX CertiPrep";
		//mm.To.Add(new MailAddress("carlo.cortes.sci@gmail.com"));
        mm.To.Add(new MailAddress("crmsales@spexcsp.com"));
		//mm.CC.Add(new MailAddress("peskow@spexcsp.com"));
		mm.To.Add(new MailAddress("crmsales@spex.com"));
		mm.Bcc.Add(new MailAddress("tom@eerieglow.com"));
		mm.Bcc.Add(new MailAddress("spexcertiprepmarcom@gmail.com"));
		mm.From = new MailAddress("CRMSales@spex.com", "SPEX CertiPrep Contact");
        mm.BodyEncoding = System.Text.Encoding.GetEncoding("utf-8");
		
        AlternateView plainView = AlternateView.CreateAlternateViewFromString(Regex.Replace(strBody, @"<(.|\n)*?>", string.Empty), System.Text.Encoding.GetEncoding("utf-8"), "text/plain");
        AlternateView htmlView = AlternateView.CreateAlternateViewFromString(strBody, System.Text.Encoding.GetEncoding("utf-8"), "text/html");
        mm.AlternateViews.Add(plainView);
        mm.AlternateViews.Add(htmlView);

        SmtpClient smtp = new SmtpClient();
        smtp.Send(mm);
		
		
		
		StringBuilder sb2 = new StringBuilder();
        sb2.AppendLine("<html><body>");
		sb2.AppendLine("<div style='padding:30px 25px; border: 1px solid #b9b9b9;width:525px;'><a href='http://www.spexcertiprep.com/'><img src='http://www.spexcertiprep.com/images/certiprep_logo_new.png' alt='SPEX CertiPrep'></a>");
		sb2.AppendLine("<table border='0' style='width:100%'>");
        sb2.AppendLine("<tr><td style='padding:10px'>&nbsp;</td></tr>");
		sb2.AppendLine("<tr><td style='padding:10px'>Thank you for registering with SPEX CertiPrep. You can access your account at any time by clicking My Account at <a href='https://www.spexcertiprep.com'>www.spexcertiprep.com</a>.</td></tr>");
		sb2.AppendLine("<tr><td style='padding:10px'>If you have any questions or need assistance, contact us at 1.800.LAB.SPEX or 732.549.7144 or via email at CRMSales@spex.com.</td></tr>");
		sb2.AppendLine("<tr><td style='padding:10px'>- SPEX CertiPrep</td></tr>");
		sb2.AppendLine("<tr><td style='padding:10px'>&nbsp;</td></tr>");
		sb2.AppendLine("<tr><td style='padding:10px'>&nbsp;</td></tr>");
		sb2.AppendLine("</table></div>");
        sb2.AppendLine("</body></html>");
		strBody = sb2.ToString();
		
		MailMessage mm2 = new MailMessage();
		mm2.Subject = "Thank you for registering at SPEX CertiPrep";
		mm2.To.Add(new MailAddress(email_check.Text.Trim()));
		mm2.Bcc.Add(new MailAddress("tom@eerieglow.com"));
		mm2.From = new MailAddress("CRMSales@spex.com", "SPEX CertiPrep Contact");
        mm2.BodyEncoding = System.Text.Encoding.GetEncoding("utf-8");
		
        plainView = AlternateView.CreateAlternateViewFromString(Regex.Replace(strBody, @"<(.|\n)*?>", string.Empty), System.Text.Encoding.GetEncoding("utf-8"), "text/plain");
        htmlView = AlternateView.CreateAlternateViewFromString(strBody, System.Text.Encoding.GetEncoding("utf-8"), "text/html");
        mm2.AlternateViews.Add(plainView);
        mm2.AlternateViews.Add(htmlView);

        SmtpClient smtp2 = new SmtpClient();
        smtp2.Send(mm2);
		
		
        // Log the new user in and redirect
        if (!myUser.DoLogin(email_check.Text.Trim(), password.Text.Trim())) {
            errorbox.Visible = true;
            
        } else {
			
            Response.Redirect("/register-thankyou.aspx");
        }
    }

     protected void cmdLoginFromReg_Click(object sender, EventArgs e)
    {
        string LoginRedirect = HttpContext.Current.Request.Url.AbsolutePath;
        
        if (Page.IsValid) 
        {
            clsUser myUser = new clsUser();
            if (!myUser.DoLogin(txtUsernameFromReg.Text.Trim(), txtPasswordFromReg.Text.Trim()))
            {
               
                ltrErrorMsgFromReg.Text = "Wrong username or password. <br /> Please try again.";
            }
            else
            {
                Response.Redirect("~/order_summary.aspx");
                
            }

           
        }//PAGE IS VALID
    }
}