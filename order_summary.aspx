<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="order_summary.aspx.cs" Inherits="order_summary" debug="true"%>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <link rel="stylesheet" href="/css/screen/shoppingcart_nav.css" type="text/css" />
	<style type="text/css">
		#postsurvey table, #postsurvey table td { border: 0 none; }
		#cmdSubmitSurvey { border: 4px solid #a6a6a6;background:#ececed; border-radius: 5px; }
		.float-footer {display:none;}
		#fancybox-close {
			top: 4px !important;
			right: 4px !important;
		}
		#breadcrumb { z-index: -1}
	</style>
	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
<asp:MultiView ID="mvForm" runat="server" ActiveViewIndex="0">
    <asp:View ID="vwReview" runat="server">
		<div class="chat_status"></div>
		<div id="res"></div>
        <div id="shoppingcart_nav" class="floatbox"> 
	        <ul id="angle" style="width: 100%;">
		        <li class="selected"><b class="p5"></b><em>Review Your Order</em><b class="p6"></b></li>
		        <li><b class="p5"></b><em>Billing Information</em><b class="p6"></b></li>
		        <li><b class="p5"></b><em>Shipping Information</em><b class="p6"></b></li>
		        <li><b class="p5"></b><em>Order Summary</em><b class="p6"></b></li>
		        <li><b class="p5"></b><em>Receipt</em><b class="p6"></b></li>
	        </ul>
			<ul id="m_angle">
				<li class="selected"><b class="p5"></b><em>Review Your Order</em><b class="p6"></b></li>
		        <li><b class="p5"></b><em>Step 1 of 5</em><b class="p6"></b></li>
			</ul>
			<a class="pageBack" style="cursor:pointer">
				<img class="cartBack" src="/images/cartback.png" alt="Back" title="Back" />
				<img class="mcartBack" src="/images/mcartback.png" alt="Back" title="Back" />
			</a>
			<a class="pageCheckOut" style="cursor:pointer">
				<img class="cartCheck" src="/images/cartcheck.png" alt="Check Out" title="Check Out" />
				<img class="mcartCheck" src="/images/mcartcheck.png" alt="Check Out" title="Check Out" />
			</a>
        </div>
        <div id="main" style="margin-bottom:50px">
            <h3 class="review_label" style="clear:both;"></h3>
            <div id="resultstable">
				<div class="itemContainer">
					<div id="removedBox">Item removed!</div>
					<div id="addBox">New item added!</div>
					<div class="loadingBox"><div class="gear"></div></div>
					<div class="itemTableContainer">
						<%=orderItems%>	
						<%=orderItemsMobile%>	
					</div>
				</div>
				
				<div class="secure"><img src="/images/secure.png" alt="Secure Network" /></div>
				<strong>Add An Item:</strong>
                <div id="checkOutBox" class="subcolumns">
                    <div class="c50l">
                        <div class="subcl">
						<table class="price_table" align="left">
							<tr>
								<td>
									<asp:Panel ID="pnlAddItem" runat="server" DefaultButton="cmdAddPart">
										<label id="partNum">Part #: </label><asp:TextBox ID="review_partsearch" CssClass="review_formfield" ClientIDMode="Static" runat="server" autocomplete="off" />
										<asp:Button ID="cmdAddPart" Text="" CssClass="review_button" style="display:none;" runat="server" onclick="cmdAddPart_Click" />
										<input type="button" value="" id="addPartNum" class="review_button" onclick="addItem()" />
									</asp:Panel>
								</td>
							</tr>
							<tr style="border:none">
								<td style="padding-bottom:0; line-height: 18px;">
									Received a quote from us?<br />
									Enter the Quote Number below and you will receive an email<br /> 
									for your pricing.
								</td>
							<tr>
							<tr style="border:none">
								<td><label id="salesQ">Sales Quote Number: </label><asp:TextBox ID="sales_quote" CssClass="review_formfield" runat="server" /></td>
							</tr>
                            <div id="error_additem"></div>
						</table>
							<asp:Panel ID="pnlPromotion" runat="server">
                                    <img src="/images/promo_icon.png" style="float:left; margin-right:5px;" alt="Promo" />
                                    <p class="promotion_headline">Promotional Code is applicable to this item.</p>
                            </asp:Panel>
                            <asp:Panel ID="pnlHazardous" runat="server">
                                    <img src="images/hazardous_large.gif" style="float:left; margin-right:5px;" alt="Hazardous" />
                                    <p class="hazardous_headline">This item has been deemed as hazardous.</p>
                                    <p>Additional Hazardous shipping fees may apply.</p>
                            </asp:Panel>
                            <asp:Panel ID="pnlRefrigerator" runat="server">
                	            <img src="images/hazardous_large.gif" style="float:left; margin-right:5px;" alt="Hazardous" />
                                <!--CHANGE icon size-->
                                <!--<p class="hazardous_headline" style="padding-top:5px">Refrigerator Message: This item needs to be refrigerated immediately upon arrival.</p>-->
                                <p class="hazardous_headline" style="">Refrigerator Message: This item needs to be refrigerated immediately upon arrival.</p>
                            </asp:Panel>
                            <asp:Panel ID="pnlFreezer" runat="server">
                	            <img src="images/hazardous_large.gif" style="float:left; margin-right:5px;" alt="Hazardous" />
                                <!--CHANGE icon size-->
                                <!--<p class="hazardous_headline" style="padding-top:12px">Freezer Message: This item must be stored in a freezer to ensure stability..</p>-->
                                <p class="hazardous_headline" style="">Freezer Message: This item must be stored in a freezer to ensure stability..</p>
                            </asp:Panel>
                        </div>
                    </div>
                    <div class="c50r">
                        <div class="subcr">                      
                            <table class="price_table" align="right">
                                <tr>
                                    <td class="desc">Subtotal:</td>
                                    <td class="price"><strong><span class="ltrSubtotal"><asp:Literal ID="ltrSubtotal" runat="server" /></span></strong></td>
                                </tr>
								<tr>
									<td colspan="2">
										<asp:Panel ID="pnlPromo" DefaultButton="promo_add" runat="server">
											<asp:Label ID="lblreview_promocode" AssociatedControlID="review_promocode" Text="Promotion code:" runat="server" />
											<asp:TextBox ID="review_promocode" ClientIDMode="Static" CssClass="review_formfield" runat="server" autocomplete="off" /><asp:Button ID="promo_add" ClientIDMode="Static" Text="" CssClass="review_button" runat="server" onclick="cmdPromo_Click" />
											<div id="error_promo_quote"></div>
											<asp:Label ID="lblPromoNotValid" Text="This promotional code is not valid." Visible="false" runat="server" EnableViewState="true" />
										</asp:Panel>
									</td>
								</tr>
                                <tr>
                                    <td class="desc total">Total Savings:</td>
                                    <td class="price total"><strong><span class="ltrSavings"><asp:Literal ID="ltrSavings" runat="server" /></span></strong></td>
                                </tr>              
                                <tr style="display:none">
                                    <td class="desc"><a href="#modal_spoints" class="inlinedialog" style="font-weight:bold">SPoints</a> Earned:</td>
                                    <td class="price"><strong><span class="ltrSPoints"><asp:Literal ID="ltrSPoints" runat="server" /></span></strong></td>
                                </tr>              
                                <tr>
                                    <td class="desc">Sales Tax:</td>
                                    <td class="price"><strong><span class="ltrTax"><asp:Literal ID="ltrTax" runat="server" /></span></strong></td>
                                </tr>
                                <tr>
                                    <td class="desc">Shipping Method:</td>
                                    <td class="price">
                                        <asp:DropDownList ID="shipmethod" runat="server">
                                            <asp:ListItem Value="UPS_Ground" Text="UPS Ground" />
                                            <asp:ListItem Value="UPS_2nd_Day" Text="UPS 2nd Day" />
                                            <asp:ListItem Value="UPS_Next_Day_Air" Text="UPS Next Day Air" />
                                            <asp:ListItem Value="FedEx_Ground" Text="FedEx - Ground" />
                                            <asp:ListItem Value="FedEx_2Day" Text="FedEx - 2 Day" />
                                            <asp:ListItem Value="FedEx_NextDay" Text="FedEx - Next Day" />
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr style="border-bottom:0">
                                    <td colspan="2" class="desc">Payment Method</td>
                                </tr>
                                <tr style="border-bottom:0">
                                    <td colspan="2">
                                        <input id="ShipPayment1" type="radio" name="ShipPayment" value="Inv" checked="checked" />
										<label for="ShipPayment1" style="font-weight:normal;">Shipping and hazmat fees prepaid & added to invoice</label>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<input id="ShipPayment2" type="radio" name="ShipPayment" value="Acct" />
										<label for="ShipPayment2" style="font-weight:normal;">Charge shipping and hazmat fees to account #:</label>
									</td>                                        
                                </tr>
                         
                                </tr>
                                <tr id="rowCarrierAcct" style="display:none;">
                                    <td class="desc">Carrier Account #:</td>
                                    <td class="price"><asp:TextBox ID="ShipAccountNo" runat="server" CssClass="review_formfield" style="width: 125px;" /> </td>
                                </tr>
                                <tr>
                                    <td class="desc">Shipping:</td>
                                    <td style="text-align:right;"><a href="#modal_shipping" class="inlinedialog" style="font-weight:bold">(POLICY)</a></td>
                                </tr>
                                <tr>
                                    <td class="desc"><div style="font-size:16px;">Final Total:</div>(Shipping not included) </td>
                                    <td class="price"><span class="ltrTotal"><asp:Literal ID="ltrTotal" runat="server" /></span></td>
                                </tr>
								<tr>
									<td colspan="2">
										<asp:CheckBox ID="shippartial" Checked="true" Text="&nbsp;&nbsp;If all items are not in stock ship partial order" runat="server" />
									</td>
								</tr>
                                <tr style="border-bottom:0">
                                    <td colspan="2" class="alignright">
                                        <asp:MultiView ID="mvAction" runat="server" ActiveViewIndex="0">
                                            <asp:View ID="vwLogin" runat="server">
                        	                    <img src="images/hazardous_large.gif" alt=""/>
                                                <asp:Button ID="cmdLogin" runat="server" Text="" CssClass="submitbutton" style="margin-top: 10px;" onclick="cmdLogin_Click" />
											</asp:View>
                                            <asp:View ID="vwEmpty" runat="server">
                                                <asp:Button ID="cmdEmpty" Text="CHECKOUT" runat="server" CssClass="submitbutton" OnClientClick="alert('You have no items in your shopping cart.');return false;" />
											</asp:View>
                                            <asp:View ID="vwSubmit" runat="server">
                                                <asp:Button ID="cmdSubmit" Text="" runat="server" CssClass="submitbutton" onclick="cmdSubmit_Click" />
											</asp:View>
                                        </asp:MultiView>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
	    </div>

        <div style="display:none">
            <div id="modal_shipping">
	            <h3 style="color:#a3b405">Shipping Policy</h3>
                <p>SPEX CertiPrep will Pre-Pay and Add all shipping charges. If you have no preference in shipping method SPEX CertiPrep will default to UPS ground shipping. If you would like us to apply shipping charges to a specific <span style="color:#d9534f">UPS or FedEx Collect</span> Account please include your collect account number in the provided box.</p>
            </div>
            <div id="modal_spoints">
	            <h3>Spoints</h3>
                <p>This is your total accumulated Spoints earned for your current order. If you would like to see your Overall Spoints total, please log in and visit our Customer Center. For further information on SPEX CertiPrep’s Spoints Rewards Program please click on Spoint Rewards in the Purchasing Options Tab.</p>
            </div>
        </div>
    </asp:View>

    <asp:View ID="vwBilling" runat="server">
        <div id="shoppingcart_nav" class="floatbox"> 
	        <ul id="angle" style="width: 100%;">
		        <li><b class="p5"></b><em>Review Your Order</em><b class="p6"></b></li>
		        <li class="selected"><b class="p5"></b><em>Billing Information</em><b class="p6"></b></li>
		        <li><b class="p5"></b><em>Shipping Information</em><b class="p6"></b></li>
		        <li></b><b class="p5"></b><em>Order Summary</em><b class="p6"></b></li>
		        <li><b class="p5"></b><em>Receipt</em><b class="p6"></b></li>
	        </ul>
			<ul id="m_angle">
				<li class="selected"><b class="p5"></b><em>Billing Information</em><b class="p6"></b></li>
		        <li><b class="p5"></b><em>Step 2 of 5</em><b class="p6"></b></li>
			</ul>
			<a class="pageBack" style="cursor:pointer">
				<img class="cartBack" src="/images/cartback.png" alt="Back" title="Back" />
				<img class="mcartBack" src="/images/mcartback.png" alt="Back" title="Back" />
			</a>
			<a class="pageCheckOut" style="cursor:pointer">
				<img class="cartCheck" src="/images/cartcheck.png" alt="Check Out" title="Check Out" />
				<img class="mcartCheck" src="/images/mcartcheck.png" alt="Check Out" title="Check Out" />
			</a>
        </div>
        <div id="main" style="margin-bottom:50px">
            <div id="backlink_bar2" style="display:none"><asp:LinkButton ID="lbReturnShoppingCart" Text="&lt; Return to Shopping Cart" runat="server" onclick="lbReturnShoppingCart_Click" /></div>
            <div id="shopping_cart_form" class="floatbox">
                <div id="billing_details" class="yform">
                    <div id="billing_details_header">
                        <h3>Customer Billing Details:</h3>
                        <span class="small_text" style="float:right;line-height: 18px;">All Fields Are Required Unless Noted</span>
                    </div>
                    <div class="subcolumns">
                        <div class="c50l">
                            <div class="subcl">
                                <div class="type-text">
                                    <asp:TextBox ID="billFirstname" placeholder="First Name" runat="server" Width="250px" />
                                    <asp:RequiredFieldValidator ID="rfvbillFirstname" ControlToValidate="billFirstname" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required." ValidationGroup="vgBill" />
                                </div>
                                <div class="type-text">
                                    <asp:TextBox ID="billLastname" placeholder="Last Name" runat="server" Width="250px" />
                                    <asp:RequiredFieldValidator ID="rfvbillLastname" ControlToValidate="billLastname" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required." ValidationGroup="vgBill" />
                                </div>
                                <div class="type-text">
                                    <asp:TextBox ID="billOrganization" placeholder="Organization" runat="server" Width="250px" />
                                    <asp:RequiredFieldValidator ID="rfvbillOrganization" ControlToValidate="billOrganization" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required." ValidationGroup="vgBill" />
                                </div>
                                <div class="type-text">
                                    <asp:TextBox ID="billPhone" placeholder="Phone Number" runat="server" Width="250px" />
                                </div>
                                <div class="type-text">
                                    <asp:TextBox ID="billFax" placeholder="Fax" runat="server" Width="250px" />
                                </div>
                            </div>
                        </div>
                        <div class="c50r">
                            <div class="subcr">
                                <div class="type-text">
                                    <asp:TextBox ID="billAddress1" placeholder="Billing Address 1" runat="server" Width="250px" />
                                    <asp:RequiredFieldValidator ID="rfvbillAddress1" ControlToValidate="billAddress1" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required." ValidationGroup="vgBill" />
                                </div>
                                <div class="type-text">
                                    <asp:TextBox ID="billAddress2" placeholder="Billing Address 2" runat="server" Width="250px" />
                                </div>
                                <div class="type-text">
                                    <asp:TextBox ID="billCity" placeholder="City" runat="server" Width="250px" />
                                    <asp:RequiredFieldValidator ID="rfvbillCity" ControlToValidate="billCity" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required." ValidationGroup="vgBill" />
                                </div>
                                <div class="subcolumns">
                                    <div class="c50l">
                                        <div class="subcl">
                                            <div class="type-text">
												<asp:TextBox ID="billState" placeholder="State/Territory" runat="server" MaxLength="3" Width="100px" />
                                                <asp:RequiredFieldValidator ID="rfvbillState" ControlToValidate="billState" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required." ValidationGroup="vgBill" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="c50r">
                                        <div class="subcr">
                                            <div class="type-text">
                                                <asp:TextBox ID="billZIP" placeholder="ZIP Code" runat="server" Width="100px" />
                                                <asp:RequiredFieldValidator ID="rfvbillZIP" ControlToValidate="billZIP" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required." ValidationGroup="vgBill" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="creditcard_info" class="yform">
					<div class="choiceRadio" runat="server">
						<h3>Choose Billing Method</h3>		
						<asp:RadioButtonList ID="bill_method" OnSelectedIndexChanged="radioChangeItem" AutoPostBack="true" runat="server">
							<asp:ListItem id="poNum" value="PONumber" text="PO Number"></asp:ListItem>
							<asp:ListItem id="creditCard" value="CreditCardNumber" text="Credit Card Number"></asp:ListItem>
						</asp:RadioButtonList>
						
						<asp:RequiredFieldValidator ID="bill_methodG" ControlToValidate="bill_method" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Select Billing Method." ValidationGroup="vgBill" />
					</div>
					<div id="POInfo" class="POInfo" style="display:none;" runat="server">
						<h3>PO Number:</h3>
						<div class="type-text">
							<asp:TextBox ID="billPO" placeholder="PO Number" runat="server" Width="250px" AutoPostBack="true" />
							<asp:RequiredFieldValidator ID="rfvbillPO" ControlToValidate="billPO" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Required if not paying by credit card." ValidationGroup="vgBill" />
						</div>
					</div>
					<div id="creditInfo" class="creditInfo" runat="server" style="display:none;">
					<h3>Credit Card Information:</h3>
                    <div class="type-select">
                        <asp:DropDownList ID="CardType" runat="server" Width="150px">
                            <asp:ListItem Text="Card Type" Value="0" disabled selected style="display:none;" />
                            <asp:ListItem Text="VISA" Value="visa" />
                            <asp:ListItem Text="AMERICAN EXPRESS" Value="american_express" />
                            <asp:ListItem Text="MASTERCARD" Value="master_card" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvCardType" ControlToValidate="CardType" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required." ValidationGroup="vgBill" />
                    </div>
                    <div class="type-text">
                        <asp:TextBox ID="CardNumber" runat="server" Width="250px" MaxLength="20" AutoPostBack="true" placeholder="Card Number" />
                        <asp:RequiredFieldValidator ID="rfvCardNumber" ControlToValidate="CardNumber" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Required if not paying with a PO Number." ValidationGroup="vgBill" />
                        <asp:RegularExpressionValidator ID="valCardNumber" runat="server" CssClass="formerror" ControlToValidate="CardNumber" ErrorMessage="Invalid length!" ValidationExpression=".{13}.*"  ValidationGroup="vgBill"/>
                        <asp:CompareValidator ID="cv" runat="server" ControlToValidate="CardNumber" CssClass="formerror" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Must be numeric!" ValidationGroup="vgBill" />
                    </div>
                    <div class="subcolumns">
                        <div class="c66l">
                            <div class="subcl">
                                <div class="type-select">
                                    <asp:DropDownList ID="ExpirationMonth" runat="server" Width="150px">
                                        <asp:ListItem Value="0" Text="Expiration Month" disabled selected style="display:none;" />
                                        <asp:ListItem Value="01" Text="January" />
                                        <asp:ListItem Value="02" Text="February" />
                                        <asp:ListItem Value="03" Text="March" />
                                        <asp:ListItem Value="04" Text="April" />
                                        <asp:ListItem Value="05" Text="May" />
                                        <asp:ListItem Value="06" Text="June" />
                                        <asp:ListItem Value="07" Text="July" />
                                        <asp:ListItem Value="08" Text="August" />
                                        <asp:ListItem Value="09" Text="September" />
                                        <asp:ListItem Value="10" Text="October" />
                                        <asp:ListItem Value="11" Text="November" />
                                        <asp:ListItem Value="12" Text="December" />
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvExpirationMonth" ControlToValidate="ExpirationMonth" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required." ValidationGroup="vgBill" />
                                </div>
                            </div>
                        </div>
                        <div class="c66l">
                            <div class="subcl">
                                <div class="type-select">
                                    <asp:DropDownList ID="ExpirationYear" runat="server" AppendDataBoundItems="true">
                                        <asp:ListItem Value="0" Text="Expiration Year" disabled selected style="display:none;" />
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvExpirationYear" ControlToValidate="ExpirationYear" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required." ValidationGroup="vgBill" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="type-text">
                        <div class="small_text" style="float: right;margin-top: 20px;"><a href="#modal_cvv" class="inlinedialog">What's This?</a></div>
                        <asp:TextBox ID="CVV" placeholder="CVV" runat="server" Width="150px" MaxLength="4" />
                        <asp:RequiredFieldValidator ID="rfvCVV" ControlToValidate="CVV" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required." ValidationGroup="vgBill" />
                        <asp:RegularExpressionValidator ID="valCVV" runat="server" CssClass="formerror" ControlToValidate="CVV" ErrorMessage="Invalid length!" ValidationExpression=".{3}.*"  ValidationGroup="vgBill"/>
                        <asp:CompareValidator ID="cvCVV" runat="server" ControlToValidate="CVV" CssClass="formerror" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Must be numeric!" ValidationGroup="vgBill" />
                    </div>
                    <p style="padding-top:10px;font-size:10px">Your card will not be charged until we furnish you with a final shipping estimate and you approve the total cost.<br />
                        <a href="#modal_protection" class="inlinedialog">How we protect your personal information.</a></p>
					</div>
                    <div class="type-button">
                        <asp:Button ID="cmdBilling" Text="" runat="server" CssClass="submitbutton" onclick="cmdBilling_Click" ValidationGroup="vgBill" />
                    </div>
                </div>
            </div>

        </div>
        
        <div style="display:none">
            <div id="modal_cvv">
	            <h3>CVV Number</h3>
	            <p>A credit card verification number is an added safeguard for your credit card purchases. Depending on the type of credit card you use, it is the 3- or 4-digit number printed on the back or front of your credit card.</p>
                <p>For American Express,  your identification number is the 4-digit number found on the far right on the front of your credit card. For Visa or MasterCard, your identification number is the 3-digit number found on the back of your credit card near the signature panel.</p>
            </div>
            <div id="modal_protection">
	            <h3>How We Protect Your Information</h3>
	            <p>Your payment and personal information is always safe. Our Secure Sockets Layer (SSL) protocol is the industry standard and among the best available today for secure commerce transactions. It encrypts all of your personal information, including credit card number, name and address, so that it cannot be read over the Internet.</p>
            </div>
        </div>

    </asp:View>

    <asp:View ID="vwShipping" runat="server">
        <div id="shoppingcart_nav" class="floatbox"> 
	        <ul id="angle" style="width: 100%;">
                <li><b class="p5"></b><em>Review Your Order</em><b class="p6"></b></li>
                <li><b class="p5"></b><em>Billing Information</em><b class="p6"></b></li>
                <li class="selected"><b class="p5"></b><em>Shipping Information</em><b class="p6"></b></li>
                <li><b class="p5"></b><em>Order Summary</em><b class="p6"></b></li>
                <li><b class="p5"></b><em>Receipt</em><b class="p6"></b></li>
	        </ul>
			<ul id="m_angle">
				<li class="selected"><b class="p5"></b><em>Shipping Information</em><b class="p6"></b></li>
		        <li><b class="p5"></b><em>Step 3 of 5</em><b class="p6"></b></li>
			</ul>
			<a class="pageBack" style="cursor:pointer">
				<img class="cartBack" src="/images/cartback.png" alt="Back" title="Back" />
				<img class="mcartBack" src="/images/mcartback.png" alt="Back" title="Back" />
			</a>
			<a class="pageCheckOut" style="cursor:pointer">
				<img class="cartCheck" src="/images/cartcheck.png" alt="Check Out" title="Check Out" />
				<img class="mcartCheck" src="/images/mcartcheck.png" alt="Check Out" title="Check Out" />
			</a>
        </div>
        <div id="main" style="margin-bottom:50px">
            <div id="backlink_bar2" style="display:none"><asp:LinkButton ID="lbReturnShoppingCart2" Text="&lt; Return to Billing" runat="server" onclick="lbReturnShoppingCart2_Click" /></div>
            <div id="shopping_cart_form" class="floatbox">
                <div id="shipping_details">
                    <div id="billing_details_header">
                        <h3>Shipping Address:</h3>
                        <span class="small_text" style="float:right;line-height: 18px;">All Fields Are Required Unless Noted</span>
                    </div>

                    <div class="yform" style="margin-bottom:0;padding:0;border:0;">
                    <asp:ListView ID="lvShippingAddresses" DataSourceID="dataShippingAddresses"  runat="server">
                        <LayoutTemplate>
                            <div id="existingaddresses_box">
                                <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
                            </div><br />
                            <h5 style="font-size:14px;font-weight:bold;">Or provide a new address:</h5>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <div class="shipaddress">
                                <%# Eval("Address_1")%><br />
                                <%# Eval("Address_2").ToString().Length > 0 ? Eval("Address_2") + "<br />" : ""%>
                                <%# Eval("City")%><br />
                                <%# Eval("State")%> <%# Eval("Zip")%>
                                <div class="type-button" style="text-align:left">
                                    <asp:Button ID="cmdShipAddress" Text="Ship to this address" runat="server" CssClass="submit" onclick="cmdShipAddress_Click" CommandArgument='<%# Eval("RecordID")%>' />
                                </div>
            
            	                <div class="shipaddress_select"></div>
                            </div>
                        </ItemTemplate>
                    </asp:ListView> 
                    </div>

                    <div id="addressblock" class="yform" style="width:100%;">
                        <div class="subcolumns">
                            <div class="c50l">
                                <div class="subcl">
                                    <div class="type-check">
                                        <asp:CheckBox ID="chkSameAsBilling" runat="server" AutoPostBack="true" Text=" Same as Billing Information" oncheckedchanged="chkSameAsBilling_CheckedChanged" />
                                    </div>
                                    <div class="type-text">
                                        <asp:TextBox ID="shipFirstname" placeholder=" First Name" runat="server" Width="250px" />
                                        <asp:RequiredFieldValidator ID="rfvshipFirstname" ControlToValidate="shipFirstname" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required." ValidationGroup="vgShip" />
                                    </div>
                                    <div class="type-text">
                                        <asp:TextBox ID="shipLastname" placeholder="Last Name" runat="server" Width="250px" />
                                        <asp:RequiredFieldValidator ID="rfvshipLastname" ControlToValidate="shipLastname" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required." ValidationGroup="vgShip" />
                                    </div>
                                    <div class="type-text">
                                        <asp:TextBox ID="shipPhone" placeholder="Phone Number" runat="server" Width="250px" />
                                        <asp:RequiredFieldValidator ID="rfvshipPhone" ControlToValidate="shipPhone" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required." ValidationGroup="vgShip" />
                                    </div>
                                    <div class="type-text">
                                        <asp:TextBox ID="shipFax" placeholder="Fax" runat="server" Width="250px" />
                                    </div>
                                </div>
                            </div>
                            <div class="c50r">
                                <div class="subcr">
                                    <div class="type-check">
                                        <asp:CheckBox ID="chkResidential" runat="server" Text=" This is a residential address" />
                                    </div>
									<div class="type-text">
										<asp:TextBox ID="shipOrganization" placeholder="Organization" runat="server" Width="250px" />
									</div>
                                    <div class="type-text">
                                        <asp:TextBox ID="shipAddress1" placeholder="Shipping Address 1" runat="server" Width="250px" />
                                        <asp:RequiredFieldValidator ID="rfvshipAddress1" ControlToValidate="shipAddress1" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required." ValidationGroup="vgShip" />
                                    </div>
                                    <div class="type-text">
                                        <asp:TextBox ID="shipAddress2" placeholder="Shipping Address 2" runat="server" Width="250px" />
                                    </div>
                                    <div class="type-text">
                                        <asp:TextBox ID="shipCity" placeholder="City" runat="server" Width="250px" />
                                        <asp:RequiredFieldValidator ID="rfvshipCity" ControlToValidate="shipCity" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required." ValidationGroup="vgShip" />
                                    </div>
                                    <div class="subcolumns">
                                        <div class="c50l">
                                            <div class="subcl">
                                                <div class="type-text">
													<asp:TextBox ID="shipState" placeholder="State/Territory" runat="server" Width="100px" MaxLength="3" />
                                                    <asp:RequiredFieldValidator ID="rfvshipState" ControlToValidate="shipState" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required." ValidationGroup="vgShip" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="c50r">
                                            <div class="subcr">
                                                <div class="type-text">
                                                    <asp:TextBox ID="shipZIP" placeholder="ZIP Code" runat="server" Width="100px" />
                                                    <asp:RequiredFieldValidator ID="rfvshipZIP" ControlToValidate="shipZIP" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required." ValidationGroup="vgShip" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                        </div> 
                        <div class="type-button">
                            <asp:Button ID="cmdShipping" Text="" runat="server" CssClass="submitbutton" onclick="cmdShipping_Click" ValidationGroup="vgShip" />
                        </div>
                    </div> 
                </div>

                <div id="shipping_info" class="yform">
       	            <h3>Important Shipping Information:</h3>
                    <ul>
                        <li>Products cannot be shipped to a PO Box.</li>
                        <li>Materials classified as HazMat or that require refrigeration have additional shipping restrictions outlined in our shipping policy.</li>
                    </ul>
                    <span style="margin-left: 20px;"><a href="#shippingwindow" class="inlinedialog">Our Shipping Policy</a></span>  
                </div>
            </div>
        </div>

        <div style="display:none">
            <div id="shippingwindow">
                <h3>Shipping Information</h3>
                <p>SPEX CertiPrep will Pre-Pay and Add all shipping charges. If you have no preference in shipping method SPEX CertiPrep will default to UPS ground shipping. If you would like us to apply shipping charges to a specific UPS Collect Account please include your collect account number in the provided box.</p>
            </div>
        </div>

    </asp:View>

    <asp:View ID="vwSummary" runat="server">
        <div id="shoppingcart_nav" class="floatbox"> 
	        <ul id="angle" style="width: 100%;">
		        <li><b class="p5"></b><em>Review Your Order</em><b class="p6"></b></li>
		        <li><b class="p5"></b><em>Billing Information</em><b class="p6"></b></li>
		        <li><b class="p5"></b><em>Shipping Information</em><b class="p6"></b></li>
		        <li class="selected"><b class="p5"></b><em>Order Summary</em><b class="p6"></b></li>
		        <li><b class="p5"></b><em>Receipt</em><b class="p6"></b></li>
	        </ul>
			<ul id="m_angle">
				<li class="selected"><b class="p5"></b><em>Order Summary</em><b class="p6"></b></li>
		        <li><b class="p5"></b><em>Step 4 of 5</em><b class="p6"></b></li>
			</ul>
			<a class="pageBack" style="cursor:pointer">
				<img class="cartBack" src="/images/cartback.png" alt="Back" title="Back" />
				<img class="mcartBack" src="/images/mcartback.png" alt="Back" title="Back" />
			</a>
			<a class="pageCheckOut" style="cursor:pointer">
				<img class="cartCheck" src="/images/cartcheck.png" alt="Check Out" title="Check Out" />
				<img class="mcartCheck" src="/images/mcartcheck.png" alt="Check Out" title="Check Out" />
			</a>
        </div>
        <div id="main" style="margin-bottom:50px">
            <div id="backlink_bar2" style="display:none"><asp:LinkButton ID="lbReturnShoppingCart3" Text="&lt; Return to Shipping" runat="server" onclick="lbReturnShoppingCart3_Click" /></div>
        	<div class="floatbox">
                <asp:Panel ID="pnlSummaryErrorbox" CssClass="errorbox" runat="server" Visible="false" EnableViewState="false">
                    <asp:Literal ID="ltrSummaryErrorMessage" runat="server" />
                </asp:Panel>
                <div class="subcolumns">
                    <div class="c33l">
                        <div class="subcl">
           		            <h3 style="color:#94A232;font-size:14px;">Please Review Your Order</h3>
           		            <p>When you are ready,<br />
                                click the “Complete Order” button<br />
                                to submit your order.</p>
                        </div>
                    </div>
                    <div class="c66r">
                        <div class="subcr">
                            <div class="subcolumns">
                                <div class="c33l">
                                    <div class="subcl">
					                    <strong>Bill To</strong><br />
                                        <asp:Literal ID="ltrSumBillTo" runat="server" />
                                    </div>
                                </div>
                                <div class="c33l">
                                    <div class="subcl">
        		                        <strong>Ship To:</strong><br />
                                        <asp:Literal ID="ltrSumShipTo" runat="server" />
                                    </div>
                                </div>
                                <div class="c33r">
                                    <div class="subcr">
        		                        <strong>Payment:</strong><br />
                                        <asp:Literal ID="ltrSumPayment" runat="server" /><br /><br />
        		                        <strong>Account #:</strong><br />
                                        <asp:Literal ID="ltrSumAccount" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </div>
        		    </div>
      		    </div>
            </div>

            <div id="resultstable">
               <table id="summary_table" align="center" style="width:100%">
                    <thead>
                        <tr>
                            <th scope="col"></th>
                            <th scope="col">Item Description</th>
                            <th scope="col">Volume</th>
                            <th scope="col">Hazardous</th>
                            <th scope="col">Storage</th>
                            <th scope="col">Quantity</th>
                            <th scope="col" class="price" style="text-align:right">Price</th>
                            <th scope="col" class="price" style="text-align:right">Total</th>
                        </tr>
                    </thead>
                    <tbody>
<% foreach (ShoppingCartItem si in ItemList) { %>
                        <tr>
                            <td><img src="images/<%=si.Thumbnail%>" width="37" height="37" alt="Thumbnail" /></td>
                            <td class="desc">Part #: <%= si.PartNumber %><br /><input type='hidden' class='hiddenPart' value='<%= si.PartNumber %>' /><span class="greensmall"><%= si.ProdTitle %></span></td>
                            <td><%= si.Volume %></td>
                            <td><img src='/images/<%= si.ShippingIcon %>' width="19" height="17" alt='<%= si.Hazardous %>' class="smallicon" align="absmiddle" /><%= si.Hazardous %></td>
                            <td><img src='/images/<%= si.StorageIcon %>' width="19" height="17" alt='<%= si.Storage %>' class="smallicon" align="absmiddle" /><%= si.Storage%></td>
                            <td><%= si.Qty %></td>
                            <td class="summaryprice" style="text-align:right"><%=CurrencySymbol%><%= si.BaseCost.ToString("##,##0.00")%></td>
                            <td class="summaryprice" style="text-align:right"><%=CurrencySymbol%><%= si.LineCost.ToString("##,##0.00")%></td>
							
                        </tr>
<% } %>
                    </tbody>
                </table>

                <div class="subcolumns" style="margin-top:1em;">
                    <div class="c50l">
                        <div class="subcl">
							<div class="yform" style="border:0;">
								<div class="type-text">
									<asp:Label ID="lblNotes" AssociatedControlID="Notes" Text="Comments / Special Requests:" runat="server" />
									<asp:TextBox ID="Notes" TextMode="MultiLine" Rows="4" runat="server" />
								</div>
							</div>
                            <h3>Additional Information</h3>
                            <p>In stock orders received by 1PM EST will be shipped the same day. If Ship Partial Order is not checked, order is shipped when all items are in stock. UPS Ground shipping takes 4-5 business days.</p>
							
							<asp:Panel ID="pnlPromotion2" runat="server">
                                    <img src="/images/promo_icon.png" style="float:left; margin-right:5px;" alt="Promo" />
                                    <p class="promotion_headline">Promotional Code is applicable to this item.</p>
                            </asp:Panel>
                            <asp:Panel ID="pnlHazardous2" runat="server">
                                    <img src="images/hazardous_large.gif" style="float:left; margin-right:5px;" alt="Hazardous" />
                                    <p class="hazardous_headline">This item has been deemed as hazardous.</p>
                                    <p>Additional Hazardous shipping fees may apply.</p>
                            </asp:Panel>
                            <asp:Panel ID="pnlRefrigerator2" runat="server">
                	            <img src="images/hazardous_large.gif" style="float:left; margin-right:5px;" alt="Hazardous" />
                                <p class="hazardous_headline" style="padding-top:5px">Refrigerator Message: This item needs to be refrigerated immediately upon arrival.</p>
                            </asp:Panel>
                            <asp:Panel ID="pnlFreezer2" runat="server">
                	            <img src="images/hazardous_large.gif" style="float:left; margin-right:5px;" alt="Hazardous" />
                                <p class="hazardous_headline" style="padding-top:12px">Freezer Message: This item must be stored in a freezer to ensure stability..</p>
                            </asp:Panel>
                        </div>
                    </div>
                    <div class="c50r">
                        <div class="subcr">
                            <table class="price_table" align="right">
                                <tr>
                                    <td class="desc">Subtotal:</td>
                                    <td><strong><asp:Literal ID="ltrSumSubtotal" runat="server" /></strong></td>
                                </tr>              
                                <tr>
                                    <td class="desc">Total Savings:</td>
                                    <td><strong><asp:Literal ID="ltrSumSavings" runat="server" /></strong></td>
                                </tr>              
                                <tr>
                                    <td class="desc"><a href="#modal_spoints2" class="inlinedialog" style="font-weight:bold">SPoints</a> Earned:</td>
                                    <td><strong><asp:Literal ID="ltrSumSPoints" runat="server" /></strong></td>
                                </tr>              
                                <tr>
                                    <td class="desc">Sales Tax:</td>
                                    <td><strong><asp:Literal ID="ltrSumTax" runat="server" /></strong></td>
                                </tr>
                                <tr>
                                    <td class="desc">Shipping Method:</td>
                                    <td><asp:Literal ID="ltrSumShippingMethod" runat="server" /></td>
                                </tr>
                                <tr>
                                    <td class="desc">CARRIER ACCOUNT #:</td>
                                    <td><asp:Literal ID="ltrSumCarrierAccount" runat="server" /></td>
                                </tr>
                                <tr>
                                    <td class="desc">SHIPPING:</td>
                                    <td style="text-align:center;"><a href="#modal_shipping2" class="inlinedialog" style="font-weight:bold">(POLICY)</a></td>
                                </tr>
                                <tr>
                                    <td class="desc"><div style="font-size:16px; font-weight:bold">Final Total:</div>(SHIPPING NOT INCLUDED) </td>
                                    <td style="font-size:16px; font-weight:bold; text-align:center"><span class="ltrTotal"><asp:Literal ID="ltrSumTotal" runat="server" /></span></td>
                                </tr>
                                <tr>
                                    <td colspan="2" class="alignright">
                                        <a href="/terms and conditions final.pdf" target="_blank">I agree to the Terms &amp; Conditions</a>
                                        <asp:CheckBox ID="tccheck" runat="server" />
                                    </td>
                                </tr>
                                <tr style="border-bottom:0">
                                    <td colspan="2" class="alignright">
                                        <asp:Button ID="cmdSummary" Text="" runat="server" CssClass="submitbutton" onclick="cmdSummary_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div style="display:none">
            <div id="modal_shipping2">
                <h3>Shipping Information</h3>
                <p>SPEX CertiPrep will Pre-Pay and Add all shipping charges. If you have no preference in shipping method SPEX CertiPrep will default to UPS ground shipping. If you would like us to apply shipping charges to a specific UPS Collect Account please include your collect account number in the provided box.</p>
            </div>
            <div id="modal_spoints2">
	            <h3>Spoints</h3>
                <p>This is your total accumulated Spoints earned for your current order. If you would like to see your Overall Spoints total, please log in and visit our Customer Center. For further information on SPEX CertiPrep’s Spoints Rewards Program please click on Spoint Rewards in the Purchasing Options Tab.</p>
            </div>
        </div>

    </asp:View>
	
    <asp:View ID="vwReceipt" runat="server">
		<script src="https://apis.google.com/js/platform.js?onload=renderOptIn" async defer></script>

		<script>
		window.renderOptIn = function() {
			window.gapi.load('surveyoptin', function() {
				window.gapi.surveyoptin.render(
				{
					"merchant_id": 112453285,
					"order_id": "<%=OrderID%>",
					"email": "<%=cusEmail%>",
					"delivery_country": "<%=cusCCode%>",
					"estimated_delivery_date": "<%=DateTime.Now.AddDays(7).ToString("yyyy-MM-dd")%>"
				});
			});
		}
		</script>
        <div id="shoppingcart_nav" class="floatbox"> 
	        <ul id="angle" style="width: 100%;">
		        <li><b class="p5"></b><em>Review Your Order</em><b class="p6"></b></li>
		        <li><b class="p5"></b><em>Billing Information</em><b class="p6"></b></li>
		        <li><b class="p5"></b><em>Shipping Information</em><b class="p6"></b></li>
		        <li><b class="p5"></b><em>Order Summary</em><b class="p6"></b></li>
		        <li class="selected"><b class="p5"></b><em>Receipt</em><b class="p6"></b></li>
	        </ul>
        </div>
        <div id="main">
            <div id="backlink_bar2"><a href="/default.aspx">&lt; Return to shopping</a></div>
		    <div id="order_summary" class="floatbox">
        	    <div class="thankyou">
           		    <h3>Thank you! Your Order <asp:Literal ID="ltrOrderNumber" runat="server" /> Has Been Submitted.</h3>
           		    <p>You will receive an email confirmation at <asp:Literal ID="ltrReceiptCustomerMail" runat="server" />.
				    We will contact you shortly with a final estimate for your approval.</p>
				</div>
			    <div id="receipt_nav">
                    <div class="receipt_item"><a href="javascript:window.print();">Print Receipt</a></div>
                    <div class="receipt_item"><a href="about-us/contact-us.aspx">Contact Us</a></div>
                    <div class="receipt_item"><a href="/usercp1.aspx?oh=y" target="_blank">Order History</a></div>
                    <div class="receipt_item"><a href="#modal_shipping3" class="inlinedialog">Shipping Policy</a></div>
                </div>    
    	    </div>

            <div id="resultstable">
                <table id="summary_table" align="center" style="width:100%">
                    <thead>
                        <tr>
                            <th scope="col"></th>
                            <th scope="col">Item Description</th>
                            <th scope="col">Volume</th>
                            <th scope="col">Hazardous</th>
                            <th scope="col">Storage</th>
                            <th scope="col">Quantity</th>
                            <th scope="col" class="price" style="text-align:right">Price</th>
                            <th scope="col" class="price" style="text-align:right">Total</th>
                        </tr>
                    </thead>
                    <tbody>
    <% foreach (ShoppingCartItem si in ItemList) { %>
                        <tr>
                            <td><img src="images/<%=si.Thumbnail%>" width="37" height="37" alt="Thumbnail" /></td>
                            <td class="desc">Part #: <%= si.PartNumber %><br /><input type='hidden' class='hiddenPart' value='<%= si.PartNumber %>' /><span class="greensmall"><%= si.ProdTitle %></span></td>
                            <td><%= si.Volume %></td>
                            <td><img src='/images/<%= si.ShippingIcon %>' width="19" height="17" alt='<%= si.Hazardous %>' class="smallicon" align="absmiddle" /><%= si.Hazardous %></td>
                            <td><img src='/images/<%= si.StorageIcon %>' width="19" height="17" alt='<%= si.Storage %>' class="smallicon" align="absmiddle" /><%= si.Storage%></td>
                            <td><%= si.Qty %></td>
                            <td class="summaryprice" style="text-align:right"><%=CurrencySymbol%><%= si.BaseCost.ToString("##,##0.00")%></td>
                            <td class="summaryprice" style="text-align:right"><%=CurrencySymbol%><%= si.LineCost.ToString("##,##0.00")%></td>
                        </tr>
    <% } %>
                    </tbody>
                </table>

                <div class="subcolumns" style="margin-bottom:50px">
                    <div class="c66l">
                        <div class="subcl">
                            <div class="subcolumns">
                                <div class="c33l">
                                    <div class="subcl">
                                        <strong>Bill To</strong><br />
                                        <asp:Literal ID="ltrRecBillTo" runat="server" />
                                    </div>
                                </div>
                                <div class="c33l">
                                    <div class="subcl">
                                        <strong>Ship To:</strong><br />
                                        <asp:Literal ID="ltrRecShipTo" runat="server" />
                                    </div>
                                </div>
                                <div class="c33r">
                                    <div class="subcr">
                                        <strong>Payment:</strong><br />
                                        <asp:Literal ID="ltrRecPayment" runat="server" /><br /><br />
                                        <strong>Account #:</strong><br />
                                        <asp:Literal ID="ltrRecAccount" runat="server" />
                                    </div>
                                </div>                
             	            </div>
 							<div id="postsurvey" style="border: 3px #94a231 solid;margin-top:15px;padding:15px;color:#fff; -moz-border-radius: 10px; -webkit-border-radius: 10px; border-radius: 10px; background: #5c615d">
								<asp:MultiView ID="mvSurvey" runat="server" ActiveViewIndex="0">
									<asp:View ID="vw0" runat="server">
										<div style="color:#a5b308;font-weight:bold;font-size:1.5em;margin-bottom:15px">Please help us to serve you better</div>
										<div style="margin-bottom:10px"><asp:Literal ID="Q0" runat="server">How easy was it to find the product(s) you needed?</asp:Literal></div>
										<asp:RadioButtonList ID="A0" runat="server" RepeatDirection="Horizontal" RepeatLayout="Table">
											<asp:ListItem Value="Very easy" Text=" Very easy" />
											<asp:ListItem Value="Easy" Text=" Easy" />
											<asp:ListItem Value="Average" Text=" Average" />
											<asp:ListItem Value="Difficult" Text=" Difficult" />
											<asp:ListItem Value="Very Difficult" Text=" Very Difficult" />
										</asp:RadioButtonList>
										<div style="text-align:right">
											<asp:Button ID="cmdSubmitSurvey0" runat="server" Text="Submit" OnClick="cmdSubmitSurvey0_Click" />
										</div>
									</asp:View>
									<asp:View ID="vw1" runat="server">
										<div style="color:#a5b308;font-weight:bold;font-size:1.5em;margin-bottom:15px">Please help us to serve you better</div>
										<div style="margin-bottom:10px"><asp:Literal ID="Q1" runat="server">How did you find the product(s) you needed?</asp:Literal></div>
										<asp:RadioButtonList ID="A1" runat="server" RepeatDirection="Vertical" RepeatLayout="Table">
											<asp:ListItem Value="Searched using the compound/element name (ex. Gold)" Text=" Searched using the compound/element name (ex. Gold)" />
											<asp:ListItem Value="Searched using the instrumentation type (ex. ICP, GCMS)" Text=" Searched using the instrumentation type (ex. ICP, GCMS)" />
											<asp:ListItem Value="I entered the part number" Text=" I entered the part number" />
											<asp:ListItem Value="Searched using the element symbol (ex. Fe)" Text=" Searched using the element symbol (ex. Fe)" />
											<asp:ListItem Value="Searched using the CAS#" Text=" Searched using the CAS#" />
											<asp:ListItem Value="Searched using a method number" Text=" Searched using a method number" />
											<asp:ListItem Value="Other" Text=" Other" />
										</asp:RadioButtonList>
										<div style="text-align:right">
											<asp:Button ID="cmdSubmitSurvey1" runat="server" Text="Submit" OnClick="cmdSubmitSurvey1_Click" />
										</div>
									</asp:View>
									<asp:View ID="vw2" runat="server">
										<div style="color:#a5b308;font-weight:bold;font-size:1.5em;margin-bottom:15px">Please help us to serve you better</div>
										<div style="margin-bottom:10px"><asp:Literal ID="Q2" runat="server">How was your experience using our website?</asp:Literal></div>
										<asp:RadioButtonList ID="A2" runat="server" RepeatDirection="Vertical" RepeatLayout="Table">
											<asp:ListItem Value="Excellent; will use it for all future orders" Text=" Excellent; will use it for all future orders" />
											<asp:ListItem Value="Good; will use it most of the time" Text=" Good; will use it most of the time" />
											<asp:ListItem Value="Average; will use it for stock items only" Text=" Average; will use it for stock items only" />
											<asp:ListItem Value="Fair; I might try it again" Text=" Fair; I might try it again" />
											<asp:ListItem Value="Poor; I will call in my order next time" Text=" Poor; I will call in my order next time" />
										</asp:RadioButtonList>
										<div style="text-align:right">
											<asp:Button ID="cmdSubmitSurvey2" runat="server" Text="Submit" OnClick="cmdSubmitSurvey2_Click" />
										</div>
									</asp:View>
									<asp:View ID="vw3" runat="server">
										<div style="color:#a5b308;font-weight:bold;font-size:1.5em;margin-bottom:15px">Please help us to serve you better</div>
										<div style="margin-bottom:10px"><asp:Literal ID="Q3" runat="server">Did you find the product descriptions informative? </asp:Literal></div>
										<asp:RadioButtonList ID="A3" runat="server" RepeatDirection="Vertical" RepeatLayout="Table">
											<asp:ListItem Value="Very informative" Text=" Very informative" />
											<asp:ListItem Value="Contained the information I needed" Text=" Contained the information I needed" />
											<asp:ListItem Value="Contained only basic information" Text=" Contained only basic information" />
											<asp:ListItem Value="Would like more information in the descriptions" Text=" Would like more information in the descriptions" />
										</asp:RadioButtonList>
										<div style="text-align:right">
											<asp:Button ID="cmdSubmitSurvey3" runat="server" Text="Submit" OnClick="cmdSubmitSurvey3_Click" />
										</div>
									</asp:View>
									<asp:View ID="vw4" runat="server">
										<div style="color:#a5b308;font-weight:bold;font-size:1.5em;margin-bottom:15px">Please help us to serve you better</div>
										<div style="margin-bottom:10px"><asp:Literal ID="Q4" runat="server">If you used our Knowledge Base Section, what section(s) did you use?</asp:Literal></div>
										<asp:CheckBoxList ID="A4" runat="server" RepeatDirection="Vertical" RepeatLayout="Table">
											<asp:ListItem Value="Ask a Chemist" Text=" Ask a Chemist" />
											<asp:ListItem Value="Dilutulator" Text=" Dilutulator" />
											<asp:ListItem Value="Periodic Table" Text=" Periodic Table" />
											<asp:ListItem Value="Conversion Table" Text=" Conversion Table" />
											<asp:ListItem Value="SDS" Text=" SDS" />
											<asp:ListItem Value="Catalog" Text=" Catalog" />
											<asp:ListItem Value="Resources" Text=" Resources" />
										</asp:CheckBoxList>
										<div style="text-align:right">
											<asp:Button ID="cmdSubmitSurvey4" runat="server" Text="Submit" OnClick="cmdSubmitSurvey4_Click" />
										</div>
									</asp:View>
									<asp:View ID="vw5" runat="server">
										<div style="color:#a5b308;font-weight:bold;font-size:1.5em;margin-bottom:15px">Please help us to serve you better</div>
										<div style="margin-bottom:10px"><asp:Literal ID="Q5" runat="server">Did you receive our loyal customer discount?</asp:Literal></div>
										<asp:RadioButtonList ID="A5" runat="server" RepeatDirection="Vertical" RepeatLayout="Table">
											<asp:ListItem Value="Yes" Text=" Yes" />
											<asp:ListItem Value="No" Text=" No" />
											<asp:ListItem Value="I’d like more information" Text=" I’d like more information" />
										</asp:RadioButtonList>
										<div style="text-align:right">
											<asp:Button ID="cmdSubmitSurvey5" runat="server" Text="Submit" OnClick="cmdSubmitSurvey5_Click" />
										</div>
									</asp:View>
									<asp:View ID="vw6" runat="server">
										<div style="color:#a5b308;font-weight:bold;font-size:1.5em;margin-bottom:15px">Please help us to serve you better</div>
										<div style="margin-bottom:10px"><asp:Literal ID="Q6" runat="server">Do you participate in our SPoints rewards program?</asp:Literal></div>
										<asp:RadioButtonList ID="A6" runat="server" RepeatDirection="Vertical" RepeatLayout="Table">
											<asp:ListItem Value="Yes" Text=" Yes" />
											<asp:ListItem Value="No" Text=" No" />
											<asp:ListItem Value="I’d like more information" Text=" I’d like more information" />
										</asp:RadioButtonList>
										<div style="text-align:right">
											<asp:Button ID="cmdSubmitSurvey6" runat="server" Text="Submit" OnClick="cmdSubmitSurvey6_Click" />
										</div>
									</asp:View>
									<asp:View ID="vw7" runat="server">
										<div style="color:#a5b308;font-weight:bold;font-size:1.5em;margin-bottom:15px">Please help us to serve you better</div>
										<div style="margin-bottom:10px"><asp:Literal ID="Q7" runat="server">What tools did you use to find the products you needed for this order?</asp:Literal></div>
										<asp:CheckBoxList ID="A7" runat="server" RepeatDirection="Vertical" RepeatLayout="Table">
											<asp:ListItem Value="Hard copy catalog" Text=" Hard copy catalog" />
											<asp:ListItem Value="Online catalog" Text=" Online catalog" />
											<asp:ListItem Value="Website search features" Text=" Website search features" />
										</asp:CheckBoxList>
										<div style="text-align:right">
											<asp:Button ID="cmdSubmitSurvey7" runat="server" Text="Submit" OnClick="cmdSubmitSurvey7_Click" />
										</div>
									</asp:View>
									<asp:View ID="vwThanks" runat="server">
										<div style="color:#a5b308;font-weight:bold;font-size:1.5em;text-align:center">Thank you for helping us to serve you better</div>
									</asp:View>
								</asp:MultiView>
							</div>
                       </div>
                    </div>
                    <div class="c33r">
                        <div class="subcr">
                            <table class="price_table" align="right">
                                <tr>
                                    <td class="desc">Subtotal:</td>
                                    <td><strong><asp:Literal ID="ltrRecSubtotal" runat="server" /></strong></td>
                                </tr>              
                                <tr>
                                    <td class="desc">Total Savings:</td>
                                    <td><strong><asp:Literal ID="ltrRecSavings" runat="server" /></strong></td>
                                </tr>              
                                <tr>
                                    <td class="desc"><a href="#modal_spoints3" class="inlinedialog" style="font-weight:bold">SPoints</a> Earned:</td>
                                    <td><strong><asp:Literal ID="ltrRecSpoints" runat="server" /></strong></td>
                                </tr>              
                                <tr>
                                    <td class="desc">Sales Tax:</td>
                                    <td><strong><asp:Literal ID="ltrRecTax" runat="server" /></strong></td>
                                </tr>
                                <tr>
                                    <td class="desc">Shipping Method:</td>
                                    <td><asp:Literal ID="ltrRecShippingMethod" runat="server" /></td>
                                </tr>
                                <tr>
                                    <td class="desc">CARRIER ACCOUNT #:</td>
                                    <td><asp:Literal ID="ltrRecShipAccountNo" runat="server" /></td>
                                </tr>
                                <tr>
                                    <td class="desc">SHIPPING:</td>
                                    <td style="text-align:center;"><a href="#modal_shipping3" class="inlinedialog" style="font-weight:bold">(POLICY)</a></td>
                                </tr>
                                <tr>
                                    <td class="desc"><div style="font-size:16px; font-weight:bold">Final Total:</div>(SHIPPING NOT INCLUDED) </td>
                                    <td style="font-size:16px; font-weight:bold; text-align:center"><span class="ltrTotal"><asp:Literal ID="ltrRecTotal" runat="server" /></span></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
           </div>
        </div>
            
        <div style="display:none">
            <div id="modal_shipping3">
                <h3>Shipping Information</h3>
                <p>Most items are shipped via UPS or motor freight, depending on the size and weight of the shipment.  Various overnight/express services are also available.  All shipping charges are prepaid and the cost is added at the time of invoice.</p>
            </div>
            <div id="modal_spoints3">
	            <h3>Spoints</h3>
                <p>This is your total accumulated Spoints earned for your current order. If you would like to see your Overall Spoints total, please log in and visit our Customer Center. For further information on SPEX CertiPrep’s Spoints Rewards Program please click on Spoint Rewards in the Purchasing Options Tab.</p>
            </div>
        </div>
		<!-- Google Code for Cart Conversion Page -->
		<script type="text/javascript">
		/* <![CDATA[ */
		var google_conversion_id = 1051567786;
		var google_conversion_language = "en";
		var google_conversion_format = "3";
		var google_conversion_color = "ffffff";
		var google_conversion_label = "rN9NCPynvQIQqs229QM";
		var google_conversion_value = 0;
		if (1) {
		  google_conversion_value = 1;
		}
		/* ]]> */
		</script>
		<script type="text/javascript" src="https://www.googleadservices.com/pagead/conversion.js">
		</script>
		<noscript>
		<div style="display:inline;">
		<img height="1" width="1" style="border-style:none;" alt="" src="https://www.googleadservices.com/pagead/conversion/1051567786/?value=1&amp;label=rN9NCPynvQIQqs229QM&amp;guid=ON&amp;script=0"/>
		</div>
		</noscript>
            
    </asp:View>
</asp:MultiView>

<asp:SqlDataSource ID='dataShippingAddresses' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>" CancelSelectOnNullParameter="true"
    SelectCommand="SELECT * FROM cp_roi_CMSHIP WHERE Bill_To_Customer = @CustomerNumber" SelectCommandType="Text">
    <SelectParameters>
        <asp:Parameter Name="CustomerNumber" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>


</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
<link href="/css/screen/jquery-ui.css" rel="stylesheet" type="text/css" media="screen">
<script src="/js/jquery-ui.js" type="text/javascript"></script>
<script type="text/javascript">
		function removeItem(id) {
			var values = {};
			$(".loadingBox").show();
			values['id'] = id;
			values['action'] = 'delete';
			$.ajax({
				'url' 		: 'order_summary.aspx',
				'type' 		: 'GET',
				'data' 		: values,
				success 	: function(data){
				},
				complete 	: function() {
					$(".itemTableContainer").load("/order_items.aspx", function() {
						$(".loadingBox").hide(); 
						$('#removedBox').show();
						updatePrices();
						setInterval(function(){
							$('#removedBox').fadeOut('slow', function() {
								$('#removedBox').hide();
							});
						}, 3000);
						if ($(".summaryprice").length <= 0){
							$("#cmdSubmit").attr("onclick", "alert('You have no items in your shopping cart.');return false;");
						}
					});
				}
			});
			
		}
		function addItem() {
			if ($("#review_partsearch").val().length > 0) {
				if (!$("#error_additem:contains('Part number not found')").text()) {
					var part = $("#review_partsearch").val();
					var values = {};
					$(".loadingBox").show();
					values['part'] = part;
					values['action'] = 'add';
					$.ajax({
						'url' 		: 'order_summary.aspx',
						'type' 		: 'GET',
						'data' 		: values,
						success 	: function(data){
						},
						complete 	: function() {
							$(".itemTableContainer").load("/order_items.aspx", function() {
								$(".loadingBox").hide(); 
								$('#addBox').show();
								setInterval(function(){
									$('#addBox').fadeOut('slow', function() {
										$('#addBox').hide();
									});
								}, 3000);
								$("#error_additem").empty();
								$("#review_partsearch").val('');
								$("#cmdSubmit").removeAttr("onclick");
							});
						}
					});
				}
			}else {
				$("#error_additem").html("<span class='red'>Please input Part number</span>");
			}
		}
		function updateQuantity(divid, counter, newQuantity) {
			
			divName = ".quantitybox_" + divid;
			$(".loadingBox").show();
			$(divName).load("/utility/updatequantity.aspx?itemid=" + divid + "&quantity=" + newQuantity + "&counter=" + counter, function () {
				$(".itemTableContainer").load("/order_items.aspx", function() {
					$(".loadingBox").hide(); 
				});
			});
		}

		$(document).ready(function () {
			$("input[name='ShipPayment']").click(function () {
				if ($("input[name='ShipPayment']:checked").val() == "Inv") {
					$("#rowCarrierAcct").hide();
				} else if ($("input[name='ShipPayment']:checked").val() == "Acct") {
					$("#rowCarrierAcct").show();
				}
			});

			$("#review_partsearch").bind('keyup', function () {
				var thepartquery = $("#review_partsearch").val();
				if (thepartquery.length != 0) {
					$("#error_additem").load("/utility/checkpart.aspx?query=" + thepartquery);
				}
			})
			$("#review_promocode").bind('keyup', function () {
				var thepromoquery = $("#review_promocode").val();
				var shipmeth = $("#shipmethod").val();
				if (thepromoquery.length != 0) {
					$("#error_promo_quote").load("/utility/checkpromo.aspx?query=" + thepromoquery + "&ship=" + shipmeth);
				}
			})
			$("#promo_add").click(function (e) {
				if (($("#error_promo_quote").html()).indexOf("Valid promotional code") != -1) {
					var promocode = $("#review_promocode").val();
					document.location.href = "order_summary.aspx?action=addpromo&promocode=" + promocode;
				} else {
					e.preventDefault();
					alert("This promotional code is not valid.");
				}
			})
			$(".inlinedialog").fancybox({
				'autoDimensions': false,
				'width': 300,
				'padding': 16,
				'centerOnScroll': true
			});
			<% if (Session["PONumber"] != null) {%>
				$("#poNum").trigger("click");
				$("#POInfo").show();
				$("#creditInfo").hide();
				console.log("PO Exists");
			<%}%>
			
			<% if (Session["CreditCard"] != null) {%>
				$("#creditCard").trigger("click");
				$("#creditInfo").show();
				$("#POInfo").show();
				console.log("CreditCard Exists");
			<%}%>
			
			$("#poNum").click(function(){
				$("#POInfo").show();
				$("#creditInfo").hide();
			});
			$("#creditCard").click(function() {			
				$("#creditInfo").show();
				$("#POInfo").show();
			});
			$(".pageBack").click(function() {
				var backLocation = document.referrer;
				if (backLocation) {
					if (backLocation.indexOf("?") > -1) {
						backLocation += "&redirect=order_summary";
					} else {
						backLocation += "?redirect=order_summary";
					}
					window.location.assign(backLocation);
				}
			});
			$(".pageCheckOut").click(function() {
				$(".submitbutton").trigger("click");
			});
			$(".removeItem").click(function() {
				var part = $(this).data("prodid");
				removeItem(part);
			});

			$(".quantity_dd").on("change",function() {
				var ctr = $(this).data("ctr");
				var id = $(this).data("prodid");
				var qty = $(this).val();
				updateQuantity(id, ctr, qty);
			});
			
			$("#cmdSubmit").click(function(){
				console.log("Review Order - Check Out");
				eventTrackSend("Review Order", "Check Out");
			});
			
			$("#cmdBilling").click(function(){
				console.log("Billing Information - Continue");
				eventTrackSend("Billing Information", "Continue");
			});
			
			$("#cmdShipping").click(function(){
				console.log("Shipping Information - Continue");
				eventTrackSend("Shipping Information", "Continue");
			});
			
			$("#cmdSummary").click(function(){
				console.log("Order Summary - Complete Order");
				eventTrackSend("Order Summary", "Complete Order");
			});
			
			
			var availableTags = [
			  "AL", "AK", "AZ", "AR", "AB",
			  "BC", "CA", "CO", "CT", "DC",
			  "DE", "FA", "GA", "HI", "ID",
			  "IL", "IN", "IA", "KS", "KY",
			  "LA", "ME", "MD", "MA", "MI",
			  "MN", "MS", "MO", "MT", "NC",
			  "NB", "ND", "NE", "NV", "NH",
			  "NJ", "NM", "NY", "OH", "OK",
			  "OR", "ON", "PA", "PR", "RI",
			  "SC", "SD", "TN", "TX", "UT",
			  "VT", "VA", "WA", "WV", "WI", "WY"
			];
			$( "#billState" ).autocomplete({ source: availableTags });
			$( "#shipState" ).autocomplete({ source: availableTags });
		});
		
		function eventTrackSend(cat, act) {
			ga('send', {
				hitType: 'event',
				eventCategory: cat,
				eventAction: act,
			});
		}
		
		
	</script>
</asp:Content>

