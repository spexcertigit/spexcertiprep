<%@ Page Language="C#" Title="New Page" MasterPageFile="~/admin/Site.Master" AutoEventWireup="true" CodeFile="add.aspx.cs" Inherits="career_add" ValidateRequest="false" debug="true" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <section class="featured">
        <div class="content-wrapper">
            <div class="row">
				<% if (Request.QueryString["success"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-success alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Successfully</strong> created new <strong>Page!!</strong>
                    </div>
                </div>
				<% }else if (Request.QueryString["failed"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-danger alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Opps!</strong> something went wrong in creating new <strong>Page!!</strong>
                    </div>
                </div>	
				<% }%>
                <div class="col-lg-12">
                    <h1 class="page-header">
                       Create new Page
                    </h1>
                    <ol class="breadcrumb">
						<li>
                            <i class="fa fa-fw fa-dashboard"></i> <a href="/admin/dashboard.aspx">Dashboard</a>
                        </li>
                        <li>
                            <i class="fa fa-files-o"></i> <a href="/admin/pages/">Pages</a>
                        </li>
                        <li class="active">
                            <i class="fa fa-plus-square"></i> Create new Page
                        </li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <div class="row">
        <div class="col-lg-10">
            <div class="table-responsive">
                <div class="form-group">
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control btn-lg" placeholder="Page Name" TabIndex="0" Width="100%"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" ValidationGroup="InputCheck" ErrorMessage="Page name is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
					<div class="slug-section hidden">
						<div class="permalink lh29"><b>Permalink:</b> http://<%=HttpContext.Current.Request.Url.Host%>/<span id="locContainer"></span><span id="slugContainer"></span> <button type="button" class="btnEdit btn btn-primary btn-sm">Edit</button></div>
						<div class="slug-form hidden">
							<div class="form-container ddlLocation">
								<asp:DropDownList ID="ddlLocation" runat="server" CssClass="form-control btn-sm">
									<asp:ListItem Text="none" Value=""/>
									<asp:ListItem Text="products" Value="products"/>
									<asp:ListItem Text="purchase-options" Value="purchase-options"/>
									<asp:ListItem Text="knowledge-base" Value="knowledge-base"/>
									<asp:ListItem Text="news-and-events" Value="news-and-events"/>
									<asp:ListItem Text="about-us" Value="about-us"/>
								</asp:DropDownList>
							</div>
							<span class="seperator lh29">/</span>
							<div class="form-container txtSlug">
								<asp:TextBox ID="txtSlug" runat="server" CssClass="form-control btn-sm" placeholder="Location" TabIndex="0"></asp:TextBox>
							</div>&nbsp;&nbsp; 
							<button type="button" class="btnSave btn btn-success btn-sm">Save</button>
							<button type="button" class="btnCancel btn btn-danger btn-sm">Cancel</button>
						</div>
						<div class="clear"></div>
					</div>
                </div>

				<div class="form-group">
                    <div class="form-group input-group">
						<span class="input-group-addon">Page Banner</span>
						<asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" />
					</div>
                </div>
				
				<div class="form-group">
                    <asp:TextBox id="txtExcerpt" TextMode="multiline" CssClass="form-control" placeholder="Short Description" runat="server" Width="100%" style="resize:none"/>
                </div>
				
                <div class="form-group layout-content standard-content">
                    <asp:TextBox id="txtContent1" TextMode="multiline" CssClass="main-editor" Columns="50" Rows="5" runat="server" />
                </div>
				
				<div class="form-group layout-content two_columns-content hidden">
					<asp:TextBox id="txtContent2" TextMode="multiline" CssClass="main-editor" Columns="25" Rows="5" runat="server" />
                </div>
				
				<div class="form-group layout-content three_columns-content hidden">
					<asp:TextBox id="txtContent3" TextMode="multiline" CssClass="main-editor" Columns="25" Rows="5" runat="server" />
                </div>
				
            </div>
			
			<div class="form-group"></div>
            
		
            <div class="form-group">&nbsp;</div>
        </div>
		<div class="col-lg-2">
			<div class="form-group">
				<asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" TabIndex="4" style="width:48.5%" ValidationGroup="InputCheck" OnClick="btnSave_Click"/>
				<asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-danger" TabIndex="6" style="width:48.5%" OnClick="btnCancel_Click" />
				<div class="clear"></div>
            </div>
			
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Page Attributes</h3>
				</div>
				<div class="panel-body">
					<label>Colors</label>
					<div class="form-group">
						<div class="color-picker">
							<div id="bannerBgColor" class="colorSelector"><div style="background-color: #ffffff"></div></div>
							<asp:HiddenField ID="txtBannerBgColor" runat="server" Value="ffffff" />
							<p class="btn-sm" style="padding-top:8px">Banner BG Color</p>
							<div class="clear"></div>
						</div>
					</div>
					<label for="ddlLayout">Layout</label>
					<asp:DropDownList ID="ddlLayout" runat="server" CssClass="form-control btn-sm" Width="100%">
						<asp:ListItem Text="Standard" Value="standard"/>
						<asp:ListItem Text="Full Width" Value="full_width"/>
						<asp:ListItem Text="Sidebar Right" Value="sidebar_right"/>
						<asp:ListItem Text="Two Columns" Value="two_columns"/>
						<asp:ListItem Text="Three Columns" Value="three_columns"/>
					</asp:DropDownList>
					<div class="layout-box text-center">
						<img class="selected-layout" src="/images/layout/standard.png" alt="Standard" />
					</div>
					<div class="form-group">
						<label for="txtOrder">Order</label>
						<asp:TextBox ID="txtOrder" runat="server" CssClass="form-control btn-sm" placeholder="Page Order" Width="100%">0</asp:TextBox>
					</div>
					<div class="form-group input-group">
						<span class="input-group-addon">Status</span>
						<asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control btn-sm" Width="100%">
							<asp:ListItem Text="Inactive" Value="0"/>
							<asp:ListItem Text="Active" Value="1"/>
						</asp:DropDownList>
					</div>
				</div>
			</div>
			
		</div>
    </div>
	
	<div class="row">
		<div class="col-lg-10">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Meta Data</h3>
				</div>
				<div class="panel-body">
					<div class="form-group">
						<asp:TextBox ID="txtMetaTitle" runat="server" CssClass="form-control" placeholder="Meta Title" Width="100%"></asp:TextBox>
					</div>
					<div class="form-group">
						<asp:TextBox ID="txtMetaKeys" runat="server" CssClass="form-control" placeholder="Meta Keys" Width="100%"></asp:TextBox>
					</div>
					<div class="form-group">
						<asp:TextBox ID="txtMetaDesc" TextMode="multiline" runat="server" CssClass="form-control" placeholder="Meta Description" Width="100%"></asp:TextBox>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
        function relocate(url) {
            location.replace(url);
        }
		
		$(document).ready(function() {
			$("#btnSave").click(function() {
				$(".overlay .loadingBox").show();
			});
			
			$("#txtName").change(function() {
				var txtName = $(this).val().trim();
				txtName = txtName.replace(/\s/g, "-").toLowerCase();
				var res = txtName.replace(/[&\/\\#,+()$~%.'":*?<>{}]/g,'-');
				checkSlug(res);
			});
			
			$(".btnEdit").click(function() {
				$("#locContainer").hide();
				$("#slugContainer").hide();
				$(".slug-form").removeClass("hidden");
				$(this).hide();
			});
			
			$(".btnSave").click(function() {
				var loc = $("#ddlLocation").val().trim();
				var slug = $("#txtSlug").val().trim();
				
				if (slug == "") {
					$(".txtSlug").addClass("has-error");
				}else {
					if (loc != "") {
						$("#locContainer").text(loc + "/");
					}else {
						$("#locContainer").text("");
					}
					showPermalink();
				}
			});
			
			$(".btnCancel").click(function() {
				showPermalink();
			});
			
			$("#ddlLayout").change(function() {
				var source = $(this).val();
				var alter = $(this).text();
				$(".selected-layout").attr("src", "/images/layout/" + source + ".png");
				$(".selected-layout").attr("alt", alter);
				
				if (source == "two_columns") {
					$(".three_columns-content").addClass("hidden");
					$(".standard-content").removeClass("hidden");
					$(".two_columns-content").removeClass("hidden");
				}else if (source == "three_columns") {
					$(".layout-content").removeClass("hidden");
				}else {
					$(".layout-content").addClass("hidden");
					$(".standard-content").removeClass("hidden");
				}
			});
			
			$('#bannerBgColor').ColorPicker({
				color: '#ffffff',
				onShow: function (colpkr) {
					$(colpkr).fadeIn(500);
					return false;
				},
				onHide: function (colpkr) {
					$(colpkr).fadeOut(500);
					return false;
				},
				onChange: function (hsb, hex, rgb) {
					$('#bannerBgColor div').css('backgroundColor', '#' + hex);
					$('#txtBannerBgColor').val(hex);
				}
			});
			
		});
		
		function checkSlug(res)  {
			$.ajax({
				url: 'add.aspx/checkSlug',
				type: "POST",
				data: JSON.stringify({ slug: res }),
				contentType: "application/json; charset=utf-8",
				dataType: "json",
				success: function (data) {
					$("#slugContainer").text(data.d);
					$("#txtSlug").val(data.d);
					$(".slug-section").removeClass("hidden");
				}
			});
		}
		function showPermalink() {
			$("#locContainer").show();
			$("#slugContainer").show();
			$(".slug-form").addClass("hidden");
			$(".btnEdit").show();
		}
    </script>
	
</asp:Content>