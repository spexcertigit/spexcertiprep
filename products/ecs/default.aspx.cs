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

public partial class ecs_parts : System.Web.UI.Page
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
	
        //dim CatCode
		int SearchTerm = 0;
        if (Request.QueryString["cat"] != null) { 
			Int32.TryParse(Request.QueryString["cat"].ToString(), out SearchTerm);
		}

        myUser = new clsUser();
        Region = myUser.Region;
        CurrencySymbol = myUser.CurrencySymbol;
        CatCode = myUser.DiscountCode;

        switch (SearchTerm) {
            case 1:
                sTitle = "Gas Chromatography Standards";
                break;
            case 2:
                sTitle = "GC/MS Standards";
                break;
            case 3:
                sTitle = "Liquid Chromatography Standards";
                break;
            case 4:
                sTitle = "LC/MS Standards";
                break;
        }

        if (!Page.IsPostBack) {
            //Select the right item from the Technique dropdown
            technique.Items.Clear();
            technique.Items.Add(new ListItem("-- Select Technique --", "0"));
            technique.DataBind();
            ListItem li = technique.Items.FindByValue(SearchTerm.ToString());
            if (li != null) { li.Selected = true; }

            //Select the right item from the Application dropdown
            int selectedFamily = 0;
            if (Request.QueryString["family"] != null) {
                Int32.TryParse(Request.QueryString["family"].ToString(), out selectedFamily);
                if (selectedFamily > 0) {
                    family.DataBind();
                    li = family.Items.FindByValue(selectedFamily.ToString());
                    if (li != null) { li.Selected = true; }
                }
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

			Page.Title = "ECS Parts | SPEX CertiPrep";

            SetQuery();
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
    protected void dataProducts_Selected(object sender, SqlDataSourceStatusEventArgs e) {
        ProductCount = e.AffectedRows;
        ProductListPagerSimple.Visible = ProductListPagerSimple2.Visible = (ProductCount > ProductListPagerSimple.PageSize);
		ProductListMobilePager.Visible = (ProductCount > ProductListMobilePager.PageSize);	
    }

    private void SetQuery() {
        int selectedFamily = 0;
        if (Request.QueryString["family"] != null) {
            Int32.TryParse(Request.QueryString["family"].ToString(), out selectedFamily);
        }
        int selectedMethod = 0;
        if (Request.QueryString["method"] != null) {
            Int32.TryParse(Request.QueryString["method"].ToString(), out selectedMethod);
        }

        string SQL = "SELECT cp.cpPart AS PartNumber, " +
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
        SQL += "   WHERE cp.cpPart LIKE 'ECS%'" +
                     "   AND cp.cpType = 1 " +
                     "   AND cp.For_Web = 'Y' ";
					 
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
	
    protected void lbResults_Change(object sender, EventArgs e) {
		int pages = Int32.Parse(lbResults.SelectedValue);
        ProductListPagerSimple.PageSize = ProductListPagerSimple2.PageSize = pages;
        SetQuery();
        lvProducts.DataBind();
    }
	
    protected void cmdFilter_Click(object sender, EventArgs e) {
        Response.Redirect("default.aspx");
    }
	 protected void cmdFilterMobile_Click(object sender, EventArgs e) {
        Response.Redirect("default.aspx?method=" + s_methodMobile.SelectedValue + "&family=" + familyMobile.SelectedValue + "&cat=" + techniqueMobile.SelectedValue);
    }
	protected void selectedChange(object sender, EventArgs e) {
		Response.Redirect("default.aspx?method=" + s_method.SelectedValue + "&family=" + family.SelectedValue + "&cat=" + technique.SelectedValue);
	}	
    /*
	protected void ProductListPagerSimple_PreRender(object sender, EventArgs e)
    {
        int CurrentPage = 0;
		int SecondtoLastPage = 0;
		
        Int32.TryParse(Request.QueryString["page"], out CurrentPage);
        CurrentPage = CurrentPage.Equals(0) ? 1 : CurrentPage;
		SecondtoLastPage = ProductListPagerSimple.TotalRowCount / ProductListPagerSimple.MaximumRows;
 
        HyperLink FirstLink = ProductListPagerSimple.Controls[0].Controls[0] as HyperLink;
		HyperLink PreviousLink = ProductListPagerSimple.Controls[0].Controls[1] as HyperLink;
        HyperLink LastLink = ProductListPagerSimple.Controls[2].Controls[1] as HyperLink;
		HyperLink NextLink = ProductListPagerSimple.Controls[2].Controls[0] as HyperLink;
        if (PreviousLink != null)
        {
            if (CurrentPage.Equals(1))
            {
                PreviousLink.Visible = false;
				FirstLink.Visible = false;
            }
			else if (CurrentPage.Equals(2))
            {
                PreviousLink.Visible = true;
				FirstLink.Visible = false;
            }
            else if (CurrentPage > 2)
            {
                PreviousLink.Visible = true;
				FirstLink.Visible = true;
            }
        }
        if (NextLink != null)
        {
            if ((CurrentPage * ProductListPagerSimple.PageSize) >= ProductListPagerSimple.TotalRowCount)
            {
                NextLink.Visible = false;
				LastLink.Visible = false;
            }
			else if (CurrentPage.Equals(SecondtoLastPage))
            {
                NextLink.Visible = true;
				LastLink.Visible = false;
            }
            else
            {
                NextLink.Visible = true;
				LastLink.Visible = true;
            }
        }
    }
	
	protected void ProductListPagerSimple2_PreRender(object sender, EventArgs e)
    {
        int CurrentPage = 0;
		int SecondtoLastPage = 0;
		
        Int32.TryParse(Request.QueryString["page"], out CurrentPage);
        CurrentPage = CurrentPage.Equals(0) ? 1 : CurrentPage;
		SecondtoLastPage = ProductListPagerSimple2.TotalRowCount / ProductListPagerSimple2.MaximumRows;
 
        HyperLink FirstLink = ProductListPagerSimple2.Controls[0].Controls[0] as HyperLink;
		HyperLink PreviousLink = ProductListPagerSimple2.Controls[0].Controls[1] as HyperLink;
        HyperLink LastLink = ProductListPagerSimple2.Controls[2].Controls[1] as HyperLink;
		HyperLink NextLink = ProductListPagerSimple2.Controls[2].Controls[0] as HyperLink;
        if (PreviousLink != null)
        {
            if (CurrentPage.Equals(1))
            {
                PreviousLink.Visible = false;
				FirstLink.Visible = false;
            }
			else if (CurrentPage.Equals(2))
            {
                PreviousLink.Visible = true;
				FirstLink.Visible = false;
            }
            else if (CurrentPage > 2)
            {
                PreviousLink.Visible = true;
				FirstLink.Visible = true;
            }
        }
        if (NextLink != null)
        {
            if ((CurrentPage * ProductListPagerSimple2.PageSize) >= ProductListPagerSimple2.TotalRowCount)
            {
                NextLink.Visible = false;
				LastLink.Visible = false;
            }
			else if (CurrentPage.Equals(SecondtoLastPage))
            {
                NextLink.Visible = true;
				LastLink.Visible = false;
            }
            else
            {
                NextLink.Visible = true;
				LastLink.Visible = true;
            }
        }
    }*/
		
}