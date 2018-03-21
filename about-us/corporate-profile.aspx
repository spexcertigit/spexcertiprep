<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="corporate-profile.aspx.cs" Inherits="about_corporate" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server">
<style>
</style>
<a href="../default.aspx">Home</a> > About Us > Corporate Profile</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="mainHeader">
                <asp:Literal ID="ltrHeadline" runat="server" />
            </div>
            <div id="main">
                <div id="col1">
                    <div id="col1_content" class="clearfix">
						<uc1:ShareThis ID="ShareThis1" runat="server" />
                    </div>
                </div>
                <div id="col3" style="border:0">
                    <div id="col3_content" class="cp-page clearfix">
                        <!--<img class="cp_bldg_1" alt="" src="images/cpbldg1.jpg" style="margin-bottom:1em;" />-->
                        <img class="cp_bldg_1" alt="" src="images/spexcerti-bldg.png" style="margin-bottom:1em;" />
                        <asp:Literal ID="ltrSubHeader" runat="server" />
                        <asp:Literal ID="ltrBody" runat="server" />
                    </div>
                    <div id="ie_clearing"> &#160; </div>
                </div>
            </div>
			<script type="application/ld+json">
			{
			  "@context": "http://schema.org",
			  "@type": "Store",
			  "name": "SPEX CertiPrep",
			  "description": "SPEX CertiPrep is the top manufacturer of certified reference materials, spectroscopy &amp; chromatography calibration standards.",
			  "openingHours": "Mo-Fr 08:30-17:00",
			  "telephone": "1-800-LAB-SPEX"
			}
			</script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
</asp:Content>

