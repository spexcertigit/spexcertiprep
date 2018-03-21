using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class qc_sample : System.Web.UI.Page
{
    protected string sTitle = "";
    protected int ProductCount = 0;
    protected string Region = "US";
    protected string CurrencySymbol = "$";
    protected string CatCode = "1";
    protected clsUser myUser;

    protected void Page_Load(object sender, EventArgs e)
    {
        myUser = new clsUser();
        Region = myUser.Region;
        CurrencySymbol = myUser.CurrencySymbol;
        CatCode = myUser.DiscountCode;

		Page.Title = sTitle + " - Lab Stuff" + ConfigurationSettings.AppSettings["gsDefaultPageTitle"];
		
    }
    protected string GetPrice(string PartNumber) {
        clsItemPrice price = new clsItemPrice(PartNumber, myUser);
        return price.PriceText;
    }
	
	protected string GetLink(string Type) {
		string output = "";
        if (Type == "1") {
			output = "/products/product_organic.aspx";
		}else if (Type == "2") {
			output = "/products/product_inorganic.aspx";
		}else if (Type == "6") {
			output = "/products/product_labstuff.aspx";
		}
        return output;
    }
	
    protected void dataProducts_Selected(object sender, SqlDataSourceStatusEventArgs e) {
        ProductCount = e.AffectedRows;
        ProductListPagerSimple2.Visible = (ProductCount > ProductListPagerSimple2.PageSize);
		ProductListMobilePager.Visible = (ProductCount > ProductListMobilePager.PageSize);
    }

    protected void lbResults50_Click(object sender, EventArgs e) {
        ProductListPagerSimple.PageSize = ProductListPagerSimple2.PageSize = 25;
        lvProducts.DataBind();
    }
    protected void lbResults100_Click(object sender, EventArgs e) {
        ProductListPagerSimple.PageSize = ProductListPagerSimple2.PageSize = 50;
        lvProducts.DataBind();
    }
	
	protected void lbResults_Change(object sender, EventArgs e) {
		int pages = Int32.Parse(lbResults.SelectedValue);
        ProductListPagerSimple.PageSize = ProductListPagerSimple2.PageSize = pages;
        lvProducts.DataBind();
    }
}