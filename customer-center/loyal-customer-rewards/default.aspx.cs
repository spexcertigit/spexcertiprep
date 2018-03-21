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
    protected int ProductCount = 0;
    protected clsUser myUser;
	
	protected bool LoggedIn = false;
	protected int cusID = 0;
    protected string DisplayName = "";
	
	protected int Spoints = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
		myUser = new clsUser();
        if (!myUser.LoggedIn) {
            //If user is not logged in
			Response.Redirect("/");
        } else {
            LoggedIn = true;
            DisplayName = myUser.FirstName + " " + myUser.LastName;
			cusID = myUser.UserID;
        }
		
		Page.Header.Title = "Loyal Customer Rewards | SPEX CertiPrep";
		
        SetQuery();
    }
	
	
    protected void dataProducts_Selected(object sender, SqlDataSourceStatusEventArgs e) {
        ProductCount = e.AffectedRows;
        ProductListPagerSimple.Visible = ProductListPagerSimple2.Visible = (ProductCount > ProductListPagerSimple.PageSize);
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
		
        string SQL = "SELECT wod.id, wod.orderdate, ISNULL(wod.Spoints, 0) AS points FROM WebOrderDetails AS wod INNER JOIN cp_roi_SOH AS crs ON crs.So_Nbr = wod.id WHERE wod.customer_id = '" + cusID +"' AND crs.Order_Status = 'C' ORDER BY wod.orderdate DESC";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				string p = "";
				while(dr.Read()) {
					p = dr["points"].ToString().Trim();
					if (p == "") { p = "0"; }
					Spoints = Spoints + Convert.ToInt32(p);
				}
			}
		}

        dataProducts.SelectCommand = SQL;
        dataProducts.DataBind();
    }
	
	
    protected void lbResults_Change(object sender, EventArgs e) {
        SetQuery();
        lvProducts.DataBind();
    }

}