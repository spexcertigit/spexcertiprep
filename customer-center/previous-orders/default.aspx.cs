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
using System.Text.RegularExpressions;

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
			cusID = myUser.CustomerNumber.Trim();
			webCusID = myUser.UserID.ToString().Trim();
			//ltrPrevOrders.Text = getPrevOrders(cusID);
        }
		
        Region = myUser.Region;
        CurrencySymbol = myUser.CurrencySymbol;
        CatCode = myUser.DiscountCode;
		
		Page.Header.Title = "Previous Orders | SPEX CertiPrep";
		
        SetQuery();
    }
	  
    protected static string GetPrice(string PartNumber) {
		clsUser myUser2 = new clsUser();
        clsItemPrice price = new clsItemPrice(PartNumber, myUser2);
        return price.PriceText;
    }
	
	
	[WebMethod()]
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
				output = "<table id='loadOrder'><tr style='background:#ebebeb'><th colspan='5'>Web Order ID: " + id + "</th></tr><tr><th>Part #</th><th>Description</th><th>Quantity</th><th>Price</th><th>Total</th></tr>";
				while(dr.Read()) {
					part = dr["item_id"].ToString();
					item_price = Convert.ToSingle(RemoveSpecialCharacters(GetPrice(part)));
					qty = Convert.ToSingle(dr["item_quantity"]);
					total = item_price * qty;
					dcCode = dr["discount_code"].ToString();
					final_price = Convert.ToSingle(dr["FinalPrice"]);
					totalDC = Convert.ToSingle(dr["TotalDiscount"]);
					ship = dr["shipping_method"].ToString();
					
					output += "<tr><td>" + part + "</td><td>" + getProdName(part) + "</td><td>" + qty + "</td><td style='text-align:right'>"+ myUser3.CurrencySymbol + item_price + "</td><td style='text-align:right'>"+ myUser3.CurrencySymbol + total + "</td></tr>";
					subtotal = subtotal + item_price;
				}
				output += "</table><table class='tblSum'><tr><td style='text-align:right'>SUBTOTAL:</td><td style='text-align:right;font-weight:bold'>"+ myUser3.CurrencySymbol + subtotal + "</td></tr><tr><td  style='text-align:right'>TOTAL SAVINGS:</td><td style='text-align:right;font-weight:bold'>"+ myUser3.CurrencySymbol + totalDC + "</td></tr><tr><td style='text-align:right'>SHIPPING METHOD:</td><td style='text-align:right'>" + ship + "</td></tr><tr><td style='text-align:right'>FINAL TOTAL:<br>(SHIIPING NOT INCLUDED)</td><td style='text-align:right;font-weight:bold'>" + myUser3.CurrencySymbol + final_price + "</td></tr></table><div style='clear:both'></div>";
			}
		}
		return output;
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
	
	protected string getPrevOrders(int cusID) {
		string prevOrders = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
									
			string SQL =	"SELECT * FROM WebOrderItems WHERE customer_id = @cusID";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@cusID", SqlDbType.VarChar).Value = cusID;
				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					while(dr.Read()) {
						string partnum = dr["item_id"].ToString();
						
						prevOrders += 	"<tr>" +
											"<td>"+ partnum +"</td>" +
											"<td>"+"</td>" +
											"<td>"+ string.Format("{0:MM/dd/yyyy}", dr["date_ordered"]) +"</td>";
						prevOrders +=		"<td>"+ getCertificate(partnum) +"</td>";
						prevOrders +=		"<td>" + getMSDS(partnum) + "</td>" +
											"<td><a href=''>View Order</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;" + checkProduct(partnum) + "</td>" +
										"</tr>";
					}
				}
			}
		}
		return prevOrders;
	}
	
	public static string checkProduct(string part) {
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT cpPart FROM cp_roi_Prods WHERE cpPart = @part";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@part", SqlDbType.VarChar).Value = part;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				
				if (dr.HasRows) {
					dr.Read();
					return "<a id='buy_"+ part.Trim() +"' name='" + part.Trim() + "' class='reorder'>Re-order</a>";
				}
			}
		}
		return "<a name='" + part.Trim() + "' class='noprod'>Re-order</a>";
	}
	
	public static string chechProductType(string part)  {
		string output = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT cpType FROM cp_roi_Prods WHERE cpPart = @part";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@part", SqlDbType.VarChar).Value = part;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				
				if (dr.HasRows) {
					dr.Read();
					string cpType = dr["cpType"].ToString();
					if (cpType == "1") {
						output = "<b><a href='/products/product_organic.aspx?part=" + part + "'>" + part + "</a></b>";
					}else if (cpType == "2"){
						output = "<b><a href='/products/product_inorganic.aspx?part=" + part + "'>" + part + "</a></b>";
					}else if (cpType == "6") {
						output = "<b><a href='/products/product_labstuff.aspx?part=" + part + "'>" + part + "</a></b>";
					}
				}
			}
		}
		return output;
	}
	
	[WebMethod()]
	public static string getCertificate(string lot) {
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT FileName FROM certiCertifcates WHERE LotNumber = @lot";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@lot", SqlDbType.VarChar).Value = lot;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				
				if (dr.HasRows) {
					dr.Read();
					return "<a href='/certificates/"+ dr["FileName"].ToString() +"' target='_blank'>Download</a>";
				}else {
					return "<span style='color:#948787'>&#8212;</span>";
				}
			}
		}
		return "";
	}
	
	[WebMethod()]
	public static string getMSDS(string part) {
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT FileName FROM certiMSDS WHERE PartNumber = @part";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@part", SqlDbType.VarChar).Value = part;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				
				if (dr.HasRows) {
					dr.Read();
					return "<img class='pdfIcon' src='/images/pdf-icon.png' alt='"+ part +"' />&nbsp;&nbsp;<a href='/msds/" + dr["FileName"].ToString() + "' target='_blank'>SDS</a>";
				}else {
					return "<span style='color:#948787'>&#8212;</span>";
				}
			}
		}
		return "";
	}
	
	protected void dataProducts2_Selected(object sender, SqlDataSourceStatusEventArgs e) {
        ProductCount = e.AffectedRows;
        ProductListPagerSimple.Visible = ProductListPagerSimple3.Visible = (ProductCount > ProductListPagerSimple.PageSize);
    }
	
    private void SetQuery() {
        //string SQL = "SELECT * FROM WebOrderItems woi INNER JOIN WebOrderDetails wod ON woi.Order_Number = wod.id INNER JOIN cp_roi_SOH crs ON wod.id = crs.So_Nbr WHERE crs.Order_Status = 'C' AND woi.customer_id = " + cusID + " ORDER BY woi.date_ordered DESC";
        //Response.Write(SQL);
		string SQL = 	"SELECT soh.So_Nbr, soh.So_Date, sod.Date_Added, soh.Shipment_Nbr, sod.Part_Wo_Gl  " +
						"FROM cp_roi_CM cm " +
						"INNER JOIN cp_roi_SOH_Full soh ON cm.Bill_To_Customer = soh.Cust_Nbr " +
						"AND cm.Ship_To_Code = soh.Ship_To_Addr_Code " +
						"INNER JOIN cp_roi_SOD sod ON soh.So_Nbr = sod.So_Nbr " +
						"WHERE cm.RecordID = '" + cusID + "' ORDER BY soh.So_Date DESC";

        dataProducts.SelectCommand = SQL;
        dataProducts.DataBind();
		
		//SQL = "SELECT * FROM WebOrderItems woi INNER JOIN WebOrderDetails wod ON woi.Order_Number = wod.id INNER JOIN cp_roi_SOH crs ON wod.id = crs.So_Nbr WHERE crs.Order_Status = 'C' AND woi.customer_id = '" + webCusID + "' ORDER BY woi.date_ordered DESC";
		
		SQL = "SELECT * FROM WebOrderItems woi INNER JOIN WebOrderDetails wod ON woi.Order_Number = wod.id WHERE woi.customer_id = '" + webCusID + "' AND wod.site = 'cp' AND ((wod.id NOT IN(SELECT So_Nbr FROM cp_roi_SOH) AND wod.paid = 'y') OR wod.id IN (SELECT So_Nbr FROM cp_roi_SOH WHERE Order_Status = 'C')) ORDER BY woi.date_ordered DESC";
		
		dataProducts3.SelectCommand = SQL;
        dataProducts3.DataBind();
		
		DateTime myDateTime = DateTime.Now;
		string sqlFormattedDate = myDateTime.ToString("yyyy-MM-dd HH:mm:ss");

		SQL = 	"SELECT soh.So_Nbr, soh.So_Date, sod.Date_Added, soh.Shipment_Nbr, sod.Part_Wo_Gl, sod.Expire  " +
						"FROM cp_roi_CM cm " +
						"INNER JOIN cp_roi_SOH_Full soh ON cm.Bill_To_Customer = soh.Cust_Nbr " +
						"AND cm.Ship_To_Code = soh.Ship_To_Addr_Code " +
						"INNER JOIN cp_roi_SOD sod ON soh.So_Nbr = sod.So_Nbr " +
						"WHERE cm.RecordID = '" + webCusID + "' ORDER BY soh.So_Date DESC";
		
		dataProducts2.SelectCommand = SQL;
        dataProducts2.DataBind();
    }
	
	[WebMethod()]
	public static string getLotNumber(string soNbr, string part) {
		string So_Nbr = soNbr;
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT lot.Lot_Nbr FROM cp_roi_Shiplist_SOD_AllocatedLots lot INNER JOIN cp_roi_Shiplist ship ON lot.Reference_Nbr = ship.Shiplist_Nbr WHERE ship.Sales_Order = @So_Nbr AND lot.Part = @part";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@So_Nbr", SqlDbType.VarChar).Value = So_Nbr;
                cmd.Parameters.Add("@part", SqlDbType.VarChar).Value = part;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				
				if (dr.HasRows) {
					dr.Read();
					return dr["Lot_Nbr"].ToString();				
				}else {
					return "<span style='color:#948787'>&#8212;</span>";
				}
			}
		}
		return "";
	}
	
	[WebMethod()]
	public static string getWebLotNumber(string soNbr, string part) {
		string So_Nbr = "W" + soNbr;
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT lot.Lot_Nbr FROM cp_roi_Shiplist_SOD_AllocatedLots lot INNER JOIN cp_roi_Shiplist ship ON lot.Reference_Nbr = ship.Shiplist_Nbr WHERE ship.Sales_Order = @So_Nbr AND lot.Part = @part";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@So_Nbr", SqlDbType.VarChar).Value = So_Nbr;
                cmd.Parameters.Add("@part", SqlDbType.VarChar).Value = part;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				
				if (dr.HasRows) {
					dr.Read();
					return dr["Lot_Nbr"].ToString();				
				}else {
					return "<span style='color:#948787'>&#8212;</span>";
				}
			}
		}
		return "";
	}
	
	public string getPartNum(string part) {
		string output = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT Item_Part_Nbr FROM cp_roi_IM WHERE Part_Number = @part";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@part", SqlDbType.VarChar).Value = part;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				
				if (dr.HasRows) {
					dr.Read();
					output = dr["Item_Part_Nbr"].ToString().Trim();
				}
			}
		}
		return output;
	}
	
	public static string getProductLink(string part) {
		string output = "";
		part = part.Trim();
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT cpType FROM cp_roi_Prods WHERE cpPart = @part";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@part", SqlDbType.VarChar).Value = part;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				
				if (dr.HasRows) {
					dr.Read();
					string cpType = dr["cpType"].ToString();
					if (cpType == "1") {
						output = "<b><a href='/products/product_organic.aspx?part=" + part + "'>" + part + "</a></b>";
					}else if (cpType == "2"){
						output = "<b><a href='/products/product_inorganic.aspx?part=" + part + "'>" + part + "</a></b>";
					}else if (cpType == "6") {
						output = "<b><a href='/products/product_labstuff.aspx?part=" + part + "'>" + part + "</a></b>";
					}
				}else {
					output = part;
				}
			}
		}
		return output;
	}
	
	public string getExpiryDate(string expire, string date) {
		if (expire != "") {
			string resultString = Regex.Match(expire, @"\d+").Value;
			int expiryMonth = Convert.ToInt32(resultString);
			
			DateTime dt = Convert.ToDateTime(date); 
			
			return dt.AddMonths(expiryMonth).ToString();
		}else {
			return "";
		}
	}
	
	public string convertDate(string date) {
		if (date != "") {
			return string.Format("{0:MM/dd/yyyy}", Convert.ToDateTime(date));
		}else {
			return "";
		}
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
					if (stat == "C") {
						return "<span style='color:#5cb85c'>APPROVED</span>";
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
						return "<span style='color:#d9534f'>REJECTED</span>";
					}else {
						return "<span style='color:#f0ad4e'>RECEIVED</span>";
					} //#d9534f red
					cmd.Connection.Close();
				}
			}
		}
		return "";
	}
	
	public string getTimeSpan(string expire, string date) {
		string output = "";
		if (expire != "") {
			string resultString = Regex.Match(expire, @"\d+").Value;
			int expiryMonth = Convert.ToInt32(resultString);
			
			DateTime dt = Convert.ToDateTime(date); 
			dt = dt.AddMonths(expiryMonth);
			
			TimeSpan interval = dt.Subtract(DateTime.Now);
			if (interval < TimeSpan.FromDays(0)) {
				output = "<span style='color:#d9534f'>EXPIRED</span>";
			}else if (interval < TimeSpan.FromDays(30)) {
				output = "<span style='color:#f0ad4e'>" + interval.ToString("%d") + " days " + interval.ToString("%h") + " hours and " + interval.ToString("%m") + " minutes.</span>";
			}else {
				output = "<span style='color:#5cb85c'>" + interval.ToString("%d") + " days " + interval.ToString("%h") + " hours and " + interval.ToString("%m") + " minutes.</span>";
			}
			
		}else {
			output = "";
		}
		return output;
	}

}