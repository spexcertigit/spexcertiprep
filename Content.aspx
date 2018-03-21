<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="Content.aspx.cs" Inherits="Content" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/default.aspx">Home</a> <asp:Literal ID="Breadcrumb" runat="server" /></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="mainHeader">
                <h1><asp:PlaceHolder ID="Headline" runat="server" /></h1>
            </div>
            <div id="main">
                <div id="col1">
                    <div id="col1_content" class="clearfix">
						<asp:PlaceHolder ID="Image" runat="server" />
                        <uc1:ShareThis ID="ShareThis1" runat="server" />
						<asp:PlaceHolder ID="SideContent" runat="server" />
                    </div>
                </div>
                <div id="col3">
                    <div id="col3_content" class="clearfix">
                        <div id="newsletters">
							<asp:PlaceHolder ID="BodyContent" runat="server" />
                        </div>
                    </div>
                    <div id="ie_clearing"> &#160; </div>
                </div>
            </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" runat="server">
    <asp:Literal ID="ltrHighlite" runat="server" />
    <script type="text/javascript">
    	$(function () {
    		/*$("#catmenu").menu();
    		$("#cat-accordion").accordion({ collapsible: true, heightStyle: "content", active: false });*/
    	});
    </script>
</asp:Content>

