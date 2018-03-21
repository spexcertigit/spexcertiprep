<%@ Page Title="Loyal Customer Rewards" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="loyal_customer_reward" Debug="True"%>

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
								<li><a href="/customer-center/previous-orders/">Previous Orders</a></li>
								<li><a href="/customer-center/current-orders/">Current Orders</a></li>
								<li><a href="/customer-center/order-summary/">Order Summary</a></li>
								<li><a href="/customer-center/order-details/">Order Details</a></li>
								<li><a class="selected">Loyal Customer Rewards</a></li>
							</ul>
						</div>
					</div>
					 
				</div>	
				<div class="c66r ">
    			    <div style="">
						<div id="cc-p">		
							<h2 class="ccClient">Hello, <%=DisplayName%>!</h2>
							<p>Welcome to our Customer Center page. Proin gravida nibh vel velit auctor aliquet. Aenean sollicitudin, lorem quis bibendum autor, nisi elit consequat ipsum, nec sagittis sem nibh id elit.</p>
						</div> 											
    			    </div>
    		    </div>	
            </div>
    <div id="resultstable" style="margin-top:3em">
		<!--<div style="text-align: right; margin: 1.5em 0 0;">-->
		<div class="pagers1_wrapper">									
			<div style="clear:both"></div>
		</div>
		<div>
		<h2 class="cc">Loyal Customer Rewards</h2></div>
		<div class="tab" style="margin:2em 0 6em;display:block"> 
			<div id="web-freq-orders" class="freqOrderTabs">
				<table width="958" class="tablesorter cc" align="center" >
					<thead>
						<tr>
							
							<th>BillToAccount Number</th>
							<th>Customer Name</th>
							<th>Available SPoints</th>
							
							
						</tr>
					</thead>
					<tbody>
								<tr class="webUser">
									<td><asp:Label id="bill" runat="server"></asp:Label></td>
									<td><asp:Label id="name" runat="server"></asp:Label></td>
									<td><asp:Label id="spoint" runat="server"></asp:Label></td>
								</tr>
					</tbody>
				</table>
			</div>
			
			
		</div>
		
	</div>
</asp:Content>
	


