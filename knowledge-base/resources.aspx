<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="resources.aspx.cs" Inherits="knowledge_resources" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="../default.aspx">Home</a> > Knowledge Base > Recommended Reading</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="mainHeader">
                <asp:Literal ID="ltrHeadline" runat="server" />
            </div>
            <div id="main">
                <div id="col1">
                    <div id="col1_content" class="clearfix">
                        <img src="images/ResourcesImage.jpg" alt="Your science is our passion" width="240" height="240" />
						<uc1:ShareThis ID="ShareThis1" runat="server" />
                    </div>
                </div>
                <div id="col3">
                    <div id="col3_content" class="clearfix">
                        <asp:Literal ID="ltrSubHeader" runat="server" />
                        <asp:Literal ID="ltrBody" runat="server" />
                    </div>
                    <div id="ie_clearing"> &#160; </div>
                </div>
            </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
</asp:Content>

