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

public partial class equipment_and_accessories_addtocart2 : System.Web.UI.Page
{
	protected int TotalProductCountNum2 = 0;	
    protected bool LoggedIn = false;
    protected string StartingPrice2 = "";
    protected string PartID = "";
	protected string qty = "";

    protected void Page_Load(object sender, EventArgs e)
    {
		qty = Request.QueryString["pq"];
		
        clsUser myUser = new clsUser();
        LoggedIn = myUser.LoggedIn;
        
		ltrCurrencySymbolHeader.Text = myUser.CurrencySymbol;
		
        clsShoppingCart myCart = new clsShoppingCart(myUser.UserID);
        myCart.RefreshPrices(myUser.Region, myUser.DiscountCode, myUser.PriceCode, myUser.DiscountAmount);
		TotalProductCountNum2 = myCart.TotalItemCountNum;
        StartingPrice2 = myCart.OrderSubtotal.ToString("##,##0.00");
		

    }
}