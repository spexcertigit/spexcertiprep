<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="webinar_archives.aspx.cs" Inherits="knowledge_base_webinars" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="../default.aspx">Home</a> > <a href="/knowledge-base">Knowledge Base</a> > <a href="/knowledge-base/webinars.aspx">Webinars</a></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">

<style>
.archiveBox {margin-bottom: 0}
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
							<div class="info-head">Archives</div>
							<ul>
								<asp:Literal ID="ltrArchive" runat="server" />
								<asp:Literal ID="ltrOldArchive" runat="server" />
							</ul>
						</div>
                    </div>
					<uc1:ShareThis ID="ShareThis1" runat="server" />
                </div>
                <div id="col3" style="margin:0;float:left;width:710px;">
                    <asp:Literal ID="ltrContent" runat="server" />
                    <div id="ie_clearing"> &#160; </div>
                </div>
				<div style="clear:both"></div>
            </div>

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


