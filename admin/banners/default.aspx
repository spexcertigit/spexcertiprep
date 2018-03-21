<%@ Page Language="C#" Title="banners" MasterPageFile="~/admin/Site.Master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="banners_items" debug="true" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <script type="text/javascript">
        function relocate(url) {
            location.replace(url);
        }
		function confirmation(id) {
			var answer = confirm("Are you sure you want to delete this item?")
			if (answer){
				//alert("DELETE!")
				$.ajax({
					url: 'default.aspx/deleteItem',
					type: "POST",
					data: JSON.stringify({ bannersid: id }),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						$('#Tr'+id).remove();
						$('#del-msg').slideDown('slow').delay(1000).slideUp('slow');
					},
					error: function (request, status, error) {
						alert(request.responseText);
					}
				});
			}
		}
    </script>
	<style>
		td { vertical-align:middle !important; }
	</style>
    <section class="featured">
		<div id="result" >
		<div id='del-msg' style="display: none;" class='alert alert-success alert-dismissable bg-success'><button type='button' class='close' data-dismiss='alert' aria-hidden='true'>×</button>Notification banner item has been Deleted</div>
		</div>
        <div class="content-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        Notification Banner <small><input type="button" class="btn btn-primary" onclick="relocate('/admin/banners/add.aspx')" value="Add New" /></small>
                    </h1>
                    <ol class="breadcrumb">
						<li>
                            <i class="fa fa-fw fa-dashboard"></i> <a href="/admin/dashboard.aspx">Dashboard</a>
                        </li>
                        <li class="active">
                            <i class="fa fa-bullhorn"></i> Notification Banner
                        </li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
	<div class="row">
		<div class="col-lg-3">
            <div class="form-group input-group">
                <span class="input-group-addon">Display</span>                  
                <asp:DropDownList ID="ddlDisplay" runat="server" AutoPostBack="True" CssClass="form-control" OnSelectedIndexChanged="ddlDisplay_SelectedIndexChanged" Width="75px">
                    <asp:ListItem>25</asp:ListItem>
                    <asp:ListItem>50</asp:ListItem>
                    <asp:ListItem>75</asp:ListItem>
                    <asp:ListItem>100</asp:ListItem>
                    <asp:ListItem>125</asp:ListItem>
                    <asp:ListItem>150</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
        <div class="col-lg-7"></div>
        <div class="col-lg-2">
		</div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="table-responsive">
                <asp:ListView ID="lvbannersTable" runat="server">
                    <LayoutTemplate>
                        <table class="table table-bordered table-hover table-striped">
                            <thead>
                                <tr>
									<th style="width:10%;">Status</th>                               									
									<th>Title</th>
									<th>Image</th>
									<th style="width:10%;">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr runat="server" id="itemPlaceHolder"></tr>
                            </tbody>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr id="Tr<%#Eval("id") %>">
							<td style="text-align:center; font-size:18px; "><%#Eval("setValue") %></td>
                            <!--<td><%# Regex.Replace(Eval("id").ToString(), @"<[^>]+>|&nbsp;", "").Trim() %></td>-->
							<td><a href="/admin/banners/edit.aspx?id=<%#Eval("id") %>" title="Edit"><%#Eval("title") %></a></td>
							<td class="text-center">
								<img src="../../notification-banner/uploads/<%# (Eval("thumb").ToString() == "") ? "defaultnews.jpg" : Eval("thumb").ToString() %>" alt="<%#Eval("thumb").ToString() %>" style="width:auto; max-width:571px; height:auto; max-height:38px;" />
							</td>
							<td class="text-center">
								<a href="/admin/banners/edit.aspx?id=<%#Eval("id") %>" title="Edit"><i class="fa fa-edit"></i></a>
								&nbsp;&nbsp;
								<a onclick="confirmation('<%#Eval("id") %>')" class="red-del" title="Delete"><i class="fa fa-eraser"></i></a>
							</td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>    
            </div>
        </div>
    </div>
   
	<asp:DataPager ID="DataPager1" runat="server" PagedControlID="lvbannersTable" QueryStringField="page" class="pagination" PageSize="25">
        <Fields>
            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
            <asp:NumericPagerField />
            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
        </Fields>
    </asp:DataPager>
	
</asp:Content>
