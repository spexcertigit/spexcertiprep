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
								<li><a href="/customer-center/order-summary/">Order Summary</a></li>
								<li><a href="/customer-center/order-details/">Order Details</a></li>
								<li><a class="selected">Previous Orders</a></li>
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
		<div class="pagers1_wrapper">									
			<asp:DataPager ID="ProductListPagerSimple" style="display:none" ClientIDMode="Static" runat="server" PagedControlID="lvPrevWebOrders" PageSize="25" QueryStringField="page">
				<Fields>
					<asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="true" RenderDisabledButtonsAsLabels="true" FirstPageText="&lt;&lt;" PreviousPageText="&lt;" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
					<asp:NumericPagerField RenderNonBreakingSpacesBetweenControls="false" />
					<asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="true" RenderDisabledButtonsAsLabels="true" LastPageText="&gt;&gt;" NextPageText="&gt;" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
				</Fields>
			</asp:DataPager>
			<div style="clear:both"></div>
		</div>
		<div class="customer-center-nav">
			<a data-id="order_history" class="tabselector selected" href="javascript:void()">Order History</a>
			<a data-id="expiring_standards" class="tabselector" href="javascript:void()">Expiring Standards</a>
			<div class="bottom-line"></div>
		</div>
        <div id="order_history" class="tab" style="margin:2em 0 6em">
            <table width="958" class="tablesorter cc" align="center" >
                <thead>
                    <tr>
                        <th scope="col" id="partnumber" onclick="doSort('partnumber')" class="header sorter">Part #</th>
                        <th scope="col" id="title" onclick="doSort('title')" class="header sorter">Lot #</th>
                        <th scope="col" id="matrix" onclick="doSort('matrix')" class="header sorter">Date Ordered</th>
                        <th scope="col" id="volume" onclick="doSort('volume')" class="">Certificate</th>
                        <th scope="col">SDS</th>
						 <th scope="col" id="status" onclick="doSort('status')" class="">Status</th>
                        <th scope="col" id="price" onclick="doSort('price')" style="border-right:1px solid;">&nbsp;</th>
                    </tr>
                </thead>
                <tbody>
					<asp:ListView ID="lvPrevWebOrders" runat="server" DataSourceID="dataProducts3">
                        <LayoutTemplate>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>
									<%# getProductLink(Eval("item_id").ToString().Trim()) %>
								</td>
                                <td><%# getWebLotNumber(Eval("Order_Number").ToString(), Eval("item_id").ToString().Trim()) %></td>
                                <td><%# string.Format("{0:MM/dd/yyyy}", Eval("date_ordered")) %></td>
                                <td><%# getCertificate(getLotNumber(Eval("Order_Number").ToString().Trim(), Eval("item_id").ToString().Trim())) %></td>
                                <td><%# getMSDS(Eval("item_id").ToString().Trim()) %></td>
								<td><%# getOrderStatus(Eval("Order_Number").ToString()) %></td>
                                <td><a class="viewOrderBtn" data-so='<%#Eval("Order_Number").ToString()%>'>View Order</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<%# checkProduct(Eval("item_id").ToString().Trim()) %></td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                        </EmptyDataTemplate>
                    </asp:ListView> 
					
					<asp:ListView ID="lvPrevOrders" runat="server" DataSourceID="dataProducts">
                        <LayoutTemplate>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>
									<%# getProductLink(Eval("Part_Wo_Gl").ToString().Trim()) %>
								</td>
                                <td><%# getLotNumber(Eval("So_Nbr").ToString(), Eval("Part_Wo_Gl").ToString().Trim()) %></td>
                                <td><%# string.Format("{0:MM/dd/yyyy}", Eval("So_Date")) %></td>
                                <td><%# getCertificate(getLotNumber(Eval("So_Nbr").ToString().Trim(), Eval("Part_Wo_Gl").ToString().Trim())) %></td>
                                <td><%# getMSDS(Eval("Part_Wo_Gl").ToString().Trim()) %></td>
								<td><%# getOrderStatus(Eval("So_Nbr").ToString()) %></td>
                                <td><a class="viewOrderBtn" data-so='<%#Eval("So_Nbr").ToString()%>'>View Order</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<%# checkProduct(Eval("Part_Wo_Gl").ToString().Trim()) %></td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                        </EmptyDataTemplate>
                    </asp:ListView>
                </tbody>
            </table>
		</div>
		
		
		<div id="expiring_standards" class="tab" style="margin:2em 0 6em"> 
            <table width="958" class="tablesorter cc" align="center" >
                <thead>
                    <tr>
                        <th scope="col" id="partnumber" class="header sorter">Part #</th>
                        <th scope="col" id="desc" class="header sorter">Description</th>
                        <th scope="col" id="date" class="header sorter">Date Ordered</th>
                        <th scope="col" id="exp" class="header sorter">Expiration</th>
						<th scope="col" id="expdate" class="header sorter">Expiry Date</th>
						<th scope="col" >Remaining</th>
                        <th scope="col" style="width:20%">&nbsp;</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:ListView ID="lvProducts2" runat="server" DataSourceID="dataProducts2">
                        <LayoutTemplate>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr class="orig-tr-products">
                                <td class="desc" nowrap><%# getProductLink(getPartNum(Eval("Part_Wo_Gl").ToString())) %></td>
                                <td class="desc"><%# getProdName(getPartNum(Eval("Part_Wo_Gl").ToString())) %></td>
                                <td><%# string.Format("{0:MM/dd/yyyy}", Eval("Date_Added"))%></td>
                                <td><%# Eval("Expire").ToString()%></td>
                                <td><%# convertDate(getExpiryDate(Eval("Expire").ToString(), Eval("Date_Added").ToString())) %></td>
								<td><%# getTimeSpan(Eval("Expire").ToString(), Eval("Date_Added").ToString()) %></td>
								<td><a class="viewOrderBtn" data-so='<%#Eval("So_Nbr").ToString()%>'>View Order</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<%# checkProduct(getPartNum(Eval("Part_Wo_Gl").ToString())) %></td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate>
							<tr>
								<td colspan="10" style="text-align:center">No expiring standards found.</td>
							</tr>
                        </EmptyDataTemplate>
                    </asp:ListView> 
                </tbody>
            </table>
            <asp:DataPager ID="ProductListPagerSimple3" ClientIDMode="Static" runat="server" PagedControlID="lvProducts2" PageSize="25" QueryStringField="expiring_standards">
                <Fields>
                    <asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="true" RenderDisabledButtonsAsLabels="true" FirstPageText="&lt;&lt;" PreviousPageText="&lt;" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
                    <asp:NumericPagerField RenderNonBreakingSpacesBetweenControls="false" />
                    <asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="true" RenderDisabledButtonsAsLabels="true" LastPageText="&gt;&gt;" NextPageText="&gt;" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
                </Fields>
            </asp:DataPager>
		</div>
		
		<a class='viewOrder' href="#viewOrderBox" style="display:none">Show Order</div>
		<div style="display:none">
			<div id="viewOrderBox">
				
			</div>
		</div>
    </div>
	</div>
	<asp:SqlDataSource ID='dataNews' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
		SelectCommand="SELECT TOP 6 id, title FROM news WHERE category IN ('8') AND active = '1' ORDER BY posteddate DESC" SelectCommandType="Text">
	</asp:SqlDataSource> 
    <asp:SqlDataSource ID='dataTechnique' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT * FROM cp_roi_Families WHERE cfTypeID = 2 ORDER BY cfFamily" SelectCommandType="Text">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataCategory' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT DISTINCT ccID, ccCategory FROM cp_roi_Cats WHERE ccFamilyID = @Family ORDER BY ccCategory" SelectCommandType="Text">
        <SelectParameters>
            <asp:QueryStringParameter Name="Family" Type="Int32" DefaultValue="1" QueryStringField="cat" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataProducts' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>" SelectCommandType="Text">
    </asp:SqlDataSource>
	<asp:SqlDataSource ID='dataProducts2' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommandType="Text" onselected="dataProducts2_Selected">
    </asp:SqlDataSource>
	<asp:SqlDataSource ID='dataProducts3' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommandType="Text" >
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script src="/js/jquery-ui.js" type="text/javascript"></script>
	<script src="/js/jquery.tablesorter.min.js" type="text/javascript"></script>	
    <script type="text/javascript">
        $(document).ready(function () {
			$(".tablesorter tr:odd").addClass("odd");
			
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
				alert("Product " + prodID + " is not available.");
			});
			
			$(".viewOrder").fancybox();
			
			$(".viewOrderBtn").click(function(){
				var part = $(this).attr('data-so');
				/*$.ajax({
					url: 'default.aspx/getViewOrder',
					type: "POST",
					data: JSON.stringify({ id: part }),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						$('#viewOrderBox').html(data.d);
						$(".viewOrder").trigger("click");
					}
				});*/
				location.replace("/customer-center/order-summary/default.aspx?id=" +part);
			});
			
			$(".tabselector").click(function(){
				var id = $(this).data("id");
				$(".tab").fadeOut("fast");
				$("#" + id).fadeIn("slow");
				$(".tabselector").each(function() {
					$(this).removeClass("selected");
				});
				$(this).addClass("selected");
			});
			
			$(".order-tabselector").click(function(){
				var id = $(this).data("id");
				$(".order-tab").fadeOut("fast");
				$("#" + id).fadeIn("slow");
				$(".order-tabselector").each(function() {
					$(this).removeClass("selected");
				});
				$(this).addClass("selected");
			});
			
			var page = location.search;
			if (page.indexOf("order_history") > 0) {
				toggleTabs("order_history");
			}else if (page.indexOf("expiring_standards") > 0) {
				toggleTabs("expiring_standards");
			}
        });
		
		function toggleTabs(tab) {
			$(".tab").hide();
			$("#" + tab).show();
			
			$(".tabselector").each(function() {
				$(this).removeClass("selected");
			});
			$(".tabselector").each(function() {
				var id = $(this).data("id"); 
				if (id == tab) {
					$(this).addClass("selected");
				}
			});
		}
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

