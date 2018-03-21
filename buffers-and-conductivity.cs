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
	protected string sDesc = "";
    protected int ProductCount = 0;
    protected string Region = "US";
    protected string CurrencySymbol = "$";
    protected string CatCode = "1";
	protected string bannerImg = "";
    protected clsUser myUser;
	protected int SearchTerm = 0;

    protected void Page_Load(object sender, EventArgs e)
    {   
        //dim CatCode
        
        
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT cfID, banner FROM cp_roi_Families WHERE slug=@slug";

            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@slug", SqlDbType.NVarChar).Value = "buffers-and-conductivity";
                cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					dr.Read();
					SearchTerm = Convert.ToInt32(dr["cfID"]);
					bannerImg = dr["banner"].ToString();
				}
                cmd.Connection.Close();
			}
		}
        if (SearchTerm == 0) { Response.Redirect("/products/inorganic/"); }

        myUser = new clsUser();
        Region = myUser.Region;
        CurrencySymbol = myUser.CurrencySymbol;
        CatCode = myUser.DiscountCode;

        switch (SearchTerm) {
            case 1:
                sTitle = "AA / ICP Standards";
				sDesc = "AA and ICP Assurance&#174; Grade CRMs are available in single and multi-element formulations. Over 70 single-element standards are available at 1,000 and/or 10,000 &#181;g/mL. Custom singles can be manufactured upon request.";
                break;
            case 2:
                sTitle = "CLP Standards";
				sDesc = "Every CLP standard SPEX CertiPrep offers allows you to Calibrate with Confidence&#174;. The final ICP check, performed in our own laboratories, is your stamp of assurance. We calibrate our instruments with traceable reference materials and show you the actual found value of the solution you receive&#150;not just an ideal. ";
                break;
            case 3:
                sTitle = "ICP-MS Standards";
				sDesc = "ICP-MS Claritas PPT&#174; Grade CRMs are designed for ICP-MS and can also be used in ICP analysis. They are available in single and multi-element solutions. The standards are at 1, 10 or 1,000 &#181;g/mL and packaged in 125 mL bottles to minimize contamination. They are made using ultra high purity acids, the highest grade starting materials, and a high purity water to minimize contaminants.";
                break;
            case 4:
                sTitle = "Ion Chromatography / Ion Selective Electrode Standards";
				sDesc = "SPEX CertiPrep offers the highest quality IC and ISE standards available for the analytical laboratory. Our standards feature a full line of anion and cation single element standards available at 1000 ppm in 125 mL and 500 mL volumes.";
                break;
            case 5:
                sTitle = "Cyanide Standards";
				sDesc = "SPEX CertiPrep offers a cyanide reference standard in a simple form designed for US EPA methods 335.2 and 335.3, ASTM method D2036-19 and Standard method 4500-CNF, and in a complex form for use with US EPA method 335.1.";
                break;
            case 6:
                sTitle = "Organometallic Oil Standards";
				sDesc = "Organometallic Oil Standards are offered with a choice of single element or multi-element blends. Whether you are testing engine oils via ICP, RDE, DCP, AA or XRF, our standards are pure and accurate to suit your needs. We offer a choice of 37 single element standards at 1,000 and 5,000 &#181;g/g. Multi-element mixes of 5, 12, 21 and 23 elements are available and come in convenient 50 or 100 gram sizes.";
                break;
            case 7:
                sTitle = "XRF / Fusion";
				sDesc = "Pure and Ultra-Pure Fusion Fluxes and Additives are made from a &#34;Micro Bead&#34; formula to ensure the same ratio of components in each bead with no harmful dust to clog your instruments. Our Fusion Fluxes are pre-fused with additives for better accuracy. Density of 1.4 g/mL ensures flux is easier to handle and measure. ";
                break;
            case 8:
                sTitle = "Buffers / Conductivity";
				//sDesc = "New regulations are constantly enacted to protect consumers from a variety of potentially dangerous chemicals and elements. SPEX CertiPrep leads the CRM field with a full line of Consumer Safety Compliance Standards for a variety of testing regulations. These include Cyanide, BioDiesel, RoHS/WEEE, Conductivity, CPSC Metals in Children's Toys, and USP <232> and <233> testing for pharmaceuticals.";
                break;
        }
        Page.Title = sTitle + " - Inorganic Standards" + ConfigurationSettings.AppSettings["gsDefaultPageTitle"];

        if (!Page.IsPostBack) {
            //Select the right item from the Technique dropdown
            technique.Items.Clear();
            technique.Items.Add(new ListItem("-- Select Analytical Technique --", "0"));
            technique.DataBind();
            ListItem li = technique.Items.FindByValue("buffers-and-conductivity");
            if (li != null) { li.Selected = true; }

            //Select the right item from the Category dropdown
            int selectedCategory = 0;
            if (Request.QueryString["category"] != null) {
                
                Int32.TryParse(Request.QueryString["category"].ToString(), out selectedCategory);
                if (selectedCategory > 0) {
                    category.DataBind();
                    li = category.Items.FindByValue(selectedCategory.ToString());
                    if (li != null) { li.Selected = true; }
                }
            }

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
        //string SearchTerm = technique.SelectedValue;
        int selectedMethod = 0;
        if (category.SelectedIndex > 0) {
            Int32.TryParse(category.SelectedValue, out selectedMethod);
        }
        //jacob Added DISTINCT
        string SQL = "SELECT DISTINCT cp.cpPart AS PartNumber, " +
                     "       cp.cpDescrip AS Title,  " +
                     "       cv.cpvVolume AS Volume, " +
                     "       cp.cpUnitCnt AS UnitPack, " +
                     "       mat.T542_Sub_Short AS Matrix, " +
                     "       0 AS Price " +
                     "   FROM  cp_roi_Prods cp LEFT JOIN cp_roi_ProdFamilies pfam ON cp.cpPart = pfam.cpfProdID " +
					 "		 LEFT JOIN cp_roi_Families cpfam ON pfam.cpffamID = cpfam.cfID " +
                     "       LEFT JOIN cp_roi_Volumes AS cv ON cp.Cpvol = cv.cpvID " +
                     "       LEFT JOIN cp_roi_Matrix AS mat ON cp.cpMatrix = mat.T542_Code ";
        if (selectedMethod > 0) {
            SQL += " LEFT JOIN cp_roi_ProdCats AS pc ON pc.cpcProdID = cp.cpPart ";
        }
        
		/*SQL += "   WHERE pfam.cpffamID = " + SearchTerm +
                     "   AND cp.cpType = 2 " +
                     "   AND cp.For_Web = 'Y' ";
		*/
		
		//jacob ic-ise-standards merge with cyanide-standards
        if(SearchTerm == 4){
			SQL += "   WHERE (pfam.cpffamID =" + SearchTerm + " OR pfam.cpffamID = 5 OR pfam.cpffamID = 8)" +
                     "   AND cp.cpType = 2 " +
                     "   AND cp.For_Web = 'Y' ";	
		}else{
			 SQL += "   WHERE pfam.cpffamID = " + SearchTerm +
                     "   AND cp.cpType = 2 " +
                     "   AND cp.For_Web = 'Y' ";
		}
		
	
		if (selectedMethod > 0) {
            SQL += " AND pc.cpcCatID = " + selectedMethod.ToString() + " ";
        }
        SQL += "   ORDER BY cp.cpPart";
        //Response.Write(category);
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
        ProductListPagerSimple.PageSize = ProductListPagerSimple2.PageSize = pages;
        SetQuery();
        lvProducts.DataBind();
    }
	
    protected void cmdFilter_Click(object sender, EventArgs e) {
        Response.Redirect("search_inorganic_category.aspx");
    }
	
	protected void cmdFilterMobile_Click(object sender, EventArgs e) {
		string path = HttpContext.Current.Request.Url.AbsolutePath;
        if (ProductListMobilePager.PageSize > 25) {
            Response.Redirect(path + "?category=" + categoryMobile.SelectedValue + "&p=" + ProductListMobilePager.PageSize.ToString());
        } else {
            Response.Redirect(path + "?category=" + categoryMobile.SelectedValue);
        }
    }
	
	protected void selectedChange(object sender, EventArgs e) {
		string path = HttpContext.Current.Request.Url.AbsolutePath;
        if (ProductListPagerSimple.PageSize > 25) {
            Response.Redirect(path + "?category=" + category.SelectedValue + "&p=" + ProductListPagerSimple.PageSize.ToString());
        } else {
            Response.Redirect(path + "?category=" + category.SelectedValue);
        }
    }
	protected void techChange(object sender, EventArgs e) {
		Response.Redirect("/inorganic-standards/" + technique.SelectedValue);
    }
}