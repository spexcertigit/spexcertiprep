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

public partial class search_organic_category : System.Web.UI.Page
{
    protected string sTitle = "";
    protected int ProductCount = 0;
    protected string Region = "US";
    protected string CurrencySymbol = "$";
    protected string CatCode = "1";
	protected string sDesc = "";
    protected clsUser myUser;

    protected void Page_Load(object sender, EventArgs e)
    {	
		if(ProductListPagerSimple != null){
		//	TestLabel.Text=ProductListPagerSimple2.Controls[2].Controls[0];
		}
		else{
		//	TestLabel.Text="NOT HERE!";
		}
        //dim CatCode
        if (Page.RouteData.Values["cat"] == null) { Response.Redirect("/products/organic"); }
        int SearchTerm = 0;
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT CatID FROM cp_roi_AnTechs WHERE slug=@slug";

            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@slug", SqlDbType.NVarChar).Value = Page.RouteData.Values["cat"].ToString();
                cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					dr.Read();
					SearchTerm = Convert.ToInt32(dr["CatID"]);
				}
                cmd.Connection.Close();
			}
		}
		if (SearchTerm == 0) { Response.Redirect("/products/organic"); }
		
        myUser = new clsUser();
        Region = myUser.Region;
        CurrencySymbol = myUser.CurrencySymbol;
        CatCode = myUser.DiscountCode;

        switch (SearchTerm) {
			case 1:
                sTitle = "GC/MS Standards";
				sDesc = "Gas Chromatography (GC) and Mass Spectrometry (MS) make an effective combination for chemical analysis. SPEX CertiPrep provides over 3,500 GC/MS standards well-suited for a variety of applications.";
                break;
            case 2:
                sTitle = "Gas Chromatography Standards";
				sDesc = "Gas Chromatography (GC) is one of the most frequently used analytical techniques. SPEX CertiPrep provides over 3,500 GC standards well-suited for a variety of applications.";
                break;       
            case 3:
                sTitle = "Liquid Chromatography Standards";
				sDesc = "SPEX CertiPrep creates single and multi-component standards suitable for all LC detectors. Our LC products are used for identification and quantification of compounds in a variety of fields from agriculture to manufacturing uses.";
                break;
            case 4:
                sTitle = "LC/MS Standards";
				sDesc = "SPEX CertiPrep&#39;s LC/MS single and multi-component standards are created to reduce potential interference and increase analytical accuracy. Our LC/MS products are used for identification and quantification of compounds in a variety of fields from agriculture to manufacturing uses.";
                break;
			 case 5:
                sTitle = "Consumer Safety Standards";
				sDesc = "";
                break;
				
			case 6:
                sTitle = "Semivolatiles";
				sDesc = "";
                break;
				
			 case 7:
                sTitle = "Volatiles";
				sDesc = "";
                break;
        }

        if (!Page.IsPostBack) {
            //Select the right item from the Technique dropdown
            technique.Items.Clear();
            technique.Items.Add(new ListItem("-- Select Technique --", "0"));
            technique.DataBind();
            ListItem li = technique.Items.FindByValue(Page.RouteData.Values["cat"].ToString());
            if (li != null) { li.Selected = true; }

            //Select the right item from the Application dropdown
			if (Page.RouteData.Values["family"] != null) {
				family.DataBind();
				li = family.Items.FindByValue(Page.RouteData.Values["family"].ToString());
				if (li != null) { li.Selected = true; }
			}

            //Select the right item from the Method dropdown
            int selectedMethod = 0;
            if (Request.QueryString["method"] != null) {
                Int32.TryParse(Request.QueryString["method"].ToString(), out selectedMethod);
                if (selectedMethod > 0) {
                    s_method.DataBind();
                    li = s_method.Items.FindByValue(selectedMethod.ToString());
                    if (li != null) { li.Selected = true; }
                }
            }

			Page.Title = sTitle + " - Organic Standards" + ConfigurationSettings.AppSettings["gsDefaultPageTitle"];

            SetQuery();
        }
    }
	
	protected void DataPager_Init(object sender, EventArgs e)
    {
        var dp = sender as DataPager;
        if (dp == null)
        {
            throw new Exception("This Event handler only works for DataPager web controls.");
        }

        string strPageNum = Request.QueryString[dp.QueryStringField];
        if (strPageNum == null) return;  // param not there, DataPager will use default

        int pageNum = -1;
        if (int.TryParse(strPageNum, out pageNum) && pageNum > 0)
        {
            return; // valid page number parameter, let DataPager handle it
        }


        dp.QueryStringField = null; // Force default
    }
	
    protected string GetCAS(string PartNumber) {
        string CAS = "";

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT count(*) " +
                         "   FROM certiProdComps " +
                         "   WHERE cpmpProd = @partnumber";

            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@partnumber", SqlDbType.VarChar, 21).Value = PartNumber;
                cmd.Connection.Open();
                int CASCount = (int)cmd.ExecuteScalar();
                cmd.Connection.Close();

                if (CASCount > 1) {
                    CAS = "Various";
                } else if (CASCount == 1) {
                    cmd.CommandText = "SELECT c.cmpCAS " +
                                      "  FROM certiProdComps pc JOIN certiComps c ON pc.cpmpCompID = c.cmpID " +
                                      "  WHERE pc.cpmpProd = @partNumber";
					cmd.Connection.Open();
					SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
					if (dr.HasRows) {
						dr.Read();
						CAS = dr[0].ToString();
					}
					cmd.Connection.Close();
				}
            }
        }
        return CAS;
    }
    protected string GetConcentration(string PartNumber) {
        string conc = "";

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT DISTINCT CONVERT(varchar(20), cpc.cpmpConc) + ' ' + cu.cuUnit AS conc " +
							  "  FROM certiProdComps cpc JOIN certiComps AS cc ON cpc.cpmpCompID = cc.cmpID " +
							  "      JOIN certiUnits AS cu ON cpc.cpmpUnits = cu.cuID " +
							  "  WHERE cpc.cpmpConc IS NOT NULL AND cpc.cpmpProd = @partnumber";

            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@partnumber", SqlDbType.VarChar, 21).Value = PartNumber;
                cmd.Connection.Open();

				SqlDataReader dr = cmd.ExecuteReader();

				if (dr.HasRows) {
					dr.Read();
					conc = dr["conc"].ToString();
					if (dr.Read()) {
						conc = "Various";
					}
				}
				cmd.Connection.Close();
			}
        }
        return conc;
    }
    protected string GetPrice(string PartNumber) {
        clsItemPrice price = new clsItemPrice(PartNumber, myUser);
        return price.PriceText;
    }
    protected string GetMethod(string PartNumber) {
        string method = "";

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT count(*) " +
                         "   FROM cp_roi_ProdMeths " +
                         "   WHERE cpmProdID = @partnumber";

            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@partnumber", SqlDbType.VarChar, 21).Value = PartNumber;
                cmd.Connection.Open();
                int MethodCount = (int)cmd.ExecuteScalar();
                cmd.Connection.Close();

                if (MethodCount > 1) {
                    method = "Various";
                } else if (MethodCount == 1) {
		            cmd.CommandText = "SELECT m.cmName " +
 		                              "  FROM cp_roi_ProdMeths pm JOIN cp_roi_Methods m ON pm.cpmMethID = m.cmID " +
		                              "  WHERE pm.cpmProdID = @partNumber";
                    cmd.Connection.Open();
					SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
					if (dr.HasRows) {
						dr.Read();
						method = dr[0].ToString();
					}
                    cmd.Connection.Close();
                }
            }
        }
        return method;
    }
    protected void dataProducts_Selected(object sender, SqlDataSourceStatusEventArgs e) {
        ProductCount = e.AffectedRows;
        ProductListPagerSimple.Visible = ProductListPagerSimple2.Visible = (ProductCount > ProductListPagerSimple.PageSize);
		ProductListMobilePager.Visible = (ProductCount > ProductListMobilePager.PageSize);	
    }

    private void SetQuery() {
        string SearchTerm = Page.RouteData.Values["cat"].ToString();
        int selectedFamily = 0;
        if (Page.RouteData.Values["family"] != null) {
            Int32.TryParse(getFamilyID(Page.RouteData.Values["family"].ToString()), out selectedFamily);
        }
        int selectedMethod = 0;
        if (Request.QueryString["method"] != null) {
            Int32.TryParse(Request.QueryString["method"].ToString(), out selectedMethod);
        }

        string SQL = "SELECT DISTINCT cp.cpPart AS PartNumber, " +
                     "       cp.cpDescrip AS Title,  " +
                     "       cv.cpvVolume AS Volume, " +
                     "       cp.cpUnitCnt AS UnitPack, " +
                     "       mat.T542_Sub_Short AS Matrix, " +
                     "       0 AS Price " +
                     "   FROM  cp_roi_Prods cp LEFT JOIN cp_roi_ProdATs cpats ON cp.cpPart = cpats.cpatProdId " +
                     "       LEFT JOIN cp_roi_AnTechs at ON cpats.cpatATID = at.CatID " +
                     "       LEFT JOIN cp_roi_Volumes AS cv ON CP.Cpvol = cv.cpvID " +
                     "       LEFT JOIN cp_roi_Matrix AS mat ON mat.T542_Code = cp.cpMatrix ";
        if (selectedFamily > 0) {
            SQL += " LEFT JOIN cp_roi_ProdFamilies AS cpf ON cp.cpID = cpf.cpfID ";
        }
        if (selectedMethod > 0) {
            SQL += " LEFT JOIN cp_roi_ProdMeths AS pm ON pm.cpmProdID = cp.cpPart ";
        }
        SQL += "   WHERE at.slug = '" + SearchTerm + "' " +
                     "   AND cp.cpType = 1 " +
                     "   AND cp.For_Web = 'Y' ";
		if (SearchTerm == "4") {
			SQL += " AND cp.cpPart LIKE 'LC%' ";
		}
					 
        if (selectedFamily > 0) {
            SQL += " AND cpf.cpffamID = " + selectedFamily.ToString() + " ";
        }
        if (selectedMethod > 0) {
            SQL += " AND pm.cpmMethID = " + selectedMethod.ToString() + " ";
        }
        SQL += " ORDER BY cp.cpPart";

        dataProducts.SelectCommand = SQL;
        dataProducts.DataBind();
    }

	/*[WebMethod()]
	[ScriptMethod(UseHttpGet=false)]
	public static string GetDataMethod(string partnumber)
	{
		string MethodUL = "";
		string Method = "";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
		 //Get the all methods descriptions associated with this product
            string SQL = "SELECT m.cmSource + '  ' + m.cmName,  m.cmDesc " +
 	              "    FROM cp_roi_Prods p JOIN  cp_roi_ProdMeths pm ON p.cpPart = pm.cpmProdID " + 
                  "    INNER JOIN cp_roi_Methods m ON pm.cpmMethID = m.cmID " +
                  "    WHERE p.cpPart = @partNumber " +
				  "    AND m.cmDesc is not null ORDER BY m.cmName";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@partnumber", SqlDbType.VarChar).Value = partnumber;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows) {

					  MethodUL = "<UL>";
                    while (dr.Read()) {
						Method += dr[0].ToString() + ", ";
		                MethodUL += "<LI>" + dr[0].ToString() + ": " + dr[1].ToString() + "</LI>";
                    }
					if (Method.Length > 2) { Method = Method.Substring(0, Method.Length - 2); }
                   MethodUL += "</UL>";
                }
                cmd.Connection.Close();
            }

			if (MethodUL.Length > 0) {
				MethodUL = "<h1>Method Reference</h1>" + MethodUL + "";
			}
		}
		return MethodUL;
		
	}*/
	
	
	[WebMethod()]
	//[ScriptMethod(UseHttpGet=false)]
	public static string infomethodor(string partnumber)
	{
		string MethodUL = "";
		string Method = "";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
		 //Get the all methods descriptions associated with this product
            string SQL = "SELECT m.cmSource + '  ' + m.cmName,  m.cmDesc " +
 	              "    FROM cp_roi_Prods p JOIN  cp_roi_ProdMeths pm ON p.cpPart = pm.cpmProdID " + 
                  "    INNER JOIN cp_roi_Methods m ON pm.cpmMethID = m.cmID " +
                  "    WHERE p.cpPart = @partNumber " +
				  "    AND m.cmDesc is not null ORDER BY m.cmName";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@partnumber", SqlDbType.VarChar).Value = partnumber;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows) {

					  MethodUL = "<UL>";
                    while (dr.Read()) {
						Method += dr[0].ToString() + ", ";
		                MethodUL += "<LI>" + dr[0].ToString() + ": " + dr[1].ToString() + "</LI>";
                    }
					if (Method.Length > 2) { Method = Method.Substring(0, Method.Length - 2); }
                   MethodUL += "</UL>";
                }
                cmd.Connection.Close();
            }

			if (MethodUL.Length > 0) {
				MethodUL = "<h1>Method Reference</h1>" + MethodUL + "";
			}
		}
		return MethodUL;
		
	}
	
	

	[WebMethod()]
	public static string GetDataCAS(string partnumber)
	{
		string Concentration = "";
		string Component = "";
		string Unit = "";
		string CAS = "";
		string CAStable = "";
		string CasClass = "";
		int ctr = 0;
	
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
		string SQL = "SELECT CAST(cpc.cpmpConc AS varchar(10)) AS cpmpConc, " +
						"		cc.cmpComp, " +
						"		cu.cuUnit, " +
						"		cc.cmpCAS AS CAS " +
						"	FROM certiProdComps AS cpc JOIN certiComps AS cc ON cpc.cpmpCompID = cc.cmpID " + 
						"		JOIN cp_roi_Prods AS cp ON cpc.cpmpProd = cp.cpPart " + 
						"		JOIN certiUnits AS cu ON cpc.cpmpUnits = cu.cuID " +
						"	WHERE cpc.cpmpConc IS NOT NULL AND cpc.cpmpProd = @partnumber " +
						"	ORDER BY cpc.cpmpConc DESC, cc.cmpComp";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@partnumber", SqlDbType.VarChar).Value = partnumber;
                cmd.Connection.Open();
                //SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					CAStable = "<tbody>";
					while (dr.Read()) {
						ctr++;
						
						Concentration = dr["cpmpConc"].ToString();
						Component = dr["cmpComp"].ToString();
						Unit = dr["cuUnit"].ToString();
						CAS = dr["CAS"].ToString();
						
						CasClass = ctr%2 == 0 ? " " : "class='odd'";
						
						CAStable += "<tr "+ CasClass +">";
						CAStable += "<td class='desc'>" + Component + "</td>";
						CAStable += "<td class='desc'>" + CAS + "</td>";
						CAStable += "<td class='desc'>" + Concentration + " " + Unit + "</td>";
						CAStable += "</tr>";
                    }
					CAStable += "</tbody>";
				} 
				else {
					cmd.Connection.Close();
				}
				cmd.Connection.Close();
            }
			
			CAStable = "<table id='productdata_table'>"+
					"	<thead>"+
					"		<tr class='odd'>"+
					"			<th style='width:35%;' scope='col'>Components</th>"+
					"			<th style='width:20%;' scope='col'>CAS#</th>"+
					"			<th style='width:15%;' scope='col'>Concentration</th>"+
					"		</tr>"+
					"	</thead> "+ 
							CAStable + 
					"	</table>";
		}
		return CAStable;
	}
	
	[WebMethod()]
	public static string infoor(string partnumber)
	{
		string Concentration = "";
		string Component = "";
		string Unit = "";
		string CAS = "";
		string CAStable = "";
		string CasClass = "";
		int ctr = 0;
	
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
		string SQL = "SELECT CAST(cpc.cpmpConc AS varchar(10)) AS cpmpConc, " +
						"		cc.cmpComp, " +
						"		cu.cuUnit, " +
						"		cc.cmpCAS AS CAS " +
						"	FROM certiProdComps AS cpc JOIN certiComps AS cc ON cpc.cpmpCompID = cc.cmpID " + 
						"		JOIN cp_roi_Prods AS cp ON cpc.cpmpProd = cp.cpPart " + 
						"		JOIN certiUnits AS cu ON cpc.cpmpUnits = cu.cuID " +
						"	WHERE cpc.cpmpConc IS NOT NULL AND cpc.cpmpProd = @partnumber " +
						"	ORDER BY cpc.cpmpConc DESC, cc.cmpComp";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@partnumber", SqlDbType.VarChar).Value = partnumber;
                cmd.Connection.Open();
                //SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					CAStable = "<tbody>";
					while (dr.Read()) {
						ctr++;
						
						Concentration = dr["cpmpConc"].ToString();
						Component = dr["cmpComp"].ToString();
						Unit = dr["cuUnit"].ToString();
						CAS = dr["CAS"].ToString();
						
						CasClass = ctr%2 == 0 ? " " : "class='odd'";
						
						CAStable += "<tr "+ CasClass +">";
						CAStable += "<td class='desc'>" + Component + "</td>";
						CAStable += "<td class='desc'>" + CAS + "</td>";
						CAStable += "<td class='desc'>" + Concentration + " " + Unit + "</td>";
						CAStable += "</tr>";
                    }
					CAStable += "</tbody>";
				} 
				else {
					cmd.Connection.Close();
				}
				cmd.Connection.Close();
            }
			
			CAStable = "<table id='productdata_table'>"+
					"	<thead>"+
					"		<tr class='odd'>"+
					"			<th style='width:35%;' scope='col'>Components</th>"+
					"			<th style='width:20%;' scope='col'>CAS#</th>"+
					"			<th style='width:15%;' scope='col'>Concentration</th>"+
					"		</tr>"+
					"	</thead> "+ 
							CAStable + 
					"	</table>";
		}
		return CAStable;
	}
	
    protected void lbResults_Change(object sender, EventArgs e) {
		int pages = Int32.Parse(lbResults.SelectedValue);
        ProductListPagerSimple.PageSize = ProductListPagerSimple2.PageSize = pages;
        SetQuery();
        lvProducts.DataBind();
    }
	
    protected void cmdFilter_Click(object sender, EventArgs e) {
        Response.Redirect("search_organic_category.aspx");
    }
	protected void cmdFilterMobile_Click(object sender, EventArgs e) {
		string path = HttpContext.Current.Request.Url.AbsolutePath;
        Response.Redirect(path + "?method=" + s_methodMobile.SelectedValue);
    }
	protected void selectedChange(object sender, EventArgs e) {
		string path = HttpContext.Current.Request.Url.AbsolutePath;
		Response.Redirect(path + "?method=" + s_method.SelectedValue);
	}	
	protected void redirectPage(object sender, EventArgs e) {
		Response.Redirect("/organic-standards/" + technique.SelectedValue);
	}
	
	protected void familyChange(object sender, EventArgs e) {
		if (family.SelectedValue.ToString() == "0" ) {
			Response.Redirect("/organic-standards/" + technique.SelectedValue);
		}else {
			Response.Redirect("/organic-standards/" + technique.SelectedValue + "/" + family.SelectedValue);
		}
		
	}	
	
	public static string getFamilyID(string slug) {
		string famID = "";
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT cfID FROM cp_roi_Families WHERE slug = @slug";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@slug", SqlDbType.NVarChar, 100).Value = slug;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				if (dr.HasRows) {
					dr.Read();
					famID = dr["cfID"].ToString();
				}
                cmd.Connection.Close();
            }
        }
        return famID;
	}
}