<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="sitemap.aspx.cs" Inherits="sitemap" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="../default.aspx">Home</a> > About Us > Corporate Profile</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="mainHeader">
                <h1><asp:Literal ID="ltrHeadline" runat="server" /></h1>
            </div>
            <div id="main">
                <div id="col1">
                    <div id="col1_content" class="clearfix">
						<uc1:ShareThis ID="ShareThis1" runat="server" />
                    </div>
                </div>
                <div id="col3" style="border:0">
                    <div id="col3_content" class="clearfix">
						<ul id="sitemap-list">
							<li><a href="/default.aspx">Home</a></li>
							
						</ul>
                    </div>
                    <div id="ie_clearing"> &#160; </div>
                </div>
            </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
<script>
	$(document).ready(function() {
		$(".top-navi .nav-menu").each(function(){
			if (!$(this).hasClass("home")) {
				$("#sitemap-list").append("<li>" + $(this).html() + "</li>");
			}
		});
	});
</script>
</asp:Content>

