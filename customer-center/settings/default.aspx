<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="hipure_inorganic" Debug="True"%>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <style type="text/css">
        a.aspNetDisabled { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        a.aspNetDisabled:hover { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        #ProductListPagerSimple span,
        #ProductListPagerSimple2 span { font-weight:bold; }
		.buybutton { border-right: 1px solid #727272; }
		#breadcrumb { padding:0;}
    </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
	<!--CAS Pop Up-->
	<div id="cas-container-opacity">
		<div id="cas-container">
			<div class="close-x"></div>
			<div class="CAStable"></div>
		</div>
	</div>
	<!--EOF CAS Pop Up-->
	<div id="main" style="margin-bottom:2em">
		<% if (Request.QueryString["success"] != null) {%>
				<div class="success-box">
                    <div class="alert alert-success alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Success!!</strong> All changes to the account details has been completed!!
                    </div>
                </div>
		<% } %>
		<h1 class="cc">Customer Center</h1>
        <div class="subcolumns">			
			<div class="c30l">
				<div>
					<div class="customer-center">
						<ul>
							<li class="header">My Account</li>
							<li><a href="/customer-center/">My Orders <span class="coming-soon">- Coming Soon!</span></a></li>
							<li><a class="selected">Account Details</a></li>
							<li><a href="/customer-center/loyal-customer-rewards/">My SPoints <span class="coming-soon">- Coming Soon!</span></a></li>
						</ul>
					</div>
				</div>	 
			</div>	
			<div class="c66r">
				<div>
					<div id="cc-p">		
						<h2 class="ccClient">Hello, <%=DisplayName%>!</h2>
						<p>My Account allows you to update your account information and edit your password. Make any necessay changes to the information below and submit your changes when complete.</p>
						<p>Contact <a href="mailto:CRMMarketing@spex.com">CRMMarketing@spex.com</a> with any questions or call us at 1.732.549.7144.</p>
					</div> 											
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-lg-12">
				<div id="cc-p">		
					<h2 class="half-header">Account Details</h2>
					<div class="row">
						<div class="col-lg-12">
							<div class="spexAccNum">
								SPEX Account Number:&nbsp;&nbsp;&nbsp;<strong><asp:Literal ID="ltrAccNum" runat="server" /></strong>
							</div>
						</div>
						<div class="col-lg-6 hidden">
							<div class="form-group">
								<label for="txtFName">First Name</label>
								<asp:TextBox ID="txtFName" runat="server" CssClass="form-control" TabIndex="0" Width="100%"></asp:TextBox>
								<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtFName" ValidationGroup="InputCheck" ErrorMessage="This field is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
							</div>
							<div class="section-header">Default Shipping Address</div>
							<div class="form-group">
								<label for="txtShipCompany">Company Name</label>
								<asp:TextBox ID="txtShipCompany" runat="server" CssClass="form-control" TabIndex="2" Width="100%"></asp:TextBox>
							</div>
							<div class="form-group">
								<label for="txtShipAdd">Address</label>
								<asp:TextBox ID="txtShipAdd1" runat="server" CssClass="form-control ad-address" placeholder="Street1" TabIndex="3" Width="100%"></asp:TextBox>
								<asp:TextBox ID="txtShipAdd2" runat="server" CssClass="form-control ad-address" placeholder="Street2" TabIndex="3" Width="100%"></asp:TextBox>
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="txtShipCity">City</label>
										<asp:TextBox ID="txtShipCity" runat="server" CssClass="form-control" TabIndex="4" Width="100%"></asp:TextBox>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="txtShipState">State</label>
										<asp:TextBox ID="txtShipState" runat="server" CssClass="form-control" TabIndex="5" Width="100%"></asp:TextBox>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="txtShipZip">Zip/Postal Code</label>
										<asp:TextBox ID="txtShipZip" runat="server" CssClass="form-control" TabIndex="6" Width="100%"></asp:TextBox>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="txtShipState">Country</label>
										<asp:DropDownList id="ddlShipCountry" CssClass="form-control ddl-bg" TabIndex="7" runat="server" DataSourceID="dataCountries" DataTextField="Country" DataValueField="iso2" AppendDataBoundItems="true">
											<asp:ListItem Value="" Text="Select Country" disabled selected/>
										</asp:DropDownList>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label for="txtShipPhone">Phone Number</label>
								<asp:TextBox ID="txtShipPhone" runat="server" CssClass="form-control" TabIndex="8" Width="100%"></asp:TextBox>
							</div>
						</div>
						<div class="col-lg-6 hidden">
							<div class="form-group">
								<label for="txtLName">Last Name</label>
								<asp:TextBox ID="txtLName" runat="server" CssClass="form-control" TabIndex="9" Width="100%"></asp:TextBox>
								<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtLName" ValidationGroup="InputCheck" ErrorMessage="This field is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
							</div>
							<div class="section-header">Default Shipping Address</div>
							<div class="form-group">
								<label for="txtBillCompany">Company Name</label>
								<asp:TextBox ID="txtBillCompany" runat="server" CssClass="form-control" TabIndex="10" Width="100%"></asp:TextBox>
							</div>
							<div class="form-group">
								<label for="txtBillAdd">Address</label>
								<asp:TextBox ID="txtBillAdd1" runat="server" CssClass="form-control ad-address" placeholder="Street1" TabIndex="11" Width="100%"></asp:TextBox>
								<asp:TextBox ID="txtBillAdd2" runat="server" CssClass="form-control ad-address" placeholder="Street2" TabIndex="11" Width="100%"></asp:TextBox>
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="txtBillCity">City</label>
										<asp:TextBox ID="txtBillCity" runat="server" CssClass="form-control" TabIndex="12" Width="100%"></asp:TextBox>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="txtBillState">State</label>
										<asp:TextBox ID="txtBillState" runat="server" CssClass="form-control" TabIndex="13" Width="100%"></asp:TextBox>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="txtBillZip">Zip/Postal Code</label>
										<asp:TextBox ID="txtBillZip" runat="server" CssClass="form-control" TabIndex="14" Width="100%"></asp:TextBox>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="txtShipState">Country</label>
										<asp:DropDownList id="ddlBillCountry" CssClass="form-control ddl-bg" TabIndex="15" runat="server" DataSourceID="dataCountries" DataTextField="Country" DataValueField="iso2" AppendDataBoundItems="true">
											<asp:ListItem Value="" Text="Select Country" disabled selected/>
										</asp:DropDownList>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label for="txtBillPhone">Phone Number</label>
								<asp:TextBox ID="txtBillPhone" runat="server" CssClass="form-control" TabIndex="16" Width="100%"></asp:TextBox>
							</div>
							<div class="type-button">
								<asp:Button ID="cmdSubmit" Text="SUBMIT CHANGES" runat="server" CssClass="btn btn-warning btn-lg submitBtn pull-right" TabIndex="17" onclick="cmdSubmit_Click" ValidationGroup="InputCheck" />
							</div>
						</div>
						<div class="clear"></div>
					</div>
						
					<div class="row">
						<div class="col-lg-12">
							<div class="section-header">Change Password</div>
						</div>
						<div class="col-lg-6">
							<div class="form-group">
								<label for="txtPass">Password</label>
								<asp:TextBox ID="txtPass" runat="server" CssClass="form-control" TabIndex="18" Width="100%" TextMode="Password" MaxLength="20" autocomplete="off"></asp:TextBox>
								<div id="passRes"></div>
							</div>
						</div>
						<div class="col-lg-6">
							<div class="form-group">
								<label for="txtPass">&nbsp;</label>
								<asp:TextBox ID="txtBlank" runat="server" CssClass="form-control" TabIndex="19" Width="100%" TextMode="Password" MaxLength="20" style="visibility:hidden;" ></asp:TextBox>
							</div>
						</div>
						<div class="col-lg-6">
							<div class="form-group ">
								<label for="txtNPass">New Password</label>
								<asp:TextBox ID="txtNPass" runat="server" CssClass="form-control" TabIndex="20" Width="100%" TextMode="Password" MaxLength="20" autocomplete="off"></asp:TextBox>
								<div class="errorMatch"></div>
							</div>
						</div>
							
						<div class="col-lg-6">
							<div class="form-group ">
								<label for="txtCPass">Confirm Password</label>
								<asp:TextBox ID="txtCPass" runat="server" CssClass="form-control" TabIndex="21" Width="100%" TextMode="Password" MaxLength="20" autocomplete="off"></asp:TextBox>
							</div>
							<div class="type-button">
								<asp:Button ID="cmdUpdate" Text="PASSWORD UPDATE" runat="server" CssClass="btn btn-warning btn-lg submitBtn pull-right" TabIndex="13" onclick="cmdUpdate_Click" style="padding:10px 40px; " />
							</div>
							<div class="clear"></div>
						</div>
					</div>
				</div> 											
    		</div>
    	</div>	
		<div class="clear"></div>
	</div>
		<asp:SqlDataSource ID='dataCountries' runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" ProviderName="<%$ ConnectionStrings:ApplicationServices.ProviderName %>"
			SelectCommand="SELECT * FROM spexCountryList ORDER BY Country" SelectCommandType="Text">
		</asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script src="/js/jquery-ui.js" type="text/javascript"></script>
	<script src="/js/jquery.tablesorter.min.js" type="text/javascript"></script>	
    <script type="text/javascript">
		var errors = true;
		
        $(document).ready(function () {
			$(".close").click(function() {
				$(this).parent().remove();
			});

			$(".ddl-bg").change(function() {
				$(this).css("font-style", "normal");
				$(this).css("color", "#555");
			});
			$("#txtPass").change(function() {
				var pwd = $(this).val();
				if (pwd != "") {
				$.ajax({
					url: 'default.aspx/checkPassword',
					type: "POST",
					data: JSON.stringify({ password: pwd, webCusID: "<%=webCusID%>" }),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						if (data.d == true) {
							$("#txtPass").removeClass("incorrect");
							$("#txtPass").addClass("correct");
							$("#passRes").removeClass("incorrect");
							$("#passRes").html("&#10004; Correct Password!").addClass("correct").show();
							errors = false;
						}else {
							$("#txtPass").removeClass("correct");
							$("#txtPass").addClass("incorrect");
							$("#passRes").removeClass("correct");
							$("#passRes").html("&#10006; Incorrect Password!").addClass("incorrect").show();
							errors = true;
						}
					}
				});
				}else {
					$("#passRes").hide();
					$("#txtPass").removeClass("incorrect").removeClass("correct");
					errors = false;
				}
			});
			
			$("#txtNPass").keyup(function() {
				var npass = $(this).val();
				var cpass = $("#txtCPass").val();
				if (cpass != "") {
					comparePass(npass, cpass);
				}
			});
			
			$("#txtCPass").keyup(function() {
				var cpass = $(this).val();
				var npass = $("#txtNPass").val();
				comparePass(npass, cpass);
			});
			
			$("#cmdUpdate").click(function(e) {
				if (errors == true) {
					e.preventDefault();
					console.log("Errors detected.");
				}
			});
		});
		function comparePass(npass, cpass) {
			var pass = $("#txtPass").val();
			if (pass != "") {
				$("#txtNPass").removeClass("incorrect").removeClass("correct");
				$("#txtCPass").removeClass("incorrect").removeClass("correct");
				$(".errorMatch").hide();
				if (npass == cpass) {
					$("#txtNPass").removeClass("incorrect").addClass("correct");
					$("#txtCPass").removeClass("incorrect").addClass("correct");
					$(".errorMatch").removeClass("incorrect").addClass("correct");
					$(".errorMatch").html("&#10004; Password Match!").addClass("correct").show();
					errors = false;
				}else {
					$("#txtNPass").removeClass("correct").addClass("incorrect");
					$("#txtCPass").removeClass("correct").addClass("incorrect");
					$(".errorMatch").removeClass("correct").addClass("incorrect");
					$(".errorMatch").html("&#10006; Password Mismatch!").addClass("incorrect").show();
					errors = true;
				}
			}else {
				$("#txtNPass").removeClass("correct").addClass("incorrect");
				$("#txtCPass").removeClass("correct").addClass("incorrect");
				$(".errorMatch").html("&#10006; Please input current password!").addClass("incorrect").show();
				$("#txtPass").focus();
				errors = true;
			}
		}
    </script>
	
</asp:Content>

