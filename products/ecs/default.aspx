﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="ecs_parts"  Debug="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
	<link href="/css/easydropdown.css" rel="stylesheet" type="text/css" charset="utf-8" />
    <style type="text/css">
        a.aspNetDisabled { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        a.aspNetDisabled:hover { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        #ProductListPagerSimple span,
        #ProductListPagerSimple2 span { font-weight:bold; }
    </style>
    
	<div id="banner-div" class="ecs">
		<div class="banner-label-wrapper">
			<img class="banner-ecs-logo" src="/products/ecs/images/ecs-logo.png" />
			<h1 class="banner-header ecs">Specializing in high quality analytical standards for GC/MS</h1>
			<a class="ecs-cat-dl" target="_blank" href="/products/ecs/ECS_SPEX_Catalog_2015.pdf">Download Product Catalog</a>
			<img class="ecs-pdf" src="/products/ecs/images/pdf.png">
			<img class="banner-image-right-hipure" src="/products/ecs/images/ecs-right-image.png" />
		</div>
		<!--<img class="m320-category-banner-img" src="/cannabis/img/category-banner-organic-320.png" alt="Organic Certified Reference Materials" />
		<img class="m480-category-banner-img" src="/cannabis/img/category-banner-organic-480.png" alt="Organic Certified Reference Materials" />
		<img class="m768-category-banner-img" src="/cannabis/img/category-banner-organic-768.png" alt="Organic Certified Reference Materials" />-->
		<div class="banner-shadow"></div>
	</div>	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/">Home</a> > Search Organic Standards</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
	<!--Method Pop Up-->
	<div id="method-container-opacity">
		<div class="close-x"></div>
		<div id="method-container">
			<div class="method-ref">
			</div>
		</div>
	</div>
	<style>
		#breadcrumb { display: none}
	</style>
	<!--EOF Method Pop Up-->
	
	<!--CAS Pop Up-->
	<div id="cas-container-opacity">
		<div id="cas-container">
			<div class="close-x"></div>
			<div class="CAStable"></div>
		</div>
	</div>
	<!--EOF CAS Pop Up-->
	            
    <div id="resultstable">
        <!--<div style="text-align: right; margin: 1.5em 0 0;">-->
		<div class="pagers1_wrapper" style="display:none;">
			<asp:Panel ID="pnlPerPage" runat="server" style="text-align:right">
			<asp:Label ID="TestLabel" runat="server" />
			<span class="rpp">Results per page:</span>
				<div class="selectbgPagi">
					<div class="IEmagicPagi">
						<asp:DropDownList ID="lbResults" runat="server" AutoPostBack="True" CssClass="page-filter" OnSelectedIndexChanged="lbResults_Change">
							<asp:ListItem Value="25" Text="25" />
							<asp:ListItem Value="50" Text="50" />
						</asp:DropDownList>
					</div>
				</div>
			</asp:Panel>
								 
			<asp:DataPager ID="ProductListPagerSimple" ClientIDMode="Static" runat="server" PagedControlID="lvProducts" PageSize="25" QueryStringField="page" >
				<Fields>
					<asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="true" FirstPageText="&lt;&lt;" PreviousPageText="&lt;" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
					<asp:NumericPagerField RenderNonBreakingSpacesBetweenControls="false" />
					<asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="true" LastPageText="&gt;&gt;" NextPageText="&gt;" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
				</Fields>
			</asp:DataPager>
			<div style="clear:both"></div>
		</div>
        <div style="margin:1.5em 0 6em"> 
            <table width="958" class="tablesorter" align="center" >
                <thead>
                    <tr style="border:none;">
                        <td style="text-align:left;" colspan="10">
							<span class="product-filter">Product Filter</span>
                            <!--<asp:Label ID="lblTechnique" AssociatedControlID="technique" runat="server" Text="Analytical Technique:" />-->
							<span class="filters">
							<div class="select-wrap">
								<!--<div class="selectbgProdList">
									<div class="IEmagicProdList">-->
										<!--<asp:Label ID="lblFamily" AssociatedControlID="family" runat="server" Text="Application:" />-->
										<asp:DropDownList ID="family" CssClass="select-tech" ClientIDMode="Static" DataSourceID="dataFamily" DataValueField="cfid" DataTextField="cfFamily" runat="server" AppendDataBoundItems="true" AutoPostBack="true" onselectedindexchanged="selectedChange">
											<asp:ListItem Value="" Text="-- Select Application --" />
											<asp:ListItem Value="0" Text="All" />
										</asp:DropDownList>&nbsp;&nbsp;
									<!--</div>
								</div>-->
							</div>
							<div class="select-wrap">
								<!--<div class="selectbgProdList">
									<div class="IEmagicProdList">-->
								    <!--<asp:Label ID="lblMethod" AssociatedControlID="s_method" runat="server" Text="Method:" />-->
								    <asp:DropDownList ID="s_method" CssClass="select-tech" ClientIDMode="Static" DataSourceID="dataMethod" DataValueField="cmid" DataTextField="cmName" runat="server" AppendDataBoundItems="true" AutoPostBack="true" onselectedindexchanged="selectedChange">
									    <asp:ListItem Value="" Text="-- Select Method --" />
										<asp:ListItem Value="0" Text="All" />
								    </asp:DropDownList>&nbsp;&nbsp;
									<!--</div>
								</div>-->
							</div>
                            <div class="select-wrap">
								<!--<div class="selectbgProdList">
									<div class="IEmagicProdList">-->
										<asp:DropDownList ID="technique" CssClass="select-tech" ClientIDMode="Static" DataSourceID="dataTechnique" DataValueField="Catid" DataTextField="CatName" runat="server" AppendDataBoundItems="true" AutoPostBack="true" onselectedindexchanged="selectedChange">
											<asp:ListItem Value="0" Text="-- Select Technique --" />
										</asp:DropDownList>&nbsp;&nbsp;
									<!--</div>
								</div>-->
							</div>
							
							
                            <asp:Button ID="cmdFilter" Text="" CssClass="filter-btn" runat="server" onclick="cmdFilter_Click" />
							</span>
                        </td>
                    </tr>
                    <tr class="orig-tr-header">
                        <th scope="col" id="method" onclick="doSort('method')" class="header sorter" >Method</th>
                        <th scope="col" id="partnumber" onclick="doSort('partnumber')" class="header sorter">Part #</th>
                        <th scope="col" id="title" onclick="doSort('title')" class="header sorter">Product Name</th>
                        <th scope="col" id="cas" onclick="doSort('cas')" class="header sorter">CAS#</th>
                        <th scope="col" >Conc.</th>
                        <th scope="col" id="matrix" onclick="doSort('matrix')" class="">Matrix</th>
                        <th scope="col" id="volume" onclick="doSort('volume')" class="">Vol.</th>
                        <th scope="col" >Unit</th>
                        <th scope="col" id="price" onclick="doSort('price')" class="">Price</th>
                        <th scope="col" >Add to Cart</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:ListView ID="lvProducts" runat="server" DataSourceID="dataProducts">
                        <LayoutTemplate>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr class="orig-tr-products">
								<!--Method-->
								<%# (GetMethod(Eval("partnumber").ToString()) == "Various") ? "<td>"+ 
								GetMethod(Eval("partnumber").ToString())+"<a href='javascript:void()' class='various_method' data-partnum='"+
								Eval("partnumber")+"'><img src='/images/modal-tooltip.png' /></a></td>" : "<td>"+ 
								GetMethod(Eval("partnumber").ToString())+"</td>" %>
								<!--EOF Method-->
                                <td class="desc" nowrap><b><a href='products/product_organic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("partnumber") %></a></b></td>
                                <td class="desc"><b><a href='products/product_organic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("title") %></a></b></td>
								<!--CAS-->
								<%# (GetCAS(Eval("partnumber").ToString()) == "Various") ? "<td>"+ 
								GetCAS(Eval("partnumber").ToString())+"<a href='javascript:void()' class='various_cascon' data-partnum='"+
								Eval("partnumber")+"'><img src='/images/modal-tooltip.png' /></a></td>" : "<td>"+ 
								GetCAS(Eval("partnumber").ToString())+"</td>" %>
								<!--EOF CAS-->
								<!--Concentration-->
								<%# (GetConcentration(Eval("partnumber").ToString()) == "Various") ? "<td style='white-space:nowrap;'>"+ 
								GetConcentration(Eval("partnumber").ToString())+"<a href='javascript:void()' class='various_cascon' data-partnum='"+
								Eval("partnumber")+"'><img src='/images/modal-tooltip.png' /></a></td>" : "<td>"+ 
								GetConcentration(Eval("partnumber").ToString())+"</td>" %>
								<!--EOF Concentration-->
                                <td><%# Eval("Matrix") %></td>
                                <td style="text-align:right;white-space:nowrap;"><%# Eval("Volume") %></td>
                                <td style="text-align:center;white-space:nowrap;"><%# Eval("UnitPack") %></td>
                                <td style="text-align:right;white-space:nowrap;"><%# GetPrice(Eval("partnumber").ToString())%></td>
                                <td class="buybutton" style="white-space:nowrap;">
                                    <input name='quantity_<%# Eval("partnumber") %>' type="text" id='quantity_<%# Eval("partnumber") %>' class="search_quantity" value="1" /><input type="button" id='buy_<%# Eval("partnumber") %>' name='buy_<%# Eval("partnumber") %>' value="" class="search_buy" onclick="buyIt('<%# Eval("partnumber") %>');" /></td>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <div style="font-size:1.2em">
                            <p>No Results</p>
                            </div>
                        </EmptyDataTemplate>
                    </asp:ListView> 
                </tbody>
            </table>
            <asp:DataPager ID="ProductListPagerSimple2" ClientIDMode="Static" runat="server" PagedControlID="lvProducts" PageSize="25" QueryStringField="page">
                <Fields>
                    <asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="true" FirstPageText="&lt;&lt;" PreviousPageText="&lt;" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
                    <asp:NumericPagerField RenderNonBreakingSpacesBetweenControls="false" />
                    <asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="true" LastPageText="&gt;&gt;" NextPageText="&gt;" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
                </Fields>
            </asp:DataPager> 
			
			<div id="mobile-tablesorter">
				<div class="mobile-product-filter">
					<h1 class="product-filter">Product Filter</h1>
						<div class="select-wrap">
							<div class="selectbgProdList">
								<div class="IEmagicProdList">
									<asp:DropDownList ID="techniqueMobile" CssClass="select-tech" ClientIDMode="Static" DataSourceID="dataTechnique" DataValueField="Catid" DataTextField="CatName" runat="server" AppendDataBoundItems="true">
										<asp:ListItem Value="0" Text="-- Select Technique --" />
									</asp:DropDownList>&nbsp;&nbsp;
								</div>
							</div>
						</div>
						<div class="select-wrap">
							<div class="selectbgProdList">
								<div class="IEmagicProdList">
									<asp:DropDownList ID="familyMobile" CssClass="select-tech" ClientIDMode="Static" DataSourceID="dataFamily" DataValueField="cfid" DataTextField="cfFamily" runat="server" AppendDataBoundItems="true">
										<asp:ListItem Value="0" Text="-- Select Application --" />
									</asp:DropDownList>&nbsp;&nbsp;
								</div>
							</div>
						</div>
						<div class="select-wrap">
							<div class="selectbgProdList">
								<div class="IEmagicProdList">
									<asp:DropDownList ID="s_methodMobile" CssClass="select-tech" ClientIDMode="Static" DataSourceID="dataMethod" DataValueField="cmid" DataTextField="cmName" runat="server" AppendDataBoundItems="true">
										<asp:ListItem Value="0" Text="-- Select Method --" />
									</asp:DropDownList>&nbsp;&nbsp;
								</div>
							</div>
						</div>
						<asp:Button ID="cmdFilterMobile" Text="" CssClass="filter-btn" runat="server" onclick="cmdFilterMobile_Click" />
				</div>
                <asp:ListView ID="lvProductsMobile" runat="server" DataSourceID="dataProducts">
                    <LayoutTemplate>
                        <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
                    </LayoutTemplate>
                    <ItemTemplate>
						<table class="mobile-result-table">
							<tr><td colspan="4" class="fullTD"><a href='products/product_organic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("title") %></a></td></tr>
							<tr>
								<td class="headerColumns" colspan="2" style="width:35%">Method</td>
								<%# (GetMethod(Eval("partnumber").ToString()) == "Various") ? "<td colspan='2' class='topBorderTD'>"+ 
								GetMethod(Eval("partnumber").ToString())+"<img src='/images/modal-tooltip.png' /></td>" : "<td colspan='2' class='topBorderTD'>"+ 
								GetMethod(Eval("partnumber").ToString())+"</td>" %>
							</tr>
							<tr>
								<td class="headerColumns" colspan='2'>Part #</td>
								<td colspan='2' class='grayTD'><a href='products/product_organic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("partnumber") %></a></td>
							</tr>
							<tr>
								<td class="headerColumns" colspan='2'>CAS#</td>
								<%# (GetCAS(Eval("partnumber").ToString()) == "Various") ? "<td colspan='2' >"+ 
								GetCAS(Eval("partnumber").ToString())+"<img src='/images/modal-tooltip.png' /></a></td>" : "<td colspan='2'>"+ 
								GetCAS(Eval("partnumber").ToString())+"</td>" %>
							</tr>
							<tr>
								<td class="headerColumns" colspan='2'>Concentration</td>
								<%# (GetConcentration(Eval("partnumber").ToString()) == "Various") ? "<td colspan='2' class='grayTD' style='white-space:nowrap;'>"+ 
								GetConcentration(Eval("partnumber").ToString())+"<img src='/images/modal-tooltip.png' /></td>" : "<td class='grayTD' colspan='2'>"+ 
								GetConcentration(Eval("partnumber").ToString())+"</td>" %>
							</tr>
							<tr>
								<td class="headerColumns" colspan='2'>Matrix</td>
								<td colspan='2'><%# Eval("Matrix") %></td>
							</tr>
							<tr>
								<td class="headerColumns" colspan='2'>Vol.</td>
								<td colspan='2' class='grayTD'><%# Eval("Volume") %></td>
							</tr>
							<tr>
								<td class="headerColumns" colspan='2'>Unit</td>
								<td colspan='2'><%# Eval("UnitPack") %></td>
							</tr>
							<tr>
								<td class="headerColumns" colspan='2'>Price</td>
								<td colspan='2' class='grayTD'><%# GetPrice(Eval("partnumber").ToString())%></td>
							</tr>
							<tr>
								<td class="headerColumns" colspan='2'>Add to Cart</td>
								<td colspan="2" class="topBorderTD">
									<input name='quantity_<%# Eval("partnumber") %>' type="text" id='quantity_<%# Eval("partnumber") %>' class="search_quantity" value="1" /><input type="button" id='buy_<%# Eval("partnumber") %>' name='buy_<%# Eval("partnumber") %>' value="" class="search_buy" onclick="buyIt('<%# Eval("partnumber") %>');" /></td>
								</td>
							</tr>
						</table>
                    </ItemTemplate>
                    <EmptyDataTemplate>
                        <div style="font-size:1.2em">
							<p>No Results</p>
                        </div>
                    </EmptyDataTemplate>
                </asp:ListView> 
            </div>			
			<asp:DataPager ID="ProductListMobilePager" ClientIDMode="Static" runat="server" PagedControlID="lvProductsMobile" PageSize="10" QueryStringField="page">
                <Fields>
                    <asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="true" FirstPageText="&lt;&lt;" PreviousPageText="&lt;" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
                    <asp:NumericPagerField RenderNonBreakingSpacesBetweenControls="false" />
                    <asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="true" LastPageText="&gt;&gt;" NextPageText="&gt;" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
                </Fields>
            </asp:DataPager> 
		</div>
    </div>
    <asp:SqlDataSource ID='dataTechnique' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT * FROM cp_roi_AnTechs ORDER BY CatName" SelectCommandType="Text">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataFamily' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT * FROM cp_roi_Families WHERE cfTypeID = '1' ORDER BY cfFamily" SelectCommandType="Text">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataMethod' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT * FROM cp_roi_Methods ORDER BY cmName" SelectCommandType="Text">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataProducts' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommandType="Text" onselected="dataProducts_Selected">
    </asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script src="/js/jquery-ui.js" type="text/javascript"></script>
	<script src="/js/jquery.tablesorter.min.js" type="text/javascript"></script>
	<!--<script> jQuery.noConflict(); </script>-->
    <script type="text/javascript">
        $(document).ready(function () {
            $(".tablesorter tr:odd").addClass("odd");
			$(".various_method").click(function(){
				var part = $(this).attr('data-partnum');
				jQuery.ajax({
					url: 'search_organic_category.aspx/GetDataMethod',
					type: "POST",
					data: JSON.stringify({ partnumber: part }),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						jQuery('#method-container .method-ref').html(data.d);
					}
				});
				$('#method-container-opacity').insertAfter(".mask-layout");
				$('#method-container-opacity').show(500);
				$(".mask-layout").show();
				$(".mask-layout").css("height", $("body").height());
			});
			$(".various_cascon").click(function(){
				var part = $(this).attr('data-partnum');
				jQuery.ajax({
					url: 'search_organic_category.aspx/GetDataCAS',
					type: "POST",
					data: JSON.stringify({ partnumber: part }),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						jQuery('#cas-container .CAStable').html(data.d);
					}
				});
				$('#cas-container-opacity').insertAfter(".mask-layout");
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
        /*    $("span#footer_cart").load("/utility/addtocart.aspx?productid=" + productid + "&pq=" + theQuantity, function () {
                $("#totalitems").effect("highlight", { color: "#ffffff" }, 5000);
                $("#totalcost").effect("highlight", { color: "#ffffff" }, 5000);
                $("#totalsavings").effect("highlight", { color: "#ffffff" }, 5000);
                $("#SPoints").effect("highlight", { color: "#ffffff" }, 5000);
            });*/
			$("#footer_cart").load("/utility/addtocart.aspx?productid=" + productid + "&pq=" + theQuantity, function () {
                //$("#totalitems").effect("highlight", { color: "#FFFFFF" }, 5000);
                $("#totalcost").effect("highlight", { color: "#ffffff" }, 5000);
                $("#totalsavings").effect("highlight", { color: "#ffffff" }, 5000);
                $("#SPoints").effect("highlight", { color: "#ffffff" }, 5000);
            });
            //document.getElementById("buy_"+productid).value=" - ";
            $("#buy_" + productid).removeClass("search_buy");
            $("#buy_" + productid).addClass("search_buy_clicked");
            //$("#buy_" + productid).effect("highlight", { color: "#FFFFFF" }, 2000);
        }
		$(document).ready(function() { 
			$(".tablesorter").tablesorter({
				headers: {
					4: {sorter: false}, 
					5: {sorter: false}, 
					6: {sorter: false}, 
					7: {sorter: false}, 
					8: {sorter: false}, 
					9: {sorter: false}
				}
			}); 
		}); 
    </script>
	<script>
		$(function() {
			try {
				$("#technique").msDropDown();
				$("#s_method").msDropDown();
				$("#family").msDropDown();
			} catch (e) {
				alert(e.message);
			}
		});
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
	});
	</script>
</asp:Content>

