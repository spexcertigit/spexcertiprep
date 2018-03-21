using System;
using System.Collections.Generic;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

/// <summary>
/// Summary description for clsPageContent
/// </summary>
public class clsPageContent
{
    private string _PageName = "";
    public string PageName {
        get {
            return _PageName;
        }
    }
	
	private string _HeaderTitle = "";
    public string HeaderTitle {
        get {
            return _HeaderTitle;
        }
    }
	
	private string _PageSlug = "";
    public string PageSlug {
        get {
			return _PageSlug;
        }
    }
	
	private string _PageLocation = "";
    public string PageLocation {
        get {
            if (_PageLocation.Length > 0) {
                return _PageLocation;
            } else {
                return "";
            }
        }
    }
	
	private string _PageLayout = "";
    public string PageLayout {
        get {
			return _PageLayout;
        }
    }
		
	private string _BannerBgColor = "";
	public string BannerBgColor {
        get {
            if (_BannerBgColor.Length > 0) {
                return _BannerBgColor;
            } else {
                return "ffffff";
            }
        }
    }
	
	private string _PageBanner = "";
    public string PageBanner {
        get {
            if (_PageBanner.Length > 0) {
                return "style='background: #" + _BannerBgColor + " url(/images/page-banners/" + _PageBanner +") no-repeat top center;'";
            } else {
                return "";
            }
        }
    }
	
    private string _Excerpt = "";
    public string Excerpt {
        get {
            return _Excerpt;
        }
    }
	
	private string _PageTitle = "";
    public string PageTitle {
        get {
            return _PageTitle;
        }
    }
	
	private string _PageKeys = "";
    public string PageKeys {
        get {
            return _PageKeys;
        }
    }
	
	private string _PageDesc = "";
    public string PageDesc {
        get {
            return _PageDesc;
        }
    }
	
	private string _PageContent1 = "";
    public string PageContent1 {
        get {
            return _PageContent1;
        }
    }
	
	private string _PageContent2 = "";
    public string PageContent2 {
        get {
            return _PageContent2;
        }
    }
	
	private string _PageContent3 = "";
    public string PageContent3 {
        get {
            return _PageContent3;
        }
    }
	
	private string _ShowTitle = "";
    public string ShowTitle {
        get {
            return _ShowTitle;
        }
    }
	
    public clsPageContent(int ID)
	{
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT * FROM cpPages WHERE id = @id";

            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@id", SqlDbType.Int).Value = ID;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows) {
                    dr.Read();
                    _PageName = dr["name"].ToString().Trim();
					_PageSlug = dr["slug"].ToString().Trim();
					_PageLocation = dr["location"].ToString().Trim();
					_PageLayout = dr["layout"].ToString().Trim();
					_PageBanner = dr["banner"].ToString().Trim();
					_Excerpt = dr["excerpt"].ToString().Trim();
					_PageTitle = dr["meta_title"].ToString().Trim();
					_PageKeys = dr["meta_keys"].ToString().Trim();
					_PageDesc = dr["meta_description"].ToString().Trim();
                    _PageContent1 = dr["content1"].ToString().Trim();
					_PageContent2 = dr["content1"].ToString().Trim();
					_PageContent3 = dr["content1"].ToString().Trim();
					_BannerBgColor = dr["banner_bgcolor"].ToString().Trim();
					_HeaderTitle = dr["title"].ToString().Trim();
					_ShowTitle = dr["show_title"].ToString();
                }
                cmd.Connection.Close();
            }
        }
	}
}