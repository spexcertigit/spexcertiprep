using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class searchlab : System.Web.UI.Page
{
    protected string SearchTerm = "";

    protected clsUser myUser;

    protected void Page_Load(object sender, EventArgs e) {
        if (Request.QueryString["search"] != null) {
            SearchTerm = Request.QueryString["search"].ToString();
            if (SearchTerm.Length > 25) { SearchTerm = SearchTerm.Substring(0, 25); }
        }

        dataProducts.SelectParameters[0].DefaultValue = "%" + SearchTerm + "%";

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT COUNT(*) " +
							"FROM ( " +
							"SELECT * " +
							"FROM cp_roi_Prods " +
							"WHERE cpType = @Type AND (cpLongDescrip LIKE @Query OR cpPart LIKE @Query)  AND (For_Web = 'Y') " +
							") a";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@Query", SqlDbType.VarChar, 23).Value = "%" + SearchTerm + "%";
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
    }
    protected string GetPrice(string PartNumber) {
        clsItemPrice price = new clsItemPrice(PartNumber, myUser);
        return price.PriceText;
    }
	
    protected void lbResults_Change(object sender, EventArgs e) {
		int pages = Int32.Parse(lbResults.SelectedValue);
        ProductListPagerSimple2.PageSize = pages;
        lvProducts.DataBind();
    }
}