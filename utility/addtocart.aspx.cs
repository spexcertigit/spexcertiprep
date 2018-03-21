using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text.RegularExpressions;

public partial class equipment_and_accessories_addtocart : System.Web.UI.Page
{
    protected string ProductCountText = "";
	protected int ProductCountNum = 0;	
	protected int TotalProductCountNum = 0;	
    protected bool LoggedIn = false;
    protected string StartingPrice = "";
    protected string FinalDiscount = "";
    protected string TotalSpoints = "0";
    protected string PartID = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        PartID = Request.QueryString["productid"].ToString();
        int Quantity = 0;
        Int32.TryParse(Request.QueryString["pq"].ToString(), out Quantity);
        if (Quantity == 0) { Quantity = 1; }

        clsUser myUser = new clsUser();
        LoggedIn = myUser.LoggedIn;
        ltrCurrencySymbol.Text = myUser.CurrencySymbol;
		
		ltrLoadSmallCart.Text = "<script>" +
									"$('.headerCart').load('/utility/addtosmallcart.aspx?pq="+ Quantity +"');" +
									"$('.itemAdd').load('/utility/addtosmallcart.aspx?pq="+ Quantity +"');" +
								"</script>";
								
        clsShoppingCart myCart = new clsShoppingCart(myUser.UserID);
        myCart.AddItem(PartID, Quantity);
        myCart.RefreshPrices(myUser.Region, myUser.DiscountCode, myUser.PriceCode, myUser.DiscountAmount);
        ProductCountText = myCart.ItemCountText;
		ProductCountNum = myCart.ItemCountNum;
		TotalProductCountNum = myCart.TotalItemCountNum;
        StartingPrice = myCart.OrderSubtotal.ToString("##,##0.00");
        FinalDiscount = myCart.DiscountTotal.ToString("##,##0.00");
        TotalSpoints = myCart.SPoints.ToString();
    }
}