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

public partial class ecs_parts : System.Web.UI.Page
{
    protected string sTitle = "";
    protected int ProductCount = 0;
    protected string Region = "US";
    protected string CurrencySymbol = "$";
    protected string CatCode = "1";
	protected string sDesc = "";
    protected clsUser myUser;
	protected string strCatalog = "";
	
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack) {
			Page.Title = "Optimize | SPEX CertiPrep";
        }
    }
	protected void cmdNew_Click(object sender, EventArgs e) {
		int subscribe = 0;
		string fullAdd = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "INSERT INTO cp_optimize_download" +
                "(fname, email, company, address, country, currdate) " +
                "VALUES (@fname,  @email, @company, @address, @country, @currdate)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				DateTime dateNow = DateTime.Now;
				fullAdd = address.Text.Trim() + ", " + city.Text.Trim() + ", " + state_region.Text.Trim() + ", " + zip.Text.Trim() + ", " + Country.SelectedItem.Text;
				
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@fname", SqlDbType.NVarChar, 50).Value = fullname.Text.Trim();
				cmd.Parameters.Add("@email", SqlDbType.NVarChar, 100).Value = email_check.Text.Trim();
				cmd.Parameters.Add("@company", SqlDbType.NVarChar, 100).Value = Company.Text.Trim();
				cmd.Parameters.Add("@address", SqlDbType.Text).Value = fullAdd;
                cmd.Parameters.Add("@country", SqlDbType.NVarChar, 50).Value = Country.SelectedItem.Text;
				cmd.Parameters.Add("@currdate", SqlDbType.DateTime).Value = dateNow;

                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
        }
		
		StringBuilder sb = new StringBuilder();
        sb.AppendLine("<html><body>");
        sb.AppendLine("Contact name: " + fullname.Text.Trim() + "<br>");
        sb.AppendLine("Company name: " + Company.Text.Trim() + "<br>");
		sb.AppendLine("Address " + fullAdd + "<br>");
        sb.AppendLine("Email: " + email_check.Text.Trim() + "<br>");
        sb.AppendLine("</body></html>");
        string strBody = sb.ToString();

        MailMessage mm = new MailMessage();
        mm.Subject = "A Customer requested a Physical Copy of Optimize Issue";
		mm.To.Add(new MailAddress("crmsales@spex.com"));
		mm.To.Add(new MailAddress("aevans@spex.com"));
		mm.Bcc.Add(new MailAddress("spexcertiprepmarcom@gmail.com"));
        //mm.To.Add(new MailAddress("crmsales@spexcsp.com"));
		
		mm.From = new MailAddress("contact@spexcsp.com", "SPEX CertiPrep Contact");
        mm.BodyEncoding = System.Text.Encoding.GetEncoding("utf-8");

        AlternateView plainView = AlternateView.CreateAlternateViewFromString(Regex.Replace(strBody, @"<(.|\n)*?>", string.Empty), System.Text.Encoding.GetEncoding("utf-8"), "text/plain");
        AlternateView htmlView = AlternateView.CreateAlternateViewFromString(strBody, System.Text.Encoding.GetEncoding("utf-8"), "text/html");
        mm.AlternateViews.Add(plainView);
        mm.AlternateViews.Add(htmlView);

        SmtpClient smtp = new SmtpClient();
        smtp.Send(mm);
		
		Session["thankyou-redirect"] = HttpContext.Current.Request.Url.AbsolutePath;
		Response.Redirect("optimize-thank-you.aspx");
		
		//PDFdownload();
	}
	
	public void PDFdownload() {    
		Response.Clear();
		Response.ClearHeaders();
		Response.ClearContent();
		Response.AddHeader("Content-Disposition", "attachment; filename=Optimize_201601.pdf"); 
		Response.ContentType = "Application/pdf"; 
		Response.Flush();
		Response.TransmitFile(Server.MapPath("/ECS/Optimize_201601.pdf")); 
		Response.End(); 
		Response.Clear();
	}
}