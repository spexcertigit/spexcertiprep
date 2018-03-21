<%@ Page Language="C#" Title="Update Notification Banner" MasterPageFile="~/admin/Site.Master" AutoEventWireup="true" CodeFile="edit.aspx.cs" Inherits="banners_edit" ValidateRequest="false" debug="true"%>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <script type="text/javascript">
		$(document).ready(function() {			
			//alert("<%=pubStatus%>");
			//$("#status").val("<%=pubStatus%>");
			
		});
        function relocate(url) {
            location.replace(url);0
        }
		
		function changeimage(){
			$(".current_thumb").hide("fast");
			$(".upload_image").show("fast");
		}
		
		
		
    </script>
    <section class="featured">
        <div class="content-wrapper">
            <div class="row">
				<% if (Request.QueryString["success"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-success alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Successfully</strong> updated the <strong>Notification Banner Item!!</strong>
                    </div>
                </div>
				<% }else if (Request.QueryString["failed"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-danger alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Opps!</strong> something went wrong in updating the <strong>Notification Banner Item!!</strong>
                    </div>
                </div>	
				<% }%>
                <div class="col-lg-12">
                    <h1 class="page-header">
                        Edit Notification Banner
                    </h1>
                    <ol class="breadcrumb">
						<li>
                            <i class="fa fa-fw fa-dashboard"></i> <a href="/admin/dashboard.aspx">Dashboard</a>
                        </li>
                        <li>
                            <i class="fa fa-bullhorn"></i> <a href="/admin/banners/">Notification Banner</a>
                        </li>
                        <li class="active">
                            <i class="fa fa-edit"></i> Edit Notification Banner 
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
                    <asp:TextBox ID="LitName" runat="server" CssClass="form-control" placeholder="Item Name" TabIndex="0" Width="100%"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="LitName" ValidationGroup="InputCheck" ErrorMessage="Title is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
				<div class="form-group">
					<asp:CheckBox id="setFeatured" runat="server" Text="Set this banner on homepage" Checked="FALSE"/>
				</div>
				<div class="form-group">
                    <asp:TextBox id="txtBody" TextMode="multiline" CssClass="main-editor" Columns="50" Rows="5" runat="server" />
                </div>
				<div class="current_thumb form-group input-group">
					<input type="image" name="image" src='../../notification-banner/uploads/<asp:Literal ID="imgAtt" runat="server" />' style="max-height:38px">
					<input type="button" onclick="changeimage()" class="btn btn-default" value="Change" style="margin: 5px"/>
				</div>
				<div class="upload_image form-group input-group" style="display:none;">
					<span class="input-group-addon">Notification Banner Image</span>
					<asp:FileUpload ID="FileUpload2" runat="server" CssClass="form-control" />
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
