using System;
using System.IO;
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
        int SearchTerm = 1;

        myUser = new clsUser();
        Region = myUser.Region;
        CurrencySymbol = myUser.CurrencySymbol;
        CatCode = myUser.DiscountCode;

        if (!Page.IsPostBack) {

			Page.Title = "Inorganic International Standards" + ConfigurationSettings.AppSettings["gsDefaultPageTitle"];

            SetQuery();
			SetGlobal();
        }
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

    private void SetQuery() {

        string SQL = "SELECT DISTINCT cp.cpPart AS PartNumber, " +
                     "       cp.cpDescrip AS Title,  " +
                     "       cv.cpvVolume AS Volume, " +
                     "       cp.cpUnitCnt AS UnitPack, " +
                     "       mat.T542_Sub_Short AS Matrix, " +
					 "		 ci.country AS Country, " +
                     "       0 AS Price " +
                     "   FROM  cp_roi_Prods cp LEFT JOIN cp_roi_ProdATs cpats ON cp.cpPart = cpats.cpatProdId " +
                     "       LEFT JOIN cp_roi_AnTechs at ON cpats.cpatATID = at.CatID " +
                     "       LEFT JOIN cp_roi_Volumes AS cv ON CP.Cpvol = cv.cpvID " +
                     "       LEFT JOIN cp_roi_Matrix AS mat ON mat.T542_Code = cp.cpMatrix " +
					 "       INNER JOIN certiInternational AS ci ON cp.cpPart = ci.cpPart" ;
        SQL +=       "   WHERE cp.cpType = 2 AND ci.country != 'global'" +
                     "   AND cp.For_Web = 'Y' ";
        SQL += 		 "   ORDER BY ci.country";
		
		string outputTable = "", countryHead = "", currCounrty = "", partNum="", prodTitle="", matrix="", vol="", unit="", price="", image_path = "", imageFlag="";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows) {					
                    while (dr.Read()) {
						partNum = dr["PartNumber"].ToString();
						prodTitle = dr["Title"].ToString();
						matrix = dr["Matrix"].ToString();
						vol = dr["Volume"].ToString();
						unit = dr["UnitPack"].ToString();
						price = dr["Price"].ToString();
						image_path = "/images/international/" + dr["Country"].ToString() + ".png";
						if (File.Exists(Server.MapPath(image_path))) {
							imageFlag = "<img style='float:left' class='imageFlag' src="+image_path+" />";
						}else {
							imageFlag ="";
						}
						
						countryHead = 	"<thead>" +
											"<tr style='border:none;'>" +
												"<td style='text-align:left;padding:4px;' colspan='10'>" +
													imageFlag +
													"<span class='product-filter' style='padding-top:9px;'>" + FirstCharToUpper(dr["Country"].ToString()) + "</span>" +
												"</td>" +
											"</tr>" +
											"<tr class='orig-tr-header'>" +
												"<th scope='col' id='method' class='header sorter' >Method</th>" +
												"<th scope='col' id='partnumber' class='header sorter'>Part #</th>" +
												"<th scope='col' id='title' class='header sorter'>Product Name</th>" +
												"<th scope='col' id='cas' class='header sorter'>CAS#</th>" +
												"<th scope='col' >Conc.</th>" +
												"<th scope='col' id='matrix'>Matrix</th>" +
												"<th scope='col' id='volume'>Vol.</th>" +
												"<th scope='col' >Unit</th>" +
												"<th scope='col' id='price'>Price</th>" +
												"<th scope='col' >Add to Cart</th>" +
											"</tr>" +
										"</thead>" +
										"<tbody>";
										
						
						if (currCounrty != dr["Country"].ToString()) {
							outputTable += countryHead;
							currCounrty = dr["Country"].ToString();
						}
						if (currCounrty != dr["Country"].ToString()) {
							outputTable += "</tbody>";
						}
						
						outputTable +=	"<tr class='orig-tr-products'>"; 
						if (GetMethod(partNum) == "Various") {
							outputTable += "<td>" + GetMethod(partNum) + "<a href='javascript:void()' class='various_method' data-partnum='"+partNum+"'><img src='/images/modal-tooltip.png' /></a></td>";
						}else {
							outputTable += "<td>" + GetMethod(partNum)+"</td>";
						}
						outputTable += 	"<td class='desc' nowrap><b><a href='products/product_inorganic.aspx?part="+partNum+"'>"+partNum+"</a></b></td>" +
										"<td class='desc'><b><a href='products/product_inorganic.aspx?part="+ partNum +"'>"+prodTitle+"</a></b></td>";
						if(GetCAS(partNum) == "Various") {
							outputTable += "<td>"+ GetCAS(partNum)+"<a href='javascript:void()' class='various_cascon' data-partnum='"+partNum+"'><img src='/images/modal-tooltip.png' /></a></td>";
						}else {
							outputTable += "<td>"+ GetCAS(partNum)+"</td>";
						}
						
						if (GetConcentration(partNum) == "Various") {
							outputTable += "<td style='white-space:nowrap;'>"+ GetConcentration(partNum)+"<a href='javascript:void()' class='various_cascon' data-partnum='"+partNum+"'><img src='/images/modal-tooltip.png' /></a></td>";
						}else {
							outputTable += "<td>"+ GetConcentration(partNum)+"</td>";
						}
						
                        outputTable += 	"<td>"+matrix+"</td>" +
										"<td style='text-align:right;white-space:nowrap;'>"+vol+"</td>" +
										"<td style='text-align:center;white-space:nowrap;'>"+unit+"</td>" +
										"<td style='text-align:right;white-space:nowrap;'>"+GetPrice(partNum)+"</td>" +
										"<td class='buybutton' style='white-space:nowrap;'>" +
											"<input name='quantity_"+partNum+"' type='text' id='quantity_"+partNum+"' class='search_quantity' value='1' />" +
											"<input type='button' id='buy_"+partNum+"' name='buy_"+partNum+"' value='' class='search_buy' onclick='buyIt(\'"+partNum+"\');' /></td>" +
										"</td>" +
									"</tr>";
                    }
					outputTable += "</tbody>";
                }
                cmd.Connection.Close();
            }
		}
		ltrTBLoutput.Text = outputTable;
    }
	
	private void SetGlobal() {
        string SQL = "SELECT DISTINCT cp.cpPart AS PartNumber, " +
                     "       cp.cpDescrip AS Title,  " +
                     "       cv.cpvVolume AS Volume, " +
                     "       cp.cpUnitCnt AS UnitPack, " +
                     "       mat.T542_Sub_Short AS Matrix, " +
					 "		 ci.country AS Country, " +
                     "       0 AS Price " +
                     "   FROM  cp_roi_Prods cp LEFT JOIN cp_roi_ProdATs cpats ON cp.cpPart = cpats.cpatProdId " +
                     "       LEFT JOIN cp_roi_AnTechs at ON cpats.cpatATID = at.CatID " +
                     "       LEFT JOIN cp_roi_Volumes AS cv ON CP.Cpvol = cv.cpvID " +
                     "       LEFT JOIN cp_roi_Matrix AS mat ON mat.T542_Code = cp.cpMatrix " +
					 "       INNER JOIN certiInternational AS ci ON cp.cpPart = ci.cpPart" ;
        SQL +=       "   WHERE cp.cpType = 2 AND ci.country = 'global'" +
                     "   AND cp.For_Web = 'Y' ";
        SQL += 		 "   ORDER BY ci.country";
		
		string outputTable = "", countryHead = "", currCounrty = "", partNum="", prodTitle="", matrix="", vol="", unit="", price="", image_path = "", imageFlag="", mobileOutputTable = "", mobMethod = "", mobCas = "", mobConc = "", mobCountryHead = "";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows) {					
                    while (dr.Read()) {
						partNum = dr["PartNumber"].ToString();
						prodTitle = dr["Title"].ToString();
						matrix = dr["Matrix"].ToString();
						vol = dr["Volume"].ToString();
						unit = dr["UnitPack"].ToString();
						price = dr["Price"].ToString();
						image_path = "/images/international/" + dr["Country"].ToString() + ".png";
						if (File.Exists(Server.MapPath(image_path))) {
							imageFlag = "<img style='float:left' class='imageFlag' src="+image_path+" />";
						}else {
							imageFlag ="";
						}
						
						countryHead = 	"<thead>" +
											"<tr style='border:none;'>" +
												"<td style='text-align:left;padding:4px;' colspan='10'>" +
													imageFlag +
													"<p style='font-weight:bold;font-size:14px;margin:0 7px;line-height:17px;padding-top:5px'>ICH/Global Compliance Standards<br>Elemental Impurities in Pharmaceuticals and Dietary Supplements</p>" +
												"</td>" +
											"</tr>" +
											"<tr class='orig-tr-header'>" +
												"<th scope='col' id='method' class='header sorter' >Method</th>" +
												"<th scope='col' id='partnumber' class='header sorter'>Part #</th>" +
												"<th scope='col' id='title' class='header sorter'>Product Name</th>" +
												"<th scope='col' id='cas' class='header sorter'>CAS#</th>" +
												"<th scope='col' >Conc.</th>" +
												"<th scope='col' id='matrix'>Matrix</th>" +
												"<th scope='col' id='volume'>Vol.</th>" +
												"<th scope='col' >Unit</th>" +
												"<th scope='col' id='price'>Price</th>" +
												"<th scope='col' >Add to Cart</th>" +
											"</tr>" +
										"</thead>" +
										"<tbody>";
						
						mobCountryHead = "<table class='mobile-result-table'><tr>" +
											"<td style='text-align:left;padding:4px;background:url(/images/methodref.png) repeat-x' colspan='10'>" +
													imageFlag +
													"<p style='font-weight:bold;font-size:14px;margin:0 7px;line-height:17px;padding-top:5px'>ICH/Global Compliance Standards<br>Elemental Impurities in Pharmaceuticals and Dietary Supplements</p>" +
												"</td>" +
										"</tr></table>";
						
						if (currCounrty != dr["Country"].ToString()) {
							outputTable += countryHead;
							mobileOutputTable += mobCountryHead;
							currCounrty = dr["Country"].ToString();
						}
						if (currCounrty != dr["Country"].ToString()) {
							outputTable += "</tbody>";
						}
						
						outputTable +=	"<tr class='orig-tr-products'>"; 
						if (GetMethod(partNum) == "Various") {
							outputTable += "<td>" + GetMethod(partNum) + "<a href='javascript:void()' class='various_method' data-partnum='"+partNum+"'><img src='/images/modal-tooltip.png' /></a></td>";
							mobMethod = GetMethod(partNum) + "<a href='javascript:void()' class='various_method' data-partnum='"+partNum+"'><img src='/images/modal-tooltip.png' /></a>";
						}else {
							outputTable += "<td>" + GetMethod(partNum)+"</td>";
							mobMethod = GetMethod(partNum);
						}
						outputTable += 	"<td class='desc' nowrap><b><a href='products/product_inorganic.aspx?part="+partNum+"'>"+partNum+"</a></b></td>" +
										"<td class='desc'><b><a href='products/product_inorganic.aspx?part="+ partNum +"'>"+prodTitle+"</a></b></td>";
						if(GetCAS(partNum) == "Various") {
							outputTable += "<td>"+ GetCAS(partNum)+"<a href='javascript:void()' class='various_cascon' data-partnum='"+partNum+"'><img src='/images/modal-tooltip.png' /></a></td>";
							mobCas = GetCAS(partNum)+"<a href='javascript:void()' class='various_cascon' data-partnum='"+partNum+"'><img src='/images/modal-tooltip.png' /></a>";
						}else {
							outputTable += "<td>"+ GetCAS(partNum)+"</td>";
							mobCas = GetCAS(partNum);
						}
						
						if (GetConcentration(partNum) == "Various") {
							outputTable += "<td style='white-space:nowrap;'>"+ GetConcentration(partNum)+"<a href='javascript:void()' class='various_cascon' data-partnum='"+partNum+"'><img src='/images/modal-tooltip.png' /></a></td>";
							mobConc = GetConcentration(partNum)+"<a href='javascript:void()' class='various_cascon' data-partnum='"+partNum+"'><img src='/images/modal-tooltip.png' /></a>";
						}else {
							outputTable += "<td>"+ GetConcentration(partNum)+"</td>";
							mobConc = GetConcentration(partNum);
						}
						
                        outputTable += 	"<td>"+matrix+"</td>" +
										"<td style='text-align:right;white-space:nowrap;'>"+vol+"</td>" +
										"<td style='text-align:center;white-space:nowrap;'>"+unit+"</td>" +
										"<td style='text-align:right;white-space:nowrap;'>"+GetPrice(partNum)+"</td>" +
										"<td class='buybutton' style='white-space:nowrap;'>" +
											"<input name='quantity_"+partNum+"' type='text' id='quantity_"+partNum+"' class='search_quantity' value='1' />" +
											"<input type='button' id='buy_"+partNum+"' name='buy_"+partNum+"' value='' class='search_buy' onclick='buyIt(\'"+partNum+"\');' /></td>" +
										"</td>" +
									"</tr>";
						
						mobileOutputTable += "<table class='mobile-result-table'>" +
												"<tr><td colspan='4' class='fullTD'><a href='/products/product_inorganic.aspx?part="+partNum+ "'>"+prodTitle+"</a></td></tr>" +
												"<tr>" +
													"<td class='headerColumns' colspan='2'>Part #</td>" +
													"<td colspan='2' class='topBorderTD'><a href='/products/product_inorganic.aspx?part="+partNum+"'>"+partNum+"</a></td>" +
												"</tr>" +
												"<tr>" +
													"<td class='headerColumns' colspan='2'>Method</td>" +
													"<td colspan='2' class='grayTD'>"+mobMethod+"</td>" +
												"</tr>" +
												"<tr>" +
													"<td class='headerColumns' colspan='2'>CAS#</td>" +
													"<td colspan='2'>"+mobCas+"</td>" +
												"</tr>" +
												"<tr>" +
													"<td class='headerColumns' colspan='2'>Concentration</td>" +
													"<td colspan='2' class='grayTD'>"+mobMethod+"</td>" +
												"</tr>" +
												"<tr>" +
													"<td class='headerColumns' colspan='2'>Matrix</td>" +
													"<td colspan='2'>"+matrix+"</td>" +
												"</tr>" +
												"<tr>" +
													"<td class='headerColumns' colspan='2'>Volume</td>" +
													"<td colspan='2' class='grayTD'>"+vol+"</td>" +
												"</tr>" +
												"<tr>" +
													"<td class='headerColumns' colspan='2'>Unit</td>" +
													"<td colspan='2'>"+unit+"</td>" +
												"</tr>" +
												"<tr>" +
													"<td class='headerColumns' colspan='2'>Price</td>" +
													"<td colspan='2' class='grayTD'>"+GetPrice(partNum)+"</td>" +
												"</tr>" +
												"<tr>" +
													"<td class='headerColumns' colspan='2'>Add to Cart</td>" +
													"<td colspan='2' class='topBorderTD'>" +
														"<input name='quantity_"+partNum+"' type='text' id='m_quantity_"+partNum+"' class='search_quantity' value='1' />" +
														"<input type='button' id='mbuy_"+partNum+"' name='buy_"+partNum+"' value='' class='search_buy' onclick='buyItM(\'"+partNum+"\');' /></td>" +
													"</td>" +
												"</tr>" +
											"</table>";
                    }
					outputTable += "</tbody>";
                }
                cmd.Connection.Close();
            }
		}
		ltrTBLglobal.Text = outputTable;
		ltrMobileOutput.Text = mobileOutputTable;
    }

	[WebMethod()]
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
	public static string FirstCharToUpper(string input)
	{
		if (String.IsNullOrEmpty(input))
			throw new ArgumentException("ARGH!");
		return input.First().ToString().ToUpper() + input.Substring(1);
	}
	
    protected void cmdFilter_Click(object sender, EventArgs e) {
        
    }
	protected void cmdFilterMobile_Click(object sender, EventArgs e) {
	
    }
	
}