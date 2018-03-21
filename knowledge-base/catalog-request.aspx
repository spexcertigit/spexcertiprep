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
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/">Home</a> > Knowledge Base > Request a Catalog</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
	<div id="mainHeader">
		<h1>Request a Catalog</h1>
	</div>
	<div id="main">
		<div id="col1">
			<div id="col1_content" class="clearfix">
				<uc1:ShareThis ID="ShareThis1" runat="server" />
			</div>

			<div id="col1_content2" class="clearfix">
				<h2>Catalog Archives</h2>
				<br />
				<p>SPEX CertiPrep is celebrating <i><strong>60 years</strong></i> in 2014! Take a trip through SPEX history and browse our archive of product catalogs and literature dating back to 1954.</p>
				<p>Visit our SPEX <a href="http://www.spexspeaker.com/catalogarchives">catalog archive</a>.</p>
				<br /><br />
				<p><a href="http://www.spexspeaker.com/catalogarchives"><img src="images/1955-09_SPEXIndustriesCatalog.jpg" alt="SPEX very first catalog" height="150" width="118" style="border:solid 1px" /></a></p>
			</div>

		</div>

		<div id="col3">
			<div id="col3_content" class="clearfix">
				<asp:MultiView ID="mvForm" runat="server" ActiveViewIndex="0">
					<asp:View ID="vwForm" runat="server">
						<div id="catreq_form" class="form_grey yform" style="width:660px;">
							<div style="margin-bottom:10px" >
								<h3 style="font-weight:bold; font-size:1.4em;">Download or request a copy of our latest literature.</h3> 
							</div>
							<div id="catalog" class="floatbox">
								<h3 style="font-size:1.3em; padding-left:4px;">Browse our catalog as an interactive flipbook:</h3>
								<div id="OrgFlipbook"> 
									<a href="/organic/" target="_blank">
										<img class="organic_catalog" name="organic_catalog" src="images/OrganicFlipbook.jpg" width="220" height="86" alt="View Interactive Organic Catalog" />
									</a>
									<h3>Organic Flipbook Catalog</h3>
								</div>

								<div> 
									<a href="/inorganic/" target="_blank">
										<img class="inorganic_catalog" name="inorganic_catalog" src="images/InorganicFlipbook.jpg" width="220" height="86" alt="View Interactive Inorganic Catalog" /> 
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

								<asp:Literal ID="ltrProdLit" runat="server" />
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
							
							<div class="subcolumns">
								<div class="type-text">
									<asp:TextBox ID="txtTitle" runat="server" Width="94%" style="margin-left:10px;" placeholder="Title" />
								</div>
							</div>
							
							<div class="type-text">
								<asp:TextBox ID="company_name" runat="server" Width="94%" style="margin-left:10px;" placeholder="Company Name" />
							</div>

							<div class="type-text">
								<span class="req-left">*</span>
								<asp:TextBox ID="company_address" runat="server" Width="94%" placeholder="Company Address" />
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
	<script type="text/javascript" src="http://www.googleadservices.com/pagead/conversion.js"></script>
	<noscript>
		<div style="display:inline;">
			<img height="1" width="1" style="border-style:none;" alt="" src="http://www.googleadservices.com/pagead/conversion/1051567786/?value=1&amp;label=1dPSCLS9sgIQqs229QM&amp;guid=ON&amp;script=0"/>
		</div>
	</noscript>
</asp:Content>

