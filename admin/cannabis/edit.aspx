<%@ Page Language="C#" Title="Update Cannabis Page" MasterPageFile="~/admin/Site.Master" AutoEventWireup="true" CodeFile="edit.aspx.cs" Inherits="cannabis_edit" ValidateRequest="false" debug="true"%>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
	<style>
		.panel { position:relative }
		.panel-body { 
			max-height:320px;
			overflow: auto;
		}
		a { cursor:pointer }
	</style>
    <script type="text/javascript">
        function relocate(url) {
            location.replace(url);
        }
		
		function changeimage(){
			$(".current_thumb").hide("fast");
			$(".upload_image").show("fast");
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
			
			$(".list-group-item").click(function() {
				$(".loadingBox").show();
				var stateID = $(this).data("id");
				var stateName = $(this).text();
				$("#hiddenState").val(stateID);
				loadProducts(stateID, stateName);
			});
			
			$("#addProdBtn").click(function(e) {
				e.preventDefault();
				var stateID = $("#hiddenState").val();
				var part = $("#addPartNum").val();
				var stateName = $(".panel-title").text();
				
				$(".loadingBox").show();
				
				if (part != "") {
					$.ajax({
						url: 'edit.aspx/addProduct',
						type: "POST",
						data: JSON.stringify({ state: stateID, partNum: part }),
						contentType: "application/json; charset=utf-8",
						dataType: "json",
						success: function (data) {
							loadProducts(stateID, stateName);
						},
						error: function (request, status, error) {
							alert(request.responseText);
						}
					});
				}
			})
		});
		
		function loadProducts(stateID, stateName) {
			$.ajax({
				url: 'edit.aspx/getProducts',
				type: "POST",
				data: JSON.stringify({ state: stateID }),
				contentType: "application/json; charset=utf-8",
				dataType: "json",
				success: function (data) {
					$("#prodTable").html(data.d);
					$(".panel-title").text(stateName);
					$(".panel").removeClass("hidden").fadeIn("slow");
					$(".loadingBox").fadeOut("fast");
				},
				error: function (request, status, error) {
					alert(request.responseText);
				}
			});
		}
		function checkSlug(slug) {
			$.ajax({
				url: 'edit.aspx/CheckSlug',
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
                        <strong>Successfully</strong> updated the <strong>Cannabis Page Item!!</strong>
                    </div>
                </div>
				<% }else if (Request.QueryString["failed"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-danger alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Opps!</strong> something went wrong in updating the <strong>Cannabis Page Item!!</strong>
                    </div>
                </div>	
				<% }%>
                <div class="col-lg-12">
                    <h1 class="page-header">
                        Edit Cannabis Page
                    </h1>
                    <ol class="breadcrumb">
						<li>
                            <i class="fa fa-fw fa-dashboard"></i> <a href="/admin/dashboard.aspx">Dashboard</a>
                        </li>
                        <li>
                            <i class="fa fa-pagelines"></i> <a href="/admin/cannabis/">Cannabis Page</a>
                        </li>
                        <li class="active">
                            <i class="fa fa-edit"></i> Edit Cannabis Page 
                        </li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
	
  
	<div class="row">
		<% if (Request.QueryString["id"] != "1") {%>
        <div class="col-lg-6">
		<% } else {%>
		<div class="col-lg-12">
		<% }%>
             <div class="table-responsive">
				<% if (Request.QueryString["id"] != "1") {%>
                <div class="form-group">
                    <asp:TextBox ID="title" runat="server" CssClass="form-control" placeholder="Cannabis Page" TabIndex="0" Width="100%"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="title" ValidationGroup="InputCheck" ErrorMessage="Title is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
				<div class="form-group">
                    <asp:TextBox ID="slug" runat="server" CssClass="form-control" placeholder="URL pathname" TabIndex="0" Width="100%"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvSLug" runat="server" ControlToValidate="title" ValidationGroup="InputCheck" ErrorMessage="URL pathname is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
				<% }%>
				<div class="form-group">
                    <asp:TextBox id="txtBody" TextMode="multiline" CssClass="main-editor" Columns="50" Rows="5" runat="server" />
                </div>
				<div class="form-group">
                    <asp:TextBox ID="FlyerTitle" runat="server" CssClass="form-control" placeholder="Flyer Title" TabIndex="0" Width="100%"></asp:TextBox>
                    
                </div>
				<div class="form-group">
                    <asp:TextBox ID="FlyerLink" runat="server" CssClass="form-control" placeholder="Flyer Link" TabIndex="0" Width="100%"></asp:TextBox>
                    
                </div>
				<div class="upload_image form-group input-group" style="display:none;">
					<span class="input-group-addon">Cannabis Page Image</span>
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
		<% if (iID == "71") {%>
		<div class="col-lg-6">
			<div class="table-responsive">
				<asp:ListView ID="lvcannabisTable" runat="server" DataSourceID="tblStates">
                    <LayoutTemplate>
                        <div runat="server" id="itemPlaceHolder" class="list-group"></div>
                    </LayoutTemplate>
                    <ItemTemplate>
						<a class="list-group-item" data-id="<%# Eval("id")%>" ><%# Eval("name").ToString() %></a>
                    </ItemTemplate>
                </asp:ListView> 
				<br /><br />
				<div class="panel panel-default hidden">
					<div class="loadingBox"><div class="gear"></div></div>
					<div class="panel-heading">
						<h3 class="panel-title"></h3>
						<input id="hiddenState" type="hidden" value="" />
					</div>
					<div class="panel-body">
						<div class="form-group input-group">
							<input type="text" id="addPartNum" placeholder="Add Product Part Number" class="form-control" />
							<span class="input-group-btn"><a id="addProdBtn" class="btn btn-success">Add</a></span>
                        </div>
						<div id="prodTable">
							
						</div>
					</div>
				</div>
			</div>
		</div>
		<% }%>
    </div>
	<asp:SqlDataSource ID="tblStates" runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiprep %>" SelectCommand="SELECT * FROM certiPesticidesResidueState"></asp:SqlDataSource>
</asp:Content>
