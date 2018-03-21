<%@ Page Title="Pesticide Standards | SPEX CertiPrep" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="search" debug="true" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <script src="/js/jquery-ui.js" type="text/javascript"></script>
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
	</style>
	<script>
		$(document).ready(function () {
			$('#banner-div').show();
		});
	</script>	
		
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"></asp:Content>
<asp:Content ID="ContentHeader" ContentPlaceHolderID="cpPageBanner" Runat="Server">
	<div id="banner-div" class="pesticides">
		<!--<img class="category-banner-img" src="img/category-banner-organic.png" alt="Organic Certified Reference Materials" />-->
		<div class="banner-label-wrapper">
			<!--<img class="banner-label" src="img/banner-organic-label.png">-->
			<h1 class="banner-header pesticides">Pesticide Standards</h1>
		</div>
		<div class="banner-shadow"></div>
	</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
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
        <div id="main">
            <div class="subcolumns">
				<span class="starter">To get started, please click an option below:</span><br /><br />
				<div class="pesticides-box">
					<span class="title">General Pesticide Standards</span>
					<p>Build Your Pesticide Library with SPEX CertiPrep Pesticide Mixes <br /><br />
					Now available, SPEX CertiPrep premixed pesticide multi-compound CRMs. Want all 144 top pesticides? We have the kit containing all of the compounds.
					</p>
					<a class="click-here" href="/products/pesticides/pesticide-mixes">Click here >></a>
				</div>
				
				<div class="pesticides-box">
					<span class="title">Know Your EPA Method</span> <br /><br />
					<p>Drinking Water &#8226; Municipal &amp; Industrial Waste &#8226; Environmental Samples &#8226; Miscellaneous Methods</p>
					<a class="click-here" href="/products/pesticides/epa-methods">Click here >></a>
				</div>
				
				<div style="padding:110px"></div>
			</div>
		</div>
	<asp:SqlDataSource ID='dataMethod' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT * FROM certiPesticidesMethods ORDER BY id" SelectCommandType="Text">
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
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
</asp:Content>

