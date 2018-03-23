<%@ Page Title="Thank you for your Product Catalog Request | SPEX CertiPrep" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="catalog-request-thank-you.cs" Inherits="thank_you" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="main">
				<div id="mainHeader">
					<h1 style="font-weight:bold;">NEW SPEX CertiPrep <span class="greyHead">Product Catalog</span></h1>
				</div>
                <h1>Thank You!</h1>
				<p>Your new product catalog request has been sent! </p>
				<p>If you have any immediate request or inquiry, please call 1-800-LAB-SPEX</p>
				<br />
				<p>You will be redirected to the homepage after 10 seconds. Click <a href="http://dev.spexcertiprep.com/">Here</a> if you don't wish to wait.</p>
				
            </div>
			<br><br><br><br>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script>
		$(document).ready(function() {
			delayRedirect("http://dev.spexcertiprep.com/");
			
			setTimeout(function(){
				if(document.location.search.length) {
					
					window.location = "/catalog-download.aspx";
				}
			},1400);
		});
		function delayRedirect(url) {
			var Timeout = setTimeout("window.location='" + url + "'",10000);
		}
	</script>
</asp:Content>

