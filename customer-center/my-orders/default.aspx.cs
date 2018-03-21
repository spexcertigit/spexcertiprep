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
using System.Text;
using System.Globalization;
using System.Threading;

public partial class hipure_inorganic : System.Web.UI.Page
{
    protected string sTitle = "";
	protected string sDesc = "";
    protected int ProductCount = 0;
    protected string Region = "US";
    protected string CurrencySymbol = "$";
    protected string CatCode = "1";
    protected clsUser myUser;
	protected string prodTitle = "";
	protected string strCatalog = "";
	
	protected bool LoggedIn = false;
	protected string cusID = "";
	protected string webCusID = "";
    protected string DisplayName = "";
	protected string orderID = "";
	
	protected string orderDate = "";
	protected string shipAdd = "";
	protected string billAdd = "";
	protected string payMethod = "";
	protected string shipMethod = "";

    protected void Page_Load(object sender, EventArgs e)
    {
		myUser = new clsUser();
		//Response.Write("currently loggedin:" + myUser.UserID.ToString());
        if (!myUser.LoggedIn) {
            //If user is not logged in
			Response.Redirect("/");
        } else {
            LoggedIn = true;
            DisplayName = myUser.FirstName + " " + myUser.LastName;
			webCusID = myUser.UserID.ToString().Trim();
			cusID = myUser.CustomerNumber.Trim();
        }
		
		if (!String.IsNullOrEmpty(Request.QueryString["id"])) {
			orderID = Request.QueryString["id"].ToString();
			ltrItemsOrdered.Text = getItemsOrdered(orderID);
			ltrInvoice.Text = getInvoice(orderID);
		}
		
        Region = myUser.Region;
        CurrencySymbol = myUser.CurrencySymbol;
        CatCode = myUser.DiscountCode;
		
		Page.Header.Title = "My Orders | SPEX CertiPrep";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = 	"SELECT * FROM WebOrderDetails WHERE id = @orderID";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@orderID", SqlDbType.VarChar).Value = orderID;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					dr.Read();
					CultureInfo cultureInfo   = Thread.CurrentThread.CurrentCulture;
					TextInfo textInfo = cultureInfo.TextInfo;
					
					orderDate = string.Format("{0:MMMM dd, yyyy}", dr["orderdate"]);
					// Shipping Address Content
					if (dr["shipping_organization"].ToString().Trim() != "") {
						shipAdd += dr["shipping_organization"].ToString().Trim() + "<br />";
					}
					shipAdd += dr["shipping_address1"].ToString().Trim() + "<br />";
					if (dr["shipping_address2"].ToString().Trim() != "") {
						shipAdd += dr["shipping_address2"].ToString().Trim() + "<br />";
					}
					shipAdd += dr["shipping_city"].ToString().Trim() + ", " + dr["shipping_area"].ToString().Trim() + " " + dr["shipping_postcode"].ToString().Trim();
					
					// Billing Address Content
					if (dr["organization"].ToString().Trim() != "") {
						billAdd += dr["organization"].ToString().Trim() + "<br />";
					}
					billAdd += dr["billing_address1"].ToString().Trim() + "<br />";
					if (dr["billing_address2"].ToString().Trim() != "") {
						billAdd += dr["billing_address2"].ToString().Trim() + "<br />";
					}
					billAdd += dr["billing_city"].ToString().Trim() + ", " + dr["billing_area"].ToString().Trim() + " " + dr["billing_postcode"].ToString().Trim();
					
					// Payment Method Content
					payMethod += dr["payment_method"].ToString().Trim() + "<br />";
					if (dr["payment_method"].ToString().Trim() == "Credit Card") {
						string cardNum = dr["card_number"].ToString().Trim();
						payMethod += "Credit Card Type: " + textInfo.ToTitleCase(dr["card_type"].ToString().Trim().Replace("_", " ")) + "<br />";
						payMethod += "Credit Card Number: XXXX-" + cardNum.Substring(cardNum.Length - 4) + "<br />";
						payMethod += "Processed Amount: -";
					}else {
						payMethod += "PO Number: " + dr["PO_number"].ToString().Trim();
					}
					
					shipMethod = dr["shipping_method"].ToString().Trim();
				}
				cmd.Connection.Close();
			}
		}
    }
		
	public static string getItemsOrdered(string id) {
		string output = "";
		string part = "";
		float subtotal = 0;
		float total = 0;
		float item_price = 0;
		float qty = 0;
		string dcCode = "";
		string ship = "";
		float final_price = 0;
		float totalDC = 0;
		
		clsUser myUser3 = new clsUser();
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT woi.item_id, woi.item_quantity, wod.shipping_method, wod.discount_code, wod.FinalPrice, wod.TotalDiscount " +
							"FROM WebOrderItems woi INNER JOIN WebOrderDetails wod ON woi.Order_Number = wod.id WHERE wod.id = @orderID";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@orderID", SqlDbType.VarChar).Value = id;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				output = "<table id='loadOrder' class='cuscen table table-bordered text-center'><thead><tr><th style='text-align:left'>Description</th><th>Part Number</th><th>Quantity</th><th>Subtotal</th></tr></thead><tbody>";
				while(dr.Read()) {
					part = dr["item_id"].ToString();
					item_price = Convert.ToSingle(RemoveSpecialCharacters(GetPrice(part)));
					qty = Convert.ToSingle(dr["item_quantity"]);
					total = item_price * qty;
					dcCode = dr["discount_code"].ToString();
					final_price = Convert.ToSingle(dr["FinalPrice"]);
					totalDC = Convert.ToSingle(dr["TotalDiscount"]);
					ship = dr["shipping_method"].ToString();
					
					output += "<tr><td style='text-align:left'>" + getProdName(part) + "</td><td>" + part + "</td><td>" + qty + "</td><td>"+ myUser3.CurrencySymbol + total + "</td></tr>";
					subtotal = subtotal + total;
				}
				output += "</tbody></table>";
			}
		}
		return output;
	}
	
	public static string getInvoice(string id) {
		string output = "";
		string part = "";
		float subtotal = 0;
		float total = 0;
		float item_price = 0;
		float qty = 0;
		string dcCode = "";
		string ship = "";
		float final_price = 0;
		float totalDC = 0;
		
		clsUser myUser3 = new clsUser();
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT woi.item_id, woi.item_quantity, wod.shipping_method, wod.discount_code, wod.FinalPrice, wod.TotalDiscount " +
							"FROM WebOrderItems woi INNER JOIN WebOrderDetails wod ON woi.Order_Number = wod.id WHERE wod.id = @orderID";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@orderID", SqlDbType.VarChar).Value = id;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				output = "<table id='loadOrder' class='cuscen table table-bordered text-center'><thead><tr><th>Description</th><th>Part Number</th><th>Quantity</th><th>Price</th><th>Total</th></tr></thead><tbody>";
				while(dr.Read()) {
					part = dr["item_id"].ToString();
					item_price = Convert.ToSingle(RemoveSpecialCharacters(GetPrice(part)));
					qty = Convert.ToSingle(dr["item_quantity"]);
					total = item_price * qty;
					dcCode = dr["discount_code"].ToString();
					final_price = Convert.ToSingle(dr["FinalPrice"]);
					totalDC = Convert.ToSingle(dr["TotalDiscount"]);
					ship = dr["shipping_method"].ToString();
					
					output += "<tr><td style='text-align:left'>" + getProdName(part) + "</td><td>" + part + "</td><td>" + qty + "</td><td>" + myUser3.CurrencySymbol + item_price + "</td><td>"+ myUser3.CurrencySymbol + total + "</td></tr>";
					subtotal = subtotal + total;
				}
				output += 	"<tr class='graybg'>" +
							"	<td></td>" + 
							"	<td></td>" +
							"	<td></td>" +
							"	<td style='text-align:right'>Subtotal</td><td>"+ myUser3.CurrencySymbol + subtotal + "</td>" +
							"</tr>" +
							"<tr class='graybg'>" +
							"	<td></td>" +
							"	<td></td>" +
							"	<td></td>" +
							"	<td style='text-align:right'>Total Savings:</td><td>"+ myUser3.CurrencySymbol + totalDC + "</td>" + 
							"</tr>" +
							"<tr class='graybg'>" +
							"	<td></td>" +
							"	<td></td>" +
							"	<td></td>" +
							"	<td style='text-align:right;font-weight:bold'>TOTAL</td><td style='font-weight:bold'>" + myUser3.CurrencySymbol + final_price + "</td>" +
							"</tr>";
				
				output += "</tbody></table>";
			}
		}
		return output;
	}
	
	protected static string getProdName(string part) {
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT cpDescrip FROM cp_roi_Prods WHERE cpPart = @part";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@part", SqlDbType.VarChar).Value = part;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if(dr.HasRows) {
					dr.Read();
					return dr["cpDescrip"].ToString();
				}
			}
		}
		return "";
	}
	
	protected static string GetPrice(string PartNumber) {
		clsUser myUser2 = new clsUser();
        clsItemPrice price = new clsItemPrice(PartNumber, myUser2);
        return price.PriceText;
    }
	
	public static string RemoveSpecialCharacters(string str) {
	   StringBuilder sb = new StringBuilder();
	   foreach (char c in str) {
		  if ((c >= '0' && c <= '9') || (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || c == '.' || c == '_') {
			 sb.Append(c);
		  }
	   }
	   return sb.ToString();
	}
	
	[WebMethod()]
	public static string getOrderStatus(string orderID) {
		bool recieved = false;
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT Order_Status FROM cp_roi_SOH WHERE So_Nbr = @orderID";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@orderID", SqlDbType.VarChar).Value = orderID;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				
				if (dr.HasRows) {
					dr.Read();
					string stat = dr["Order_Status"].ToString();
					if (stat == "O") {
						return "Processed";
					}else if (stat == "C") {
						return "Completed";
					}
				}else {
					recieved = true;
				} //#d9534f red
				cmd.Connection.Close();
			}
			if (recieved == true) {
				SQL = "SELECT id FROM WebOrderDetails WHERE id=@orderID AND site = 'CP' AND paid = 'Y' AND id NOT IN (SELECT So_Nbr FROM cp_roi_SOH)";
				using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
					cmd.CommandType = CommandType.Text;
					cmd.Parameters.Add("@orderID", SqlDbType.VarChar).Value = orderID;
					cmd.Connection.Open();
					SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
					if (dr.HasRows) {
						dr.Read();
						return "Rejected";
					}else {
						return "Received";
					} //#d9534f red
					cmd.Connection.Close();
				}
			}
		}
		return "";
	}
}
