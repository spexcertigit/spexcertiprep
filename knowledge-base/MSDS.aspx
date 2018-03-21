<%@ Page Title="SPEX CertiPrep - Knowledge Base - MSDS Download" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="MSDS.aspx.cs" Inherits="knowledge_base_msds" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <style>
    #Country_msdd.dd {
        width: 258px !important;
    }
    #Country_child.ddChild {
        width: 258px !important;
    }
	.yform { padding: 22px; }
    </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/">Home</a> > Knowledge Base > SDS Download</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="mainHeader">
                <h1><asp:PlaceHolder ID="Headline" runat="server" /></h1>
            </div>
            <div id="main">
                <div id="col1">
                    <div id="col1_content" class="clearfix">
						<div class="MSDS-logo">
							<asp:PlaceHolder ID="SideContent" runat="server" />
							<uc1:ShareThis ID="ShareThis1" runat="server" />
						</div>
                    </div>
                </div>
                <div id="col3">
                    <div id="col3_content" class="clearfix">
						<asp:PlaceHolder ID="BodyContent" runat="server" />
	                    <asp:MultiView ID="mvForm" runat="server" ActiveViewIndex="0">
                            <asp:View ID="vwForm" runat="server">
		                        <h2>SDS (MSDS) Download</h2>
      	                        <p>To download an SDS (MSDS) for a specific part please enter the part number in the box below.</p>
                                <asp:Panel ID="pnSearch" runat="server" CssClass="form_grey" DefaultButton="cmdSearch">
		  	                        <label for="part_number" class="label_block" style="#float: left;">Part Number: *</label>
                                    <asp:TextBox ID="part_number" style="width:250px; margin-left:10px" runat="server" />
                                    <asp:Button ID="cmdSearch" Text="SEARCH" runat="server" CssClass="submitbutton" onclick="cmdSearch_Click" style="clear:none;" />
		                        </asp:Panel>
                                <div id="msds_results">
                                    <!-- start msds table table -->
                                    <asp:GridView ID="msds_table" Visible="false" ClientIDMode="Static" DataSourceID="dataMSDS" runat="server" AutoGenerateColumns="false">
                                        <Columns>
                                            <asp:BoundField DataField="partno" HeaderText="Part #" />
                                            <asp:BoundField DataField="description" HeaderText="Description" />
                                            <asp:TemplateField HeaderText="SDS">
                                                <ItemTemplate>
                                                    <a href='/msds/<%#Eval("filename") %>'>View SDS (MSDS)</a>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <EmptyDataTemplate>
                                            <p style="text-align:center">SDS (MSDS) not found</p>
                                        </EmptyDataTemplate>
                                    </asp:GridView>
                                </div>

                                <p style="padding-top: 30px;">If you cannot find the SDS you  are looking for, send us a request by completing the information below.</p>
								<div id="msds_headerlabel" class="headerlabel" style="width: 91.2%;">
									<span class="label-left">
										<h2 class="title">SDS (MSDS) Request</h2>
									</span>
								</div>
                                <div class="msds_form">
                                    <div class="form_grey2 yform">
										<div class="row">
											<div class="col-md-12">
												<div class="form-group">
													<!-- <asp:Label ID="lblPartNumber" AssociatedControlID="PartNumber" runat="server">Part Number(s): *<br />(Please separate multiple part numbers with a comma)</asp:Label> -->
													<asp:TextBox ID="PartNumber"  runat="server" CssClass="form-control em-ph" Rows="3" TextMode="MultiLine" MaxLength="1000" placeholder="Part Number(s): (Please separate multiple part numbers with a comma) *" />
													<asp:RequiredFieldValidator ID="rfvPartNumber" ControlToValidate="PartNumber" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
												</div>
											</div>
										</div>

										<div class="subcolumns">
											<div class="row">
												<div class="col-md-6">
													<div class="form-group">
														<!-- <asp:Label ID="lblfirstname" AssociatedControlID="first_name" Text="First Name: *" runat="server" /> -->
														<asp:TextBox ID="first_name" runat="server" CssClass="form-control em-ph" MaxLength="100" placeholder="First Name: *"  />
														<asp:RequiredFieldValidator ID="rfvfirstname" ControlToValidate="first_name" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
													</div>
												</div>
												<div class="col-md-6">
													<div class="form-group">
														<!-- <asp:Label ID="lbllastname" AssociatedControlID="last_name" Text="Last Name: *" runat="server" /> -->
														<asp:TextBox ID="last_name" runat="server" CssClass="form-control em-ph" MaxLength="100" placeholder="Last Name: *" />
														<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="last_name" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
													</div>
												</div>
											</div>
										</div>

										<div class="form-group">
											<!-- <asp:Label ID="lblTitle" AssociatedControlID="txtTitle" Text="Title:" runat="server" /> -->
											<asp:TextBox ID="txtTitle" runat="server" CssClass="form-control em-ph" MaxLength="100"  placeholder="Title:"/>
										</div>

										<div class="form-group">
											<!-- <asp:Label ID="lblcompany_name" AssociatedControlID="company_name" Text="Company Name:" runat="server" /> -->
											<asp:TextBox ID="company_name" runat="server" Width="100%" MaxLength="100" placeholder="Company Name:" CssClass="form-control em-ph" />
										</div>

										<div class="form-group">
										   <!-- <asp:Label ID="lblcompany_address" AssociatedControlID="company_address" Text="Company Address: *" runat="server" /> -->
											<asp:TextBox ID="company_address" runat="server" MaxLength="100" placeholder="Company Address: *" CssClass="form-control em-ph"  />
											<asp:RequiredFieldValidator ID="rfvcompany_address" ControlToValidate="company_address" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
										</div>

										<div class="row">
											<div class="col-md-4">
												<div class="form-group">
													<!-- <asp:Label ID="lblcity" AssociatedControlID="city" Text="City: *" runat="server" /> -->
													<asp:TextBox ID="city" runat="server" MaxLength="100" placeholder="City: *" CssClass="form-control em-ph" />
													<asp:RequiredFieldValidator ID="rfvcity" ControlToValidate="city" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group">
													<!-- <asp:Label ID="lblstate_region" AssociatedControlID="state_region" Text="State/Province/Region: *" runat="server" /> -->
													<asp:TextBox ID="state_region" runat="server" MaxLength="50" placeholder="State/Province/Region: *" CssClass="form-control em-ph" />
													<asp:RequiredFieldValidator ID="rfvstate_region" ControlToValidate="state_region" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group">
													<!-- <asp:Label ID="lblzip" AssociatedControlID="zip" Text="ZIP/Postal Code: *" runat="server" /> -->
													<asp:TextBox ID="zip" runat="server" MaxLength="50" placeholder="ZIP/Postal Code: *" CssClass="form-control em-ph" />
													<asp:RequiredFieldValidator ID="rfvzip" ControlToValidate="zip" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
												</div>
											</div>
										</div>

										<div id="msds_country_wrap" class="row">
											<div class="col-md-6">
												<div class="form-group">
													<!-- <asp:Label ID="lblCountry" AssociatedControlID="Country" Text="Country: *" runat="server" /> -->
													<asp:DropDownList ID="Country" runat="server" DataSourceID="dataCountries" DataTextField="countryname" DataValueField="countryCode" AppendDataBoundItems="true" CssClass="form-control ddl-bg">
															<asp:ListItem Value="" Text="Select Country" disabled selected style='display:none;'/>
													</asp:DropDownList>
													<asp:RequiredFieldValidator ID="rfvCountry" ControlToValidate="Country" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
												</div>
											</div>
										</div>

										<div class="row">
											<div class="col-md-6">
												<div id="msds_fon" class="form-group">
													<!-- <asp:Label ID="lblphone_number" AssociatedControlID="phone_number" Text="Phone Number:" runat="server" /> -->
													<asp:TextBox ID="phone_number" runat="server" CssClass="form-control em-ph" MaxLength="50" placeholder="Phone Number:" />
												</div>
											</div>
											<div class="col-md-6">
												<div class="form-group">
													<!-- <asp:Label ID="lblemail" AssociatedControlID="email" Text="Email Address: *" runat="server" /> --> 
													<asp:TextBox ID="email" runat="server" MaxLength="255" placeholder="Email Address: *" CssClass="form-control em-ph" />
													<asp:RequiredFieldValidator ID="rfvemail" ControlToValidate="email" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
												</div>
											</div>
										</div>
										
										<div class="row">
											<div class="col-md-12">
												<div class="type-button text-right">
													<asp:Button ID="cmdSubmit" Text="SUBMIT" runat="server" CssClass="submitbutton pull-right" onclick="cmdSubmit_Click" ValidationGroup="vgNew" />
													<div class="pull-right" style="padding: 10px">* Required</div>
													<div class="clear"></div>
												</div>
											</div>
										</div>
									</div>
								</div>
                            </asp:View>
                            <asp:View ID="vwThank" runat="server">
								<h2>Thank You</h2>
								<p>Your request has been submitted. We shall contact you shortly.</p>
								<!-- Google Code for MSDS Request Conversion Page -->
								
							  
                            </asp:View>
                        </asp:MultiView>
                    </div>
                    <div id="ie_clearing"> &#160; </div>
                </div>
            </div>

    <asp:SqlDataSource ID='dataCountries' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="sp_GetCountryList" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataMSDS' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT msds.FileName AS filename, msds.PartNumber AS partno, prod.cpDescrip AS description FROM certiMSDS AS msds LEFT JOIN cp_roi_Prods AS prod ON prod.cpPart = msds.PartNumber WHERE msds.PartNumber = @Query" SelectCommandType="Text">
        <SelectParameters>
            <asp:ControlParameter ControlID="part_number" Name="Query" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script src="/js/jquery-ui.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$(".ddl-bg").change(function() {
				$(this).css("font-style", "normal");
				$(this).css("color", "#555");
			});
		});
	
		/* <![CDATA[ */
		var google_conversion_id = 1051567786;
		var google_conversion_language = "en";
		var google_conversion_format = "3";
		var google_conversion_color = "ffffff";
		var google_conversion_label = "3mwDCISnvQIQqs229QM";
		var google_conversion_value = 0;
		if (1) {
			google_conversion_value = 1;
		}
		/* ]]> */
		
	</script>
	<script type="text/javascript" src="http://www.googleadservices.com/pagead/conversion.js"></script>
	<noscript>
		<div style="display:inline;">
			<img height="1" width="1" style="border-style:none;" alt="" src="http://www.googleadservices.com/pagead/conversion/1051567786/?value=1&amp;label=3mwDCISnvQIQqs229QM&amp;guid=ON&amp;script=0"/>
		</div>
	</noscript>
</asp:Content>

