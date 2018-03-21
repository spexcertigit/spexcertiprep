<%@ Page Title="Thank you for Answering | SPEX CertiPrep" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="feedback-thank-you.cs" Inherits="thank_you" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="main">
				<div id="mainHeader">
					<h1 style="font-weight:bold;">SPEX CertiPrep <span class="greyHead">Survey</span></h1>
				</div>
                <h1>Thank You!</h1>
				<p>We really appreciate your feedback! Your response will be kept confidential and will not be sent to third party establishment.</p>
				<p>If you have any immediate request or inquiry, please call 1-800-LAB-SPEX</p>
				<br />
				<p>You will be redirected to the homepage after 10 seconds. Click <a href="http://www.spexcertiprep.com/">Here</a> if you don't wish to wait.</p>
				
            </div>
			<br><br><br><br>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script>
		$(document).ready(function() {
			delayRedirect("http://www.spexcertiprep.com/");
		});
		function delayRedirect(url) {
			var Timeout = setTimeout("window.location='" + url + "'",10000);
		}
	</script>
</asp:Content>

