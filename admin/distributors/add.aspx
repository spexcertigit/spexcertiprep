<%@ Page Language="C#" Title="New Distributor" MasterPageFile="~/admin/Site.Master" AutoEventWireup="true" CodeFile="add.aspx.cs" Inherits="news_add" ValidateRequest="false" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <script type="text/javascript">
        function relocate(url) {
            location.replace(url);
        }
    </script>
    <section class="featured">
        <div class="content-wrapper">
            <div class="row">
				<% if (Request.QueryString["success"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-success alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Successfully</strong> created new <strong>Distributor!!</strong>
                    </div>
                </div>
				<% }else if (Request.QueryString["failed"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-danger alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Opps!</strong> something went wrong in creating new <strong>Distributor!!</strong>
                    </div>
                </div>	
				<% }%>
                <div class="col-lg-12">
                    <h1 class="page-header">
                        Add New Distributor
                    </h1>
                    <ol class="breadcrumb">
						<li>
                            <i class="fa fa-fw fa-dashboard"></i> <a href="/admin/dashboard.aspx">Dashboard</a>
                        </li>
                        <li>
                            <i class="fa fa-map-marker"></i> <a href="/admin/distributors/">Distributors</a>
                        </li>
                        <li class="active">
                            <i class="fa fa-plus-square"></i> Add New Distributor
                        </li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <div class="row">
        <div class="col-lg-6">
            <div class="table-responsive">
                <div class="form-group">
                    <asp:TextBox ID="txtCountry" runat="server" CssClass="form-control" placeholder="Country" Width="100%"></asp:TextBox>
					<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCountry" ValidationGroup="InputCheck" ErrorMessage="Title is field is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
				
                <div class="form-group">
                    <asp:TextBox ID="txtCompany" runat="server" CssClass="form-control" placeholder="Company" Width="100%"></asp:TextBox>
					<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCompany" ValidationGroup="InputCheck" ErrorMessage="Title is field is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
				
				<div class="form-group">
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Phone" Width="100%"></asp:TextBox>
                </div>
				
				<div class="form-group">
                    <asp:TextBox ID="txtFax" runat="server" CssClass="form-control" placeholder="Fax" Width="100%"></asp:TextBox>
                </div>
				
				<div class="form-group">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email" Width="100%"></asp:TextBox>
                </div>
				
				<div class="form-group">
                    <asp:TextBox ID="txtEmail2" runat="server" CssClass="form-control" placeholder="Email2" Width="100%"></asp:TextBox>
                </div>
				
				<div class="form-group">
                    <asp:TextBox ID="txtSite" runat="server" CssClass="form-control" placeholder="Website" Width="100%"></asp:TextBox>
                </div>
				
				<div class="form-group">
                    <asp:TextBox ID="txtAdd1" runat="server" CssClass="form-control" placeholder="Address1" Width="100%"></asp:TextBox>
                </div>
				<div class="form-group">
                    <asp:TextBox ID="txtAdd2" runat="server" CssClass="form-control" placeholder="Address2" Width="100%"></asp:TextBox>
                </div>
				<div class="form-group">
                    <asp:TextBox ID="txtAdd3" runat="server" CssClass="form-control" placeholder="Address3" Width="100%"></asp:TextBox>
                </div>
				<div class="form-group">
                    <asp:TextBox ID="txtAdd4" runat="server" CssClass="form-control" placeholder="Address4" Width="100%"></asp:TextBox>
                </div>
				
				<div class="form-group">
                    <asp:TextBox ID="txtOrder" runat="server" CssClass="form-control" placeholder="Sort Order" Width="100%"></asp:TextBox>
                </div>
				
				<div class="form-group">
                    <asp:TextBox ID="txtLat" runat="server" CssClass="form-control" placeholder="Latitude" Width="100%"></asp:TextBox>
					<asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="txtLat" ValidationGroup="InputCheck" ErrorMessage="Title is field is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
				
				<div class="form-group">
                    <asp:TextBox ID="txtLong" runat="server" CssClass="form-control" placeholder="Longitude" Width="100%"></asp:TextBox>
					<asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="txtLong" ValidationGroup="InputCheck" ErrorMessage="Title is field is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
				
				<div class="form-group">
                    <asp:TextBox ID="txtZoom" runat="server" CssClass="form-control" placeholder="Zoom Level" Width="100%"></asp:TextBox>
                </div>
				
            </div>
			
			<div class="form-group"></div>
            <div class="form-group">
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-danger pull-right" TabIndex="6" OnClick="btnCancel_Click" />
                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary pull-right" TabIndex="4" style="margin-right:10px" ValidationGroup="InputCheck" OnClick="btnSave_Click"/>   
                <div class="clearfix"></div>
            </div>
            <div class="form-group">&nbsp;</div>
        </div>
    </div>
</asp:Content>