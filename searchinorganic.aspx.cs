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

public partial class searchinorganic : System.Web.UI.Page
{
    protected string SearchTerm = "";
    protected int ProductCount = 0;
    protected string CurrencySymbol = "$";
    protected string CatCode = "1";
    protected clsUser myUser;

    protected void Page_Load(object sender, EventArgs e) {
        if (Request.QueryString["search"] != null) {
            SearchTerm = Request.QueryString["search"].ToString();
            if (SearchTerm.Length > 25) { SearchTerm = SearchTerm.Substring(0, 25); }
        }

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT COUNT(*) " +
							"FROM ( " +
							"SELECT * " +
							"FROM cp_roi_Prods " +
							"WHERE cpType = @Type AND (cpLongDescrip LIKE @Query OR cpPart LIKE @Query)  AND (For_Web = 'Y') " +
							") a";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@Query", SqlDbType.NVarChar, 23).Value = "%" + SearchTerm + "%";
                cmd.Parameters.Add("@Type", SqlDbType.Int).Value = 1;
                cmd.Connection.Open();
                ltrOrganicCount.Text = String.Format("{0:##,###,##0}", cmd.ExecuteScalar());
                cmd.Connection.Close();

                cmd.Parameters["@Type"].Value = 2;
                cmd.Connection.Open();
                ltrInorganicCount.Text = String.Format("{0:##,###,##0}", cmd.ExecuteScalar());
                cmd.Connection.Close();

                cmd.Parameters["@Type"].Value = 6;
                cmd.Connection.Open();
                ltrLabCount.Text = String.Format("{0:##,###,##0}", cmd.ExecuteScalar());
                cmd.Connection.Close();
            }
        }

        myUser = new clsUser();
        CurrencySymbol = myUser.CurrencySymbol;
        CatCode = myUser.DiscountCode;

        if (!Page.IsPostBack) {
            //Select the right item from the Technique dropdown
            int selectedTechnique = 0;
            if (Request.QueryString["tech"] != null) {
                Int32.TryParse(Request.QueryString["tech"].ToString(), out selectedTechnique);
                if (selectedTechnique > 0) {
                    technique.DataBind();
                    ListItem li = technique.Items.FindByValue(selectedTechnique.ToString());
                    if (li != null) { li.Selected = true; }
                }
            }

            //Select the right item from the Category dropdown
            int selectedCategory = 0;
            if (Request.QueryString["category"] != null) {
                Int32.TryParse(Request.QueryString["category"].ToString(), out selectedCategory);
                if (selectedCategory > 0) {
                    category.DataBind();
                    ListItem li = category.Items.FindByValue(selectedCategory.ToString());
                    if (li != null) { li.Selected = true; }
                }
            }

            SetQuery();
        }
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
    private void SetQuery() {
        int selectedCategory = 0;
        if (Request.QueryString["category"] != null) {
            Int32.TryParse(Request.QueryString["category"].ToString(), out selectedCategory);
        }
        int selectedTechnique = 0;
        if (Request.QueryString["tech"] != null) {
            Int32.TryParse(Request.QueryString["tech"].ToString(), out selectedTechnique);
        }
        int selectedFamily = 0;
        if (Request.QueryString["family"] != null) {
            Int32.TryParse(Request.QueryString["family"].ToString(), out selectedFamily);
        }
        int selectedMethod = 0;
        if (Request.QueryString["method"] != null) {
            Int32.TryParse(Request.QueryString["method"].ToString(), out selectedMethod);
        }

        string SQL = "SELECT DISTINCT cp.cpPart AS PartNumber, " +
                     "       cp.cpDescrip AS Title,  " +
                     "       cv.cpvVolume AS Volume, " +
                     "       cp.cpUnitCnt AS UnitPack, " +
                     "       mat.T542_Sub_Short AS Matrix " +
                     "   FROM  cp_roi_Prods cp LEFT JOIN cp_roi_ProdFamilies pfam ON cp.cpPart = pfam.cpfProdID " +
                     "       LEFT JOIN cp_roi_Volumes AS cv ON cp.Cpvol = cv.cpvID " +
                     "       LEFT JOIN cp_roi_Matrix AS mat ON cp.cpMatrix = mat.T542_Code ";
        if (selectedTechnique > 0) {
            SQL += " LEFT JOIN cp_roi_ProdFamilies AS cpf ON cp.cpID = cpf.cpfID ";
        }
        if (selectedCategory > 0) {
            SQL += " LEFT JOIN cp_roi_ProdMeths AS pm ON pm.cpmProdID = cp.cpPart ";
        }
        SQL += "   WHERE cp.cpType = 2 " +
                     "   AND cp.For_Web = 'Y' " +
                     "   AND (cpLongDescrip LIKE '%" + SearchTerm + "%' or cpPart LIKE '%" + SearchTerm + "%') ";
        if (selectedTechnique > 0) {
            SQL += " AND pfam.cpffamID = " + selectedTechnique.ToString() + " ";
        }
        if (selectedCategory > 0) {
            SQL += " AND pm.cpmMethID = " + selectedCategory.ToString() + " ";
        }
        SQL += "   ORDER BY cp.cpPart";
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
	protected void dataProducts_Selected(object sender, SqlDataSourceStatusEventArgs e) {
        ProductCount = e.AffectedRows;
        ProductListPagerSimple2.Visible = (ProductCount > ProductListPagerSimple2.PageSize);
		ProductListMobilePager.Visible = (ProductCount > ProductListMobilePager.PageSize);
    }
    protected void cmdFilter_Click(object sender, EventArgs e) {
        Response.Redirect("searchinorganic.aspx?category=" + category.SelectedValue + "&tech=" + technique.SelectedValue + "&search=" + Server.UrlEncode(SearchTerm));
    }
	 protected void cmdFilterMobile_Click(object sender, EventArgs e) {
        Response.Redirect("searchinorganic.aspx?category=" + categoryMobile.SelectedValue + "&tech=" + techniqueMobile.SelectedValue + "&search=" + Server.UrlEncode(SearchTerm));
    }
	protected void lbResults_Change(object sender, EventArgs e) {
		int pages = Int32.Parse(lbResults.SelectedValue);
        ProductListPagerSimple2.PageSize = pages;
        SetQuery();
        lvProducts.DataBind();
    }
}