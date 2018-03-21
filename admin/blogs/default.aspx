<%@ Page Language="C#" Title="Blogs" MasterPageFile="~/admin/Site.Master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="blogs_items" debug="true" %>

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
					data: JSON.stringify({ blogsid: id }),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						$('#result').html(data.d);
						$('#Tr'+id).remove();
					},
					error: function (request, status, error) {
						alert(request.responseText);
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
                        Blogs <small><input type="button" class="btn btn-primary" onclick="relocate('/admin/blogs/add.aspx')" value="Add New" /></small>
                    </h1>
                    <ol class="breadcrumb">
						<li>
                            <i class="fa fa-fw fa-dashboard"></i> <a href="/admin/dashboard.aspx">Dashboard</a>
                        </li>
                        <li class="active">
                            <i class="fa fa-newspaper-o"></i> Blogs
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
                <asp:ListView ID="lvBlogsTable" runat="server">
                    <LayoutTemplate>
                        <table class="table table-bordered table-hover table-striped">
                            <thead>
                                <tr>
									                                    									
									<th>Title</th>
									<th>Category</th>
									<th style="width:10%;">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr runat="server" id="itemPlaceHolder"></tr>
                            </tbody>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr id="Tr<%#Eval("PostID") %>">
							
                            <!--<td><%# Regex.Replace(Eval("PostID").ToString(), @"<[^>]+>|&nbsp;", "").Trim() %></td>-->
							<td><%#Eval("Title") %></td>
							<td class="text-center">
								<%#Eval("CategoryName") %>
							</td>
							 <td class="text-center">
								<a href="/admin/blogs/edit.aspx?id=<%#Eval("PostID") %>" title="Edit"><i class="fa fa-edit"></i></a>
								&nbsp;&nbsp;
								<a onclick="confirmation('<%#Eval("PostID") %>')" class="red-del" title="Delete"><i class="fa fa-eraser"></i></a>
							</td>
							
                            
                        </tr>
                    </ItemTemplate>
                </asp:ListView>    
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="TableContent" runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiprep %>" SelectCommand="SELECT a.Title, a.PostID, c.CategoryName FROM cms_BlogPost as a LEFT JOIN cms_BlogPost_Category_xref as b on a.PostID = b.PostID LEFT JOIN cms_BlogCategory as c on b.CategoryID =  c.CategoryID WHERE a.IsDeleted = 'false' ORDER BY a.PublishDate DESC">
	</asp:SqlDataSource>
	
	<asp:DataPager ID="DataPager1" runat="server" PagedControlID="lvBlogsTable" QueryStringField="page" class="pagination" PageSize="25">
        <Fields>
            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
            <asp:NumericPagerField />
            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
        </Fields>
    </asp:DataPager>
	
</asp:Content>
