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

public partial class knowledge_base_msds : System.Web.UI.Page
{
	protected string PageID = "";

	protected void Page_Load(object sender, EventArgs e) {
		((Inside)Master).AllowShareThisIcon=true;
		string PageTitle = "";
		string section = "knowledge-base";
		string detail = "msds";
		string qString = "/cp/" + section + "/" + detail;

		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString)) {
			using (SqlCommand cmd = new SqlCommand("SELECT * FROM [cms_Page] WHERE VirtualPath = @VirtualPath", cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("VirtualPath", SqlDbType.VarChar, 250).Value = qString;

				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				if (dr.HasRows) {
					dr.Read();
					PageTitle = dr["PageTitle"].ToString();
					Page.MetaDescription = dr["PageDescription"].ToString();
					Page.MetaKeywords = dr["PageKeywords"].ToString();
					PageID = dr["PageID"].ToString();
				}
				cmd.Connection.Close();
			}
		}

		if (PageTitle.Length > 0) {
			Page.Title = PageTitle + " - Knowledge Base" + Global.TitleSuffixSep + Global.TitleSuffix;
		} else {
			Page.Title = "Knowledge Base" + Global.TitleSuffixSep + Global.TitleSuffix;
		}

		LoopTextBoxes(Page);
	}

	private void LoopTextBoxes(Control parent) {
		if (PageID.Length > 0) {
			using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString)) {
				using (SqlCommand cmd = new SqlCommand("SELECT Contents FROM [cms_Module] WHERE PageID = @PageID AND ModuleName = @ModuleName", cn)) {
					cmd.CommandType = CommandType.Text;
					cmd.Parameters.Add("PageID", SqlDbType.UniqueIdentifier).Value = new Guid(PageID);
					cmd.Parameters.Add("ModuleName", SqlDbType.VarChar, 50);

					foreach (Control c in parent.Controls) {
						if (c.GetType() == typeof(PlaceHolder)) {
							PlaceHolder pl = (PlaceHolder)c;
							if (pl != null) {
								Literal lt = new Literal();
								cmd.Parameters["ModuleName"].Value = pl.ID;
								cmd.Connection.Open();
								SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
								if (dr.HasRows) {
									dr.Read();
									lt.Text = dr["Contents"].ToString();
								}
								cmd.Connection.Close();
								pl.Controls.Add(lt);
							}
						}

						if (c.HasControls())
							LoopTextBoxes(c);
					}
				}
			}
		}
	}
	protected void cmdSearch_Click(object sender, EventArgs e) {
        msds_table.Visible = true;
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
        sb.AppendLine("<tr><td style='padding:10px'>SDS (MSDS) requested:</td><td style='font-weight:bold;padding:10px'>" + PartNumber.Text.Trim() + "</td></tr>");
		sb.AppendLine("</table></div>");
        sb.AppendLine("</body></html>");
        string strBody = sb.ToString();

        MailMessage mm = new MailMessage();
        mm.Subject = "New SDS (MSDS) request from SPEX CertiPrep";
		mm.Bcc.Add(new MailAddress("spexcertiprepmarcom@gmail.com"));
        mm.To.Add(new MailAddress("sheetal.patel@spexcsp.com"));
		mm.To.Add(new MailAddress("crmsales@spex.com"));
        //mm.CC.Add(new MailAddress("peskow@spexcsp.com"));
        mm.CC.Add(new MailAddress("gmiller@spexcsp.com"));
        mm.CC.Add(new MailAddress("crmsales@spexcsp.com"));
        mm.CC.Add(new MailAddress("jmassa@spexcsp.com"));		
		


        mm.From = new MailAddress("contact@spexcsp.com", "SPEX CertiPrep Contact");
        mm.BodyEncoding = System.Text.Encoding.GetEncoding("utf-8");

        AlternateView plainView = AlternateView.CreateAlternateViewFromString(Regex.Replace(strBody, @"<(.|\n)*?>", string.Empty), System.Text.Encoding.GetEncoding("utf-8"), "text/plain");
        AlternateView htmlView = AlternateView.CreateAlternateViewFromString(strBody, System.Text.Encoding.GetEncoding("utf-8"), "text/html");
        mm.AlternateViews.Add(plainView);
        mm.AlternateViews.Add(htmlView);

        SmtpClient smtp = new SmtpClient();


        InsertSubmissionIntoDB();

        smtp.Send(mm);
	
		Session["thankyou-redirect"] = HttpContext.Current.Request.Url.AbsolutePath;
		Response.Redirect("msds_thankyou.aspx");
        mvForm.SetActiveView(vwThank);

    }



    public void InsertSubmissionIntoDB()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString))
        {
            string SQL = "EXEC [cp_InsertContactUsSubmission] 'MSDS', '" + first_name.Text.ToString() + "', '" + last_name.Text.ToString() + "', '" + txtTitle.Text.ToString() + "', '" + company_name.Text.ToString() + "', '" + company_address.Text.ToString() + "', '" + city.Text.ToString() + "', '" + state_region.Text.ToString() + "', '" + zip.Text.ToString() + "', '" + Country.SelectedItem.ToString() + "', '" + phone_number.Text.ToString() + "', '" + email.Text.ToString() + "', '" + PartNumber.Text.ToString() + "'";
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