<%@ Page Title="Spectroscopy | SPEX CertiPrep" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="spectroscopy.cs" Inherits="thank_you" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
	<style>
		#breadcrumb { display:none; }
		.banner-label-wrapper { text-align: center; padding: 25px 0; }
		#main h1 { font-size: 21px; margin-bottom: 20px;}
		.gray-specs {
			background: #898989;
			color:#fff;
			padding-top: 20px;
			margin-bottom:40px; 
		}
		ul {
			padding: 0;
		}
		ul li {
			list-style:none; 
		}
		#resultstable { min-height: 0px;}
		.tablesorter {
			border:1px solid #727272;
		}
		.tablesorter thead > tr, th, td { border: none;}
	</style>
</asp:Content>
<asp:Content ID="ContentBanner" ContentPlaceHolderID="cpPageBanner" Runat="Server">
	<div id="banner-div" class="spectroscopy">
		<div class="banner-label-wrapper">
			<img src="/knowledge-base/images/Spectroscopy-Header.jpg" alt="spectroscopy-header" />
		</div>
	</div>	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="main">
				<h1>Heavy Metals and Minerals Testing Kits</h1>
				<p>
				Heavy Metals and Minerals Testing Kits are designed for routinely analyzed heavy metals and minerals. All kits come with six, 30 mL ICP-MS standards which includes a nitric acid blank for easy dilution. 
				</p>
				<p>Conveniently packaged in a sturdy, heavy-duty carton, these kits are perfect to store on a lab bench or in a cabinet. The 30 mL ICP-MS standards ship non-hazardous, saving money on shipping costs. The smaller volume also allows for less hazardous waste should the standard expire before its contents are used.</p>
				<div class="gray-specs text-center">
					<span style="font-weight:bold">30 mL Standards Help Decrease Your Waste and Save Your Space!</span>
					<br /><br />
					<div class="row">
						<div class="col-md-6 text-left">
							<ul style="padding-left:80px;">
								<li>- No Excess to toss</li>
								<li>- Volume accommodates infrequent analysis</li>
								<li>- 1/3 the price of larger volume standards</li>
								<li>- No hazardous shipping or disposal fees</li>
							</ul>
						</div>
						<div class="col-md-6 text-left">
							<ul style="padding-right:80px;">
								<li>- Hazardous goods in excepted quantities</li>
								<li>- Ease of shipping</li>
								<li>- Custom packaging</li>
							</ul>
						</div>
					</div>
				</div>
				<div id="resultstable">
					<div class="productcontent" id="productcontent_Product">
						<div style="margin:0 0 2em">
							<table id="ts1" style="width:100%" class="tablesorter">
								<thead>
									<tr>
										<th scope="col" class="header sorter"  nowrap>Part #</th>
										<th scope="col" class="header sorter">Product Name</th>
										<th scope="col" class="header sorter">Conc.</th>
										<th scope="col" class="">Volume</th>
										<th scope="col" >Unit/Pk</th>
										<th scope="col" class="">Price</th>
										<th scope="col" >Add to Cart</th>
									</tr>
								</thead>
								<tbody>
									<asp:ListView ID="lvProductsInorg1" runat="server" DataSourceID="dataKits">
										<LayoutTemplate>
											<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
										</LayoutTemplate>
										<ItemTemplate>
											<tr>
												<td class="desc"><b><a href='/products/product_inorganic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("partnumber") %></a></b></td>
												<td class="desc"><b><a href='/products/product_inorganic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("title") %></a></b></td>
												<!--Concentration-->
												<td>1,000 &mu;g/mL</td
												<!--EOF Concentration-->
												<td style="text-align:right;white-space:nowrap;"><%# Eval("Volume") %></td>
												<td style="text-align:center;white-space:nowrap;"><%# Eval("UnitPack") %></td>
												<td style="text-align:right;white-space:nowrap;"><%# GetPrice(Eval("partnumber").ToString())%></td>
												<td class="buybutton" style="white-space:nowrap;">
													<input name='quantity_<%# Eval("partnumber") %>' type="text" id='quantity_<%# Eval("partnumber") %>' class="search_quantity" value="1" /><input type="button" id='buy_<%# Eval("partnumber") %>' name='buy_<%# Eval("partnumber") %>' value="" class="search_buy" onclick="buyIt('<%# Eval("partnumber") %>');" />
												</td>
											</tr>
										</ItemTemplate>
									</asp:ListView> 
								</tbody>
							</table>
						</div>
					 </div>
				</div>
				<p>For additional ICP and ICP-MS 30 ml Plasma Shots&reg; <a href="/30mL-plasma-shots/">click here.</a></p><br /><br /><br />
            </div>
			
	<asp:SqlDataSource ID='dataKits' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommandType="Text">
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="cphBotBanner" Runat="Server">	
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script src="/js/jquery.tablesorter.min.js" type="text/javascript"></script>	
	<script type="text/javascript">
		$(document).ready(function () {
            $(".tablesorter tr:odd").addClass("odd");
		});
		function buyIt(productid) {
            theQuantity = document.getElementById("quantity_" + productid).value;
            if(theQuantity == '' || theQuantity == '0' ) {
            	alert('Quantity must be greater than 0');
            	return false;
            }
            $("#footer_cart").load("/utility/addtocart.aspx?productid=" + productid + "&pq=" + theQuantity, function () {
                //$("#totalitems").effect("highlight", { color: "#ffffff" }, 5000);
                $("#totalcost").effect("highlight", { color: "#ffffff" }, 5000);
                $("#totalsavings").effect("highlight", { color: "#ffffff" }, 5000);
            });
            //document.getElementById("buy_"+productid).value=" - ";
            $("#buy_" + productid).removeClass("search_buy");
            $("#buy_" + productid).addClass("search_buy_clicked");
            //$("#buy_" + productid).effect("highlight", { color: "#ffffff" }, 1000);
        }
	</script>
</asp:Content>


