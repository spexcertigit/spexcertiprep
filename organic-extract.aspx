<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="organic-extract.cs" Inherits="search_organic_category"  Debug="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
	<link href="/css/easydropdown.css" rel="stylesheet" type="text/css" charset="utf-8" />
    <style type="text/css">
        a.aspNetDisabled { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        a.aspNetDisabled:hover { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        #ProductListPagerSimple span,
        #ProductListPagerSimple2 span { font-weight:bold; }
    </style>
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
			$("#footer_cart").load("/utility/addtocart.aspx?productid=" + productid + "&pq=" + theQuantity, function () {
                $("#totalcost").effect("highlight", { color: "#ffffff" }, 5000);
                $("#totalsavings").effect("highlight", { color: "#ffffff" }, 5000);
                $("#SPoints").effect("highlight", { color: "#ffffff" }, 5000);
            });
            $("#buy_" + productid).removeClass("search_buy");
            $("#buy_" + productid).addClass("search_buy_clicked");
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/">Home</a> > Organic Standards</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
	<!--Method Pop Up-->
	<div id="method-container-opacity">
		<div class="close-x"></div>
		<div id="method-container">
			<div class="method-ref">
			</div>
		</div>
	</div>
	<!--EOF Method Pop Up-->
	
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
		<h1><%=sTitle%> - <%=String.Format("{0:##,###,##0}", ProductCount)  %> Organic Standards</h1>
	</div>
            
    <div id="resultstable">
        <!--<div style="text-align: right; margin: 1.5em 0 0;">-->
		<div class="pagers1_wrapper">
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
								
			<div style="clear:both"></div>
		</div>
        <div style="margin:1.5em 0 6em"> 
            <table width="958" class="tablesorter" align="center" >
                <thead>
                    <tr style="border:none;">
                        <td style="text-align:left;" colspan="10">
							<span class="product-filter">Product Filter</span>
							<span class="filters">
							<div class="select-wrap">
								<asp:DropDownList ID="family" CssClass="select-tech" ClientIDMode="Static" DataSourceID="dataFamily" DataValueField="slug" DataTextField="cfFamily" runat="server" AppendDataBoundItems="true" AutoPostBack="true" onselectedindexchanged="familyChange">
									<asp:ListItem Value="" Text="-- Select Application --" />
									<asp:ListItem Value="0" Text="All" />
								</asp:DropDownList>&nbsp;&nbsp;
							</div>
							<div class="select-wrap">
								<asp:DropDownList ID="s_method" CssClass="select-tech" ClientIDMode="Static" DataSourceID="dataMethod" DataValueField="cmid" DataTextField="cmName" runat="server" AppendDataBoundItems="true" AutoPostBack="true" onselectedindexchanged="selectedChange">
									<asp:ListItem Value="" Text="-- Select Method --" />
									<asp:ListItem Value="0" Text="All" />
								</asp:DropDownList>&nbsp;&nbsp;
							</div>
                            <div class="select-wrap">
								<asp:DropDownList ID="technique" CssClass="select-tech" ClientIDMode="Static" DataSourceID="dataTechnique" DataValueField="slug" DataTextField="CatName" runat="server" AppendDataBoundItems="true" AutoPostBack="true" onselectedindexchanged="redirectPage">
									<asp:ListItem Value="0" Text="-- Select Technique --" />
								</asp:DropDownList>&nbsp;&nbsp;
							</div>
                            <asp:Button ID="cmdFilter" Text="" CssClass="filter-btn" runat="server" onclick="cmdFilter_Click" />
							</span>
                        </td>
                    </tr>
                    <tr class="orig-tr-header">
                        <th scope="col" id="partnumber" onclick="doSort('partnumber')" class="header sorter">Part #</th>
                        <!--<th scope="col" id="price" onclick="doSort('price')" class="">Price</th>
						 <th scope="col" id="price" onclick="doSort('price')" class="">Image</th>-->
                    </tr>
                </thead>
                <tbody>
                    <asp:ListView ID="lvProducts" runat="server" DataSourceID="dataProducts">
                        <LayoutTemplate>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr class="orig-tr-products">
                                <!--<td class="desc" nowrap><b><a href='/products/product_organic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("partnumber") %></a></b></td>-->
                                
                                <td style="text-align:right;white-space:nowrap;"><%# GetPrice(Eval("partnumber").ToString())%></td>
                               
							  <!-- <td style="text-align:right;white-space:nowrap;"><img src="/images/<%# getProdImage(Eval("partnumber").ToString())%>" /></td>-->
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
            
			
			<div id="mobile-tablesorter">
				<div class="mobile-product-filter">
					<h2 class="product-filter">Product Filter</h2>
						<div class="select-wrap">
							<div class="selectbgProdList">
								<div class="IEmagicProdList">
									<asp:DropDownList ID="techniqueMobile" CssClass="select-tech" ClientIDMode="Static" DataSourceID="dataTechnique" DataValueField="slug" DataTextField="CatName" runat="server" AppendDataBoundItems="true" onselectedindexchanged="redirectPage">
										<asp:ListItem Value="0" Text="-- Select Technique --" />
									</asp:DropDownList>&nbsp;&nbsp;
								</div>
							</div>
						</div>
						<div class="select-wrap">
							<div class="selectbgProdList">
								<div class="IEmagicProdList">
									<asp:DropDownList ID="familyMobile" CssClass="select-tech" ClientIDMode="Static" DataSourceID="dataFamily" DataValueField="slug" DataTextField="cfFamily" runat="server" AppendDataBoundItems="true" onselectedindexchanged="familyChange">
										<asp:ListItem Value="0" Text="-- Select Application --" />
									</asp:DropDownList>&nbsp;&nbsp;
								</div>
							</div>
						</div>
						<div class="select-wrap">
							<div class="selectbgProdList">
								<div class="IEmagicProdList">
									<asp:DropDownList ID="s_methodMobile" CssClass="select-tech" ClientIDMode="Static" DataSourceID="dataMethod" DataValueField="cmid" DataTextField="cmName" runat="server" AppendDataBoundItems="true" onselectedindexchanged="selectedChange">
										<asp:ListItem Value="0" Text="-- Select Method --" />
									</asp:DropDownList>&nbsp;&nbsp;
								</div>
							</div>
						</div>
						<asp:Button ID="cmdFilterMobile" Text="" CssClass="filter-btn" runat="server" onclick="cmdFilterMobile_Click" />
				</div>
            </div>			
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
</asp:Content>

