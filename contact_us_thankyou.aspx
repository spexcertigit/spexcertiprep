<%@ Page Title="SPEX SamplePrep - Thank You" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="contact_us_thankyou.aspx.cs" Inherits="thank_you" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="main">
				<div id="mainHeader">
					<h1 style="font-weight:bold;">SPEX CertiPrep <span class="greyHead">Contact Us</span></h1>
				</div>
				<br>
				<h2 style="padding:0">Thank you!</h2>
				<br>
				<p>Thank you for sending your inquiry.</p>
				<p>We will get in touch with you soon.</p>
				<p>If you have any immediate request or inquiry, please call us at 1-800-LAB-SPEX</p>
				<br />
				<p>You will be redirected back to the previous page after 10 seconds. Click <a href="<%=Session["thankyou-redirect"]%>">Here</a> if you don't wish to wait.</p>
            </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
				<script>
					$(document).ready(function() {
						delayRedirect('<%=Session["thankyou-redirect"]%>');
					});
					function delayRedirect(url) {
						var Timeout = setTimeout("window.location='" + url + "'",10000);
					}
				</script>
</asp:Content>

