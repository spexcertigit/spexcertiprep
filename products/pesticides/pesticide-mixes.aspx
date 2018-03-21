<%@ Page Title="Pesticide Mixes | SPEX CertiPrep" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="pesticide-mixes.aspx.cs" Inherits="search" debug="true" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">		
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"></asp:Content>
<asp:Content ID="ContentHeader" ContentPlaceHolderID="cpPageBanner" Runat="Server">
	<div id="banner-div" class="pesticides">
		<!--<img class="category-banner-img" src="img/category-banner-organic.png" alt="Organic Certified Reference Materials" />-->
		<div class="banner-label-wrapper">
			<!--<img class="banner-label" src="img/banner-organic-label.png">-->
			<h1 class="banner-header pesticides">Pesticide Mixes</h1>
		</div>
		<div class="banner-shadow"></div>
	</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
        <div id="main">
            <div class="subcolumns">
				<h2 class="pm-title">Premixed Pesticide Multi-Compound CRMs</h2>
				<span class="pm-sub-title">Build Your Pesticide Library With SPEX CertiPrep Pesticide Mixes!</span>
				<br /><br />
				<p>
					Now available, SPEX CertiPrep premixed pesticide multi-compound CRMs. Want all 144 top pesticides? We have the kit containing all of the compounds. <br /><br />
					Pesticide residue analysis is a critical step in protecting agricultural products and foodstuff from both the onslaught of damaging pests as well as protecting the environment and the population from potentially dangerous chemical residues. <br /><br />
					Many new pesticides are now being tested using GC/MS and LC/MS and GC techniques to determine even minute amounts of pesticide residue in environmental samples and food products. SPEX CertiPrep is the leader in offering HPLC, GC, GC/ MS, and LC/MS pesticide CRMs designed to work within the EPA, AOAC, FDA, and international analytical testing methods. <br /><br />
					Your analysis just got faster and easier. Calibration time will be shorter, requiring fewer injections. You will save money too. Our mixes will be less expensive than buying individual CRMs. 
				</p>
				<h3 class="pm-title">CAN'T FIND THE STANDARDS YOU ARE LOOKING FOR?</h3>
				<p>
					SPEX CertiPrep can make custom standards to meet your exact needs. Simply choose the organic custom mix you need by filling out the online request <a href="/products/custom-standards_organic.aspx" style="color:#5A5B5D">here</a>. <br /><br />
					Each product listed below contains a variety of compounds. Click on the part number to see the list of compounds and CAS numbers.
				</p>
			</div>
			
			<div id="resultstable">
                <div class="productcontent" id="productcontent_Product">
                    <div style="margin:1.5em 0 2em">
                        <h2></h2>
                        <table style="width:100%" class="tablesorter" border="1">
                            <thead>
                                <tr>
                                    <th scope="col" class="header sorter" nowrap>Part #</th>
                                    <th scope="col" class="header sorter">Product Name</th>
                                    <th scope="col" class="header sorter">Conc</th>
                                    <th scope="col" class="header">Volume</th>
                                    <th scope="col" >Unit/Pk</th>
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
                                            <td class="desc" nowrap><b><a href='/products/product_organic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("partnumber") %></a></b></td>
                                            <td class="desc"><b><a href='/products/product_organic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("title") %></a></b></td>
											<!--Concentration-->
											<%# (GetConcentrationInorg(Eval("partnumber").ToString()) == "Various") ? "<td style='white-space:nowrap;'>"+ 
											GetConcentrationInorg(Eval("partnumber").ToString())+"</td>" : "<td>"+ 
											GetConcentrationInorg(Eval("partnumber").ToString())+"</td>" %>
											<!--EOF Concentration-->
                                            <td style="text-align:right;white-space:nowrap;"><%# Eval("Volume") %></td>
                                            <td style="text-align:center;white-space:nowrap;"><%# Eval("UnitPack") %></td>
                                            <td style="text-align:right;white-space:nowrap;"><%# GetPrice(Eval("partnumber").ToString())%></td>
                                            <td class="buybutton" style="white-space:nowrap;">
                                                <input name='quantity_<%# Eval("partnumber") %>' type="text" id='quantity_<%# Eval("partnumber") %>' class="search_quantity" value="1" /><input type="button" id='buy_<%# Eval("partnumber") %>' name='buy_<%# Eval("partnumber") %>' value="" class="search_buy" onclick="buyIt('<%# Eval("partnumber") %>');" />
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:ListView> 
                            </tbody>
                        </table>
						
						<div id="mobile-tablesorter">
							<asp:ListView ID="lvProductsMobile" runat="server" DataSourceID="dataProducts">
								<LayoutTemplate>
									<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
								</LayoutTemplate>
								<ItemTemplate>
									<table class="mobile-result-table">
										<tr>
											<td colspan="4" class="fullTD">
												<a href='/products/product_organic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("title") %></a>
											</td>
										</tr>
										<tr>
											<td class="headerColumns" colspan='2'>Part #</td>
											<td colspan='2' class="topBorderTD">
												<a href='/products/product_organic.aspx?part=<%# Eval("partnumber") %>'><%# Eval("partnumber") %></a>
											</td>
										</tr>
										<tr>
											<td class="headerColumns" colspan="2" style="width:35%">Concentration</td>
											<%# (GetConcentrationInorg(Eval("partnumber").ToString()) == "Various") ? "<td colspan='2' class='grayTD' style='white-space:nowrap;'>"+ 
											GetConcentrationInorg(Eval("partnumber").ToString())+"<img src='/images/modal-tooltip.png' /></td>" : "<td colspan='2' class='grayTD'>"+ 
											GetConcentrationInorg(Eval("partnumber").ToString())+"</td>" %>
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
												<input name='quantity_<%# Eval("partnumber") %>' type="text" id='quantity_<%# Eval("partnumber") %>' class="search_quantity" value="1" /><input type="button" id='buy_<%# Eval("partnumber") %>' name='buy_<%# Eval("partnumber") %>' value="" class="search_buy" onclick="buyIt('<%# Eval("partnumber") %>');" />
											</td>
										</tr>
									</table>
								</ItemTemplate>
							</asp:ListView> 
						</div>
		            </div>
                 </div>
			</div>
		</div>
	<asp:SqlDataSource ID='dataProducts' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommandType="Text">
    </asp:SqlDataSource>
	<asp:SqlDataSource ID='dataMethod' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT * FROM certiPesticidesMethods ORDER BY id" SelectCommandType="Text">
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script src="/js/jquery-ui.js" type="text/javascript"></script>
	<script src="/js/jquery.tablesorter.min.js" type="text/javascript"></script>	
	<style type="text/css">
		#name {
			*padding-top:11px;
			*height: 22px !important;
		}	
		#email {
			*padding-top:11px;
			*height: 22px !important;
		}
		#breadcrumb {padding:0;}
		table a { text-decoration:none; }
	</style>
	<script>
		$(document).ready(function () {
			$('#banner-div').show();
			$(".tablesorter").tablesorter({
				headers: {
					3: {sorter: false}, 
					4: {sorter: false}, 
					5: {sorter: false},
					6: {sorter: false}, 
					7: {sorter: false}
				}
			});	
			$(".tablesorter tr:odd").addClass("odd");
		});
	</script>	
    <script type="text/javascript">
		$(document).ready(function(){
			$('a[href^=#]').click(function(event){		
				event.preventDefault();
				$('html,body').animate({scrollTop:$(this.hash).offset().top}, 2000);
			});
			
			$('#s_method').change(function() {
				location.replace('/products/pesticides/' + $(this).val());
			});
		});
	</script>
	
	<script>
		$(document).ready(listenWidth);
		$(document).load($(window).bind("resize", listenWidth));

		function listenWidth( e ) {
			if($(window).width()<737)
			{
				$(".c30l").remove().insertAfter($(".c66r"));
			} else {
				$(".c30l").remove().insertBefore($(".c66r"));
			}
		}
	</script>
</asp:Content>

