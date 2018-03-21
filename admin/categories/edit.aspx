<%@ Page Language="C#" Title="Update Categories" MasterPageFile="~/admin/Site.Master" AutoEventWireup="true" CodeFile="edit.aspx.cs" Inherits="news_edit" ValidateRequest="false" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <script type="text/javascript">
		$(document).ready(function() {	
			$(".langSelect option").removeAttr("selected");
			
			$(".langSelect").val("<%=currRegion%>");
			
			$(".langSelect").change(function() {
				relocate("/admin/news-and-events/edit.aspx?id=<%=iID%>&lang=" + $(this).val())
			});
		});
        function relocate(url) {
            location.replace(url);
        }
		function changeBg(){
			$(".currentBg").hide("fast");
			$(".uploadBg").show("fast");
		}
    </script>
    <section class="featured">
        <div class="content-wrapper">
            <div class="row">
				<% if (Request.QueryString["success"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-success alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Successfully</strong> updated the <strong>Category!!</strong>
                    </div>
                </div>
				<% }else if (Request.QueryString["failed"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-danger alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Opps!</strong> something went wrong in updating the <strong>Category!!</strong>
                    </div>
                </div>	
				<% }%>
                <div class="col-lg-12">
                    <h1 class="page-header">
                        Edit Category
                    </h1>
                    <ol class="breadcrumb">
						<li>
                            <i class="fa fa-fw fa-dashboard"></i> <a href="/admin/dashboard.aspx">Dashboard</a>
                        </li>
                        <li>
                            <i class="fa fa-database"></i> <a href="/admin/categories/">Categories</a>
                        </li>
                        <li class="active">
                            <i class="fa fa-edit"></i> Edit Category
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
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="Display Title" Width="100%"></asp:TextBox>
					<small><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTitle" ValidationGroup="InputCheck" ErrorMessage="Title is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></small>
                </div>
				<div class="form-group input-group">
                    <span class="input-group-addon">Permalink</span>
                    <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control" placeholder="Permalink" Width="100%"></asp:TextBox>
					<small><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtSlug" ValidationGroup="InputCheck" ErrorMessage="This field is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></small> 
                </div>
                <div class="form-group input-group">
                    <span class="input-group-addon">Body</span>
					<asp:TextBox id="txtBody" TextMode="multiline" CssClass="main-editor" Columns="50" Rows="5" runat="server" />
                </div>
            </div>
            <div class="form-group">&nbsp;</div>
			<div class="form-group"></div>
            <div class="form-group">
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-danger pull-right" TabIndex="7" OnClick="btnCancel_Click" />
                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary pull-right" style="margin-right:10px" ValidationGroup="InputCheck" OnClick="btnSave_Click" />
                <div class="clearfix"></div>
            </div>
            <div class="form-group">&nbsp;</div>
        </div>
    </div>
</asp:Content>
