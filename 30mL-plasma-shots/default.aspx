<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="hipure_inorganic" Debug="True"%>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <style type="text/css">
        a.aspNetDisabled { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        a.aspNetDisabled:hover { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        #ProductListPagerSimple span,
        #ProductListPagerSimple2 span { font-weight:bold; }
		.buybutton { border-right: 1px solid #727272; }
		#breadcrumb { padding:0;}
    </style>
    
		
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/">Home</a>&nbsp;&nbsp;>&nbsp;&nbsp;Products&nbsp;&nbsp;>&nbsp;&nbsp;<%=prodTitle%></asp:Content>
<asp:Content ID="ContentHeader" ContentPlaceHolderID="cpPageBanner" Runat="Server">
	<div id="banner-div" class="plasma">
		<div class="banner-label-wrapper">
			<h1 class="banner-header hipure"><%=prodTitle%></h1>
			<img class="banner-image-right-hipure" src="/30mL-plasma-shots/images/30ml-right-image.png" />
		</div>
		<div class="banner-shadow"></div>
	</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
	<!--CAS Pop Up-->
	<div id="cas-container-opacity">
		<div id="cas-container">
			<div class="close-x"></div>
			<div class="CAStable"></div>
		</div>
	</div>
	<!--EOF CAS Pop Up-->
	<div id="main" style="margin-bottom:2em">
           <div class="subcolumns">			
				<div class="c30l">
					<div>
						<h2 id="updates">Product Flyers</h2>
						<div class="organic-side">
							<ul class="list-info">
								<li class="pdf_dl"><a target="_blank" href="https://www.spexcertiprep.com/knowledge-base/catalogs/0519-111858-Assurance-and-Claritas-30-mL-Flyer.pdf">30 mL Single Element Standards</a></li>
							</ul>
						</div>
					</div>
					 
				</div>
				<div class="c66r ">
    			    <div style="">
						<div id="banner-p">		
							<h2 style="padding: 0 0 15px;"><%=prodTitle%></h2>
							<asp:Literal ID="ltrContent" runat="server"/>
						</div> 											
    			    </div>
    		    </div>	
            </div>
    <div id="resultstable" style="margin-top:3em">
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
									
			<asp:DataPager ID="ProductListPagerSimple" style="display:none" ClientIDMode="Static" runat="server" PagedControlID="lvProducts" PageSize="25" QueryStringField="page">
				<Fields>
					<asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="true" RenderDisabledButtonsAsLabels="true" FirstPageText="&lt;&lt;" PreviousPageText="&lt;" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
					<asp:NumericPagerField RenderNonBreakingSpacesBetweenControls="false" />
					<asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="true" RenderDisabledButtonsAsLabels="true" LastPageText="&gt;&gt;" NextPageText="&gt;" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
				</Fields>
			</asp:DataPager>
			<div style="clear:both"></div>
		</div>
		<div class="plamas-standards-nav">
			<a class="claritas" href="/30mL-plasma-shots/"><h2>ICP-MS</h2></a>
			<a class="assurance" href="/30mL-plasma-shots/default.aspx?a=1"><h2>ICP</h2></a>
			<div class="bottom-line"></div>
		</div>
        <div style="margin:2em 0 6em"> 
            <table width="958" class="tablesorter" align="center" >
                <thead>
                    <tr>
                        <th scope="col" id="partnumber" onclick="doSort('partnumber')" class="header sorter">Part #</th>
                        <th scope="col" id="title" onclick="doSort('title')" class="header sorter">Product Name</th>
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
									<a href='/products/product_inorganic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("title") %></a>
								</td>
							</tr>
							<tr>
								<td class="headerColumns" colspan='2'>Part #</td>
								<td colspan='2' class="topBorderTD"><a href='/products/product_inorganic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("partnumber") %></a></td>
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
	</div>
	<asp:SqlDataSource ID='dataNews' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
		SelectCommand="SELECT TOP 6 id, title FROM news WHERE category IN ('8') AND active = '1' ORDER BY posteddate DESC" SelectCommandType="Text">
	</asp:SqlDataSource> 
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
					url: 'default.aspx/GetDataCAS',
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
                //$("#totalitems").effect("highlight", { color: "#ffffff" }, 5000);
                $("#totalcost").effect("highlight", { color: "#ffffff" }, 5000);
                $("#totalsavings").effect("highlight", { color: "#ffffff" }, 5000);
                $("#SPoints").effect("highlight", { color: "#ffffff" }, 5000);
            });
            $("#buy_" + productid).removeClass("search_buy");
            $("#buy_" + productid).addClass("search_buy_clicked");
            //$("#buy_" + productid).effect("highlight", { color: "#ffffff" }, 1000);
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
		$(document).ready(function () {
			$('#banner-div').show();
			
			var field = 'a';
			var url = window.location.href;
			if(url.indexOf('?' + field + '=') != -1) {
				$(".assurance").addClass('selected');
				$(".claritas").removeClass('selected');
			}else if(url.indexOf('&' + field + '=') != -1) {
				$(".assurance").addClass('selected');
				$(".claritas").removeClass('selected');
			}else {
				$(".assurance").removeClass('selected');
				$(".claritas").addClass('selected');
			}
			
		});
	</script>
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
				 "@id": "http://www.spexcertiprep.com/30mL-plasma-shots/",
				 "name": "30mL Plasma Shots® ICP & ICP-MS Grade"
			   }
			  }
			 ]
			}
		</script>
</asp:Content>

