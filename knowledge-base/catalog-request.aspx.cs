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

public partial class knowledge_base_catalog : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ((Inside)Master).AllowShareThisIcon=true;
        Page.Title = "Request a Catalog - Knowledge Base" + ConfigurationSettings.AppSettings["gsDefaultPageTitle"];

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string str2="";
            string SQL = "SELECT * FROM cp_Product_Literature_Category";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read()) {
                    str2 += "<div class='category-section'>" +
                                "<h3>" + dr["CategoryName"].ToString() + "</h3>" + 
                                getProdLit(Convert.ToInt32(dr["CategoryID"])) +
                                "<div style='clear:both'></div>" +
                            "</div>";
                }
                cmd.Connection.Close();
            }
            ltrProdLit.Text = str2;
        }
    }
    public string getProdLit(int id) {
        string str2="";
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string checkID = "";
            string imgUrl = "";
            string SQL = "SELECT * FROM cp_Product_Literature WHERE CategoryID = " + id;
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read()) {
                    string flyerStyle="";
                    checkID = dr["id"].ToString();
                    if (dr["LitImage"].ToString() != "") {
						flyerStyle="style='height:220px'";
					}
                    str2 += "<div class='flyers' " + flyerStyle + ">";
					if (dr["LitImage"].ToString() != "") {
                        imgUrl = "<img src='images/" + dr["LitImage"].ToString() + "' />";
						str2 += "<a target='_blank' id='lnk" + checkID + "' href='catalogs/" + dr["LitFile"].ToString() + "'>" + imgUrl + "</a>";
                    }
                    str2 +=     "<div class='checkbox'>" +
                                    "<input id='checkBox" + checkID + "' type='checkbox' name='litCheckBox' value='" + dr["LitName"].ToString() + "' runat='server'>" +
                                    "<label for='checkBox" + checkID + "'> " + dr["LitName"].ToString() + "</label>" +
                                "</div>" +
                            "</div>";
                }
                cmd.Connection.Close();
            }
        }
        return str2;
    }   

    protected void cmdSubmit_Click(object sender, EventArgs e) {
        // send email to Spex telling them a new user has registered
        StringBuilder sb = new StringBuilder();
        sb.AppendLine("<html><body>");
		sb.AppendLine("<div style='padding:30px 25px; border: 1px solid #b9b9b9;width:525px;'><a href='http://www.spexcertiprep.com/'><img src='http://www.spexcertiprep.com/images/certiprep_logo_new.png' alt='SPEX CertiPrep'></a>");
		sb.AppendLine("<table border='0'>");
        sb.AppendLine("<tr><td style='width:156px;padding:10px'>Contact name:</td><td style='font-weight:bold;padding:10px'>" + first_name.Text.Trim() + " " + last_name.Text.Trim() + "</td></tr>");
        sb.AppendLine("<tr><td style='padding:10px'>Job Title:</td><td style='font-weight:bold;padding:10px'>" + txtTitle.Text.Trim() + "</td></tr>");
        sb.AppendLine("<tr><td style='padding:10px'>Company name:</td><td style='font-weight:bold;padding:10px'>" + company_name.Text.Trim() + "</td></tr>");
        sb.AppendLine("<tr><td style='padding:10px'>Address:</td><td style='font-weight:bold;padding:10px'>" + company_address.Text.Trim() + ", " + city.Text.Trim() + ", " + state_region.Text.Trim() + ", " + zip.Text.Trim() + ", " + Country.SelectedItem.Text + "</td></tr>");
        sb.AppendLine("<tr><td style='padding:10px'>Phone:</td><td style='font-weight:bold;padding:10px'>" + phone_number.Text.Trim() + "</td></tr>");
        sb.AppendLine("<tr><td style='padding:10px'>Email:</td><td style='font-weight:bold;padding:10px'>" + email.Text.Trim() + "</td></tr>");
        
        if (Request.Form["litCheckBox"] != "") {
            sb.AppendLine("<tr><td style='padding:10px;vertical-align:top'>Please send hard copy of:</td><td style='font-weight:bold;padding:10px'>");
            sb.AppendLine(Regex.Replace(Request.Form["litCheckBox"], ",", "<br>") + "</td></tr>");
        }
        sb.AppendLine("<br>");
        sb.AppendLine("</body></html>");
        string strBody = sb.ToString();

        MailMessage mm = new MailMessage();
        mm.Subject = "Catalog Request from SPEX CertiPrep";
        mm.To.Add(new MailAddress("crmsales@spex.com"));
		mm.CC.Add(new MailAddress("aevans@spex.com"));
		mm.Bcc.Add("spexcertiprepmarcom@gmail.com");

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