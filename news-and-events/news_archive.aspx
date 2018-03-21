<%@ Page Title="SPEX CertiPrep - News & Events - News Archives" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="news_archive.aspx.cs" Inherits="news_archive" %>
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
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/default.aspx">Home</a> > News & Events > News Archives</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="mainHeader">
                <h1>News Archives</h1>
            </div>
            <div id="main">
                <div id="col1">
                    <div id="col1_content" class="clearfix">
                        <img src="../images/page-photos/YourScienceImage_Fancy.jpg" alt="Your science is our passion" width="240" height="240" />     
                        <%--<form id="ccoptin" class="ccoptin" name="ccoptin" runat="server" target="_blank">--%>
                            <h2>Sign up for our mailing list!</h2>
                            <br />
                            <table border="0" cellpadding="0" cellspacing="0" class="news_mailist noborder">
                                <tr>
                                    <td class="noborder" style="padding:0">
                                        <input name="ea" placeholder="Email Address" type="text" value="" class="email_newsletter" id="email" style="width:160px;margin:0" />
                                        <%--<asp:TextBox ID="email" name="ea" MaxLength="100" placeholder="Enter Address" CssClass="email_newsletter" style="width:160px;margin:0"/>--%>
                                    </td>
                                    <td class="noborder">
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
                                        <asp:ListView ID="lvNews" DataSourceID="dataNews" runat="server">
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
                                        <asp:DataPager ID="NewsPager" runat="server" PagedControlID="lvNews" QueryStringField="pg" PageSize="5">
                                           <Fields>
                                              <asp:NextPreviousPagerField FirstPageText="&lt;&lt;" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" RenderNonBreakingSpacesBetweenControls="true" />
                                              <asp:NumericPagerField RenderNonBreakingSpacesBetweenControls="false" />
                                              <asp:NextPreviousPagerField LastPageText="&gt;&gt;" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" RenderNonBreakingSpacesBetweenControls="true" />
                                           </Fields>
                                        </asp:DataPager> 
                                    </div>
                                </div>
                                <div class="c33r">
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
                                        <h2 style="margin-top:2em;">Archives:</h2>
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
        SelectCommand="SELECT * FROM news WHERE MONTH(posteddate) = @month AND YEAR(posteddate) = @year AND category IN ('1','2','3','7','8') ORDER BY posteddate desc" SelectCommandType="Text" onselected="dataNews_Selected">
        <SelectParameters>
            <asp:Parameter Name="month" Type="Int32" />
            <asp:Parameter Name="year" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataArchive' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT dateadd(month, datediff(month, 0, posteddate),0) AS archivemonth, COUNT(*) AS archivemonthcount FROM news WHERE active = '1' AND category IN ('1','2','3','7','8') GROUP BY dateadd(month, datediff(month, 0, posteddate),0) ORDER BY dateadd(month, datediff(month, 0, posteddate),0) DESC" SelectCommandType="Text">
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
</asp:Content>

