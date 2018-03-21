<%@ Page Title="SPEX CertiPrep - Knowledge Base - FAQs" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="ask-a-chemist.aspx.cs" Inherits="knowledge_base_FAQs" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">

<style type="text/css">
	#breadcrumb {
		display:none; 
	}
	#mainHeader { height:auto }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"></asp:Content>
<asp:Content ID="ContentHeader" ContentPlaceHolderID="cpPageBanner" Runat="Server">
	<div id="banner-div" class="ask-chemist">
		<img src="/knowledge-base/images/Ask-A-Chemist-Header.png" />
	</div>	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="mainHeader">
                <h1 class="chemist">Do you have a technical CRM question for our experienced chemists?</h1>
				<a href="mailto:CRMMarketing@spex.com" class="ask-btn" >Ask Now! >></a>
            </div>
            <div id="main">
				<br /><br />
				<asp:ListView ID="lvProducts" runat="server" DataSourceID="dataQuestions">
					<LayoutTemplate>
						<div id="question-container">
							<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
						</div>
					</LayoutTemplate>
					<ItemTemplate>
						<div id="qb-<%# Eval("id").ToString() %>" class="question-box">
							<p><%# Eval("question").ToString() %></p>
							<a class="answer-btn" data-id="<%# Eval("id").ToString() %>">Answer</a>
							<div class="answer-container"><div id="ans-<%# Eval("id").ToString() %>" class="answer-box"><%# Eval("answer").ToString() %></div></div>
						</div>
					</ItemTemplate>
				</asp:ListView> 
				<div id="ie_clearing"> &#160; </div>
            </div>
	<asp:SqlDataSource ID='dataQuestions' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>" SelectCommand="SELECT * FROM AskAChemist ORDER BY responsedate DESC" SelectCommandType="Text">
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script>
		$(document).ready(function() {
			$(".answer-btn").click(function() {
				var id = $(this).data("id");
				if ($("#ans-" + id).hasClass("selected")) {
					$("#qb-" + id).removeClass("selected")
					$("#ans-" + id).slideToggle().removeClass("selected");
				}else {
					$(".question-box").each(function() { $(this).removeClass("selected"); });
					$(".answer-box").each(function() {
						if ($(this).hasClass("selected")) {
							$(this).slideToggle();
							$(this).removeClass("selected");
						}
					});
					
					$("#qb-" + id).addClass("selected");
					$("#ans-" + id).slideToggle().addClass("selected");
				}
				
			});
		});
	</script>
</asp:Content>

