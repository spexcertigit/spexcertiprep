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
		}else {
			ltrSummary.Text = "Please select a web order.";
		}
		
        Region = myUser.Region;
        CurrencySymbol = myUser.CurrencySymbol;
        CatCode = myUser.DiscountCode;
		
		Page.Header.Title = "Order Summary | SPEX CertiPrep";
		
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