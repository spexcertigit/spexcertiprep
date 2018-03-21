<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="single.aspx.cs" Inherits="knowledge_base_webinars" debug="true"%>

<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="../default.aspx">Home</a> > <a href="/knowledge-base">Knowledge Base</a> > <a href="/knowledge-base/webinars.aspx">Webinars</a></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">

<style>
div.atclear { clear:none; }
iframe { display: block }
</style>
            <div id="mainHeader">
                <h2>Webinars</h2>
            </div>
            <div id="main">
                <div id="col1">
                    <div id="col1_content" class="clearfix webinars">
                        <img src="/knowledge-base/images/ResourcesImage.jpg" alt="Your science is our passion" width="240" height="240" />
						<br><br>
						<p>  	Every year, SPEX CertiPrep produces several FREE, informative webinars on a variety of topics including Clean Laboratory Techniques, CRM's: Beyond the Basics, and Uncertainty of Analytical Data.<br>  	<br>  	Recordings of the most recent and&nbsp;popular webinars&nbsp;are embedded below. To view the archive of our previous events, please visit our <a href="http://www.youtube.com/spexcertiprep">YouTube</a> page.</p>
						<p>  	<a href="http://www.youtube.com/spexcertiprep/"><img alt="Visit our YouTube Channel" src="/knowledge-base/images/YouTubeLogo_hh.png"></a></p>
						<p>  	Be sure to check out our list of <a href="http://spexcertiprep.com/news-and-events/tradeshow-calendar.aspx">upcoming events</a> to find a schedule of any upcoming webinars.</p>
                    </div>
					<div class="archiveBox">
						<div class="info-head">Archives</div>
						<ul>
							<asp:Literal ID="ltrArchive" runat="server" />
							<asp:Literal ID="ltrOldArchive" runat="server" />
						</ul>
					</div>
					
                </div>
                <div id="col3">
					<div id='col3_content'>
						<div id="mainHeader" style="height: auto;">
							<h1><asp:Literal ID="ltrTitle" runat="server" /></h1>
						</div>
						<div class="vid-container">
							<asp:Literal ID="ltrVideo" runat="server" />
						</div>
						<ul class="shareBtn"><li><uc1:ShareThis ID="ShareThis1" runat="server" /></li></ul>
						<div class="vid-desc">
							<asp:Literal ID="ltrAbstract" runat="server" />
							<br><br>
							<span style="font-style:italic"><asp:Literal ID="ltrDesc" runat="server" /></span>
						</div>
					</div>
                    <div id="ie_clearing"> &#160; </div>
                </div>
				<div style="clear:both"></div>
            </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script>
		$(function () {
			$('.meta p').each(function () {
				var content = $(this).text();
				var sentence = content.split('.');
				var output = sentence[0] + ".";
				$(this).html(output);
			});
		});
	</script>
</asp:Content>

