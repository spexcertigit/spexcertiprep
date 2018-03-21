using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Services;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Text;

public partial class order_summary : System.Web.UI.Page
{
    protected string CurrencySymbol = "";
    protected List<ShoppingCartItem> ItemList;
	protected string OrderID = "";
	protected string orderItems = "";
	protected string orderItemsMobile = "";
	protected string strSubTotal = "";
	protected string strSavings = "";
	protected string strSPoints = "";
	protected string strTax = "";
	protected string strTotal = "";
	protected string cusEmail = "";
	protected string cusCCode = "";
	
	protected void Page_Load(object sender, EventArgs e)
    {
    	
        clsUser myUser = new clsUser();
        CurrencySymbol = myUser.CurrencySymbol;
        clsShoppingCart myCart = new clsShoppingCart(myUser.UserID);

        if (!Page.IsPostBack) {
            //Populate expiration year dropdown on Billing screen
            for (int x = DateTime.Now.Year; x < DateTime.Now.Year + 7; x++) {
                ExpirationYear.Items.Add(new ListItem(x.ToString(), x.ToString()));
            }
            review_promocode.Text = myCart.PromoCode;
			if (myCart.PromoCode.ToString() == "FREESHIP18") {
				shipmethod.Items.Remove(shipmethod.Items.FindByValue("UPS_2nd_Day"));
				shipmethod.Items.Remove(shipmethod.Items.FindByValue("UPS_Next_Day_Air"));
				shipmethod.Items.Remove(shipmethod.Items.FindByValue("FedEx_2Day"));
				shipmethod.Items.Remove(shipmethod.Items.FindByValue("FedEx_NextDay"));
			}
        }

        myCart.RefreshPrices(myUser.Region, myUser.DiscountCode, myUser.PriceCode, myUser.DiscountAmount);

		pnlPromotion.Visible = pnlPromotion2.Visible = myCart.ShowPromotionAlert;
        pnlHazardous.Visible = pnlHazardous2.Visible = myCart.ShowShippingAlert;
        pnlRefrigerator.Visible = pnlRefrigerator2.Visible = myCart.ShowRefrigeratorAlert;
        pnlFreezer.Visible = pnlFreezer2.Visible = myCart.ShowFreezerAlert;

        ltrSubtotal.Text = myUser.CurrencySymbol + myCart.OrderSubtotal.ToString("##,##0.00");
        ltrSavings.Text = myUser.CurrencySymbol + myCart.DiscountTotal.ToString("##,##0.00");
        ltrSPoints.Text = myCart.SPoints.ToString();
        ltrTax.Text = myUser.CurrencySymbol + "0.00";
        ltrTotal.Text = myUser.CurrencySymbol + myCart.OrderTotal.ToString("##,##0.00");
        ItemList = myCart.ItemList;

		cartItems();
		mobileCartItems();
		if (myCart.ItemCount > 0) {
            if (myUser.LoggedIn) {
                mvAction.SetActiveView(vwSubmit);
            } else {
                mvAction.SetActiveView(vwLogin);
                if (myUser.Region == "UK" || myUser.Region == "USA") {
	                cmdSubmit.Text = ""; //COMPLETE ORDER
                } else {
	                cmdSubmit.Text = ""; //REQUEST QUOTE
                }
            }
        } else {
			if (myUser.LoggedIn) {
				mvAction.SetActiveView(vwSubmit);
				cmdSubmit.OnClientClick = "alert('You have no items in your shopping cart.');return false;";
				if (myUser.Region == "UK" || myUser.Region == "USA") {
					cmdEmpty.Text = ""; //COMPLETE ORDER
				} else {
					cmdEmpty.Text = ""; //REQUEST QUOTE
				}
			} else {
                mvAction.SetActiveView(vwLogin);
			}
        }
        

        //Delete an item from the cart
        if (Request.QueryString["action"] != null && Request.QueryString["action"].ToString().ToLower() == "delete") {
            int ItemID = 0;
            if (Request.QueryString["id"] != null && Int32.TryParse(Request.QueryString["id"].ToString(), out ItemID)) {
                myCart.RemoveItem(ItemID);
                //Response.Redirect("/order_summary.aspx");
            }
			
        }else if (Request.QueryString["action"] != null && Request.QueryString["action"].ToString().ToLower() == "add") {
			myCart.AddItem(Request.QueryString["part"].ToString(), 1);
			//Response.Redirect("/order_summary.aspx");
			cartItems();
			mobileCartItems();
		}

        if (Session["ReturnURL"] == null) { 
        } else {
            //hlReturn.NavigateUrl = Session["ReturnURL"].ToString();
            //ltrReturn.Text = "&lt; Return to shopping";
        }
    }
	[WebMethod()]
	public static void checkCartItems() {
		clsUser myUser = new clsUser();
        clsShoppingCart myCart = new clsShoppingCart(myUser.UserID);
	}
	protected string cartItems() {
		orderItems = "<table id='summary_table' align='center' style='width:100%'>" + 
					"<thead>" +
						"<tr>" +
                            "<th scope='col' class='item'>Item</th>" +
                            "<th scope='col'></th>" +
                            "<th scope='col' class='desc'>Description</th>" +
                            "<th scope='col'>Volume</th>" +
                            "<th scope='col'>Hazardous</th>" +
                            "<th scope='col'>Storage</th>" +
                            "<th scope='col' class='quatity'>Quantity</th>" +
                            "<th scope='col' class='price'>Your Price</th>" +
                            "<th scope='col' class='price'>Total</th>" +
                        "</tr>" +
                    "</thead>" +
                    "<tbody>";
		
		int Counter = 1;
		if (ItemList.Count > 0) {
			foreach (ShoppingCartItem si in ItemList) {		
				orderItems += "<tr id='row" + si.ProductID + "'>" +
								"<td class='summaryremove'><a class='removeItem' data-prodid='" + si.ProductID + "'><img src='/images/remove_button.gif' width='27' height='27' alt='Remove Item' id='remove" + Counter+ "' class='removeicon' /></a></td>" +
								"<td class='summarythumb'><img src='images/" + si.Thumbnail +"' width='37' height='37' alt='Thumbnail' /></td>" +
								"<td class='summarydesc'>Part #: " + si.PartNumber + si.PromoIcon + "<br /><input type='hidden' class='hiddenPart' value='" + si.PartNumber + "' /><span class='greensmall'>" + si.ProdTitle + "</span></td>" +
								"<td class='summaryvol'>" + si.Volume + "</td>" +
								"<td class='summaryhaz'>" +
                                "<img src='/images/" + si.ShippingIcon + "' width='19' height='17' alt='" + si.Hazardous + "' class='smallicon' align='absmiddle' />" + si.Hazardous +
								"</td>" +
								"<td class='summarystore'>" +
                                "<img src='/images/" + si.StorageIcon + "' width='19' height='17' alt='" + si.Storage + "' class='smallicon' align='absmiddle' />" + si.Storage +
								"</td>" +
								"<td class='summaryprice'>" +
                                "<div class='quantitybox_" + si.ProductID + "'>" +
                                    "<div id='quantity_wrapper'>" +
				                        "<select id='quantity" + si.ProductID + "' class='quantity_dd' style='height:27px;' data-ctr='" + Counter + "' data-prodid='"+ si.ProductID +"'>";
				int TopRange = 20;
				if (si.Qty > 10) {
					TopRange = si.Qty + 10;
				}
				for (int X = 1; X <= TopRange; X++) {
					orderItems += "<option value='" + X + "'";
					if (X == si.Qty) {
                        orderItems += "selected = 'selected' ";
					}
					orderItems += ">" + X + "</option>";
				}
				orderItems += 			"</select>" +
                                    "</div>" +
                                "</div>" +
                            "</td>" +
                            "<td class='summaryprice'>" + CurrencySymbol + si.BaseCost.ToString("##,##0.00") + "</td>" +
                            "<td class='summaryprice'>" + CurrencySymbol + si.LineCost.ToString("##,##0.00") + "</td>" +
                        "</tr>";
			}
		}else {
			orderItems += 	"<tr>" +
								"<td></td>" +
								"<td class='desc'>No Items In Cart</td><td></td>" +
								"<td></td>" +
								"<td></td>" +
							"</tr>";
		}
		orderItems += "</tbody></table>";
		
		return orderItems;
	}
	
	protected string mobileCartItems() {
		orderItemsMobile = "<table id='mobile_summary_table' align='center' style='width:100%' border='0'>";
		int Counter2 = 1;
		if (ItemList.Count > 0) {
			foreach (ShoppingCartItem si in ItemList) {
				orderItemsMobile += "<tr id='row" + si.ProductID + "'>" +
										"<td>" +
											"<a class='removeItem' data-prodid='" + si.ProductID + "'><img src='/images/remove_button.gif' width='27' height='27' alt='Remove Item' id='remove" + Counter2 + "' class='removeicon' /></a>" +
										"</td>" +
										"<td>" +
											"<table class='product-info'>" +
												"<thead>" +
													"<tr>" +
														"<th scope='col' style='width:5%'>Item</th>" +
														"<th scope='col' style='width:35%'>Description</th>" +
														"<th scope='col' style='width:5%; text-align:center'>Volume</th>" +
														"<th scope='col' style='width:20%; text-align:center'>Hazardous</th>" +
														"<th scope='col' style='width:20%; text-align:center'>Storage</th>" +
													"<tr/>" +
												"</thead>" +
												"<tbody>" +
													"<tr>" +
														"<td><img src='images/"+ si.Thumbnail + "' width='37' height='37' alt='Thumbnail' /></td>" +
														"<td>Part #: " + si.PartNumber + si.PromoIcon + "<br /><span class='greensmall'>" + si.ProdTitle + "</span></td>" +
														"<td style='text-align:center'>" + si.Volume + "</td>" +
														"<td style='text-align:center'><img src='/images/" + si.ShippingIcon + "' width='19' height='17' alt='" + si.Hazardous + "' class='smallicon' align='absmiddle' />" + si.Hazardous + "</td>" +
														"<td style='text-align:center'><img src='/images/" + si.StorageIcon +"' width='19' height='17' alt='" + si.Storage + "' class='smallicon' align='absmiddle' />" + si.Storage + "</td>" +
													"</tr>" +
												"</tbody>" +
											"</table>" +
											"<table class='product-pricing'>" +
												"<tbody>" +
													"<tr>" +
														"<td style='width:10%;'>Quantity: </td>" +
														"<td style='width:14%'>" +
															"<div class='quantitybox_" + si.ProductID + "'>" +
																"<select id='quantity"+ si.ProductID +"' style='height:33px;' class='quantity_dd' data-ctr='" + Counter2 +"' data-prodid='" + si.ProductID +"'>";
																int TopRange = 20;
																if (si.Qty > 10) {
																	TopRange = si.Qty + 10;
																}
																for (int X = 1; X <= TopRange; X++) {
																	orderItemsMobile += "<option value='" + X + "' ";
																	if (X == si.Qty) {
																		orderItemsMobile += "selected = 'selected' ";
																	} 
																	orderItemsMobile += ">" + X + "</option>";
																}
											orderItemsMobile += "</select>" +
															"</div>" +
														"</td>" +
														"<td style='text-align:right'>Your Price: </td>" +
														"<td style='color:#ee1c27; font-size:16px;'>" + CurrencySymbol + si.BaseCost.ToString("##,##0.00") + "</td>" +
														"<td style='text-align:right'>Total: </td>" +
														"<td style='color:#ee1c27; font-size:16px;'>" + CurrencySymbol + si.LineCost.ToString("##,##0.00") +"</td>" +
													"</tr>" +
												"</tbody>" +
											"</table>" +
										"</td>" +
									"</tr>";
				Counter2++;
			}
			orderItemsMobile += "</table>";
		}else {
			orderItemsMobile += "<table id='mobile_summary_table' align='center' style='width:100%' border='1'>" +
									"<tr>" +
										"<td class='desc' colspan='2' style='text-align:center'>" +
											"No Items In Cart" +
										"</td>" +
									"</tr>" +
								"</table>";
		}
				
		return orderItemsMobile;
	}
    protected void cmdAddPart_Click(object sender, EventArgs e) {
        clsUser myUser = new clsUser();
        clsShoppingCart myCart = new clsShoppingCart(myUser.UserID);
        myCart.AddItem(review_partsearch.Text.ToString(), 1);
        Response.Redirect("/order_summary.aspx");
    }
    protected void cmdLogin_Click(object sender, EventArgs e) {
        Response.Redirect("/register.aspx?redirect=order_summary");
    }
    protected void cmdPromo_Click(object sender, EventArgs e) {
        clsUser myUser = new clsUser();
        clsShoppingCart myCart = new clsShoppingCart(myUser.UserID);
        myCart.PromoCode = review_promocode.Text.Trim();
        Response.Redirect("/order_summary.aspx");
    }

    protected void cmdSubmit_Click(object sender, EventArgs e) {
        //User is on the shopping cart page, going to the Billing Info page

        clsUser myUser = new clsUser();
        if (!myUser.LoggedIn) {
            Response.Redirect("login.aspx?redirect=order_summary");
        } else {
            if (myUser.Region == "UK" || myUser.Region == "USA") {
                Page.Title = "SPEX CertiPrep - Billing Information";
                rfvbillState.Enabled = (myUser.Region == "USA");
                billFirstname.Text = myUser.FirstName;
                billLastname.Text = myUser.LastName;
	            if (!string.IsNullOrEmpty(myUser.CustomerNumber)) {
                    string BillingTable = "";
   	                if (myUser.Region == "UK") {
			            BillingTable = "uk_roi_CMBILL";
		            } else {
			            BillingTable = "cp_roi_CMBILL";
		            }
                    using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
                        string SQL = "SELECT * FROM " + BillingTable + " WHERE Bill_To_Customer = @CustomerNumber";
                        using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                            cmd.CommandType = CommandType.Text;
                            cmd.Parameters.Add("@CustomerNumber", SqlDbType.Char, 6).Value = myUser.CustomerNumber;
                            cmd.Connection.Open();
                            SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                            if (dr.HasRows) {
                                dr.Read();
			                    billAddress1.Text = dr["Address_1"].ToString();
			                    billAddress2.Text = dr["Address_2"].ToString();
			                    billOrganization.Text = dr["Customer_Name"].ToString();
			                    billCity.Text = dr["City"].ToString();
			                    billState.Text =  dr["State"].ToString().Trim();
			                    billZIP.Text = dr["Zip"].ToString();
			                    billPhone.Text = dr["Phone"].ToString();
                            }
                            cmd.Connection.Close();
                        }
                    }
	            }
                mvForm.SetActiveView(vwBilling);
            } else {
                mvForm.SetActiveView(vwShipping);
                lbReturnShoppingCart2.Text = "Return to Shopping Cart";
            }
        }
    }
    protected void cmdBilling_Click(object sender, EventArgs e) {
        //User is on the Billing Info page, going to the Shipping Info page

        clsUser myUser = new clsUser();
        if (!myUser.LoggedIn) {
            Response.Redirect("login.aspx?redirect=order_summary");
        } else {
            Page.Title = "SPEX CertiPrep - Shipping Information";
            rfvshipState.Enabled = (myUser.Region == "USA");
            shipFirstname.Text = myUser.FirstName;
            shipLastname.Text = myUser.LastName;

            if (myUser.Region == "UK") {
                dataShippingAddresses.SelectCommand = "SELECT * FROM uk_roi_CMSHIP WHERE Bill_To_Customer = @CustomerNumber";
            }
            if (myUser.LoggedIn && myUser.CustomerNumber != "") {
                dataShippingAddresses.SelectParameters[0].DefaultValue = myUser.CustomerNumber;
            }

            //Only show the "Same as Billing" checkbox for US/UK customers
            chkSameAsBilling.Visible = (myUser.Region == "USA" || myUser.Region == "UK");

            lvShippingAddresses.DataBind();
            mvForm.SetActiveView(vwShipping);
        }
    }
    protected void cmdShipping_Click(object sender, EventArgs e) {
        //User is on the Shipping Info page, going to the Order Summary page

        clsUser myUser = new clsUser();
        if (!myUser.LoggedIn) {
            Response.Redirect("login.aspx?redirect=order_summary");
        } else {
            Page.Title = "SPEX CertiPrep - Order Summary";
            ltrSumBillTo.Text = billFirstname.Text.Trim() + " " + billLastname.Text.Trim() + "<br />" +
				"<div>" + billOrganization.Text.Trim() + "</div>" +
				billAddress1.Text.Trim() + "<br />" +
                "<div>" + billAddress2.Text.Trim() + "</div>" +
                billCity.Text.Trim() + ", " + billState.Text.Trim() + " " + billZIP.Text.Trim();

            ltrSumShipTo.Text = shipFirstname.Text.Trim() + " " + shipLastname.Text.Trim() + "<br />" +
				"<div>" + shipOrganization.Text.Trim() + "</div>" +
				shipAddress1.Text.Trim() + "<br />" +
				"<div>" + shipAddress2.Text.Trim() + "</div>" +
                shipCity.Text.Trim() + ", " + shipState.Text.Trim() + " " + shipZIP.Text.Trim() + "<br />" +
                shipPhone.Text.Trim();
            if (shipFax.Text.Trim().Length > 0) {
                ltrSumShipTo.Text += "<br />" + shipFax.Text.Trim();
            }

        	if (CardNumber.Text.Trim().Length > 4) {
                ltrSumPayment.Text = CardType.SelectedItem.Text + "<br />" +
                    "XXXXXXXXXXXX" + CardNumber.Text.Trim().Substring(CardNumber.Text.Trim().Length - 4) + "<br />";
            }
        	if (billPO.Text.Trim().Length > 0) {
                ltrSumPayment.Text += "PO # " + billPO.Text.Trim();
            }

            if (myUser.CustomerNumber != "") {
                ltrSumAccount.Text = myUser.CustomerNumber;
            } else {
                ltrSumAccount.Text = "Not Yet Assigned";
            }

            ltrSumSubtotal.Text = ltrSubtotal.Text;
            ltrSumSavings.Text = ltrSavings.Text;
            ltrSumSPoints.Text = ltrSPoints.Text;
            ltrSumTax.Text = ltrTax.Text;
            ltrSumShippingMethod.Text = shipmethod.SelectedItem.Text;
            ltrSumCarrierAccount.Text = ShipAccountNo.Text;
            ltrSumTotal.Text = ltrTotal.Text;

            mvForm.SetActiveView(vwSummary);
		}
    }
    protected void cmdShipAddress_Click(object sender, EventArgs e) {
        //Choosing a previously used address to populate shipping address fields

        Button cmdShipAddress = (Button)sender;
        chkSameAsBilling.Checked = false;
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            clsUser myUser = new clsUser();
            string SQL = "";
            if (myUser.Region == "UK") {
                SQL = "SELECT * FROM uk_roi_CMSHIP WHERE RecordID = @RecordID";
            } else {
                SQL = "SELECT * FROM cp_roi_CMSHIP WHERE RecordID = @RecordID";
            }
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@RecordID", SqlDbType.Char, 11).Value = cmdShipAddress.CommandArgument;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                if (dr.HasRows) {
                    dr.Read();
                    shipPhone.Text = dr["Phone"].ToString();
					shipOrganization.Text = dr["Customer_Name"].ToString();
					shipAddress1.Text = dr["Address_1"].ToString();
					shipAddress2.Text = dr["Address_2"].ToString();
                    shipCity.Text = dr["City"].ToString();
                    shipState.Text = dr["State"].ToString().Trim();
                    shipZIP.Text = dr["Zip"].ToString();
                }
                cmd.Connection.Close();
            }
        }
    }

    protected void cmdSummary_Click(object sender, EventArgs e) {
        //User is on the Order Summary page, checking out then going to the Receipt page

        clsUser myUser = new clsUser();
        if (!myUser.LoggedIn) {
            Response.Redirect("login.aspx?redirect=order_summary");
        } else {
            if (!tccheck.Checked) {
                pnlSummaryErrorbox.Visible = true;
                ltrSummaryErrorMessage.Text = "You must agree to the Terms And Conditions.";
            } else {
                clsShoppingCart myCart = new clsShoppingCart(myUser.UserID);

				myCart.SaveOrder(
					myUser.Region,
					myUser.CustomerNumber,
					myUser.FirstName + " " + myUser.LastName,
					myUser.Email,
					myUser.DiscountCode,
					myUser.PriceCode,
					myUser.DiscountAmount,
					sales_quote.Text.Trim(),
					review_promocode.Text.Trim(),
					shipmethod.SelectedItem.Text,
					ShipAccountNo.Text.Trim(),
					shippartial.Checked,
					billFirstname.Text.Trim(),
					billLastname.Text.Trim(),
					billOrganization.Text.Trim(),
					billPhone.Text.Trim(),
					billFax.Text.Trim(),
					billAddress1.Text.Trim(),
					billAddress2.Text.Trim(),
					billCity.Text.Trim(),
					billState.Text.Trim(),
					billZIP.Text.Trim(),
					billPO.Text.Trim(),
					CardType.SelectedValue,
					CardNumber.Text.Trim(),
					ExpirationMonth.SelectedValue,
					ExpirationYear.SelectedValue,
					CVV.Text.Trim(),
					shipFirstname.Text.Trim(),
					shipLastname.Text.Trim(),
					shipPhone.Text.Trim(),
					shipFax.Text.Trim(),
					chkResidential.Checked,
					shipOrganization.Text.Trim(),
					shipAddress1.Text.Trim(),
					shipAddress2.Text.Trim(),
					shipCity.Text.Trim(),
					shipState.Text.Trim(),
					shipZIP.Text.Trim(),
					Notes.Text.Trim());

				OrderID = myCart.OrderID;
				ltrOrderNumber.Text = "#" + OrderID;
				Page.Title = "SPEX CertiPrep - Order Receipt - Order #" + OrderID;
				ltrReceiptCustomerMail.Text = cusEmail = myUser.Email;
				cusCCode = myUser.Region;
				if (cusCCode == "USA") {
					cusCCode = "US";
				}

                ltrRecSubtotal.Text = ltrSubtotal.Text;
                ltrRecSavings.Text = ltrSavings.Text;
                ltrRecSpoints.Text = ltrSPoints.Text;
                ltrRecTax.Text = ltrTax.Text;
                ltrRecShippingMethod.Text = shipmethod.SelectedItem.Text;
                ltrRecTotal.Text = ltrTotal.Text;
                if (ShipAccountNo.Text.Trim().Length > 0) {
                    ltrRecShipAccountNo.Text = "A/C: " + ShipAccountNo.Text.Trim();
                } else {
                    ltrRecShipAccountNo.Text = "";
                }
                ltrRecBillTo.Text = ltrSumBillTo.Text;
                ltrRecShipTo.Text = ltrSumShipTo.Text;
                ltrRecAccount.Text = ltrSumAccount.Text;
                ltrRecPayment.Text = ltrSumPayment.Text;

                mvForm.SetActiveView(vwReceipt);
				Session.Remove("CreditCard");
				Session.Remove("PONumber");

				switch (DateTime.Now.DayOfYear % 8) {
					case 0: mvSurvey.SetActiveView(vw0); break;
					case 1: mvSurvey.SetActiveView(vw1); break;
					case 2: mvSurvey.SetActiveView(vw2); break;
					case 3: mvSurvey.SetActiveView(vw3); break;
					case 4: mvSurvey.SetActiveView(vw4); break;
					case 5: mvSurvey.SetActiveView(vw5); break;
					case 6: mvSurvey.SetActiveView(vw6); break;
					case 7: mvSurvey.SetActiveView(vw7); break;
				}
			}
        }
    }

    protected void lbReturnShoppingCart_Click(object sender, EventArgs e) {
        Page.Title = "SPEX CertiPrep - Shopping Cart";
        mvForm.SetActiveView(vwReview);
    }
    protected void lbReturnShoppingCart2_Click(object sender, EventArgs e) {
        Page.Title = "SPEX CertiPrep - Billing Information";
        mvForm.SetActiveView(vwBilling);
    }
    protected void lbReturnShoppingCart3_Click(object sender, EventArgs e) {
        Page.Title = "SPEX CertiPrep - Shipping Information";
        mvForm.SetActiveView(vwShipping);
    }
    protected void radioChangeItem(object sender, EventArgs e) {
		if (bill_method.SelectedItem.Value == "PONumber") {
			Session["PONumber"] = "Exists";
			Session.Remove("CreditCard");
			rfvbillPO.Enabled = true;
            rfvCardNumber.Enabled = false;
            rfvCardType.Enabled = false;
            rfvCVV.Enabled = false;
            rfvExpirationMonth.Enabled = false;
            rfvExpirationYear.Enabled = false;
			CardNumber.Text = "";
			CVV.Text = "";
		}else if (bill_method.SelectedItem.Value == "CreditCardNumber") {
			Session["CreditCard"] = "Exists";	
			Session.Remove("PONumber");
			rfvbillPO.Enabled = false;
            rfvCardNumber.Enabled = true;
            rfvCardType.Enabled = true;
            rfvCVV.Enabled = true;
            rfvExpirationMonth.Enabled = true;
            rfvExpirationYear.Enabled = true;
			billPO.Text = "";
		}
	}
   /* protected void billPO_TextChanged(object sender, EventArgs e) {
        if (billPO.Text.Trim().Length == 0) {
            if (CardNumber.Text.Trim().Length == 0) {
                rfvbillPO.Enabled = true;
            } else {
                rfvbillPO.Enabled = false;
            }
            rfvCardNumber.Enabled = true;
            rfvCardType.Enabled = true;
            rfvCVV.Enabled = true;
            rfvExpirationMonth.Enabled = true;
            rfvExpirationYear.Enabled = true;
        } else {
            rfvbillPO.Enabled = true;
            rfvCardNumber.Enabled = false;
            rfvCardType.Enabled = false;
            rfvCVV.Enabled = false;
            rfvExpirationMonth.Enabled = false;
            rfvExpirationYear.Enabled = false;
        }
    }
	
    protected void CardNumber_TextChanged(object sender, EventArgs e) {
        if (CardNumber.Text.Trim().Length == 0) {
            rfvbillPO.Enabled = true;
            if (billPO.Text.Trim().Length == 0) {
                rfvCardNumber.Enabled = true;
                rfvCardType.Enabled = true;
                rfvCVV.Enabled = true;
                rfvExpirationMonth.Enabled = true;
                rfvExpirationYear.Enabled = true;
            } else {
                rfvCardNumber.Enabled = false;
                rfvCardType.Enabled = false;
                rfvCVV.Enabled = false;
                rfvExpirationMonth.Enabled = false;
                rfvExpirationYear.Enabled = false;
            }
        } else {
            rfvbillPO.Enabled = false;
            rfvCardNumber.Enabled = true;
            rfvCardType.Enabled = true;
            rfvCVV.Enabled = true;
            rfvExpirationMonth.Enabled = true;
            rfvExpirationYear.Enabled = true;
        }
    }*/
    protected void chkSameAsBilling_CheckedChanged(object sender, EventArgs e) {
        if (chkSameAsBilling.Checked) {
            shipFirstname.Text = billFirstname.Text.Trim();
            shipLastname.Text = billLastname.Text.Trim();
            shipPhone.Text = billPhone.Text.Trim();
            shipFax.Text = billFax.Text.Trim();
			shipOrganization.Text = billOrganization.Text.Trim();
            shipAddress1.Text = billAddress1.Text.Trim();
            shipAddress2.Text = billAddress2.Text.Trim();
            shipCity.Text = billCity.Text.Trim();
            shipState.Text = billState.Text.Trim();
            shipZIP.Text = billZIP.Text.Trim();
        }
    }

	protected void cmdSubmitSurvey0_Click(object sender, EventArgs e) {
		if (A0.SelectedIndex > -1) {
			ProcessSubmitSurvey(1, Q0.Text, A0.SelectedValue, "");
		}
		mvSurvey.SetActiveView(vwThanks);
	}
	protected void cmdSubmitSurvey1_Click(object sender, EventArgs e) {
		if (A1.SelectedIndex > -1) {
			ProcessSubmitSurvey(2, Q1.Text, A1.SelectedValue, "");
		}
		mvSurvey.SetActiveView(vwThanks);
	}
	protected void cmdSubmitSurvey2_Click(object sender, EventArgs e) {
		if (A2.SelectedIndex > -1) {
			ProcessSubmitSurvey(3, Q2.Text, A2.SelectedValue, "");
		}
		mvSurvey.SetActiveView(vwThanks);
	}
	protected void cmdSubmitSurvey3_Click(object sender, EventArgs e) {
		if (A3.SelectedIndex > -1) {
			ProcessSubmitSurvey(4, Q3.Text, A3.SelectedValue, "");
		}
		mvSurvey.SetActiveView(vwThanks);
	}
	protected void cmdSubmitSurvey4_Click(object sender, EventArgs e) {
		string selectedItems = "";
		foreach (ListItem li in A4.Items) {
			if (li.Selected) {
				selectedItems += li.Text + " | ";
			}
		}
		if (selectedItems.Length > 0) {
			ProcessSubmitSurvey(5, Q4.Text, selectedItems, "");
		}
		mvSurvey.SetActiveView(vwThanks);
	}
	protected void cmdSubmitSurvey5_Click(object sender, EventArgs e) {
		if (A5.SelectedIndex > -1) {
			ProcessSubmitSurvey(6, Q5.Text, A5.SelectedValue, "");
		}
		mvSurvey.SetActiveView(vwThanks);
	}
	protected void cmdSubmitSurvey6_Click(object sender, EventArgs e) {
		if (A6.SelectedIndex > -1) {
			ProcessSubmitSurvey(7, Q6.Text, A6.SelectedValue, "");
		}
		mvSurvey.SetActiveView(vwThanks);
	}
	protected void cmdSubmitSurvey7_Click(object sender, EventArgs e) {
		string selectedItems = "";
		foreach (ListItem li in A7.Items) {
			if (li.Selected) {
				selectedItems += li.Text + " | ";
			}
		}
		if (selectedItems.Length > 0) {
			ProcessSubmitSurvey(8, Q7.Text, selectedItems, "");
		}
		mvSurvey.SetActiveView(vwThanks);
	}
	protected void ProcessSubmitSurvey(int QuestionNumber, string QuestionText, string QuestionAnswer, string QuestionComment) {
		clsUser myUser = new clsUser();
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "INSERT INTO [certiPostOrderSurvey] " +
						"	   ([customer_id], " +
						"	   [OrderID], " +
						"	   [QuestionNumber], " +
						"	   [QuestionText], " +
						"	   [QuestionAnswer], " +
						"	   [QuestionComment] " +
						"	) VALUES ( " +
						"	   @customer_id, " +
						"	   @OrderID, " +
						"	   @QuestionNumber, " +
						"	   @QuestionText, " +
						"	   @QuestionAnswer, " +
						"	   @QuestionComment " +
						"	)";

			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@customer_id", SqlDbType.VarChar, 20).Value = myUser.UserID;
				cmd.Parameters.Add("@OrderID", SqlDbType.Int).Value = Convert.ToInt32(ltrOrderNumber.Text.Substring(1));
				cmd.Parameters.Add("@QuestionNumber", SqlDbType.Int).Value = QuestionNumber;
				cmd.Parameters.Add("@QuestionText", SqlDbType.VarChar).Value = QuestionText;
				cmd.Parameters.Add("@QuestionAnswer", SqlDbType.VarChar).Value = QuestionAnswer;
				cmd.Parameters.Add("@QuestionComment", SqlDbType.VarChar).Value = QuestionComment;

				cmd.Connection.Open();
				cmd.ExecuteNonQuery();
				cmd.Connection.Close();
			}
		}
		
		StringBuilder sb = new StringBuilder();
		sb.AppendLine("<html><body>");
		sb.AppendLine("<div style='padding:30px 25px; border: 1px solid #b9b9b9;width:525px;'><a href='http://www.spexcertiprep.com/'><img src='http://www.spexcertiprep.com/images/certiprep_logo_new.png' alt='SPEX CertiPrep'></a>");
		sb.AppendLine("<table border='0'>");
        sb.AppendLine("<tr><td style='width:135px;padding:10px'>Customer ID:</td><td style='font-weight:bold;padding:10px'>" + myUser.UserID + "</td></tr>");
        sb.AppendLine("<tr><td style='padding:10px'>Name:</td><td style='font-weight:bold;padding:10px'>" + myUser.FirstName + " " + myUser.LastName + "</td></tr>");
        sb.AppendLine("<tr><td style='padding:10px'>Question:</td><td style='font-weight:bold;padding:10px'>" + QuestionText + "</td></tr>");
        sb.AppendLine("<tr><td style='padding:10px'>Answer:</td><td style='font-weight:bold;padding:10px'>" + QuestionAnswer + "</td></tr>");
        sb.AppendLine("<tr><td style='padding:10px'>Comment:</td><td style='font-weight:bold;padding:10px'>" + QuestionComment + "</td></tr>");
		sb.AppendLine("</table></div>");
        sb.AppendLine("</body></html>");
        string strBody = sb.ToString();

        MailMessage mm = new MailMessage();
        mm.Subject = "Post Order Survey | SPEX CertiPrep";
		mm.To.Add(new MailAddress("hchitalia@spexcsp.com"));
        mm.To.Add(new MailAddress("aevans@spex.com"));
		mm.Bcc.Add(new MailAddress("spexcertiprepmarcom@gmail.com"));
		mm.From = new MailAddress("contact@spexcsp.com", "SPEX CertiPrep Contact");
        mm.BodyEncoding = System.Text.Encoding.GetEncoding("utf-8");
		
        AlternateView plainView = AlternateView.CreateAlternateViewFromString(Regex.Replace(strBody, @"<(.|\n)*?>", string.Empty), System.Text.Encoding.GetEncoding("utf-8"), "text/plain");
        AlternateView htmlView = AlternateView.CreateAlternateViewFromString(strBody, System.Text.Encoding.GetEncoding("utf-8"), "text/html");
        mm.AlternateViews.Add(plainView);
        mm.AlternateViews.Add(htmlView);

        SmtpClient smtp = new SmtpClient();
        smtp.Send(mm);
	}
}