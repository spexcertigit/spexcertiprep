<%@ Page Language="C#" Title="New Event or Notification Banner" MasterPageFile="~/admin/Site.Master" AutoEventWireup="true" CodeFile="add.aspx.cs" Inherits="banners_add" ValidateRequest="false" debug="true" %>

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
                        <strong>Successfully</strong> created <strong>Notification Banner Item!!</strong>
                    </div>
                </div>
				<% }else if (Request.QueryString["failed"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-danger alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Opps!</strong> something went wrong in creating <strong>Notification Banner Item!!</strong>
                    </div>
                </div>	
				<% }%>
                <div class="col-lg-12">
                    <h1 class="page-header">
                        Add New Notification Banner Item
                    </h1>
                    <ol class="breadcrumb">
						<li>
                            <i class="fa fa-fw fa-dashboard"></i> <a href="/admin/dashboard.aspx">Dashboard</a>
                        </li>
                        <li>
                            <i class="fa fa-bullhorn"></i> <a href="/admin/banners/">Notification Banner</a>
                        </li>
                        <li class="active">
                            <i class="fa fa-plus-square"></i> Add New Notification Banner Item
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
                    <asp:TextBox ID="title" runat="server" CssClass="form-control" placeholder="Banner Title" TabIndex="0" Width="100%"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="title" ValidationGroup="InputCheck" ErrorMessage="Title is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
				<div class="form-group">
					<asp:CheckBox id="setFeatured" runat="server" Text="Set this banner on homepage" Checked="FALSE"/>
				</div>
				<div class="form-group">
                    <asp:TextBox id="txtBody" TextMode="multiline" CssClass="main-editor" Columns="50" Rows="5" runat="server" />
                </div>
				<div class="form-group input-group">
					<span class="input-group-addon">Thumbnail:</span>
					<asp:FileUpload ID="FileUpload2" runat="server" CssClass="form-control" />	
				</div>
				<span >(Prefered image size: 183px/91px)</span>
				
			
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