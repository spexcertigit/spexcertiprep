using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Services;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class search : System.Web.UI.Page
{
    protected string SearchTerm = "";
	protected string AsIsSearchTerm = "";
	protected string DashedSearchTerm = "";
	protected string NoSpaceSearchTerm = "";
    protected string SearchType = "";
    protected int EquipTypeCount = 0;
    protected int ProductCount = 0;	
    protected int AccessoryCount = 0;
    protected int ProdResCnt = 0;
    protected int FaqCount = 0;

    protected string Region = "US";
    protected string CurrencySymbol = "$";
    protected string CatCode = "1";
	protected string baseURL = "";
    protected clsUser myUser;
	
	protected string prodQuery = "";
	protected string pageQuery = "";
	protected string appQuery = "";
	protected string postQuery = "";
	protected string webQuery = "";
	protected string opQuery = "";
	protected string epaQuery = "";
	protected string newsQuery = "";
	protected string catQuery = "";
	protected bool isCas = false;

    protected void Page_Load(object sender, EventArgs e) {
		
        if (Request.QueryString["search"] != null) {
            AsIsSearchTerm = SearchTerm = Request.QueryString["search"].ToString().Trim();
			DashedSearchTerm = SearchTerm.Replace(" ", "-");
			NoSpaceSearchTerm = SearchTerm.Replace(" ", "");
			NoSpaceSearchTerm = NoSpaceSearchTerm.Replace("-", "");
			
			if (SearchTerm.Contains("-")) {
				SearchTerm = SearchTerm.Replace("-", " ");
			}
            if (SearchTerm.Length > 25) { SearchTerm = SearchTerm.Substring(0, 25); }
        }
		
		if (Request.QueryString["type"] !=null) {
			SearchType = Request.QueryString["type"].ToString().Trim();
		}
		
		string prodQuery = "";
		string pageQuery = "";
		string appQuery = "";
		string postQuery = "";
		string webQuery = "";
		string opQuery = "";
		string epaQuery = "";
		string newsQuery = "";
		string catQuery = "";
	
		string[] tokens = SearchTerm.Split(new[] { " " }, StringSplitOptions.None);
		int ctr = 0;
		int lastItem = tokens.Length - 1;
		
		prodQuery += "REPLACE(cpPart, '-', '') LIKE '" + NoSpaceSearchTerm + "%'";
		
		prodQuery += " OR cpDescrip LIKE '%" + SearchTerm + "%' OR cpLongDescrip LIKE '%" + SearchTerm + "%' OR cpPart LIKE '%"+ SearchTerm +"%'";
		pageQuery += "title_tag LIKE '%" + SearchTerm + "%' OR meta_description LIKE '%" + SearchTerm + "%'";
		appQuery += "title LIKE '%" + SearchTerm + "%' OR abstract LIKE '%" + SearchTerm + "%'";
		postQuery += "title LIKE '%" + SearchTerm + "%' OR abstract LIKE '%" + SearchTerm + "%'";
		webQuery += "title LIKE '%" + SearchTerm + "%' OR abstract LIKE '%" + SearchTerm + "%'";
		opQuery += "title LIKE '%" + SearchTerm + "%' OR filepath LIKE '%" + SearchTerm + "%'";
		epaQuery += "method LIKE '%" + SearchTerm + "%' OR description LIKE '%" + SearchTerm + "%'";
		newsQuery += "title LIKE '%" + SearchTerm + "%' OR body LIKE '%" + SearchTerm + "%'";
		
		
		foreach (string srch in tokens) {
			if (srch != SearchTerm) {
				prodQuery += " OR cpDescrip LIKE '%" + srch + "%' OR cpLongDescrip LIKE '%" + srch + "%'";
				pageQuery += " OR title_tag LIKE '%" + srch + "%' OR meta_description LIKE '%" + srch + "%'";
				appQuery += " OR title LIKE '%" + srch + "%' OR abstract LIKE '%" + srch + "%'";
				postQuery += " OR title LIKE '%" + srch + "%' OR abstract LIKE '%" + srch + "%'";
				webQuery += " OR title LIKE '%" + srch + "%' OR abstract LIKE '%" + srch + "%'";
				opQuery += " OR title LIKE '%" + srch + "%' OR filepath LIKE '%" + srch + "%'";
				epaQuery += " OR method LIKE '%" + srch + "%' OR description LIKE '%" + srch + "%'";
				newsQuery += " OR title LIKE '%" + srch + "%' OR body LIKE '%" + srch + "%'";
			}
		}
		
		string SQL = "";
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			
			using (SqlCommand cmd = new SqlCommand("SELECT * FROM certiComps WHERE cmpCAS = @cas", cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@cas", SqlDbType.NVarChar, 100).Value = AsIsSearchTerm;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if(dr.HasRows) {
					dr.Read();
					isCas = true;
				}
                cmd.Connection.Close();
            }
			
			if (isCas == false) {
				switch (SearchType) {
					case "products":
						SQL = 	"SELECT COUNT(*) AS ctr FROM ( " +
									"SELECT cpPart AS url, " +
										"'[' + cpPart + '] ' + cpDescrip AS title, " +
										"cpLongDescrip AS description, " +
										"'products' AS type " +
									"FROM cp_roi_Prods WHERE (" + prodQuery + ") " +
									"UNION ALL " +
									"SELECT crp.cpPart AS url, crp.cpDescrip AS title, crp.cpLongDescrip AS description, 'products' AS type " +
									"FROM cp_roi_Prods AS crp " +
									"INNER JOIN cp_roi_ProdCats AS crpc ON crpc.cpcProdID = crp.cpPart " +
									"INNER JOIN cp_roi_Cats AS crc ON crpc.cpcCatID = crc.ccID WHERE (crc.ccCategory LIKE '" + AsIsSearchTerm + "%') AND crp.cpPart NOT IN (SELECT cpPart FROM cp_roi_Prods WHERE (" + prodQuery +")) " +
								") a ";
						break;
					case "resources":
						SQL = 	"SELECT COUNT(*) AS ctr FROM (" +
									"SELECT slug AS url, " +
										"title AS title, " +
										"abstract AS description, " +
										"'appnotes' AS type " +
									"FROM cp_KB_Resources WHERE (" + appQuery + ") AND type IN (1, 2) " +
									"UNION ALL " +
									"SELECT slug AS url, " +
										"title AS title, " +
										"abstract AS description, " +
										"'posters' AS type " +
									"FROM cp_KB_Resources WHERE (" + postQuery + ") AND type IN (3, 4) " +
									"UNION ALL " +
									"SELECT slug AS url, title AS title, abstract AS description, 'webinars' AS type FROM cpWebinar WHERE (" + webQuery + ") " + 
									"UNION ALL " +
									"SELECT filepath AS url, title AS title, '' AS description, 'optimize' AS type FROM cp_optimize_issue WHERE (" + opQuery + ")" + 
								") a ";
						break;
					case "methods":
						SQL = "SELECT COUNT(*) AS ctr FROM certiPesticidesMethods WHERE (" + epaQuery + ")";
						break;
					case "news":
						SQL = "SELECT COUNT(*) AS ctr FROM news WHERE (" + newsQuery + ") AND category IN ('1','2','3','7','8') AND active = '1'";
						break;
					default:
						SQL = 	"SELECT COUNT(*) AS ctr FROM (" + 
									"SELECT 'products' AS type FROM cp_roi_Prods WHERE (" + prodQuery + ") " +
									"UNION ALL " +
									"SELECT 'products' AS type " +
									"FROM cp_roi_Prods AS crp " +
									"INNER JOIN cp_roi_ProdCats AS crpc ON crpc.cpcProdID = crp.cpPart " +
									"INNER JOIN cp_roi_Cats AS crc ON crpc.cpcCatID = crc.ccID WHERE (crc.ccCategory LIKE '" + AsIsSearchTerm + "%') AND crp.cpPart NOT IN (SELECT cpPart FROM cp_roi_Prods WHERE (" + prodQuery +")) " +
									"UNION ALL " +
									"SELECT 'pages' AS type FROM cp_Meta_Tags WHERE (" + pageQuery + ") " +
									"UNION ALL " +
									"SELECT 'appnotes' AS type FROM cp_KB_Resources WHERE (" + appQuery + ") AND type IN (1, 2) " +
									"UNION ALL " +
									"SELECT 'posters' AS type FROM cp_KB_Resources WHERE (" + postQuery + ") AND type IN (3, 4) " +
									"UNION ALL " +
									"SELECT 'webinars' AS type FROM cpWebinar WHERE (" + webQuery + ") " +
									"UNION ALL " +
									"SELECT 'optimize' AS type FROM cp_optimize_issue WHERE (" + opQuery + ") " + 
									"UNION ALL " +
									"SELECT 'epa' AS type FROM certiPesticidesMethods WHERE (" + epaQuery + ") " +
									"UNION ALL " +
									"SELECT 'news' AS type FROM news WHERE (" + newsQuery + ") AND category IN ('1','2','3','7','8') AND active = '1') a";
						break;
				}
				using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
					cmd.CommandType = CommandType.Text;
					cmd.CommandTimeout = 60;
					cmd.Parameters.Add("@Query", SqlDbType.NVarChar, 100).Value = "%" + SearchTerm + "%";
					cmd.Connection.Open();
					SqlDataReader dr = cmd.ExecuteReader();
					int count = 0;//(int)cmd.ExecuteScalar();
					if (dr.HasRows) {
						dr.Read();
						count = Convert.ToInt32(dr["ctr"]);
					}
					resCount.Text = count.ToString("##,###,##0");
					cmd.Connection.Close();
				}
			}else {
				SQL = "SELECT COUNT(*) AS ctr FROM certiProdComps AS cpc INNER JOIN certiComps AS cc ON cpc.cpmpCompID = cc.cmpID WHERE cc.cmpCAS = @cas";
				using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
					cmd.CommandType = CommandType.Text;
					cmd.CommandTimeout = 60;
					cmd.Parameters.Add("@cas", SqlDbType.NVarChar, 100).Value = AsIsSearchTerm;
					cmd.Connection.Open();
					SqlDataReader dr = cmd.ExecuteReader();
					int count = 0;//(int)cmd.ExecuteScalar();
					if (dr.HasRows) {
						dr.Read();
						count = Convert.ToInt32(dr["ctr"]);
					}
					resCount.Text = count.ToString("##,###,##0");
					cmd.Connection.Close();
				}
			}
        }

        if (!Page.IsPostBack) {
            SetQuery();
			baseURL = Request.Url.Scheme + "://" + Request.Url.Authority + Request.ApplicationPath.TrimEnd('/') + "/";
        }
    }
   
    private void SetQuery() {
		string SQL = "";
		SearchType = "";
		if (Request.QueryString["search"] != null) {
            AsIsSearchTerm = SearchTerm = Request.QueryString["search"].ToString().Trim();
			DashedSearchTerm = SearchTerm.Replace(" ", "-");
			NoSpaceSearchTerm = SearchTerm.Replace(" ", "");
			NoSpaceSearchTerm = NoSpaceSearchTerm.Replace("-", "");
			if (SearchTerm.Contains("-")) {
				SearchTerm = SearchTerm.Replace("-", " ");
			}
            if (SearchTerm.Length > 25) { SearchTerm = SearchTerm.Substring(0, 25); }
        }
		if (Request.QueryString["type"] !=null) {
			SearchType = Request.QueryString["type"].ToString();
		}
		
		if (isCas == false) {
			string[] tokens = SearchTerm.Split(new[] { " " }, StringSplitOptions.None);
			int ctr = 0;
			int lastItem = tokens.Length - 1;
			
			prodQuery += "REPLACE(cpPart, '-', '') LIKE '" + NoSpaceSearchTerm + "%'";
			
			prodQuery += " OR cpDescrip LIKE '%" + SearchTerm + "%' OR cpLongDescrip LIKE '%" + SearchTerm + "%' OR cpPart LIKE '%"+ SearchTerm +"%'";
			pageQuery += "title_tag LIKE '%" + SearchTerm + "%' OR meta_description LIKE '%" + SearchTerm + "%'";
			appQuery += "title LIKE '%" + SearchTerm + "%' OR abstract LIKE '%" + SearchTerm + "%'";
			postQuery += "title LIKE '%" + SearchTerm + "%' OR abstract LIKE '%" + SearchTerm + "%'";
			webQuery += "title LIKE '%" + SearchTerm + "%' OR abstract LIKE '%" + SearchTerm + "%'";
			opQuery += "title LIKE '%" + SearchTerm + "%' OR filepath LIKE '%" + SearchTerm + "%'";
			epaQuery += "method LIKE '%" + SearchTerm + "%' OR description LIKE '%" + SearchTerm + "%'";
			newsQuery += "title LIKE '%" + SearchTerm + "%' OR body LIKE '%" + SearchTerm + "%'";
			
			foreach (string srch in tokens) {
				if (srch != SearchTerm) {
					prodQuery += " OR cpDescrip LIKE '%" + srch + "%' OR cpLongDescrip LIKE '%" + srch + "%'";
					pageQuery += " OR title_tag LIKE '%" + srch + "%' OR meta_description LIKE '%" + srch + "%'";
					appQuery += " OR title LIKE '%" + srch + "%' OR abstract LIKE '%" + srch + "%'";
					postQuery += " OR title LIKE '%" + srch + "%' OR abstract LIKE '%" + srch + "%'";
					webQuery += " OR title LIKE '%" + srch + "%' OR abstract LIKE '%" + srch + "%'";
					opQuery += " OR title LIKE '%" + srch + "%' OR filepath LIKE '%" + srch + "%'";
					epaQuery += " OR method LIKE '%" + srch + "%' OR description LIKE '%" + srch + "%'";
					newsQuery += " OR title LIKE '%" + srch + "%' OR body LIKE '%" + srch + "%'";
				}
			}
			
			switch (SearchType) {
				case "products":
					SQL = 	"SELECT a.* FROM (" +
								"SELECT cpPart AS url, " +
									"'[' + cpPart + '] ' + cpDescrip AS title, " +
									"cpLongDescrip AS description, " +
									"'products' AS type " +
								"FROM cp_roi_Prods WHERE (" + prodQuery + ") " +
								"UNION ALL " +
								"SELECT crp.cpPart AS url, crp.cpDescrip AS title, crp.cpLongDescrip AS description, 'products' AS type " +
								"FROM cp_roi_Prods AS crp " +
								"INNER JOIN cp_roi_ProdCats AS crpc ON crpc.cpcProdID = crp.cpPart " +
								"INNER JOIN cp_roi_Cats AS crc ON crpc.cpcCatID = crc.ccID WHERE (crc.ccCategory LIKE '" + AsIsSearchTerm + "%') AND crp.cpPart NOT IN (SELECT cpPart FROM cp_roi_Prods WHERE (" + prodQuery +")) " +
							") a " +	
							"ORDER BY CASE " +
								"WHEN CAST(url AS NVARCHAR(MAX)) LIKE '" + DashedSearchTerm + "%' OR CAST(title AS NVARCHAR(MAX)) LIKE '" + DashedSearchTerm + "%' THEN 1 " +
								"WHEN CAST(title AS NVARCHAR(MAX)) LIKE '" + SearchTerm + "%' THEN 2 " +
								"WHEN CAST(title AS NVARCHAR(MAX)) LIKE '%" + SearchTerm + "%' THEN 3 " +
								"WHEN CAST(description AS NVARCHAR(MAX)) LIKE '%" + SearchTerm + "%' THEN 4 " +
								"ELSE 5 " +
							"END";
					break;
				case "resources":
					SQL = 	"SELECT a.* FROM (" +
								"SELECT itemfile AS url, " +
									"title AS title, " +
									"abstract AS description, " +
									"'appnotes' AS type " +
								"FROM cp_KB_Resources WHERE (" + appQuery + ") AND type IN (1, 2) " +
								"UNION ALL " +
								"SELECT itemfile AS url, " +
									"title AS title, " +
									"abstract AS description, " +
									"'posters' AS type " +
								"FROM cp_KB_Resources WHERE (" + postQuery + ") AND type IN (3, 4) " +
								"UNION ALL " +
								"SELECT slug AS url, title AS title, abstract AS description, 'webinars' AS type FROM cpWebinar WHERE (" + webQuery + ") " + 
								"UNION ALL " +
								"SELECT filepath AS url, title AS title, '' AS description, 'optimize' AS type FROM cp_optimize_issue WHERE (" + opQuery + ") " + 
							") a " +
							"ORDER BY CASE " +
								"WHEN CAST(a.title AS NVARCHAR(MAX)) LIKE '" + SearchTerm + "%' THEN 1 " +
								"WHEN CAST(a.title AS NVARCHAR(MAX)) LIKE '%" + SearchTerm + "%' THEN 2 " +
								"WHEN CAST(a.description AS NVARCHAR(MAX)) LIKE '%" + SearchTerm + "%' THEN 2 " +
								"ELSE 4 " +
							"END";
					break;
				case "methods":
					SQL = "SELECT slug AS url, method AS title, description AS description, 'epa' AS type FROM certiPesticidesMethods WHERE (" + epaQuery + ")";
					break;
				case "news":
					SQL = "SELECT CAST(id AS NVARCHAR(MAX)) AS url, CAST(title COLLATE Latin1_General_CI_AS AS NVARCHAR(MAX)) AS title, body AS description, 'news' AS type FROM news WHERE (" + newsQuery + ") AND category IN ('1','2','3','7','8') AND active = '1' ORDER BY posteddate DESC";
					break;
				default:
					SQL = 	"SELECT a.* FROM (" + 
								"SELECT cpPart AS url, '[' + cpPart + '] ' + cpDescrip AS title, cpLongDescrip AS description, 'products' AS type FROM cp_roi_Prods WHERE (" + prodQuery + ") " +
								"UNION ALL " +
								"SELECT crp.cpPart AS url, crp.cpDescrip AS title, crp.cpLongDescrip AS description, 'products' AS type " +
								"FROM cp_roi_Prods AS crp " +
								"INNER JOIN cp_roi_ProdCats AS crpc ON crpc.cpcProdID = crp.cpPart " +
								"INNER JOIN cp_roi_Cats AS crc ON crpc.cpcCatID = crc.ccID WHERE (crc.ccCategory LIKE '" + AsIsSearchTerm + "%') " +
								"UNION ALL " +
								"SELECT current_page_url AS url, title_tag AS title, meta_description AS description, 'pages' AS type FROM cp_Meta_Tags WHERE (" + pageQuery + ") " +
								"UNION ALL " +
								"SELECT itemfile AS url, title AS title, abstract AS description, 'appnotes' AS type FROM cp_KB_Resources WHERE (" + appQuery + ") AND type IN (1, 2) " +
								"UNION ALL " +
								"SELECT itemfile AS url, title AS title, abstract AS description, 'posters' AS type FROM cp_KB_Resources WHERE (" + postQuery + ") AND type IN (3, 4) " +
								"UNION ALL " +
								"SELECT slug AS url, title AS title, abstract AS description, 'webinars' AS type FROM cpWebinar WHERE (" + webQuery + ") " +
								"UNION ALL " +
								"SELECT filepath AS url, title AS title, '' AS description, 'optimize' AS type FROM cp_optimize_issue WHERE (" + opQuery + ") " + 
								"UNION ALL " +
								"SELECT slug AS url, method AS title, description AS description, 'epa' AS type FROM certiPesticidesMethods WHERE (" + epaQuery + ") " + 
								"UNION ALL " +
								"SELECT CAST(id AS NVARCHAR(MAX)) AS url, CAST(title COLLATE Latin1_General_CI_AS AS NVARCHAR(MAX)) AS title, body AS description, 'news' AS type FROM news WHERE (" + newsQuery + ") AND category IN ('1','2','3','7','8') AND active = '1') a " +
								"ORDER BY CASE " +
									"WHEN CAST(a.url AS NVARCHAR(MAX)) LIKE '" + DashedSearchTerm + "%' AND type = 'products' OR CAST(a.title AS NVARCHAR(MAX)) LIKE '" + DashedSearchTerm + "%' THEN 1 " +
									"WHEN CAST(a.title AS NVARCHAR(MAX)) LIKE '" + SearchTerm + "%' THEN 2 " +
									"WHEN CAST(a.title AS NVARCHAR(MAX)) LIKE '%" + SearchTerm + "%' THEN 3 " +
									"WHEN CAST(a.description AS NVARCHAR(MAX)) LIKE '%" + SearchTerm + "%' THEN 4 " +
									"ELSE 5 " +
								"END";
					break;
			}
		}else {
			SQL = "SELECT cpPart AS url, cpDescrip AS title, cpLongDescrip AS description, 'products' AS type FROM cp_roi_Prods AS crp INNER JOIN certiProdComps cpc ON cpc.cpmpProd = crp.cpPart INNER JOIN certiComps AS cc ON cpc.cpmpCompID = cc.cmpID WHERE cc.cmpCAS = '" + AsIsSearchTerm + "' ORDER BY cc.cmpID DESC";
		}
		//Response.Write("<script>console.log('" + prodQuery +"')</script>");
        dataResults.SelectCommand = SQL;
        dataResults.DataBind();
    }
	
	protected void dataResults_Selecting(object sender, SqlDataSourceSelectingEventArgs e) {
		e.Command.CommandTimeout = 60;  //or more time....
	}
	
	public string getURL(string part) {
		string output = "";
		string SQL = "";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			SQL = 	"SELECT cpType FROM cp_roi_Prods WHERE cpPart = @part";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("part", SqlDbType.NVarChar, 50).Value = part;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					dr.Read();
					string type = dr["cpType"].ToString();
					if (type == "1") {
						output = baseURL + "products/product_organic.aspx?part=" + part;
					}else if (type == "2") {
						output = baseURL + "products/product_inorganic.aspx?part=" + part;
					}else if (type == "6") {
						output =  baseURL + "products/product_labstuff.aspx?part=" + part;
					}
				}
				cmd.Connection.Close();
            }
		}
		
		return output;
	}
	
	public string getIcon(string type, string part) {
		string icon = "";
		switch(type) {
			case "products":
				using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
					string SQL = "SELECT typeImg FROM certiBottleType WHERE partNum = @part";
					using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
						cmd.CommandType = CommandType.Text;
						cmd.Parameters.Add("part", SqlDbType.NVarChar, 50).Value = part;
						cmd.Connection.Open();
						SqlDataReader dr = cmd.ExecuteReader();
						if (dr.HasRows) {
							dr.Read();
							string img = dr["typeImg"].ToString();
							icon = "<img src='/images/" + img + "' />";
						}
						cmd.Connection.Close();
					}
				}
				break;
			case "pages":
				icon = "<i class='fa fa-files-o'></i>";
				break;
			case "appnotes":
				icon = "<i class='fa fa-file-pdf-o'></i>";
				break;
			case "posters":
				icon = "<i class='fa fa-file-pdf-o'></i>";
				break;
			case "webinars":
				icon = "<i class='fa fa-youtube-play'></i>";
				break;
			case "optimize":
				icon = "<i class='fa fa-file-pdf-o'></i>";
				break;
			case "epa":
				icon = "<i class='fa fa-pencil-square-o'></i>";
				break;
			case "news":
				icon = "<i class='fa fa-newspaper-o'></i>";
				break;
		}
		
		return icon;
	}
	
	protected void dataResults_Selected(object sender, SqlDataSourceStatusEventArgs e) {
        ProductCount = e.AffectedRows;
        ProductListPagerSimple.Visible = (ProductCount > ProductListPagerSimple.PageSize);
    }
	
	protected void lbResults_Change(object sender, EventArgs e) {
		int pages = Int32.Parse(lbResults.SelectedValue);
        ProductListPagerSimple.PageSize = pages;
        SetQuery();
        lvResults.DataBind();
    }
}