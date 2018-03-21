<%@ Page Language="C#" Title="Update Custom Standards Page" MasterPageFile="~/admin/Site.Master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="plasmashots" ValidateRequest="false" debug="true"%>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <script type="text/javascript">
		$(document).ready(function() {			
			
			
		});
        function relocate(url) {
            location.replace(url);0
        }
		
    </script>
    <section class="featured">
        <div class="content-wrapper">
            <div class="row">
				<% if (Request.QueryString["success"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-success alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Successfully</strong> updated the <strong>Page Item(s)!!</strong>
                    </div>
                </div>
				<% }else if (Request.QueryString["failed"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-danger alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Opps!</strong> something went wrong in updating the <strong>Page Item!!</strong>
                    </div>
                </div>	
				<% }%>
                <div class="col-lg-12">
                    <h1 class="page-header">
                        Edit 30mL-plasma-shots Page
                    </h1>
                    <ol class="breadcrumb">
						<li>
                            <i class="fa fa-fw fa-dashboard"></i> <a href="/admin/dashboard.aspx">Dashboard</a>
                        </li>
                        <li>
                            <i class="fa fa-pencil-square-o"></i> <a href="/admin/editpages/">Edit A Page</a>
                        </li>
                        <li class="active">
                            <i class="fa fa-edit"></i> Edit 30mL-plasma-shots Page
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
				<label>Header 1:</label>
                    <asp:TextBox ID="header1" runat="server" CssClass="form-control" placeholder="Title" TabIndex="0" Width="100%"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="header1" ValidationGroup="InputCheck" ErrorMessage="Job title is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
				
				<div class="form-group">
				<label>Heading 2:</label>
                    <asp:TextBox ID="header2" runat="server" CssClass="form-control" placeholder="Header2" TabIndex="0" Width="100%"></asp:TextBox>
                </div>
				
				<div class="form-group">
				<label>Header Image URL:</label>
                    <asp:TextBox ID="image1" runat="server" CssClass="form-control" placeholder="image1" TabIndex="0" Width="20%" ></asp:TextBox>
					<br/>
					<asp:Image ID="image1Con" runat="server" CssClass="banner" />
                </div>
				
				
				
				<div class="form-group" style="width: 100%">
					<label>Long Content1:</label>
                    <asp:TextBox id="long_content1" TextMode="multiline" CssClass="main-editor" Columns="100" Rows="10" runat="server" />
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
