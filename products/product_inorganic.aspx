<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="product_inorganic.aspx.cs" Inherits="product_inorganic" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
	<style>
	.product_detail_right #productdata_table { width: 100% !important; }
	</style>
    
	<style>
		#cas-container-opacity {position:absolute;}
		#cas-container-opacity .close-x { right:15px; top: 15px;}
		#productdata_table2 {
			width: 50%;
			border-top:none;
		}
		#productdata_table2 th { 
			font-size: 17px;
			width:auto;
			margin: 0;
			font-weight: bold;
			color: #FFF;
			padding: 10px 15px;
			background: none;
			border-left: none;
		}
		#productdata_table2 thead tr {
			background: url('/images/headerbartop.png') repeat-x;
			height: 49px;
		}
		#productdata_table2 td {
			padding: 10px 15px;
			border-left:none;
		}
		#productdata_table2 td.price {
			font-weight:700;
			color: #a3b405;
		}
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server">
	<a href="/">Home</a> > Products > <a href="/products/inorganic">Inorganic Standards</a> > <% if (Request.QueryString["part"] == "182002" || Request.QueryString["part"] == "183134") {%> <a href="/knowledge-base/carbon-black-reagents">Carbon Black</a> > <% }%> <%=ProdTitle%>
	<div class="pageControls">
		<a class="emailBtn" href="#emailToFriend">emailBtn</a>
		<a class="printBtn" href="#">printBtn</a>
	</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
  
	<!--CAS Pop Up-->
	<div id="cas-container-opacity">
		<div id="prod-container">
			<div class="close-x"></div>
			<div class="CAStable"></div>
		</div>
	</div>
	<!--EOF CAS Pop Up-->
    
    <div class="product_details_wrap" id="main_page" style="margin-bottom:6em;display:inline-block;">
		<div class="product_detail_kits">
        
		<div class="product_detail_left">
			<div id="productinfo_div">
				<div class="info-head"><h2 class="prod-info">Product Information</h2></div>
				<ul class="list-info prod-info">
					<li>Part #: <span class="shade"><%=PartNumber%></span><span class="hidden" id="prod-part"><%=PartNumber%></span></li>
					<li>Matrix: <span class="shade"><%=Matrix%></span></li>
					<li>Volume: <span class="shade"><%=Volume%></span></li>
					<li>Units/Pack: <span class="shade"><%=UnitsPerPack%></span></li>
					<!--<li>In Stock: <span class="shade"><%=InStock%></span></li>-->
					<li>Storage Condition: <span class="shade"><%=Storage%></span></li>
					<li>Shipping Info: <span class="shade"><%=Shipping%></span></li>
					<li>Method Reference: <span class="shade"><%=Method%></span></li>
					<li>Product Notes: <span class="shade"><%=Notes%></span></li>
					<asp:ListView ID="lvMSDS" runat="server" DataSourceID="dataMSDS">
                    <LayoutTemplate>
                        <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <li class="pdf_dl"><a target='_blank' href='/MSDS/<%# Eval("FileName") %>'>SDS</a></li>
                    </ItemTemplate>
					</asp:ListView> 
				</ul>
			</div>
			<div class="iso-box">
				<img src="/images/iso.png"/>
				<p>SPEX CertiPrep is accredited by A2LA for Organic and Inorganic Certified Reference Materials. In addition to being registered as an ISO 9001 facility, SPEX CertiPrep is accredited by A2LA as complying with the requirements of ISO/IEC 17025 and ISO 17034. Our scope is the most comprehensive in the industry.</p>
			</div>
		</div>
		<div class="product_detail_right">
			<div id="product_title">
				<h1><%=ProdTitle%></h1>
			</div>
			<div id="product_top">
				<div id="product_topleft">
					<div id="product_image">
						<a id="single_image" href="<%=ImageURL%>" title="<%=ImageDesc%>"><img src="<%=ImageThumb%>" title="<%=ImageTitle%>" alt="<%=ImageAltText%>" /></a>
					</div>
					<div style="clear:both"></div>
				</div>
				<div id="product_topright">
					<div id="product_prices">
						<!--In Stock: <span style="margin-left:6.3em"><%=InStock%></span><br />-->
						Retail Price: <span class="price" style="margin-left:5em"><%=ThePriceText%></span><br />
						<% if (HttpContext.Current.Session["userid"] != null) {%>Discounted Price: <span class="price" style="margin-left:2.4em"><%=DiscountPriceText%></span><% }%>
					</div>
					<div id="product_orderbox">
						<!--<span class="our_price">Your Price <%=DiscountPriceText%></span><br />-->
						<div id="quantity_box">
							<div class="quantity_label">Quantity:</div>
							<div class="quantity_field">
								<input type="text" name="quantity" id="select_quantity" value="1" size="2" class="quantitybox qb1" onchange="checkNumber();" />
								<img class="quantity_arrow" src="/images/arrow-down.png" onclick="dropQty('qb1')" />
								<ul id="qb1" class="quantity_box_list">
									<li>1</li>
									<li>2</li>
									<li>3</li>
									<li>4</li>
									<li>5</li>
									<li>6</li>
									<li>7</li>
									<li>8</li>
									<li>9</li>
									<li>10</li>
									<li>15</li>
									<li>20</li>
									<li>25</li>
								</ul>
							</div>
						</div>
						<div id="addtocart_button" class="addtocart_button">
							Add To Cart
						</div>
						<div style="clear:both"></div>
					</div>
					<div id="product_payment">
						<p>Or call 1-800-LAB-SPEX</p>
						<img src="/images/payment.png" alt="Payment" />
						<div style="clear:both"></div>
					</div>
				</div>
				<div id="product_description">
					<%=ProdDescription%>
				</div>	
				<div style="clear:both"></div>
			</div>
			<asp:ListView ID="lvKits" runat="server" DataSourceID="dataKits">
            <LayoutTemplate>
                <div id="table_header" class="datakits-head">This kit contains the following items:</div>
                <table id="productdata_table" class="data_kits">
                    <thead>
						<tr>
                            <th scope="col">Part#</th>
                            <th scope="col">Description</th>
                            <th scope="col">#Components</th>
                            <th scope="col">Matrix</th>
                            <th scope="col">Volume</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
                    </tbody>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td style="width:20%"><%# Eval("PartNumber").ToString().Trim()%></td>
                    <td><a href='product_inorganic.aspx?part=<%# Eval("PartNumber").ToString().Trim()%>'><%# Eval("Description").ToString().Trim()%></a></td>
                    <td style="text-align:center"><%# GetComponentCount(Eval("PartNumber").ToString().Trim())%></td>
                    <td><%# Eval("Matrix").ToString().Trim()%></td>
                    <td><%# Eval("Volume").ToString().Trim()%></td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
		<asp:ListView ID="lvComponents" runat="server" DataSourceID="dataComponents">
			<LayoutTemplate>
				<table id="productdata_table" style="width:75%">
					<thead>
						<tr>
							<th scope="col">Components</th>
							<th scope="col">Concentration</th>
						</tr>
					</thead>
					<tbody>
						<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
					</tbody>
				</table>
			</LayoutTemplate>
			<ItemTemplate>
				<tr>
					<td class="desc"><%# Eval("caNameWeb")%></td>
					<td><%# Eval("cpmpConc") + " " + Eval("cuUnit")%></td>
				</tr>
			</ItemTemplate>
		</asp:ListView>
        
		<br>
		<p style="color:#1a1a1a"><%=certiLCICPMS%></p>
		<asp:ListView ID="lvLabelCat" runat="server" DataSourceID="dataLabelCat">
            <LayoutTemplate>
				<div class="labelCat">
					<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
				</div>
            </LayoutTemplate>
            <ItemTemplate>
                <img src="/images/label-cat/<%#Eval("labelCat").ToString() %>" />
            </ItemTemplate>
        </asp:ListView>
		
		<div class="prevPages">
			<%=prevPages%>
		</div>
		<br />
		<br />
		<div class="method-ref">
			<%=MethodUL%>

			<%=SEOText%>
		</div>
			<div class="spex-div">
				<div id="banner-p">	
					<div style="font-size:1.15em;">
						SPEX CertiPrep offers a full range of Inorganic Certified Reference Materials (CRM). 
						<a href="http://www.spexcertiprep.com/products/custom-standards_inorganic.aspx">Custom Inorganic standards</a> 
						are also available.
					</div>
					<br>
					<ul style="font-size:1.15em;">
						<li>99% of stock orders ship within 24 hours</li>
						<li>New Inorganic Multi-Element Standards for the latest EPA methods</li>
						<li>Custom standards manufactured and shipped within 5 business days</li>
						<li>Dedicated technical support to answer your CRM and lab questions</li>
						<li>New Inorganic Multi-Element Standards for the latest EPA methods</li>
					</ul>
				</div>
			</div>
			<div id="product_orderbox" style="padding:0;margin:0;float:right">
                <!--<span class="our_price">Your Price <%=DiscountPriceText%></span><br />-->
				<div id="quantity_box">
					<div class="quantity_label">
						<span style="color:#000">Quantity:</span> 
					</div>
					<div class="quantity_field">
						<input type="text" name="quantity" id="select_quantity2" value="1" size="2" class="quantitybox qb2" onchange="checkNumber();" />
						<img class="quantity_arrow" src="/images/arrow-down.png" onclick="dropQty('qb2')"/>
						<ul id="qb2" class="quantity_box_list">
							<li>1</li>
							<li>2</li>
							<li>3</li>
							<li>4</li>
							<li>5</li>
							<li>6</li>
							<li>7</li>
							<li>8</li>
							<li>9</li>
							<li>10</li>
							<li>15</li>
							<li>20</li>
							<li>25</li>
						</ul>
					</div>
				</div>
                <div id="addtocart_button" class="addtocart_button2">
                    Add To Cart
                </div>
				
            </div>
		</div>	
		</div>
		<div class="clear"></div>
    </div>
	<div id="emailModule">
		<div id="emailToFriend">
			<h3 style="margin-bottom:15px;">Email to Colleague</h3>
			<div class="emailBox">
				<input type="email" id="temp_emails" class="input-260" maxlength="100" placeholder="Colleague's Email Address" />
				<br><br>
				<input type="text" id="temp_name" class="input-260" maxlength="100" placeholder="Your Name" />
				<br><br>
				<input type="email" id="from_emails" class="input-260" maxlength="100" placeholder="Your Email Address" />
				<br>
				<span class="error" style="color: red;visibility:hidden;">You need to provide all fields.</span>
			</div>
			<button id="cmdTrigger" class="submitbutton">Submit</button>
			<div style="clear:both"></div>
		</div>
		<asp:TextBox ID="emails" runat="server" CssClass="input-260" MaxLength="100" placeholder="Colleague's Email Address" />
		<asp:TextBox ID="fullname" runat="server" CssClass="input-260" MaxLength="100" placeholder="Your Name" />
		<asp:TextBox ID="emailsfrom" runat="server" CssClass="input-260" MaxLength="100" placeholder="Your Email Address" />
		<asp:Button ID="cmdSubmit" Text="SUBMIT" runat="server"  onclick="cmdSubmit_Click" CssClass="submitbutton"/>
	</div>
    <asp:SqlDataSource ID='dataMSDS' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT FileName FROM certiMSDS WHERE PartNumber = @PartNumber" SelectCommandType="Text">
        <SelectParameters>
            <asp:QueryStringParameter Name="PartNumber" Type="String" QueryStringField="part" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataComponents' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT  cp.cpPart, cp.cpDescrip, ca.caNameWeb, CAST(cpc.cpmpConc AS varchar(10)) AS cpmpConc, cu.cuUnit FROM certiProdComps AS cpc JOIN certiAnalytes AS ca ON cpc.cpmpAnalyteID = ca.caID JOIN cp_roi_Prods AS cp ON cpc.cpmpProd = cp.cpPart JOIN certiUnits AS cu ON cpc.cpmpUnits = cu.cuID WHERE cpc.cpmpConc IS NOT NULL AND cpc.cpmpProd =  @PartNumber ORDER BY cpc.cpmpConc DESC, ca.caNameWeb" SelectCommandType="Text">
        <SelectParameters>
            <asp:QueryStringParameter Name="PartNumber" Type="String" QueryStringField="part" />
        </SelectParameters>
    </asp:SqlDataSource>
	
	<asp:SqlDataSource ID='dataLabelCat' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT * FROM cp_LabelCAT WHERE partNum = @PartNumber" SelectCommandType="Text">
        <SelectParameters>
            <asp:QueryStringParameter Name="PartNumber" Type="String" QueryStringField="part" />
        </SelectParameters>
    </asp:SqlDataSource>
	
    <asp:SqlDataSource ID='dataKits' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT IM_1.Item_Part_Nbr AS PartNumber, cp.cpDescrip AS [Description], cp.cpLongMatrix AS Matrix, cv.cpvVolume AS Volume FROM cp_roi_Prods p JOIN cp_roi_PS AS ps ON p.cpID = ps.Novo_IM_Assy LEFT JOIN cp_roi_IM AS IM_1 ON IM_1.Part_Number = ps.Component_Part LEFT JOIN cp_roi_Prods AS cp ON IM_1.Item_Part_Nbr = cp.cpPart LEFT JOIN cp_roi_Volumes AS cv ON cp.Cpvol = cv.cpvID WHERE p.cpPart = @PartNumber AND p.cpIsKit = 'Y' ORDER BY IM_1.Item_Part_Nbr" SelectCommandType="Text">
        <SelectParameters>
            <asp:QueryStringParameter Name="PartNumber" Type="String" QueryStringField="part" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script src="/js/jquery-ui.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#productdata_table tr:even").addClass("odd");
            $(".addtocart_button").click(function () {
                theQuantity = document.getElementById("select_quantity").value;
				//alert(theQuantity);
                if(theQuantity == '' || theQuantity == '0' ) {
                    alert('Quantity must be greater than 0');
                    return false;
                }
                $("#footer_cart").load("/utility/addtocart.aspx?productid=<%=Server.UrlEncode(PartNumber)%>&pq=" + theQuantity);
                $('.addtocart_button').html("In Cart");
				setTimeout(function(){itemAddShow();},500);
            });
			$(".addtocart_button2").click(function () {
                theQuantity = document.getElementById("select_quantity2").value;
                if(theQuantity == '' || theQuantity == '0' ) {
                    alert('Quantity must be greater than 0');
                    return false;
                }
                $("#footer_cart").load("/utility/addtocart.aspx?productid=<%=Server.UrlEncode(PartNumber)%>&pq=" + theQuantity);
                $('.addtocart_button2').html("In Cart");
				setTimeout(function(){itemAddShow();},500);
            });
			
			$(".quantity_box_list").focusout(function() {
				$(this).css("display", "none");
			});
			$('.quantity_box_list li').click(function() {
				var par = $(this).parent().attr("id");
				$(".quantitybox." + par).val($(this).text());
				$(this).parent().css("display", "none");
			});
			
			$(".prevViewed").click(function(){
				$('#prod-container').removeClass('slim');
				$('#prod-container').center();
				var winWidth = document.body.clientWidth;
				var popBox = ($("#cas-container-opacity #prod-container").width() + 20) / 2;
				var part = $(this).attr('data-partnum');
				var type = $(this).attr('data-prodtype');
				var getprodURL = 'product_inorganic.aspx/GetProduct';
				if (type == "1") {
					getprodURL = 'product_organic.aspx/GetProduct';
				}
				jQuery.ajax({
					url: getprodURL,
					type: "POST",
					data: JSON.stringify({ partnumber: part }),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						console.log(part);
						jQuery('#prod-container .CAStable').html(data.d);
					}
				});
				$('#cas-container-opacity').insertAfter(".mask-layout");
				$('#cas-container-opacity').css("left", (winWidth/2)-popBox);
				$('#cas-container-opacity').fadeIn(500);
				$(".mask-layout").fadeIn();
				$(".mask-layout").css("height", $("body").height());
				//$('html, body').animate({
				//	scrollTop: $("#prod-container").offset().top
				//}, 1000);
			});
			
			$(".forslim a").click(function(){
				$('#prod-container').addClass('slim');
				$('#prod-container').slimCenter();
				var winWidth = document.body.clientWidth;
				var popBox = ($("#cas-container-opacity #prod-container").width() + 20) / 2;
				var part = $(this).attr('data-partnum');
				jQuery.ajax({
					url: 'product_organic.aspx/GetProduct',
					type: "POST",
					data: JSON.stringify({ partnumber: part }),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						jQuery('#prod-container .CAStable').html(data.d);
					}
				});
				$('#cas-container-opacity').insertAfter(".mask-layout");
				$('#cas-container-opacity').css("left", (winWidth/2)-popBox);
				$('#cas-container-opacity').show(500);
				$(".mask-layout").show();
				$(".mask-layout").css("height", $("body").height());
				//$('html, body').animate({
				//	scrollTop: $("#prod-container").offset().top
				//}, 1000);
			});
			$(".close-x").click(function(){
				$('#method-container-opacity').hide();
				$('#cas-container-opacity').hide();
				$('.mask-layout').hide();
			});
			
			$(".quantitybox").keydown(function (e) {
				if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
					(e.keyCode == 65 && ( e.ctrlKey === true || e.metaKey === true ) ) || 
					(e.keyCode >= 35 && e.keyCode <= 40)) {
						 return;
				}
				if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
					e.preventDefault();
				}
			});
			
			$("#cmdTrigger").click(function() {
				if ($("#temp_emails").val() != "" && $("#temp_name").val() != "" && $("#from_emails").val() != "") {
					$("#emails").val($("#temp_emails").val());
					$("#fullname").val($("#temp_name").val());
					$("#emailsfrom").val($("#from_emails").val());
					$("#cmdSubmit").trigger( "click" );
				}else {
					$(".emailBox span").css("visibility", "visible");
				}
			});
			
			$(".emailBtn").fancybox();
        });
		
		jQuery.fn.center = function () {
			this.css("position","absolute");
			this.css("top", Math.max(0, ((($(window).height() - $(this).outerHeight()) / 2) + 
														$(window).scrollTop()) - 333) + "px");
			
			return this;
		}
		jQuery.fn.slimCenter = function () {
			this.css("position","absolute");
			this.css("top", Math.max(0, ((($(window).height() - $(this).outerHeight()) / 2) + 
														$(window).scrollTop()) - 253) + "px");
			
			return this;
		}
		function dropQty(qb) {
			$("#" + qb).slideDown("fast");
			//$(".quantitybox." + qb).focus();
			$("#" + qb).attr('tabindex',-1).focus();
		}
		
		$(function() {
			$('.printBtn').printPreview();
			
			$("a#single_image").fancybox({'titlePosition' : 'inside'});
		});
		
		function itemAddShow() {
			$('.float-footer').addClass("mobshow");
			$(".itemAddBox").fadeIn("slow");
			setTimeout(function() {
				$(".itemAddBox").fadeOut("slow");
			}, 4000);
		}
    </script>
</asp:Content>

