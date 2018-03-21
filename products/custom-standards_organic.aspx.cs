using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class products_custom_standards_organic : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack) {
            units_menu.DataBind();
            ListItem li = units_menu.Items.FindByValue("µg/mL");
            if (li != null) { li.Selected = true; }
        }
		Page.Title = "Custom Organic Standards Request Form" + ConfigurationSettings.AppSettings["gsDefaultPageTitle"];
    }
    protected void cmdSubmit_Click(object sender, EventArgs e) {
        // send email to Spex telling them a new user has registered
        StringBuilder sb = new StringBuilder();
		sb.AppendLine("<html><body>");
		sb.AppendLine("<div style='padding:30px 25px; border: 1px solid #b9b9b9;width:525px;'><a href='http://www.spexcertiprep.com/'><img src='http://www.spexcertiprep.com/images/certiprep_logo_new.png' alt='SPEX CertiPrep'></a>");
		sb.AppendLine("<table border='0'>");
		sb.AppendLine("<tr><td style='width:135px;padding:10px'>Contact name: </td><td style='font-weight:bold;padding:10px'>" + first_name.Text.Trim() + " " + last_name.Text.Trim() + "</td></tr>");
		sb.AppendLine("<tr><td style='padding:10px'>Job Title: </td><td style='font-weight:bold;padding:10px'>" + txtTitle.Text.Trim() + "</td></tr>");
		sb.AppendLine("<tr><td style='padding:10px'>Company name: </td><td style='font-weight:bold;padding:10px'>" + company_name.Text.Trim() + "</td></tr>");
		sb.AppendLine("<tr><td style='padding:10px'>Address: </td><td style='font-weight:bold;padding:10px'>" + company_address.Text.Trim() + ", " + city.Text.Trim() + ", " + state_region.Text.Trim() + ", " + zip.Text.Trim() + ", " + Country.SelectedItem.Text + "</td></tr>");
		sb.AppendLine("<tr><td style='padding:10px'>Phone: </td><td style='font-weight:bold;padding:10px'>" + phone_number.Text.Trim() + "</td></tr>");
		sb.AppendLine("<tr><td style='padding:10px'>Email: </td><td style='font-weight:bold;padding:10px'>" + email.Text.Trim() + "</td></tr>");
		sb.AppendLine("<tr><td style='padding:10px'>Refer By: </td><td style='font-weight:bold;padding:10px'>" + Refer.SelectedItem.Text + "</td></tr>");
		
		string[] seperators = {"Component# =", "CASNumber =", "Concentration ="};
		string sComponents = components.Text.Trim();
		string[] values = sComponents.Split(seperators, StringSplitOptions.RemoveEmptyEntries);
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "INSERT INTO cp_Custom_Request (contact_name, job_title, company_name, address, phone, email, refer_by, instrument_type, matrix, volume, quantity, comments, category) VALUES (@contact_name, @job_title, @company_name, @address, @phone, @email, @refer_by, @instrument_type, @matrix, @volume, @quantity, @comments, 0)";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@contact_name", SqlDbType.NVarChar, 120).Value = first_name.Text.Trim() + " " + last_name.Text.Trim();
				cmd.Parameters.Add("@job_title", SqlDbType.NVarChar, 120).Value = txtTitle.Text.Trim();
				cmd.Parameters.Add("@company_name", SqlDbType.NVarChar, 120).Value = company_name.Text.Trim();
				cmd.Parameters.Add("@address", SqlDbType.Text).Value = company_address.Text.Trim() + ", " + city.Text.Trim() + ", " + state_region.Text.Trim() + ", " + zip.Text.Trim() + ", " + Country.SelectedItem.Text;
				cmd.Parameters.Add("@phone", SqlDbType.NVarChar, 60).Value = phone_number.Text.Trim();
				cmd.Parameters.Add("@email", SqlDbType.NVarChar, 100).Value = email.Text.Trim();
				cmd.Parameters.Add("@refer_by", SqlDbType.NVarChar, 60).Value = Refer.SelectedItem.Text;
				if (instrument_type.SelectedValue == "Other") {
					cmd.Parameters.Add("@instrument_type", SqlDbType.NVarChar, 100).Value = instrument_type.SelectedValue + ": " + other_instru.Text.Trim();
				}else {
					cmd.Parameters.Add("@instrument_type", SqlDbType.NVarChar, 100).Value = instrument_type.SelectedValue;
				}
				cmd.Parameters.Add("@matrix", SqlDbType.NVarChar, 200).Value = matrix.SelectedValue;
				cmd.Parameters.Add("@volume", SqlDbType.NVarChar, 20).Value = volume.Text.Trim();
				cmd.Parameters.Add("@quantity", SqlDbType.Int).Value = quantity.Text.Trim();
				cmd.Parameters.Add("@comments", SqlDbType.Text).Value = comments.Text.Trim();
				cmd.Connection.Open();
				cmd.ExecuteNonQuery();
				cmd.Connection.Close();
			}
			
			int req_id = 0;
			
			SQL = "SELECT id FROM cp_Custom_Request ORDER BY id DESC";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				if (dr.HasRows) {
					dr.Read();
					req_id = Convert.ToInt32(dr["id"].ToString());
				} 
				cmd.Connection.Close();
			}
		
			sb.AppendLine("<tr><td colspan='2' style='padding:10px'><table class='tbl2' border='0' style='width:100%;border-spacing:0'><tr><td colspan='4' style='background: url(http://www.spexcertiprep.com/images/headerbartop.png) repeat-x;color: #fff;font-weight: bold;font-size: 16px;border: 1px solid rgb(79, 79, 79);border-top: none;padding:10px'>");
			sb.AppendLine("Components requested:</td></tr>");
			sb.AppendLine("<tr style='background:#e7dedf;border:1px solid #bfbfbf;border-top:none;'><td style='padding:5px 20px;border-left:1px solid #bfbfbf;border-bottom:1px solid #bfbfbf;''>ITEM</td><td style='padding:5px 20px;border-bottom:1px solid #bfbfbf;'>CAS NUMBER</td><td style='padding:5px 20px;border-right:1px solid #bfbfbf;border-bottom:1px solid #bfbfbf;'>CONCENTRATION</td></tr>");
			int ctr = 1, num = 1;
			string bg = "", item="", casNum="", conc="";
			
			foreach (var word in values) {
				if (ctr == 1) {
					sb.AppendLine("<tr style='"+bg+"'><td style='padding:5px 20px;border-left:1px solid #bfbfbf;border-bottom:1px solid #bfbfbf;'>" + num + ". " + word +"</td>");
					num++;
					item = word;
				}else if (ctr == 2) {
					sb.AppendLine("<td style='padding:5px 20px;border-bottom:1px solid #bfbfbf;'>" + word +"</td>");
					casNum = word;
				}else if (ctr == 3) {
					sb.AppendLine("<td style='padding:5px 20px;border-right:1px solid #bfbfbf;border-bottom:1px solid #bfbfbf;'>" + word +"</td></tr>");
					conc = word;
					SQL = "INSERT INTO cp_Custom_Request_List (item, cas_number, concentration, req_id) VALUES (@item, @casNum, @conc, @req_id)";
					using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
						cmd.CommandType = CommandType.Text;
						cmd.Parameters.Add("@item", SqlDbType.NVarChar, 200).Value = item;
						cmd.Parameters.Add("@casNum", SqlDbType.NVarChar, 150).Value = casNum;
						cmd.Parameters.Add("@conc", SqlDbType.NVarChar, 150).Value = conc;
						cmd.Parameters.Add("@req_id", SqlDbType.Int).Value = req_id;
						cmd.Connection.Open();
						cmd.ExecuteNonQuery();
						cmd.Connection.Close();
					}
					ctr = 0;
				}
				ctr++;
				if (bg == "background:#e7dedf") {
					bg = "";
				}else {
					bg = "background:#e7dedf";
				}
			}
		}
		//sb.AppendLine("<tr><td style='padding:5px 20px;'>" + sComponents.Replace("CASNumber =","</td><td style='padding:5px 20px;'>").Replace("Concentration =","</td><td style='padding:5px 20px;'>").Replace("\n","</td></tr><tr><td style='padding:5px 20px;'>").Replace("<BR>","<td style='padding:5px 20px;>").Replace("Component#","") + "</td></tr>");
		sb.AppendLine("</table></td></tr>");
		if (instrument_type.SelectedValue == "Other") {
			sb.AppendLine("<tr><td style='padding:10px'>Instrument Type: </td><td style='font-weight:bold;padding:10px'>" + instrument_type.SelectedValue + ": " + other_instru.Text.Trim() + "</td></tr>");
		}else {
			sb.AppendLine("<tr><td style='padding:10px'>Instrument Type: </td><td style='font-weight:bold;padding:10px'>" + instrument_type.SelectedValue + "</td></tr>");
		}
		sb.AppendLine("<tr><td style='padding:10px'>Matrix: </td><td style='font-weight:bold;padding:10px'>" + matrix.SelectedValue + "</td></tr>");
		sb.AppendLine("<tr><td style='padding:10px'>Volume: </td><td style='font-weight:bold;padding:10px'>" + volume.Text.Trim() + "</td></tr>");
		sb.AppendLine("<tr><td style='padding:10px'>Quantity:</td><td style='font-weight:bold;padding:10px'> " + quantity.Text.Trim() + "</td></tr>");
		
	//	if (data_pack.Checked) {
	//		sb.AppendLine("<tr><td>Checked: Data Pack::</td><td>YES</td></tr>");
	//	} else
	//		sb.AppendLine("<tr><td>Checked: Data Pack::</td><td>NO</td></tr>");

		sb.AppendLine("<tr><td style='padding:10px'>Comments:: </td><td style='font-weight:bold;padding:10px'>" + comments.Text.Trim() + "&nbsp;</td></tr>");
		sb.AppendLine("</table></div>");
		sb.AppendLine("</body></html>");

		string strBody = sb.ToString();

        MailMessage mm = new MailMessage();
        mm.Subject = "New Organic Custom Standards Request from SPEX CertiPrep";
        //mm.To.Add(new MailAddress("peskow@spexcsp.com"));
		mm.To.Add(new MailAddress("spexcertiprepmarcom@gmail.com"));
		mm.To.Add(new MailAddress("crmsales@spexcsp.com"));
		mm.To.Add(new MailAddress("crmsales@spex.com"));
		

        mm.From = new MailAddress("contact@spexcsp.com", "SPEX CertiPrep Contact");
        mm.BodyEncoding = System.Text.Encoding.GetEncoding("utf-8");

        AlternateView plainView = AlternateView.CreateAlternateViewFromString(Regex.Replace(strBody, @"<(.|\n)*?>", string.Empty), System.Text.Encoding.GetEncoding("utf-8"), "text/plain");
        AlternateView htmlView = AlternateView.CreateAlternateViewFromString(strBody, System.Text.Encoding.GetEncoding("utf-8"), "text/html");
        mm.AlternateViews.Add(plainView);
        mm.AlternateViews.Add(htmlView);

        SmtpClient smtp = new SmtpClient();
        smtp.Send(mm);

		Session["thankyou-redirect"] = HttpContext.Current.Request.Url.AbsolutePath;
		Response.Redirect("custom_standards_organic_thankyou.aspx");
		
        //mvForm.SetActiveView(vwThank);

	//Response.Write(strBody.Replace("\n","<BR>"));

	}
    //protected void organic_inorganic_SelectedIndexChanged(object sender, EventArgs e) {
    //    if (organic_inorganic.SelectedValue == "Inorganic") { Response.Redirect("custom-standards_inorganic.aspx"); }
    //}
}