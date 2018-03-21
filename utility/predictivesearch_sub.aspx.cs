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

public partial class inc_predictivesearch_sub : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        clsUser myLogin = new clsUser();
        StringBuilder sb = new StringBuilder();

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string Query = Request.QueryString["query"].ToString();
			Query = Query.Replace("'", "''");
            string SQL = "SELECT TOP 10 * " +
							"FROM ( " +
							"SELECT * " +
							"FROM cp_roi_Prods " +
							"WHERE cpLongDescrip LIKE '%" + Query + "%' or cpPart LIKE '%" + Query + "%'  AND (For_Web = 'Y') " +
							"UNION " +
							"SELECT p.* " + 
							"FROM certiComps c JOIN certiProdComps pc on c.cmpID = pc.cpmpCompID " +
							"JOIN cp_roi_Prods p ON pc.cpmpProdID = p.cpID " +
							"WHERE c.cmpCAS LIKE '" + Query + "%'  AND (For_Web = 'Y')) a ORDER BY cpDescrip";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (!dr.HasRows) {
                    sb.AppendLine("<strong>No Results</strong>");
                } else {
                    sb.AppendLine("<ul>");
                    while (dr.Read()) {
                        string LinkText = "";
                        string LinkDesc = "";

                        string ProductID = dr["cpPart"].ToString().Trim();
                        string ProductName = dr["cpDescrip"].ToString().Trim();
                        string ProductType = dr["cpType"].ToString().Trim();

                        if (ProductType == "1") {
	                        LinkText = "product_organic.aspx?part=" + ProductID;
	                        LinkDesc = "Organic Standards";
                        } else if (ProductType == "2") {
	                        LinkText = "product_inorganic.aspx?part=" + ProductID;
	                        LinkDesc = "Inorganic Standards";
                        } else if (ProductType == "3") {
	                        LinkText = "product_inorganic.aspx?part=" + ProductID;
	                        LinkDesc = "Category 3";
                        } else if (ProductType == "4") {
	                        LinkText = "product_inorganic.aspx?part=" + ProductID;
	                        LinkDesc = "Category 4";
                        } else if (ProductType == "6") {
	                        LinkText = "product_labstuff.aspx?part=" + ProductID;
	                        LinkDesc = "Lab Stuff";
                        }

                        sb.AppendLine("<li onclick=\"document.location.href='/products/" + LinkText + "';\">" + ProductName);
                        sb.AppendLine("<br /><span class='predictivesearch_info'>" + ProductID + " - " + LinkDesc + "</span></li>");
                    }
                }
                cmd.Connection.Close();
                sb.AppendLine("</ul>");
            }
        }

        ltrSearch.Text = sb.ToString();

    }
}