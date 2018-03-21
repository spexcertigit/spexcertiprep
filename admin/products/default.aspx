<%@ Page Language="C#" Title="Products" MasterPageFile="~/admin/Site.Master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="news_items" debug="true" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <script type="text/javascript">
		$(document).ready(function() {			
			$("#searchBtn").click(function(){
				$("#btnSearch").trigger("click");
			});
		});
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
					data: JSON.stringify({ newsid: id }),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						$('#result').html(data.d);
						$('#Tr'+id).remove();
					}
				});
			}
		}
    </script>
    <section class="featured">
		<div id="result"></div>
        <div class="content-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        Products <small><input type="button" class="btn btn-primary hidden" onclick="relocate('/admin/products/add.aspx')" value="Add New" /></small>
                    </h1>
                    <ol class="breadcrumb">
						<li>
                            <i class="fa fa-fw fa-dashboard"></i> <a href="/admin/dashboard.aspx">Dashboard</a>
                        </li>
                        <li class="active">
                            <i class="fa fa-diamond"></i> Products
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
        <div class="col-lg-4"></div>
		<div class="col-lg-2"></div>
		<div class="col-lg-3">
			<div class="form-group input-group">
				<asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Width="100%" placeholder="Search Product"></asp:TextBox>
				<span class="input-group-btn"><button id="searchBtn" class="btn btn-warning" type="button" style="border-radius: 0 4px 4px 0;"><i class="fa fa-search"></i></button></span>
				<asp:Button ID="btnSearch" runat="server" Text="Save" CssClass="btn btn-primary pull-right" style="margin-right:10px; display:none; " ValidationGroup="InputCheck" OnClick="btnSearch_Click" />
				<asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-danger pull-right" style="margin-left:10px;" OnClick="btnClearSearch_Click" />
			</div>
		</div>
        
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="table-responsive">
                <asp:ListView ID="lvProdTable" runat="server">
                    <LayoutTemplate>
                        <table class="table table-bordered table-hover table-striped">
                            <thead>
                                <tr>
									<th style="width:14%">Part #</th>
                                    <th>Product Name</th>
									<th style="width:8%">Thumbnails</th>
									<th style="width:45%">Description</th>
									<th style="width:13%">Type</th>
                                    <th style="width:5%;">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr runat="server" id="itemPlaceHolder"></tr>
                            </tbody>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr id="Tr<%#Eval("cpID") %>">
							<td class="text-center vcenter" style="font-size:20px">
								<%#Eval("cpPart").ToString().Trim() %>
							</td>
                            <td class="vcenter"><a href="/admin/products/edit.aspx?id=<%#Eval("cpID") %>" title="Edit"><%# Regex.Replace(Eval("cpDescrip").ToString(), @"<[^>]+>|&nbsp;", "").Trim() %></a></td>
							<td class="text-center vcenter">
								<%# getImage(Eval("cpPart").ToString().Trim(), Eval("cpType").ToString().Trim()) %>
							</td>
							<td class="vcenter"><%#Eval("cpLongDescrip") %></td>
							<td class="text-center vcenter"><%# getProdType(Eval("cpType").ToString()) %></td>
                            <td class="text-center vcenter">
								<a href="/admin/products/edit.aspx?id=<%#Eval("cpID") %>" title="Edit"><i class="fa fa-edit"></i></a>
								<a class="hidden" onclick="confirmation('<%#Eval("cpID") %>')" class="red-del" title="Delete"><i class="fa fa-eraser"></i></a>
							</td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>    
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="TableContent" runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" SelectCommand="SELECT * FROM cp_roi_Prods ORDER BY cpID DESC">
	</asp:SqlDataSource>

	<asp:DataPager ID="DataPager1" runat="server" PagedControlID="lvProdTable" QueryStringField="page" class="pagination" PageSize="25">
        <Fields>
            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
            <asp:NumericPagerField />
            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
        </Fields>
    </asp:DataPager>
</asp:Content>
