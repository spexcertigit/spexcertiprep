<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="SPEX-Speaker.aspx.cs" Inherits="knowledge_base_SPEX_Speaker" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
	<style>
		input[type=text] { box-sizing:border-box; width: 94%;}
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server">&nbsp;&nbsp;&nbsp;</asp:Content>
<asp:Content ID="ContentHeader" ContentPlaceHolderID="cpPageBanner" Runat="Server">
	<div id="banner-div" class="speaker">
		<div class="banner-label-wrapper" id="spex-speaker_banner-label-wrapper">
			<img class="banner-image-right" id="spex-speaker_banner-image-right" src="/images/spex-speaker-banner.png">
			<h1 id="speaker-header">SPEX Speaker</h1>
			<p class="speaker-intro" id="spex-speaker_speaker-intro">Speaking Spectroscopy Since 1956</p>
			<a class="latest-link" href="<%=getLatestIssue()%>" target="_blank">Click here to download the latest issue >></a>
		</div>
		<div class="banner-shadow"></div>
	</div>	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            
			<div id="main">
				<div class="row">
					<div class="col-lg-3 pr0">
						<div>
							<h2 id="updates">View/Download SPEX Speaker</h2>
							<div class="organic-side">
								<ul class="flyers">
									<asp:ListView ID="lvIssuesImg" runat="server" DataSourceID="dataIssues">
										<LayoutTemplate>
											<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
										</LayoutTemplate>
										<ItemTemplate>
											<li class="pdf_dl"><a href="<%# Eval("filePDF")%>" target="_blank">SPEX Speaker <%# Eval("fileTitle")%></a></li>
										</ItemTemplate>
										<EmptyDataTemplate>
												
										</EmptyDataTemplate>
									</asp:ListView> 
								</ul>
							</div>
						</div>
						<br><br>
						<a class="speakerRequestLink" href="#requestFormBox">Request a Physical Copy of our latest issue >></a>
					</div>
					<div class="col-lg-9">
						<div id="col3_content" class="clearfix">
							<%=get2Issues() %>
							<div id="newsletters">
								<div style="display:none">
									<div id="requestFormBox">
										<div class="headerlabel">
											<div class="title">Request a Physical Copy</div>       
										</div>  
										<asp:Panel ID="downloadform" ClientIDMode="Static" CssClass="yform" DefaultButton="cmdSubmit" runat="server">
											<p>By requesting a copy of our new issue, you are now eligible to recieve all our future SPEX Speaker issues.</p>
											<span class="req-label"><span class="req">*</span> Required Fields</span>
											<div class="leftCol">
												<div class="type-text">
													<span class="req-left">*</span>
													<asp:TextBox ID="fullname" placeholder="Name" runat="server" CssClass="input-260" MaxLength="30" TabIndex="1" />
												</div>
												<asp:RequiredFieldValidator ID="rfvfullname" ControlToValidate="fullname" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
												<div class="type-text">
													<span class="req-left">*</span>
													<asp:TextBox ID="email_check" placeholder="Email Address" runat="server" ClientIDMode="Static" CssClass="input-260" MaxLength="50" TabIndex="3" />	
												</div>
												<asp:RequiredFieldValidator ID="rfvemail_check" ControlToValidate="email_check" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
												<asp:RegularExpressionValidator ID="revemail_check" ControlToValidate="email_check" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Please enter a valid email address." ValidationGroup="vgNew" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
												<div class="type-text">
													<span class="req-left">*</span>
													<asp:TextBox ID="city" placeholder="City" runat="server" CssClass="input-260" MaxLength="15" TabIndex="5" />
												</div>
												<asp:RequiredFieldValidator ID="rfvcity" ControlToValidate="city" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
												<div class="type-select req" style="width:100%;">
													<span class="req-left">*</span>
													<div class="selectbg" style="width:94%;">
														<div class="IEmagic">
															<asp:DropDownList ID="Country" runat="server" CssClass="input-273" AppendDataBoundItems="true" DataSourceID="dataCountries" DataTextField="countryname" DataValueField="countryCode" style="width:100%;" TabIndex="7">
																<asp:ListItem Value="" Text="Select Country" selected />
															</asp:DropDownList>
														</div>
													</div>
												</div>
												<asp:RequiredFieldValidator ID="rfvCountry" ControlToValidate="Country" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
											</div>
											<div class="rightCol">
												<div class="type-text">
													<span class="req-left">*</span>
													<asp:TextBox ID="Company" placeholder="Company Name" runat="server" CssClass="input-260" MaxLength="30" TabIndex="2" />
												</div>
												<asp:RequiredFieldValidator ID="rfvCompany" ControlToValidate="Company" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
												<div class="type-text">
													<span class="req-left">*</span>
													<asp:TextBox ID="address" placeholder="Address" runat="server" CssClass="input-260" MaxLength="30" TabIndex="4" />
												</div>
												<asp:RequiredFieldValidator ID="rfvAddress" ControlToValidate="address" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
												<div class="type-text">
													<span class="req-left">*</span>
													<asp:TextBox ID="state_region" placeholder="State/Province/Region" runat="server" CssClass="input-260" MaxLength="30" TabIndex="6" />
												</div>
												<asp:RequiredFieldValidator ID="rfvstate_region" ControlToValidate="state_region" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
												<div class="type-text">
													<span class="req-left">*</span>
													<asp:TextBox ID="zip" placeholder="Zip Code" runat="server" CssClass="input-260" MaxLength="30" TabIndex="8" />
												</div>
												<asp:RequiredFieldValidator ID="rfvzip" ControlToValidate="zip" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
											</div>
											<div class="fullCol">
											</div>
											<asp:Button ID="cmdSubmit" Text="submit" runat="server" CssClass="subBtn" onclick="cmdSubmit_Click" ValidationGroup="vgNew" TabIndex="9" />
											<div class="clearboth"></div>
										</asp:Panel>
									</div>
								</div>
							</div>						
						</div>
						<div id="ie_clearing"> &nbsp; </div>
					</div>
					<div style="margin-bottom:40px;">
						<h2 class="speaker_title" style="margin-bottom: 20px">SPEX Speaker Archive</h2>
						<p>Behold The SPEX Speaker -  the complete run of the unique trade journal that between 1956 and 1983, published articles, about a wide variety of spectrographic methods and techniques, while showcasing SPEX products. Art and Harriet Mitteldorf, who founded SPEX Industries, Inc. in 1954, started by selling graphite electrodes and spectrographic plates and film for arc/spark spectroscopy. They quickly developed their own analytical   standards and sample preparation equipment, and those two traditions and   product lines are proudly continued today by SPEX CertiPrep®, Inc., and SPEX® SamplePrep LLC.</p>                                  
						<p>Visit the <a href="http://www.spexspeaker.com">SPEX Speaker Archive</a> and take a trip through the history of spectroscopy.</p>
					</div>
				
				</div>
            </div>
			<asp:SqlDataSource ID='dataIssues' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
				SelectCommand="SELECT * FROM cp_speaker ORDER BY id DESC" SelectCommandType="Text">
			</asp:SqlDataSource>
			<asp:SqlDataSource ID='dataCountries' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
				SelectCommand="sp_GetCountryList" SelectCommandType="StoredProcedure">
			</asp:SqlDataSource>

</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script src="/js/jquery-ui.js" type="text/javascript"></script>
	<script>
		$(document).ready(function() {
			$("form").submit(function(){
			//$("#cmdSubmit").click(function() {
				//alert("submited");
				var fullName = $("#fullname").val();
				var firstName = fullName.split(' ').slice(0, -1).join(' ');
				var lastName = fullName.split(' ').slice(-1).join(' ');
				
				var dataValue = "ca=28af1f9c-a310-47f4-8f27-7ffdf28c1b46&list=1626433698&source=EFD&email=" + $("#email_check").val() + "&first_name=" + firstName + "&last_name=" + lastName + "&address_country=" + $("#Country").val() + "&address_street=" + $("#address").val() + "&address_city=" + $("#city").val() + "&address_state=" + $("#state_region").val() + "&address_postal_code=" + $("#zip").val() + "&company=" + $("#Company").val();
				
				$.ajax({
					url: 'https://visitor2.constantcontact.com/api/signup',
					type: "POST",
					data: dataValue,
					contentType: "application/x-www-form-urlencoded; charset=UTF-8",
					success: function (data) {
						$('#result').html(data.d);
					}
				});
			});
			
			var imgs = $('.CustomOS_logo img');
			var numberOfimgs = imgs.length;
			var currentImg = numberOfimgs;
			var last = numberOfimgs - (numberOfimgs - 1);
			
			console.log("num:" + numberOfimgs +" last:" + last);
			
			function changeImg() {
				var currImg = $("#issue" + currentImg);

				showHide(currImg);
								
				if (currentImg == last) {
					imgs.fadeIn("slow");
					currentImg = numberOfimgs;
				}else {
					currentImg--;
				}
				
				
				console.log("curr:" + currentImg);
			}
			
			function showHide(currImg) {
				if (currImg.css("display") == "none") {
					currImg.fadeIn("slow");
				}else {
					currImg.fadeOut("slow");
				}
			}
			
			//setInterval(changeImg, 5000);
			
			$("a.speakerRequestLink").fancybox();
			$("#form1").append($("#floatlayer"));
			$("#form1").append($("#fancybox-tmp"));
			$("#form1").append($("#fancybox-loading"));
			$("#form1").append($("#fancybox-overlay"));
			$("#form1").append($("#fancybox-wrap"));
		});
	</script>
</asp:Content>


