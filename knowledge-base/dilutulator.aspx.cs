using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;

public partial class knowledge_dilutilator : System.Web.UI.Page
{
	protected string PageID = "";

	protected void Page_Load(object sender, EventArgs e) {
		((Inside)Master).AllowShareThisIcon=true;
		string PageTitle = "";
		string section = "knowledge-base";
		string detail = "dilutulator";
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
			//Breadcrumb.Text += " &gt; " + PageTitle;
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
}