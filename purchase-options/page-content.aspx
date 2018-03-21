<%@ Page Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="page-content.cs" Inherits="page_preview" debug="true"%>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="ContentBanner" ContentPlaceHolderID="cpPageBanner" Runat="Server">
	<% if (banner != "") { %>
		<div id="banner-section" <%=banner%>>
			<div class="banner-label-wrapper">
				<% if (title == "") {%>
					<h1><%=name%></h1>
				<% }else { %>
					<%=title%>
				<% } %>
			</div>
		</div>
	<% }%>
	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server">
    <a href="/">Home</a> > Purchase Options > <%=name%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
	<% if (showtitle == "True") { %>
		<div id="mainHeader">
			<h1><%=name%></h1>
		</div>
	<% }%>
	<div id="layout_container">
		<% if (layout == "standard") {%>
			<div id="standard" class="page-layout">
				<div class="sidebar">
					<%=widgets%>
					<uc1:ShareThis ID="ShareThis1" runat="server" />
					<div class="clear"></div>
				</div>
				<div class="main-column">
					<%=pagecontent1%>
					<div class="clear"></div>
				</div>
				<div class="clear"></div>
			</div>
		<% }else if (layout == "full_width") { %>
			<div id="full_width" class="page-layout">
				<%=pagecontent1%>
				<div class="clear"></div>
			</div>
		<% }else if (layout == "sidebar_right") { %>
			<div id="sidebar_right" class="page-layout">
				<div class="main-column">
					<%=pagecontent1%>
					<div class="clear"></div>
				</div>
				<div class="sidebar">
					<%=widgets%>
					<uc1:ShareThis ID="ShareThis2" runat="server" />
					<div class="clear"></div>
				</div>
				<div class="clear"></div>
			</div>
		<% }else if (layout == "two_columns") { %>
			<div id="two_columns" class="page-layout">
				<div id="first" class="content-column">
					<%=pagecontent1%>
				</div>
				<div id="second" class="content-column">
					<%=pagecontent2%>
				</div>
				<div class="clear"></div>
			</div>
		<% }else if (layout == "three_columns") { %>
			<div id="three_columns" class="page-layout">
				<div id="first" class="content-column">
					<%=pagecontent1%>
				</div>
				<div id="second" class="content-column">
					<%=pagecontent2%>
				</div>
				<div id="third" class="content-column">
					<%=pagecontent3%>
				</div>
				<div class="clear"></div>
			</div>
		<% }%>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	
</asp:Content>


