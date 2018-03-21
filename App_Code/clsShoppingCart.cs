using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text.RegularExpressions;
using System.Net.Mail;
using System.Text;

/// <summary>
/// Summary description for clsShoppingCart
/// </summary>
public class clsShoppingCart
{
    private int _UserID = 0;
    private int _ItemCount = -1;
    public int ItemCount {
        get {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
                string SQL = "SELECT COUNT(*) AS RecordCount FROM sprepPersistentCart WHERE userid = @UserID AND purchased = 'n'";
                using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = _UserID;
                    cmd.Connection.Open();
                    _ItemCount = Convert.ToInt32(cmd.ExecuteScalar());
                    cmd.Connection.Close();
                }
            }
         
            return _ItemCount;
        }
    }
	//Total Cart Item
	private int _TotalItemCount = -1;
	public int TotalItemCount {
        get {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
                string SQL = "SELECT SUM(quantity) AS QuantityCount FROM sprepPersistentCart WHERE userid = @UserID AND purchased = 'n'";
                using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = _UserID;
                    cmd.Connection.Open();
					SqlDataReader dr = cmd.ExecuteReader();
					if (dr.HasRows) {
						dr.Read();
						if (!Convert.IsDBNull(dr["QuantityCount"])) {
							_TotalItemCount = Convert.ToInt32(dr["QuantityCount"]);
						}
						else {
							_TotalItemCount = 0;
						}
					}
					else {
						_TotalItemCount = -5;
					}
					//if (! DBNull.Value.Equals(row['QuantityCount'])) {
					//	_TotalItemCount = Convert.ToInt32(cmd.ExecuteScalar());
					//}
					//else {
					//	_TotalItemCount = 0;
					//}
                    cmd.Connection.Close();
                }
            }
            return _TotalItemCount;
        }
    }
	//EOF Total Cart Item
    private int _SPoints = 0;
    public int SPoints {
        get {
            return _SPoints;
        }
    }
    public string ItemCountText {
        get {
            if (_ItemCount == -1) { int temp = this.ItemCount; }
            if (_ItemCount == 0) {
                return "No Items";
            } else if (_ItemCount == 1) {
                return "1 item";
            } else {
                return _ItemCount.ToString() + " items";
            }
        }
    }
    public int ItemCountNum {
        get {
            if (_ItemCount == -1) { int temp = this.ItemCount; }
			
            return _ItemCount;
        }
    }
	public int TotalItemCountNum {
        get {
            if (_TotalItemCount == -1) { int temp = this.TotalItemCount; }
			if (_TotalItemCount == 0) {
                return 0;
            }
			else{
				return _TotalItemCount;
			}
        }
    }
    private double _OrderSubtotal = 0;
    public double OrderSubtotal {
        get {
            return _OrderSubtotal;
        }
    }
	private double _DCOrderSubtotal = 0;
    public double DCOrderSubtotal {
        get {
            return _DCOrderSubtotal;
        }
    }
    private double _OrderTotal = 0;
    public double OrderTotal {
        get {
            return _OrderTotal;
        }
    }
    private double _DiscountSubtotal = 0;
    public double DiscountSubtotal {
        get {
            return _DiscountSubtotal;
        }
    }
    private double _DiscountTotal = 0;
    public double DiscountTotal {
        get {
            return _DiscountTotal;
        }
    }
    public string PromoCode {
        get {
            if (HttpContext.Current.Session["promocode"] != null) {
                return HttpContext.Current.Session["promocode"].ToString();
            } else {
                return "";
            }
        }
        set {
            if (value.Length > 0) {
                HttpContext.Current.Session["promocode"] = value;
                this.InitializePromoCode(value);
            } else {
                HttpContext.Current.Session["promocode"] = null;
                _PromoDescription = "";
                _PromoOrderValue = 0;
                _PromoAmountDiscount = 0;
                _PromoPercentDiscount = 0;
            }
        }
    }
    private string _PromoDescription = "";
    private double _PromoOrderValue = 0;
    private double _PromoAmountDiscount = 0;
    private double _PromoPercentDiscount = 0;

	private bool _ShowPromotionAlert = false;
    public bool ShowPromotionAlert {
        get {
            return _ShowPromotionAlert;
        }
    }
    private bool _ShowShippingAlert = false;
    public bool ShowShippingAlert {
        get {
            return _ShowShippingAlert;
        }
    }
    private bool _ShowRefrigeratorAlert = false;
    public bool ShowRefrigeratorAlert {
        get {
            return _ShowRefrigeratorAlert;
        }
    }
    private bool _ShowFreezerAlert = false;
    public bool ShowFreezerAlert {
        get {
            return _ShowFreezerAlert;
        }
    }
	private string _OrderID = "";
	public string OrderID {
		get {
			return _OrderID;
		}
	}

    private List<ShoppingCartItem> _ItemList = new List<ShoppingCartItem>();
    public List<ShoppingCartItem> ItemList {
        get {
            return _ItemList;
        }
    }

    public clsShoppingCart(int UserID)
	{
        _UserID = UserID;
        if (PromoCode.Length > 0) { InitializePromoCode(PromoCode); }
	}

    public void AddItem(string PartID, int Quantity) {
        if (Quantity < 1) { Quantity = 1; }
        // check shopping cart table for existing items
        bool AddIt = true;
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            int CartID = 0;

            //See if the part is already in the catalog
            string SQL = "SELECT * FROM sprepPersistentCart WHERE userid = @UserID AND part_id = @PartID AND purchased = 'n'";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = _UserID;
                cmd.Parameters.Add("@PartID", SqlDbType.VarChar, 20).Value = PartID;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                if (dr.HasRows) {
                    AddIt = false;
                    dr.Read();
                    CartID = Convert.ToInt32(dr["id"]);
                }
                cmd.Connection.Close();
            }

            if (AddIt) {
                SQL = "INSERT INTO sprepPersistentCart (userid, part_id, part_desc, quantity, purchased) " +
                    "SELECT @UserID, cpPart, cpDescrip, @Quantity, 'n' " +
                    "FROM cp_roi_Prods " +
                    "WHERE cpPart = @PartID";
                using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = _UserID;
                    cmd.Parameters.Add("@PartID", SqlDbType.VarChar, 20).Value = PartID;
                    cmd.Parameters.Add("@Quantity", SqlDbType.Int).Value = Quantity;
                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                    cmd.Connection.Close();
                }
            } else {
                //Update it
                SQL = "UPDATE sprepPersistentCart SET quantity = quantity + @NewQuantity WHERE id = @CartID";
                using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("@CartID", SqlDbType.Int).Value = CartID;
                    cmd.Parameters.Add("@NewQuantity", SqlDbType.Int).Value = Quantity;
                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                    cmd.Connection.Close();
                }
            }
        }
    }
    public void RemoveItem(int ItemID) {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "DELETE FROM sprepPersistentCart WHERE userid = @UserID AND id = @id";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = _UserID;
                cmd.Parameters.Add("@ID", SqlDbType.Int).Value = ItemID;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
        }
    }
    public void UpdateItemQty(int ItemID, int Qty) {
        if (Qty < 1) { Qty = 1; }
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "UPDATE sprepPersistentCart SET Quantity = @NewQuantity WHERE userid = @UserID AND id = @id";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = _UserID;
                cmd.Parameters.Add("@ID", SqlDbType.Int).Value = ItemID;
                cmd.Parameters.Add("@NewQuantity", SqlDbType.Int).Value = Qty;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
        }
    }

    public void SaveOrder(
        string Region,
        string SPEXaccount,
        string FullUserName,
        string UserEmail,
        string DiscountCode,
        string PriceCode,
        double CustDiscountMult,
        string sales_quote,
        string review_promocode,
        string shipmethod,
        string ShipAccountNo,
        bool PermitPartial,
        string billFirstname,
        string billLastname,
        string billOrganization,
        string billPhone,
        string billFax,
        string billAddress1,
        string billAddress2,
        string billCity,
        string billState,
        string billZIP,
        string billPO,
        string CardType,
        string CardNumber,
        string ExpirationMonth,
        string ExpirationYear,
        string CVV,
        string shipFirstname,
        string shipLastname,
        string shipPhone,
        string shipFax,
        bool chkResidential,
		string shipOrganization,
		string shipAddress1,
        string shipAddress2,
        string shipCity,
        string shipState,
        string shipZIP,
		string Notes
        ) {
	    // add order to web orders table
	
        RefreshPrices(Region, DiscountCode, PriceCode, CustDiscountMult);
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "sp_certiInsertWebOrderDetails";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@site", SqlDbType.VarChar, 5).Value = "CP";
                cmd.Parameters.Add("@customer_id", SqlDbType.VarChar, 20).Value = _UserID.ToString();
                cmd.Parameters.Add("@spex_account", SqlDbType.VarChar, 50).Value = SPEXaccount;
                cmd.Parameters.Add("@organization", SqlDbType.VarChar, 100).Value = billOrganization;
                cmd.Parameters.Add("@billing_address1", SqlDbType.VarChar, 200).Value = billAddress1;
                cmd.Parameters.Add("@billing_address2", SqlDbType.VarChar, 200).Value = billAddress2;
                cmd.Parameters.Add("@billing_city", SqlDbType.VarChar, 200).Value = billCity;
                cmd.Parameters.Add("@billing_area", SqlDbType.VarChar, 200).Value = billState;
                cmd.Parameters.Add("@billing_postcode", SqlDbType.VarChar, 20).Value = billZIP;
                cmd.Parameters.Add("@billing_country", SqlDbType.VarChar, 50).Value = Region;
				cmd.Parameters.Add("@shipping_organization", SqlDbType.VarChar, 200).Value = shipOrganization;
				cmd.Parameters.Add("@shipping_address1", SqlDbType.VarChar, 200).Value = shipAddress1;
				cmd.Parameters.Add("@shipping_address2", SqlDbType.VarChar, 200).Value = shipAddress2;
                cmd.Parameters.Add("@shipping_city", SqlDbType.VarChar, 200).Value = shipCity;
                cmd.Parameters.Add("@shipping_area", SqlDbType.VarChar, 200).Value = shipState;
                cmd.Parameters.Add("@shipping_postcode", SqlDbType.VarChar, 20).Value = shipZIP;
                cmd.Parameters.Add("@shipping_country", SqlDbType.VarChar, 50).Value = Region;
				cmd.Parameters.Add("@shipping_method", SqlDbType.VarChar, 50).Value = shipmethod;
				cmd.Parameters.Add("@notes", SqlDbType.VarChar).Value = Notes;
				cmd.Parameters.Add("@discount_code", SqlDbType.VarChar, 50).Value = review_promocode;
                cmd.Parameters.Add("@permit_partial", SqlDbType.VarChar, 5).Value = PermitPartial ? "Y" : "";
				if (CardNumber.Length > 0) {
					cmd.Parameters.Add("@payment_method", SqlDbType.VarChar, 20).Value = "Credit Card";
				} else {
					cmd.Parameters.Add("@payment_method", SqlDbType.VarChar, 20).Value = "Purchase Order";
                }
				cmd.Parameters.Add("@PO_number", SqlDbType.VarChar, 50).Value = billPO;
				cmd.Parameters.Add("@card_number", SqlDbType.VarChar, 20).Value = CardNumber;
				cmd.Parameters.Add("@card_expiry", SqlDbType.VarChar, 20).Value = ExpirationMonth + "-" + ExpirationYear;
				cmd.Parameters.Add("@card_cvv", SqlDbType.VarChar, 5).Value = CVV;

                cmd.Parameters.Add("@sales_quote_number", SqlDbType.VarChar, 50).Value = sales_quote;
                cmd.Parameters.Add("@paid", SqlDbType.VarChar, 5).Value = 'n';
                cmd.Parameters.Add("@fulfilled", SqlDbType.VarChar, 5).Value = 'n';
                cmd.Parameters.Add("@FinalPrice", SqlDbType.VarChar, 30).Value = _OrderTotal.ToString("##,##0.00");
                cmd.Parameters.Add("@TotalDiscount", SqlDbType.VarChar, 30).Value = _DiscountTotal.ToString("##,##0.00");
                cmd.Parameters.Add("@Spoints", SqlDbType.VarChar, 10).Value = "";
                cmd.Parameters.Add("@carrier", SqlDbType.VarChar, 30).Value = "";
                cmd.Parameters.Add("@Billing_Name", SqlDbType.VarChar, 50).Value = billFirstname + " " + billLastname;
                cmd.Parameters.Add("@user_name", SqlDbType.VarChar, 50).Value = FullUserName;
                cmd.Parameters.Add("@carrier_acct", SqlDbType.VarChar, 30).Value = ShipAccountNo;
                cmd.Parameters.Add("@card_type", SqlDbType.VarChar, 25).Value = CardType;

                cmd.Parameters.Add("@UserEmail", SqlDbType.VarChar, 80).Value = UserEmail;
                cmd.Parameters.Add("@BillPhone", SqlDbType.VarChar, 80).Value = billPhone;
                cmd.Parameters.Add("@ShipPhone", SqlDbType.VarChar, 80).Value = shipPhone;


                cmd.Parameters.Add("RETURN", SqlDbType.Int);
                cmd.Parameters["RETURN"].Direction = ParameterDirection.ReturnValue;

                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
	            // get order id of last order
				_OrderID = cmd.Parameters["RETURN"].Value.ToString();
                cmd.Connection.Close();
            }
			
			SQL = "INSERT INTO certiCouponCheck (userID, PromoCode, date_used) VALUES (@UserID, @PromoCode, CURRENT_TIMESTAMP)";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = _UserID;
				cmd.Parameters.Add("@PromoCode", SqlDbType.NVarChar, 100).Value = this.PromoCode;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
            // Correct error where items can have zero qualtity
            SQL = "UPDATE sprepPersistentCart " +
                    "SET quantity = 1 " +
                    "WHERE quantity < 1 AND userid = @UserID AND purchased = 'n'";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = _UserID;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
			
			string perCart_Part = "";
			
			SQL = "SELECT part_id FROM sprepPersistentCart " +
                    "WHERE userid = @UserID AND purchased = 'n'";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = _UserID;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					dr.Read();
					perCart_Part = dr["part_id"].ToString();
				}
                cmd.Connection.Close();
            }
            
            // pull items out of persistent cart and add them to the web order items table
            //SQL = "INSERT INTO WebOrderItems (customer_id, item_id, item_quantity, date_ordered, Order_Number, cpID, ItemListPrice, ItemDiscountAmount) " + "SELECT userid, part_id, quantity, GETDATE(), " + _OrderID + ", " + getCPID(perCart_Part) + ", " + getItemPrice(Region, perCart_Part) + ", " + getItemDiscount(Region, perCart_Part, DiscountCode) + " " + "FROM sprepPersistentCart " + "WHERE userid = @UserID AND purchased = 'n'";
			decimal itemDCd = 0;
			decimal itemDC = 0;
			decimal itemP = 0;
			foreach (ShoppingCartItem si in ItemList) {
				itemDCd = Convert.ToDecimal(si.LineCost) / Convert.ToDecimal(si.Qty);
				itemDC = Convert.ToDecimal(si.BaseCost) - itemDCd;
				
				SQL = "INSERT INTO WebOrderItems (customer_id, item_id, item_quantity, date_ordered, Order_Number, cpID, ItemListPrice, ItemDiscountAmount, ItemFinalPrice) VALUES ('" + _UserID + "', '" + si.PartNumber + "', '" + si.Qty.ToString() + "', GETDATE(), '" + _OrderID + "', '" + getCPID(si.PartNumber) + "', '" + si.BaseCost + "', '" + getItemDiscount(Region, si.PartNumber, DiscountCode, itemDC.ToString()) + "', '" + getFinalPrice(si.PartNumber, DiscountCode, itemDCd.ToString()) + "')";
				using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
					cmd.CommandType = CommandType.Text;
					cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = _UserID;
					cmd.Connection.Open();
					cmd.ExecuteNonQuery();
					cmd.Connection.Close();
				}
			}
			
			SQL = "UPDATE WebOrderDetails " + 
                    "SET ROICompleteFlg = 1 " + 
                    "WHERE id = @OrderID";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@OrderID", SqlDbType.VarChar, 10).Value = _OrderID;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
			
            //update persistent cart to show items have been ordered
            SQL = "UPDATE sprepPersistentCart " + 
                    "SET purchased = 'y', " + 
                    "PurchaseDate = GETDATE(), " + 
                    "Order_Number = @OrderID " + 
                    "WHERE userid = @UserID AND purchased = 'n'";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = _UserID;
				cmd.Parameters.Add("@OrderID", SqlDbType.VarChar, 10).Value = _OrderID;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
        }
	    
        // send email to SPEX with order info
        string CurrencySymbol = "$";
        if (Region == "UK") {
            CurrencySymbol = "&pound;";
        }

        StringBuilder sbCart = new StringBuilder();
        sbCart.AppendLine("<table>");
        sbCart.AppendLine("<thead>");
        sbCart.AppendLine("<tr>");
        sbCart.AppendLine("<th>Part</th>");
        sbCart.AppendLine("<th>Description</th>");
        sbCart.AppendLine("<th>Quantity</th>");
        sbCart.AppendLine("<th style='text-align:right'>Price</th>");
        sbCart.AppendLine("<th style='text-align:right'>Total</th>");
        sbCart.AppendLine("</tr>");
        sbCart.AppendLine("</thead>");
        sbCart.AppendLine("<tbody>");
        foreach (ShoppingCartItem si in ItemList) {
            sbCart.AppendLine("<tr>");
            sbCart.AppendLine("<td>" + si.PartNumber + "</td>");
            sbCart.AppendLine("<td>" + si.ProdTitle + "</td>");
            sbCart.AppendLine("<td>" + si.Qty.ToString() + "</td>");
            sbCart.AppendLine("<td style='text-align:right'>" + CurrencySymbol + si.BaseCost.ToString("##,##0.00") + "</td>");
            sbCart.AppendLine("<td style='text-align:right'>" + CurrencySymbol + si.LineCost.ToString("##,##0.00") + "</td>");
            sbCart.AppendLine("</tr>");
        }
        sbCart.AppendLine("<tr>");
        sbCart.AppendLine("<td colspan='3' style='text-align:right'>SUBTOTAL:</td>");
        sbCart.AppendLine("<td colspan='2' style='text-align:right'><b>" + CurrencySymbol + _OrderSubtotal.ToString("##,##0.00") + "</b></td>");
        sbCart.AppendLine("</tr><tr>");
        sbCart.AppendLine("<td colspan='3' style='text-align:right'>TOTAL SAVINGS:</td>");
        sbCart.AppendLine("<td colspan='2' style='text-align:right'><b>" + CurrencySymbol + _DiscountTotal.ToString("##,##0.00") + "</b></td>");
        sbCart.AppendLine("</tr><tr>");
        sbCart.AppendLine("<td colspan='3' style='text-align:right'>SPOINTS EARNED:</td>");
        sbCart.AppendLine("<td colspan='2' style='text-align:right'><b>" + _SPoints.ToString("##,##0.00") + "</b></td>");
        sbCart.AppendLine("</tr><tr>");
        sbCart.AppendLine("<td colspan='3' style='text-align:right'>SALES TAX:</td>");
        sbCart.AppendLine("<td colspan='2' style='text-align:right'><b>" + CurrencySymbol + "0.00</b></td>");
        sbCart.AppendLine("</tr><tr>");
        sbCart.AppendLine("<td colspan='3' style='text-align:right'>SHIPPING METHOD:</td>");
        sbCart.AppendLine("<td colspan='2' style='text-align:right'>" + shipmethod);
        sbCart.AppendLine("<div>" + ShipAccountNo + "</div>");
        sbCart.AppendLine("</td>");
        sbCart.AppendLine("</tr><tr>");
        sbCart.AppendLine("<td colspan='3' style='text-align:right'><div>FINAL TOTAL:</div>(SHIPPING NOT INCLUDED)</td>");
        sbCart.AppendLine("<td colspan='2' style='text-align:right'><b>" + CurrencySymbol + _OrderTotal.ToString("##,##0.00") + "</b></td>");
        sbCart.AppendLine("</tr>");
        if (this.PromoCode.Length > 0) {
            sbCart.AppendLine("<tr>");
            sbCart.AppendLine("<td colspan='3' style='text-align:right'><div>PROMOTION CODE:</div>(SHIPPING NOT INCLUDED)</td>");
            sbCart.AppendLine("<td colspan='2' style='text-align:right'><b>" + this.PromoCode + "</b><br />" + this._PromoDescription + "</td>");
            sbCart.AppendLine("</tr>");

        }
        sbCart.AppendLine("</tbody>");
        sbCart.AppendLine("</table>");

        string CustomerNumberText = "Not yet assigned";
        if (SPEXaccount != ""){
            CustomerNumberText = SPEXaccount;
        }
        string PartialOrder = PermitPartial ? "Yes" : "No";

        string ReceiptSection2 = "<table width='500' border='1'>" +
                          "<tr><th colspan='2'>Account Holder</th></tr>" +
						  "<tr><td>Web OrderID:</td><td><b>" + _OrderID + "</b></td></tr>" +
                          "<tr><td width='250'>Customer UserID:</td><td><b>" + _UserID + "</b></td></tr>" +
                          "<tr><td>Customer Number:</td><td><b>" + CustomerNumberText + "</b></td></tr>" +
                          "</table>";

        string ReceiptSection3 = "<table width='500' border='1'>" + 
                          "<tr><th colspan='2'>About You</th></tr>" + 
                          "<tr><td width='250'>Name:</td><td><b>" +  FullUserName + "</b></td></tr>" +
                          "<tr><td width='250'>Email Address:</td><td><b>" + UserEmail + "</b></td></tr>" + 
                          "</table>";

        string ReceiptSection4 = "<table width='500' border='1'>" + 
                          "<tr><th colspan='2'>Billing Information</th></tr>" + 
                          "<tr><td width='250'>Company:</td><td><b>" +  billOrganization + "</b></td></tr>" + 
                          "<tr><td width='250'>Address1:</td><td><b>" +  billAddress1 + "</b></td></tr>" + 
                          "<tr><td width='250'>Address2:</td><td><b>" +  billAddress2 + "</b></td></tr>" + 
                          "<tr><td width='250'>City:</td><td><b>" +  billCity + "</b></td></tr>" + 
                          "<tr><td width='250'>State:</td><td><b>" +  billState + "</b></td></tr>" + 
                          "<tr><td width='250'>Zip Code:</td><td><b>" +  billZIP + "</b></td></tr>" + 
                          "<tr><td width='250'>State:</td><td><b>" +  billState + "</b></td></tr>" + 
                          "<tr><td width='250'>Country:</td><td><b>" +  Region + "</b></td></tr>" + 
                          "<tr><td width='250'>Phone:</td><td><b>" +  billPhone + "</b></td></tr>" + 
                          "<tr><td width='250'>Fax:</td><td><b>" +  billFax + "</b></td></tr>" + 
                          "</table>";
				  
        string ReceiptSection5 = "<table width='500' border='1'>" + 
                          "<tr><th colspan='2'>Shipping Information</th></tr>" + 
                          "<tr><td width='250'>First Name:</td><td><b>" +  shipFirstname + "</b></td></tr>" + 
                          "<tr><td width='250'>Last Name:</td><td><b>" +  shipLastname + "</b></td></tr>" +
						  "<tr><td width='250'>Organization:</td><td><b>" + shipOrganization + "</b></td></tr>" +
						  "<tr><td width='250'>Address1:</td><td><b>" + shipAddress1 + "</b></td></tr>" +
						  "<tr><td width='250'>Address2:</td><td><b>" + shipAddress2 + "</b></td></tr>" + 
                          "<tr><td width='250'>City:</td><td><b>" +  shipCity + "</b></td></tr>" + 
                          "<tr><td width='250'>State:</td><td><b>" +  shipState + "</b></td></tr>" + 
                          "<tr><td width='250'>Zip Code:</td><td><b>" +  shipZIP + "</b></td></tr>" + 
                          "<tr><td width='250'>Country:</td><td><b>" +  Region + "</b></td></tr>" + 
                          "<tr><td width='250'>Partial Order:</td><td><b>" +  PartialOrder + "</b></td></tr>" + 
                          "<tr><td width='250'>Phone:</td><td><b>" +  shipPhone + "</b></td></tr>" + 
                          "<tr><td width='250'>Fax:</td><td><b>" +  shipFax + "</b></td></tr>" + 
                          "<tr><td width='250'>Shipping Method:</td><td><b>" +  shipmethod + "</b></td></tr>" +
							"<tr><td width='250'>Carrier Account:</td><td><b>" + ShipAccountNo + "</b></td></tr>" +
							"<tr><td width='250'>Comments / Special Requests:</td><td><b>" + Notes + "</b></td></tr>" +
							"</table>";

        string ReceiptSection6 = "";
		if (CardNumber.Length > 0 ) {
			ReceiptSection6 = "<table width='500' border='1'>" + 
                        "<tr><th height='15' colspan='2'>Payment Information</th></tr>" + 
                        "<tr><td width='250'>Payment Method:</td><td><b>Credit Card</b></td></tr>" + 
                        "<tr><td width='250'>Billing First Name:</td><td><b>" +  billFirstname + "</b></td></tr>" + 
                        "<tr><td width='250'>Billing Last Name:</td><td><b>" +  billLastname + "</b></td></tr>" +
                        "<tr><td width='250'>Credit Card Type:</td><td><b>" +  CardType  + "</b></td></tr>" + 
                        "<tr><td width='250'>Credit Card Number:</td><td><b>XXXXXXXXX" +  CardNumber.Substring(CardNumber.Length - 4)  + "</b></td></tr>" + 
                        "<tr><td width='250'>Expiration:</td><td><b>" +  ExpirationMonth + "-" + ExpirationYear + "</b></td></tr>" + 
                        "<tr><td width='250'>CVV:</td><td><b>" +  CVV + "</b></td></tr>";

			if (billPO.Length > 0) {
				ReceiptSection6 += "<tr><td width='250'>PO Number:</td><td><b>" + billPO + "</b></td></tr>";
			}
			ReceiptSection6 += "</table>";
		} else if (billPO.Length > 0) {
			ReceiptSection6 = "<table width='500' border='1'>" +
							  "<tr><th height='15' colspan='2'>Payment Information</th></tr>" +
							  "<tr><td width='250'>Payment Method:</td><td><b>Purchase Order</b></td></tr>" +
							  "<tr><td width='250'>Billing First Name:</td><td><b>" + billFirstname + "</b></td></tr>" +
							  "<tr><td width='250'>Billing Last Name:</td><td><b>" + billLastname + "</b></td></tr>" +
							  "<tr><td width='250'>PO Number:</td><td><b>" + billPO + "</b></td></tr>" +
							  "</table>";
		}

		StringBuilder sb = new StringBuilder();
        sb.AppendLine("<html><body>");
        sb.AppendLine(sbCart.ToString());
        sb.AppendLine("<br />" + ReceiptSection2);
        sb.AppendLine("<br />" + ReceiptSection3);
        if (Region == "UK" || Region == "USA") {
            sb.AppendLine("<br />" + ReceiptSection4);
        }
        sb.AppendLine("<br />" + ReceiptSection5);
        if (Region == "UK" || Region == "USA") {
            sb.AppendLine("<br />" + ReceiptSection6);
        }
        sb.AppendLine("<br /> If you have any questions about your order, please feel free to contact us.");
        sb.AppendLine("<br /><br /><strong>Email: </strong><a href='mailto:crmsales@spexcsp.com'>crmsales@spexcsp.com</a>");
        sb.AppendLine("<br /><strong>Phone:</strong> 1-800-LAB-SPEX | +1 (732)549-7144");
        sb.AppendLine("<br /><br /><a href='http://www.spexcertiprep.com'>SPEX CertiPrep</a><br />203 Norcross Ave.<br />Metuchen, NJ 08840");
        sb.AppendLine("<br /><br />Thank you for choosing SPEX CertiPrep.");
        sb.AppendLine("</body></html>");
        string strBody = sb.ToString();

        MailMessage mm = new MailMessage();
        mm.Subject = "New order from SPEX CertiPrep";
		mm.To.Add(UserEmail);  
		mm.Bcc.Add(new MailAddress("op@spexcsp.com"));
		mm.Bcc.Add(new MailAddress("crmsales@spexcsp.com"));
		mm.Bcc.Add(new MailAddress("peskow@spexcsp.com"));
		mm.Bcc.Add(new MailAddress("ycangelosi@spexcsp.com"));
        mm.Bcc.Add(new MailAddress("evlaun@spexcsp.com"));
        mm.Bcc.Add(new MailAddress("kmckeown@spexcsp.com"));
		mm.Bcc.Add(new MailAddress("JAkers@spex.com"));
		mm.Bcc.Add(new MailAddress("msnyder@spexcsp.com"));
		mm.Bcc.Add(new MailAddress("spexcertiprepmarcom@gmail.com"));
		mm.Bcc.Add(new MailAddress("rbiermann@spex.com"));
		
        mm.From = new MailAddress("contact@spexcsp.com", "SPEX CertiPrep Contact");
        mm.BodyEncoding = System.Text.Encoding.GetEncoding("utf-8");

        AlternateView plainView = AlternateView.CreateAlternateViewFromString(Regex.Replace(strBody, @"<(.|\n)*?>", string.Empty), System.Text.Encoding.GetEncoding("utf-8"), "text/plain");
        AlternateView htmlView = AlternateView.CreateAlternateViewFromString(strBody, System.Text.Encoding.GetEncoding("utf-8"), "text/html");
        mm.AlternateViews.Add(plainView);
        mm.AlternateViews.Add(htmlView);

        SmtpClient smtp = new SmtpClient();
        smtp.Send(mm);
		
		HttpContext.Current.Session["promocode"] = null;
    }
	
	public int getCPID(string Part) {
		int cpID = 0;
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT cpID FROM cp_roi_Prods WHERE cpPart = @PartNum";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@PartNum", SqlDbType.VarChar, 100).Value = Part;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					dr.Read();
					cpID = Convert.ToInt32(dr["cpID"].ToString());
				}
                cmd.Connection.Close();
            }
        }
		return cpID;
	}
	
	public decimal getItemPrice(string Region, string Part) {
		decimal itemPrice = 0;
		string SQL = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			if (Region == "UK") {
                SQL = "SELECT cd.Catalog_Prices FROM cp_roi_Prods cp LEFT JOIN uk_roi_IM_Catalog_Data cd ON cp.cpPart = cd.Part_Nbr " +
						" WHERE cp.cppart = @PartNumber " +
						"AND cp.For_Web = 'Y' " +
						"AND cd.Price_Currency = 'GBP' " +
						"AND cd.Eff_Date <= GETDATE() " +
						"ORDER BY cd.Eff_Date DESC";
            }else {              
				SQL = "SELECT cd.Catalog_Prices " +
                                  "  FROM cp_roi_Prods cp LEFT JOIN cp_roi_IM im ON cp.part_nbr = im.Part_Number " +
                                  "      LEFT JOIN cp_roi_IM_Catalog_Data cd ON im.Novo_IM = cd.Novo_IM " +
                                  "  WHERE cp.cppart = @PartNumber " +
                                  "      AND cp.For_Web = 'Y' " +
                                  "      AND im.Eff_Date <= GETDATE() " +
                                  "      AND cd.Eff_Date <= GETDATE() " +
                                  "  ORDER BY im.Eff_Date DESC, cd.Eff_Date DESC";
			}
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@PartNumber", SqlDbType.VarChar, 100).Value = Part;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleResult);
				if (dr.HasRows) {
					dr.Read();
					itemPrice = Convert.ToDecimal(dr["Catalog_Prices"].ToString());
				}
                cmd.Connection.Close();
            }
        }
		return itemPrice;
	}
	
	public decimal getItemDiscount(string Region, string Part, string DiscountCode, string itemDC) {
		decimal itemDiscount = 0;
		decimal disc = 0;
		string SQL = "";
		string Sales_Code = "";
		bool dcAvailable = false;
		if (Region == "UK") {
			using (SqlConnection cn2 = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
				SQL = "SELECT Sales_Code FROM uk_roi_IM WHERE Item_Part_Nbr = @PartNumber";
				using (SqlCommand cmd2 = new SqlCommand(SQL, cn2)) {
					cmd2.CommandType = CommandType.Text;
					cmd2.Parameters.Add("@PartNumber", SqlDbType.VarChar, 21).Value = Part;
					cmd2.Connection.Open();
					SqlDataReader dr2 = cmd2.ExecuteReader(CommandBehavior.SingleResult);
					if (dr2.HasRows) {
						dr2.Read();
						Sales_Code = dr2[0].ToString();
					}
					cmd2.Connection.Close();
				}
				
				SQL = "SELECT Disc_Mult FROM uk_roi_TRADE_DISCOUNT_DETAIL WHERE Sales_Prod_Code = @SalesCode AND Discount_Code = @DiscountCode";
				using (SqlCommand cmd2 = new SqlCommand(SQL, cn2)) {
					cmd2.CommandType = CommandType.Text;
					cmd2.Parameters.Add("@SalesCode", SqlDbType.Char, 8).Value = Sales_Code;
					cmd2.Parameters.Add("@DiscountCode", SqlDbType.Char, 8).Value = DiscountCode;
					cmd2.Connection.Open();
					SqlDataReader dr2 = cmd2.ExecuteReader(CommandBehavior.SingleResult);
					if (dr2.HasRows) {
						dr2.Read();
						disc = Convert.ToDecimal(dr2[0]);
					}
					cmd2.Connection.Close();
				}
				itemDiscount = getItemPrice(Region, Part) * disc;
			}
		}else {
			using (SqlConnection cn2 = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
				SQL = "SELECT TOP 1 Sales_Code FROM cp_roi_IM WHERE Item_Part_Nbr = @PartNumber AND Sales_Code != '39' AND Eff_Date <= GETDATE() ORDER BY Eff_Date ASC";
				using (SqlCommand cmd2 = new SqlCommand(SQL, cn2)) {
					cmd2.CommandType = CommandType.Text;
					cmd2.Parameters.Add("@PartNumber", SqlDbType.VarChar, 21).Value = Part;
					cmd2.Connection.Open();
					SqlDataReader dr2 = cmd2.ExecuteReader(CommandBehavior.SingleResult);
					if (dr2.HasRows) {
						dr2.Read();
						Sales_Code = dr2[0].ToString();
					}
					cmd2.Connection.Close();
				}
				
				string SQL2 = "SELECT * FROM cp_roi_CrmPromDet WHERE Prom_Code = @PromoCode AND Cat = @Sales_Code";
				using (SqlCommand cmd2 = new SqlCommand(SQL2, cn2)) {
					cmd2.CommandType = CommandType.Text;
					cmd2.Parameters.Add("@PromoCode", SqlDbType.NVarChar, 100).Value = this.PromoCode;
					cmd2.Parameters.Add("@Sales_Code", SqlDbType.VarChar, 10).Value = Sales_Code;
					cmd2.Connection.Open();
					SqlDataReader dr2 = cmd2.ExecuteReader(CommandBehavior.SingleRow);
					if (dr2.HasRows) {
						dr2.Read();
						dcAvailable = true;
					}
					cmd2.Connection.Close();
				}	
			}
			if (this.PromoCode.Length > 0 && dcAvailable == true) {			
				if (_PromoAmountDiscount > 0) {
					// $$ off discount
					disc = Convert.ToDecimal(_PromoAmountDiscount);
				} 
				if (_PromoPercentDiscount > 0) {
					// % off discount
					disc = getItemPrice(Region, Part) * Convert.ToDecimal(_PromoPercentDiscount);
				}           
			}
			itemDiscount = disc;
		}
		itemDiscount = itemDiscount + Convert.ToDecimal(itemDC);
		return itemDiscount;
	}
	
	public decimal getFinalPrice(string Part, string DiscountCode, string itemsTP) {
		decimal finalPrice = 0;
		decimal discountedPrice = 0;
		string Sales_Code = "";
		bool dcAvailable = false;
		finalPrice = discountedPrice = Convert.ToDecimal(itemsTP);
		
		using (SqlConnection cn2 = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT TOP 1 Sales_Code FROM cp_roi_IM WHERE Item_Part_Nbr = @PartNumber AND Sales_Code != '39' AND Eff_Date <= GETDATE() ORDER BY Eff_Date ASC";
				using (SqlCommand cmd2 = new SqlCommand(SQL, cn2)) {
					cmd2.CommandType = CommandType.Text;
					cmd2.Parameters.Add("@PartNumber", SqlDbType.VarChar, 21).Value = Part;
					cmd2.Connection.Open();
					SqlDataReader dr2 = cmd2.ExecuteReader(CommandBehavior.SingleResult);
					if (dr2.HasRows) {
						dr2.Read();
						Sales_Code = dr2[0].ToString();
					}
					cmd2.Connection.Close();
				}
				
			string SQL2 = "SELECT * FROM cp_roi_CrmPromDet WHERE Prom_Code = @PromoCode AND Cat = @Sales_Code";
			using (SqlCommand cmd2 = new SqlCommand(SQL2, cn2)) {
                cmd2.CommandType = CommandType.Text;
				cmd2.Parameters.Add("@PromoCode", SqlDbType.NVarChar, 100).Value = this.PromoCode;
                cmd2.Parameters.Add("@Sales_Code", SqlDbType.VarChar, 10).Value = Sales_Code;
                cmd2.Connection.Open();
                SqlDataReader dr2 = cmd2.ExecuteReader(CommandBehavior.SingleRow);
                if (dr2.HasRows) {
                    dr2.Read();
                    dcAvailable = true;
                }
                cmd2.Connection.Close();
            }	
		}
		if (this.PromoCode.Length > 0 && dcAvailable == true) {			
            if (_PromoAmountDiscount > 0) {
                // $$ off discount
                finalPrice = discountedPrice - Convert.ToDecimal(_PromoAmountDiscount);
            } 
			if (_PromoPercentDiscount > 0) {
                // % off discount
                decimal PromoCodeDiscount = discountedPrice * Convert.ToDecimal(_PromoPercentDiscount);
                finalPrice =  discountedPrice - PromoCodeDiscount;
            }           
		}
		return finalPrice;
	}

    public void EmptyCart() {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "DELETE FROM sprepPersistentCart WHERE userid = @UserID AND purchased = 'n'";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = _UserID;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
        }
        PromoCode = "";
    }
    public void RefreshPrices(string Region, string DiscountCode, string PriceCode, double CustDiscountMult) {
        _SPoints = 0;
		//HttpContext.Current.Response.Write("RefreshPrices<br />");
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT c.ID, c.part_id AS PartNumber, c.part_desc, c.quantity, " +
                         "       prod.cpID AS UniqueID, prod.cpDescrip as Title, prod.cpLongDescrip AS Description, " +
                         "       prod.cpUnitCnt AS UnitPack, prod.cpType as Type, " +
                         "       cv.cpvVolume AS Volume, " +
                         "       si.csfinfo AS Shipping, " +
                         "       cs.csgStore AS Storage, " +
                         "       img.main_image AS Thumbnail " +
                         "   FROM sprepPersistentCart c JOIN cp_roi_Prods prod ON c.part_id = prod.cpPart " +
                         "   LEFT JOIN cp_roi_ProdDetails cpd ON cpd.cpdID = prod.cpID " +
                         "   LEFT JOIN cp_roi_Volumes cv ON prod.cpVol = cv.cpvID " +
                         "   LEFT JOIN cp_roi_ShipInfo si ON si.csfID = cpd.cpdShipInf " +
                         "   LEFT JOIN cp_roi_Storage cs ON cs.csgID = cpd.cpdStorage " +
                         "   LEFT JOIN certiProdImages img ON prod.cpPart = img.PartNumber " +
                         "   WHERE c.userid = @UserID " + 
                         "   AND c.purchased = 'n'";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = _UserID;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read()) {
                    ShoppingCartItem si = new ShoppingCartItem();
                    si.ProductID = dr["ID"].ToString();
                    si.PartNumber = dr["PartNumber"].ToString();
                    si.ProdTitle = dr["Part_Desc"].ToString();
                    si.Qty = Convert.ToInt32(dr["quantity"]);
                    if (si.Qty < 1) { si.Qty = 1; }
                    si.Volume = dr["Volume"].ToString();
                    si.Hazardous = dr["Shipping"].ToString();
                    if (dr["Shipping"].ToString().ToLower() == "hazardous") { _ShowShippingAlert = true; }
                    si.Storage = dr["Storage"].ToString();
                    if (dr["Storage"].ToString().ToLower() == "refrigerator") { _ShowRefrigeratorAlert = true; }
                    if (dr["Storage"].ToString().ToLower() == "freezer") { _ShowFreezerAlert = true; }
                    if (!string.IsNullOrEmpty(dr["Thumbnail"].ToString())) {
                        si.Thumbnail = "product_images/" + dr["Thumbnail"].ToString();
                    } else {
					    if (dr["Type"].ToString() == "1") {
					        // organic
					        si.Thumbnail = "product_images/OrganicProducts.jpg";
					    } else if (dr["Type"].ToString() == "2") {
					        // inorganic
					        si.Thumbnail = "smallthumb.jpg";
					    } else {
					        // default image 
					        si.Thumbnail = "smallthumb.jpg";
					    }
                    }

                    int Novo_Code = 0;
                    string Sales_Code = "";

					//HttpContext.Current.Response.Write("_UserID " + _UserID + "<br />");
					using (SqlConnection cn2 = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
                        string SQL2 = "";

						//HttpContext.Current.Response.Write("Region " + Region + "<br />");
						//Check SPoints
                        if (Region == "UK") {
                            SQL2 = "SELECT * FROM uk_roi_CM cm JOIN uk_roi_CONTACT_MASTER m ON m.Cust_Nbr = cm.recordid WHERE m.ID = @UserID";
                        } else {
							SQL2 = "SELECT cm.customer_type, cm.sales_division FROM cp_roi_CM cm JOIN cp_roi_CONTACT_MASTER m ON m.Cust_Nbr = cm.recordid WHERE m.ID = @UserID";
                        }
                        bool CheckSpoints = false;

                        using (SqlCommand cmd2 = new SqlCommand(SQL2, cn2)) {
                            cmd2.CommandType = CommandType.Text;
                            cmd2.Parameters.Add("@UserID", SqlDbType.Int).Value = _UserID;
                            cmd2.Connection.Open();
                            SqlDataReader dr2 = cmd2.ExecuteReader();
                            if (dr2.HasRows) {
                                dr2.Read();

                                if (dr2["customer_type"].ToString().Trim() == "C" && dr2["sales_division"].ToString().Trim() == "D") {
                                    CheckSpoints = true;
                                } else {
                                    CheckSpoints = false;
                                }
                            }
                            cmd2.Connection.Close();
                        }
						//HttpContext.Current.Response.Write("CheckSpoints " + CheckSpoints + "<br />");

                        // get price
                        int ShortSPC = 0;
                        Int32.TryParse(PriceCode, out ShortSPC);
                        if (ShortSPC == 0) { ShortSPC = 1; }

                        if (Region == "UK") {
                            SQL = "SELECT cp.cpID as NOVO_IM, NULLIF(im.Sales_Code, 1) AS Sales_Code, cd.Catalog_Prices " +
                                  "  FROM cp_roi_Prods cp LEFT JOIN uk_roi_IM im ON cp.cppart = im.Item_Part_Nbr " +
                                  "      LEFT JOIN uk_roi_IM_Catalog_Data cd ON im.Item_Part_Nbr = cd.part_nbr " +
                                  "  WHERE cp.cppart = @PartNumber " +
                                  "      AND cd.Cat_Code = @CatCode " +
                                  "      AND cd.Price_Currency = 'GBP' " +
                                  "      AND cp.For_Web = 'Y' " +
                                  "      --AND im.Eff_Date <= GETDATE() " +
                                  "      AND cd.Eff_Date <= GETDATE() " +
                                  "  ORDER BY im.Eff_Date DESC, cd.Eff_Date DESC";
                            using (SqlCommand cmd2 = new SqlCommand(SQL, cn2)) {
                                cmd2.CommandType = CommandType.Text;
                                cmd2.Parameters.Add("@PartNumber", SqlDbType.VarChar, 21).Value = si.PartNumber;
                                cmd2.Parameters.Add("@CatCode", SqlDbType.Char, 3).Value = ShortSPC;
                                cmd2.Connection.Open();
                                SqlDataReader dr2 = cmd2.ExecuteReader(CommandBehavior.SingleResult);
                                if (dr2.HasRows) {
                                    dr2.Read();
                                    si.BaseCost = Convert.ToDouble(dr2["Catalog_Prices"]);
                                    Sales_Code = dr2["Sales_Code"].ToString();
                                }
                                cmd2.Connection.Close();
                            }

                            // Get discount for this item, with the user's discount code
                            double ItemDiscountMult = 0;
                            SQL = "SELECT TOP 1 Disc_Mult FROM uk_roi_TRADE_DISCOUNT_DETAIL where MultiID = @MultiID";
                            using (SqlCommand cmd2 = new SqlCommand(SQL, cn2)) {
                                cmd2.CommandType = CommandType.Text;
                                cmd2.Parameters.Add("@MultiID", SqlDbType.Char, 10).Value = DiscountCode.Trim() + "_" + Sales_Code.Trim();
                                cmd2.Connection.Open();
                                SqlDataReader dr2 = cmd2.ExecuteReader(CommandBehavior.SingleRow);
                                if (dr2.HasRows) {
                                    dr2.Read();
                                    ItemDiscountMult = Convert.ToDouble(dr2["Disc_Mult"]);
                                }
                                cmd2.Connection.Close();
                                si.DiscountedCost = si.BaseCost * (1 - ItemDiscountMult + CustDiscountMult);
                            }
                        } else {
							//SQL = "SELECT Sales_Code FROM cp_roi_Prods prod JOIN cp_roi_IM im ON prod.cpID = im.Novo_IM WHERE prod.cpPart = @PartNumber";
							SQL = "SELECT TOP 1 Sales_Code FROM cp_roi_IM WHERE Item_Part_Nbr = @PartNumber AND Sales_Code != '39' AND Eff_Date <= GETDATE() ORDER BY Eff_Date ASC";
							using (SqlCommand cmd2 = new SqlCommand(SQL, cn2)) {
								cmd2.CommandType = CommandType.Text;
								cmd2.Parameters.Add("@PartNumber", SqlDbType.VarChar, 21).Value = si.PartNumber;
								cmd2.Connection.Open();
								SqlDataReader dr2 = cmd2.ExecuteReader(CommandBehavior.SingleResult);
								if (dr2.HasRows) {
									dr2.Read();
									Sales_Code = dr2[0].ToString();
								}
								cmd2.Connection.Close();
							}

							using (SqlCommand cmd2 = new SqlCommand("sp_certGetItemPrice", cn2)) {
                                cmd2.CommandType = CommandType.StoredProcedure;
                                cmd2.Parameters.Add("@cp_roi_Contact_Master_ID", SqlDbType.VarChar, 10).Value = _UserID.ToString();
                                cmd2.Parameters.Add("@cp_roi_Prods_cpPart", SqlDbType.VarChar, 21).Value = si.PartNumber;
								//HttpContext.Current.Response.Write("si.PartNumber " + si.PartNumber + "<br />");
								cmd2.Parameters.Add("@Price", SqlDbType.Decimal);
                                cmd2.Parameters.Add("@DiscountPrice", SqlDbType.Decimal);
								
                                cmd2.Parameters["@Price"].Direction = ParameterDirection.Output;
                                cmd2.Parameters["@Price"].Precision = 16;
                                cmd2.Parameters["@Price"].Scale = 2;
                                cmd2.Parameters["@DiscountPrice"].Direction = ParameterDirection.Output;
                                cmd2.Parameters["@DiscountPrice"].Precision = 16;
                                cmd2.Parameters["@DiscountPrice"].Scale = 2;
								

                                cmd2.Connection.Open();
                                cmd2.ExecuteNonQuery();
                                si.BaseCost = Convert.ToDouble(cmd2.Parameters["@Price"].Value);
                                si.DiscountedCost = Convert.ToDouble(cmd2.Parameters["@DiscountPrice"].Value);
								si.DiscMult = Convert.ToDouble(DiscountCode);
								//si.DefaultMult = Convert.ToDouble(cmd2.Parameters["@DeMult"].Value);
                                cmd2.Connection.Close();
                            }							
                        }


                        //Part 4 - is item in stock?
                        SQL2 = "SELECT Net_Avail FROM cp_roi_IPL WHERE Novo_IM = @Novo_Code";
                        using (SqlCommand cmd2 = new SqlCommand(SQL2, cn2)) {
                            cmd2.CommandType = CommandType.Text;
                            cmd2.Parameters.Add("@Novo_Code", SqlDbType.Int).Value = Novo_Code;
                            cmd2.Connection.Open();
                            SqlDataReader dr2 = cmd2.ExecuteReader(CommandBehavior.SingleRow);
                            if (dr2.HasRows) {
                                dr2.Read();
                                si.InStock = (Convert.ToInt32(dr2["Net_Avail"]) > 0 ? "Yes" : "No");
                            }
                            cmd2.Connection.Close();
                        }

                        //Part 5 - check Spoints, if appropriate for this customer
                        if (CheckSpoints) {
							//HttpContext.Current.Response.Write("Sales_Code " + Sales_Code + "<br />");
							SQL2 = "SELECT spoints FROM GrpCatLookup WHERE cat = @Sales_Code";
                            using (SqlCommand cmd2 = new SqlCommand(SQL2, cn2)) {
                                cmd2.CommandType = CommandType.Text;
                                cmd2.Parameters.Add("@Sales_Code", SqlDbType.VarChar, 10).Value = Sales_Code;
                                cmd2.Connection.Open();
                                SqlDataReader dr2 = cmd2.ExecuteReader(CommandBehavior.SingleRow);
                                if (dr2.HasRows) {
                                    dr2.Read();
                                    if (dr2["spoints"].ToString().ToLower() == "y") {
                                        _SPoints += Convert.ToInt32(Math.Round(si.LineCost * 0.1, 0));
                                    }
                                }
                                cmd2.Connection.Close();
                            }
                        }
						
						if (this.PromoCode.Length > 0) {
							if (IsPromoPerProd(PromoCode) == true) {			
								if (checkCustomerType(_UserID.ToString()) == false) {
									SQL2 = "SELECT * FROM cpPromoPerProd WHERE Promo_Code = @PromoCode AND Part_Num = @Part_Num";
									using (SqlCommand cmd2 = new SqlCommand(SQL2, cn2)) {
										cmd2.CommandType = CommandType.Text;
										cmd2.Parameters.Add("@PromoCode", SqlDbType.NVarChar, 100).Value = this.PromoCode;
										cmd2.Parameters.Add("@Part_Num", SqlDbType.NVarChar, 100).Value = si.PartNumber;
										cmd2.Connection.Open();
										SqlDataReader dr2 = cmd2.ExecuteReader(CommandBehavior.SingleRow);
										if (dr2.HasRows) {
											dr2.Read();
											_DCOrderSubtotal += si.LineCost;
											si.Promotion = "Yes";
										}
										cmd2.Connection.Close();
									}
								}
							}else {
								SQL2 = "SELECT * FROM cp_roi_CrmPromDet WHERE Prom_Code = @PromoCode AND Cat = @Sales_Code";
								using (SqlCommand cmd2 = new SqlCommand(SQL2, cn2)) {
									cmd2.CommandType = CommandType.Text;
									cmd2.Parameters.Add("@PromoCode", SqlDbType.NVarChar, 100).Value = this.PromoCode;
									cmd2.Parameters.Add("@Sales_Code", SqlDbType.VarChar, 10).Value = Sales_Code;
									cmd2.Connection.Open();
									SqlDataReader dr2 = cmd2.ExecuteReader(CommandBehavior.SingleRow);
									if (dr2.HasRows) {
										dr2.Read();
										_DCOrderSubtotal += si.LineCost;
										si.Promotion = "Yes";
									}
									cmd2.Connection.Close();
								}
							}
							
						}
                    }

                    _OrderSubtotal += si.LineCost;
                    _DiscountSubtotal += si.LineDiscount;

                    _ItemList.Add(si);
                }
                cmd.Connection.Close();

            }

            _DiscountTotal = _DiscountSubtotal;
            _OrderTotal = _OrderSubtotal;

            if (this.PromoCode.Length > 0) {
                // apply discount code and get final price
                if (_OrderSubtotal >= _PromoOrderValue) {
                    //Meets the minimum order size criteria
                    if (_PromoAmountDiscount > 0) {
                        // $$ off discount
                        _DiscountTotal = _DiscountSubtotal + _PromoAmountDiscount;
                        _OrderTotal = _OrderSubtotal - _PromoAmountDiscount;
                    } else if (_PromoPercentDiscount > 0 && _DCOrderSubtotal >= _PromoOrderValue) {
                        // % off discount
						_ShowPromotionAlert = true;
                        double PromoCodeDiscount = _DCOrderSubtotal * _PromoPercentDiscount;
                        _DiscountTotal = _DiscountSubtotal + PromoCodeDiscount;
                        _OrderTotal = _OrderSubtotal - PromoCodeDiscount;
                    }
                }
            }

        }
    }
	
	public bool IsPromoPerProd(string code) {
		bool output = false;
		string SQL2 = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			SQL2 = "SELECT * FROM cp_roi_CrmProm WHERE Prom_Code = @code AND Per_Product = @perprod";
			using (SqlCommand cmd2 = new SqlCommand(SQL2, cn)) {
				cmd2.CommandType = CommandType.Text;
				cmd2.Parameters.Add("@code", SqlDbType.NVarChar, 60).Value = code;
				cmd2.Parameters.Add("@perprod", SqlDbType.Int).Value = 1;
				cmd2.Connection.Open();
				SqlDataReader dr2 = cmd2.ExecuteReader(CommandBehavior.SingleRow);
				if (dr2.HasRows) {
					dr2.Read();
					output = true;
				}
				cmd2.Connection.Close();
			}
		}
		return output;
	}
	
	public bool checkCustomerType(string uID) {
		bool output = false;
		string SQL2 = "", Cust_Nbr = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			SQL2 = "SELECT Cust_Nbr FROM cp_roi_CONTACT_MASTER AS crm INNER JOIN cp_roi_CM AS crc ON crm.Cust_Nbr = crc.Bill_To_Customer WHERE crm.ID = @uID AND crc.Customer_Type = 'C'";
			using (SqlCommand cmd2 = new SqlCommand(SQL2, cn)) {
				cmd2.CommandType = CommandType.Text;
				cmd2.Parameters.Add("@uID", SqlDbType.NVarChar, 10).Value = uID;
				cmd2.Connection.Open();
				SqlDataReader dr2 = cmd2.ExecuteReader(CommandBehavior.SingleRow);
				if (dr2.HasRows) {
					dr2.Read();
					Cust_Nbr = dr2["Cust_Nbr"].ToString().Trim();
				}else {
					return true;
				}
				cmd2.Connection.Close();
			}
			
			SQL2 = "SELECT crt.Default_Mult FROM cp_roi_CM AS crc INNER JOIN cp_roi_TRADE_DISCOUNT AS crt ON crt.Discount_Code = crc.Discount_Code WHERE crc.Bill_To_Customer = @Cust_Nbr AND crc.Customer_Type = 'C' AND crt.Default_Mult IS NOT NULL";
			using (SqlCommand cmd2 = new SqlCommand(SQL2, cn)) {
				cmd2.CommandType = CommandType.Text;
				cmd2.Parameters.Add("@Cust_Nbr", SqlDbType.NVarChar, 10).Value = Cust_Nbr;
				cmd2.Connection.Open();
				SqlDataReader dr2 = cmd2.ExecuteReader(CommandBehavior.SingleRow);
				if (dr2.HasRows) {
					dr2.Read();
					if (Convert.ToDouble(dr2["Default_Mult"]) >= 0.15) {
						output = true;
					}else {
						output = false;
					}
				}else {
					output = false;
				}
				cmd2.Connection.Close();
			}
		}
		return output;
	}

    private void InitializePromoCode(string code) {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT cp.Prom_Desc, ISNULL(cp.Order_Value, 0) AS Order_Value, ISNULL(cp.Order_Disc, 0) AS Order_Disc, " +
                         "   ISNULL(cp.Order_Disc_Perc, 0) AS Order_Disc_Perc " +
                         "   FROM certiCoupons cc FULL OUTER JOIN cp_roi_CrmProm cp ON cc.Prom_Code = cp.Prom_Code " +
                         "   WHERE (cc.code = @code or cp.Prom_Code = @code ) " +
                         "   AND cc.is_used is NULL " +
                         "   AND cp.Expiration >= GetDate() " +
                         "   AND cp.Web = 'Y'";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@code", SqlDbType.Char, 30).Value = code;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                if (dr.HasRows) {
                    dr.Read();
                    _PromoDescription = dr["Prom_Desc"].ToString();
                    _PromoOrderValue = Convert.ToDouble(dr["Order_Value"]);
                    _PromoAmountDiscount = Convert.ToDouble(dr["Order_Disc"]);
                    _PromoPercentDiscount = Convert.ToDouble(dr["Order_Disc_Perc"]) / 100;
                } else {
                    this.PromoCode = "";
                }
                cmd.Connection.Close();
            }
        }
    }
}

public class ShoppingCartItem {
    public string ProductID = "";
    public string PartNumber = "";
    public string ProdTitle = "";
    public int Qty = 0;
    public double BaseCost = 0;
    public double DiscountedCost = 0;
	
	public double DiscMult = 0;
	public double DefaultMult = 0;
	
    public string InStock = "";
    public string Volume = "";
    public string Hazardous = "";
    public string Storage = "";
    public string Thumbnail = "";
	public string Promotion = "";

    public double ItemDiscount {
        get {
            //This is the discounts applied to the unit price
            return (BaseCost - DiscountedCost);
        }
    }
    public double LineCost {
        get {
            //This is the final cost of the quantity ordered
            return DiscountedCost * Qty;
        }
    }
    public double LineDiscount {
        get {
            //This is the total discount for the quantity ordered
            return ItemDiscount * Qty;
        }
    }
    public string ShippingIcon {
        get {
            if (Hazardous.ToLower() == "hazardous") {
                return "hazardous_icon.gif";
            } else {
                return "not_hazardous_icon.gif";
            }
        }
    }
    public string StorageIcon {
        get {
            if (Storage.ToLower() == "ambient" || Storage == "") {
                return "not_hazardous_icon.gif";
            } else {
                return "hazardous_icon.gif";
            }
        }
    }
    public string PromoIcon {
        get {
            if (Promotion.ToLower() == "yes") {
                return "<img src='/images/promo_icon.png' alt='Promotion' />";
            }else {
				return "";
			}
        }
    }
    public ShoppingCartItem() { }
}