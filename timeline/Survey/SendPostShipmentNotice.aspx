<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="SendPostShipmentNotice.aspx.cs" Inherits="Survey_PostShipment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
		<h3 style="font-size:1.4em">Send Post-Shipment Customer Survey</h3>
		<hr />

		<asp:Label ID="lblQ1" AssociatedControlID="ProcessDate" runat="server">Date to Process</asp:Label><br />
		<asp:TextBox ID="ProcessDate" runat="server" />
		<hr />

		<div><asp:Button ID="cmdSubmit" runat="server" Text="Submit" OnClick="cmdSubmit_Click" /></div>


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
</asp:Content>

