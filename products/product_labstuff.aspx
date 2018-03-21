<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="product_labstuff.aspx.cs" Inherits="product_labstuff" Debug="true" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    
	
	<style>
		.tabcontents { color: #444444;}
		.demo_video{padding-top: 15px;}
		.demo_video b{
			padding-bottom: 10px;
			float: left;
			font-size: 25px;
			font-weight: bold;
			color: #9fa615;
			}
		.demo_video iframe { display:block; }
		#related-static b{font-size:25px;color:#9fa615;padding-bottom: 15px;float: left;}
		#related-static ul{clear: both;margin:0;}
		#related-static ul li
		 {
			background: url('/images/bullet-ico.png') no-repeat left top;
			height: auto;
			padding: 0 0 10px 30px;
			margin: 0;
			color: #1a1a1a;
			font-size: 16px;	
			height: auto;
			padding-bottom: 10px;
			-webkit-print-color-adjust:exact;
			list-style: none;
		}
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server">
	<a href="/">Home</a> > Products > <a href="/search_labstuff.aspx">Laboratory Products</a> > <%=ProdTitle%>
	<div class="pageControls">
		<a class="emailBtn" href="#emailToFriend">emailBtn</a>
		<a class="printBtn" href="#">printBtn</a>
	</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">

	<div class="product_details_wrap" id="main_page" style="margin-bottom:6em;display:inline-block;">
		<div class="product_detail_kits">
			<div class="product_detail_left">
				<div id="productinfo_div">
					<div class="info-head"><h2 class="prod-info">Product Information</h2></div>
					<ul class="list-info prod-info">
						<li>Part #: <span class="shade"><%=PartNumber%></span><span class="hidden" id="prod-part"><%=PartNumber%></span></li>
						<li>Method: <span class="shade"><%=Method%></span></li>
						<li>Units/Pack: <span class="shade"><%=UnitsPerPack%></span></li>
						<!--<li>In Stock: <span class="shade"><%=InStock%></span></li>-->
						<li>Storage Condition: <span class="shade"><%=Storage%></span></li>
						<li>Shipping Info: <span class="shade"><%=Shipping%></span></li>
						
						<asp:ListView ID="lvMSDS" runat="server" DataSourceID="dataMSDS">
						<LayoutTemplate>
							<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
						</LayoutTemplate>
						<ItemTemplate>
							<li class="pdf_dl"><a href='/MSDS/<%# Eval("FileName") %>'>View MSDS</a></li>
						</ItemTemplate>
						</asp:ListView> 
					</ul>
				</div>
				<br /><br />
				<% if (getProdFylers() != "") { %>
					<div id="productinfo_div">
						<div class="info-head"><h2 class="prod-info">Product Literature</h2></div>
						<ul class="flyers">
							<%=getProdFylers()%>
						</ul>
					</div>
				<% }%>
				
				<div class="demo_video">
					<%=demo_video%>
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
				<% if (SEOText != "") { %>
					<div class="method-ref">
						<div class="tabs" id="Menu1" style="float: left;">
							<ul class="level1 static" tabindex="0" role="menubar" style="position: relative; width: auto; float: left;">
									<li role="menuitem" class="static selected_tab" id="tab1">
										Additional Information
									</li>
									
									<li role="menuitem" class="static" id="tab2">
										Product Features
									</li>
							</ul>
						</div>
						<div class="tabcontents" id="tabcontents1" style="clear:both;">
							<%=additional_info%>
						</div>
						<div class="tabcontents" id="tabcontents2" style="display:none;clear:both;">
							<%=product_features%>
						</div>
					</div>
					<br><br>
					<div id="related-static">
						<%=related_products%>
					</div>
				<% } %>
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
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script src="/js/jquery-ui.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function(){
			$("#productdata_table tr:even").addClass("odd");
			$("div.method-ref table tr:even").addClass("odd");
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
				jQuery.ajax({
					url: 'product_inorganic.aspx/GetProduct',
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
		});
		
		function itemAddShow() {
			$('.float-footer').addClass("mobshow");
			$(".itemAddBox").fadeIn("slow");
			setTimeout(function() {
				$(".itemAddBox").fadeOut("slow");
			}, 4000);
		}
    </script>    
    <script type="text/javascript">
        $(document).ready(function () {
            $("li:has(a.selected)").addClass("selected");
			$(".demo_video iframe").width(287);
			$(".demo_video iframe").height(215);
			
			$("a#single_image").fancybox({'titlePosition' : 'inside'});
        });
    </script>
	<script>
		jQuery(document).ready(function () {
			jQuery('#tab1').click(function(){
				jQuery('#tabcontents2').hide();jQuery('#tabcontents1').show();
				jQuery('#tab1').addClass('selected_tab');
				jQuery('#tab2').removeClass('selected_tab');
				
			});
			
			jQuery('#tab2').click(function(){
				jQuery('#tabcontents1').hide();jQuery('#tabcontents2').show();
				jQuery('#tab2').addClass('selected_tab');
				jQuery('#tab1').removeClass('selected_tab');
			});		
		});
	</script>
</asp:Content>

