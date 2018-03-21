<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="qc-samples.cs" Inherits="qc_sample" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <style type="text/css">
        a.aspNetDisabled { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        a.aspNetDisabled:hover { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        #ProductListPagerSimple span,
        #ProductListPagerSimple2 span { font-weight:bold; }
    </style>
    <script src="/js/jquery-ui.js" type="text/javascript"></script>
	<script src="/js/jquery.tablesorter.min.js" type="text/javascript"></script>	
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
		$(document).ready(function() 
			{ 
				$(".tablesorter").tablesorter({
					headers: {
						3: {sorter: false},
						4: {sorter: false}
					}
				}); 
			} 
		); 			
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/">Home</a> > QC Samples</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
	<div id="category_description">
		The end-product of most analytical laboratories is data. It is therefore imperative that the quality of the data produced meet or exceed performance criteria. The implementation of quality control processes helps control error and estimate uncertainty. Quality control can be a tool in method development, regulatory processes, laboratory training and performance monitoring. QC samples can help an analytical laboratory determine its precision, accuracy, linear range and method ruggedness. QC samples allow the laboratories to fulfill documentation requirements as well as correct errors in a root cause analysis of a possible failure. Finally, QC samples monitor the effectiveness of laboratory analysis to produce accurate data.
		<br><br>
		All of ERA's QC samples have been tested in-house with the USEPA, NIST, NELAC and ISO protocols to ensure accuracy, homogeneity and stability.
	</div>
	<br>
	<div class="category-header">
		<h1>QC Samples - <%=String.Format("{0:##,###,##0}", ProductCount)  %> items</h1>
	</div>
            
    <div id="resultstable">
		<div class="pagers1_wrapper">
			<asp:Panel ID="pnlPerPage" runat="server" style="text-align:right">
				<span class="rpp"> Results per page:</span>
				<div class="selectbgPagi">
					<div class="IEmagicPagi">
						<asp:DropDownList ID="lbResults" runat="server" AutoPostBack="True" CssClass="page-filter" OnSelectedIndexChanged="lbResults_Change">
							<asp:ListItem Value="25" Text="25" />
							<asp:ListItem Value="50" Text="50" />
						</asp:DropDownList>
					</div>
				</div>
			</asp:Panel>
					
							
			<asp:DataPager ID="ProductListPagerSimple" ClientIDMode="Static" runat="server" PagedControlID="lvProducts" PageSize="25" QueryStringField="page">
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
                    <tr>
                        <th scope="col" id="partnumber" class="header sorter">Part #</th>
                        <th scope="col" id="title" class="header sorter">Product Name</th>
                        <th scope="col" class="header sorter">Unit/Pk</th>
                        <th scope="col" id="price" >Price</th>
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
                                <td class="desc">
									<b>
									<a href='<%# GetLink(Eval("Type").ToString())%>?part=<%# Eval("partnumber") %>'><%# Eval("partnumber") %></a>
									</b>
								</td>
                                <td class="desc">
									<b><a href='<%# GetLink(Eval("Type").ToString())%>?part=<%# Eval("partnumber") %>'><%# Eval("title") %></a></b>
								</td>
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
							<tr>
								<td colspan="4" class="fullTD">
									<a href='<%# GetLink(Eval("Type").ToString())%>?part=<%# Eval("partnumber") %>'><%# Eval("title") %></a>
								</td>
							</tr>
							<tr>
								<td class="headerColumns" colspan="2" style="width:35%">Part #</td>
								<td class="topBorderTD" colspan="2">
									<a href='<%# GetLink(Eval("Type").ToString())%>?part=<%# Eval("partnumber") %>'><%# Eval("partnumber") %></a>
								</td>
							</tr>
							<tr>
								<td class="headerColumns" colspan='2'>Unit/Pk</td>
								<td colspan='2' class='grayTD'><%# Eval("UnitPack") %></td>
							</tr>
							<tr>
								<td class="headerColumns" colspan='2'>Price</td>
								<td colspan='2'><%# GetPrice(Eval("partnumber").ToString())%></td>
							</tr>
							<tr>
								<td class="headerColumns" colspan='2'>Add to Cart</td>
								<td colspan="2" class="topBorderTD grayTD">
									<input name='quantity_<%# Eval("partnumber") %>' type="text" id='quantity_<%# Eval("partnumber") %>' class="search_quantity" value="1" />
									<input type="button" id='buy_<%# Eval("partnumber") %>' name='buy_<%# Eval("partnumber") %>' value="" class="search_buy" onclick="buyIt('<%# Eval("partnumber") %>');" />
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
    <asp:SqlDataSource ID='dataProducts' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT cp.cpType AS Type, cp.cpPart AS PartNumber, cp.cpDescrip AS Title, cp.cpUnitCnt AS UnitPack FROM cp_roi_Prods cp WHERE cp.cpDescrip LIKE '%QC Sample%' AND cp.For_Web = 'Y' ORDER BY cp.cpDescrip" SelectCommandType="Text" onselected="dataProducts_Selected">
    </asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
</asp:Content>

