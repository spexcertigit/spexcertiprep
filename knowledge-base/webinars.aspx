<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="webinars.aspx.cs" Inherits="knowledge_base_webinars" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="../default.aspx">Home</a> > <a href="/knowledge-base">Knowledge Base</a> > Webinars</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">

<style>
.archiveBox {margin-bottom: 0}
.meta ul { display:none; }
.meta ul.watch-link { display:block; }
iframe { display:block }
</style>
            <div id="mainHeader">
                <h1><asp:Literal ID="ltrHeadline" runat="server" /></h1>
            </div>
            <div id="main">
                <div id="col1">
                    <div id="col1_content" class="clearfix webinars">
                        <img src="images/ResourcesImage.jpg" alt="Your science is our passion" width="240" height="240" />
                        <br><br>
						<p>  	Every year, SPEX CertiPrep produces several FREE, informative webinars on a variety of topics including Clean Laboratory Techniques, CRM's: Beyond the Basics, and Uncertainty of Analytical Data.<br>  	<br>  	Recordings of the most recent and&nbsp;popular webinars&nbsp;are embedded below. To view the archive of our previous events, please visit our <a href="http://www.youtube.com/spexcertiprep">YouTube</a> page.</p>
						<p>  	<a href="http://www.youtube.com/spexcertiprep/"><img alt="Visit our YouTube Channel" src="/knowledge-base/images/YouTubeLogo_hh.png"></a></p>
						<p>  	Be sure to check out our list of <a href="http://spexcertiprep.com/news-and-events/tradeshow-calendar.aspx">upcoming events</a> to find a schedule of any upcoming webinars.</p>
						<div class="archiveBox">
							<div class="info-head"><h2>Archives</h2></div>
							<ul>
								<asp:Literal ID="ltrArchive" runat="server" />
								<asp:Literal ID="ltrOldArchive" runat="server" />
							</ul>
						</div>
                    </div>
					<uc1:ShareThis ID="ShareThis1" runat="server" />
                </div>
                <div id="col3" style="margin:0;float:left;width:710px;">
					<asp:ListView ID="lvVids" runat="server" DataSourceID="dataVids">
						<LayoutTemplate>
							<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
						</LayoutTemplate>
						<ItemTemplate>
							<div id="col3_content">
								<div class="webinar-container">
									<div class="vid">
										<iframe allowfullscreen="" frameborder="0" height="184" src="<%# getVidEmbed(Eval("url").ToString()) %>" width="329"></iframe>
									</div>
									<div class="meta">
										<span><%# Eval("title").ToString() %></span><br> <br>
										<p class="desc-content" style="display: block;">
											<%# getNormalised(Eval("abstract").ToString())%>
										</p>
										<ul class="watch-link">
											<li><a href="/webinar/<%# getPageURL(Eval("title").ToString())%>">Watch Video &gt;&gt;</a></li>
										</ul>
									</div>
								</div>
								<div style="clear:both"></div>
							</div>
						</ItemTemplate>
						<EmptyDataTemplate>
							<div style="font-size:1.2em">
								<p>No Results</p>
							</div>
						</EmptyDataTemplate>
					</asp:ListView> 
					<div id="col3_content">
						<asp:DataPager ID="ProductListPagerSimple" ClientIDMode="Static" runat="server" PagedControlID="lvVids" PageSize="5" QueryStringField="page">
							<Fields>
								<asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="true" FirstPageText="&lt;&lt;" PreviousPageText="&lt;" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
								<asp:NumericPagerField RenderNonBreakingSpacesBetweenControls="false" />
								<asp:NextPreviousPagerField RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="true" LastPageText="&gt;&gt;" NextPageText="&gt;" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
							</Fields>
						</asp:DataPager> 
					</div>
					<div id="ie_clearing"> &#160; </div>
                </div>
				<div style="clear:both"></div>
				
            </div>
			
	<asp:SqlDataSource ID='dataVids' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT * FROM cpWebinar ORDER BY created_date DESC" SelectCommandType="Text">
    </asp:SqlDataSource>
	<asp:SqlDataSource ID='dataArchive' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT dateadd(month, datediff(month, 0, created_date),0) AS archivemonth, COUNT(*) AS archivemonthcount FROM cpWebinar GROUP BY dateadd(month, datediff(month, 0, created_date),0) ORDER BY dateadd(month, datediff(month, 0, created_date),0) DESC" SelectCommandType="Text">
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script>
		$(function () {
			$('.desc-content').each(function () {
				var content = $(this).text();
				var sentence = content.split('.');
				var output = sentence[0] + ".";
				$(this).text(output).show();
			});
		});
	</script>
</asp:Content>


