<%@ Page Title="Inorganic Product Search | SPEX CertiPrep" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="searchinorganic.aspx.cs" Inherits="searchinorganic" debug="true"%>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <style type="text/css">
        a.aspNetDisabled { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        a.aspNetDisabled:hover { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        #ProductListPagerSimple span,
        #ProductListPagerSimple2 span { font-weight:bold; }
		p{font-size:1.15em;}
		select, select:hover, select:active, select:focus { width:250px; }
		.select-tech { width:250px; }
    </style>
    <script src="/js/jquery-ui.js" type="text/javascript"></script>
	<script src="/js/jquery.tablesorter.min.js" type="text/javascript"></script>	
    <script type="text/javascript">
        $(document).ready(function () {
            $(".tablesorter tr:odd").addClass("odd");
            $(".various_cascon").click(function(){
                var part = $(this).attr('data-partnum');
                jQuery.ajax({
                    url: 'search_inorganic_category.aspx/GetDataCAS',
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
                $("#SPoints").effect("highlight", { color: "#ffffff" }, 5000);
            });
            //document.getElementById("buy_"+productid).value=" - ";
            $("#buy_" + productid).removeClass("search_buy");
            $("#buy_" + productid).addClass("search_buy_clicked");
            //$("#buy_" + productid).effect("highlight", { color: "#ffffff" }, 1000);
        }

        $(document).ready(function () {
            $("#productdata_table tr:odd").addClass("odd");
        });
        $(document).ready(function() { 
            $(".tablesorter").tablesorter({
                headers: {
                    2: {sorter: false},
                    3: {sorter: false},					
                    4: {sorter: false}, 
                    5: {sorter: false}, 
                    6: {sorter: false}, 
                    7: {sorter: false}
                }
            }); 
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
    <style type="text/css">
        .searchresult_heading a {color:#333; font-weight:bold; text-decoration:none; display:block; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="default.aspx">Home</a> > Search</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
		<!--CAS Pop Up-->
		<div id="cas-container-opacity">
			<div id="cas-container">
				<div class="close-x"></div>
				<div class="CAStable"></div>
			</div>
		</div>
		<!--EOF CAS Pop Up-->
		
    	<div id="main">
            <h1>Search Results - &quot;<%=SearchTerm%>&quot;</h1>
			<p style="font-weight:bold">Can't find what you're looking for?<br />
				Request a custom <a href="/products/custom-standards_inorganic.aspx">Inorganic</a> or <a href="/products/custom-standards_organic.aspx">Organic</a> standard.</p>
			<asp:Panel ID="pnlPerPage" runat="server" style="text-align:right">
				<div class="resTxt" style="text-align: right;">Results per page:
					<asp:DropDownList ID="lbResults" runat="server" AutoPostBack="True" CssClass="page-filter" OnSelectedIndexChanged="lbResults_Change">
						<asp:ListItem Value="25" Text="25" />
						<asp:ListItem Value="50" Text="50" />
					</asp:DropDownList>
				</div>
			</asp:Panel>
			<div class="floatbox">
                <div class="searchresult_heading" id="organic_results">
                    <a href="search.aspx?l=1&search=<%= Server.UrlEncode(SearchTerm)%>">Organic (<asp:Literal ID="ltrOrganicCount" runat="server" />)</a>
                </div>
                <div class="searchresult_heading searchresult_heading_selected" id="inorganic_results">
                    Inorganic (<asp:Literal ID="ltrInorganicCount" runat="server" />)
                </div>
                <div class="searchresult_heading" id="lab_results">
                    <a href="searchlab.aspx?l=1&search=<%= Server.UrlEncode(SearchTerm)%>">Lab Stuff (<asp:Literal ID="ltrLabCount" runat="server" />)</a>
                </div>
            </div>
            <div id="resultstable">
                <div class="productcontent" id="productcontent_Product">
                    <div style="margin:0 0 6em">
                        <table align="center" style="width:100%" class="tablesorter">
                            <thead>
                                <tr>
                                    <td style="text-align:left;" colspan="8">
									<h2 class="product-filter">Product Filter</h2>
									<span class="filters">
                                        <!--<asp:Label ID="lblTechnique" AssociatedControlID="technique" runat="server" Text="Analytical Technique:" />-->
									<div class="select-wrap inorganic">
								        <!--<div class="selectbgProdList">
									        <div class="IEmagicProdList">-->
												<asp:DropDownList ID="technique" ClientIDMode="Static" DataSourceID="dataTechnique" CssClass="select-tech" DataValueField="cfID" DataTextField="cfFamily" runat="server" AppendDataBoundItems="true">
													<asp:ListItem Value="0" Text="-- Select Analytical Technique --" />
												</asp:DropDownList>&nbsp;&nbsp;
									        <!--</div>
								        </div>-->
									</div>
									<div class="select-wrap">
								        <!--<div class="selectbgProdList">
									        <div class="IEmagicProdList">-->
												<!--<asp:Label ID="lblCategory" AssociatedControlID="category" runat="server" Text="Category:" />-->
												<asp:DropDownList ID="category" ClientIDMode="Static" DataSourceID="dataCategory" CssClass="select-tech" DataValueField="ccID" DataTextField="ccCategory" runat="server" AppendDataBoundItems="true">
													<asp:ListItem Value="0" Text="-- Select Category --" />
												</asp:DropDownList>&nbsp;&nbsp;
									        <!--</div>
								        </div>-->
									</div>
                                        <asp:Button ID="cmdFilter" Text="" CssClass="filter-btn" runat="server" onclick="cmdFilter_Click" />
									</span>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="col" class="header sorter">Part #</th>
                                    <th scope="col" class="header sorter">Product Name</th>
                                    <th scope="col">Concentration</th>
                                    <th scope="col">Matrix</th>
                                    <th scope="col">Volume</th>
                                    <th scope="col">Unit/Pk</th>
                                    <th scope="col">Price</th>
                                    <th scope="col">Add to Cart</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:ListView ID="lvProducts" runat="server" DataSourceID="dataProducts">
                                    <LayoutTemplate>
                                                <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <tr>
			                                <td class="desc" nowrap><b><a href='products/product_inorganic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("partnumber") %></a></b></td>
			                                <td class="desc"><b><a href='products/product_inorganic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("title") %></a></b></td>
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
			                                    <input name='quantity_<%# Eval("partnumber") %>' type="text" id='quantity_<%# Eval("partnumber") %>' class="search_quantity" value="1" />
			                                    <input type="button" id='buy_<%# Eval("partnumber") %>' name='buy_<%# Eval("partnumber") %>' value="" class="search_buy" onclick="buyIt('<%# Eval("partnumber") %>');" /></td>
			                                </td>
                                        </tr>
                                    </ItemTemplate>
                                    <EmptyDataTemplate>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td class="desc">No Results</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                    </EmptyDataTemplate>
                                </asp:ListView> 
                            </tbody>
                        </table>
                        <asp:DataPager ID="ProductListPagerSimple2" ClientIDMode="Static" runat="server" PagedControlID="lvProducts" PageSize="25" QueryStringField="page" >
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
											<asp:DropDownList ID="techniqueMobile" ClientIDMode="Static" DataSourceID="dataTechnique" CssClass="select-tech" DataValueField="cfID" DataTextField="cfFamily" runat="server" AppendDataBoundItems="true">
												<asp:ListItem Value="0" Text="-- Select Analytical Technique --" />
											</asp:DropDownList>&nbsp;&nbsp;
										</div>
									</div>
								</div>
								<div class="select-wrap">
									<div class="selectbgProdList">
										<div class="IEmagicProdList">
											<asp:DropDownList ID="categoryMobile" ClientIDMode="Static" DataSourceID="dataCategory" CssClass="select-tech" DataValueField="ccID" DataTextField="ccCategory" runat="server" AppendDataBoundItems="true">
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
												<a href='products/product_inorganic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("title") %></a>
											</td>
										</tr>
										<tr>
											<td class="headerColumns" colspan="2" style="width:35%">Part #</td>
											<td colspan='2' class="topBorderTD">
												<a href='products/product_inorganic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("partnumber") %></a>
											</td>
										</tr>
										<tr>
											<td class="headerColumns" colspan='2'>Concentration</td>
											<%# (GetConcentration(Eval("partnumber").ToString()) == "Various") ? "<td class='grayTD' style='white-space:nowrap;'><a href='javascript:void()' class='various_cascon' data-partnum='"+
											Eval("partnumber")+"'>"+ 
											GetConcentration(Eval("partnumber").ToString())+"</a></td>" : "<td class='grayTD'>"+ 
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
												<input name='quantity_<%# Eval("partnumber") %>' type="text" id='quantity_<%# Eval("partnumber") %>' class="search_quantity" value="1" /><input type="button" id='buy_<%# Eval("partnumber") %>' name='buy_<%# Eval("partnumber") %>' value="" class="search_buy" onclick="buyIt('<%# Eval("partnumber") %>    ');" /></td>
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
                <div class="productcontent hidden" id="productcontent_Accessory">
                </div>
                <div class="productcontent hidden" id="productcontent_Resources">
                </div>
		    </div>
        </div>

    <asp:SqlDataSource ID='dataTechnique' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT * FROM cp_roi_Families WHERE cfTypeID = 2 ORDER BY cfFamily" SelectCommandType="Text">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataCategory' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT DISTINCT ccID, ccCategory FROM cp_roi_Cats WHERE ccFamilyID = @tech ORDER BY ccCategory" SelectCommandType="Text">
        <SelectParameters>
            <asp:QueryStringParameter Name="tech" Type="Int32" DefaultValue="1" QueryStringField="tech" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataProducts' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommandType="Text" onselected="dataProducts_Selected">
    </asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
</asp:Content>

