using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class utility_updatequantity : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["itemid"] != null) {
            int ItemID = 0;
            if (Int32.TryParse(Request.QueryString["itemid"].ToString(), out ItemID)) {
                if (Request.QueryString["quantity"] != null) {
                    int qty = 0;
                    Int32.TryParse(Request.QueryString["quantity"].ToString(), out qty);
                    if (qty < 1) { qty = 1; }

                    clsUser myUser = new clsUser();
                    clsShoppingCart myCart = new clsShoppingCart(myUser.UserID);
                    myCart.UpdateItemQty(ItemID, qty);
                }
            }
        }
    }
}