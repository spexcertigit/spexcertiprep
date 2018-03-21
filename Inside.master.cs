using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.UI.HtmlControls;

public partial class Inside : System.Web.UI.MasterPage
{
    protected string regionAltText = "Click to change region";
    protected string theFlag = "us_flag.png";
    protected string SampLink = "";
	protected string countryText = "";

    protected string ProductCountText = "No Items";
    protected int ProductCountNum = 0;	
	protected int TotalProductCountNum = 0;	
    protected double StartingPrice = 0;
    protected string TotalSavings = "";
    protected int SPoints = 0;

    protected bool LoggedIn = false;
    protected string DisplayName = "";
    protected bool isIE6 = false;
    //override on the individual aspx page if page will allow to show share this icon fb. tweeter etc.
    public bool AllowShareThisIcon = false;

    protected void Page_Load(object sender, EventArgs e) {
      

		switch (HttpContext.Current.Request.Url.AbsolutePath) {
			case "/knowledge-base/additional-tools":
				AllowShareThisIcon = true;
				break;
			case "/knowledge-base/posters-presentations":
				 AllowShareThisIcon = true;
				break;
			case "/knowledge-base/appnotes-whitepapers" : 
				AllowShareThisIcon = true;
				break;
			case "/knowledge-base/spex-speaker":
				AllowShareThisIcon = true;
				break;
			case "/knowledge-base/resources":
				AllowShareThisIcon = true;
				break;	
			default:
				break;
		}

        //===========================
        // header Configuration
        //===========================
        //check if user is logged in
        clsUser myUser = new clsUser();
        if (!myUser.LoggedIn) {
            //If user is not logged in
        } else {
            LoggedIn = true;
            DisplayName = myUser.DisplayName;
        }
		
        //Check for IE6
        if (Request.Browser.Browser == "IE" && Request.Browser.MajorVersion == 6) {
            isIE6 = true;
        }

        //Test Clear Cache
        HttpResponse.RemoveOutputCacheItem("/catalog-request.aspx");

		if (Session["region"] == "") {
			HttpCookie certiCookie = new HttpCookie("certiprep");
			Session["region"] = "USA";
			certiCookie.Values["saved_region"] = "USA";
			certiCookie.Expires = DateTime.Now.AddYears(50);
			Response.Cookies.Add(certiCookie);
		}
		if (!Page.IsPostBack) {
			switch (myUser.Region.ToString()) {
				case "UK":
					lblPhoneNumber.Text = "+44 (0) 2082046656";
					theFlag = "uk_flag.png";
					regionAltText = "Region: UK (click to change)";
					countryText = "United Kingdom";
					regionDD.Items.FindByValue("UK").Selected = true;
					break;
				case "USA":
					lblPhoneNumber.Text = "1-800-LAB-SPEX";
					theFlag = "us_flag.png";
					regionAltText = "Region: US (click to change)";
					countryText = "United States";
					regionDD.Items.FindByValue("USA").Selected = true;
					break;
				case "OT":
					lblPhoneNumber.Text = "1-732-549-7144";
					theFlag = "ot_flag.png";
					countryText = "Other";
					regionAltText = "Region: Other (click to change)";
					regionDD.Items.FindByValue("OT").Selected = true;
					break;
				default:
					lblPhoneNumber.Text = "1-732-549-7144";
					theFlag = "ot_flag.png";
					countryText = "Other";
					break;
			}

            if (Request.QueryString["search"] != null) {
                searchbox.Text = Request.QueryString["search"].ToString();
            }
        }
        SampLink = "http://spexsampleprep.com/default.aspx?region=" + myUser.Region;
        //===========================
        // Footer Configuration
        //===========================
        ltrCurrencySymbol5.Text = ltrCurrencySymbol.Text = myUser.CurrencySymbol;

        // shopping cart info
        clsShoppingCart myCart = new clsShoppingCart(myUser.UserID);
        ProductCountText = myCart.ItemCountText;
		ProductCountNum = myCart.ItemCountNum;
		TotalProductCountNum = myCart.TotalItemCountNum;
        myCart.RefreshPrices(myUser.Region, myUser.DiscountCode, myUser.PriceCode, myUser.DiscountAmount);
        StartingPrice = myCart.OrderSubtotal;
        TotalSavings = myUser.CurrencySymbol + myCart.DiscountTotal.ToString("##,##0.00");
		SPoints = myCart.SPoints;

        litCanonical.Text = GetCanonicalUrlTag(new string[2] { "cat","part" });
    }
    //Rel Cano
    public static string GetCanonicalUrlTag(string[] sQueryParameters)
    {
        StringBuilder sQueryString = new StringBuilder();
        if (sQueryParameters.Length > 0)
        {
            sQueryString.Append("?");
            foreach (string sQueryParameter in sQueryParameters)
            {
                if (!string.IsNullOrEmpty(HttpContext.Current.Request.QueryString[sQueryParameter]))
                { // check and make sure the parameter exists in the current url
                    sQueryString.Append("&" + sQueryParameter + "=" + HttpContext.Current.Request.QueryString[sQueryParameter]);
                }
            }
            sQueryString.Replace("?&", "?"); // remove the leading '&'
            if (sQueryString.Length == 1)
            { // no params in current url
                sQueryString.Remove(0, sQueryString.Length);
            }
        }

        Uri uri = new Uri(HttpContext.Current.Request.Url.Scheme + "://" + HttpContext.Current.Request.Url.Host + HttpContext.Current.Request.RawUrl);
        if (uri.Query.Length > 0)        
        {
            uri = new Uri(uri.AbsoluteUri.Replace(uri.Query, string.Empty));
        }
        return "<link rel=\"canonical\" href=\"" + uri.AbsoluteUri + sQueryString.ToString() + "\" />";
    }
    //EOF rel cano
    protected void regionDD_SelectedIndexChanged(object sender, EventArgs e) {
        HttpCookie certiCookie = new HttpCookie("certiprep");
        Session["region"] = regionDD.SelectedValue;
        certiCookie.Values["saved_region"] = regionDD.SelectedValue;
        certiCookie.Expires = DateTime.Now.AddYears(50);
        Response.Cookies.Add(certiCookie);
		string url = HttpContext.Current.Request.Url.AbsoluteUri;
        Response.Redirect(url);
    }
	public string getNotification() {
		 //Show Notification Banner
		 string output = "", BannerImageUrl="";
         string SQL = "SELECT * FROM Notification_Banner WHERE setFeatured = '1' ORDER BY posteddate DESC";
		 using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
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
					
					if (dr["type"].ToString() == "1") {
						output = "<a class='notiBanner' title='" + dr["title"].ToString() + "'>" + BannerImageUrl + "</a>";
					}else {
						output = "<a href='#promo-pop-up' class='promoBanner' title='" + dr["title"].ToString() + "' style='visibility:hidden'></a>";
					}
				}
				cmd.Connection.Close();
			}
		}
		return output;
	}
	protected string getMetatags() {
        StringBuilder sb = new StringBuilder();
		string curr_url = HttpContext.Current.Request.Url.Scheme + "://" + HttpContext.Current.Request.Url.Authority + HttpContext.Current.Request.RawUrl;
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM cp_Meta_Tags WHERE current_page_url LIKE '" + curr_url + "'", cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					dr.Read();
                    sb.AppendLine("<title>" + dr["title_tag"].ToString() + "</title>");
					sb.AppendLine("<meta name=\"Description\" content=\"" + dr["meta_description"].ToString() + "\">");
					sb.AppendLine("<meta name=\"Keywords\" content=\"" + dr["keyword_target"].ToString() + "\">");
                }
                cmd.Connection.Close();
            }
        }
        return sb.ToString();
    }
    protected string GetEquipmentDropdown() {
        StringBuilder sb = new StringBuilder();
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM sp_roi_EquipmentCategories ORDER BY OrderBy", cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read()) {
                    sb.AppendLine("<li><a href='/products_by_category.aspx?cat=" + dr["EquipcatId"].ToString() + "'>" + dr["EquipmentCategory"].ToString() + "</a></li>");
                }
                cmd.Connection.Close();
            }
        }
        return sb.ToString();
    }
    protected void lbEmptyCart_Click(object sender, EventArgs e) {
        clsUser myUser = new clsUser();
        clsShoppingCart myCart = new clsShoppingCart(myUser.UserID);
        myCart.EmptyCart();
        ProductCountText = "No Items";
        StartingPrice = 0;
    }
    protected void lbLogout_Click(object sender, EventArgs e) {
        clsUser myUser = new clsUser();
        myUser.DoLogout();

        Response.Redirect("/");
    }
    protected void searchbutton_Click(object sender, ImageClickEventArgs e) {
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM cp_roi_Prods WHERE cpPart = @part", cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@part", SqlDbType.NVarChar, 100).Value = searchbox.Text.Trim();
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if(dr.HasRows) {
					dr.Read();
					int ptype = Convert.ToInt32(dr["cpType"]);
					if (ptype == 1) {
						Response.Redirect("/products/product_organic.aspx?part=" + searchbox.Text.Trim());
					}else if (ptype == 2) {
						Response.Redirect("/products/product_inorganic.aspx?part=" + searchbox.Text.Trim());
					}else if (ptype == 6) {
						Response.Redirect("/products/product_labstuff.aspx?part=" + searchbox.Text.Trim());
					}
				}
                cmd.Connection.Close();
            }
        }
        if (searchbox.Text.Trim().Length > 0) {
            Response.Redirect("/search.aspx?search=" + Server.UrlEncode(searchbox.Text.Trim()));
        }
    }
    public bool CheckErrors() {
        clsUser myUser = new clsUser();
        if (!myUser.DoLogin(Email.Text.Trim(), login_password.Text.Trim())) {
            errorbox.Visible = true;
            ltrErrorMessage.Text = "Wrong username or password. Please try again.";
            login_container_opacity.Style["display"] = "block";
            string height = HttpContext.Current.Request.Params["clientScreenHeight"];
            mask_layout.Style["display"] = "block";
            mask_layout.Style["height"] = height+"px";
            return false;
        }
        return true;
    }
	protected void cmdLogin_Click(object sender, EventArgs e) {
		string LoginRedirect = HttpContext.Current.Request.Url.AbsolutePath;
		if (Page.IsValid) {
            if (CheckErrors()) {
                string RedirectedFrom = redirect.Value.Trim();
                errorbox.Visible = false;
                ltrErrorMessage.Text = "Wrong username or password. Please try again.";
                if(LoginRedirect == "/register.aspx" && Request.QueryString["redirect"].ToString().ToLower()=="order_summary") {
                    Response.Redirect("/order_summary.aspx");
                } else {
					if (RedirectedFrom.Length == 0) {
                        Response.Redirect(LoginRedirect);
                    } else {
                        if (RedirectedFrom.Contains("?oh=")) {
                            Response.Redirect("/" + RedirectedFrom);
						} else if (RedirectedFrom.Contains("?cc=")) {
							Response.Redirect("/" + RedirectedFrom.Replace("?cc=", ""));
                        } else if (RedirectedFrom.Contains(".aspx")) {
                            Response.Redirect(RedirectedFrom);
                        } else {
                            Response.Redirect("/" + RedirectedFrom + ".aspx");
                        }
					}
                }
            }
        }
	}
}
