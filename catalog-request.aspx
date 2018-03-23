<%@ Page Title="NEW SPEX CertiPrep Product Catalog | SPEX CertiPrep" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="catalog-request.cs" Inherits="knowledge_base_Presentations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
	
	<style> #breadcrumb { display:none }</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="main" class="catalog-request">
				<div class="row">
					<div class="col-lg-12">
						<h1>COMING SOON, the NEW SPEX CertiPrep Product Catalog!</h1>
						<h2>Certified Materials for Every Application</h2>
						<p>We have updated our catalog to include all the information you need to get the exact CRMs for your laboratory needs. Custom CRMs are also available. In this flip style catalog you will find the following products <strong><em>AND SO MUCH MORE!</em></strong></p>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-2"></div>
					<div class="col-lg-4">
						<span class="list-title">INORGANIC CRMs</span>
						<br />
						<ul>
							<li>Assurance and Claritas Grade CRMs</li>
							<li>Speciation Standards</li>
							<li>NEW Heavy Metals and Minerals Testing Kits</li>
							<li>Ion Chromatography Standards</li>
							<li>Carbon Black Reagents</li>
							<li>USP and ICH Standards</li>
						</ul>
					</div>
					<div class="col-lg-4">
						<span class="list-title organic">ORGANIC CRMs</span>
						<br />
						<ul>
							<li>Single Component Standards</li>
							<li>Volatiles</li>
							<li>Semivolatiles</li>
							<li>Pesticides, PCBs and Herbicides</li>
							<li>Cannabis Standards</li>
							<li>Consumer Safety Standards</li>
						</ul>
					</div>
					<div class="col-lg-2"></div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<p>To receive your download or hard copy catalog, please fill out the form below. Downloads and hard copies will be available in April. If you have any questions, please feel free to contact us at <a href="mailto:crmmarketing@spex.com" style="text-decoration:none;"><span class="list-title">CRMMarketing@spex.com</a></a> or call us at <span class="list-title">1.800.LAB.SPEX</span> or <span class="list-title">732.549.7144.</span></p>
					</div>
				</div>
				<div class="row purple-bg">
					<div class="col-lg-12">
						<p>To receive a download or hard copy of our NEW product catalog, please provide us with the following information:</p>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-6">
						<div class="form-group">
							<asp:TextBox ID="FName" placeholder="First Name*" runat="server" CssClass="form-control surveyTxtbox" />
							<asp:RequiredFieldValidator ID="rfvFName" ControlToValidate="FName" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true"  Text="Please enter your first name." ValidationGroup="vgRNew" />
						</div>
					</div>
					<div class="col-lg-6">
						<div class="form-group">
							<asp:TextBox ID="LName" placeholder="Last Name*" runat="server" CssClass="form-control surveyTxtbox" />
							<asp:RequiredFieldValidator ID="rfvLName" ControlToValidate="LName" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true"  Text="Please enter your last name." ValidationGroup="vgRNew" />
						</div>
					</div>
					<div class="col-lg-12">
						<div class="form-group">
							<asp:TextBox ID="RCompany" placeholder="Company Name*" runat="server" CssClass="form-control surveyTxtbox" />
							<asp:RequiredFieldValidator ID="rfvRCompany" ControlToValidate="RCompany" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server"   SetFocusOnError="true" Text="Please enter your company name" ValidationGroup="vgRNew" />
						</div>
					</div>
					<div class="col-lg-12">
						<div class="form-group">
							<asp:TextBox ID="Address1" placeholder="Address 1" runat="server" CssClass="form-control surveyTxtbox" />
							<asp:RequiredFieldValidator ID="rfvAddress1" ControlToValidate="Address1" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server"   SetFocusOnError="true" Text="Please enter your address" ValidationGroup="vgRNew" />
						</div>
					</div>
					<div class="col-lg-12">
						<div class="form-group">
							<asp:TextBox ID="Address2" placeholder="Address 2" runat="server" CssClass="form-control surveyTxtbox" />
						</div>
					</div>
					<div class="col-lg-6">
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<asp:TextBox ID="City" placeholder="City" runat="server" CssClass="form-control surveyTxtbox" />
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<asp:DropDownList ID="State" runat="server" CssClass="form-control ddl-bg surveyTxtbox" AppendDataBoundItems="true" DataSourceID="dataStates" DataTextField="state" DataValueField="state">
										<asp:ListItem Value="0" Text="State" selected />
									</asp:DropDownList>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-6">
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<asp:TextBox ID="Zip" runat="server" placeholder="Zip/Postal Code" CssClass="form-control surveyTxtbox" />
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<asp:DropDownList ID="Country" runat="server" CssClass="form-control ddl-bg surveyTxtbox" AppendDataBoundItems="true" DataSourceID="dataCountries" DataTextField="countryname" DataValueField="countryCode">
										<asp:ListItem Value="0" Text="Country" selected />
									</asp:DropDownList>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-6">
						<div class="form-group">
							<asp:TextBox ID="REmail" placeholder="Email Address*" runat="server" CssClass="form-control surveyTxtbox" />
							<asp:RequiredFieldValidator ID="rfvREmail" ControlToValidate="REmail" CssClass="formerror" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true"  Text="Please enter your email address" ValidationGroup="vgRNew" />
						</div>
					</div>
					<div class="col-lg-6">
						<div class="form-group">
							<asp:TextBox ID="Phone" placeholder="Phone Number" runat="server" CssClass="form-control  surveyTxtbox" />
						</div>
					</div>
					<div class="col-lg-12">
						<div class="row">
							<div class="col-md-3">
								<div class="form-group">
									<asp:CheckBoxList  ID="rblCopy" runat="server" CssClass="overSizeQue" RepeatDirection="Horizontal">
										<asp:ListItem Text="<span><span></span></span>Download" Value="Download" />
										<asp:ListItem Text="<span><span></span></span>Hard Copy" Value="Hard Copy" />
									</asp:CheckBoxList>
								</div>
							</div>
							<div class="col-md-5">
								<div class="form-group input-group">
									<span class="input-group-addon">Quantity of Hard Copies You Want to Request</span>
									<asp:DropDownList ID="qty" runat="server" CssClass="form-control ddl-bg surveyTxtbox" AppendDataBoundItems="true">
										<asp:ListItem Value="1" Text="1" />
										<asp:ListItem Value="2" Text="2" />
										<asp:ListItem Value="3" Text="3" />
										<asp:ListItem Value="4" Text="4" />
										<asp:ListItem Value="5" Text="5" />
										<asp:ListItem Value="6" Text="6" />
										<asp:ListItem Value="7" Text="7" />
										<asp:ListItem Value="8" Text="8"  />
										<asp:ListItem Value="9" Text="9" />
									</asp:DropDownList>
								</div>
								<p>NOTE: If you require more than 10 hard copies, please contact CRMMarketing@spex.com</p>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<asp:Button ID="cmdSubmit" Text="SUBMIT" runat="server" AutoPostBack="false" CssClass="btn btn-warning btn-orange" onclick="cmdSubmit_Click" ValidationGroup="vgRNew" />
								</div>
							</div>
						</div>
						<br/><br/>
					</div>
				</div>
				<asp:SqlDataSource ID='dataCountries' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>" SelectCommand="sp_GetCountryList" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
				<asp:SqlDataSource ID='dataStates' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>" SelectCommand="SELECT * FROM certiCityState" SelectCommandType="Text"></asp:SqlDataSource>
                
				<div style="clear:both"></div>
            </div>
	<asp:SqlDataSource ID='dataProducts' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
	SelectCommand="SELECT cfFamily FROM cp_roi_Families ORDER BY cfID" SelectCommandType="Text">
	</asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script>
		$(document).ready(function(){
			$(".ratestar").mouseover(function() {
				var rate = $(this).data("rate");
				$(".ratestar").each(function(){
					if ($(this).data("rate") <= rate) {
						$(this).css("background-position", "-3px -1px");
					}
				});
			});
			
			$(".ratestar").mouseout(function() {
				$(".ratestar").removeAttr("style");
			});
			
			$(".ratestar").click(function() {
				if ($(this).hasClass("ratestar-select")) {
					$(".ratestar").each(function() {
						$(this).removeClass("ratestar-select");
					});
					rate = $(this).data("rate");
					rateScoring(rate);
				}else {
					var rate = $(this).data("rate");
					rateScoring(rate);
				}
			});
			
			function rateScoring(rate) {
				$(".ratestar").each(function() {
					$(this).removeClass("ratestar-select");
					if ($(this).data("rate") <= rate) {
						$(this).addClass("ratestar-select");
					}
				});
				$("#RateScore").val(rate);
			}
			
			var maxWords = 300;
			$('textarea').keypress(function() {
				var $this, wordcount, temp;
				$this = $(this);
				wordcount = $this.val().split(/\b[\s,\.-:;]*/).length;
				if (wordcount > maxWords) {
					return false;
				} else {
					temp = $("#" + $(this).attr("id") + "-limit").text(maxWords - wordcount);	
					return temp;					
				}
				if (temp < (maxWords - wordcount)) { 
					temp = $("#" + $(this).attr("id") + "-limit").text(maxWords + wordcount);
					return temp;
				}
				
			});

			$('textarea').change(function() {
				var words = $(this).val().split(/\b[\s,\.-:;]*/);
				if (words.length > maxWords) {
					//words.splice(maxWords);
					//$(this).val(words.join(""));
					//alert("You've reached the maximum allowed words. Extra words removed.");
					
				}
			});
		});
	</script>
</asp:Content>


