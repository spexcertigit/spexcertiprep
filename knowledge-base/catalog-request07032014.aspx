<%@ Page Title="SPEX CertiPrep - Knowledge Base - Request a Catalog" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="catalog-request.aspx.cs" Inherits="knowledge_base_catalog" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
		<style type="text/css">
		#col1_content2
		{
			padding-right:10px;
		}
		#col1_content2 img
		{
			margin-left:50px;
			text-align:center;
		}
		.yform .type-text input, .yform .type-text textarea {
			width: 91%;
		}
		span.req-left {
			float: left;
		}    
	</style>
    <script src="/js/jquery-ui.js" type="text/javascript"></script>
    <script>
        $(document).ready(function () {
            // Dropdown Change
            try {
				if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
				// some code..
				}else {
					$("#Country").msDropDown();
				}
            } catch (e) {
                alert(e.message);
            }
            //EOF Dropdown Change
        })
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/">Home</a> > Knowledge Base > Request a Catalog</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
			<div id="mainHeader">
				<h1>Request a Catalog</h1>
			</div>
			<div id="main">
				<div id="col1">
					<div id="col1_content" class="clearfix">
						<div class="anniv-logo">
							<img src="../images/page-photos/60th-Anniversary-Logo.jpg" alt="Your science is our passion" />
						</div>
						<uc1:ShareThis ID="ShareThis1" runat="server" />
					</div>

										<div id="col1_content2" class="clearfix" style="margin-top:50px;"><h2>Catalog Archives</h2><br /><p>SPEX CertiPrep is celebrating <i><strong>60 years</strong></i> in 2014! Take a trip through SPEX history and browse our archive of product catalogs and literature dating back to 1954.</p><p>Visit our SPEX <a href="http://www.spexspeaker.com/catalogarchives">catalog archive</a>.</p><br /><br /><p><a href="http://www.spexspeaker.com/catalogarchives"><img src="images/1955-09_SPEXIndustriesCatalog.jpg" alt="SPEX very first catalog" height="150" width="118" style="border:solid 1px" /></a></p></div>

				</div>
				<div id="col3">
					<div id="col3_content" class="clearfix">
						<asp:MultiView ID="mvForm" runat="server" ActiveViewIndex="0">
							<asp:View ID="vwForm" runat="server">
								<div id="catreq_form" class="form_grey yform">
									<div style="margin-bottom:10px" >
										<h3 style="font-weight:bold; font-size:1.4em;">Download or request a copy of our latest literature.</h3> 
									</div>
									<div id="catalog" class="floatbox">
										<h3 style="font-size:1.3em; padding-left:4px;">Browse our catalog as an interactive flipbook:</h3>
										<div id="OrgFlipbook"> 
											<a href="/organic/" target="_blank">
												<img name="organic_catalog" src="images/OrganicFlipbook.jpg" width="220" height="86" alt="View Interactive Organic Catalog" />
											</a>
											<h3>Organic Flipbook Catalog</h3>
										</div>

										<div> 
											<a href="/inorganic/" target="_blank">
												<img name="inorganic_catalog" src="images/InorganicFlipbook.jpg" width="220" height="86" alt="View Interactive Inorganic Catalog" /> 
											</a>       
											<h3>Inorganic Flipbook Catalog</h3>
										</div>
									</div>
									<br />

									<div id="literature" class="floatbox">	
									<br />
										<h3 style="font-size:1.3em;">Download or request literature: </h3>
										<p>Check any literature you want mailed to you.  Click the image to download a PDF (where available)</p>
									<br />
										<div style= "width:97%; background-color: #94a232">
									 <h3 style="padding-top: 8px; font-size:1.2em; padding-left:8px; margin-bottom:5px; color:white;">Catalogs</h3>
										</div>
										<div class="subcolumns" style="margin-bottom:15px">
											
											<div class="c25l">
												<div>
													<asp:HyperLink ID="lnkOrganicCatalog" runat="server" NavigateUrl="catalogs/OrganicCat.pdf" ImageUrl="images/Cover_Organic.jpg"></asp:HyperLink>
													<div class="subcl type-check">
														<asp:CheckBox ID="OrganicCatalog" Text=" 2014-2015 Organic Catalog" runat="server" />
													</div>
												</div>
											</div>
											<div class="c25l">
												<asp:HyperLink ID="lnkInorganicCatalog" runat="server" NavigateUrl="catalogs/InorganicCat.pdf" ImageUrl="images/Cover_Inorganic.jpg"></asp:HyperLink>
												<div class="subcl type-check">
													<asp:CheckBox ID="InorganicCatalog" Text=" 2014 -2015 Inorganic Catalog" runat="server" />
												</div>
											</div>
											
											<div class="c25l">
												<div>
													<asp:HyperLink ID="newProdSup" runat="server" NavigateUrl="catalogs/2013NewProductSupplement.pdf" ImageUrl="images/2013CatalogSupplement.jpg"></asp:HyperLink>
												<div class="subcr type-check">
													<asp:CheckBox ID="NewProdSupplement" Text=" 2013 New Products Supplement" runat="server" />
												</div>
												</div>
											</div>

<%--											<div class="c25r">
												<asp:HyperLink ID="lnkCDRomCatalog" runat="server" ImageUrl="images/EmptyCatalogCover.png"></asp:HyperLink>
												<div class="subcr type-check">
													<asp:CheckBox ID="CDROMCatalogs" Text=" Catalogs on CD-ROM" runat="server" />
												</div>
											</div>--%>
										</div>

									   <br /><br />


										<%--First Row...--%>
										<div style= "width:97%; background-color: #94a232">
											 <h3 style="padding-top: 8px; font-size:1.2em; padding-left:8px; margin-bottom:5px; color:white;">General Company Information</h3>
										</div>
										<div class="subcolumns" style="margin-bottom:15px; border-bottom-color:black;">
											<div class="c25l">
												<div>
													<asp:HyperLink ID="lnkAccred" runat="server" ImageUrl="images/Accreditations.jpg" NavigateUrl="catalogs/Accreditations.pdf"></asp:HyperLink>
													<div class="subcl type-check">
														<asp:CheckBox ID="Accreditations" Text=" Accreditations" runat="server" />
													</div>
												</div>
											</div>
											<div class="c25l">
												<div>
													<asp:HyperLink ID="lnkSPEXertificate" runat="server" NavigateUrl="catalogs/SPEXertificate.pdf" ImageUrl="images/SPEXertificate.jpg"></asp:HyperLink>
												<div class="subcr type-check">
													<asp:CheckBox ID="SPEXertificate" Text=" Certificate of Analysis" runat="server" />
												</div>
													</div>
											</div>
											 <div class="c50r">
												<div>
													<asp:HyperLink ID="lnkSPoints" runat="server" NavigateUrl="catalogs/SPoints.pdf" ImageUrl="images/SPoints.jpg"></asp:HyperLink>
													<div class="subcl type-check">
														<asp:CheckBox ID="SPoints" Text=" SPoints Rewards" runat="server" />
													</div>
												</div>
											</div>

									   </div>
								   <br />
<%--                                             <hr />--%>
									<br />
										<%--Organic Products...--%>
										<div style= "width:97%; background-color: #94a232">
											 <h3 style="padding-top: 8px; font-size:1.2em; padding-left:8px; margin-bottom:5px; color:white;">Organic Certified Reference Materials</h3>
										</div>

										<div class="subcolumns" style="margin-bottom:15px">
											<div class="c25l">
												<div>
													<asp:HyperLink ID="lnkUSP467" runat="server" NavigateUrl="catalogs/USP467.pdf" ImageUrl="images/USP467.jpg">
													</asp:HyperLink>
													<div class="subcl type-check">
														<asp:CheckBox ID="OrganicUSP467" Text=" USP 467" runat="server" />
													</div>
												</div>
											</div>

											<div class="c25l">
												<div>
													<asp:HyperLink ID="lnkQuechers" runat="server" NavigateUrl="catalogs/QuEChERSFlyer.pdf" ImageUrl="images/QuechersThumb.jpg"></asp:HyperLink>
													<div class="subcl type-check">
														<asp:CheckBox ID="cbQuechers" Text=" QuEChERS Kits" runat="server" />
													</div>
												</div>
											</div>

											<div class="c25l">
												<div>
													<asp:HyperLink ID="lnkSVOA" runat="server" NavigateUrl="catalogs/SVOADrinkingWater.pdf" ImageUrl="images/SVOA_DrinkingWater.jpg"></asp:HyperLink>
													<div class="subcl type-check">
														<asp:CheckBox ID="SVOADrinkingWater" Text=" SVOA Drinking Water Standards" runat="server" />
													</div>
												</div>
											</div>
											<div class="c25r">
												<div>
													<asp:HyperLink ID="lnkPesticides" runat="server" ImageUrl="images/PesticideStandards.jpg" NavigateUrl="catalogs/Pesticides.pdf"></asp:HyperLink>
													<div class="subcl type-check">
														<asp:CheckBox ID="Pesticides" Text=" Pesticide Standards" runat="server" />
													</div>
												</div>
											</div>
									  </div>
								  <br /><br />

										<%--Organic Products - Second Row--%>
										<div class="subcolumns" style="margin-bottom:15px">
											<div class="c25l">
												<div>
													<asp:HyperLink ID="lnkConsumerSafety" runat="server" NavigateUrl="catalogs/ConsumerSafety.pdf" ImageUrl="images/ConsumerSafety.jpg">
													</asp:HyperLink>
													<div class="subcl type-check">
														<asp:CheckBox ID="OrganicConsumerSafety" Text=" Consumer Safety" runat="server" />
													</div>
												</div>
											</div>

											<div class="c25l">
												<div>
													<asp:HyperLink ID="lnkWine" runat="server" ImageUrl="images/Wine.jpg" NavigateUrl="catalogs/Wine.pdf"></asp:HyperLink>

												<div class="subcr type-check">
													<asp:CheckBox ID="Wine" Text=" Wine Standards" runat="server" />
												</div>
											</div>
										</div>
											<div class="c25l">
												<div>
													<asp:HyperLink ID="lnkPharmaResidualSolv" runat="server" ImageUrl="images/PharmaResidualSolvents.jpg" NavigateUrl="catalogs/PharmaceuticalResidualSolvents.pdf"></asp:HyperLink>
													<div class="subcl type-check">
														<asp:CheckBox ID="PharmaResidualSolvents" Text=" Pharmaceutical Residual Solvents" runat="server" />
													</div>
												</div>
											</div>
											<div class="c25r">
												<div>
												<div>
													<asp:HyperLink ID="lnkGeneralOrganics" runat="server" ImageUrl="images/GeneralOrganics.jpg" NavigateUrl="catalogs/GeneralOrganics.pdf"></asp:HyperLink>

												<div class="subcr type-check">
													<asp:CheckBox ID="GeneralOrganics" Text=" Organic Standards Overview" runat="server" />
												</div>
											</div>
												</div>
											</div>


									  </div>
								  <br /><br />

										<%--Organic Products - Third Row--%>
										<div class="subcolumns" style="margin-bottom:15px">
											<div class="c25l">
												<div>
													<asp:HyperLink ID="lnkLCPestRes" runat="server" NavigateUrl="catalogs/LCPestResidue.pdf" ImageUrl="images/LCPestResidue.jpg">
													</asp:HyperLink>
													<div class="subcl type-check">
														<asp:CheckBox ID="cbLCPestRes" Text=" LC Pesticide Residue" runat="server" />
													</div>
												</div>
											</div>

											<div class="c50l">
												<div>
													<asp:HyperLink ID="lnkLCMSPostcard" runat="server" NavigateUrl="catalogs/LCMSPostcard.pdf" ImageUrl="images/LCMSPostcard.jpg"></asp:HyperLink>
													<div class="subcl type-check">
														<asp:CheckBox ID="LCMSPostcard" Text=" LC-MS Standards" runat="server" />
													</div>
												</div>
											</div>
											</div>
								  <br /><br />

									<%--Inorganic Grouping - 1st Row...--%>
										<div style= "width:97%; background-color: #94a232">
											 <h3 style="padding-top: 8px; font-size:1.2em; padding-left:8px; margin-bottom:5px; color:white;">Inorganic Certified Reference Materials</h3>
										</div>
										 <div class="subcolumns" style="margin-bottom:15px">
											<div class="c25l">
												<div>
													<asp:HyperLink ID="lnkFusionFlux" runat="server" NavigateUrl="catalogs/FusionFlux.pdf" ImageUrl="images/FusionFlux.jpg"></asp:HyperLink>
												<div class="subcl type-check">
													<asp:CheckBox ID="FusionFlux" Text=" Fusion Flux" runat="server" />
												</div>
											</div>

											</div>
											<div class="c25l">
												<div>
													<asp:HyperLink ID="lnkICH" runat="server" NavigateUrl="catalogs/ICHGlobalCompliance.pdf" ImageUrl="images/ICH_Global_Compliance.jpg"></asp:HyperLink>
												<div class="subcl type-check">
													<asp:CheckBox ID="ICHGlobalCompliance" Text=" ICH Global Compliance" runat="server" />
												</div>
											</div>

											</div>
											<div class="c25l">
												<div>
													<asp:HyperLink ID="lnkPHBuff" runat="server" ImageUrl="images/pHBuffers.jpg" NavigateUrl="catalogs/pH_Buffers.pdf"></asp:HyperLink>
													<div class="subcl type-check">
														<asp:CheckBox ID="PHBuffers" Text=" pH Buffers" runat="server" />
													</div>
												</div>
											</div>
											<div class="c25r">
												<div>
													<asp:HyperLink ID="lnk1ppmSingles" runat="server" NavigateUrl="catalogs/1PPM_ICP-MS_Singles.pdf" ImageUrl="images/1PPM-ICPMS-Singles.jpg"></asp:HyperLink>
												<div class="subcr type-check">
													<asp:CheckBox ID="Claritas1PPMSingles" Text=" 1ppm ICP-MS Singles" runat="server" />
												</div>
													</div>
											</div>
										</div>
										<br />
										<br />
										<%--Inorganic Grouping - second row--%>

										<div class="subcolumns" style="margin-bottom:15px">
											<div class="c25l">
												<div>
													<asp:HyperLink ID="lnkUSP232" runat="server" NavigateUrl="catalogs/USP232.pdf" ImageUrl="images/USP232.jpg"></asp:HyperLink>
												<div class="subcl type-check">
													<asp:CheckBox ID="USP232" Text=" USP 232 Standards" runat="server" />
												</div>
											</div>

											</div>
											<div class="c25l">
												<div>
													<asp:HyperLink ID="lnkInorganicConsumerSafety" runat="server" NavigateUrl="catalogs/ConsumerSafety.pdf" ImageUrl="images/ConsumerSafety.jpg"></asp:HyperLink>
												<div class="subcl type-check">
													<asp:CheckBox ID="InorganicConsumerSafety" Text=" Consumer Safety" runat="server" />
												</div>
											</div>

											</div>
											<div class="c25l">
												<div>
													<asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl="catalogs/DualSingleSpeciation.pdf" ImageUrl="images/DualSingleSpeciation.jpg"></asp:HyperLink>
													<div class="subcr type-check">
														<asp:CheckBox ID="DualSingleSpeciation" Text="Dual & Single Speciation Standards" runat="server" />
													</div>
												</div>
												
											</div>
											<div class="c25r">
                                                <div>
													<asp:HyperLink ID="lnkGeneralInorganics" runat="server" ImageUrl="images/GeneralInorganics.jpg" NavigateUrl="catalogs/GeneralInorganics.pdf"></asp:HyperLink>
													<div class="subcl type-check">
														<asp:CheckBox ID="GeneralInorganics" Text=" Inorganic Standards Overview" runat="server" />
													</div>
												</div>
											</div>
										</div>

									<%--Fourth Row...--%>

									<br /><br />

										<div style= "width:97%; background-color: #94a232">
											 <h3 style="padding-top: 8px; font-size:1.2em; padding-left:8px; margin-bottom:5px; color:white;">Lab Stuff - Contamination Control</h3>
										</div>
										<div class="subcolumns" style="margin-bottom:15px">
											<div class="c33l">
												<div class="subcl type-check">
													<asp:CheckBox ID="AcidStill" Text=" Sub-boiling Acid Still" runat="server" />
												</div>
											</div>
											<div class="c33l">
												<div class="subcr type-check">
													<asp:CheckBox ID="PipetteWasher" Text=" Pipette Washer & Dryer" runat="server" />
												</div>
											</div>
											<div class="c33r">
												<div class="subcr type-check">
													<asp:CheckBox ID="OdorEroder" Text=" OdorEroder Odor Control" runat="server" />
												</div>
											</div>
										</div>

								</div>



									<br /><br />
												<h3 style="font-size:1.3em;">To request printed materials, please complete the following information:</h3>
									<div class="subcolumns">
										<div class="c50l">
											<div class="subcl type-text">
												<span class="req-left">*</span>
												<asp:TextBox ID="first_name" runat="server" placeholder="First Name" />
												<asp:RequiredFieldValidator ID="rfvfirstname" ControlToValidate="first_name" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
											</div>
										</div>
										<div class="c50r">
											<div class="subcr type-text">
												<span class="req-left">*</span>
												<asp:TextBox ID="last_name" runat="server" placeholder="Last Name" />
												<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="last_name" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
											</div>
										</div>
									</div>

									<div class="type-text">
										<asp:TextBox ID="txtTitle" runat="server" Width="95.2%" style="margin-left:10px;" placeholder="Title" />
									</div>

									<div class="type-text">
										<asp:TextBox ID="company_name" runat="server" Width="95.2%" style="margin-left:10px;" placeholder="Company Name" />
									</div>

									<div class="type-text">
										<span class="req-left">*</span>
										<asp:TextBox ID="company_address" runat="server" Width="95.2%" placeholder="Company Address" />
										<asp:RequiredFieldValidator ID="rfvcompany_address" ControlToValidate="company_address" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
									</div>

									<div class="subcolumns">
										<div class="c33l">
											<div class="subcl type-text">
												<span class="req-left">*</span>
												<asp:TextBox ID="city" runat="server" Width="85%" placeholder="City"/>
												<asp:RequiredFieldValidator ID="rfvcity" ControlToValidate="city" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
											</div>
										</div>
										<div class="c33l">
											<div class="subcl type-text">
												<span class="req-left">*</span>
												<asp:TextBox ID="state_region" runat="server" Width="85%" placeholder="State/Province/Region" />
												<asp:RequiredFieldValidator ID="rfvstate_region" ControlToValidate="state_region" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
											</div>
										</div>
										<div class="c33r">
											<div class="subcr type-text">
												<span class="req-left">*</span>
												<asp:TextBox ID="zip" runat="server" Width="80%" placeholder="ZIP/Postal Code" />
												<asp:RequiredFieldValidator ID="rfvzip" ControlToValidate="zip" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
											</div>
										</div>
									</div>

									<div class="type-select">
										<span class="req-left">*</span>
										<asp:DropDownList ID="Country" runat="server" DataSourceID="dataCountries" DataTextField="countryname" DataValueField="countryCode" AppendDataBoundItems="true" >
											<asp:ListItem Value="" Text="Select Country" disabled selected style='display:none;'/>
										</asp:DropDownList>
										<asp:RequiredFieldValidator ID="rfvCountry" ControlToValidate="Country" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
									</div>

									<div class="subcolumns" style="margin-bottom:15px">
										<div class="c50l">
											<div class="subcl type-text">
												<asp:TextBox ID="phone_number" runat="server" placeholder="Phone Number" style="margin-left:10px;"/>
											</div>
										</div>
										<div class="c50r">
											<div class="subcr type-text">
												<span class="req-left">*</span>
												<asp:TextBox ID="email" runat="server" placeholder="Email Address" />
												<asp:RequiredFieldValidator ID="rfvemail" ControlToValidate="email" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
											</div>
										</div>
									</div>

									<div class="subcolumns">
										<div class="c50l">
											<div class="subcl" id="reqtext">
												<span style="padding: 10px 5px 0 0;color: #ff0000;">*</span> Required
											</div>
										</div>
										<div class="c50r">
											<div class="subcr type-button">
												<asp:Button ID="cmdSubmit" Text="SUBMIT" runat="server" CssClass="submitbutton" onclick="cmdSubmit_Click" ValidationGroup="vgNew" />
											</div>
										</div>
									</div>
									<div style="clear:both"></div>
									</div>
							</asp:View>
							<asp:View ID="vwThank" runat="server">
								<h2>Thank You</h2>
								<p>Your request for information has been received and you should expect to receive your materials shortly.</p>
								<!-- Google Code for Catalog Request Conversion Page -->
								<script type="text/javascript">
								/* <![CDATA[ */
								var google_conversion_id = 1051567786;
								var google_conversion_language = "en";
								var google_conversion_format = "3";
								var google_conversion_color = "ffffff";
								var google_conversion_label = "1dPSCLS9sgIQqs229QM";
								var google_conversion_value = 0;
								if (1) {
								  google_conversion_value = 1;
								}
								/* ]]> */
								</script>
								<script type="text/javascript" src="http://www.googleadservices.com/pagead/conversion.js">
								</script>
								<noscript>
								<div style="display:inline;">
								<img height="1" width="1" style="border-style:none;" alt="" src="http://www.googleadservices.com/pagead/conversion/1051567786/?value=1&amp;label=1dPSCLS9sgIQqs229QM&amp;guid=ON&amp;script=0"/>
								</div>
								</noscript>

							</asp:View>
						</asp:MultiView>
					</div>
					<div id="ie_clearing"> &#160; </div>
				</div>
			</div>
	<asp:SqlDataSource ID='dataCountries' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
		SelectCommand="sp_GetCountryList" SelectCommandType="StoredProcedure">
	</asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
</asp:Content>

