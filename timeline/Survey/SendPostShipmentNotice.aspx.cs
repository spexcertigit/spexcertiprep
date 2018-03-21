using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Survey_PostShipment : System.Web.UI.Page
{
	private string CustomerID = "";
	private int OrderID = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
		if (!Page.IsPostBack) {
			ProcessDate.Text = DateTime.Now.ToShortDateString();
		}
		if (Request.QueryString["mode"] != null && Request.QueryString["mode"].ToString() == "auto") {
			ProcessOrders(DateTime.Now.ToShortDateString());
		}
    }
	protected void cmdSubmit_Click(object sender, EventArgs e) {
		ProcessOrders(ProcessDate.Text);
	}

	protected void ProcessOrders(string processDate) {
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT id, customer_id, UserEmail, Billing_Name, DATEADD(dd,-14,@myDate), DATEADD(dd,-13,@myDate) " +
							"FROM WebOrderDetails " +
							"WHERE site = 'CP' AND orderdate >= DATEADD(dd,-14,@myDate) AND orderdate < DATEADD(dd,-13,@myDate)";

			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("myDate", SqlDbType.DateTime).Value = processDate;

				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				while (dr.Read()) {
					SendNotice(dr["UserEmail"].ToString(), dr["Billing_Name"].ToString(), dr["id"].ToString(), "http://spexcertiprep.com/survey/postshipment.aspx?id=" + dr["id"].ToString() + "&cust=" + dr["customer_id"].ToString());
				}
				cmd.Connection.Close();
			}
		}
	}

	private void SendNotice(string email, string Billing_Name, string OrderID, string URL) {
		//---------------- Sending Email
		if (email.Length > 0) {
			string strBody = "<html><body>Dear " + Billing_Name + ",<br /><br />" +
								"Thank you for your recent order (#" + OrderID + ")  from SPEX CertiPrep.<br /><br />" +
								"As a valued customer, your opinion is important to us. Please take a few minutes to complete our brief online customer satisfaction survey: <br />" +
								"<a href='" + URL + "'>" + URL + "<a/><br /><br />" +
								"At the end of the survey, <b>you will receive a discount code to save 20% off your next online order of $150 or more.</b><br /><br />" +
								"Your feedback helps us improve our current processes to make your next purchasing experience easier and more convenient!  Please contact me directly if you have any additional comments or questions.<br /><br />" +
								"Sincerely,<br /><br />" +
								"Amy Williams<br />" +
								"Marketing Manager<br />" +
								"Tel. 732-549-7144 ext. 452" +
								"</body></html>";

			MailMessage mm = new MailMessage();
			mm.From = new MailAddress("info@spexcertiprep.com", "SpexCertiPrep.com");
			mm.Subject = "Thank you for your recent order from SPEX CertiPrep! (Order #" + OrderID + ")";
			mm.To.Add(email);
			mm.Bcc.Add("ycangelosi@spexcsp.com");
			mm.Bcc.Add("rtoomey@baldwinandobenauf.com");
			mm.Bcc.Add("peskow@spex.com");
			mm.Bcc.Add("awilliams@spex.com");
			mm.Bcc.Add("tom@eerieglow.com");

			AlternateView plainView = AlternateView.CreateAlternateViewFromString(Regex.Replace(strBody, @"<(.|\n)*?>", string.Empty), System.Text.Encoding.GetEncoding("utf-8"), "text/plain");
			AlternateView htmlView = AlternateView.CreateAlternateViewFromString(strBody, System.Text.Encoding.GetEncoding("utf-8"), "text/html");
			mm.AlternateViews.Add(plainView);
			mm.AlternateViews.Add(htmlView);

			SmtpClient smtp = new SmtpClient();
			smtp.Send(mm);
		}

	}
}