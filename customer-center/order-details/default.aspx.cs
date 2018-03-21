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
			ltrSummary.Text = getViewOrder(orderID);
			ltrInfo.Text = getOrderInfo(orderID);
		}else {
			ltrSummary.Text = "Please select a web order.";
		}
		
        Region = myUser.Region;
        CurrencySymbol = myUser.CurrencySymbol;
        CatCode = myUser.DiscountCode;
		
		Page.Header.Title = "Order Details | SPEX CertiPrep";
		
		string output = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT id FROM WebOrderDetails WHERE customer_id = @webCusID";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@webCusID", SqlDbType.VarChar).Value = webCusID;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				while(dr.Read()) {
					if (dr["id"].ToString().Trim() == orderID) {
						output += "<option value='" + dr["id"].ToString().Trim() + "' selected>" + dr["id"].ToString().Trim() + "</option>";
					}else {
						output += "<option value='" + dr["id"].ToString().Trim() + "'>" + dr["id"].ToString().Trim() + "</option>";
					}
				}
			}
		}
		ltrOrderList.Text = output;
		
    }
		
	public static string getViewOrder(string id) {
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
				output = "<h2 class='cc'>Web Order ID: <span style='font-weight:normal'>"+ id +"</span></h2><table id='loadOrder' class='tablesorter cc'><thead><tr><th>Part #</th><th>Description</th><th>Quantity</th><th>Price</th><th>Total</th></tr></thead><tbody>";
				while(dr.Read()) {
					part = dr["item_id"].ToString();
					item_price = Convert.ToSingle(RemoveSpecialCharacters(GetPrice(part)));
					qty = Convert.ToSingle(dr["item_quantity"]);
					total = item_price * qty;
					dcCode = dr["discount_code"].ToString();
					final_price = Convert.ToSingle(dr["FinalPrice"]);
					totalDC = Convert.ToSingle(dr["TotalDiscount"]);
					ship = dr["shipping_method"].ToString();
					
					output += "<tr><td>" + part + "</td><td>" + getProdName(part) + "</td><td>" + qty + "</td><td style='text-align:right'>"+ myUser3.CurrencySymbol +item_price + "</td><td style='text-align:right'>"+ myUser3.CurrencySymbol + total + "</td></tr>";
					subtotal = subtotal + total;
				}
				output += "</tbody></table><table class='tblSum'><tr><td style='text-align:right'>SUBTOTAL:</td><td style='text-align:right;font-weight:bold'>"+ myUser3.CurrencySymbol + subtotal + "</td></tr><tr><td  style='text-align:right'>TOTAL SAVINGS:</td><td style='text-align:right;font-weight:bold'>"+ myUser3.CurrencySymbol + totalDC + "</td></tr><tr><td style='text-align:right'>SHIPPING METHOD:</td><td style='text-align:right'>" + ship + "</td></tr><tr><td style='text-align:right'>FINAL TOTAL:<br>(SHIPPING NOT INCLUDED)</td><td style='text-align:right;font-weight:bold'>" + myUser3.CurrencySymbol + final_price + "</td></tr></table><div style='clear:both'></div>";
			}
		}
		return output;
	}
	
	protected static string getOrderInfo(string orderID)  {
		string output = "";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT * FROM WebOrderDetails WHERE id = @orderID";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@orderID", SqlDbType.VarChar).Value = orderID;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if(dr.HasRows) {
					dr.Read();
					output += 	"<div class='col-6-l'>" + 
									"<table border='1'>" +
										"<tr style='background:#eee'>" +
											"<td colspan='2'><strong>Account Holder</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Web Order ID:</td>" +
											"<td><strong>" + dr["id"].ToString() + "</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Customer UserID:</td>" +
											"<td><strong>" + dr["customer_id"].ToString() + "</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Customer Number:</td>" +
											"<td><strong>" + dr["spex_account"].ToString() + "</strong></td>" +
										"</tr>" +
									"</table>" +
									"<table border='1'>" +
										"<tr style='background:#eee'>" +
											"<td colspan='2'><strong>About You</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Customer Name:</td>" +
											"<td><strong>" + dr["user_name"].ToString() + "</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Customer UserID:</td>" +
											"<td><strong>" + dr["UserEmail"].ToString() + "</strong></td>" +
										"</tr>" +
									"</table>" +
									"<table border='1'>" +
										"<tr style='background:#eee'>" +
											"<td colspan='2'><strong>Billing Information</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Company:</td>" +
											"<td><strong>" + dr["organization"].ToString() + "</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Address1:</td>" +
											"<td><strong>" + dr["billing_address1"].ToString() + "</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Address2:</td>" +
											"<td><strong>" + dr["billing_address2"].ToString() + "</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>City:</td>" +
											"<td><strong>" + dr["billing_city"].ToString() + "</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>State:</td>" +
											"<td><strong>" + dr["billing_area"].ToString() + "</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>ZipCode:</td>" +
											"<td><strong>" + dr["billing_postcode"].ToString() + "</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Country:</td>" +
											"<td><strong>" + dr["billing_country"].ToString() + "</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Phone:</td>" +
											"<td><strong>" + dr["BillPhone"].ToString() + "</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Fax:</td>" +
											"<td><strong></strong></td>" +
										"</tr>" +
									"</table>" +
								"</div>" +
								"<div class='col-6-r'>" + 
									"<table border='1'>" +
										"<tr style='background:#eee'>" +
											"<td colspan='2'><strong>Shipping Information</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Name:</td>" +
											"<td><strong>" + dr["user_name"].ToString() + "</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Organization:</td>" +
											"<td><strong>" + dr["shipping_organization"].ToString() + "</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Address1:</td>" +
											"<td><strong>" + dr["shipping_address1"].ToString() + "</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Address2:</td>" +
											"<td><strong>" + dr["shipping_address2"].ToString() + "</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>City:</td>" +
											"<td><strong>" + dr["shipping_city"].ToString() + "</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>State:</td>" +
											"<td><strong>" + dr["shipping_area"].ToString() + "</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>ZipCode:</td>" +
											"<td><strong>" + dr["shipping_postcode"].ToString() + "</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Country:</td>" +
											"<td><strong>" + dr["shipping_country"].ToString() + "</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Partial Order:</td>" +
											"<td><strong>" + dr["permit_partial"].ToString() + "</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Phone:</td>" +
											"<td><strong>" + dr["ShipPhone"].ToString() + "</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Fax:</td>" +
											"<td><strong></strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Shipping Method:</td>" +
											"<td><strong>" + dr["shipping_method"].ToString() + "</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Carrier Account:</td>" +
											"<td><strong></strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Comments / Special Request:</td>" +
											"<td><strong>" + dr["Comments"].ToString() + "</strong></td>" +
										"</tr>" +
									"</table>" +
									"<table border='1'>" +
										"<tr style='background:#eee'>" +
											"<td colspan='2'><strong>Payment Information</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Payment Method:</td>" +
											"<td><strong>" + dr["payment_method"].ToString() + "</strong></td>" +
										"</tr>" +
										"<tr>" +
											"<td>Billing Name:</td>" +
											"<td><strong>" + dr["Billing_Name"].ToString() + "</strong></td>" +
										"</tr>" +
									"</table>" +
								"</div>";
				}
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
}