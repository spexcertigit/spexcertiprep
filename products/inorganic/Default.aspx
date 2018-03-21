<%@ Page Title="Inorganic Certified Reference Materials - SPEX CertiPrep" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="search" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
	<meta name="description" content="SPEX CertiPrep provides a large selection of Inorganic Certified Reference Materials (CRMs). Inorganic Standards available include ICP Standards, ICP-MS Standards, IC Standards, Fusion Fluxes and Additives.  SPEX also provides Organometallic Oil Standards, Consumer Safety Standards, and Speciation Standards.  Can't find the exact mix for your needs? Custom product are also available. 99% of Stock orders ship within 24 hours." />
	<style type="text/css">
	#breadcrumb {padding:0;}
    a.aspNetDisabled { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
	a.aspNetDisabled:hover { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
	#ProductListPagerSimple span,
	#ProductListPagerSimple2 span { font-weight:bold; }
	h1 {color: #94A232;font-size: 2.34em;font-weight: bold;margin:0 0 10px}
	#main h2 {color: #5a5b5d;font-size: 1.34em;font-weight: bold;margin:0 0 5px}
	.c20l a {text-decoration:none}
	.c20l p {line-height:1em}
	p {font-size:1.14em;}
	.catImg
	{
		float:left; 
		padding-right:0.5em;
	}
	.twoColUL ul li
	{
		overflow:hidden;
		padding-left:2em;
		font-size:1.15em;
	}
	.categorySectionOdd
	{
		background-color: ghostwhite;
		padding: 10px;
	}
	.categorySectionOdd p
	{
		overflow: hidden;
	}
	.categorySectionEven
	{
		background-color: none;
		padding: 10px;
	}
	.categorySectionEven p
	{
		overflow: hidden;
	}
	#resultstable {
		position: absolute;
		right:0;
	}
	.categorySectionOdd {
		position: relative;
		height: 589px;
		background: transparent !important;
	}
	.banner-div,.banner-div img{width:100%;}
	.tablesorter{width:100%;}
	#table-img .table-img-con{width: 100%;float: left;border: 1px solid #d4d4d4;padding: 2.5%;margin: 1.5% 0;}
	#table-img div.table-img-con img{margin-bottom: 10px;box-shadow: 0px 5px 5px #888888;}
	#table-img div.table-img-con .c63l b{
		font-size: 16px;
		font-weight: bold;
		margin-bottom: 10px;
		float: left;
		text-align: left;
		width:60%;
		color: #1A1A1A;
	}
	#table-img div.table-img-con .c63l a{font-size: 16px;text-align: right;float: right;text-decoration: none;}
	.c63l p{clear:both;}
	.twoColUL li a,.c63l p a{float:none!important;}
	.c63l,.c37l{float:left;}
	.c63l{width:63%;}
	.c37l{width:37%;}
	thead th{background:#94A232 !important;}	
	#banner-div.inorganic div.banner-label-wrapper img.banner-image-right {
		height: 192px;
	}
    </style>
    
	
	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="default.aspx">Home</a> > Products > Inorganic Certified Reference Materials</asp:Content>
<asp:Content ID="ContentHeader" ContentPlaceHolderID="cpPageBanner" Runat="Server">
	<div id="banner-div" class="inorganic" >
		<div class="banner-label-wrapper">
			<h1 class="banner-header inorganic">Inorganic Certified <br />Reference Materials</h1>
			<img class="banner-image-right" src="img/banner-image-right-inorganic.png">
		</div>
		<img class="m768-category-banner-img" src="img/banner-inorganic-768.png" alt="Inorganic Certified Reference Materials" />
		<img class="m480-category-banner-img" src="img/banner-inorganic-480.png" alt="Inorganic Certified Reference Materials" />
		<img class="m320-category-banner-img" src="img/banner-inorganic-480.png" alt="Inorganic Certified Reference Materials" />
		<div class="banner-shadow"></div>
	</div>	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">

        <div id="main" style="margin-bottom:6em">

    		
            <div class="subcolumns">
				
				
				<div class="c30l">			
				
					<div class="side-module">
						<h2 id="updates">Product Flyers</h2>
						<div class="organic-side">
							<ul class="flyers">
								<asp:ListView ID="lvProdLit" runat="server" DataSourceID="dataProdLit">
									<LayoutTemplate>
										<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
									</LayoutTemplate>
									<ItemTemplate>
										<li class="pdf_dl"><a href="/knowledge-base/catalogs/<%# Eval("LitFile")%>" target="_blank"><%# Eval("LitName")%></a></li>
									</ItemTemplate>
									<EmptyDataTemplate>
										<li><h3>There are no product literature on this category.</h3></li>
									</EmptyDataTemplate>
								</asp:ListView> 
							</ul>
						</div>
					</div>
				
					<!--Newsletter Module-->
					<!-- <div class="newsletter-side" style="margin-top:30px;">
						<div class="newsletter-inner-wrapper">
							<h3>Newsletter Signup</h3>
							<div class="type-text-nl">
								<asp:TextBox ID="name2" runat="server" MaxLength="100" placeholder="Enter your Name" />
							</div>
							<div class="type-text-nl">
								<input name="ea" placeholder="Enter your email address" type="text" value="" id="email" />
							</div>								
							<center>
								<asp:button id="newsletter_submit" name="newsletter_submit"
										  CssClass="mobile_newsl_btn"
										  postbackurl="http://visitor.constantcontact.com/d.jsp" 
										  runat="Server" style="margin-top: 12px;margin-left: -6px;background: url(/images/subscribebutton.png) no-repeat;width: 243px;height: 45px;border: 0;cursor:pointer;">
										</asp:button>
								<input name="m" value="1101976134161" type="hidden" />
								<input name="p" value="oi" type="hidden" />
							</center>
						</div>	
					</div> -->
					<!--EOF Newsletter Module-->
				
				</div>
				
    		    <div class="c66r" id="main_page">
				
					<div>
						<div id="banner-p">	
							<h2 class="mainH2">Elemental Analysis</h2>
							<div style="font-size:1.15em;">
								SPEX CertiPrep offers a full range of Inorganic Certified Reference Materials (CRM). 
								<a href="http://www.spexcertiprep.com/products/custom-standards_inorganic.aspx">Custom Inorganic standards</a> 
								are also available.
							</div>
							<br />
							<ul style="font-size:1.15em;">
								<li>99% of stock orders ship within 24 hours</li>
								<li>New Inorganic Multi-Element Standards for the latest EPA methods</li>
								<li>Custom standards manufactured and shipped within 5 business days</li>
								<li>Dedicated technical support to answer your CRM and lab questions</li>
							</ul>
						</div>
						
					</div>
				
					<%--<div id="promotion" class="inorganicpromo">
						<img class="promoTag" src="../../images/banners/banner-promotion.png" />
						<span class="promoText">
							<h2>Inorganic Product Promotion</h2>
							<p>Save 15% when you enter promo code <b><asp:Label id="lblPromoCode1" runat="server" Text=""></asp:Label></b> on your next Inorganic online order of $100 or more.</p>
                            <p>
								Promo code valid on Inorganic products only. Minimum order amount is $100. Must enter or mention promo code 
								<strong><asp:Label id="lblPromoCode2" runat="server" Text=""></asp:Label></strong>
								when ordering. Offer expires <asp:Label id="lblPromoExpiration" runat="server" Text=""></asp:Label>. Valid on direct, US orders only. Not valid with any other promotions. One per customer.
							</p>
						</span>
					</div>--%>
					
					
					
    			    <div class="table-content">
						<b style="margin-bottom: 2%;float: left;">Comparison of Assurance (ICP) and Claritas (ICP-MS) Standards</b>
						<br>
						<table class="tablesorter">
    
                            <thead>
                                <tr>
                                    <th scope="col" class="header greenBg" >&nbsp;</th>
                                    <th scope="col" class="header greenBg" style="text-align:center;"><img src="img/Assurance_Yellow_small.jpg" alt="Assurance <sup>&reg;</sup> Standards" height="25px" width="135px"/></th>
                                    <th scope="col" class="header greenBg" style="text-align:center;"><img src="img/ClaritasPPT_Logo_small.jpg" alt="Claritas PPT <sup>&reg;</sup> Standards" height="25px" width="135px"/></th>
                                </tr>
                            </thead>
                            <tbody>
                                
                                                
                                        <tr>
                                            <td class="desc">Designed for Use With</td>
                                            <td style="text-align:center;white-space:nowrap;">AA / ICP</td>
                                            <td style="text-align:center;white-space:nowrap;">ICP / ICP-MS</td>
                                        </tr>
                                    
                                          <tr>
                                            <td class="desc">Analytical Range for Use</td>
                                            <td style="text-align:center;white-space:nowrap;">PPM, PPB</td>
                                            <td style="text-align:center;white-space:nowrap;">PPB, PPT</td>
                                        </tr>
									 
                                        <tr>
                                            <td class="desc">Single Standards</td>
                                            <td style="text-align:center;white-space:nowrap;"><span class="checkMark">&#10004;</span></td>
                                            <td style="text-align:center;white-space:nowrap;"><span class="checkMark">&#10004;</span></td>
                                        </tr>
                                        <tr>
                                            <td class="desc" style="text-align:center;white-space:nowrap;">1 mg/L</td>
                                            <td style="text-align:center;white-space:nowrap;"></td>
                                            <td style="text-align:center;white-space:nowrap;"><span class="checkMark">&#10004;</span></td>
                                        </tr>
                                        <tr>
                                            <td class="desc" style="text-align:center;white-space:nowrap;">10  mg/L</td>
                                            <td style="text-align:center;white-space:nowrap;"></td>
                                            <td style="text-align:center;white-space:nowrap;"><span class="checkMark">&#10004;</span></td>
                                        </tr>
                                        <tr>
                                            <td class="desc" style="text-align:center;white-space:nowrap;">1,000  mg/L</td>
                                            <td style="text-align:center;white-space:nowrap;"><span class="checkMark">&#10004;</span></td>
                                            <td style="text-align:center;white-space:nowrap;"><span class="checkMark">&#10004;</span></td>
                                        </tr>
                                        <tr>
                                            <td class="desc" style="text-align:center;white-space:nowrap;">10,000  mg/L</td>
                                            <td style="text-align:center;white-space:nowrap;"><span class="checkMark">&#10004;</span></td>
                                            <td style="text-align:center;white-space:nowrap;"></td>
                                        </tr>
                                        <tr>
                                            <td class="desc">Multi-Element Standards</td>
                                            <td style="text-align:center;white-space:nowrap;"><span class="checkMark">&#10004;</span></td>
                                            <td style="text-align:center;white-space:nowrap;"><span class="checkMark">&#10004;</span></td>
                                        </tr>
                                        <tr>
                                            <td class="desc">Custom Standards</td>
                                            <td style="text-align:center;white-space:nowrap;"><span class="checkMark">&#10004;</span></td>
                                            <td style="text-align:center;white-space:nowrap;"><span class="checkMark">&#10004;</span></td>
                                        </tr>
                                        <tr class="greenBg" style="background-color:#94A232;color:#FFFFFF;height:42px;">
                                            <td class="desc">Certifications</td>
                                            <td style="text-align:center;white-space:nowrap;border: 0;"></td>
                                            <td style="text-align:center;white-space:nowrap;border: 0;"></td>
                                        </tr>

                                        <tr>
                                            <td class="desc">ISO 9001:2008</td>
                                            <td style="text-align:center;white-space:nowrap;"><span class="checkMark">&#10004;</span></td>
                                            <td style="text-align:center;white-space:nowrap;"><span class="checkMark">&#10004;</span></td>
                                        </tr>
                                        <tr>
                                            <td class="desc">ISO 17025:2005</td>
                                            <td style="text-align:center;white-space:nowrap;"><span class="checkMark">&#10004;</span></td>
                                            <td style="text-align:center;white-space:nowrap;"><span class="checkMark">&#10004;</span></td>
                                        </tr>
                                        <tr>
                                            <td class="desc">ISO Guide 34</td>
                                            <td style="text-align:center;white-space:nowrap;"><span class="checkMark">&#10004;</span></td>
                                            <td style="text-align:center;white-space:nowrap;"><span class="checkMark">&#10004;</span></td>
                                        </tr>


                                        <tr class="greenBg" style="background-color:#94A232;color:#FFFFFF;height:42px;">
                                            <td class="desc">Quality:</td>
                                            <td style="text-align:center;white-space:nowrap;border: 0;"></td>
                                            <td style="text-align:center;white-space:nowrap;border: 0;"></td>
                                        </tr>

                                        <tr>
                                            <td class="desc">Traceable by NIST SRM</td>
                                            <td style="text-align:center;white-space:nowrap;"><span class="checkMark">&#10004;</span></td>
                                            <td style="text-align:center;white-space:nowrap;"><span class="checkMark">&#10004;</span></td>
                                        </tr>
                                        <tr>
                                            <td class="desc">Acid Grade</td>
                                            <td style="text-align:center;white-space:nowrap;">High Purity</td>
                                            <td style="text-align:center;white-space:nowrap;">Ultra High Purity</td>
                                        </tr>
                                        <tr>
                                            <td class="desc"># Trace Impurities Measured on<br/>Certificate of Analysis</td>
                                            <td style="text-align:center;white-space:nowrap;">68</td>
                                            <td style="text-align:center;white-space:nowrap;">68</td>
                                        </tr>
                                        <tr>
                                            <td class="desc">Trace Impurities Measured to</td>
                                            <td style="text-align:center;white-space:nowrap;">&micro;g/L</td>
                                            <td style="text-align:center;white-space:nowrap;">&micro;g/L</td>
                                        </tr>



                            </tbody>
                        </table>
                      

                  
						
					</div>
					
					<div>
					
						<h2>ICP</h2>

						<p style="line-height:150%;"><a href="/search_inorganic_category.aspx?cat=1">AA and ICP-AES Assurance<sup>&reg;</sup> Grade CRMs</a> are available in single and multi-element formulations. Over 70 single-element standards are available at 1,000 and/or 10,000 ppm.  Multi-element standards include: calibration test solutions, instrument performance standards, drinking water metals, and interference check standards. <a href="/products/custom-standards_inorganic.aspx">Custom blends</a> can be manufactured upon request.</p>

    				    <h2>ICP-MS</h2>

						<p style="line-height:150%;"><a href="/search_inorganic_category.aspx?cat=3">ICP-MS Claritas PPT<sup>&reg;</sup> Grade CRMs</a> are designed for ICP-MS and can also be used in ICP-OES analysis. They are available in single and multi-element solutions. The standards are at 1 or 1,000 ppm and packaged in 125 mL bottles to minimize contamination. They are made using high purity acids, the highest grade starting materials, and a high purity water to minimize contaminants. A one step dilution to PPB levels reduces dilution errors.</p>
						
						<h2>Testing Kits</h2>

						<p style="line-height:150%;"><a href="/testing-kits">Heavy Metals and Minerals Testing Kits</a> designed for routinely analyzed heavy metals and minerals. All kits come with six, 30 mL standards which includes a nitric acid blank for easy dilution. Conveniently packaged in a sturdy, heavy-duty carton, these kits are perfect to store on a lab bench or in a cabinet. The 30 mL standards ship non-hazardous, saving money on shipping costs. The smaller volume also allows for less hazardous waste should the standard expire before its contents are used.</p>
					
					</div>
					
					<div id="table-img">
					
						<div class="table-img-con">
							<div class="c37l"><img src="img/environmental.jpg"/></div>
							<div class="c63l">
								<b>Ion Chromatography & ISE Standards</b>
								<a href="/search_inorganic_category.aspx?cat=4">[View Category]</a><br/>
								<p>Every <a href="/search_inorganic_category.aspx?cat=4">Ion Chromatography Standard</a> is prepared under our unique Triple Checked for Quality<sup>&reg;</sup> Assurance Program with all results reported on our SPEXCertificate<sup>&reg;</sup>. It features a full line of anion and cation single element standards available at 1000 ppm in 125 mL and 500 mL volumes.</p>
							</div>
						</div>
						
						<div class="table-img-con">
							<div class="c37l"><img src="img/fusionflux.jpg"/></div>
							<div class="c63l">
								<b>Fusion Fluxes & Additives</b>
								<a href="/search_inorganic_category.aspx?category=0&cat=7">[View Category]</a><br/>
								<p><a href="/search_inorganic_category.aspx?category=0&cat=7">Pure and Ultra-Pure Fusion Fluxes and Additives</a> are made from a "Micro Bead" formula to ensure the same ratio of components in each bead with no harmful dust to clog your instruments. Our Fusion Fluxes are pre-fused with additives for better accuracy. Density of 1.4 g/mL ensures flux is easier to handle and measure. Download our Fusion Flux & Addititves</a> brochure.</p><p>Not convinced our Fusion Flux will suit your needs? Visit <a href="http://www.SPEXFusionFlux.com">SPEXFusionFlux.com</a> and request your FREE sample today!</p>
							</div>
						</div>
						
						<div class="table-img-con">
						
							<div class="c37l"><img src="img/organo_metallic.jpg"/></div>
							<div class="c63l">
								<b>Organometallic Oil Standards</b>
								<a href="/search_inorganic_category.aspx?cat=6">[View Category]</a><br/>
								<p>Organometallic Oil Standards are offered with a choice of single element or multi-element blends. Whether you are testing engine oils via ICP-AES, RDE, DCP, AA or XRF, our standards are pure and accurate to suit your needs. We offer a choice of 37 single element standards at 1,000 and 5,000 &micro;g/g. Multi-element mixes of 5, 12, 21 and 23 elements are available and come in convenient 50 or 100 gram sizes. </p>
							</div>
						</div>
						
						<div class="table-img-con">
							<div class="c37l"><img src="img/speciation.jpg"/></div>
							<div class="c63l">
								<b>Speciation Standards</b>
								<a href="/searchinorganic.aspx?search=speciation">[View Category]</a><br/>
								<p>Speciation analysis covers many areas including environmental protection, and the food and drug administration. To analyze species in a sample requires certified reference materials for sample verification and method validation. Many speciation standards are available in today's market, but most of the speciation standards are not certified or analyzed with a state-of-art ICP-MS. SPEX CertiPrep is  proud to offer Inorganic single-element speciation standards analyzed by ICP-MS. </p>
							</div>
							
						</div>
						
						<div class="table-img-con">
							<div class="c37l"><img src="img/consumer_safety.jpg"/></div>
							<div class="c63l">
								<b>Consumer Safety Standards</b>
								<a href="/products/inorganic">[View Category]</a><br/>
								<p>New regulations are constantly enacted to protect consumers from a variety of potentially dangerous chemicals and elements. SPEX CertiPrep leads the CRM field with a full line of Consumer Safety Compliance Standards for a variety of testing regulations. These include:</p>
							
								<div>
									<div style="float:left; margin-right: 10%;">
										<ul class="twoColUL">
											<li><a href="/searchinorganic.aspx?search=cyani">Cyanide</a></li>
											<li><a href="/search_inorganic_category.aspx?category=51&cat=6">BioDiesel</a></li>
											<li><a href="/searchinorganic.aspx?search=rohs">RoHS/WEEE</a></li>

										</ul>   
									</div>
									
									<div>
										<ul class="twoColUL">
											<li><a href="/searchinorganic.aspx?search=tds">Conductivity</a></li>
											<li><a href="/searchinorganic.aspx?search=empt">CPSC Metals in Children's Toys</a></li>
											<li><a href="/products/USP/">USP &lt;232&gt; and &lt;233&gt;</a> testing for Pharmaceuticals</li>
										</ul>
									</div>
								</div>
							</div>
						</div>
						
						<div class="table-img-con">
							<div class="c37l"><img src="img/qc_samples.jpg"/></div>
							<div class="c63l">
								<b>Quality Control Samples</b>
								<a href="/searchinorganic.aspx?search=QC+Sample">[View Category]</a><br/>
								<p>We partner with ERA to offer <a href="/searchinorganic.aspx?search=QC+Sample">Quality Control Samples</a>. All of ERA's QC samples have been tested in-house with the USEPA, NIST, NELAC and ISO protocols to ensure accuracy, homogeneity and stability. </p>
							</div>
						</div>
					
					</div>
					
					<div style="clear:both; height:30px;"></div>
					<div id="print-page">
						Print this page
					</div>
					<div id="go-top">
						<a href="#top">Back to top &#9650;</a> 
					</div>
					<iframe name="print_frame" width="0" height="0' frameborder="0" src="about:blank"></iframe>
				</div>
			</div>
			
			<script type="application/ld+json">
				{
				 "@context": "http://schema.org",
				 "@type": "Enumeration",
				 "name": "Inorganic Certified Reference Materials",
				 "image": "http://www.spexcertiprep.com/products/inorganic/img/banner-image-right-inorganic.png",
				 "url": "http://www.spexcertiprep.com/products/inorganic/",
				 "description": "We create custom inorganic reference standards for inductively coupled plasma (ICP) & ICP mass spectrometry (ICP-MS). Request now!"
				}
			</script>
</div>
	<asp:SqlDataSource ID='dataNews' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
		SelectCommand="SELECT TOP 6 id, title FROM news WHERE category IN ('8') AND active = '1' ORDER BY posteddate DESC" SelectCommandType="Text">
	</asp:SqlDataSource> 
	<asp:SqlDataSource ID="dataProdLit" runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
		SelectCommand="SELECT * FROM cp_Product_Literature WHERE CategoryID = '4' ORDER BY id DESC" SelectCommandType="Text">
	</asp:SqlDataSource> 
    <asp:SqlDataSource ID='dataProducts' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommandType="Text">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataProductsInorg1' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommandType="Text">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataProductsInorg2' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommandType="Text">
    </asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script src="/js/jquery-ui.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".tablesorter tr:odd").addClass("odd");
            // Dropdown Change
	        try {
				$("#application").msDropDown();
			} catch (e) {
				alert(e.message);
			}
			$('#banner-div').show();
			
			$("#print-page").click(function() {
				var printDivCSS = new String ('<link href="/css/screen/content.css" rel="stylesheet" type="text/css" charset="utf-8" Runat="Server" media="print"/><link href="/css/screen/cssinorganic.css" rel="stylesheet" type="text/css" charset="utf-8" media="print" />');
				window.frames["print_frame"].document.body.innerHTML=printDivCSS + document.getElementById("main_page").innerHTML
				window.frames["print_frame"].window.focus()
				window.frames["print_frame"].window.print()
			});
        })
        function buyIt(productid) {
            theQuantity = document.getElementById("quantity_" + productid).value;
            $("span#footer_cart").load("/utility/addtocart.aspx?productid=" + productid + "&pq=" + theQuantity, function () {
                $("#totalitems").effect("highlight", { color: "#ffffff" }, 5000);
                $("#totalcost").effect("highlight", { color: "#ffffff" }, 5000);
                $("#totalsavings").effect("highlight", { color: "#ffffff" }, 5000);
            });
            //document.getElementById("buy_"+productid).value=" - ";
            $("#buy_" + productid).removeClass("search_buy");
            $("#buy_" + productid).addClass("search_buy_clicked");
            $("#buy_" + productid).effect("highlight", { color: "#ffffff" }, 1000);
        }
    </script>
	<script>
		$(function() {
			if (window.PIE) {
				$('#table-img div.table-img-con img').each(function() {
					PIE.attach(this);
				});
			}
			var subcolumnWidth = $(".subcolumns").width();
			if (subcolumnWidth <= 736) {
				$(".c66r").after($(".c30l"));
			}
		});
		$(document).ready(listenWidth);
		$(document).load($(window).bind("resize", listenWidth));

		function listenWidth( e ) {
			if($(window).width()<736)
			{
				$(".c30l").remove().insertAfter($(".c66r"));
			} else {
				$(".c30l").remove().insertBefore($(".c66r"));
			}
		}
	</script>
    <script type="text/javascript">
		$(document).ready(function(){
			$('a[href^=#]').click(function(event){		
				event.preventDefault();
				$('html,body').animate({scrollTop:$(this.hash).offset().top}, 2000);
			});
		});
	</script>
	<!-- USP List -->
	<script type="text/javascript">
	/* <![CDATA[ */
	var google_conversion_id = 1051567786;
	var google_conversion_label = "yETTCOzbwQQQqs229QM";
	var google_custom_params = window.google_tag_params;
	var google_remarketing_only = true;
	/* ]]> */
	</script>
	<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
	</script>
	<noscript>
	<div style="display:inline;">
	<img height="1" width="1" style="border-style:none;" alt="" src="//googleads.g.doubleclick.net/pagead/viewthroughconversion/1051567786/?value=0&amp;label=yETTCOzbwQQQqs229QM&amp;guid=ON&amp;script=0"/>
	</div>
	</noscript>

</asp:Content>

