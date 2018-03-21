<%@ Page Title="SPEX CertiPrep Search" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="searchlab.aspx.cs" Inherits="searchlab" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <style type="text/css">
        a.aspNetDisabled { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        a.aspNetDisabled:hover { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        #ProductListPagerSimple span,
        #ProductListPagerSimple2 span { font-weight:bold; }
    </style>
    <script src="/js/jquery-ui.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".tablesorter tr:odd").addClass("odd");
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
    </script>
    <style type="text/css">
        .searchresult_heading a {color:#333; font-weight:bold; text-decoration:none; display:block; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="default.aspx">Home</a> > Search</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
    	<div id="main">
            <h1>Search Results - &quot;<%=SearchTerm%>&quot;</h1>
			<p style="font-weight:bold">Can't find what you're looking for?<br />
				Request a custom <a href="/products/custom-standards_inorganic.aspx">Inorganic</a> or <a href="/products/custom-standards_organic.aspx">Organic</a> standard.</p>
				<div class="resTxt" style="text-align: right; margin: 1.5em 0 0;">Results per page:
					<asp:DropDownList ID="lbResults" runat="server" AutoPostBack="True" CssClass="page-filter" OnSelectedIndexChanged="lbResults_Change">
										<asp:ListItem Value="50" Text="50" />
										<asp:ListItem Value="100" Text="100" />
					</asp:DropDownList>
				</div>
				<div class="floatbox">
                <div class="searchresult_heading" id="organic_results">
                    <a href="search.aspx?l=1&search=<%= Server.UrlEncode(SearchTerm)%>">Organic (<asp:Literal ID="ltrOrganicCount" runat="server" />)</a>
                </div>
                <div class="searchresult_heading" id="inorganic_results">
                    <a href="searchinorganic.aspx?l=1&search=<%= Server.UrlEncode(SearchTerm)%>">Inorganic (<asp:Literal ID="ltrInorganicCount" runat="server" />)</a>
                </div>
                <div class="searchresult_heading searchresult_heading_selected" id="lab_results">
                    Lab Stuff (<asp:Literal ID="ltrLabCount" runat="server" />)
                </div>
            </div>
            <div id="resultstable">
                <div class="productcontent" id="productcontent_Product">
                    <div style="margin:0 0 6em">
                        <table align="center" style="width:100%" class="tablesorter">
                            <thead>
                                <tr>
                                    <th scope="col" id="partnumber" onclick="doSort('partnumber')" class="header">Part #</th>
                                    <th scope="col" id="title" onclick="doSort('title')" class="header">Description</th>
                                    <th scope="col" id="price" onclick="doSort('price')" class="header">Price</th>
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
                                            <td><b><%# Eval("partnumber") %></b></td>
                                            <td class="desc"><b><a href='products/product_labstuff.aspx?part=<%# Eval("partnumber") %>'><%# Eval("title") %></a></b></td>
                                            <td style="text-align:right;white-space:nowrap;"><%# GetPrice(Eval("partnumber").ToString())%></td>
                                            <td class="buybutton" style="white-space:nowrap;">
                                                <input name='quantity_<%# Eval("partnumber") %>' type="text" id='quantity_<%# Eval("partnumber") %>' class="search_quantity" value="1" /><input type="button" id='buy_<%# Eval("partnumber") %>' name='buy_<%# Eval("partnumber") %>' value="" class="search_buy" onclick="buyIt('<%# Eval("partnumber") %>');" /></td>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                    <EmptyDataTemplate>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td class="desc">No Results</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                    </EmptyDataTemplate>
                                </asp:ListView> 
                            </tbody>
                        </table>
                        <asp:DataPager ID="ProductListPagerSimple2" ClientIDMode="Static" runat="server" PagedControlID="lvProducts" PageSize="50" QueryStringField="page">
                            <Fields>
                                <asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="true" RenderDisabledButtonsAsLabels="true" FirstPageText="&lt;&lt;" PreviousPageText="&lt;" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
                                <asp:NumericPagerField RenderNonBreakingSpacesBetweenControls="false" />
                                <asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="true" RenderDisabledButtonsAsLabels="true" LastPageText="&gt;&gt;" NextPageText="&gt;" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
                            </Fields>
                        </asp:DataPager> 
						<div id="mobile-tablesorter">
							<asp:ListView ID="lvProductsMobile" runat="server" DataSourceID="dataProducts">
								<LayoutTemplate>
									<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
								</LayoutTemplate>
								<ItemTemplate>
									<table class="mobile-result-table">
										<tr><td colspan="4" class="fullTD"><a href='products/product_labstuff.aspx?part=<%# Eval("partnumber") %>'><%# Eval("title") %></a></td></tr>
										<tr>
											<td class="headerColumns" colspan="2" style="width:35%">Part #</td>
											<td colspan="2" class="topBorderTD"><%# Eval("partnumber") %></td>
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
									<table class="mobile-result-table">
										<tr><td colspan="4" class="fullTD">No Result</a></td></tr>
										<tr>
											<td class="headerColumns" colspan="2" style="width:35%">Part #</td>
											<td colspan="2" class="topBorderTD"></td>
										</tr>
										<tr>
											<td class="headerColumns" colspan='2'>Price</td>
											<td colspan='2' class='grayTD'></td>
										</tr>
										<tr>
											<td class="headerColumns" colspan='2'>Add to Cart</td>
											<td colspan="2" class="topBorderTD">
											</td>
										</tr>
									</table>
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

    <asp:SqlDataSource ID='dataProducts' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT cp.cpPart AS PartNumber, cp.cpDescrip AS Title, cp.cpUnitCnt AS UnitPack FROM  cp_roi_Prods cp WHERE cp.cpType = 6 AND cp.For_Web = 'Y' AND (cpLongDescrip LIKE @SearchTerm OR cpPart LIKE @SearchTerm) ORDER BY cp.cpDescrip" SelectCommandType="Text">
        <SelectParameters>
            <asp:Parameter Name="SearchTerm" Type="String" Size="27" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
</asp:Content>

