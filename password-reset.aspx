<%@ Page Title="Reset Forgotten Password | SPEX CertiPrep" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="password-reset.cs" Inherits="password_reset" debug="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="mainHeader">
                <h1>Forgotten Password</h1>
            </div>
            <div id="main">
				<% if (Request.QueryString["success"] != null) {%>
				<div class="success-box">
                    <div class="alert alert-success alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Success!!</strong> All changes to the account details has been completed!!
                    </div>
                </div>
				<% } %>
				<div class="row">
					<div class="col-lg-12">
						<div class="section-header">Change Password</div>
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
				<br /><br />
            </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script type="text/javascript">
		$(document).ready(function() {
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

