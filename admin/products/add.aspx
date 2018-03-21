<%@ Page Language="C#" Title="New Accessory" MasterPageFile="~/admin/Site.Master" AutoEventWireup="true" CodeFile="add.aspx.cs" Inherits="news_edit" ValidateRequest="false" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <script type="text/javascript">
		$(document).ready(function() {	
			
			$(".checkController input").each(function(){
				if ($(this).prop("checked") == true) {
					var eqID = $(this).attr("id");
					checkSelectedBox(eqID);
				}
			});
			
			$(".checkController input").click(function(){
				var eqID = $(this).attr("id");
				checkSelectedBox(eqID);
			});
			
		});
		
		function checkSelectedBox(eqID) {
			$("#accChkBox input").each(function(){
				if ($(this).val() == eqID) {
					if ($(this).prop("checked") == true) {
						$(this).prop("checked", false);
					}else {
						$(this).prop("checked", true);
					}
					//console.log("accChkBox: " + $(this).val() + " | checkController: " + eqID);
				}
			});
		}
		
        function relocate(url) {
            location.replace(url);
        }
		
		
		tinymce.init({
			selector: '.content-editor',  // change this value according to your html
			content_css : '/css/content.min.css',
			plugins: "code",
			forced_root_block : "", 
			menu : {
				tools: {title: 'Tools', items: 'spellchecker'}
			},
			toolbar: [
				'undo redo | code'
			]
		});
    </script>
    <section class="featured">
        <div class="content-wrapper">
            <div class="row">
				<div id="result"></div>
				<% if (Request.QueryString["success"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-success alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Successfully</strong> created the <strong>Accessory!!</strong>
                    </div>
                </div>
				<% }else if (Request.QueryString["failed"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-danger alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Opps!</strong> something went wrong in creating the <strong>Accessory!!</strong>
                    </div>
                </div>	
				<% }%>
                <div class="col-lg-12">
                    <h1 class="page-header">
                        New Accessory
                    </h1>
                    <ol class="breadcrumb">
						<li>
                            <i class="fa fa-fw fa-dashboard"></i> <a href="/admin/dashboard.aspx">Dashboard</a>
                        </li>
                        <li>
                            <i class="fa fa fa-diamond"></i> <a href="/admin/accessories/">Accessories</a>
                        </li>
                        <li class="active">
                            <i class="fa fa-plus-square"></i> New Accessory
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
        <div class="col-lg-12">
            <div class="table-responsive">
                <div class="form-group input-group">
                    <span class="input-group-addon">Part Number</span>
                    <asp:TextBox ID="txtPart" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
					<asp:RequiredFieldValidator ID="RequiredFieldValidator" runat="server" ControlToValidate="txtPart" ValidationGroup="InputCheck" ErrorMessage="Part Number is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group input-group">
                    <span class="input-group-addon">Product Name</span>
					<asp:TextBox ID="txtName" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
					<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" ValidationGroup="InputCheck" ErrorMessage="Product Name is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
				<div class="form-group input-group">
                    <span class="input-group-addon">Description</span>
					<asp:TextBox id="txtDesc" TextMode="multiline" CssClass="main-editor" Columns="50" Rows="5" runat="server" />
                </div>
				<div class="form-group input-group">
                    <span class="input-group-addon">Product Type</span>
					<asp:DropDownList ID="ddlProdType" runat="server" CssClass="form-control" DataSourceID="dataProdTypes" DataTextField="AccessoryProductTypeDesc" DataValueField="AccessoryProductTypeID">
						<asp:ListItem Text="Select Product Type" Value=""/>
					</asp:DropDownList>
                </div>
				<div class="form-group input-group">
					<span class="input-group-addon">Product Level</span>
					<asp:DropDownList ID="ddlProdLvl" runat="server" CssClass="form-control">
						<asp:ListItem Text="Select Product Level" Value="0"/>
						<asp:ListItem Text="XRF Accessories" Value="2"/>
						<asp:ListItem Text="Equipment Accessories" Value="3"/>
					</asp:DropDownList>
                </div>
				 <asp:CheckBoxList ID="accChkBox" runat="server" style="display:none"></asp:CheckBoxList>
				<asp:Placeholder ID="accCheckList" runat="server" />
            </div>
			<div class="table-responsive">
				<table class="table table-bordered table-striped">
					<tr>
						<th>Main Image</th>
						<th>Full Image</th>
					</tr>
					<tr>
						<td>
							<div class="main_image_upload1">
								<asp:FileUpload ID="image_upload1" runat="server" CssClass="form-control" />
							</div>
						</td>
						<td>
							<div class="full_image_upload1">
								<asp:FileUpload ID="full_upload1" runat="server" CssClass="form-control" />
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="col-lg-12">
            <div class="form-group">&nbsp;</div>
			<div class="form-group"></div>
            <div class="form-group fixed-controls">
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-danger pull-right" TabIndex="7" OnClick="btnCancel_Click" />
                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary pull-right" style="margin-right:10px" ValidationGroup="InputCheck" OnClick="btnSave_Click" />
                <div class="clearfix"></div>
            </div>
            <div class="form-group">&nbsp;</div>
        </div>
    </div>
	<asp:SqlDataSource ID="dataProdTypes" runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>"></asp:SqlDataSource>
</asp:Content>
