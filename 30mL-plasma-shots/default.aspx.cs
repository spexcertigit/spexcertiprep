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

public partial class hipure_inorganic : System.Web.UI.Page
{
    protected string sTitle = "";
	protected string sDesc = "";
    protected int ProductCount = 0;
    protected string Region = "US";
    protected string CurrencySymbol = "$";
    protected string CatCode = "1";
    protected clsUser myUser;
	protected string prodTitle = "";
	protected string strCatalog = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        myUser = new clsUser();
        Region = myUser.Region;
        CurrencySymbol = myUser.CurrencySymbol;
        CatCode = myUser.DiscountCode;
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT * FROM certiProdLanding WHERE id = '3'";

            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					dr.Read();
					prodTitle = dr["title"].ToString();
					ltrContent.Text = dr["content"].ToString();
					strCatalog = "/" + dr["page"].ToString() + "/" + dr["catalog"].ToString();
				}
                cmd.Connection.Close();
            }
        }
		Page.Header.Title = prodTitle + " | SPEX CertiPrep";
		
        SetQuery();
    }
    protected string GetConcentration(string PartNumber) {
        string conc = "";

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT DISTINCT CONVERT(varchar(20), cpc.cpmpConc) + ' ' + cu.cuUnit AS conc " +
							   "  FROM certiProdComps cpc JOIN certiUnits AS cu ON cpc.cpmpUnits = cu.cuID " +
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
    protected void dataProducts_Selected(object sender, SqlDataSourceStatusEventArgs e) {
        ProductCount = e.AffectedRows;
        ProductListPagerSimple.Visible = ProductListPagerSimple2.Visible = (ProductCount > ProductListPagerSimple.PageSize);
		ProductListMobilePager.Visible = (ProductCount > ProductListMobilePager.PageSize);
    }

    private void SetQuery() {
        if (Request.QueryString["p"] == null) {
            ProductListPagerSimple.PageSize = ProductListPagerSimple2.PageSize = 25;
        } else {
            int pages = 0;
            Int32.TryParse(Request.QueryString["p"].ToString(), out pages);
            if (pages > 0) {
                ProductListPagerSimple.PageSize = ProductListPagerSimple2.PageSize = pages;
            } else {
                ProductListPagerSimple.PageSize = ProductListPagerSimple2.PageSize = 25;
            }
        }
		
        string SQL = "SELECT cp.cpPart AS PartNumber, " +
                     "       cp.cpDescrip AS Title,  " +
                     "       cv.cpvVolume AS Volume, " +
                     "       cp.cpUnitCnt AS UnitPack, " +
                     "       mat.T542_Sub_Short AS Matrix, " +
                     "       0 AS Price " +
                     "   FROM  cp_roi_Prods cp LEFT JOIN cp_roi_ProdFamilies pfam ON cp.cpPart = pfam.cpfProdID " +
                     "       LEFT JOIN cp_roi_Volumes AS cv ON cp.Cpvol = cv.cpvID " +
                     "       LEFT JOIN cp_roi_Matrix AS mat ON cp.cpMatrix = mat.T542_Code ";
        SQL += "   WHERE cv.cpvVolume = '30 mL' ";
		if (Request.QueryString["a"] == null) {
			SQL += "   AND (cp.cpPart LIKE 'CL%' OR cp.cpPart LIKE 'ISOT%')";
		}else {
			SQL += "   AND (cp.cpPart LIKE 'PL%' OR cp.cpPart LIKE 'SPEC%')";
		}
         SQL +=     "   AND cp.cpType = 2 " +
                     "   AND cp.For_Web = 'Y' ";
        SQL += "   ORDER BY cp.cpPart";
        //Response.Write(SQL);

        dataProducts.SelectCommand = SQL;
        dataProducts.DataBind();
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
		string SQL = "SELECT  cp.cpPart, " +
						"		cp.cpDescrip, " +
						"		ca.caNameWeb, " +
						"		CAST(cpc.cpmpConc AS varchar(10)) AS cpmpConc, " +
						"		cu.cuUnit " +
						"	FROM certiProdComps AS cpc JOIN certiAnalytes AS ca ON cpc.cpmpAnalyteID = ca.caID " +
						"		JOIN cp_roi_Prods AS cp ON cpc.cpmpProd = cp.cpPart " +
						"		JOIN certiUnits AS cu ON cpc.cpmpUnits = cu.cuID " +
						"	WHERE cpc.cpmpConc IS NOT NULL AND cpc.cpmpProd = @partnumber " +
						"	ORDER BY cpc.cpmpConc DESC, ca.caNameWeb";
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
						Component = dr["caNameWeb"].ToString();
						Unit = dr["cuUnit"].ToString();
						
						CasClass = ctr%2 == 0 ? " " : "class='odd'";
						
						CAStable += "<tr "+ CasClass +">";
						CAStable += "<td class='desc'>" + Component + "</td>";
						CAStable += "<td>" + Concentration + " " + Unit + "</td>";
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
					"			<th scope='col'>Components</th>"+
					"			<th scope='col'>Concentration</th>"+
					"		</tr>"+
					"	</thead> "+ 
							CAStable + 
					"	</table>";
		}
		return CAStable;
	}	
	
    protected void lbResults_Change(object sender, EventArgs e) {
		int pages = Int32.Parse(lbResults.SelectedValue);
        ProductListPagerSimple.PageSize = pages;
		ProductListPagerSimple2.PageSize = pages;
        SetQuery();
        lvProducts.DataBind();
    }

}