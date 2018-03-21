<%@ Page Language="C#" AutoEventWireup="true" CodeFile="addtocart.aspx.cs" Inherits="equipment_and_accessories_addtocart" debug="true" %>

	<div class="cart_lbl">Shopping Cart</div>
	<div class="mobile_cart_lbl"></div>
	<div id="totalitems" class="itemCount"><%=TotalProductCountNum%></div>
	<div class="footer_content">
		<%=ProductCountText%> 
		<span id="totalcost" style="padding:0 15px">|</span> Total: <span style="color:#A3B405;font-weight:bold;"><asp:Literal ID="ltrCurrencySymbol" runat="server" /><%=String.Format("{0:##,##0.00}", StartingPrice)%></span>
	</div>
	<asp:Literal ID="ltrLoadSmallCart" runat="server" />

	<%--<div class="cart-items" id="totalitems">
		<%=ProductCountText%> in my cart
	</div>
	<span style="display:none;">
	<div class="footer_item" id="totalcost">
        <asp:Literal ID="ltrCurrencySymbol" runat="server" /> 
    </div></span>
	<div class="cart-points">
		<div class="savings" id="totalsavings"><asp:Literal ID="ltrCurrencySymbol2" runat="server" /><%=FinalDiscount %> Savings</div>
		<div class="spoints" id="SPoints"><%=TotalSpoints%> SPoints</div>
	</div>--%>
	<div class="footer_update"></div>
    