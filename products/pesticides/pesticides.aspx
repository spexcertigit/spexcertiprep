<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="pesticides.aspx.cs" Inherits="search" debug="true"%>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <style type="text/css">
        a.aspNetDisabled { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        a.aspNetDisabled:hover { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        #ProductListPagerSimple span,
        #ProductListPagerSimple2 span { font-weight:bold; }
		h1 {color: #94A232;font-size: 2.34em;font-weight: bold;margin:0 0 10px}
		#main h2 {color: #5a5b5d;font-size: 1.34em;font-weight: bold;margin:0 0 5px}
		.c20l a {text-decoration:none}
		.c20l p {line-height:1em}
		p{font-size: 1.15em;}
		.content-updates {
		width: 80%;
		margin-left: 20%;
		}
		#cas-container-opacity #cas-container {height:auto;}
		#breadcrumb { padding:0; }
    </style>
    <script src="/js/jquery-ui.js" type="text/javascript"></script>
	<script src="/js/jquery.tablesorter.min.js" type="text/javascript"></script>		
    <script type="text/javascript">
        $(document).ready(function () {
            $(".tablesorter tr:odd").addClass("odd");
            // Dropdown Change
			//EOF Dropdown Change
			$(".various_cascon").click(function(){
				var part = $(this).attr('data-partnum');
				jQuery.ajax({
					url: 'Default.aspx/GetDataCAS',
					type: "POST",
					data: JSON.stringify({ partnumber: part }),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						jQuery('#cas-container .CAStable').html(data.d);
					}
				});
				$('#cas-container-opacity').show(500);
				$(".mask-layout").show();
				$(".mask-layout").css("height", $("body").height());
			});
			$(".close-x").click(function(){
				$('#method-container-opacity').hide();
				$('#cas-container-opacity').hide();
				$('.mask-layout').hide();
			});
        })
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
		$(document).ready(function() { 
			$(".tablesorter").tablesorter({
				headers: {
					3: {sorter: false}, 
					4: {sorter: false}, 
					5: {sorter: false},
					6: {sorter: false}, 
					7: {sorter: false}
				}
			});		
			
			$(document).ready(listenWidth);
			$(document).load($(window).bind("resize", listenWidth));

			function listenWidth( e ) {
				if($(window).width()<737)
				{
					$(".c30l").remove().insertAfter($(".c66r"));
				} else {
					$(".c30l").remove().insertBefore($(".c66r"));
				}
			}
			//alert($('#s_method').val());
			$('#s_method').change(function() {
				//alert($(this).val());
				location.replace('/products/pesticides/' + $(this).val());
			});
			
			$('#banner-div').show();
		}); 				
    </script>	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/">Home</a> > <a href="/products/pesticides">Pesticides Standards</a> > <a href="/products/pesticides/epa-methods">EPA Methods</a> > <asp:Literal ID="ltrBread" runat="server" /></asp:Content>
<asp:Content ID="ContentHeader" ContentPlaceHolderID="cpPageBanner" Runat="Server">
	<div id="banner-div" class="pesticides">
		<div class="banner-label-wrapper">
			<h1 class="banner-header pesticides"><asp:Literal ID="ltrH1" runat="server" /></h1>
		</div>
		<div class="banner-shadow"></div>
	</div>	
</asp:Content>
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
            <div class="subcolumns">			
				<div class="c30l">
					<div>
						<h2 id="updates">Methods</h2>
						<div class="pesticides-side">
							<asp:DropDownList ID="s_method" CssClass="select-tech" ClientIDMode="Static" DataSourceID="dataMethod" DataValueField="slug" DataTextField="slug" runat="server" AppendDataBoundItems="true" AutoPostBack="true" onselectedindexchanged="selectedChange">
									<asp:ListItem Value="0" Text="-- Select Method --" />
							</asp:DropDownList>
						</div>
					</div>
					
					<asp:Literal ID="ltrDL" runat="server" />
				</div>	
				<div class="c66r ">
    			    <div style="">
						<div id="banner-p">
							<p style="font-size:18px"><asp:Literal ID="ltrDesc" runat="server" /></p>
							<br>
							<p style="font-size:18px">If these products do not meet your exact specifications, please contact us for information on custom standards or click here to go to the custom standards request form:</p>
							<br>
							<p><a href="/products/custom-standards_organic.aspx"><img src="/cannabis/img/request-form.png" alt="" /></a></p>
						</div> 											
    			    </div>
    		    </div>	
            </div>

            <div id="resultstable">
                <div class="productcontent" id="productcontent_Product">
                    <div style="margin:1.5em 0 2em">
                        <h2></h2>
                        <table style="width:100%" class="tablesorter">
                            <thead>
                                <tr>
                                    <th scope="col" class="header sorter" nowrap>Part #</th>
                                    <th scope="col" class="header sorter">Product Name</th>
                                    <th scope="col" class="header sorter">Conc</th>
                                    <th scope="col" class="header">Matrix</th>
                                    <th scope="col" class="header">Volume</th>
                                    <th scope="col" >Unit/Pk</th>
                                    <th scope="col" class="header">Price</th>
                                    <th scope="col" >Add to Cart</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:ListView ID="lvProducts" runat="server" DataSourceID="dataProducts">
                                    <LayoutTemplate>
                                        <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td class="desc" nowrap><b><a href='/products/product_organic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("partnumber") %></a></b></td>
                                            <td class="desc"><b><a href='/products/product_organic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("title") %></a></b></td>
											<!--Concentration-->
											<%# (GetConcentrationInorg(Eval("partnumber").ToString()) == "Various") ? "<td style='white-space:nowrap;'>"+ 
											GetConcentrationInorg(Eval("partnumber").ToString())+"</td>" : "<td>"+ 
											GetConcentrationInorg(Eval("partnumber").ToString())+"</td>" %>
											<!--EOF Concentration-->
                                            <td><%# Eval("Matrix") %></td>
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
						
						<div id="mobile-tablesorter">
							<asp:ListView ID="lvProductsMobile" runat="server" DataSourceID="dataProducts">
								<LayoutTemplate>
									<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
								</LayoutTemplate>
								<ItemTemplate>
									<table class="mobile-result-table">
										<tr>
											<td colspan="4" class="fullTD">
												<a href='/products/product_organic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("title") %></a>
											</td>
										</tr>
										<tr>
											<td class="headerColumns" colspan='2'>Part #</td>
											<td colspan='2' class="topBorderTD">
												<a href='/products/product_organic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("partnumber") %></a>
											</td>
										</tr>
										<tr>
											<td class="headerColumns" colspan="2" style="width:35%">Concentration</td>
											<%# (GetConcentrationInorg(Eval("partnumber").ToString()) == "Various") ? "<td colspan='2' class='grayTD' style='white-space:nowrap;'>"+ 
											GetConcentrationInorg(Eval("partnumber").ToString())+"<img src='/images/modal-tooltip.png' /></td>" : "<td colspan='2' class='grayTD'>"+ 
											GetConcentrationInorg(Eval("partnumber").ToString())+"</td>" %>
										</tr>
										<tr>
											<td class="headerColumns" colspan='2'>Matrix</td>
											<td colspan='2'><%# Eval("Matrix") %></td>
										</tr>
										<tr>
											<td class="headerColumns" colspan='2'>Volume</td>
											<td colspan='2' class='grayTD'><%# Eval("Volume") %></td>
										</tr>
										<tr>
											<td class="headerColumns" colspan='2'>Unit/Pk</td>
											<td colspan='2'><%# Eval("UnitPack") %></td>
										</tr>
										<tr>
											<td class="headerColumns" colspan='2'>Price</td>
											<td colspan='2' class='grayTD'><%# GetPrice(Eval("partnumber").ToString())%></td>
										</tr>
										<tr>
											<td class="headerColumns" colspan='2'>Add to Cart</td>
											<td colspan="2" class="topBorderTD">
												<input name='quantity_<%# Eval("partnumber") %>' type="text" id='quantity_<%# Eval("partnumber") %>' class="search_quantity" value="1" /><input type="button" id='buy_<%# Eval("partnumber") %>' name='buy_<%# Eval("partnumber") %>' value="" class="search_buy" onclick="buyIt('<%# Eval("partnumber") %>');" />
											</td>
										</tr>
									</table>
								</ItemTemplate>
							</asp:ListView> 
						</div>
		            </div>
                 </div>
                <div class="productcontent hidden" id="productcontent_Accessory">
                </div>
                <div class="productcontent hidden" id="productcontent_Resources">
                </div>


		    </div>
			<div id="go-top">
				<a href="#top">Back to top &#9650;</a> 
			</div>
    	</div>

    <asp:SqlDataSource ID='dataProducts' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommandType="Text">
    </asp:SqlDataSource>
	<asp:SqlDataSource ID='dataMethod' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT * FROM certiPesticidesMethods ORDER BY id" SelectCommandType="Text">
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script type="text/javascript">
		$(document).ready(function(){
			$('a[href^=#]').click(function(event){		
				event.preventDefault();
				$('html,body').animate({scrollTop:$(this.hash).offset().top}, 2000);
			});
			
			
		});
	</script>
</asp:Content>

