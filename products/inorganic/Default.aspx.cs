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

public partial class search : System.Web.UI.Page
{
    protected clsHelper helper;
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
    protected string promoCode = "INORGANICS16-15";
    protected void Page_Load(object sender, EventArgs e) {
        myUser = new clsUser();
        Region = myUser.Region;
        CurrencySymbol = myUser.CurrencySymbol;
        CatCode = myUser.DiscountCode;
        //Promotion updater...
        helper = new clsHelper();
        //lblPromoExpiration.Text = helper.GetPromoExpiration(promoCode);
       // lblPromoCode1.Text = promoCode.ToString();
        //lblPromoCode2.Text = promoCode.ToString();
        if (!Page.IsPostBack) {
            string SQL = "SELECT DISTINCT cp.cpPart AS PartNumber, " +
                        "       cp.cpDescrip AS Title,  " +
                        "       cv.cpvVolume AS Volume, " +
                        "       cp.cpUnitCnt AS UnitPack, " +
                        "       mat.T542_Sub_Short AS Matrix, " +
                        "       0 AS Price " +
                        "   FROM  cp_roi_Prods cp LEFT JOIN cp_roi_ProdATs cpats ON cp.cpPart = cpats.cpatProdId " +
                        "       LEFT JOIN cp_roi_AnTechs at ON cpats.cpatATID = at.CatID " +
                        "       LEFT JOIN cp_roi_Volumes AS cv ON CP.Cpvol = cv.cpvID " +
                        "       LEFT JOIN cp_roi_Matrix AS mat ON mat.T542_Code = cp.cpMatrix " +
                        "   WHERE cp.cpPart IN ('USP-RS-C1','USP-RS-C2A','USP-RS-C2B','USP-RS-C2C','USP-RS-C3A','USP-RS-C3B'," + 
						"		'USP-S1015-DMSO','USP-S1380-DMSO','USP-S1390-DMSO','USP-S1394-DMSO','USP-S1400-DMSO','USP-S145-DMSO'," +
						"		'USP-S1572-DMSO','USP-S1597-DMSO','USP-S1715-DMSO','USP-S1910-DMSO','USP-S1940-DMSO','USP-S1952-DMSO'," + 
						"		'USP-S2062-DMSO','USP-S2480-DMSO','USP-S2590-DMSO','USP-S2722-DMSO','USP-S3240-DMSO','USP-S3460-DMSO'," +
						"		'USP-S3464-DMSO','USP-S3505-DMSO','USP-S3605-DMSO','USP-S3615-DMSO','USP-S3830-DMSO','USP-S3835-DMSO'," + 
						"		'USP-S3840-DMSO','USP-S405-DMSO','USP-S750-DMSO','USP-S810-DMSO','USP-S865-DMSO') " +
                        "   AND cp.For_Web = 'Y' " +
                        "   ORDER BY cp.cpDescrip";
            dataProducts.SelectCommand = SQL;
            dataProducts.DataBind();

			SQL = "SELECT DISTINCT cp.cpPart AS PartNumber, " +
						 "       cp.cpDescrip AS Title,  " +
						 "       cv.cpvVolume AS Volume, " +
						 "       cp.cpUnitCnt AS UnitPack, " +
						 "       mat.T542_Sub_Short AS Matrix " +
						 "   FROM  cp_roi_Prods cp LEFT JOIN cp_roi_ProdFamilies pfam ON cp.cpPart = pfam.cpfProdID " +
						 "       LEFT JOIN cp_roi_Volumes AS cv ON cp.Cpvol = cv.cpvID " +
						 "       LEFT JOIN cp_roi_Matrix AS mat ON cp.cpMatrix = mat.T542_Code " +
						 "   WHERE cp.cpPart IN ('USP-TXM2','USP-TXM3','USP-TXM4','USP-TXM5','USP-TXM6') " +
						 "   AND cp.For_Web = 'Y' " +
						 "   ORDER BY cp.cpPart";

			dataProductsInorg1.SelectCommand = SQL;
			dataProductsInorg1.DataBind();

			SQL = "SELECT DISTINCT cp.cpPart AS PartNumber, " +
						 "       cp.cpDescrip AS Title,  " +
						 "       cv.cpvVolume AS Volume, " +
						 "       cp.cpUnitCnt AS UnitPack, " +
						 "       mat.T542_Sub_Short AS Matrix " +
						 "   FROM  cp_roi_Prods cp LEFT JOIN cp_roi_ProdFamilies pfam ON cp.cpPart = pfam.cpfProdID " +
						 "       LEFT JOIN cp_roi_Volumes AS cv ON cp.Cpvol = cv.cpvID " +
						 "       LEFT JOIN cp_roi_Matrix AS mat ON cp.cpMatrix = mat.T542_Code " +
						 "   WHERE cp.cpPart IN ('ICH-TXM2', 'ICH-TXM3', 'ICH-TXM4', 'ICH-TXM6', 'ICH-TXM7', 'ICH-TXM8') " +
						 "   AND cp.For_Web = 'Y' " +
						 "   ORDER BY cp.cpPart";

			dataProductsInorg2.SelectCommand = SQL;
			dataProductsInorg2.DataBind();
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
}