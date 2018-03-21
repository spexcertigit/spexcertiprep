<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="PostOrder.aspx.cs" Inherits="Survey_PostOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
	<h1>Post-Order Survey Results</h1>
	<asp:GridView ID="gvSurvey" DataSourceID="dataSurvey" AutoGenerateColumns="false" runat="server" AllowPaging="true" PageSize="10">
		<Columns>
			<asp:BoundField DataField="ID" HeaderText="Order ID" />
			<asp:BoundField DataField="OrderDate" HeaderText="Order Date" DataFormatString="{0:d}" />
			<asp:BoundField DataField="FinalPrice" HeaderText="Amount" ItemStyle-HorizontalAlign="Right" />
			<asp:BoundField DataField="SurveyQuestion" HeaderText="Question" />
			<asp:BoundField DataField="SurveyAnswer" HeaderText="Answer" />
		</Columns>
		<PagerSettings Mode="NumericFirstLast" Position="Bottom" />
	</asp:GridView>
<asp:SqlDataSource ID='dataSurvey' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>" CancelSelectOnNullParameter="true"
    SelectCommand="SELECT wod.ID, wod.OrderDate, wod.FinalPrice, spo.SurveyQuestion, spo.SurveyAnswer FROM WebOrderDetails wod JOIN SurveyPostOrder spo ON wod.ID = spo.WebOrderDetailsID ORDER BY spo.SurveyID DESC" SelectCommandType="Text">
</asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
</asp:Content>

