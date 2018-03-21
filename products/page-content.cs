using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class page_preview : System.Web.UI.Page
{
	public string name = "", title = "";
	public string layout = "";
	public string banner = "";
	public string showtitle = "";
	public string pagecontent1 = "", pagecontent2 = "", pagecontent3 = "";
	public string widgets = "";
	public int page_id = 0;
	
    protected void Page_Load(object sender, EventArgs e) {
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT id FROM cpPages WHERE slug = @slug AND active = '1' AND location = 'products'";

            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@slug", SqlDbType.NVarChar, 50).Value = Page.RouteData.Values["slug"];
                cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					dr.Read();
					page_id = Convert.ToInt32(dr["id"]);
				}
				cmd.Connection.Close();
			}
		}
        
        clsPageContent myContent = new clsPageContent(page_id);

        Page.Title = myContent.PageTitle;
		Page.MetaDescription = myContent.PageDesc;
		name = myContent.PageName;
		banner = myContent.PageBanner;
		layout = myContent.PageLayout;
		showtitle = myContent.ShowTitle;
		
		pagecontent1 = myContent.PageContent1;
		pagecontent2 = myContent.PageContent2;
		pagecontent3 = myContent.PageContent3;
		
		title = myContent.HeaderTitle;
		
		widgets = getWidgets(page_id);
    }
	
	public string getWidgets(int page_id) {
		string output = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT * FROM cpWidgets AS cw INNER JOIN cpPageWidgets AS cpw ON cpw.widget_id = cw.id WHERE cpw.page_id = @page_id";

            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@page_id", SqlDbType.Int).Value = page_id;
                cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				while (dr.Read()) {
					string type = dr["type"].ToString();
					if(type == "news") {
						output += 	"<div>" +
										"<h2 id='updates'>" + dr["name"].ToString() + "</h2>" +
										"<div class='organic-side'>" +
											"<ul>" + 
												getWidgetNews(Convert.ToInt32(dr["category"])) +
											"</ul>" +
										"</div>" +
									"</div>";
					}else if (type == "flyers") {
						output += "<div class='side-module'>" +
										"<h2 id='updates'>" + dr["name"].ToString() + "</h2>" +
										"<div class='organic-side'>" +
											"<ul class='flyers'>" + 
												getWidgetFlyers(Convert.ToInt32(dr["category"])) +
											"</ul>" +
										"</div>" +
									"</div>";
					}else if (type == "image") {
						output += "<img src='/images/page-widgets/" + dr["img"].ToString() + "' /><br />" + dr["content"].ToString();
					}else {
						output += dr["content"].ToString();
					}
				}
                cmd.Connection.Close();
            }
        }
        return output;
	}
	
	protected string getWidgetNews(int cat) {
		string output = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT TOP 6 id, title FROM news WHERE category IN (@cat) AND active = '1' ORDER BY posteddate DESC";

            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@cat", SqlDbType.Int).Value = cat;
                cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					while (dr.Read()) {
						output += "<li><a href='/news-and-events/news.aspx?id=" + dr["id"].ToString() + "'>" + dr["title"].ToString() + "</a></li>";
					}
				}else {
					output += "<li><h3>There are no news stories for this category.</h3></li>";
				}
                cmd.Connection.Close();
            }
        }
        return output;
	}
	
	protected string getWidgetFlyers(int cat) {
		string output = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT * FROM cp_Product_Literature WHERE CategoryID = @cat ORDER BY id DESC";

            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@cat", SqlDbType.Int).Value = cat;
                cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
				while (dr.Read()) {
					output += "<li class='pdf_dl'><a href='/knowledge-base/catalogs/" + dr["LitFile"].ToString() + "' target='_blank'>" + dr["LitName"].ToString() + "</a></li>";
				}
				}else {
					output += "<li><h3>There are no product literature on this category.</h3></li>";
				}
                cmd.Connection.Close();
            }
        }
        return output;
	}
}