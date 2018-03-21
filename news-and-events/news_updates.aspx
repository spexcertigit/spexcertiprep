<%@ Page Title="SPEX CertiPrep - News & Events - News Updates" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="news_updates.aspx.cs" Inherits="news_news" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
<style>
    input.email_newsletter {
    	padding: 5px;
    	border: 2px inset #ddd ! important;
    	border-color: #DDD;
    	border-radius: 4px;
    	background: #eee ! important;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/default.aspx">Home</a> > News & Events > News Updates</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="mainHeader">
                <h1>News Updates</h1>
            </div>
            <div id="main">
                <div id="col1">
                    <div id="col1_content" class="clearfix">
						<%--<form id="ccoptin" class="ccoptin" name="ccoptin" runat="server" target="_blank">--%>
							<h2>Sign up for our mailing list!</h2>
							<br />
							<table border="0" cellpadding="0" cellspacing="0" class="news_mailist noborder">
								<tr>
									<td class="noborder" style="padding:0">
										<input name="ea" placeholder="Email Address" type="text" value="" class="email_newsletter" id="email" style="margin:0" />
										<%--<asp:TextBox ID="email" name="ea" MaxLength="100" placeholder="Enter Address" CssClass="email_newsletter" style="=margin:0"/>--%>
									</td>
									<td class="noborder" style="padding:0">
										<asp:button id="submit" name="submit"
										  CssClass="filter-btn"
										  postbackurl="http://visitor.constantcontact.com/d.jsp" 
										  runat="Server">
										</asp:button>
										<%--<input name="submit" type="submit" class="emailbutton" id="submit" value="GO!" />--%>
									</td>
									<!--action="http://visitor.constantcontact.com/d.jsp" -->
								</tr>
							</table>
							<input name="m" value="1101976134161" type="hidden" />
							<input name="p" value="oi" type="hidden" />
						<%--</form>--%>				
						<uc1:ShareThis ID="ShareThis1" runat="server" />
                    </div>
                </div>
                <div id="col3">
                    <div id="col3_content" class="clearfix">
                        <div id="newsletters">
                            <div class="subcolumns">
                                <div class="c66l">
                                    <div class="subcl">
                                        <h2><asp:Literal ID="ltrSubHeader" runat="server" /></h2>    
                                        <asp:ListView ID="lvNews" runat="server">
                                            <LayoutTemplate>
                                                <ul>
                                                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
                                                </ul>
                                            </LayoutTemplate>
                                            <ItemTemplate>
			                                    <li><a href="news.aspx?id=<%# Eval("id")%>" class="newsitem">>> <strong><%# Eval("title") %></strong></a><br />
		                                        Posted <%# string.Format("{0:d}", Eval("posteddate")) %> - Category: <%# TranslateCategory(Eval("category").ToString())%></li>
                                            </ItemTemplate>
                                            <EmptyDataTemplate>
                                                <h3>There are no news stories for this category.</h3>
                                            </EmptyDataTemplate>
                                        </asp:ListView> 
                                        <asp:DataPager ID="ProductListPagerSimple" runat="server" PagedControlID="lvNews" QueryStringField="pg" PageSize="5">
                                           <Fields>
                                              <asp:NextPreviousPagerField FirstPageText="&lt;&lt;" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" RenderNonBreakingSpacesBetweenControls="true" />
                                              <asp:NumericPagerField RenderNonBreakingSpacesBetweenControls="false" />
                                              <asp:NextPreviousPagerField LastPageText="&gt;&gt;" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" RenderNonBreakingSpacesBetweenControls="true" />
                                           </Fields>
                                        </asp:DataPager> 
                                    </div>
                                </div>
                                <div class="c33r" style="display:none;">
                                    <div class="subcr">
                                        <h2>Categories</h2>
                                        <ul class="chevrons">
                                            <li><a href="news_updates.aspx">All</a></li>
                                            <li><a href="news_updates.aspx?category=1">CertiPrep General Update</a></li>
                                            <li><a href="news_updates.aspx?category=2">CertiPrep Newsletter</a></li>
                                            <li><a href="news_updates.aspx?category=3">CertiPrep Press Release</a></li>
											<li><a href="news_updates.aspx?category=7">CertiPrep Organic Update</a></li>
											<li><a href="news_updates.aspx?category=8">CertiPrep Inorganic Update</a></li>
                                        </ul>
                                        <h2>Archives:</h2>
                                        <asp:ListView ID="lvArchive" runat="server" DataSourceID="dataArchive">
                                            <LayoutTemplate>
                                                <ul class="chevrons">
                                                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
                                                </ul>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <li><a href="<%# "news_archive.aspx?d=" + string.Format("{0:d}", Eval("archivemonth")) %>"><%# string.Format("{0:MMMM yyyy}", Eval("archivemonth")) + " (" + Eval("archivemonthcount") + ")"%></a></li>
                                            </ItemTemplate>
                                        </asp:ListView> 
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="ie_clearing"> &#160; </div>
                </div>
            </div>

    <asp:SqlDataSource ID='dataNews' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT id, title, category, body, posteddate, active FROM news WHERE category IN ('1','2','3','7','8') AND active = '1' ORDER BY posteddate DESC" SelectCommandType="Text" onselected="dataNews_Selected">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataNewsbyCat' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT id, title, category, body, posteddate, active FROM news WHERE category = @cat AND active = '1' ORDER BY posteddate DESC" SelectCommandType="Text" onselected="dataNewsbyCat_Selected">
        <SelectParameters>
            <asp:QueryStringParameter Name="cat" Type="Int32" QueryStringField="category" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataArchive' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT dateadd(month, datediff(month, 0, posteddate),0) AS archivemonth, COUNT(*) AS archivemonthcount FROM news WHERE active = '1' AND category IN ('1','2','3','7','8') GROUP BY dateadd(month, datediff(month, 0, posteddate),0) ORDER BY dateadd(month, datediff(month, 0, posteddate),0) DESC" SelectCommandType="Text">
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
</asp:Content>

