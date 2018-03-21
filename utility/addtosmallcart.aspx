<%@ Page Language="C#" AutoEventWireup="true" CodeFile="addtosmallcart.aspx.cs" Inherits="equipment_and_accessories_addtocart2" debug="true" %>

	<div class="footer_content">
		Total:
		<span style="color:#A3B405;font-weight:bold;">
			<asp:Literal ID="ltrCurrencySymbolHeader" runat="server" />
			<%=String.Format("{0:##,##0.00}", StartingPrice2)%>
		</span>
	</div>
	<a class="smallCartBtn" href="/order_summary.aspx" title="Go to Cart"><div class="cart_lbl"></div></a>
	<div class="mobile_cart_lbl"></div>
	<div id="totalitems" class="itemCount"><%=TotalProductCountNum2%></div>
	<a href="/order_summary.aspx" title="View Cart"><span class="qty"><%=(Convert.ToInt32(qty) <= 1) ? qty + " Item Added to Cart" : qty + " Items Added to Cart" %></span></a>
	<div style="clear:both"></div>