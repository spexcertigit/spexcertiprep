using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;

public partial class knowledge_base_FAQs : System.Web.UI.Page
{
	protected string PageID = "";

	protected void Page_Load(object sender, EventArgs e)
    {
		string PageTitle = "";
		string section = "knowledge-base";
		string detail = "ask-a-chemist";
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
    }
}