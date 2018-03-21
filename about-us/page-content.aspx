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
					<div class="clear"></div>
				</div>
				<div class="main-column">
					<%=pagecontent1%>
					<div style="clear:both; height:30px;"></div>
					<div id="print-page">
						Print this page
					</div>
					<div id="go-top">
						<a href="#top">Back to top &#9650;</a> 
					</div>
					<iframe name="print_frame" width="0" height="0' frameborder="0" src="about:blank"></iframe>
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
					<div id="print-page">
						Print this page
					</div>
					<div id="go-top">
						<a href="#top">Back to top &#9650;</a> 
					</div>
					<iframe name="print_frame" width="0" height="0' frameborder="0" src="about:blank"></iframe>
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
	<script src="/js/jquery-ui.js" type="text/javascript"></script>
	
    <script type="text/javascript">
        $(document).ready(function () {
            $(".tablesorter tr:odd").addClass("odd");
			$('#banner-div').show();
			$("#print-page").click(function() {
				var printDivCSS = new String ('<link href="/css/screen/content.css" rel="stylesheet" type="text/css" charset="utf-8" Runat="Server"/>');
				window.frames["print_frame"].document.body.innerHTML=printDivCSS + document.getElementById("page_margins").innerHTML;
				window.frames["print_frame"].window.focus();
				window.frames["print_frame"].window.print();
			});
        })
        function buyIt(productid) {
            theQuantity = document.getElementById("quantity_" + productid).value;
            $("#footer_cart").load("/utility/addtocart.aspx?productid=" + productid + "&pq=" + theQuantity, function () {
                $("#totalitems").effect("highlight", { color: "#ffffff" }, 5000);
                $("#totalcost").effect("highlight", { color: "#ffffff" }, 5000);
                $("#totalsavings").effect("highlight", { color: "#ffffff" }, 5000);
            });
            //document.getElementById("buy_"+productid).value=" - ";
            $("#buy_" + productid).removeClass("search_buy");
            $("#buy_" + productid).addClass("search_buy_clicked");
            $("#buy_" + productid).effect("highlight", { color: "#ffffff" }, 1000);
        }
    </script>
</asp:Content>


