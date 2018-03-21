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
	protected string Region = "US";
    protected string CurrencySymbol = "$";
    protected string CatCode = "1";
    protected clsUser myUser;
	
    protected void Page_Load(object sender, EventArgs e) {
		myUser = new clsUser();
        Region = myUser.Region;
        CurrencySymbol = myUser.CurrencySymbol;
        CatCode = myUser.DiscountCode;
		
		if (!Page.IsPostBack) {
            string SQL = "SELECT DISTINCT cp.cpPart AS PartNumber, " +
                         "       cp.cpLongDescrip AS Title,  " +
                         "       cv.cpvVolume AS Volume, " +
                         "       cp.cpUnitCnt AS UnitPack, " +
						 "       cpmp.id, " +
                         "       mat.T542_Sub_Short AS Matrix " +
                         "   FROM  cp_roi_Prods cp INNER JOIN certiPesticideMixesProd cpmp ON cp.cpPart = cpmp.partNum " +
                         "       INNER JOIN cp_roi_Volumes AS cv ON cp.Cpvol = cv.cpvID " +
                         "       INNER JOIN cp_roi_Matrix AS mat ON cp.cpMatrix = mat.T542_Code " +
                         "   WHERE cp.For_Web = 'Y' " +
                         "   ORDER BY cpmp.id";
            dataProducts.SelectCommand = SQL;
            dataProducts.DataBind();
        }
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
                    //conc = cmd.ExecuteScalar().ToString();
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
}