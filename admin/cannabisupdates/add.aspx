<%@ Page Language="C#" Title="New Event or Cannabis Updates" MasterPageFile="~/admin/Site.Master" AutoEventWireup="true" CodeFile="add.aspx.cs" Inherits="cannabisupdates_add" ValidateRequest="false" debug="true" %>

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
                        <strong>Successfully</strong> created <strong>Cannabis Updates Item!!</strong>
                    </div>
                </div>
				<% }else if (Request.QueryString["failed"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-danger alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Opps!</strong> something went wrong in creating <strong>Cannabis Updates Item!!</strong>
                    </div>
                </div>	
				<% }%>
                <div class="col-lg-12">
                    <h1 class="page-header">
                        Add New Cannabis Updates Item
                    </h1>
                    <ol class="breadcrumb">
						<li>
                            <i class="fa fa-fw fa-dashboard"></i> <a href="/admin/dashboard.aspx">Dashboard</a>
                        </li>
                        <li>
                            <i class="fa fa-leaf"></i> <a href="/admin/cannabisupdates/">Cannabis Updates</a>
                        </li>
                        <li class="active">
                            <i class="fa fa-plus-square"></i> Add New Cannabis Updates Item
                        </li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <div class="row">
        <div class="col-lg-12">
            <div class="table-responsive">
                <div class="form-group">
                    <asp:TextBox ID="title" runat="server" CssClass="form-control" placeholder="Title" TabIndex="0" Width="100%"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="title" ValidationGroup="InputCheck" ErrorMessage="Title is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
				
				 <div class="form-group">
                    <asp:TextBox ID="media" runat="server" CssClass="form-control" placeholder="Media" TabIndex="0" Width="100%"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="media" ValidationGroup="InputCheck" ErrorMessage="Media is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
				 <div class="form-group">
                    <asp:TextBox ID="link_url" runat="server" CssClass="form-control" placeholder="Link" TabIndex="0" Width="100%"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="link_url" ValidationGroup="InputCheck" ErrorMessage="Link is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
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