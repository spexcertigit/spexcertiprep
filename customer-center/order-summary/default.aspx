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
		<h1 class="cc">Customer Center</h1>
            <div class="subcolumns">			
				<div class="c30l">
					<div>
						<h2 id="cusOrders">Orders</h2>
						<div class="customer-center">
							<ul>
								<li><a href="/customer-center/current-orders/">Current Orders</a></li>
								<li><a class="selected">Order Summary</a></li>
								<li><a href="/customer-center/order-details/">Order Details</a></li>
								<li><a href="/customer-center/previous-orders/">Previous Orders</a></li>
								<li><a href="/customer-center/loyal-customer-rewards/">My SPoints</a></li>
								<li><a href="/customer-center/settings/">Account Settings</a></li>
							</ul>
						</div>
					</div>
					 
				</div>	
				<div class="c66r ">
    			    <div style="">
						<div id="cc-p">		
							<h2 class="ccClient">Hello, <%=DisplayName%>!</h2>
							<p>Welcome to our Customer Center page. From here you have a access to your entire order history for your account. You can easily see the status of current orders, access prior orders, view SDS by part number and easily re-order. In addition you now have access to view your SPoints Rewards balance.</p>
							<p>Contact <a href="mailto:CRMMarketing@spex.com">CRMMarketing@spex.com</a> with any questions.</p>
						</div> 											
    			    </div>
    		    </div>	
            </div>
    <div id="resultstable" style="margin-top:3em">
		<!--<div style="text-align: right; margin: 1.5em 0 0;">-->
		
		<div><h2 class="cc">Order Summary</h2></div>
		<div class="customer-center-nav">
			<a data-id="frequent_orders" class="tabselector" href="javascript:void()" style="margin-right:0; border-radius:4px 0 0 0">Select Web Order: </a>
			<select id="ddlOrder">
				<option value="0">-- Web Order --</option>
				<asp:Literal ID="ltrOrderList" runat="server" />
			</select>
			<div class="bottom-line"></div>
		</div>
        <div id="summary_orders" style="margin:2em 0 6em"> 
			<asp:Literal ID="ltrSummary" runat="server" />
		</div>
    </div>
	</div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script src="/js/jquery-ui.js" type="text/javascript"></script>
	<script src="/js/jquery.tablesorter.min.js" type="text/javascript"></script>	
    <script type="text/javascript">
        $(document).ready(function () {
			$(".tablesorter tr:odd").addClass("odd");
			$(".various_cascon").click(function(){
				var part = $(this).attr('data-partnum');
				jQuery.ajax({
					url: 'default.aspx/GetDataCAS',
					type: "POST",
					data: JSON.stringify({ partnumber: part }),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						jQuery('#cas-container .CAStable').html(data.d);
					}
				});
				$('#cas-container-opacity').insertAfter(".mask-layout");
				$('#cas-container-opacity').show(500);
				$(".mask-layout").show();
				$(".mask-layout").css("height", $("body").height());
			});
			$(".close-x").click(function(){
				$('#method-container-opacity').hide();
				$('#cas-container-opacity').hide();
				$('.mask-layout').hide();
			});
			
			$(".reorder").click(function() {
				var prodID = $(this).attr('name');
				//alert(prodID);
				buyIt(prodID);
			});
			$(".noprod").click(function() {
				var prodID = $(this).attr('name');
				alert("Product " + prodID + " is no longer available.");
			});
			
			$(".viewOrder").fancybox();
			
			$(".viewOrderBtn").click(function(){
				var part = $(this).attr('data-so');
				$.ajax({
					url: 'default.aspx/getViewOrder',
					type: "POST",
					data: JSON.stringify({ id: part }),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						$('#viewOrderBox').html(data.d);
						$(".viewOrder").trigger("click");
					}
				});
			});
        });
        function buyIt(productid) {
            theQuantity = 1;
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
		$(document).ready(function() 
			{ 
				$(".tablesorter").tablesorter({
					headers: {
						3: {sorter: false}, 
						4: {sorter: false}, 
						5: {sorter: false}, 
						6: {sorter: false}, 
						7: {sorter: false}
					}
				}); 
				
			} 
		); 		
		
		function itemAddShow() {
			$('.float-footer').addClass("mobshow");
			$(".itemAddBox").fadeIn("slow");
			setTimeout(function() {
				$(".itemAddBox").fadeOut("slow");
			}, 4000);
		}
    </script>  
	<script>
	$(document).ready(function () {
		$("#ddlOrder").change(function() {
			if ($(this).val() != "0"){
				location.replace("/customer-center/order-summary/default.aspx?id=" + $(this).val());
			}
		});
	});
	</script>
</asp:Content>

