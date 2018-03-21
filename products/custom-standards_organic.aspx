
<%@ Page Title="SPEX CertiPrep - Products - Custom Standards - Organic" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="custom-standards_organic.aspx.cs" Inherits="products_custom_standards_organic" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/">Home</a> > Products > Custom Standards</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">

            <div id="main">
				<div id="cisr_headerlabel" class="headerlabel">
            		<span class="label-left">
            			<h1 class="title">Custom Organic Standards Request Form</h1>
            		</span>
            		<span class="label-right">
            			<a href="custom-standards_inorganic.aspx">Click for Custom Inorganic Standards</a>
            		</span>
            	</div>
				<div id="cisr_gencontent_full">
					<div id="cisrForm">
						<asp:MultiView ID="mvForm" runat="server" ActiveViewIndex="0">
                            <asp:View ID="vwForm" runat="server">
								<div class="row">
									<div class="col-lg-12">
										<p>SPEX CertiPrep can customize any Standard to meet your specific needs. Enter the Component or CAS#. Next, enter the Concentration.</p>
										<div style="display: block;margin: 0.5em 0;padding: 3px 0.5em;position: relative;">
											<input type="radio" id="casRad" name="SearchBy" value="CAS" checked="checked" /> <label for="casRad">Search by CAS</label> &nbsp;&nbsp;&nbsp;&nbsp;
											<input type="radio" id="compRad" name="SearchBy" value="Component" /> <label for="compRad">Search by Component Name</label>
										</div>
									</div>
								</div>
								<div class="subcolumns">
									<div class="row">
										<div class="col-lg-4">
											<div id="pnlComponent" style="display:none;">
												<div class="form-group">
													<asp:DropDownList ID="component" ClientIDMode="Static" runat="server" DataSourceID="dataComponents" CssClass="form-control ddl-bg" DataTextField="CompCAS" DataValueField="cmpComp" AppendDataBoundItems="true">
														<asp:ListItem Value="" disabled selected style='display:none;' Text="Component *" />
													</asp:DropDownList>
												</div>
											</div>
											<div id="pnlCAS">
												<div class="form-group">
													<asp:DropDownList ID="CASNumber" ClientIDMode="Static" runat="server" DataSourceID="dataCAS" CssClass="form-control ddl-bg" DataTextField="CompCAS" DataValueField="cmpCAS" AppendDataBoundItems="true">
														<asp:ListItem Value="" disabled selected style='display:none;' Text="CAS Number *" />
													</asp:DropDownList>
												</div>
											</div>
										</div>
										<div class="col-lg-4">
											<div class="form-group">
												<asp:TextBox ID="concentration" CssClass="form-control em-ph" placeholder="Concentration *" ClientIDMode="Static" runat="server" />
											</div>
										</div>
										<div class="col-lg-4">
											<div class="form-group">
												<asp:DropDownList ID="units_menu" ClientIDMode="Static" runat="server" CssClass="form-control ddl-bg" DataSourceID="dataUnits" DataTextField="cuUnit" DataValueField="cuUnit" AppendDataBoundItems="true">
													<asp:ListItem Text="Units" Value="" disabled selected style="display:none;"/>
												</asp:DropDownList>
											</div>
											<div class="text-center">
												or
											</div>
											<div class="form-group">
												<asp:TextBox ID="other" ClientIDMode="Static" runat="server" CssClass="form-control em-ph" placeholder="Other" />
											</div>
										</div>
									</div>
								</div>
								
								<div class="subcolumns">
									<div class="row">
										<div class="col-lg-12 text-right">
											<div class="footer_item footer_checkout clear" id="add_component">
												ADD COMPONENT
											</div>
										</div>
									</div>
								</div>
								
								<div class="subcolumns">
									<div class="row">
										<div class="col-lg-12">
											<table id="component_table_org" align="center" style="clear: both;">
												<thead>
													<tr>
														<th scope="col">Component</th>
														<th scope="col" class="organic">CAS Number</th>
														<th scope="col">Concentration</th>
														<th scope="col">Units</th>
														<th scope="col">Remove</th>
													</tr>
												</thead>
												<tbody>
													<tr id="first_row">
														<td>&nbsp;</td>
														<td class="desc organic">&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>
												</tbody>
											</table>
											<asp:TextBox ID="components" runat="server" TextMode="MultiLine" ClientIDMode="Static" style="visibility:hidden;position:absolute;" />
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
												<asp:TextBox ID="volume" runat="server" CssClass="form-control" placeholder="Volume *" />
												<asp:RequiredFieldValidator ID="rfvvolume" ControlToValidate="volume" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
												<div style="font-size:12px;margin-top:5px;">Volume of 1mL requires minimum quantity of 5</div>
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
								
								<div>
									<div class="row">
										<div class="col-lg-4">
											<div class="form-group">
												<asp:TextBox ID="company_name" runat="server" CssClass="form-control em-ph" placeholder="Company Name *" />
												<asp:RequiredFieldValidator ID="rfvcompany_name" ControlToValidate="company_name" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
											</div>
										</div>
										<div class="col-lg-4">
											<div class="form-group" id="cisr_center_wrap" >
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
								</div>
								
								<div>
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
								</div>
								
								<div>
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
								</div>
								<div class="subcolumns text-right">
									<div class="row">
										<div class="col-lg-12">
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
        SelectCommand="SELECT cmpComp, cmpCAS, cmpComp + ' (CAS: ' + ISNULL(cmpCAS, 'No CAS') + ')' AS CompCAS FROM certiComps ORDER BY cmpComp" SelectCommandType="Text">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataCAS' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT cmpCAS, cmpCAS + ' (' + cmpComp + ')' AS CompCAS FROM certiComps WHERE cmpCAS IS NOT NULL AND cmpCAS <> '' AND cmpCAS <> 'MULTIPLE' AND cmpCAS <> 'N/A' AND cmpCAS <> 'NA' AND cmpCAS <> 'NONE' AND cmpCAS <> 'NOTNEEDED' AND cmpCAS <> 'UNKNOWN' ORDER BY cmpCAS" SelectCommandType="Text">
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
			$("input[name='SearchBy']").click(function () {
				if ($("input[name='SearchBy']:checked").val() == "CAS") {
					$("#pnlComponent").hide();
					$("#pnlCAS").show();
					$("#component").val("");
				} else if ($("input[name='SearchBy']:checked").val() == "Component") {
					$("#pnlComponent").show();
					$("#pnlCAS").hide();
					$("#CASNumber").val("");
				}
			});

			$("select#units").change(function () {
				//if other selected - show textbox
				val = $("select#units").val();
				if (val == "Other") {
					$("#units_input").html("<label for=\"units\" class=\"100wide block\" style=\"width: 50px;\">Other: </label><input type=\"text\" name=\"units\" id=\"units\" class=\"input_50wide_block\">");
				}
			});

			$('#add_component').click(function () {
				error = "";
				component = $('#component').val();
				CASNumber = $('#CASNumber').val();
				if (component == '' && CASNumber == '') {
					error += "Component / CAS number is missing. ";
				}

				var selectedVal = "";
				var selected = $("input[type='radio'][name='SearchBy']:checked");
				if (selected.length > 0) {
					selectedVal = selected.val();
					// alert(selectedVal);
				}

				if (selectedVal == "Component") {
					//View Component
					comNum = $('#component').val();
					if (comNum == '' || comNum == null) {
						error += "Please select a component.\n";
					}
					if (component != '') {
						compText = $("#component option:selected").text();
						CASNumber = compText.substring(compText.indexOf('CAS: ') + 5);
						CASNumber = CASNumber.substring("", CASNumber.length - 1);
					} 
					//EOF Search by Component
					$("#component option").each(function() {
						if ($(this).val() == $('#component').val()) {
							$(this).css("display", "none");
							var text1 = 'Component *';
							$("#component option").filter(function() {
								//may want to use $.trim in here
								return $(this).text() == text1; 
							}).prop('selected', true);
						}
					});
				}
				
				if (selectedVal == "CAS") {
					//View CAS
					casNum = $('#CASNumber').val();
					if (casNum == '' || casNum == null) {
						error += "Please select a cas number.\n";
					}
					if (CASNumber != '') {
						CASNumber = $('#CASNumber').val();
						casText = $("#CASNumber option:selected").text();
						component = casText.substring(casText.indexOf('(') + 1);
						component = component.substring("", component.length - 1);
					}
					//EOF Search by CAS
					$("#CASNumber option").each(function() {
						if ($(this).val() == $('#CASNumber').val()) {
							$(this).css("display", "none");
							var text1 = 'CAS Number *';
							$("#CASNumber option").filter(function() {
								//may want to use $.trim in here
								return $(this).text() == text1; 
							}).prop('selected', true);
						}
					});
				}
				
				concentration = $('#concentration').val();
				if (concentration == '') {
					error += "Concentration is missing. ";
				}

				var units = $('#units_menu').val();
				other = $('#other').val();
				if (units == '' || units == "Units") {
					if (other == '') {
						error += "Units are missing. ";
					} else {
						units = other;
					}
				}
				

				if ($('#component_table').text().indexOf(CASNumber) != -1) {
					if (CASNumber != '')
						error = "Duplicate CAS Number: " + CASNumber + " has already been added.";
				}

				if (error != "") {
					alert(error);
				} 
				else {

					if (first_row == "not filled") {
						//if first_row not filled, insert into first row		
						first_row = "filled";
						component_counter = component_counter + 1;
						$("#first_row").html("<td>" + component + "</td><td>" + CASNumber + "</td><td>" + concentration + "</td><td>" + units + "</td><td><img src=\"../images/remove_button.gif\" width=\"27\" height=\"27\" alt=\"Remove Item\" class=\"removeicon\"></td>");
						$('textarea#components').text("Component# = " + component + " CASNumber = " + CASNumber + " Concentration = " + concentration + units);
						$('#mobile_component_table').html("<table class='m_component_table'>" +
															"<tr><th style='width:35%'>Component</th><td>"+component+"</td></tr>"+
															"<tr><th>CAS Number</th><td>"+ CASNumber +"</td></tr>"+
															"<tr><th>Concentration</th><td>"+ concentration +"</td></tr>"+
															"<tr><th>Units</th><td>"+ units +"</td></tr>"+
															"<tr><th>Remove</th><td><img src=\"../images/remove_button.gif\" width=\"27\" height=\"27\" alt=\"Remove Item\" class=\"removeicon2\"></td></tr>"+
														  "</table>");
					} else {
						//if first_row is already filled, just append	
						$('<tr><td>' + component + '</td><td>' + CASNumber + '</td><td>' + concentration + '</td><td>' + units + '</td><td><img src=\"../images/remove_button.gif\" width=\"27\" height=\"27\" alt=\"Remove Item\" class=\"removeicon\"></td></tr>').appendTo("#component_table_org > tbody:last").show('slow');
						component_counter = component_counter + 1;
						$('textarea#components').append(" Component# = " + component + " CASNumber = " + CASNumber + " Concentration = " + concentration + units);
						$("#component_table tr:odd").addClass("oddtablerow"); //make odd table rows grey reach time after new row is added or deleted
						$("<table class='m_component_table'>" +
							"<tr><th style='width:35%'>Component</th><td>"+component+"</td></tr>"+
							"<tr><th>CAS Number</th><td>"+ CASNumber +"</td></tr>"+
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
		});

	</script>
	
	<!--[if IE 7]>
	<script>
		$(function() {		
			$("#CASNumber").customSelect();
			$("#component").customSelect();
			$("#Refer").customSelect();
			$("#matrix").customSelect();
			$("#instrument_type").customSelect();
			$("#units_menu").customSelect();
		});	
	</script>
	<![endif]-->
	<script>
		$(function() {
						
			$("#instrument_type").change(function() {		
				if ($("#instrument_type").val() == "Other") {
					$("#other_instru_box").show();
				}else {
					$("#other_instru_box").hide();
				}
			});
			
			$("#units_menu").val("µg/mL");
		});	
	</script>
</asp:Content>

