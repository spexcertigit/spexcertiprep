<%@ Page Title="Catalog Download | SPEX CertiPrep" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="catalog-download.cs" Inherits="thank_you" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="main">
				<div id="mainHeader">
					<h1 style="font-weight:bold;">SPEX CertiPrep <span class="greyHead">Catalog Download</span></h1>
				</div>
            </div>
			<br><br><br><br>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script>
		$(document).ready(function() {
			
		});
		function delayRedirect(url) {
			var Timeout = setTimeout("window.location='" + url + "'",10000);
		}
	</script>
</asp:Content>

