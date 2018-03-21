<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="register-thankyou.aspx.cs" Inherits="login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
		<div id="main">
			<div id="mainHeader">
				<h1 style="font-weight:bold;">SPEX CertiPrep <span class="greyHead">Registration</span></h1>
			</div>
			<br />
			<p>Thank you for registering with us.</p>
			<p>If you have any immediate request or inquiry, please call us at 1-800-LAB-SPEX</p>
			<p>You will be redirected back to the homepage page after 10 seconds. Click <a href="http://www.spexcertiprep.com/">Here</a> if you don't wish to wait.</p>
			<script>
				delayRedirect("http://www.spexcertiprep.com/");
				function delayRedirect(url) {
					var Timeout = setTimeout("window.location='" + url + "'",10000);
				}
			</script>
			<br>
			<br>
			<br>
        </div>
    <asp:SqlDataSource ID='dataCountries' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="sp_GetCountryList" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
</asp:Content>

