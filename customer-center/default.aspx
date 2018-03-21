<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="hipure_inorganic" Debug="True"%>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <style type="text/css">
        a.aspNetDisabled { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        a.aspNetDisabled:hover { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        #ProductListPagerSimple span,
        #ProductListPagerSimple2 span { font-weight:bold; }
		.buybutton { border-right: 1px solid #727272; }
		#breadcrumb { padding:0;}
    </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
	<!--CAS Pop Up-->
	<div id="cas-container-opacity">
		<div id="cas-container">
			<div class="close-x"></div>
			<div class="CAStable"></div>
		</div>
	</div>
	<!--EOF CAS Pop Up-->
	<div id="main" style="margin-bottom:2em">
		<h1 class="cc">Customer Center Coming Soon!</h1>
            <div class="subcolumns">			
				<div class="c30l">
					<div>
						<div class="customer-center">
							<ul>
								<li class="header">My Account</li>
								<li><a class="selected">My Orders <span class="coming-soon">- Coming Soon!</span></a></li>
								<li><a href="/customer-center/settings/">Account Details</a></li>
								<li><a href="/customer-center/loyal-customer-rewards/">My SPoints <span class="coming-soon">- Coming Soon!</span></a></li>
							</ul>
						</div>
					</div>
					 
				</div>	
				<div class="c66r ">
    			    <div style="">
						<p style="font-size: 18px">From the Customer Center you will have the ability to view your order activity and update your
							account information. You will be able to see the status of your current orders, access previous 
							orders and invoices, track shipments, view an SDS by part number, and easily reorder. In addition,
							you will now have access to view your SPoints balance.</p>
						<p style="font-size: 18px">Contact <a href="mailto:CRMMarketing@spex.com">CRMMarketing@spex.com</a> with any questions or call us at 1.732.549.7144.</p>
						<div id="cc-p" class="hidden">		
							<h2 class="ccClient">Hello, <%=DisplayName%>!</h2>
							<p>Welcome to Your Account. From your account you have the ability to view your order activity and update your account information. You can easly see the status of your current orders, access prior orders and invoices, track order shipments, view and SDS by part number and easily reorder. In addition, you now have access to view your SPoints Rewards balance.</p>
							<p>Contact <a href="mailto:CRMMarketing@spex.com">CRMMarketing@spex.com</a> with any questions or call us at 1.732.549.7144.</p>
						</div> 											
    			    </div>
    		    </div>	
            </div>
		<div id="resultstable" class="hidden">
			<!--<div style="text-align: right; margin: 1.5em 0 0;">-->
			<div>
				<h2 class="cc pull-left">Order Summary</h2>
				<div class="show-list-wrap pull-right">
					<div class="pull-left">Show</div>
					<asp:DropDownList ID="lbResults" runat="server" AutoPostBack="True" CssClass="page-filter pull-left" OnSelectedIndexChanged="lbResults_Change">
						<asp:ListItem Value="10" Text="10" />
						<asp:ListItem Value="20" Text="20" />
						<asp:ListItem Value="30" Text="30" />
						<asp:ListItem Value="40" Text="40" />
						<asp:ListItem Value="50" Text="50" />
					</asp:DropDownList>
					<div class="pull-left">per page</div>
				</div>
				<div class="clear"></div>
			</div>
			<div id="order-summary-wrap" class="tab" style="margin:2em 0 6em;display:block"> 
				<div id="orders-summary">
					<table width="958" class="cuscen table table-bordered table-hover text-center" align="center" >
						<thead>
							<tr>
								<th scope="col" id="selector">Order Number</th>
								<th scope="col" id="selector">Order Date</th>
								<th scope="col" id="selector">Order Total</th>
								<th scope="col" id="selector">Order Status</th>
								<th scope="col" id="selector">Details</th>
								<th scope="col" id="selector">Reorder</th>
							</tr>
						</thead>
						<tbody>
							<asp:ListView ID="lvOrderSummary" runat="server" DataSourceID="dataOrderSummary">
								<LayoutTemplate>
									<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
								</LayoutTemplate>
								<ItemTemplate>
									<tr class="webUser">
										<td><%# Eval("id").ToString() %></td>
										<td>
											<%# Eval("orderdate").ToString() %>
										</td>
										<td><%# Eval("FinalPrice").ToString() %></td>
										<td><%# getOrderStatus(Eval("id").ToString().Trim()) %></td>
										<td>
											<a class="viewOrderBtn" href="/customer-center/my-orders/default.aspx?id=<%# Eval("id").ToString() %>">View Order</a>
										</td>
										<td>
											<a href="#Reorder-<%# Eval("id").ToString() %>" class="reorderBtn" data-orderid="<%# Eval("id").ToString() %>">Reorder</a>
											<div class="hidden">
												<%# getProducts(Eval("id").ToString().Trim()) %>
											</div>
										</td>
									</tr>
								</ItemTemplate>
								<EmptyDataTemplate>
									
								</EmptyDataTemplate>
							</asp:ListView>
						</tbody>
					</table>
				</div>
				<asp:DataPager ID="ProductListPagerSimple" ClientIDMode="Static" runat="server" PagedControlID="lvOrderSummary" PageSize="10" QueryStringField="page" OnInit="DataPager_Init">
					<Fields>
						<asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="true" FirstPageText="&lt;&lt;" PreviousPageText="&lt;" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
						<asp:NumericPagerField RenderNonBreakingSpacesBetweenControls="false" />
						<asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="true" LastPageText="&gt;&gt;" NextPageText="&gt;" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
					</Fields>
				</asp:DataPager>
			</div>
			<div style="display:none">
				<div id="viewOrderBox">
					
				</div>
			</div>
		</div>
	</div>
	
	<asp:SqlDataSource ID='dataOrderSummary' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>" SelectCommandType="Text" onselected="dataOrderSummary_Selected">
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script src="/js/jquery-ui.js" type="text/javascript"></script>
	<script src="/js/jquery.tablesorter.min.js" type="text/javascript"></script>	
    <script type="text/javascript">
        $(document).ready(function () {			
			$(".reorder").click(function() {
				var prodID = $(this).attr('name');
				buyIt(prodID);
			});			
			$(".viewOrder").fancybox();
			
			$(".viewOrderBtn").click(function(){
				var part = $(this).attr('data-so');
				location.replace("/customer-center/order-summary/default.aspx?id=" +part);
			});
			
			$(".reorderBtn").click(function() {
				var orderID = $(this).data("orderid");
				$(".item-of-" + orderID).each(function() {
					var item = $(this).text();
					var qty = $(this).data("qty");
					buyIt(item, qty);
				});
			});
			
        });
        function buyIt(productid, theQuantity) {
            if(theQuantity == '' || theQuantity == '0' ) {
            	theQuantity = 1;
            }
            $("#footer_cart").load("/utility/addtocart.aspx?productid=" + productid + "&pq=" + theQuantity, function () {
                //$("#totalitems").effect("highlight", { color: "#ffffff" }, 5000);
                $("#totalcost").effect("highlight", { color: "#ffffff" }, 5000);
                $("#totalsavings").effect("highlight", { color: "#ffffff" }, 5000);
                $("#SPoints").effect("highlight", { color: "#ffffff" }, 5000);
            });
			setTimeout(function(){itemAddShow();},500);
        }
		function buyIt2(productid) {
            theQuantity = document.getElementById("quantity_" + productid).value;
            if(theQuantity == '' || theQuantity == '0' ) {
            	alert('Quantity must be greater than 0');
            	return false;
            }
            $("#footer_cart").load("/utility/addtocart.aspx?productid=" + productid + "&pq=" + theQuantity, function () {
                //$("#totalitems").effect("highlight", { color: "#ffffff" }, 5000);
                $("#totalcost").effect("highlight", { color: "#ffffff" }, 5000);
                $("#totalsavings").effect("highlight", { color: "#ffffff" }, 5000);
                $("#SPoints").effect("highlight", { color: "#ffffff" }, 5000);
            });
            $("#buy_" + productid).removeClass("search_buy");
            $("#buy_" + productid).addClass("search_buy_clicked");
            setTimeout(function(){itemAddShow();},500);
        }
		
		function itemAddShow() {
			$('.float-footer').addClass("mobshow");
			$(".itemAddBox").fadeIn("slow");
			setTimeout(function() {
				$(".itemAddBox").fadeOut("slow");
			}, 4000);
		}
 
    </script>
</asp:Content>