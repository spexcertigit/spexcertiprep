using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;
using System.Net.Mail;
using System.Text.RegularExpressions;

public partial class _Default : System.Web.UI.Page
{

	public string BannerImageUrl;

	protected string TranslateCategory(string cat) {
		switch (cat) {
			case "1":
				return "CertiPrep General Updates"; 
			case "2":
				return "CertiPrep Newsletters"; 
			case "3":
				return"CertiPrep Press Releases"; 
			case "4":
				return"SamplePrep General Updates"; 
			case "5":
				return "SamplePrep Newsletters"; 
			default:
				return "SamplePrep Press Releases"; 
		}
	}
			
	protected string getYoutube(string youtube) {
		string v = youtube.Replace("https://www.youtube.com/watch?v=", "");
		return v;
	}
			
	protected string GetEndDate(string startDate, string endDate) {
        return startDate != endDate ? " &ndash; " +  endDate : "";
    }

		
    protected void Page_Load(object sender, EventArgs e)
    {
		Page.Title = "Certified Reference Materials - Organic Standards - Inorganic Standards " + ConfigurationSettings.AppSettings["gsDefaultPageTitle"];
			
		//added by ardee		
		lvNews.DataSource = dataNews;
		lvNews.DataBind(); 

		lvFeatured.DataSource = dataFeatured;
		lvFeatured.DataBind(); 
		//

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string toDisplay = "";
            string SQL = "SELECT whichcontent FROM homepage_content WHERE site = 'cp'";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                if (dr.HasRows) {
                    dr.Read();
		            toDisplay = dr["whichcontent"].ToString();
                }
                cmd.Connection.Close();
            }

            //Show Notification Banner
            SQL = "SELECT * FROM Notification_Banner WHERE setFeatured = '1' ORDER BY posteddate DESC";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                if (dr.HasRows) {
                    dr.Read();
					if (dr["thumb"].ToString() == "" || dr["thumb"] == System.DBNull.Value) {
						BannerImageUrl = "";
					}else {
						BannerImageUrl = "<img src='/notification-banner/uploads/"+dr["thumb"].ToString()+"'>";
					}
					/*ltrNotification.Text = "<div class='BannerSection'>" +
												"<div class='BannerImage left'>" +
													BannerImageUrl +
												"</div>" +
												"<div class='BannerDesc left'>" +
													"<div class='descContainer'>" +
														dr["body"].ToString() +
													"</div>" +
												"</div>" +
												"<div style='clear:both'></div>" +
											"</div>";*/
                }else {
					//ltrNotification.Text = "";
				}
                cmd.Connection.Close();
            }
        }

    }
	
	
	public static string getSlides()
	{
		int bOrder = 10, htOrder = 10, hlOrder = 10, ctOrder = 10;
		string headerLogo = "";
		string headerText = "";
		string contentText = "";
		string buttonName = "";
		string buttonImage = "";
		string buttonLink = "";
		string headerLogoStyle = "";
		string headerTextStyle = "";
		string contentTextStyle = "";
		string buttonStyle = "";
		string background = "";
		string slideOutput = "";
		string[] arrSlides = new string[11];
	
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
		string SQL = "SELECT TOP 8 button, button_name, button_link, background, header_logo, header_text, content_text, button_style, header_logo_style, header_text_style, content_text_style, header_logo_order, header_text_order, content_text_order, button_order FROM cp_Slider WHERE activate = 1 ORDER By order_by ASC";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                //SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					while (dr.Read()) {
						bOrder =  Int32.Parse(dr["button_order"].ToString());
						htOrder =  Int32.Parse(dr["header_text_order"].ToString());
						hlOrder = Int32.Parse(dr["header_logo_order"].ToString());
						ctOrder = Int32.Parse(dr["content_text_order"].ToString());
						background = dr["background"].ToString();
						headerLogo = dr["header_logo"].ToString();
						headerText = dr["header_text"].ToString();
						contentText = dr["content_text"].ToString();
						buttonName = dr["button_name"].ToString();
						buttonImage = dr["button"].ToString();
						buttonLink = dr["button_link"].ToString();
						headerLogoStyle = dr["header_logo_style"].ToString();
						headerTextStyle = dr["header_text_style"].ToString();
						contentTextStyle = dr["content_text_style"].ToString();
						buttonStyle = dr["button_style"].ToString();
						arrSlides[0] = "";
						arrSlides[1] = "";
						arrSlides[2] = "";
						arrSlides[3] = "";

						if (headerLogoStyle != "") {
							arrSlides[hlOrder] = "<div id='slideLogo' class='slideLogo' style='" + headerLogoStyle + "'><img class='logo' src='images/banners/" + headerLogo + "' /></div>";
						}else {
							arrSlides[hlOrder] = "";
						}

						if (headerTextStyle != "") {
							arrSlides[htOrder] = "<div id='slideTitle' class='slideTitle' style='" + headerTextStyle + "'>" + headerText + "</div>";
						}else {
							arrSlides[htOrder] = "";
						}

						if (contentTextStyle != "") {
							arrSlides[ctOrder] = "<div id='slideContent' class='slideContent' style='" + contentTextStyle + "'>" + contentText + "</div>";
						}else {
							arrSlides[ctOrder] = "";
						}

						if (buttonStyle != "") {
							arrSlides[bOrder] = "<div id='slideButton' class='slideButton' style='" + buttonStyle + "'><a href='" + buttonLink + "'><div class='" + buttonImage + "'><p class='btnLabel'>" + buttonName + "</p></div></a></div>";
						}else {
							arrSlides[bOrder] = "";
						}

						slideOutput += "<div id='slide' class='slide' style='background:url(images/banners/" + background + ")'>";
						slideOutput += arrSlides[0];
						slideOutput += arrSlides[1];
						slideOutput += arrSlides[2];
						slideOutput += arrSlides[3];
						slideOutput += "</div>";
                    }
				} 
				else {
					cmd.Connection.Close();
				}
				cmd.Connection.Close();
            }
		}
		return slideOutput;
	}	
	
	public string getSlideNav() {
		string slideNav = "";
		int idNum = 1;
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
		string SQL = "SELECT TOP 8 * FROM cp_Slider WHERE activate = 1 ORDER By order_by ASC";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                //SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					while (dr.Read()) {
						slideNav += "<li><p id='" + idNum + "' class='nav-go'></p></li>";
						idNum++;
					}
				}
			}
		}
		return slideNav;
	}
	
	public string Excerpt(string desc) {
		string output = "";
		desc = StripHTML(desc);
		string[] words = desc.Split();
		int wordCount = words.Length;
		if (wordCount > 25) {
			output = string.Join(" ", words.Take(25));
			output = output + "...";
		}else {
			output = desc;
		}
		return output.Trim();
	}
	
	public static string StripHTML(string input)
	{
	   return Regex.Replace(input, "<.*?>", String.Empty);
	}
}