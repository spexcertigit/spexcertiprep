<%@ Page Language="C#" Title="New FAQs" MasterPageFile="~/admin/Site.Master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="question" ValidateRequest="false" debug="true" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <script type="text/javascript">
        function relocate(url) {
            location.replace(url);
        }
		
		$(document).ready(function() {
			$(".list-group-item").click(function() {
				var id = $(this).data("id");
				if ($("#ans-" + id).hasClass("selected")) {
					$("#ans-" + id).slideToggle().removeClass("selected");
				}else {
					$(".list-group-item").each(function() { $(this).removeClass("selected"); });
					$(".answer-box-container").each(function() {
						if ($(this).hasClass("selected")) {
							$(this).slideToggle();
							$(this).removeClass("selected");
						}
					});
					$("#ans-" + id).slideToggle().addClass("selected");
				}
			});
			
			$(".edit-btn").click(function() {
				var id = $(this).data("id");
				$("#queID").val(id);
				$("#questionID").val($("#que-" + id).text()).focus();
				$("#answer").val($("#answer-" + id).html());
				$("#btnAdd").hide();
				$("#btnSave").show();
				$("#btnCancel").val("Clear");
			});
			
			$("#btnCancel").click(function(e) {
				if ($("#questionID").val() != "") {
					e.preventDefault();
					$("#queID").val("");
					$("#questionID").val("").focus();
					$("#answer").val("");
					$("#btnCancel").val("Cancel");
				}
			});
			
			$(".del-btn").click(function() {
				var id = $(this).data("id");
				var answer = confirm("Are you sure you want to delete this question?")
				if (answer){
					//alert("DELETE!")
					$.ajax({
						url: 'default.aspx/deleteItem',
						type: "POST",
						data: JSON.stringify({ newsid: id }),
						contentType: "application/json; charset=utf-8",
						dataType: "json",
						success: function (data) {
							$('#result').html(data.d);
							$('#que-'+id).remove();
							$('#ans-'+id).remove();
						}
					});
				}
			});
		});
	
    </script>
	<style>
		textarea { width:100%;padding:5px 10px; border-radius:9px; }
		a { cursor:pointer }
	</style>
	
    <section class="featured">
        <div class="content-wrapper">
            <div class="row">
				<% if (Request.QueryString["success"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-success alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Successfully </strong>Added<strong> An "Ask A Chemist" Question!</strong>
                    </div>
                </div>
				<% }else if (Request.QueryString["failed"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-danger alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Opps!</strong> something went wrong in creating new <strong>"Ask A Chemist" Question!!</strong>
                    </div>
                </div>	
				<% }else if (Request.QueryString["saved"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-success alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Successfully </strong>updated<strong> An "Ask A Chemist" Question!</strong>
                    </div>
                </div>	
				<% }%>
                <div class="col-lg-12">
                    <h1 class="page-header">
                        Add "Ask A Chemist" Question 
                    </h1>
                    <ol class="breadcrumb">
						<li>
                            <i class="fa fa-fw fa-dashboard"></i> <a href="/admin/dashboard.aspx">Dashboard</a>
                        </li>
                        <li>
                            <i class="fa fa-Blogpaper-o"></i> <a href="/admin/question/">Add "Ask A Chemist" Question </a>
                        </li>
                        <li class="active">
                            <i class="fa fa-plus-square"></i> Add "Ask A Chemist" Question 
                        </li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <div class="row">
		<div class="col-lg-3"></div>
        <div class="col-lg-12">
            <div class="table-responsive">
				<div class="form-group" >
					<asp:HiddenField ID="queID" runat="server" />
					<asp:TextBox id="questionID" TextMode="multiline" CssClass="form-control" runat="server" placeholder="Question" />
				</div>
				<div class="form-group" >
					<asp:TextBox id="answer" TextMode="multiline" CssClass="form-control" Row="6" runat="server" placeholder="Answer" />
				</div>
					
				<div class="form-group">
					<asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-danger pull-right" TabIndex="6" OnClick="btnCancel_Click" />
					<asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn btn-primary pull-right" TabIndex="4" style="margin-right:10px" ValidationGroup="InputCheck" OnClick="btnAdd_Click"/>   
					<asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-success pull-right" TabIndex="4" style="margin-right:10px;display:none;" ValidationGroup="InputCheck" OnClick="btnSave_Click"/>
					<div class="clearfix"></div>
				</div>
            </div>
        </div>
		<div class="col-lg-3"></div>
    </div>
	<div class="row">
		<div class="col-lg-12">
			<asp:ListView ID="lvQueTable" runat="server" DataSourceID="queTable">
				<LayoutTemplate>
					<div runat="server" id="itemPlaceHolder" class="list-group"></div>
				</LayoutTemplate>
				<ItemTemplate>
					<a id="que-<%# Eval("id")%>" class="list-group-item" data-id="<%# Eval("id")%>"><%# Eval("question")%></a>
					<div id="ans-<%# Eval("id")%>" class="answer-box-container">
						<div id="answer-<%# Eval("id")%>"class="answer-box">
							<%# Eval("answer")%>
						</div>
						<br /><br />
						<span class="pull-right text-muted small">
							<a class="edit-btn btn btn-primary" data-id="<%# Eval("id")%>"><i class="fa fa-fw fa-edit"></i>Edit</a>
							<a class="del-btn btn btn-danger" data-id="<%# Eval("id")%>"><i class="fa fa-fw fa-eraser"></i>Delete</a>
						</span>
						<div class="clear"></div>
					</div>
				</ItemTemplate>
			</asp:ListView> 
		</div>
	</div>
	<div class="row"><br /><br /><br /></div>
	<asp:SqlDataSource ID="queTable" runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiprep %>" SelectCommand="SELECT * FROM AskAChemist ORDER BY id DESC"></asp:SqlDataSource>
</asp:Content>