<%@ Page Title="SPEX SamplePrep - Purchase Options - Distributors" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="distributors.aspx.cs" Inherits="purchase_distributors" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/default.aspx">Home</a> > Purchasing Options > Distributors</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="mainHeader">
                <asp:Literal ID="ltrHeadline" runat="server" />
            </div>
            <div id="main">
                <div id="col1">
                    <div id="col1_content" class="clearfix">
                        <asp:DropDownList id="country" runat="server" style="font-size:13px" AutoPostBack="true" DataSourceID="dataCountries" DataTextField="Country" DataValueField="Country" AppendDataBoundItems="true">
							<asp:ListItem Value="" Text="Select your country" />
                        </asp:DropDownList>
						<uc1:ShareThis ID="ShareThis1" runat="server" />
                    </div>
                </div>
                <div id="col3">
                    <div id="col3_content" class="clearfix">
                        <div id="distributors">
                            <h2>SPEX CertiPrep Distributors</h2>
							<asp:ListView ID="lvItems" DataSourceID="dataItems" runat="server">
								<LayoutTemplate>
									<asp:PlaceHolder runat="server" ID="itemPlaceHolder" />
								</LayoutTemplate>
								<ItemTemplate>
									<div style="font-weight:bold"><%# Eval("Company") %></div>
									<div><%# Eval("Phone") %></div>
									<div><%# Eval("Fax").ToString().Length > 0 ? Eval("Fax").ToString() + " (fax)" : "" %></div>
									<div><%# Eval("Email").ToString().Length > 0 ? "<a href='mailto:" + Eval("Email").ToString() + "'>" + Eval("Email").ToString() + "</a>" : "" %></div>
									<div><%# Eval("Site").ToString().Length > 0 ? "<a href='" + Eval("Site").ToString() + "' target='_blank'>" + Eval("Site").ToString() + "</a>" : "" %></div>
									<div><%# Eval("Address1") %></div>
									<div><%# Eval("Address2") %></div>
									<div><%# Eval("Address3") %></div>
									<div><%# Eval("Address4") %></div>
									<br />
								</ItemTemplate>
								<EmptyDataTemplate>
									<p>SPEX CertiPrep has a worldwide network of distributors. Select your country to the left to  find a dealer near you. Can&#8217;t  find a dealer in your country? Or are  you interested in distributing SPEX CertiPrep products? Contact us at <a href="mailto:crmsales@spexcsp.com">crmsales@spexcsp.com</a>.</p>
								</EmptyDataTemplate>
							</asp:ListView>
                        </div>
                    </div>
                    <div id="ie_clearing"> &#160; </div>
                </div>
            </div>
<asp:SqlDataSource ID='dataCountries' runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" ProviderName="<%$ ConnectionStrings:ApplicationServices.ProviderName %>"
    SelectCommand="SELECT DISTINCT Country FROM sprepDistributors ORDER BY Country" SelectCommandType="Text">
</asp:SqlDataSource>
<asp:SqlDataSource ID='dataItems' runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" ProviderName="<%$ ConnectionStrings:ApplicationServices.ProviderName %>"
    SelectCommand="SELECT * FROM sprepDistributors WHERE Country = @Country ORDER BY Company" SelectCommandType="Text" CancelSelectOnNullParameter="true">
	<SelectParameters>
		<asp:ControlParameter Name="Country" ControlID="country" Type="String" ConvertEmptyStringToNull="true" />
	</SelectParameters>
</asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
</asp:Content>

