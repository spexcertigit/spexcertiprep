<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="optimize.aspx.cs" Inherits="ecs_parts"  Debug="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
	<link href="/css/easydropdown.css" rel="stylesheet" type="text/css" charset="utf-8" />
	<style>
		.type-text { width: 97%;}
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/">Home</a> > <a href="/knowledge-base/">Knowledge Base</a> > Optimize</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
	<div id="mainHeader">
        <h1>Optimize</h1>
    </div>
    <div id="main" class="optimize">
		<div class="row">
			<div class="col-lg-3 pr0">
				<div>
					<div class="CustomOS_logo">
						<asp:ListView ID="lvIssuesImg" runat="server" DataSourceID="dataIssues">
							<LayoutTemplate>
								<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
							</LayoutTemplate>
							<ItemTemplate>
								<img id="issue<%# Eval("id")%>" class="optimize_issue" src="/images/optimize/<%# Eval("thumb")%>" alt="Optimize" />
							</ItemTemplate>
							<EmptyDataTemplate>
									
							</EmptyDataTemplate>
						</asp:ListView> 
					</div>
				</div>
				<div class="clear"></div>
			</div>
			<div class="col-lg-9">
				<div id="col3_content" class="clearfix optimize_col3_content">
					<p>Optimize is a technical newsletter from SPEX CertiPrep. It is our goal with these newsletters to help you learn the optimal way.</p>
					<table class="tablesorter" align="center" style="width:100%;" id="optimize_table">
						<thead>
							<tr style="border:none">
								<td colspan="5">
									<span class="product-filter" id="optimize_product-filter">View/Download Optimize </span>
								</td>
							</tr>
							<tr class="orig-tr-header">
								<th scope="col"></th>
								<th scope="col">Date</th>
								<th scope="col">Title</th>
								<th scope="col">Pages</th>
								<th scope="col" >Authors</th>
							</tr>
						</thead>
						<tbody>
							<asp:ListView ID="lvIssues" runat="server" DataSourceID="dataIssues">
								<LayoutTemplate>
									<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
								</LayoutTemplate>
								<ItemTemplate>
									<tr class="orig-tr-products">
										<td style="text-align:center">
											<a target="_blank" href="/knowledge-base/files/<%# Eval("filepath")%>">
												<img src="/images/pdf-icon.png" alt="<%# Eval("title")%>" title="<%# Eval("title")%>"/>
											</a>
										</td>
										<td><%# Eval("issuedate")%></td>
										<td><a target="_blank" href="/knowledge-base/files/<%# Eval("filepath")%>"><%# Eval("title")%></a></td>
										<td><%# Eval("pages")%></td>
										<td><%# Eval("authors")%></td>
									</tr>
								</ItemTemplate>
								<EmptyDataTemplate>
									<div style="font-size:1.2em">
									<p>No Results</p>
									</div>
								</EmptyDataTemplate>
							</asp:ListView> 
						</tbody>
					</table>
					<div class="headerlabel">
						<div class="title">Request a Printed Copy</div>
					</div>
					<asp:Panel ID="downloadform" ClientIDMode="Static" CssClass="yform" DefaultButton="cmdNew" runat="server">
						<div class="row">
							<div class="col-md-12">
								<span class="head-text">To receive a printed copy of Optimize, please complete the form below and click on Submit.</span>
								<br>
								<span class="req-label">* Required Fields</span>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<asp:TextBox ID="fullname" placeholder="Name *" runat="server" CssClass="form-control em-ph" MaxLength="15" TabIndex="1" />
									<asp:RequiredFieldValidator ID="rfvfullname" ControlToValidate="fullname" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
								</div>
								<div class="form-group">
									<asp:TextBox ID="email_check" placeholder="Email Address * " runat="server" ClientIDMode="Static" CssClass="form-control em-ph" MaxLength="50" TabIndex="3" />	
									<asp:RequiredFieldValidator ID="rfvemail_check" ControlToValidate="email_check" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
									<asp:RegularExpressionValidator ID="revemail_check" ControlToValidate="email_check" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Please enter a valid email address." ValidationGroup="vgNew" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
								</div>
								<div class="form-group">
									<asp:TextBox ID="city" placeholder="City *" runat="server" CssClass="form-control em-ph" MaxLength="15" TabIndex="5" />
									<asp:RequiredFieldValidator ID="rfvcity" ControlToValidate="city" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
								</div>
								<div class="form-group">
									<asp:DropDownList ID="Country" runat="server" CssClass="form-control ddl-bg" AppendDataBoundItems="true" DataSourceID="dataCountries" DataTextField="countryname" DataValueField="countryCode" style="width:100%;" TabIndex="7">
										<asp:ListItem Value="" Text="Select Country *" selected />
									</asp:DropDownList>
									<asp:RequiredFieldValidator ID="rfvCountry" ControlToValidate="Country" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<asp:TextBox ID="Company" placeholder="Company Name *" runat="server" CssClass="form-control em-ph" MaxLength="30" TabIndex="2" />
									<asp:RequiredFieldValidator ID="rfvCompany" ControlToValidate="Company" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
								</div>
								<div class="form-group">
									<asp:TextBox ID="address" placeholder="Address *" runat="server" CssClass="form-control em-ph" MaxLength="30" TabIndex="4" />
									<asp:RequiredFieldValidator ID="rfvAddress" ControlToValidate="address" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
								</div>
								<div class="form-group">
									<asp:TextBox ID="state_region" placeholder="State/Province/Region *" runat="server" CssClass="form-control em-ph"  MaxLength="30" TabIndex="6" />
									<asp:RequiredFieldValidator ID="rfvstate_region" ControlToValidate="state_region" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
								</div>
								<div class="form-group">
									<asp:TextBox ID="zip" placeholder="Zip Code *" runat="server" CssClass="form-control em-ph" MaxLength="30" TabIndex="8" />
									<asp:RequiredFieldValidator ID="rfvzip" ControlToValidate="zip" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
								</div>
							</div>
							<div class="col-md-12">
								<div class="form-group text-right">
									<asp:Button ID="cmdNew" Text="submit" runat="server" CssClass="subBtn" onclick="cmdNew_Click" ValidationGroup="vgNew" TabIndex="9" />
								</div>
							</div>
						</div>
						<div class="clearboth"></div>
					</asp:Panel>
				</div>
			</div>
		</div>
		<div class="clearboth"></div>
    </div>
	<asp:SqlDataSource ID='dataIssues' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT * FROM cp_optimize_issue ORDER BY id DESC" SelectCommandType="Text">
    </asp:SqlDataSource>
	<asp:SqlDataSource ID='dataCountries' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="sp_GetCountryList" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script src="/js/jquery-ui.js" type="text/javascript"></script>
	<script src="/js/jquery.tablesorter.min.js" type="text/javascript"></script>
	<script>
		$(document).ready(function() {
			$(".tablesorter tr:odd").addClass("odd");
			$(".ddl-bg").change(function() {
				$(this).css("font-style", "normal");
				$(this).css("color", "#555");
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
			
			setInterval(changeImg, 5000);
		});
	</script>
</asp:Content>

