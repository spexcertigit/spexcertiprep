<%@ Page Title="Carbon Black Reagents | SPEX CertiPrep" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="carbon-black-reagents.cs" Inherits="search" debug="true"%>

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
		p{font-size: 14px; line-height:normal}
		.content-updates {
		width: 80%;
		margin-left: 20%;
		}
		#cas-container-opacity #cas-container {height:auto;}
		#breadcrumb { padding:0; }
    </style>
    

		
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="default.aspx">Home</a> > Carbon Black Reagents-Sodium Thiosulfate and Iodine Solutions</asp:Content>
<asp:Content ID="ContentHeader" ContentPlaceHolderID="cpPageBanner" Runat="Server">
	<div id="banner-div" class="carbon-black">
		<!--<img class="category-banner-img" src="img/category-wine-banner.png" alt="Organic Wine Standards"/>-->
		<div class="banner-label-wrapper">
			<!--<img class="banner-label" src="img/banner-wine-label.png">-->
			<h1 class="banner-header carbon-black">Carbon Black Reagents <br />For ASTM D1510</h1>
		</div>
	</div>	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
		
    <div id="main" style="margin-bottom:6em">
           <div class="subcolumns">			
			<div class="c30l">
				<div>
					<br /><br />
					<img src="/images/carbon-black-sidbar.png" alt="Carbon Black Reagents" />
				</div>
					 
				<div class="side-module">
					<h2 id="updates">Product Flyers</h2>
					<div class="organic-side">
						<ul class="flyers">
							<li class="pdf_dl"><a href="/knowledge-base/catalogs/0323-120228-Carbon-Black-Flyer.pdf" target="_blank">Carbon Black Product Flyer</a></li>
							<li class="pdf_dl"><a href="/knowledge-base/catalogs/0221-201158-Guide-to-Carbon-Black.pdf" target="_blank">Guide to Carbon Black</a></li>
						</ul>
					</div>
				</div>
			</div>	
			<div class="c66r ">
				<div>
					<br /><br />
					<div id="banner-p">		
						<h2>SPEX CertiPrep Proudly Introduces Our Carbon Black Reagents for ASTM D1510</h2><br>
						<p>Our sodium thiosulfate solutions are prepared from ACS Grade, micro-crystalline Na<sub>2</sub>S<sub>2</sub>O<sub>3</sub> &#8226; 5H<sub>2</sub>O. In order to maximize shelf life, our matrix is prepared using double-deionized, ASTM Type I Water.</p>
						<p>Our iodine solutions are prepared from ACS Grade potassium iodine and crystalline elemental iodine. To guarantee a clean and stable product, our matrix is prepared using double-deionized, ASTM Type I Water.</p>
						<p>All solutions are prepared gravimetrically, using high accuracy analytical balances, to ensure precise target concentrations. Each batch is thoroughly homogenized using a high-speed industrial mixer to ensure reliable results from the first bottle to the last.</p>
						<p>We are titrating our samples on our automated titrator. The automated dosing drive uses 10,000 steps over its 20mL volume, so its dosing increment can be as small as 2 &micro;L. For these applications, we are using a minimum dose of 10 &micro;L for the sodium thiosulfate endpoint and 4 &micro;L for the iodine endpoint. These settings achieve the extremely precise measurements for each titration while also staying within the parameters of the dosing unit.</p>
						<p>As stated on our Certificate of Analysis, the sodium thiosulfate is run against a 0.1N potassium dichromate solution. The exact normality of this solution is calculated by comparing it to NIST potassium dichromate. A set of 6 samples are run that must all be within nominal value of 0.0394 N &plusmn; 0.00008 N.</p>
						<p>Then the certified sodium thiosulfate is used to titrate iodine. A set of 3 samples are run that must all be within the nominal value of 0.0473 N &plusmn; 0.00003 N.</p>
						<p>Before releasing either of these reagents for packaging, we run QC checks with a previous lot to ensure accuracy over time.</p>
						<p>SPEX CertiPrep has been servicing the scientific community since 1954. We are a leading manufacturer of Certified Reference Materials (CRMs) and Calibration Standards for Analytical Spectroscopy and Chromatography. We offer a full range of Inorganic and Organic CRMs. We are certified by UL-DQS for ISO 9001:2008 and are proud to be accredited by A2LA under ISO/IEC 17025:2005 and ISO/IEC 17025 Guide 34:2009. The scope of our accreditation is the most comprehensive in the industry.</p>
						<p><a href="#emailToFriend" class="emailBtn">Click here</a> to request your free sample for method validation.
					</div> 											
    			</div>
    		</div>	
		</div>

        <div id="resultstable">
			<div class="productcontent" id="productcontent_Product">
				<div style="margin:0 0 2em">
					<table style="width:100%" class="tablesorter">
						<thead>
                            <tr>
                            <th scope="col" class="header" colspan="6">Carbon Black Reagents for ASTM D1510</th>
                            </tr>
							<tr>
								<th scope="col" class="header sorter" nowrap>Part #</th>
								<th scope="col" class="header sorter">Description</th>
								<th scope="col" class="header sorter">Packaging</th>
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
										<td><%# (Eval("PartNumber").ToString() == "182002") ? "Cubitainer" : "Amber Glass Bottle" %></td>
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
				</div>
			</div>
		</div>
		<div class="orangeBox">
			Bulk discounts upon request
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
								<option class="Sodium Thiosulfate 0.0394 N and Iodine 0.0473 N">Sodium Thiosulfate 0.0394 N and Iodine 0.0473 N</option>
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
		<asp:TextBox ID="name" runat="server" CssClass="input-260" />
		<asp:TextBox ID="company" runat="server" CssClass="input-260" />
		<asp:TextBox ID="address" runat="server" CssClass="input-260" />
		<asp:TextBox ID="city" runat="server" CssClass="input-260" />
		<asp:TextBox ID="state" runat="server" CssClass="input-260" />
		<asp:TextBox ID="zipCode" runat="server" CssClass="input-260" />
		<asp:TextBox ID="phone" runat="server" CssClass="input-260" />
		<asp:TextBox ID="emails" runat="server" CssClass="input-260" MaxLength="100" placeholder="Email Address" />
		<asp:TextBox ID="products" runat="server" CssClass="input-260" />
		<asp:Button ID="cmdSubmit" Text="SUBMIT" runat="server"  onclick="cmdSubmit_Click" CssClass="submitbutton"/>
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
			
			$(".emailBtn").fancybox();	
			
			var valid = false;
					
			$("#cmdTrigger").click(function() {
				var error = 0;
				if ($("#temp_name").val() != "") {
					$("#name").val($("#temp_name").val());
					$("span.error.temp_name").css("visibility", "hidden");
					if (error > 0) { error--; }
				}else {
					$("span.error.temp_name").css("visibility", "visible");
					error++;
				}
						
				if ($("#temp_company").val() != "") {
					$("#company").val($("#temp_company").val());
					$("span.error.temp_company").css("visibility", "hidden");
					if (error > 0) { error--; }
				}else {
					$("span.error.temp_company").css("visibility", "visible");
					error++;
				}

				if ($("#temp_address").val() != "") {
					$("#address").val($("#temp_address").val());
					$("span.error.temp_address").css("visibility", "hidden");
					if (error > 0) { error--; }
				}else {
					$("span.error.temp_address").css("visibility", "visible");
					error++;
				}
						
				if ($("#temp_phone").val() != "") {
					$("#phone").val($("#temp_phone").val());
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
					$("#products").val($("#temp_product").val());
					$("span.error.temp_product").css("visibility", "hidden");
					if (error > 0) { error--; }
				}else {
					$("span.error.temp_product").css("visibility", "visible");
					error++;
				}
				console.log($("#temp_product").val() + ":" + error);
				if (error == 0) {
					$("#cmdSubmit").trigger("click");
				}
			});
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

