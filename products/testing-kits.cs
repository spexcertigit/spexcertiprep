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

public partial class thank_you : System.Web.UI.Page
{
	protected clsUser myUser;
	protected string Region = "US";
	protected string CurrencySymbol = "$";
	
    protected void Page_Load(object sender, EventArgs e)
    {
		myUser = new clsUser();
        Region = myUser.Region;
        CurrencySymbol = myUser.CurrencySymbol;
		
		if (!Page.IsPostBack) {
            

			string SQL = "SELECT DISTINCT cp.cpPart AS PartNumber, " +
						 "       cp.cpDescrip AS Title,  " +
						 "       cv.cpvVolume AS Volume, " +
						 "       cp.cpUnitCnt AS UnitPack, " +
						 "       mat.T542_Sub_Short AS Matrix " +
						 "   FROM  cp_roi_Prods cp LEFT JOIN cp_roi_ProdFamilies pfam ON cp.cpPart = pfam.cpfProdID " +
						 "       LEFT JOIN cp_roi_Volumes AS cv ON cp.Cpvol = cv.cpvID " +
						 "       LEFT JOIN cp_roi_Matrix AS mat ON cp.cpMatrix = mat.T542_Code " +
						 "   WHERE cp.cpPart IN ('SPXHM-KIT','SPXMT-KIT') " +
						 "   AND cp.For_Web = 'Y' " +
						 "   ORDER BY cp.cpPart";

			dataKits.SelectCommand = SQL;
			dataKits.DataBind();

			
		}
    }
	
	protected string GetPrice(string PartNumber) {
        clsItemPrice price = new clsItemPrice(PartNumber, myUser);
        return price.PriceText;
    }
}