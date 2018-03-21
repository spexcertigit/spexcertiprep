<%@ Page Language="C#" Title="Pages" MasterPageFile="~/admin/Site.Master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="careers_items" debug="true" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <script type="text/javascript">
        function relocate(url) {
            location.replace(url);
        }
		/*function confirmation(id) {
			var answer = confirm("Are you sure you want to delete this item?")
			if (answer){
				//alert("DELETE!")
				$.ajax({
					url: 'default.aspx/deleteItem',
					type: "POST",
					data: JSON.stringify({ careersid: id }),
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
		}*/
    </script>
    <section class="featured">
		<div id="result"></div>
        <div class="content-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                       <i class="fa fa-files-o"></i> Pages <small><input type="button" class="btn btn-primary" onclick="relocate('/admin/pages/add.aspx')" value="Add New" /></small>
                    </h1>
                    <ol class="breadcrumb">
						<li>
                            <i class="fa fa-fw fa-dashboard"></i> <a href="/admin/dashboard.aspx">Dashboard</a>
                        </li>
                        <li class="active">
                            <i class="fa fa-files-o"></i> Pages
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
                <asp:ListView ID="EditPageTable" runat="server">
                    <LayoutTemplate>
                        <table class="table table-bordered table-hover table-striped">
                            <thead>
                                <tr>
									<th>Status</th>                                    									
									<th>Title</th>
									
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
							<td class="text-center" style="font-size:20px; width:10%">
								<%# (Eval("active").ToString() == "True") ? "<i class='fa fa-toggle-on' style='color:green' title='Active'></i>" : "<i class='fa fa-toggle-off' style='color:#B73333' title='Inactive'></i>" %>
							</td>
                            <!--<td><%# Regex.Replace(Eval("id").ToString(), @"<[^>]+>|&nbsp;", "").Trim() %></td>-->
							<td><a href="/admin/pages/edit.aspx?id=<%#Eval("id") %>" title="Edit"><%#Eval("name") %></a></td>
							
							<td class="text-center">
								<a href="/admin/pages/edit.aspx?id=<%#Eval("id") %>" title="Edit"><i class="fa fa-edit"></i></a>
								<!--&nbsp;&nbsp;
								<a onclick="confirmation('<%#Eval("id") %>')" class="red-del" title="Delete"><i class="fa fa-eraser"></i></a>-->
							</td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>    
            </div>
        </div>
    </div>
   <asp:SqlDataSource ID="dataPages" runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiprep %>" SelectCommand="SELECT id, name, active FROM cpPages ORDER BY name ASC"></asp:SqlDataSource>
   
	<asp:DataPager ID="DataPager1" runat="server" PagedControlID="EditPageTable" QueryStringField="page" class="pagination" PageSize="25">
        <Fields>
            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
            <asp:NumericPagerField />
            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
        </Fields>
    </asp:DataPager>
	
</asp:Content>
