<%@ Page Title="Organic Standards for Wine - SPEX CertiPrep" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="search" %>

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
    

		
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="default.aspx">Home</a> > Products > Analytical Standards for Wine</asp:Content>
<asp:Content ID="ContentHeader" ContentPlaceHolderID="cpPageBanner" Runat="Server">
	<div id="banner-div" class="wine">
		<!--<img class="category-banner-img" src="img/category-wine-banner.png" alt="Organic Wine Standards"/>-->
		<div class="banner-label-wrapper">
			<!--<img class="banner-label" src="img/banner-wine-label.png">-->
			<h1 class="banner-header wine">Analytical Standards <br />for Wine</h1>
			<img class="banner-image-right" src="img/banner-image-right-wine2.png">
		</div>
		<img class="m320-category-banner-img" style="box-shadow:none" src="img/category-wine-banner-480.png" alt="Organic Wine Standards">
		<img class="m480-category-banner-img" style="box-shadow:none" src="img/category-wine-banner-480.png" alt="Organic Wine Standards">
		<img class="m768-category-banner-img" style="box-shadow:none" src="img/category-wine-banner-768.png" alt="Organic Wine Standards">
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
		
    	<div id="main" style="margin-bottom:6em">
            <div class="subcolumns">			
				<div class="c30l">
					<div class="side-module">
						<h2 id="updates">Latest Wine Updates</h2>
						<div class="organic-side">
							<ul>
								<li><a href="/news-and-events/news.aspx?id=102">SPEX CertiPrep Wine Webinar Video and Slides</a></li>
								<li><a href="/news-and-events/news.aspx?id=147">The Chemistry of Red Wine: pH, SO2 & Phenolics</a></li>
							</ul>
						</div>
					</div>
					 
					<div class="side-module">
						<h2 id="updates">Product Flyers</h2>
						<div class="organic-side">
							<ul class="flyers">
								<li class="pdf_dl"><a href="/knowledge-base/catalogs/Wine.pdf" target="_blank">Wine Certified Reference Materials</a></li>
								<li class="pdf_dl"><a href="/uploads/Chemistry%20COLOR%20of%20wine%20%20ACS%20webinar%201-10-13.pdf" target="_blank">A Toast to the Chemistry of Noble Grapes</a></li>
								<li class="pdf_dl"><a href="/uploads/Comprehensive_Analysis_of_Wine.pdf" target="_blank">Comprehensive Analysis of Wine from Test to Taste</a></li>
							</ul>
						</div>
					</div>
					
					<!--Newsletter Module
					<div class="newsletter-side" style="margin-top:30px;">
						<div class="newsletter-inner-wrapper">
							<h3>Newsletter Signup</h3>
							<div class="type-text-nl">
								<asp:TextBox ID="name2" runat="server" MaxLength="100" placeholder="Enter your Name" />
							</div>
							<div class="type-text-nl">
								<input name="ea" placeholder="Enter your email address" type="text" value="" id="email" />
							</div>
							<center>
								<asp:button id="newletter_submit" name="newletter_submit" CssClass="mobile_newsl_btn" postbackurl="http://visitor.constantcontact.com/d.jsp" runat="Server" style="margin-top: 12px;margin-left: -6px;background: url(/images/subscribebutton.png) no-repeat;width: 243px;height: 45px;border: 0;cursor:pointer;"></asp:button>
								<input name="m" value="1101976134161" type="hidden" />
								<input name="p" value="oi" type="hidden" />
							</center>
						</div>	
					</div>
					<!--EOF Newsletter Module-->
				</div>	
				<div class="c66r ">
    			    <div style="">
						<div id="banner-p">		
							<p>SPEX CertiPrep provides the wine industry with a comprehensive list of certified standards designed to help regulate the chemical interactions that play key roles in wine spoilage such as cork taintage. Our standards for wine are manufactured from the highest purity starting materials and the highest grade of solvents available to guarantee superior grade standards. Custom wine standards are also available.</p>
							<p>We offer standards for wine for:</p>
							<p>
								<ul>
									<li>Pesticide contamination from wine grapes</li>
									<li>Cork taint analysis</li>
									<li>Wine faults/ wine contamination</li>
									<li>Components of wine</li>
									<li>Alcohol determination (% alcohol)</li>
								</ul>
							</p>
							<p>Standards manufactured for use with:</p>
							<p>
								<ul>
									<li>GC</li>
									<li>GC/MS</li>
									<li>HPLC</li>
									<li>LC/MS</li>
								</ul>
							</p>
							<div class="webi">
								<div class="vid-container">
									<iframe allowfullscreen="" frameborder="0" height="390" src="//www.youtube.com/embed/6Mc-8PCfVpI" width="100%"></iframe>
								</div>
							</div>
						</div> 											
    			    </div>
					
					
					
					<%--<div id="promotion">
						<img class="promoTag" src="/images/banners/banner-promotion.png" />
						<span class="promoText">
							<h2>Organic Wine Standards Products Promotion</h2>
							<p>Save 20% on your next wine online order of $150 or more with promo code <b><asp:Label id="lblPromoCode1" runat="server" Text=""></asp:Label></b>.</p>
							<p>Minimum order amount is $150. Must enter or mention promo code 
								<b>
									<asp:Label id="lblPromoCode2" runat="server" Text="">
									</asp:Label>
								</b> 
								when ordering. Offer expires 
								<asp:Label id="lblPromoExpiration" runat="server" Text="">
								</asp:Label>. 
								Valid on direct, US orders only. Not valid with any other promotion.
							</p>
						</span>
						<div class="c20l left" style="position:relative;">
							<a href="#promo">
								<img src="img/winepromo.png" height="181" width="181" alt="Save 20% on your next wine online order of $150 or more." style="z-index: 1; position: absolute; left: 370px; top: 107px; "/>
							</a>
						</div>
					</div>--%>
					
    		    </div>	
            </div>

            <div id="resultstable">


                <div class="productcontent" id="productcontent_Product">


                    <div style="margin:0 0 2em">
                        <h2>Standards for Wine</h2>
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
											GetConcentrationInorg(Eval("partnumber").ToString())+"<a href='javascript:void()' class='various_cascon' data-partnum='"+
											Eval("partnumber")+"'><img src='/images/modal-tooltip.png' /></a></td>" : "<td>"+ 
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

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script src="/js/jquery-ui.js" type="text/javascript"></script>
	<script src="/js/jquery.tablesorter.min.js" type="text/javascript"></script>		
    <script type="text/javascript">
        $(document).ready(function () {
            $(".tablesorter tr:odd").addClass("odd");
            // Dropdown Change
	        try {
				$("#application").msDropDown();
			} catch (e) {
				alert(e.message);
			}
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
			var subcolumnWidth = $(".subcolumns").width();
			if (subcolumnWidth <= 600) {
				$(".c66r").after($(".c30l"));
			}
			$('#banner-div').show();
		}); 				
    </script>
	<script type="text/javascript">
		$(document).ready(function(){
			$('a[href^=#]').click(function(event){		
				event.preventDefault();
				$('html,body').animate({scrollTop:$(this.hash).offset().top}, 2000);
			});
		});
	</script>
	<!-- Wine Analysis list -->
	<script type="text/javascript">
	/* <![CDATA[ */
	var google_conversion_id = 1051567786;
	var google_conversion_language = "en";
	var google_conversion_format = "3";
	var google_conversion_color = "ffffff";
	var google_conversion_label = "XNVTCKSQgQMQqs229QM";
	var google_conversion_value = 0;
	/* ]]> */
	</script>
	<script type="text/javascript" src="http://www.googleadservices.com/pagead/conversion.js">
	</script>
	<noscript>
	<div style="display:inline;">
	<img height="1" width="1" style="border-style:none;" alt="" src="http://www.googleadservices.com/pagead/conversion/1051567786/?value=0&amp;label=XNVTCKSQgQMQqs229QM&amp;guid=ON&amp;script=0"/>
	</div>
	</noscript>

</asp:Content>

