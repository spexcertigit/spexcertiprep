<%@ Page Title="SPEX CertiPrep - Products - Custom Standards - Inorganic" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="custom-standards_inorganic.aspx.cs" Inherits="products_custom_standards_inorganic" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/">Home</a> > Products > Custom Standards</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="main">
				<div id="cisr_headerlabel" class="headerlabel">
            		<span class="label-left">
            			<h1 class="title">Custom Inorganic Standards Request Form</h1>
            		</span>
            		<span class="label-right">
            			<a href="custom-standards_organic.aspx">Click for Custom Organic Standards</a>
            		</span>
            	</div>
				<div id="cisr_gencontent_full">
					<div id="cisrForm">
						<asp:MultiView ID="mvForm" runat="server" ActiveViewIndex="0">
                            <asp:View ID="vwForm" runat="server">
								<div class="row">
									<div class="col-lg-12">
										<p>SPEX CertiPrep can customize any Standard to meet your specific needs. Enter the Analyte. Next, enter the Concentration.</p>
									</div>
								</div>
								<div class="subcolumns">
									<div class="row">
										<div class="col-lg-4">
											<div class="form-group">
												<asp:DropDownList ID="component" ClientIDMode="Static" runat="server" CssClass="form-control ddl-bg" DataSourceID="dataComponents" DataTextField="caNameWeb" DataValueField="caNameWeb" AppendDataBoundItems="true">
													<asp:ListItem Value="" disabled selected style='display:none;' Text="Component *" />
												</asp:DropDownList>
											</div>
										</div>
										<div class="col-lg-4">
											<div class="form-group" id="cisr_center_wrap">
												<asp:TextBox ID="concentration" placeholder="Concentration *" ClientIDMode="Static" runat="server" CssClass="form-control em-ph" />
											</div>
										</div>
										<div class="col-lg-4">
											<div class="form-group">
												<asp:DropDownList ID="units_menu" ClientIDMode="Static" runat="server" CssClass="form-control ddl-bg" DataSourceID="dataUnits" DataTextField="cuUnit" DataValueField="cuUnit" AppendDataBoundItems="true">
													<asp:ListItem Text="Other" Value="Other" />
												</asp:DropDownList>
											 </div>
										</div>
									</div>
								</div>
								
								<div class="subcolumns">
									<div class="row">
										<div class="col-lg-12">
											<div class="footer_item footer_checkout clear" id="add_component">
												ADD COMPONENT
											</div>
										</div>
									</div>
								</div>
								
								<div class="subcolumns">
									<div class="row">
										<div class="col-lg-12">
											<table id="component_table" align="center" style="clear: both;">
												<thead>
													<tr>
														<th scope="col">Component</th>
														<th scope="col">Concentration</th>
														<th scope="col">Units</th>
														<th scope="col">Remove</th>
													</tr>
												</thead>
												<tbody>
													<tr id="first_row">
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>
												</tbody>
											</table>
											
											<div id="mobile_component_table"> </div>
										</div>
									</div>
								</div>
								
								<div class="subcolumns">
									<div class="row">
										<div class="col-lg-4">
											<div class="form-group">
												<asp:DropDownList ID="instrument_type" runat="server" CssClass="form-control ddl-bg">
													<asp:ListItem Value="" disabled selected style='display:none;' Text="Instrument Type *" />
													<asp:ListItem Text="ICP" Value="ICP" />
													<asp:ListItem Text="ICP-MS" Value="ICP-MS" />
													<asp:ListItem Text="IC" Value="IC" />
													<asp:ListItem Text="AA" Value="AA" />
													<asp:ListItem Text="XRF" Value="XRF" />
													<asp:ListItem Text="GC" Value="GC" />
													<asp:ListItem Text="GC-MS" Value="GC-MS" />
													<asp:ListItem Text="LC" Value="LC" />
													<asp:ListItem Text="LC-MS" Value="LC-MS" />
													<asp:ListItem Text="LC-ICP-MS" Value="LC-ICP-MS" />
													<asp:ListItem Text="Other" Value="Other" />
												</asp:DropDownList>
												<asp:RequiredFieldValidator ID="rfvinstrument_type" ControlToValidate="instrument_type" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
											</div>
											
											<div id="other_instru_box" class="form-group" style="margin-top:18px;display:none">
												<asp:TextBox ID="other_instru" runat="server" CssClass="form-control em-ph" placeholder="Other Instrument *" />
											</div>
											
											<div class="form-group" style="margin-top:18px;">
												<asp:TextBox ID="volume" runat="server" CssClass="form-control em-ph" placeholder="Volume *" />
												<asp:RequiredFieldValidator ID="rfvvolume" ControlToValidate="volume" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
											</div>
										</div>
										<div class="col-lg-4">
											<div class="form-group" id="cisr_center_wrap">
												<asp:DropDownList ID="matrix" runat="server" CssClass="form-control ddl-bg" DataSourceID="dataMatrix" DataTextField="T542_Short" DataValueField="T542_Short" AppendDataBoundItems="true">
													<asp:ListItem Value="" disabled selected style='display:none;' Text="Matrix *" />
												</asp:DropDownList>
												<asp:RequiredFieldValidator ID="rfvMatrix" ControlToValidate="matrix" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
											</div>
											
											<div class="form-group" id="cisr_center_wrap" style="margin:18px auto 0;">
												<asp:TextBox ID="quantity" runat="server" CssClass="form-control em-ph" placeholder="Quantity *"/>
												<asp:RequiredFieldValidator ID="rfvQuantity" ControlToValidate="quantity" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
											</div>
										</div>
										<div class="col-lg-4">
											<div class="form-group">
												<asp:TextBox ID="comments" runat="server" CssClass="form-control em-ph" TextMode="MultiLine" Rows="4" placeholder="Comments/Notes" />
											</div>
										</div>
									</div>
								</div>
								
								<div class="subcolumns" id="cisr_checkbox_wrap">
									<div class="row">
										<asp:TextBox ID="components" runat="server" TextMode="MultiLine" ClientIDMode="Static" style="visibility:hidden;position:absolute;" />
										<div class="col-lg-7">
											<div class="row">
												<div class="col-md-4">
													<div class="form-group">
														<div class="checkbox">
															<label>
																<asp:CheckBox ID="measured_values" runat="server" />
																Measured Values
															</label>
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group">
														<div class="checkbox">
															<label>
																<asp:CheckBox ID="impurities" runat="server" />
																Impurities
															</label>
														</div>
													</div>
												</div>
												<div class="col-md-4"> 
													<div class="form-group">
														<div class="checkbox">
															<label>
																<asp:CheckBox ID="density_reported" runat="server" />
																Density Reported
															</label>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="col-lg-5">
											<div class="checkbox">
												<span>(These options incurr an additional charge)</span>   
											</div>											
										</div>
									</div>
								</div>
								<div class="subcolumns" style="margin: 17px 0 13px;">
									<div class="row">
										<div class="col-lg-12">
											<h3>Your Information</h3>
										</div>
									</div>
								</div>
								<div class="subcolumns">
									<div class="row">
										<div class="col-lg-4">
											<div class="form-group">
												<asp:TextBox ID="first_name" runat="server" CssClass="form-control em-ph" placeholder="First Name *" />
												<asp:RequiredFieldValidator ID="rfvfirstname" ControlToValidate="first_name" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
											</div>
										</div>
										<div class="col-lg-4">
											<div class="form-group" id="cisr_center_wrap">
												<asp:TextBox ID="last_name" runat="server" CssClass="form-control em-ph" placeholder="Last Name *" />
												<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="last_name" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
											</div>
										</div>
										<div class="col-lg-4">
											<div class="form-group">
												<asp:TextBox ID="txtTitle" runat="server" CssClass="form-control em-ph" placeholder="Title" />
											</div>
										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-lg-4">
										<div class="form-group">
											<asp:TextBox ID="company_name" runat="server" CssClass="form-control em-ph" placeholder="Company Name *" />
											<asp:RequiredFieldValidator ID="rfvcompany_name" ControlToValidate="company_name" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
										</div>
									</div>
									<div class="col-lg-4">
										<div class="form-group" id="cisr_center_wrap">
											<asp:TextBox ID="company_address" runat="server" CssClass="form-control em-ph" placeholder="Company Address *"/>
											<asp:RequiredFieldValidator ID="rfvcompany_address" ControlToValidate="company_address" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
										</div>
									</div>
									<div class="col-lg-4">
										<div class="form-group">
											<asp:TextBox ID="city" runat="server" CssClass="form-control em-ph" placeholder="City *"/>
                                            <asp:RequiredFieldValidator ID="rfvcity" ControlToValidate="city" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
										</div>
									</div>
								</div>
								
								<div class="row"> 
									<div class="col-lg-4">
										<div class="form-group">
											<asp:TextBox ID="state_region" runat="server" CssClass="form-control em-ph" placeholder="State/Province/Region *" />
                                            <asp:RequiredFieldValidator ID="rfvstate_region" ControlToValidate="state_region" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
										</div>
									</div>
									<div class="col-lg-4">
										<div class="form-group" id="cisr_center_wrap">
											<asp:TextBox ID="zip" runat="server" CssClass="form-control em-ph" placeholder="ZIP/Postal Code *" />
                                            <asp:RequiredFieldValidator ID="rfvzip" ControlToValidate="zip" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
										</div>
									</div>
									<div class="col-lg-4">
										<div class="form-group">
											<asp:DropDownList ID="Country" CssClass="form-control ddl-bg" runat="server" DataSourceID="dataCountries" DataTextField="countryname" DataValueField="countryCode">
												<asp:ListItem Value="" disabled selected style='display:none;' Text="Country *" />
											</asp:DropDownList>
											<asp:RequiredFieldValidator ID="rfvCountry" ControlToValidate="Country" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-lg-4">
										<div class="form-group">
											<asp:TextBox ID="phone_number" runat="server" CssClass="form-control em-ph" placeholder="Phone Number *"/>
                                            <asp:RequiredFieldValidator ID="rfvphone_number" ControlToValidate="phone_number" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
										</div>
									</div>
									<div class="col-lg-4" id="cisr_center_wrap">
										<div class="form-group">
											<asp:TextBox ID="email" runat="server" CssClass="form-control em-ph" placeholder="Email Address *"/>
                                            <asp:RequiredFieldValidator ID="rfvemail" ControlToValidate="email" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
										</div>
									</div>
									<div class="col-lg-4">
										<div class="form-group">
											<asp:DropDownList ID="Refer" runat="server" CssClass="form-control ddl-bg">
												<asp:ListItem Value="" disabled selected style='display:none;' Text="How did you hear about us?" />
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
									</div>
								</div>
								
								<div class="subcolumns">
									<div class="row">
										<div class="col-lg-12 text-right">
											<asp:Button ID="cmdSubmit" Text="SUBMIT" runat="server" ClientIDMode="Static" CssClass="submitbutton" onclick="cmdSubmit_Click" ValidationGroup="vgNew" />
											<div class="required_div">* Required</div>
										</div>
									</div>
                                </div>
							</asp:View>
                            <asp:View ID="vwThank" runat="server">
                                <h2>Thank You</h2>
                                <p>Your Custom Standards Request has been sent and a Sales Support Specialist will be contacting you shortly.</p>
								<!-- Google Code for Custom Standard Conversion Page -->
								<script type="text/javascript">
								/* <![CDATA[ */
								var google_conversion_id = 1051567786;
								var google_conversion_language = "en";
								var google_conversion_format = "3";
								var google_conversion_color = "ffffff";
								var google_conversion_label = "0yU-CIymvQIQqs229QM";
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
								<img height="1" width="1" style="border-style:none;" alt="" src="http://www.googleadservices.com/pagead/conversion/1051567786/?value=1&amp;label=0yU-CIymvQIQqs229QM&amp;guid=ON&amp;script=0"/>
								</div>
								</noscript>
								
                            </asp:View>
                        </asp:MultiView>
					</div>
				</div>
               
            </div>

    <asp:SqlDataSource ID='dataCountries' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="sp_GetCountryList" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataComponents' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT caNameWeb FROM certiAnalytes ORDER BY caNameWeb" SelectCommandType="Text">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataUnits' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT cuUnit FROM certiUnits ORDER BY cuUnit" SelectCommandType="Text">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataMatrix' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT DISTINCT T542_Short from cp_roi_Matrix WHERE T542_Code != '112' AND T542_Code != '114' ORDER BY T542_Short" SelectCommandType="Text">
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script type="text/javascript">
		$(document).ready(function () {
			var first_row = "not filled";
			var component_counter = 0;
			$(".ddl-bg").change(function() {
				$(this).css("font-style", "normal");
				$(this).css("color", "#555");
			});
			$('#submit').click(function () {
				if (first_row == 'not filled') {
					alert("Please add a component");
					$('#organic_inorganic').focus();
					return false;
				} else {
					$("#custom-standards").validate({
						submitHandler: function (form) {
							form.submit();
						}
					});
				}
			});

			$('#add_component').click(function () {
				error = "";
				component = $('#component').val();
				if (component == '') {
					error += "Component is missing.\n";
				}
				concentration = $('#concentration').val();
				if (concentration == '') {
					error += "Concentration is missing.\n";
				}
				var units = $('#units_menu').val();
				other = $('#other').val();
				if (units == '' || units == 'Other') {
					if (other == '') {
						error += "Units are missing.";
					} else {
						units = other;
					}
				}
				$("#component_table tr").each(function () {
					if ($(this).find(".comp").html() == component) {
						error = "Duplicate Compound: " + component + " has already been added.";
					}
				});
				
				$("#component option").each(function() {
					if ($(this).val() == $('#component').val()) {
						$(this).css("display", "none");
					}
				});

				if (error != "") {
					alert(error);
				} else {
					if (first_row == "not filled") { 
						first_row = "filled";
						component_counter = component_counter + 1;

						$("#first_row").html("<td class='comp'>" + component + "</td><td>" + concentration + "</td><td>" + units + "</td><td><img src=\"../images/remove_button.gif\" width=\"27\" height=\"27\" alt=\"Remove Item\" class=\"removeicon\"></td>");
						$('#components').text("Component = " + component + " Concentration = " + concentration + units);
						$('#mobile_component_table').html("<table class='m_component_table'>" +
															"<tr><th style='width:35%'>Component</th><td>"+component+"</td></tr>"+
															"<tr><th>Concentration</th><td>"+ concentration +"</td></tr>"+
															"<tr><th>Units</th><td>"+ units +"</td></tr>"+
															"<tr><th>Remove</th><td><img src=\"../images/remove_button.gif\" width=\"27\" height=\"27\" alt=\"Remove Item\" class=\"removeicon2\"></td></tr>"+
														  "</table>");
					} else { 
						//if first_row is already filled, just append	
						component_counter = component_counter + 1;

						$('<tr><td>' + component + '</td><td>' + concentration + '</td><td>' + units + '</td><td><img src=\"../images/remove_button.gif\" width=\"27\" height=\"27\" alt=\"Remove Item\" class=\"removeicon\"></td></tr>').appendTo("#component_table > tbody:last").show('slow');
						$('#components').append("\nComponent = " + component + " Concentration = " + concentration + units);
						$("#component_table tr:odd").addClass("oddtablerow"); //make odd table rows grey reach time after new row is added or deleted
						$("<table class='m_component_table'>" +
							"<tr><th style='width:35%'>Component</th><td>"+component+"</td></tr>"+
							"<tr><th>Concentration</th><td>"+ concentration +"</td></tr>"+
							"<tr><th>Units</th><td>"+ units +"</td></tr>"+
							"<tr><th>Remove</th><td><img src=\"../images/remove_button.gif\" width=\"27\" height=\"27\" alt=\"Remove Item\" class=\"removeicon2\"></td></tr>"+
						"</table>").appendTo("#mobile_component_table").show("slow");
					}
				}
			});

			$('#cmdSubmit').click(function (event) {
				if (first_row == "not filled") {
					alert("Please select a component.");
					event.preventDefault();
				}
			});

			$('table td img.removeicon').live('click', function () {
				$(this).parent().parent().remove();
				$("#component_table tr:odd").addClass("oddtablerow"); //make odd table rows grey reach time after new row is added or deleted
			});

			$('table td img.removeicon2').live('click', function () {
				$(this).parent().parent().parent().remove();
			});
			
			$('#units_menu').change(function () {
				if ($('#units_menu').val() == 'Other') {
					$('#other').show();
				} else {
					$('#other').hide();
				}
			});
			
			$("#instrument_type").change(function() {		
				if ($("#instrument_type").val() == "Other") {
					$("#other_instru_box").show();
				}else {
					$("#other_instru_box").hide();
				}
			});
		});
	</script>
</asp:Content>

