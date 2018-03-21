<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="default.aspx">Home</a> > Search</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
			<asp:Panel ID="pnlSearch" runat="server" DefaultButton="ButtonSearch">
				<asp:textbox id="TextBoxQuery" runat="server" Width="312px" Text="<%# Query %>"></asp:textbox>&nbsp;
				<asp:button id="ButtonSearch" runat="server" Text="Search" OnClick="ButtonSearch_Click"></asp:button>
			</asp:Panel>
			<div style="margin:1em 0;text-align:center">
				<asp:label id="LabelSummary" runat="server" Text="<%# srch.Summary %>"></asp:label>
			</div>
			<div style="padding:1em 0">
				<asp:label id="LabelDidYouMean" runat="server" Text="<%# srch.SimilarSuggestions %>"></asp:label>
			</div>
			<div style="margin-bottom:40px">
                <asp:repeater id="Repeater1" runat="server" DataSource="<%# Results %>">
					<ItemTemplate>
						<p><a href='<%# DataBinder.Eval(Container.DataItem, "path")  %>' class="link"><%# DataBinder.Eval(Container.DataItem, "title")  %></a><br/>
							<span class="sample">
								<%# DataBinder.Eval(Container.DataItem, "sample")  %>
							</span>
							<br>
							<span class="path">
								<a href='<%# DataBinder.Eval(Container.DataItem, "path")  %>'><%# DataBinder.Eval(Container.DataItem, "url")  %></a>
							</span>
						</p>
					</ItemTemplate>
				</asp:repeater>
             </div>
			<div class="paging">Result page:
				<asp:repeater id="Repeater2" runat="server" DataSource="<%# Paging %>">
					<ItemTemplate>
						<%# DataBinder.Eval(Container.DataItem, "html") %>
					</ItemTemplate>
				</asp:repeater>
			</div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
</asp:Content>

