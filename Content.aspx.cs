using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Content : BasePage
{
    protected string PageID = "";

    protected void Page_Load(object sender, EventArgs e)
    {
		string PageTitle = "";
		string BasePath = "";
		string section = Page.RouteData.Values["id"].ToString();
		string detail = "";
		string qString = "/cp";
		if (Page.RouteData.Values["id"] == "webinars") {
				Response.Redirect("webinars.aspx");
			}
		if (Request.Url.AbsolutePath.ToLower().StartsWith("/knowledge-base/")) {
			BasePath = "knowledge-base";
			qString += "/" + BasePath;
		}
		qString += "/" + section;
		if (Page.RouteData.Values["detail"] != null) {
			detail = Page.RouteData.Values["detail"].ToString();
			qString += "/" + detail;
		}
		
		//Response.Write("section - " + section + " - detail - " + detail);
		////if (Request.QueryString["id"] == null) { Response.Redirect("/"); }

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

		switch (section.ToLower()) {
			case "news": Breadcrumb.Text = " &gt; News & Events"; break;
		}
		if (PageTitle.Length > 0) {
			switch (BasePath) {
				case "knowledge-base":
					Page.Title = PageTitle + " - Knowledge Base " + Global.TitleSuffixSep + Global.TitleSuffix;
					Breadcrumb.Text += " &gt; Knowledge Base &gt; " + PageTitle;
					break;
				default:
					Page.Title = PageTitle + Global.TitleSuffixSep + Global.TitleSuffix;
					Breadcrumb.Text += " &gt; " + PageTitle;
					break;
			}
		} else {
			Page.Title = Global.TitleSuffix;
		}

		LoopTextBoxes(Page);
		//ltrHighlite.Text = "<script type='text/javascript'>$(function () { $(\"." + detail + " a\").addClass(\"active\");  });</script>";

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