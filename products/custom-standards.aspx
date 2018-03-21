<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="custom-standards.aspx.cs" Inherits="products_custom_standards" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="ContentBanner" ContentPlaceHolderID="cpPageBanner" Runat="Server">
	<div id="banner-div" class="custom-standards">
		<div class="banner-label-wrapper">
			<h1 class="banner-header custom-standards">CUSTOM INORGANIC AND <br>ORGANIC STANDARDS</h1>
		</div>
	</div>	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server">
    <a href="../default.aspx">Home</a> > Products > Custom Standards
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
	<div id="main">
		<h2 style="font-size:25px">Custom Organic and Inorganic Standards</h2><br />
		<p>SPEX CertiPrep has over 60 years experience in making custom standards to your exact specifications. Choose the type of product you need and complete the form. Our knowledgeable staff will verify your mix and provide you with a quote within 2 business days.</p><br />
		<div class="custom-standards-page">
			<div class="customType left">
				<a href="custom-standards_inorganic.aspx"><img src="/images/inorganic-banner.png" alt="Inorganic Custom Standards" title="Inorganic Custom Standards" class="banner"/></a>
				<h3><a href="custom-standards_inorganic.aspx">Inorganic Custom Standards</a></h3>
				<p class="customText">To order customized standards made by our experts fill out the online <a href="custom-standards_inorganic.aspx">order request form</a>. Our knowledgeable staff will verify the compatibility and stability of your requested mix and provide you with a quote within 1 business day. Your approved order is manufactured and shipped within 5 business days</p>
				<div><div style="float:left; font-size:1.15em;">
					<ul class="twoColUL">
						<li>We offer custom standards for AA, ICP, ICP-MS, IC, Wet Assay, and Conductivity</li>
						<li>Custom standards are offered in a variety of different volume sizes including the most common sizes of 100 mL, 250 mL, 500 mL and 1L</li>
						<li>Custom standards can be bottled in different containers including LDPE, FEP, PP and glass bottles</li>
						<li>All customs come with a comprehensive Certificate of Analysis and MSDS</li>
					</ul>
					</div>
				</div>
			</div>
			<div class="customType right">
				<a href="custom-standards_organic.aspx"><img src="/images/organic-banner.png" alt="Organic Custom Standards" title="Organic Custom Standards" class="banner"/></a>
				<h3><a href="custom-standards_organic.aspx">Organic Custom Standards</a></h3>
				<p>We specialize in evaluating what compounds work well together and the solvents needed to keep the standard stable. You can expect to receive a quote within 4 business days. Simply choose the Organic products you need by filling out the online <a href="custom-standards_organic.aspx">order request form</a>.</p>
				<div><div style="float:left; font-size:1.15em;">
					<ul class="twoColUL">
						<li>Standards are available for LC, LC/MS, GC or GC/MS</li>
						<li>We offer customs in 1 mL ampules up to 1 Liter bottles</li>
						<li>Each product is analyzed using state of the art instrumentation in a clean room environment</li>
						<li>We stock a comprehensive supply of starting materials for fast manufacture as well as certified solutions ready to ship</li>
						<li>All standards come with a comprehensive Certificate of Analysis and MSDS</li>
					</ul>
					</div>
				</div>
			</div>
			<div class="clearboth"></div>
		</div>
		<div class="custom-buttons">
			<div class="customType left"><p><a href="custom-standards_inorganic.aspx"><img src="/images/custom-buttons-icon.png" />&nbsp;Send us your custom inorganic design today</a></p></div>
			<div class="customType right"><p><a href="custom-standards_organic.aspx"><img src="/images/custom-buttons-icon.png" />&nbsp;Send us your custom organic design today</a></p></div>
			<div class="clearboth"></div>
		</div>
		
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script type="application/ld+json">
			{
				"@context": "http://schema.org",
				"@type": "Enumeration",
				"name": "Custom Standards",
				"url": "http://www.spexcertiprep.com/products/custom-standards.aspx",
				"description": "SPEX CertiPrep has over 60 years of experience making custom organic and inorganic standards that meet industry specifications."
			}
	</script>
</asp:Content>

