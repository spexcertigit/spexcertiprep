<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="search_inorganic_category.aspx.cs" Inherits="search_organic_category" Debug="true"%>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <style type="text/css">
        a.aspNetDisabled { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        a.aspNetDisabled:hover { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        #ProductListPagerSimple span,
        #ProductListPagerSimple2 span { font-weight:bold; }
		.buybutton { border-right: 1px solid #727272; }
    </style>
    
</asp:Content>
<asp:Content ID="cpBanner" ContentPlaceHolderID="cpPageBanner" runat="server">
	<%
		if (bannerImg != "") {
	%>
		<div id="banner-div" class="inorganic-standards">
			<img src="/images/banner/<%=bannerImg%>" alt="Banner" />
		</div>
	<%
		}
	%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/">Home</a> > Inorganic Standards</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
	<!--CAS Pop Up-->
	<div id="cas-container-opacity">
		<div id="cas-container">
			<div class="close-x"></div>
			<div class="CAStable"></div>
		</div>
	</div>
	<!--EOF CAS Pop Up-->

	<div id="category_description">
		<%=sDesc%>
	</div>
	<br />	
	
	<div class="category-header">
		<h1><%=sTitle%> - <%=String.Format("{0:##,###,##0}", ProductCount)  %> Inorganic Standards</h1>
	</div>
	
    <div id="resultstable">
		<!--<div style="text-align: right; margin: 1.5em 0 0;">-->
		<div class="pagers1_wrapper">
			<asp:Panel ID="pnlPerPage" runat="server" style="text-align:right">
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
					
							
			<asp:DataPager ID="ProductListPagerSimple" ClientIDMode="Static" runat="server" PagedControlID="lvProducts" PageSize="25" QueryStringField="page" OnInit="DataPager_Init">
				<Fields>
					<asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="true" RenderDisabledButtonsAsLabels="true" FirstPageText="&lt;&lt;" PreviousPageText="&lt;" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
					<asp:NumericPagerField RenderNonBreakingSpacesBetweenControls="false" />
					<asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="true" RenderDisabledButtonsAsLabels="true" LastPageText="&gt;&gt;" NextPageText="&gt;" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
				</Fields>
			</asp:DataPager>
			<div style="clear:both"></div>
		</div>
        <div style="margin:1.5em 0 6em"> 
            <table width="958" class="tablesorter" align="center" >
                <thead>
                    <tr style="border:none;">
                        <td style="text-align:left;" colspan="8">
							<span class="product-filter">Product Filter</span>
							<span class="filters">
							<div class="select-wrap">
								<asp:DropDownList ID="category" CssClass="select-tech" ClientIDMode="Static" DataSourceID="dataCategory" DataValueField="ccID" DataTextField="ccCategory" runat="server" AppendDataBoundItems="true" AutoPostBack="true" onselectedindexchanged="selectedChange">
                    	            <asp:ListItem Value="" Text="-- Select Category --" />
									<asp:ListItem Value="0" Text="All" />
                                </asp:DropDownList>&nbsp;&nbsp;
							</div>
							<div class="select-wrap inorganic">
								<asp:DropDownList ID="technique" CssClass="select-tech" ClientIDMode="Static" DataSourceID="dataTechnique" DataValueField="slug" DataTextField="cfFamily" runat="server" AppendDataBoundItems="true" AutoPostBack="true" onselectedindexchanged="techChange">
                                    <asp:ListItem Value="0" Text="-- Select Analytical Technique --" />
                                </asp:DropDownList>&nbsp;&nbsp;
							</div>
                            	<asp:Button ID="cmdFilter" Text="" runat="server" CssClass="filter-btn" onclick="cmdFilter_Click" />
							</span>
                        </td>
                    </tr>
                    <tr>
                        <th scope="col" id="partnumber" onclick="doSort('partnumber')" class="header sorter">Part #</th>
                        <th scope="col" id="title" onclick="doSort('title')" class="header sorter">Product Name</th>
                        <th scope="col" class="header sorter">Conc.</th>
                        <th scope="col" id="matrix" onclick="doSort('matrix')" class="">Matrix</th>
                        <th scope="col" id="volume" onclick="doSort('volume')" class="">Volume</th>
                        <th scope="col" >Unit/Pk</th>
                        <th scope="col" id="price" onclick="doSort('price')" class="">Price</th>
                        <th scope="col" style="border-right:1px solid;">Add to Cart</th>
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
            <asp:DataPager ID="ProductListPagerSimple2" ClientIDMode="Static" runat="server" PagedControlID="lvProducts" PageSize="25" QueryStringField="page" OnInit="DataPager_Init">
                <Fields>
                    <asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="true" RenderDisabledButtonsAsLabels="true" FirstPageText="&lt;&lt;" PreviousPageText="&lt;" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
                    <asp:NumericPagerField RenderNonBreakingSpacesBetweenControls="false" />
                    <asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="true" RenderDisabledButtonsAsLabels="true" LastPageText="&gt;&gt;" NextPageText="&gt;" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
                </Fields>
            </asp:DataPager> 
			<div id="mobile-tablesorter">
				<div class="mobile-product-filter">
					<h1 class="product-filter">Product Filter</h1>
					<div class="select-wrap">
						<div class="selectbgProdList">
							<div class="IEmagicProdList">
								<asp:DropDownList ID="techniqueMobile" AutoPostBack="true" CssClass="select-tech" ClientIDMode="Static" DataSourceID="dataTechnique" DataValueField="slug" DataTextField="cfFamily" runat="server" AppendDataBoundItems="true" onselectedindexchanged="techChange">
									<asp:ListItem Value="0" Text="-- Select Analytical Technique --" />
								</asp:DropDownList>&nbsp;&nbsp;
							</div>
						</div>
					</div>
					<div class="select-wrap">
						<div class="selectbgProdList">
							<div class="IEmagicProdList">
								<asp:DropDownList ID="categoryMobile" CssClass="select-tech" ClientIDMode="Static" DataSourceID="dataCategory" DataValueField="ccID" DataTextField="ccCategory" runat="server" AppendDataBoundItems="true">
									<asp:ListItem Value="0" Text="-- Select Category --" />
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
							<tr>
								<td colspan="4" class="fullTD">
									<a href='/products/product_inorganic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("title") %></a>
								</td>
							</tr>
							<tr>
								<td class="headerColumns" colspan='2'>Part #</td>
								<td colspan='2' class="topBorderTD"><a href='/products/product_inorganic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("partnumber") %></a></td>
							</tr>
							<tr>
								<td class="headerColumns" colspan="2" style="width:35%">Concentration</td>
								<%# (GetConcentration(Eval("partnumber").ToString()) == "Various") ? "<td colspan='2' class='grayTD' style='white-space:nowrap;'>"+ 
								GetConcentration(Eval("partnumber").ToString())+"<img src='/images/modal-tooltip.png' /></td>" : "<td class='grayTD' colspan='2'>"+ 
								GetConcentration(Eval("partnumber").ToString())+"</td>" %>
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
									<input name='quantity_<%# Eval("partnumber") %>' type="text" id='m_quantity_<%# Eval("partnumber") %>' class="search_quantity" value="1" /><input type="button" id='mbuy_<%# Eval("partnumber") %>' name='buy_<%# Eval("partnumber") %>' value="" class="search_buy" onclick="buyItM('<%# Eval("partnumber") %>');" /></td>
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
			<asp:DataPager ID="ProductListMobilePager" ClientIDMode="Static" runat="server" PagedControlID="lvProductsMobile" PageSize="10" QueryStringField="page" OnInit="DataPager_Init">
                <Fields>
                    <asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="true" FirstPageText="&lt;&lt;" PreviousPageText="&lt;" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
                    <asp:NumericPagerField RenderNonBreakingSpacesBetweenControls="false" />
                    <asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="true" LastPageText="&gt;&gt;" NextPageText="&gt;" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
                </Fields>
            </asp:DataPager> 
		</div>
		
		<script type="application/ld+json">
		{
		 "@context": "http://schema.org",
		 "@type": "BreadcrumbList",
		 "itemListElement":
		 [
		  {
		   "@type": "ListItem",
		   "position": 1,
		   "item":
		   {
			"@id": "http://www.spexcertiprep.com/products/inorganic/",
			"name": "Inorganic Certified Reference Materials"
			}
		  },
		  {
		   "@type": "ListItem",
		  "position": 2,
		  "item":
		   {
			 "@id": "http://www.spexcertiprep.com/search_inorganic_category.aspx?cat=<%=Request.QueryString["cat"]%>",
			 "name": "<%=sTitle%>"
		   }
		  }
		 ]
		}
		</script>
    </div>
    <asp:SqlDataSource ID='dataTechnique' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT * FROM cp_roi_Families WHERE cfTypeID = 2 ORDER BY cfFamily" SelectCommandType="Text">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataCategory' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT DISTINCT ccID, ccCategory FROM cp_roi_Cats WHERE ccFamilyID = @Family ORDER BY ccCategory" SelectCommandType="Text">
        <SelectParameters>
            <asp:QueryStringParameter Name="Family" Type="Int32" DefaultValue="1" QueryStringField="cat" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataProducts' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommandType="Text" onselected="dataProducts_Selected">
    </asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script src="/js/jquery-ui.js" type="text/javascript"></script>
	<script src="/js/jquery.tablesorter.min.js" type="text/javascript"></script>	
    <script type="text/javascript">
        $(document).ready(function () {
			$(".tablesorter tr:odd").addClass("odd");
			
			$(".various_cascon").click(function(){
				var part = $(this).attr('data-partnum');
				jQuery.ajax({
					url: '/search_inorganic_category.aspx/infoin',
					type: "POST",
					data: JSON.stringify({ partnumber: part }),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						jQuery('#cas-container .CAStable').html(data.d);
					},
					error: function (x, y, z) {
						alert(x + '\n' + y + '\n' + z);
						
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
            $("#footer_cart").load("/utility/addtocart.aspx?productid=" + productid + "&pq=" + theQuantity, function () {
                $("#totalcost").effect("highlight", { color: "#ffffff" }, 5000);
                $("#totalsavings").effect("highlight", { color: "#ffffff" }, 5000);
                $("#SPoints").effect("highlight", { color: "#ffffff" }, 5000);
            });
            $("#buy_" + productid).removeClass("search_buy");
            $("#buy_" + productid).addClass("search_buy_clicked");
        }
		function buyItM(productid) {
            theQuantity = document.getElementById("m_quantity_" + productid).value;
            if(theQuantity == '' || theQuantity == '0' ) {
            	alert('Quantity must be greater than 0');
            	return false;
            }
            $("#footer_cart").load("/utility/addtocart.aspx?productid=" + productid + "&pq=" + theQuantity, function () {
                $("#totalcost").effect("highlight", { color: "#ffffff" }, 5000);
                $("#totalsavings").effect("highlight", { color: "#ffffff" }, 5000);
                $("#SPoints").effect("highlight", { color: "#ffffff" }, 5000);
            });
            $("#mbuy_" + productid).removeClass("search_buy");
            $("#mbuy_" + productid).addClass("search_buy_clicked");
        }
		$(document).ready(function() 
			{ 
				$(".tablesorter").tablesorter({
					headers: {
						3: {sorter: false}, 
						4: {sorter: false}, 
						5: {sorter: false}, 
						6: {sorter: false}, 
						7: {sorter: false}
					}
				}); 
				
			} 
		); 		
    </script>   
</asp:Content>

