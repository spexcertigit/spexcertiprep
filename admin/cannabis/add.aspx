<%@ Page Language="C#" Title="Add Cannabis" MasterPageFile="~/admin/Site.Master" AutoEventWireup="true" CodeFile="add.aspx.cs" Inherits="cannabis_page" ValidateRequest="false" debug="true" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <script type="text/javascript">
        function relocate(url) {
            location.replace(url);
        }
		$(document).ready(function() {
			$("#title").change(function() {
				var slug = $.trim($("#title").val().toLowerCase()).replace(/ /g, "-");
				if ($("#slug").val() == "") {
					checkSlug(slug);
				}
			});
			
			$("#slug").change(function() {
				var slug = $(this).val();
				checkSlug(slug);
			});
		});
		
		function checkSlug(slug) {
			$.ajax({
				url: 'add.aspx/CheckSlug',
				type: "POST",
				data: JSON.stringify({ slugval: slug }),
				contentType: "application/json; charset=utf-8",
				dataType: "json",
				success: function (data) {
					$("#slug").val(data.d);
				},
				error: function (request, status, error) {
					alert(request.responseText);
				}
			});
				
		}
    </script>
    <section class="featured">
        <div class="content-wrapper">
            <div class="row">
				<% if (Request.QueryString["success"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-success alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Successfully</strong> created <strong>Cannabis Page!!</strong>
                    </div>
                </div>
				<% }else if (Request.QueryString["failed"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-danger alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Opps!</strong> something went wrong in creating <strong>Cannabis Page!!</strong>
                    </div>
                </div>	
				<% }%>
                <div class="col-lg-12">
                    <h1 class="page-header">
                        Add New Cannabis Page
                    </h1>
                    <ol class="breadcrumb">
						<li>
                            <i class="fa fa-fw fa-dashboard"></i> <a href="/admin/dashboard.aspx">Dashboard</a>
                        </li>
                        <li>
                            <i class="fa fa-pagelines"></i> <a href="/admin/cannabis/">Cannabis Pages</a>
                        </li>
                        <li class="active">
                            <i class="fa fa-plus-square"></i> Add New Cannabis Page
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
                    <asp:TextBox ID="title" runat="server" CssClass="form-control" placeholder="Cannabis Page" TabIndex="0" Width="100%"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="title" ValidationGroup="InputCheck" ErrorMessage="Title is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
				<div class="form-group">
                    <asp:TextBox ID="slug" runat="server" CssClass="form-control" placeholder="URL pathname" TabIndex="0" Width="100%"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvSLug" runat="server" ControlToValidate="title" ValidationGroup="InputCheck" ErrorMessage="URL pathname is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
				<div class="form-group">
                    <asp:TextBox id="txtBody" TextMode="multiline" CssClass="main-editor" Columns="50" Rows="5" runat="server" />
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