﻿<%@ Page Language="C#" Title="Update Webinars" MasterPageFile="~/admin/Site.Master" AutoEventWireup="true" CodeFile="edit.aspx.cs" Inherits="webinars_edit" ValidateRequest="false" debug="true"%>

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
                        <strong>Successfully</strong> updated the <strong>Webinars Item!!</strong>
                    </div>
                </div>
				<% }else if (Request.QueryString["failed"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-danger alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Opps!</strong> something went wrong in updating the <strong>Webinars Item!!</strong>
                    </div>
                </div>	
				<% }%>
                <div class="col-lg-12">
                    <h1 class="page-header">
                        Edit Webinars
                    </h1>
                    <ol class="breadcrumb">
						<li>
                            <i class="fa fa-fw fa-dashboard"></i> <a href="/admin/dashboard.aspx">Dashboard</a>
                        </li>
                        <li>
                            <i class="fa fa-pencil-square-o"></i> <a href="/admin/administerwebinars/">Webinars</a>
                        </li>
                        <li class="active">
                            <i class="fa fa-edit"></i> Edit
                        </li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
	
  
	<div class="row">
        <div class="col-lg-7">
            <div class="table-responsive">
			
                <div class="form-group">
				<label>Title:</label>
                    <asp:TextBox ID="WebinarTitle" runat="server" CssClass="form-control" placeholder="Title" TabIndex="0" Width="100%"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="WebinarTitle" ValidationGroup="InputCheck" ErrorMessage="Job title is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
				<div class="form-group">
				<label>URL:</label>
                    <asp:TextBox ID="WebinarUrl" runat="server" CssClass="form-control" placeholder="Title" TabIndex="0" Width="100%"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="WebinarUrl" ValidationGroup="InputCheck" ErrorMessage="Job title is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
				<div class="form-group" style="width: 100%">
                    <label>Description:</label>
					<asp:TextBox id="txtBodyDescription" TextMode="multiline" CssClass="main-editor" Columns="100" Rows="10" runat="server" />
                </div>
				<div class="form-group" style="width: 100%">
                    <label>Abstract:</label>
					<asp:TextBox id="txtBodyAbstract" TextMode="multiline" CssClass="main-editor" Columns="100" Rows="10" runat="server" />
                </div>
				
				<!--<div class="form-group">
                    <asp:TextBox ID="jobLocation" runat="server" CssClass="form-control" placeholder="Location" TabIndex="0" Width="100%"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="jobLocation" ValidationGroup="InputCheck" ErrorMessage="Job location is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
				
				<div class="form-group input-group">
						<span class="input-group-addon">Select a Category</span>
						<asp:DropDownList ID="jobCategory" runat="server" CssClass="form-control" Width="100%">
							<asp:ListItem Text="Corporate" Value="1"/>
							<asp:ListItem Text="Sales" Value="2"/>
							<asp:ListItem Text="Product/Marketing" Value="3"/>
							<asp:ListItem Text="Customer Service" Value="4"/>
						</asp:DropDownList>
				</div>
				
                <div class="form-group input-group">
                    <asp:TextBox id="jobSummary" TextMode="multiline" CssClass="main-editor" Columns="50" Rows="5" runat="server" />
                </div>-->
				    
            </div>
			
			<div class="form-group"></div>
           <div class="form-group">
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-danger pull-right" TabIndex="6" OnClick="btnCancel_Click" />
                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary pull-right" TabIndex="4" style="margin-right:10px" ValidationGroup="InputCheck" OnClick="btnSave_Click"/>   
                <div class="clearfix"></div>
            </div>
		
            <div class="form-group">&nbsp;</div>
        </div>
		<div class="col-lg-5">
			<div class="form-group input-group" style="width: 100%">
					<iframe width="100%" height="315" src='<%=video%>' frameborder="0" allowfullscreen></iframe>
				</div>
		</div>
    </div>
	
</asp:Content>
