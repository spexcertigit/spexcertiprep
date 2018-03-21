<%@ Page Title="SPEX CertiPrep - About Us - Contact Us" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="contact-us.aspx.cs" Inherits="about_contact" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <style type="text/css">
    .form_grey label { display:block;margin-top:10px; }
    .form_grey input, .form_grey select, .form_grey textarea { display:block; }
	select, select:hover, select:active, select:focus {
	/*	border: 2px inset #ddd !important;	*/
	}
	#breadcrumb {
		padding: 0 0 25px 0;
	}
</style>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="cphMap" Runat="Server">

       <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
    <script>
        function initialize() {
            var myLatlng = new google.maps.LatLng(40.546170, -74.371669);
            var mapOptions = {
                zoom: 12,
                scrollwheel: false,
                center: myLatlng
            }
            var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

            var marker = new google.maps.Marker({
                position: myLatlng,
                map: map,
                title: '203 Norcross Avenue, Metuchen, NJ 08840',
                icon: '/images/google_marker.png'
            });
        }

        google.maps.event.addDomListener(window, 'load', initialize);
		
    </script>
    <div id="map-canvas" style="width:100%;height:200px;margin:0;"></div>
    <div class="mapgradient"></div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="../default.aspx">Home</a> > About Us > Contact Us</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
<script>
	$(function() {
		if (window.PIE) {
			$('input').each(function() {
				PIE.attach(this);
			});
			$('textarea').each(function() {
				PIE.attach(this);
			});
		}
		
		try {
			if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
			 // some code..
			}else {
				$("#Country").msDropDown();
				$("#DropDownList1").msDropDown();
			}
		} catch (e) {
			alert(e.message);
		}
	});
</script>
            <style>
			#productpage_tagline,#col1,#mainHeader{display:none;}
			#col3{border:none;}
			#Country{width: 100%;}
			</style>
    
			<div id="mainHeader">
            
            </div>
			
			<div class="">
            <div id="main" style="margin-bottom:6em;">
            	<div class="headerlabel">
            		<span class="label-left">
            			<h1 class="title">Contact Us</h1>
            		</span>
            		<span class="label-right">
            			<a href="sales-reps.aspx">US Sales Representatives</a> |
            			<a href="sales-reps.aspx">UK Sales Representatives</a> |
            			<a href="distributors.aspx">International Distributors</a>
            		</span>
            	</div>
            	<div id="gencontent_full">
					<div id="contactform" class="yform">
						<asp:MultiView ID="mvForm" runat="server" ActiveViewIndex="0">
                            <asp:View ID="vwForm" runat="server">
		                        <div class="contact-us-left">
                            	<span class="head-text">We love to hear from our customers.  Please fill out the form below.</span>
								<br /><br />
                				<span class="req-label"><span class="req">*</span> Required Fields</span>
		                            <div class="contact-us-left-box1">
		                                <div class="type-text">
											<span class="req-left">*</span>
		                                    <asp:TextBox ID="first_name" runat="server" CssClass="input-260" MaxLength="100" placeholder="First Name" />
		                                    <asp:RequiredFieldValidator ID="rfvfirstname" ControlToValidate="first_name" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
		                                </div>
		                        
		                                <div class="type-text">
											<span class="req-left">*</span>
		                                    <asp:TextBox ID="last_name" runat="server" CssClass="input-260" MaxLength="100" placeholder="Last Name" />
		                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="last_name" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
		                                </div>
										
										<div class="type-text">
											<asp:TextBox ID="txtTitle" runat="server" CssClass="input-260 indent" MaxLength="100" placeholder="Title" />
										</div>
										
										<div class="type-text">
											<asp:TextBox ID="company_name" runat="server" CssClass="input-260 indent" MaxLength="100" placeholder="Company Name"/>
										</div>
										
										<div class="type-text">
											<span class="req-left">*</span>
											<asp:TextBox ID="company_address" runat="server" CssClass="input-260" MaxLength="100" placeholder="Company Address"/>
											<asp:RequiredFieldValidator ID="rfvcompany_address" ControlToValidate="company_address" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
										</div>
										
										<div class="type-text">
		                                    <asp:TextBox ID="phone_number" runat="server" CssClass="input-260 indent" MaxLength="50" placeholder="Phone Number" />
		                                </div>
										
										<div class="type-select" style="padding:3px 0px 0px 8px">
											<span class="req-left" style="visibility:hidden;float:left">*</span>
													<asp:DropDownList ID="Country" runat="server" CssClass="select-270" AppendDataBoundItems="true" DataSourceID="dataCountries" DataTextField="countryname" DataValueField="countryCode">
														<asp:ListItem Value="" Text="Select Country" disabled selected style='display:none;'/>
													</asp:DropDownList>
													
													<asp:RequiredFieldValidator ID="rfvCountry" ControlToValidate="Country" ForeColor="Red" Display="Dynamic" EnableClientScript="true" 	runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
										</div>
										
										<div class="subcl how-text">
											<p>How did you hear about SPEX CertiPrep? </p>
										</div>
										
		                            </div>
			                        <div class="contact-us-left-box2">
			                            <div class="type-text">
											<span class="req-left">*</span>
		                                    <asp:TextBox ID="email" runat="server" CssClass="input-260" MaxLength="255" placeholder="Email Address"/>
		                                    <asp:RequiredFieldValidator ID="rfvemail" ControlToValidate="email" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
			                            </div>
			                            <div class="type-text">
											<span class="req-left">*</span>
			                                <asp:TextBox ID="city" runat="server" CssClass="input-260" MaxLength="100" placeholder="City"/>
			                                <asp:RequiredFieldValidator ID="rfvcity" ControlToValidate="city" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
			                            </div>
			                            <div class="type-text">
											<span class="req-left">*</span>
			                                <asp:TextBox ID="state_region" runat="server" CssClass="input-260" MaxLength="50" placeholder="State/Province/Region"/>
			                                <asp:RequiredFieldValidator ID="rfvstate_region" ControlToValidate="state_region" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
			                            </div>
			                            <div class="type-text">
											<span class="req-left">*</span>
		                                    <asp:TextBox ID="zip" runat="server" CssClass="input-260" MaxLength="50" placeholder="ZIP/Postal Code" />
		                                    <asp:RequiredFieldValidator ID="rfvzip" ControlToValidate="zip" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
			                            </div>
			                            <div class="type-text">
											<span class="req-left">*</span>
					                        <asp:TextBox ID="Inquiry" runat="server" CssClass="input-260 text-115" Rows="3" placeholder="Inquiry" TextMode="MultiLine" MaxLength="1000" />
					                        <asp:RequiredFieldValidator ID="rfvInquiry" ControlToValidate="Inquiry" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
					                    </div>
					                    <div class="type-select" style="padding:3px 0px 0px 8px; margin-bottom:16px;">
											<span class="req-left" style="visibility:hidden;float:left">*</span>
													<asp:DropDownList ID="DropDownList1" runat="server" CssClass="select-270">
														<asp:ListItem Value="" disabled selected style='display:none;' Text="Choose One" />
														<asp:ListItem Value="Coworker" Text="Coworker" />
														<asp:ListItem Value="Current Customer" Text="Current Customer" />
														<asp:ListItem Value="E-blast" Text="E-blast" />
														<asp:ListItem Value="Magazine ad" Text="Magazine ad" />
														<asp:ListItem Value="Internet search" Text="Internet search" />
														<asp:ListItem Value="Postcard" Text="Postcard" />
														<asp:ListItem Value="Tradeshow" Text="Tradeshow" />
														<asp:ListItem Value="Web ad" Text="Web ad" />
													</asp:DropDownList>
										</div>
										<div class="contact-button" style="margin-right:2px">
					                     <asp:Button ID="cmdSubmit" Text="SUBMIT" runat="server" CssClass="submitbutton" onclick="cmdSubmit_Click" ValidationGroup="vgNew"/>
										</div>
									</div>
			                    </div>
		                        <div class="contact-us-right">
									<div class="address-top">
										<h2 class="add-name">United States <span class="add-label">Address</h2>
									</div>
									<div class="add-content">
										<div class="add-inner">1-800-LAB-SPEX</div>
										<div class="add-inner">crmsales@spex.com</div>
										<div class="add-inner">203 Norcross Avenue<br>
											Metuchen, NJ 08840
										</div>
									</div>
									<div class="address-bottom">
										<h2 class="add-name">United Kingdom <span class="add-label">Address</h2>
									</div>
									<div class="add-content">
										<div class="add-inner">+44 (0) 20 8240 6656</div>
										<div class="add-inner">sales@spexcertiprep.co.uk</div>
										<div class="add-inner">2 Dalston Gardens, Stanmore<br>
											Middlesex, HA7 1BQ, UK
										</div>
									</div>
		                        </div>
                              
		                    </div>
                      <div class="footer-contactus">
                                    <div class="bottom-left bottomfloat">
                                        <a href="/products/SPEXertificate.aspx"><div class="lfb"></div></a>
                                        <a href="/knowledge-base/MSDS.aspx"><div class="lfb2"></div></a>
                                    </div>
                                    <div class="bottom-right bottomfloat">
                                        <h2>Organic and Inorganic Custom Standards</h2>
                                        <p class="p1">SPEX CertiPrep has over 60 years experience 
                                        in making custom standards to your exact 
                                        specifications. Choose the type of product 
                                        you need and complete the form. </p>
                                        <p class="p2">
                                            Our knowledgabe staff will verify your mix 
                                            and provide you with a quote within 2 
                                            business days.
                                        </p>
                                        <a href="/products/custom-standards_organic.aspx" class="rocs-layout">Request Organic Custom Standards</a>
                                         <a href="/products/custom-standards_inorganic.aspx" class="rics-layout">Request Inorganic Custom Standards</a>
                                    </div>
                                    <div class="clear"></div>
                                </div>
						</asp:View>
                        <asp:View ID="vwThank" runat="server">
							<h2>Thank You</h2>
							<p>Your message has been sent and someone from SPEX CertiPrep will be contacting you shortly.</p>
							<!-- Google Code for Contact Us Conversion Page -->
							<script type="text/javascript">
							/* <![CDATA[ */
							var google_conversion_id = 1051567786;
							var google_conversion_language = "en";
							var google_conversion_format = "3";
							var google_conversion_color = "ffffff";
							var google_conversion_label = "u8wLCJSlvQIQqs229QM";
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
							<img height="1" width="1" style="border-style:none;" alt="" src="http://www.googleadservices.com/pagead/conversion/1051567786/?value=1&amp;label=u8wLCJSlvQIQqs229QM&amp;guid=ON&amp;script=0"/>
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

