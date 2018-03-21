<%@ Page Title="SPEXperience | SPEX CertiPrep" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="spexperience.cs" Inherits="thank_you" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
	<style>
		#breadcrumb { display:none; }
		h1 {
			font-size: 20px;
			font-weight: bold;
		}
	</style>
</asp:Content>
<asp:Content ID="ContentBanner" ContentPlaceHolderID="cpPageBanner" Runat="Server">
	<div id="banner-div" class="spexperience">
		<div class="banner-label-wrapper">
			<img src="/images/spexperience-header.jpg" alt="SPEXperience" />
		</div>
	</div>	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="main">
				<br /><br />
				<h1>Creating an Awesome Customer Experience!</h1>
				<p>It's not only what we do, it's how we do it. We have been manufacturing Inorganic and Organic Certified Reference Materials and Calibration Standards for the Analytical Spectroscopy and Chromatography communities since 1954. Our passion for science and dedication to the analytical community drives us to go above and beyond for you. We want to provide you with the customer experience you deserve and can rely on. We do this by making sure you are our priority in everything we do. That is the SPEXperience&reg; way!</p>
				<div class="row">
					<div class="col-lg-6 info-graph-box">
						<div class="experience-graph-box">
							<div class="graph-box-content">
								<div class="title">Experience</div>
								<div class="icon"><img src="/images/exp-icon.png" alt="Experience" /></div>
								<div class="content">Over 60 years experience manufacturing Certified Reference Materials (CRMs)</div>
							</div>
						</div>
						<div class="scope-graph-box">
							<div class="graph-box-content">
								<div class="title">Scope</div>
								<div class="icon"><img src="/images/scope-icon.png" alt="Scope" /></div>
								<div class="content">Most comprehensive scope of accreditations and certifications in the industry</div>
							</div>
						</div>
						<div class="selection-graph-box">
							<div class="graph-box-content">
								<div class="title">Selection</div>
								<div class="icon"><img src="/images/selection-icon.png" alt="Selection" /></div>
								<div class="content">Selection of over 4,000 <br /> inventoried products</div>
							</div>
						</div>
						<div class="clear"></div>
					</div>
					<div class="col-lg-6 info-graph-box">
						<div class="turn-graph-box">
							<div class="graph-box-content">
								<div class="title">Turn-around</div>
								<div class="icon"><img src="/images/turn-icon.png" alt="Turn-around" /></div>
								<div class="content">Stock products ship within 24 hours</div>
							</div>
						</div>
						<div class="tech-graph-box">
							<div class="graph-box-content">
								<div class="title">Tech Support</div>
								<div class="icon"><img src="/images/tech-icon.png" alt="Tech Support" /></div>
								<div class="content">Dedicated technical support to answer your CRM and lab questions</div>
							</div>
						</div>
						<div class="customs-graph-box">
							<div class="graph-box-content">
								<div class="title">Customs</div>
								<div class="icon"><img src="/images/customs-icon.png" alt="Customs" /></div>
								<div class="content">Custom standards <br />manufactured upon request <br />based on your individual needs</div>
							</div>
						</div>
					</div>
				</div>
				<br />
				<br /><br />
            </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="cphBotBanner" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
</asp:Content>


