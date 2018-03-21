using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;

public partial class about_careers : System.Web.UI.Page
{
	protected string PageID = "";

	protected void Page_Load(object sender, EventArgs e) {
		string PageTitle = "";
		string section = "about-us";
		string detail = "careers";
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

		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT * FROM jobs WHERE active = '1' ORDER BY posteddate DESC";
			int jobnum = 0;
			StringBuilder sb = new StringBuilder();

			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				while (dr.Read()) {
					string JobTitle = dr["title"].ToString().Trim();
					string Location = dr["location"].ToString().Trim();
					string Descript = dr["description"].ToString().Trim();
					string PostedDate = dr["posteddate"].ToString().Trim();

					// Job entry
					sb.AppendLine("<dt><a class='title' href='#' name='job" + jobnum.ToString() + "' id='job" + jobnum.ToString() + "'>" + JobTitle + "</a></dt>");
					sb.AppendLine("<dd class='summary'>");
					sb.AppendLine("<p>Location: " + Location);
					sb.AppendLine("<p>" + Descript + "</p>");
					sb.AppendLine("<a href='mailto:resumes@spexcsp.com?subject=" + JobTitle + "'><img class='middle' style='float: left;' alt='Apply for this position' src='images/SPXcp_careers_apply_for_this_position.jpg' border='0' /></a><img class='middle' alt='' src='/images/SPXcp_rule_519.jpg' />");
					sb.AppendLine("</dd>");
					// end Job Entry

					jobnum++;
				}
				cmd.Connection.Close();

				ltrJobs.Text = sb.ToString();
			}
		}
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
}