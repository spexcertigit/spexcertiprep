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
		
        Region = myUser.Region;
        CurrencySymbol = myUser.CurrencySymbol;
        CatCode = myUser.DiscountCode;
		
		Page.Header.Title = "Current Orders | SPEX CertiPrep";
	
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
				}else {
					return ifNoName(part);
				}
			}
		}
		return "";
	}
		
	protected static string ifNoName(string part) {
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT Description FROM cp_roi_IM WHERE Item_Part_Nbr = @part";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@part", SqlDbType.VarChar).Value = part;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if(dr.HasRows) {
					dr.Read();
					return dr["Description"].ToString().Trim();
				}
			}
		}
		return "";
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
	
	public static string checkProductType(string part)  {
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
				}else {
					output = part;
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
	
	public string getProducts(string order) {
		string output = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT item_id, item_quantity FROM WebOrderItems WHERE Order_Number = @order";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@order", SqlDbType.VarChar).Value = order;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				
				while (dr.Read()) {
					output += "<div class='item-of-" + order + "' data-qty='" + dr["item_quantity"].ToString().Trim() + "'>" + dr["item_id"].ToString().Trim() + "</div>";
				}
				cmd.Connection.Close();
			}
		}
		return output;
	}
	
    protected void dataOrderSummary_Selected(object sender, SqlDataSourceStatusEventArgs e) {
        ProductCount = e.AffectedRows;
        ProductListPagerSimple.Visible = (ProductCount > ProductListPagerSimple.PageSize);
    }
		
    private void SetQuery() {		
		string SQL = 	"SELECT * FROM WebOrderDetails wod WHERE wod.customer_id = '" + webCusID + "' AND wod.site = 'cp' AND ((wod.id NOT IN(SELECT So_Nbr FROM cp_roi_SOH) AND wod.paid != 'y') OR wod.id IN (SELECT So_Nbr FROM cp_roi_SOH WHERE Order_Status = 'O')) ORDER BY wod.orderdate DESC";
		
		dataOrderSummary.SelectCommand = SQL;
		dataOrderSummary.DataBind();
		
		
        string output = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			SQL = "SELECT * FROM WebOrderItems woi INNER JOIN WebOrderDetails wod ON woi.Order_Number = wod.id WHERE woi.customer_id = @webCusID AND wod.site = 'cp' AND ((wod.id NOT IN(SELECT So_Nbr FROM cp_roi_SOH) AND wod.paid != 'y') OR wod.id IN (SELECT So_Nbr FROM cp_roi_SOH WHERE Order_Status = 'O')) ORDER BY woi.date_ordered DESC";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@webCusID", SqlDbType.VarChar).Value = webCusID;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				string tempID = "";
				while (dr.Read()) {
					if (tempID != dr["Order_Number"].ToString()) {
						output += "<tr><td class='seperator'>Web Order ID: " + dr["Order_Number"].ToString() + "</td><td class='seperator'></td><td class='seperator'></td><td class='seperator'></td><td class='seperator'></td><td class='seperator'></td><td class='seperator'></td></tr>";
						tempID =  dr["Order_Number"].ToString();
					}
					output += 	"<tr>" +
									"<td>" + checkProductType(dr["item_id"].ToString()) + "</td>" +
									"<td>" + getWebLotNumber(dr["Order_Number"].ToString(), dr["item_id"].ToString()) + "</td>" +
									"<td>" + string.Format("{0:MM/dd/yyyy}", dr["date_ordered"]) + "</td>" +
									"<td>" + getCertificate(getLotNumber(dr["Order_Number"].ToString(), dr["item_id"].ToString())) + "</td>" +
									"<td>" + getMSDS(dr["item_id"].ToString()) + "</td>" +
									"<td>" + getOrderStatus(dr["Order_Number"].ToString()) + "</td>" +
									"<td><a class='viewOrderBtn' data-so='" + dr["Order_Number"].ToString() + "'>View Order</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;" + checkProduct(dr["item_id"].ToString()) + "</td>" +
								"</tr>";
				}
				cmd.Connection.Close();
			}
		}
		//ltrCurrOrders.Text = output;
		Response.Write("<script>console.log('" + cusID + "')</script>");
      		
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
						return "<span>Processed</span>";
					}else if (stat == "C") {
						return "<span>Completed</span>";
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
						return "<span>Rejected</span>";
					}else {
						return "<span>Received</span>";
					} //#d9534f red
					cmd.Connection.Close();
				}
			}
		}
		return "";
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
	
	[WebMethod()]
	public static string GetDataCAS(string partnumber)
	{
		string Concentration = "";
		string Component = "";
		string Unit = "";
		string CAS = "";
		string CAStable = "";
		string CasClass = "";
		int ctr = 0;
	
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
		string SQL = "SELECT  cp.cpPart, " +
						"		cp.cpDescrip, " +
						"		ca.caNameWeb, " +
						"		CAST(cpc.cpmpConc AS varchar(10)) AS cpmpConc, " +
						"		cu.cuUnit " +
						"	FROM certiProdComps AS cpc JOIN certiAnalytes AS ca ON cpc.cpmpAnalyteID = ca.caID " +
						"		JOIN cp_roi_Prods AS cp ON cpc.cpmpProd = cp.cpPart " +
						"		JOIN certiUnits AS cu ON cpc.cpmpUnits = cu.cuID " +
						"	WHERE cpc.cpmpConc IS NOT NULL AND cpc.cpmpProd = @partnumber " +
						"	ORDER BY cpc.cpmpConc DESC, ca.caNameWeb";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@partnumber", SqlDbType.VarChar).Value = partnumber;
                cmd.Connection.Open();
                //SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					CAStable = "<tbody>";
					while (dr.Read()) {
						ctr++;
						
						Concentration = dr["cpmpConc"].ToString();
						Component = dr["caNameWeb"].ToString();
						Unit = dr["cuUnit"].ToString();
						
						CasClass = ctr%2 == 0 ? " " : "class='odd'";
						
						CAStable += "<tr "+ CasClass +">";
						CAStable += "<td class='desc'>" + Component + "</td>";
						CAStable += "<td>" + Concentration + " " + Unit + "</td>";
						CAStable += "</tr>";
                    }
					CAStable += "</tbody>";
				} 
				else {
					cmd.Connection.Close();
				}
				cmd.Connection.Close();
            }
			
			CAStable = "<table id='productdata_table'>"+
					"	<thead>"+
					"		<tr class='odd'>"+
					"			<th scope='col'>Components</th>"+
					"			<th scope='col'>Concentration</th>"+
					"		</tr>"+
					"	</thead> "+ 
							CAStable + 
					"	</table>";
		}
		return CAStable;
	}	
	
    protected void lbResults_Change(object sender, EventArgs e) {
        SetQuery();
        lvOrderSummary.DataBind();
    }
	
	protected void DataPager_Init(object sender, EventArgs e) {
        var dp = sender as DataPager;
        if (dp == null) {
            throw new Exception("This Event handler only works for DataPager web controls.");
        }

        string strPageNum = Request.QueryString[dp.QueryStringField];
        if (strPageNum == null) return;  // param not there, DataPager will use default

        int pageNum = -1;
        if (int.TryParse(strPageNum, out pageNum) && pageNum > 0) {
            return; // valid page number parameter, let DataPager handle it
        }

        dp.QueryStringField = null; // Force default
    }
}