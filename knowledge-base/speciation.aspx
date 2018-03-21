<%@ Page Title="Speciation Standards | SPEX CertiPrep" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="speciation.cs" Inherits="search" debug="true"%>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <style type="text/css">
        a.aspNetDisabled { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        a.aspNetDisabled:hover { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        #ProductListPagerSimple span,
        #ProductListPagerSimple2 span { font-weight:bold; }
		h1 {color: #94A232;font-size: 2.34em;font-weight: bold;margin:0 0 10px}
		#main h2 {font-size: 20px;font-weight: bold;margin:0; padding:0; }
		.c20l a {text-decoration:none}
		.c20l p {line-height:1em}
		p{font-size: 14px; line-height:18px; }
		.content-updates {
		width: 80%;
		margin-left: 20%;
		}
		#cas-container-opacity #cas-container {height:auto;}
		#breadcrumb { padding:0; }
    </style>
    

		
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"></asp:Content>
<asp:Content ID="ContentHeader" ContentPlaceHolderID="cpPageBanner" Runat="Server">
	<div id="banner-div" class="speciation">
		<!--<img class="category-banner-img" src="img/category-wine-banner.png" alt="Organic Wine Standards"/>-->
		<div class="banner-label-wrapper">
			<!--<img class="banner-label" src="img/banner-wine-label.png">-->
			<h1 class="banner-header speciation">Speciation Standards for <br />ICP-MS AND LC-ICP-MS</h1>
		</div>
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
							<li class="pdf_dl"><a href="/knowledge-base/catalogs/DualSingleSpeciation.pdf" target="_blank">Single and Dual Speciation Standards by ICP, ICP-MS and LC-ICP-MS</a></li>
							<li class="pdf_dl"><a href="/knowledge-base/catalogs/0221-201232-Guide-To-Speciation.pdf" target="_blank">Guide to Speciation</a></li>
						</ul>
					</div>
				</div>
				
				<div class="side-module">
					<div class="badge-box-side">
						<img src="/images/badge-icons.png" />
						<p>SPEX CertiPrep is accredited by A2LA for Organic and Inorganic Certified Reference Materials. In addition to being registered as an ISO 9001 facility, SPEX CertiPrep is accredited by A2LA as complying with the requirements of ISO/IEC 17025 and ISO/IEC Guide 34. Our scope is the most comprehensive in the industry.</p>
					</div>
				</div>
			</div>	
			<div class="c66r ">
				<div>
					<br /><br />
					<div id="banner-p">		
						<p>SPEX CertiPrep has expanded the ICP-MS product line to include Speciation Standards. Speciation analysis covers many areas including environmental protection and the food and drug administration.</p>
						<p>To analyze species in a sample requires Certified Reference Materials for sample verification and method validation. Many Speciation Standards are available in today's market, but most of the Speciation Standards are not certified or analyzed with a state-of-art ICP, ICP-MS or LC-ICP-MS.</p>
						<p><strong>What is unique about SPEX CertiPrep Dual Speciation Standards?</strong>
							<ul class="speciation-ul">
								<li>Optimized to work well with both ICP and ICP-MS (with one-step dilution).</li>
								<li>Percentages of the species are determined by LC-ICP-MS and reported on our Certificate of Analysis.</li>
								<li>LC Chromatogram is featured on our Certificate of Analysis.</li>
								<li>Trace impurities in the final solution are analyzed by ICP-OES and are traceable to NIST. Levels are reported on our Certificate of Analysis.</li>
							</ul>
						</p>
						<div class="spexertificate-wrap">
							<img class= ""src="/knowledge-base/images/SPEXertificate-Thumbnail.jpg" alt="SPEXertificate" />
							<a href="/knowledge-base/files/SPEXertificate.pdf" target="_blank" class="spexertificate-link">Click here to view our Speciation SPEXertificate sample</a>
						</div>
					</div> 											
    			</div>
    		</div>	
		</div>
		
        <div id="resultstable">
			<div class="productcontent" id="productcontent_Product">
				<div style="margin:0 0 2em">
					<p><strong>Single Inorganic Speciation Standards</strong><br />Concentration: 1000 &micro;g/mL</p>
					<table style="width:100%" class="tablesorter">
						<thead>
							<tr>
								<th scope="col" class="header sorter" nowrap>Part #</th>
								<th scope="col" class="header sorter">Description</th>
								<th scope="col" class="header sorter">Matrix</th>
								<th scope="col" class="header">Volume</th>
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
										<td class="desc" nowrap><b><a href='/products/product_inorganic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("partnumber") %></a></b></td>
										<td class="desc"><b><a href='/products/product_inorganic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("title") %></a></b></td>
										<td><%# Eval("Matrix") %></td>
										<td style="text-align:right;white-space:nowrap;"><%# Eval("Volume") %></td>
										<td style="text-align:right;white-space:nowrap;"><%# GetPrice(Eval("partnumber").ToString())%></td>
										<td class="buybutton" style="white-space:nowrap;">
											<input name='quantity_<%# Eval("partnumber") %>' type="text" id='quantity_<%# Eval("partnumber") %>' class="search_quantity" value="1" /><input type="button" id='buy_<%# Eval("partnumber") %>' name='buy_<%# Eval("partnumber") %>' value="" class="search_buy" onclick="buyIt('<%# Eval("partnumber") %>');" />
                                        </td>
									</tr>
								</ItemTemplate>
							</asp:ListView> 
						</tbody>
					</table>
					<br>
					
					<p><strong>Organic Arsenic Speciation Standards</strong><br />Volume: 30 mL</p>
					<table style="width:100%" class="tablesorter">
						<thead>
							<tr>
								<th scope="col" class="header sorter" style="width:12%" nowrap>Part #</th>
								<th scope="col" class="header sorter" style="border-left:none;">Description</th>
								<th scope="col" class="header sorter" style="width:15%;border-left:none;">Matrix</th>
								<th scope="col" class="header" style="width:15%;border-left:none;">Concentration</th>
								<th scope="col" class="header" style="width:8%;border-left:none;">Price</th>
								<th scope="col" style="border-left:none;" >Add to Cart</th>
							</tr>
						</thead>
						<tbody>
							<asp:ListView ID="lvProducts2" runat="server" DataSourceID="dataProducts2">
								<LayoutTemplate>
									<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
								</LayoutTemplate>
								<ItemTemplate>
									<tr>
										<td class="desc" nowrap><b><a href='/products/product_inorganic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("partnumber") %></a></b></td>
										<td class="desc" style="border-left:none;"><b><a href='/products/product_inorganic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("title") %></a></b></td>
										<td style="border-left:none;"><%# Eval("Matrix") %></td>
										<!--Concentration-->
										<%# (GetConcentrationInorg(Eval("partnumber").ToString()) == "Various") ? "<td style='border-left:none;white-space:nowrap;'>"+ 
										GetConcentrationInorg(Eval("partnumber").ToString())+"<a href='javascript:void()' class='various_cascon' data-partnum='"+
										Eval("partnumber")+"'><img src='/images/modal-tooltip.png' /></a></td>" : "<td style='border-left:none;'>"+ 
										GetConcentrationInorg(Eval("partnumber").ToString())+"</td>" %>
										<!--EOF Concentration-->
										<td style="text-align:right;white-space:nowrap;border-left:none;"><%# GetPrice(Eval("partnumber").ToString())%></td>
										<td class="buybutton" style="white-space:nowrap;border-left:none;">
											<input name='quantity_<%# Eval("partnumber") %>' type="text" id='quantity_<%# Eval("partnumber") %>' class="search_quantity" value="1" /><input type="button" id='buy_<%# Eval("partnumber") %>' name='buy_<%# Eval("partnumber") %>' value="" class="search_buy" onclick="buyIt('<%# Eval("partnumber") %>');" />
                                        </td>
									</tr>
								</ItemTemplate>
							</asp:ListView> 
						</tbody>
					</table>
					<br>
					
					<p><strong>Dual Speciation Standards</strong><br />Volume: 30 mL</p>
					<table style="width:100%" class="tablesorter">
						<thead>
							<tr>
								<th scope="col" class="header sorter" style="width:12%" nowrap>Part #</th>
								<th scope="col" class="header sorter" style="border-left:none;">Description</th>
								<th scope="col" class="header sorter" style="width:15%;border-left:none;">Matrix</th>
								<th scope="col" class="header" style="width:15%;border-left:none;">Concentration</th>
								<th scope="col" class="header" style="width:8%;border-left:none;">Price</th>
								<th scope="col" style="border-left:none;" >Add to Cart</th>
							</tr>
						</thead>
						<tbody>
							<asp:ListView ID="lvProducts3" runat="server" DataSourceID="dataProducts3">
								<LayoutTemplate>
									<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
								</LayoutTemplate>
								<ItemTemplate>
									<tr>
										<td class="desc" nowrap><b><a href='/products/product_inorganic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("partnumber") %></a></b></td>
										<td class="desc" style="border-left:none;"><b><a href='/products/product_inorganic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("title") %></a></b></td>
										<td style="border-left:none;"><%# Eval("Matrix") %></td>
										<!--Concentration-->
										<%# (GetConcentrationInorg(Eval("partnumber").ToString()) == "Various") ? "<td style='border-left:none;white-space:nowrap;'>"+ 
										GetConcentrationInorg(Eval("partnumber").ToString())+"<a href='javascript:void()' class='various_cascon' data-partnum='"+
										Eval("partnumber")+"'><img src='/images/modal-tooltip.png' /></a></td>" : "<td style='border-left:none;'>"+ 
										GetConcentrationInorg(Eval("partnumber").ToString())+"</td>" %>
										<!--EOF Concentration-->
										<td style="text-align:right;white-space:nowrap;border-left:none;"><%# GetPrice(Eval("partnumber").ToString())%></td>
										<td class="buybutton" style="white-space:nowrap;border-left:none;">
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
		<div id="go-top">
			<a href="#top">Back to top &#9650;</a> 
		</div>
	</div>
		
	<div id="emailModule">
		<div id="emailToFriend" style="width:545px;">
			<h3 style="margin-bottom:15px;padding:5px;">Carbon Black FREE Sample</h3>
			<div class="emailBox" style="margin-bottom:0;">
				<table class="carbonEmailBox">
					<tr>
						<td>
							<input type="text" id="temp_name" class="input-260" maxlength="100" placeholder="Name *" />
							<span class="error temp_name" style="color: red;visibility:hidden;">You need to provide your name.</span>
						</td>
						<td>
							<input type="text" id="temp_company" class="input-260" maxlength="100" placeholder="Company *" />
							<span class="error temp_company" style="color: red;visibility:hidden;">You need to provide your company.</span>
						</td>
					</tr>
					<tr>
						<td>
							<input type="text" id="temp_address" class="input-260" maxlength="100" placeholder="Address *" />
							<span class="error temp_address" style="color: red;visibility:hidden;">You need to provide your address.</span>
						</td>
						<td>
							<input type="text" id="temp_city" class="input-260" maxlength="100" placeholder="City" />
							<span class="error" style="color: red;visibility:hidden;">&nbsp;</span>
					</td>
					</tr>
					<tr>
						<td>
							<input type="text" id="temp_state" class="input-260" maxlength="100" placeholder="State" />
							<span class="error" style="color: red;visibility:hidden;">&nbsp;</span>
						</td>
						<td>
							<input type="text" id="temp_zip" class="input-260" maxlength="100" placeholder="Zip Code" />
							<span class="error" style="color: red;visibility:hidden;">&nbsp;</span>
						</td>
					</tr>
					<tr>
						<td>
							<input type="text" id="temp_phone" class="input-260" maxlength="100" placeholder="Phone *" />
							<span class="error temp_phone" style="color: red;visibility:hidden;">You need to provide a phone number.</span>
						</td>
						<td>
							<input type="text" id="temp_emails" class="input-260" maxlength="100" placeholder="Email Address *" />
							<span class="error temp_emails" style="color: red;visibility:hidden;">You need to provide a email address.</span>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<select id="temp_product">
								<option class="0">-- Select Carbon Black Solution --</option>
								<option class="Sodium Thiosulfate 0.0394 N">Sodium Thiosulfate 0.0394 N</option>
								<option class="Iodine 0.0473 N">Iodine 0.0473 N</option>
							</select>
							<span class="error temp_product" style="color: red;visibility:hidden;">Please select a solution.</span>
						</td>
					</tr>
					<tr>
						<td colspan="2"><button id="cmdTrigger" class="submitbutton">Submit</button></td>
					</tr>
				</table>
			</div>			
			<div style="clear:both"></div>
		</div>
		<asp:TextBox ID="emails" runat="server" CssClass="input-260" MaxLength="100" placeholder="Email Address" />
		<asp:Button ID="cmdSubmit" Text="SUBMIT" runat="server"  onclick="cmdSubmit_Click" CssClass="submitbutton"/>
	</div>
	
    <asp:SqlDataSource ID='dataProducts' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommandType="Text">
    </asp:SqlDataSource>
	
	<asp:SqlDataSource ID='dataProducts2' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommandType="Text">
    </asp:SqlDataSource>
	
	<asp:SqlDataSource ID='dataProducts3' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
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
			
			$(".emailBtn").fancybox();
			
			var valid = false;
					
			$("#cmdTrigger").click(function() {
				var error = 0;
				if ($("#temp_name").val() != "") {
					$("#emails").val($("#temp_emails").val());
					$("span.error.temp_name").css("visibility", "hidden");
					if (error > 0) { error--; }
				}else {
					$("span.error.temp_name").css("visibility", "visible");
					error++;
				}
						
				if ($("#temp_company").val() != "") {
					$("#emails").val($("#temp_emails").val());
					$("span.error.temp_company").css("visibility", "hidden");
					if (error > 0) { error--; }
				}else {
					$("span.error.temp_company").css("visibility", "visible");
					error++;
				}

				if ($("#temp_address").val() != "") {
					$("#emails").val($("#temp_emails").val());
					$("span.error.temp_address").css("visibility", "hidden");
					if (error > 0) { error--; }
				}else {
					$("span.error.temp_address").css("visibility", "visible");
					error++;
				}
						
				if ($("#temp_phone").val() != "") {
					$("#emails").val($("#temp_emails").val());
					$("span.error.temp_phone").css("visibility", "hidden");
					if (error > 0) { error--; }
				}else {
					$("span.error.temp_phone").css("visibility", "visible");
					error++;
				}
						
				if ($("#temp_emails").val() != "") {
					$("#emails").val($("#temp_emails").val());
					$("span.error.temp_emails").css("visibility", "hidden");
					if (error > 0) { error--; }
				}else {
					$("span.error.temp_emails").css("visibility", "visible");
					error++;
				}
						
				if ($("#temp_product").val() != "-- Select Carbon Black Solution --") {
					$("#emails").val($("#temp_emails").val());
					$("span.error.temp_product").css("visibility", "hidden");
					if (error > 0) { error--; }
				}else {
					$("span.error.temp_product").css("visibility", "visible");
					error++;
				}
				console.log($("#temp_product").val() + ":" + error);
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

