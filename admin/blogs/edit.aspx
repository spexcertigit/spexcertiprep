<%@ Page Language="C#" Title="Update News or Event" MasterPageFile="~/admin/Site.Master" AutoEventWireup="true" CodeFile="edit.aspx.cs" Inherits="blogs_edit" ValidateRequest="false" debug="true"%>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <script type="text/javascript">
		$(document).ready(function() {			
			//alert("<%=pubStatus%>");
			$("#status").val("<%=pubStatus%>");
			
		});
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
                        <strong>Successfully</strong> updated the <strong>Blogs Item!!</strong>
                    </div>
                </div>
				<% }else if (Request.QueryString["failed"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-danger alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Opps!</strong> something went wrong in updating the <strong>Blogs Item!!</strong>
                    </div>
                </div>	
				<% }%>
                <div class="col-lg-12">
                    <h1 class="page-header">
                        Edit Blogs
                    </h1>
                    <ol class="breadcrumb">
						<li>
                            <i class="fa fa-fw fa-dashboard"></i> <a href="/admin/dashboard.aspx">Dashboard</a>
                        </li>
                        <li>
                            <i class="fa fa-newspaper-o"></i> <a href="/admin/blogs/">Blogs</a>
                        </li>
                        <li class="active">
                            <i class="fa fa-edit"></i> Edit Blog
                        </li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
	<div class="row">
		<div class="col-lg-10"></div>
		<div class="col-lg-2">
		</div>
	</div>
    <div class="row">
        <div class="col-lg-6">
            <div class="table-responsive">
                <div class="form-group input-group">
					<span class="input-group-addon">Title</span>
                    <asp:TextBox ID="blogTitle" runat="server" CssClass="form-control" TabIndex="0" Width="100%"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="blogTitle" ValidationGroup="InputCheck" ErrorMessage="Blog Title is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
				<div class="form-group input-group">
					<span class="input-group-addon">Slug Link</span>
                    <asp:TextBox ID="slugLink" runat="server" CssClass="form-control" TabIndex="0" Width="100%"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="slugLink" ValidationGroup="InputCheck" ErrorMessage="Slug Link is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
				
				<div class="form-group input-group">
					<span class="input-group-addon">Publish date:</span>						
					<asp:TextBox runat="server" CssClass="form-control" type="date" ID="pub_date"/>
					<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="pub_date" ValidationGroup="InputCheck" ErrorMessage="Publish Date is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
				</div>
				<div class="form-group input-group">
					<span class="input-group-addon">Description:</span>
                    <asp:TextBox ID="blogDesc" runat="server" CssClass="form-control"  TabIndex="0" Width="100%"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="blogDesc" ValidationGroup="InputCheck" ErrorMessage="Blog Description is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
				
				
				<div class="form-group input-group">
					<span class="input-group-addon">Category</span>
					<asp:DropDownList ID="blogCatDropDownList" runat="server" CssClass="form-control" Width="100%">
					</asp:DropDownList>
                </div>
				
                <div class="form-group">
                    <asp:TextBox id="txtBody" TextMode="multiline" CssClass="main-editor" Columns="50" Rows="5" runat="server" />
                </div>
				
				<div class="form-group input-group">
					<span class="input-group-addon">Select a Status</span>
					<asp:DropDownList ID="status" runat="server" CssClass="form-control" Width="100%">
						<asp:ListItem Text="Publish" Value="1"/>
						<asp:ListItem Text="Unpublish" Value="0"/>
					</asp:DropDownList>
                </div>
            </div>
        
            <div class="form-group">&nbsp;</div>
			<div class="form-group"></div>
            <div class="form-group">
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-danger pull-right" TabIndex="7" OnClick="btnCancel_Click" />
                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary pull-right" style="margin-right:10px" ValidationGroup="InputCheck" OnClick="btnSave_Click"/>
                <div class="clearfix"></div>
            </div>
            <div class="form-group">&nbsp;</div>
        </div>
    </div>
</asp:Content>
