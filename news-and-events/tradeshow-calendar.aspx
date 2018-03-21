<%@ Page Title="SPEX CertiPrep - News &amp; Events - Tradeshow Calendar" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="tradeshow-calendar.aspx.cs" Inherits="news_trade" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <style type="text/css">
        .borderbox { border-bottom:2px solid #bfbfbf; padding-bottom:1em; }
		p { font-size:14px;}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/default.aspx">Home</a> <asp:Literal ID="Breadcrumb" runat="server" /></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="mainHeader">
                <h1>Events</h1>
            </div>
            <div id="main">
                <div id="col1">
                    <div id="col1_content" class="clearfix">
						<asp:PlaceHolder ID="Image" runat="server" />
                        <!--<img src="images/Tradeshows.jpg" alt="Your science is our passion" width="240" height="240" />	  -->
						<uc1:ShareThis ID="ShareThis1" runat="server" />
                    </div>
                </div>
                <div id="col3">
                    <div id="col3_content" class="clearfix">
                        <div id="newsletters">
							<asp:PlaceHolder ID="BodyContent" runat="server" />
	                        <!--<p>SPEX CertiPrep exhibits at a variety of trade shows,  conferences, and exhibitions around the world. Be sure to stop by our booth at any of these upcoming events.</p>		-->
                            <asp:ListView ID="lvNews" runat="server" DataSourceID="dataNews">
                                <LayoutTemplate>
                                    <dl>
                                        <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
                                    </dl>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <div class="borderbox">
                                        <dd class="event">
											&nbsp;
                                            <p style="font-weight:700;color:#a3b405;font-size:16px;"><%# Eval("Headline")%> in <%# Eval("EventLocation")%></p>
											<p>
												<%# string.Format("{0:MMM dd, yyyy}", Eval("EventDate"))%>
												<%# GetEndDate(string.Format("{0:MMM dd, yyyy}", Eval("EventDate")), string.Format("{0:MMM dd, yyyy}", Eval("EventEndDate"))) %>
											</p>
                                            <p><%# Eval("FullDescription")%></p>
                                        </dd>
                                    </div>
                                </ItemTemplate>
                            </asp:ListView> 
                        </div>
                    </div>
                    <div id="ie_clearing"> &#160; </div>
                </div>
            </div>

    <asp:SqlDataSource ID='dataNews' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT * FROM cms_Event WHERE Site = 'cp' AND IsActive = 1 ORDER BY EventDate DESC" SelectCommandType="Text">
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
</asp:Content>

