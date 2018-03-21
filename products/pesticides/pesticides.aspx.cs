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
using System.Text;
using System.Net.Mail;
using System.Text.RegularExpressions;

public partial class search : System.Web.UI.Page
{
    protected clsHelper helper;
    protected string promoCode = "WIN13-20";

    protected string SearchTerm = "";
    protected string SearchTermEnc = "";
    protected int EquipTypeCount = 0;
    protected int AccessoryCount = 0;
    protected int ProdResCnt = 0;
    protected int FaqCount = 0;

    protected string Region = "US";
    protected string CurrencySymbol = "$";
    protected string CatCode = "1";
    protected clsUser myUser;

	protected string txtMessage = "";

    protected void Page_Load(object sender, EventArgs e) {
        myUser = new clsUser();
        Region = myUser.Region;
        CurrencySymbol = myUser.CurrencySymbol;
        CatCode = myUser.DiscountCode;
        //Promotion updater...
        helper = new clsHelper();
		
		List<String> catprods = new List<String>(); 

		string output = "";
		string catH1 = "";
		string methodName = "";
		string methodFile = "", methodFileName = "";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
		
			string SQL = "SELECT * FROM certiPesticidesMethods WHERE slug = '" + Page.RouteData.Values["method"].ToString() + "'";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
                    dr.Read();
					ltrDesc.Text = dr["description"].ToString().Trim();
					output = dr["id"].ToString().Trim();
					methodName = dr["method"].ToString().Trim();
					methodFile = dr["methodfile"].ToString().Trim();
					methodFileName = dr["methodfile_name"].ToString().Trim();
                }
                cmd.Connection.Close();
            }
		}
		string famID = output;
		if (methodFile == "" || methodFile == null) {
			ltrDL.Text = "";
		}else {
			ltrDL.Text = "<div class='side-module'>" +
							"<h2 id='updates'>Download</h2>" +
							"<div class='organic-side'>" +
								"<ul class='flyers'>" +
									"<li class='pdf_dl'><a href='" + methodFile + "' target='_blank'>" + methodFileName + "</a></li>" +
								"</ul>" +
							"</div>" +
						"</div>";
		}
		ltrH1.Text = methodName;
		ltrBread.Text = methodName;
		Page.Header.Title = "Pesticides " + methodName + " | SPEX CertiPrep";
		
        if (!Page.IsPostBack) {
            string SQL = "SELECT DISTINCT cp.cpPart AS PartNumber, " +
                         "       cp.cpDescrip AS Title,  " +
                         "       cv.cpvVolume AS Volume, " +
                         "       cp.cpUnitCnt AS UnitPack, " +
                         "       mat.T542_Sub_Short AS Matrix " +
                         "   FROM  cp_roi_Prods cp LEFT JOIN certiPesticideMethodsProd cpmp ON cp.cpPart = cpmp.prods " +
                         "       LEFT JOIN cp_roi_Volumes AS cv ON cp.Cpvol = cv.cpvID " +
                         "       LEFT JOIN cp_roi_Matrix AS mat ON cp.cpMatrix = mat.T542_Code " +
                         "   WHERE cpmp.method_id = '" + famID +
                         "'   AND cp.For_Web = 'Y' " +
                         "   ORDER BY cp.cpPart";
            dataProducts.SelectCommand = SQL;
            dataProducts.DataBind();
        }
    }
	protected string getCannabisCatName(string famID) {
		string catName = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT cfID, cfFamily FROM cp_roi_Families WHERE cfID = " + famID;			
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					dr.Read();
                    catName = dr["cfFamily"].ToString().Trim();
                }
                cmd.Connection.Close();
            }
			return catName;
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
                    CAS = cmd.ExecuteScalar().ToString();
                    cmd.Connection.Close();
                }
            }
        }
        return CAS;
    }
    protected string GetConcentration(string PartNumber) {
        string conc = "";

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT count(*) " +
                         "   FROM certiProdComps " +
                         "   WHERE cpmpProd = @partnumber AND cpmpConc IS NOT NULL";

            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@partnumber", SqlDbType.VarChar, 21).Value = PartNumber;
                cmd.Connection.Open();
                int CASCount = (int)cmd.ExecuteScalar();
                cmd.Connection.Close();

                if (CASCount > 1) {
                    conc = "Various";
                } else if (CASCount == 1) {
                    cmd.CommandText = "SELECT CONVERT(varchar(20), cpc.cpmpConc) + ' ' + cu.cuUnit AS conc " +
                                      "  FROM certiProdComps cpc JOIN certiComps AS cc ON cpc.cpmpCompID = cc.cmpID " +
                                      "      JOIN certiUnits AS cu ON cpc.cpmpUnits = cu.cuID " +
                                      "  WHERE cpc.cpmpConc IS NOT NULL AND cpc.cpmpProd = @partnumber";

                    cmd.Connection.Open();
                    conc = cmd.ExecuteScalar().ToString();
                    cmd.Connection.Close();
                }
            }
        }
        return conc;
    }
    protected string GetConcentrationInorg(string PartNumber) {
        string conc = "";

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT count(*) " +
                         "   FROM certiProdComps " +
                         "   WHERE cpmpProd = @partnumber AND cpmpConc IS NOT NULL";

            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@partnumber", SqlDbType.VarChar, 21).Value = PartNumber;
                cmd.Connection.Open();
                int CASCount = (int)cmd.ExecuteScalar();
                cmd.Connection.Close();

                if (CASCount > 1) {
                    conc = "Various";
                } else if (CASCount == 1) {
                    cmd.CommandText = "SELECT  CAST(cpc.cpmpConc AS varchar(20)) + ' ' + cu.cuUnit AS conc " +
										"FROM certiProdComps AS cpc JOIN certiUnits AS cu ON cpc.cpmpUnits = cu.cuID " +
										"WHERE cpc.cpmpConc IS NOT NULL " +
										"AND cpc.cpmpProd =  @partnumber";

                    cmd.Connection.Open();
                    conc = cmd.ExecuteScalar().ToString();
                    cmd.Connection.Close();
                }
            }
        }
        return conc;
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
				method = cmd.ExecuteScalar().ToString();
				 cmd.Connection.Close();

//					try
//					{
//						method = cmd.ExecuteScalar().ToString();
//					}
//					catch (Exception ex)
//					{
//						return "unknown"; //cmd.CommandText + ":: "  + PartNumber;
//					}
                    

                }
            }
        }
        return method;
    }
	protected void selectedChange(object sender, EventArgs e) {
		Response.Redirect("/products/pesticides/" + s_method.SelectedValue);
	}
}