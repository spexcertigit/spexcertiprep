<%@ Page Title="SPEX CertiPrep - Knowledge Base" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="knowledge_base" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
	<style>
		#breadcrumb { height:0; padding:0 }
		#main { margin:0 0 56px; }
	</style>
	
</asp:Content>
<asp:Content ID="ContentBanner" ContentPlaceHolderID="cpPageBanner" Runat="Server">
	<div id="banner-div" class="knowledgebase" >
		<!--<img class="category-banner-img" src="img/banner-inorganic.png" alt="Inorganic Certified Reference Materials" />-->
		<div class="banner-label-wrapper">
			<!--<img class="banner-label" src="img/banner-inorganic-label.png">-->
			<h1 class="banner-header knowledgebase">Knowledge Base</h1>
			<img class="banner-image-right" src="images/kb-right.png">
		</div>
		<img class="m768-category-banner-img" src="images/knowledge-base-768.png" alt="Knowledge Base" />
		<img class="m480-category-banner-img" src="images/knowledge-base-480.png" alt="Knowledge Base" />
		<img class="m320-category-banner-img" src="images/knowledge-base-480.png" alt="Knowledge Base" />
		<div class="banner-shadow"></div>
	</div>	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="main">
				<div id="kbTable">
					<div class="kbCol1">
						<div class="kbColtr">
							<div class="kbColth"><h2>Downloads</h2>&nbsp;&nbsp;<img src="images/dlicon.png" style="vertical-align:middle" /></div>
						</div>
						<div class="kbColtd">
							<ul>
								<li><a href="/knowledge-base/MSDS.aspx">SDS (MSDS)</a></li>
								<li><a href="/products/SPEXertificate.aspx">SPEXertificate</a></li>
								<li><a href="/knowledge-base/catalog-request.aspx">Catalogs &amp; Product Literature</a></li>
							</ul>
						</div>
					</div>
					<div class="kbCol2">
						<div class="kbColtr">
							<div class="kbColth"><h2>Tools, Tips &amp; Tricks</h2>&nbsp;&nbsp;<img src="images/toolsicon.png" style="vertical-align:middle" /></div>
						</div>
						<div class="kbColtd">
							<ul>
								<li><a href="/knowledge-base/ask-a-chemist.aspx">Ask a Chemist</a></li>
								<li><a href="/knowledge-base/dilutulator.aspx">Dilut-U-lator</a></li>
								<li><a href="/knowledge-base/periodic-table.aspx">Periodic Table</a></li>
								<li><a href="/knowledge-base/conversion-table.aspx">Conversion Table</a></li>
								<li><a href="/knowledge-base/additional-tools">Additional Tools</a></li>
							</ul>
						</div>
					</div>
					<div class="kbCol3">
						<div class="kbColtr">
							<div class="kbColth" style="border-right: 1px solid #4d501e;">
								<h2>Resources &amp; Publications</h2>&nbsp;&nbsp;<img src="images/rsrcicon.png" style="vertical-align:middle" />
							</div>
						</div>
						<div class="kbColtd" style="border-right: 1px solid #b3b3b3;">
							<ul>
								<li><a href="/spectroscopy">Spectroscopy</a></li>
								<li><a href="/knowledge-base/webinars.aspx">Webinars</a></li>
								<li><a href="/knowledge-base/posters-presentations">Posters &amp; Presentations</a></li>
								<li><a href="/knowledge-base/appnotes-whitepapers">Application Notes &amp; White Papers</a></li>
								<li><a href="/knowledge-base/SPEX-Speaker">SPEX Speaker</a></li>
								<li><a href="/knowledge-base/optimize">Optimize</a></li>
								<li><a href="/knowledge-base/resources">Recommended Reading</a></li>
							</ul>
						</div>
					</div>
					<div style="clear:both"></div>
				</div>
				<img class="bottom-shadow" src="images/bottom-shadow.png" />
				<div style="clear:both"></div>
            </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
</asp:Content>

