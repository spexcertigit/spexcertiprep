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
        });
        function buyIt(productid) {
            theQuantity = 1;
            if(theQuantity == '' || theQuantity == '0' ) {
            	alert('Quantity must be greater than 0');
            	return false;
            }
			$('.float-footer').css("display", "block");
            $("#footer_cart").load("/utility/addtocart.aspx?productid=" + productid + "&pq=" + theQuantity, function () {
                $("#totalcost").effect("highlight", { color: "#ffffff" }, 5000);
                $("#totalsavings").effect("highlight", { color: "#ffffff" }, 5000);
                $("#SPoints").effect("highlight", { color: "#ffffff" }, 5000);
            });
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
    </script>
	<script>
		$(function() {
			try {
				$("#technique").msDropDown();
				$("#category").msDropDown();
			} catch (e) {
				alert(e.message);
			}
		});
	</script>     
	<script>
	jQuery(document).ready(function () {
		jQuery('#banner-div').before(jQuery('.header-wrapper'));
		jQuery('#main').before(jQuery('#breadcrumb'));
		jQuery('#banner-div').show();
		
		var field = 'a';
		var url = window.location.href;
		if(url.indexOf('?' + field + '=') != -1) {
			$(".assurance").addClass('selected');
			$(".claritas").removeClass('selected');
		}else if(url.indexOf('&' + field + '=') != -1) {
			$(".assurance").addClass('selected');
			$(".claritas").removeClass('selected');
		}else {
			$(".assurance").removeClass('selected');
			$(".claritas").addClass('selected');
		}
		
	});
	</script>
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
								<li><a href="/customer-center/">My Orders <span class="coming-soon">- Coming Soon!</span></a></li>
								<li><a href="/customer-center/settings/">Account Details</a></li>
								<li><a class="selected">My SPoints <span class="coming-soon">- Coming Soon!</span></a></li>
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
							<p>SPoints can be redeemed for valuable merchandise such as gift cards, electronics and even gift certificates towards your next SPEX CertiPrep purchase. You can redeem your SPoints at any time by emailing us at <a href="mailto:CRMMarketing@spex.com">CRMMarketing@spex.com</a> or calling us at 1.732.549.7144</p>
						</div> 											
    			    </div>
    		    </div>	
            </div>
			<div id="resultstable" style="margin-top:3em">
				<div class="hidden">
					<!--<div style="text-align: right; margin: 1.5em 0 0;">-->
					<div class="pagers1_wrapper">									
						<asp:DataPager ID="ProductListPagerSimple" style="display:none" ClientIDMode="Static" runat="server" PagedControlID="lvProducts" PageSize="25" QueryStringField="page">
							<Fields>
								<asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="true" RenderDisabledButtonsAsLabels="true" FirstPageText="&lt;&lt;" PreviousPageText="&lt;" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
								<asp:NumericPagerField RenderNonBreakingSpacesBetweenControls="false" />
								<asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="true" RenderDisabledButtonsAsLabels="true" LastPageText="&gt;&gt;" NextPageText="&gt;" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
							</Fields>
						</asp:DataPager>
						<div style="clear:both"></div>
					</div>
					<h2 class="half-header">SPoints Rewards Summary</h2>
					<div class="spointSum">
						<div class="col1">
							<span class="cc"><strong>SPoints balance information</strong></span><br />
							<br />
							<span class="cc"><strong>Current Rate</strong></span><br />
							
						</div>
						<div class="col2 text-right">
							Your current balance is <span class="orange"><%=Spoints%></span> SPoint(s).<br />
							<br /><br />
							Each <span class="orange">$10</span> spent will earn <span class="orange">1</span> SPoint.<br />
							<br /> 
							<a href="mailto:CRMMarketing@spex.com" class="btn btn-warning btn-lg submitBtn" title="Redeem SPoints">REDEEM SPOINTS</a>
						</div>
						<div style="clear:both"></div>
					</div>
					<div class="customer-center-nav" style="display:none;">
						<a class="order_history selected" href="#">Transaction History</a>
						<a class="expiring_standards" href="#">Redeemed SPoints</a>
						<div class="bottom-line"></div>
					</div>
					<div style="margin:2em 0 6em"> 
						<h2 id="tableTitle" class="cc strong">Transaction History</h2>
						<table width="958" class="cuscen table table-bordered text-center" align="center" >
							<thead>
								<tr>
									<th scope="col" style="text-align:left">Order Number</th>
									<th scope="col">Date</th>
									<th scope="col">SPoints Received</th>
								</tr>
							</thead>
							<tbody>
								<asp:ListView ID="lvProducts" runat="server" DataSourceID="dataProducts">
									<LayoutTemplate>
												<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
									</LayoutTemplate>
									<ItemTemplate>
										<tr>
											<td class="text-left"><a href="/customer-center/order-summary/default.aspx?id=<%# Eval("id")%>" target="_blank"><%# Eval("id")%></a></td>
											<td style="text-align:center;white-space:nowrap;"><%# Eval("orderdate")%></td>
											<td style="text-align:right;white-space:nowrap;width:20%"><%# Eval("points")%></td>
										</tr>
									</ItemTemplate>
									<EmptyDataTemplate>
									</EmptyDataTemplate>
								</asp:ListView> 
							</tbody>
						</table>
						<asp:DataPager ID="ProductListPagerSimple2" ClientIDMode="Static" runat="server" PagedControlID="lvProducts" PageSize="25" QueryStringField="page">
							<Fields>
								<asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="true" RenderDisabledButtonsAsLabels="true" FirstPageText="&lt;&lt;" PreviousPageText="&lt;" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
								<asp:NumericPagerField RenderNonBreakingSpacesBetweenControls="false" />
								<asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="true" RenderDisabledButtonsAsLabels="true" LastPageText="&gt;&gt;" NextPageText="&gt;" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
							</Fields>
						</asp:DataPager> 
						
						<div style="margin:4em 0 0;display:none;">
							<h2 class="cc strong">E-mail Notification Settings</h2>
							<label>Subscribe for balance update</label>
						</div>
					</div>
				</div>
			</div>
		</div>
			
    <asp:SqlDataSource ID='dataProducts' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommandType="Text" onselected="dataProducts_Selected">
    </asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
</asp:Content>

