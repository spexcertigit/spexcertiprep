<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="inorganic_international.aspx.cs" Inherits="search_organic_category"  Debug="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
	<link href="/css/easydropdown.css" rel="stylesheet" type="text/css" charset="utf-8" />
    <style type="text/css">
        a.aspNetDisabled { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        a.aspNetDisabled:hover { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        #ProductListPagerSimple span,
        #ProductListPagerSimple2 span { font-weight:bold; }
    </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/">Home</a> > Inorganic International Standards</asp:Content>
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
    <div>
		<h1 style="margin-bottom:25px;">Organic and Inorganic International Standards</h1>
		<p style="font-size:14px;margin-bottom:30px;">SPEX CertiPrep offers standards for global applications. Around the world, analytic labs are required to meet their countries requirements for environmental and safety testing. SPEX CertiPrep prides itself as being a standards provider for the international market.<br /><br />
		Over the years our customers have asked for more catalog parts with global applications. We have responded to their requests and now have a selection of the most commonly requested standards to address the testing regulations in the international community.</p>
	</div>
    <div class="floatbox">
        <div class="searchresult_heading" id="organic_results">
			<a href="organic_international.aspx" style="color:#333;text-decoration:none;display:block;width:100%;"><h2>Organic</h2></a>
		</div>
        <div class="searchresult_heading  searchresult_heading_selected" id="inorganic_results"><h2>Inorganic</h2></div>
    </div>        
    <div id="resultstable">
		<div class="pagers1_wrapper" style="margin-top:0">
			<asp:Panel ID="pnlPerPage" runat="server" style="text-align:right">
				<asp:Label ID="TestLabel" runat="server" />
			</asp:Panel>
			<div style="clear:both"></div>
		</div>
        <div> 
            <table width="958" class="tablesorter" align="center" >
				<asp:Literal ID="ltrTBLglobal" runat="server" />
				<asp:Literal ID="ltrTBLoutput" runat="server" />
            </table>
		</div>
		<div id="mobile-tablesorter">
			<asp:Literal ID="ltrMobileOutput" runat="server" />
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
			 "@id": "http://www.spexcertiprep.com/inorganic_international.aspx",
			 "name": "Inorganic International Standards"
		   }
		  }
		 ] 
		}
	</script>
</asp:Content>