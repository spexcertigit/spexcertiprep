<%@ Page Title="Search | SPEX CertiPrep" Language="C#" Debug="true" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="search.cs" Inherits="search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <style type="text/css">
        a.aspNetDisabled { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        a.aspNetDisabled:hover { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        #ProductListPagerSimple span,
        #ProductListPagerSimple2 span { font-weight:bold; }
		#breadcrumb { display:none; }
		#content { padding-bottom:40px}
		.resultItem { margin: 23px 0; }
		.resultItem .title { font-size: 20px; font-weight: normal; color: #a3b405; margin:0; padding: 0; line-height: 1.2}
		.resultItem .title a { text-decoration: none; }
		.resultItem .title a:hover { text-decoration: underline; }
		.resultItem .desc-section { line-height: 18px; }
		.resultItem cite { color: #9396cb; font-family: "Myriad Pro"; font-style: normal;}
		h1 small { font-size: 13px; color:#808080;}
		.typeContainer { border-bottom: 1px solid #ebebeb; }
		.type-choices { width: 960px; margin: 0 auto; height: 45px; }
		.type-choices .type { float: left; margin-right: 10px; padding: 15px 10px 0; font-size: 14px; cursor: pointer; height: 45px;}
		.type-choices .type:hover { color:#111;}
		.type-choices .type.selected { font-weight: bold; color: #A7AF12; border-bottom: 3px solid #A7af12;}
		.iconBox img {margin:0 auto; max-height: 100%; max-width:100%; }
    </style>
	<link rel="stylesheet" href="/css/screen/font-awesome.min.css" />
</asp:Content>
<asp:Content ID="ContentBanner" ContentPlaceHolderID="cpPageBanner" Runat="Server">
	<div class="typeContainer">
		<div class="type-choices">
			<div class="type" data-type="all">All</div>
			<div class="type" data-type="products">Products</div>
			<div class="type" data-type="resources">Resources</div>
			<div class="type" data-type="methods">Methods</div>
			<div class="type" data-type="news">News</div>
		</div>
	</div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
		
    	<div id="main">
            <h1>Search Results - &quot;<%=Request.QueryString["search"].ToString()%>&quot; <small>About (<asp:Literal ID="resCount" runat="server"/>) results.</small></h1>
            <div class="resTxt" style="text-align: right;">Results per page:
				<asp:DropDownList ID="lbResults" runat="server" AutoPostBack="True" CssClass="page-filter" OnSelectedIndexChanged="lbResults_Change">
					<asp:ListItem Value="10" Text="10" />
					<asp:ListItem Value="25" Text="25" />
					<asp:ListItem Value="50" Text="50" />
					<asp:ListItem Value="100" Text="100" />
				</asp:DropDownList>
			</div>
            <div id="resultstable">
				<asp:ListView ID="lvResults" runat="server" DataSourceID="dataResults">
					<LayoutTemplate>
						<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
					</LayoutTemplate>
					<ItemTemplate>
						<div class="resultItem">
							<div class="iconBox" style="width:65px;text-align:center;float:left; margin-right: 20px; padding: 10px 0;font-size: 65px;color: #a3b405;"><%# getIcon(Eval("type").ToString(), Eval("url").ToString()) %></div>
							<h3 class="title">
								<a href=<%# (Eval("type").ToString() == "products") ? getURL(Eval("url").ToString()) : "" %>
										<%# (Eval("type").ToString() == "pages") ? Eval("url").ToString() : "" %>
										<%# (Eval("type").ToString() == "appnotes") ? baseURL + "knowledge-base/files/" + Eval("url").ToString() : "" %>
										<%# (Eval("type").ToString() == "posters") ? baseURL + "knowledge-base/files/" + Eval("url").ToString() : "" %>
										<%# (Eval("type").ToString() == "webinars") ? baseURL + "knowledge-base/webinars/" + Eval("url").ToString() : "" %>
										<%# (Eval("type").ToString() == "optimize") ? baseURL + "knowledge-base/files/" + Eval("url").ToString() : "" %>
										<%# (Eval("type").ToString() == "epa") ? baseURL + "products/pesticides/" + Eval("url").ToString() : "" %>
										<%# (Eval("type").ToString() == "news") ? baseURL + "news-and-events/news.aspx?id=" + Eval("url").ToString() : "" %> 
										<%# (Eval("type").ToString() == "appnotes") ? "target='_blank'" : "" %>
										<%# (Eval("type").ToString() == "posters") ? "target='_blank'" : "" %>
										<%# (Eval("type").ToString() == "optimize") ? "target='_blank'" : "" %>>
									<span class="title"><%# Eval("title").ToString()%></span>
								</a>
							</h3>
							<div class="desc-section">
								<div class="cite_links">
									<cite class="urls"><%# (Eval("type").ToString() == "products") ? getURL(Eval("url").ToString()) : "" %><%# (Eval("type").ToString() == "pages") ? Eval("url").ToString() : "" %><%# (Eval("type").ToString() == "appnotes") ? baseURL + "knowledge-base/files/" + Eval("url").ToString() : "" %><%# (Eval("type").ToString() == "posters") ? baseURL + "knowledge-base/files/" + Eval("url").ToString() : "" %><%# (Eval("type").ToString() == "webinars") ? baseURL + "knowledge-base/webinars/" + Eval("url").ToString() : "" %><%# (Eval("type").ToString() == "epa") ? baseURL + "products/pesticides/" + Eval("url").ToString() : "" %><%# (Eval("type").ToString() == "news") ? baseURL + "news-and-events/news.aspx?id=" + Eval("url").ToString() : "" %><%# (Eval("type").ToString() == "optimize") ? baseURL + "knowledge-base/files/" + Eval("url").ToString() : "" %>
									</cite>
								</div>
								<span class="description"><%# Regex.Replace(Eval("description").ToString(), @"<[^>]+>|&nbsp;", "").Trim() %> </span>
							</div>
							<div class="clear"></div>
						</div>									
					</ItemTemplate>
					<EmptyDataTemplate>
						<div class="med card-section">  
							<p style="padding-top:.33em"> Your search - <em><b><%=Request.QueryString["search"].ToString()%></b></em> - did not produce any results.  </p>  
							<p style="margin-top:1em">Suggestions:</p> 
							<ul style="margin-left:1.3em;margin-bottom:2em">
								<li>Make sure that all words are spelled correctly.</li>
								<li>Try different keywords.</li>
								<li>Try more general keywords.</li>
							</ul> 
						</div>
					</EmptyDataTemplate>
				</asp:ListView> 		
				<asp:DataPager ID="ProductListPagerSimple" ClientIDMode="Static" runat="server" PagedControlID="lvResults" PageSize="10" QueryStringField="page">
					<Fields>
						<asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="true" FirstPageText="&lt;&lt;" PreviousPageText="&lt;" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
						<asp:NumericPagerField RenderNonBreakingSpacesBetweenControls="false" />
						<asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="true" LastPageText="&gt;&gt;" NextPageText="&gt;" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
					</Fields>
				</asp:DataPager>
				<div class="clearboth"></div>
			</div>
			<div class="clearboth"></div>
		</div>

    <asp:SqlDataSource ID='dataResults' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>" SelectCommandType="Text" onselected="dataResults_Selected" OnSelecting="dataResults_Selecting">
    </asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script src="/js/jquery-ui.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {			
			$(".description").succinct({ size: 250 });
			$(".urls").shorten({ moreText: "" });
			$("span.title").shorten({ moreText: "" });
			var seen = false;
			var searchType = getParameterByName("type");
			$(".type").each(function() {
				if ($(this).data("type") == searchType) {
					$(this).addClass("selected");
					seen = true;
				}
			});
			if (seen == false) {
				$(".type").each(function() {
					if ($(this).data("type") == "all") {
						$(this).addClass("selected");
					}
				});
			}
			
			$(".type").click(function(){
				var url = "/search.aspx?search=<%=Request.QueryString["search"].ToString()%>";
				
				url = url + "&type=" + $(this).data("type");
				
				location.replace(url);
				//$("#main").load(url);
			});
			
			$(".description").each(function() {
				var src_str = $(this).html();
				var term = "<%=Request.QueryString["search"].ToString().Replace("-", " ")%>";
				var srch = term.split(" ");
				for (i = 0; i < srch.length; i++) {
					term2 = srch[i];
					term2 = term2.replace(/(\s+)/,"(<[^>]+>)*$1(<[^>]+>)*");
					var pattern = new RegExp("("+term2+")", "gi");

					src_str = src_str.replace(pattern, "<b>$1</b>");
					src_str = src_str.replace(/(<b>[^<>]*)((<[^>]+>)+)([^<>]*<\/b>)/,"$1</b>$2<b>$4");
					$(this).html(src_str);
				}
				
			});
        });
		
		
		
		function getParameterByName(name, url) {
			if (!url) url = window.location.href;
			name = name.replace(/[\[\]]/g, "\\$&");
			var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
				results = regex.exec(url);
			if (!results) return null;
			if (!results[2]) return '';
			return decodeURIComponent(results[2].replace(/\+/g, " "));
		}
    </script>
</asp:Content>

