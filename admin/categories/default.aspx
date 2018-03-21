<%@ Page Language="C#" Title="Categories" MasterPageFile="~/admin/Site.Master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="news_items" debug="true"%>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <script type="text/javascript">
		$(document).ready(function() {
			$(".langSelect option").removeAttr("selected");
			
			$(".langSelect").val("<%=currRegion%>");
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
                        Categories <small><input type="button" class="btn btn-primary" onclick="relocate('/admin/categories/add.aspx')" value="Add New" /></small>
                    </h1>
                    <ol class="breadcrumb">
						<li>
                            <i class="fa fa-fw fa-dashboard"></i> <a href="/admin/dashboard.aspx">Dashboard</a>
                        </li>
                        <li class="active">
                            <i class="fa fa-database"></i> Categories
                        </li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
	<div class="row">
		<div class="col-lg-12">
			<div class="form-group">
				<asp:Button ID="btnInOrg" runat="server" Text="Inorganic Standards" CssClass="btn btn-primary" TabIndex="7" OnClick="btnInOrg_Click" />
				<asp:Button ID="btnOrg" runat="server" Text="Organic Standards" CssClass="btn btn-primary" TabIndex="7" OnClick="btnOrg_Click" />
			</div>
		</div>
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
			<div class="form-group input-group" style="display:none">
                <span class="input-group-addon">Language</span>                  
                <asp:DropDownList ID="ddlLang" runat="server" AutoPostBack="True" CssClass="form-control langSelect"  DataSourceID="TableCulture" DataTextField="displayname" DataValueField="id" OnSelectedIndexChanged="ddlLang_SelectedIndexChanged">
                    
                </asp:DropDownList>
            </div>
		</div>
    </div>
    <div class="row">
		
        <div class="col-lg-12">
            <div class="table-responsive">
				<div id="inorgTech" runat="server">
					<asp:ListView ID="lvNewsTable" runat="server">
						<LayoutTemplate>
							<table class="table table-bordered table-hover table-striped">
								<thead>
									<tr>
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
							<tr id="Tr<%#Eval("cfID") %>">
								<td><a href="/admin/categories/edit.aspx?itech=<%#Eval("cfID") %>" title="Edit"><%# Regex.Replace(Eval("cfFamily").ToString(), @"<[^>]+>|&nbsp;", "").Trim() %></a></td>
								<td class="text-center">
									<a href="/admin/categories/edit.aspx?itech=<%#Eval("cfID") %>" title="Edit"><i class="fa fa-edit"></i></a>
								</td>
							</tr>
						</ItemTemplate>
					</asp:ListView> 
					<asp:DataPager ID="DataPager1" runat="server" PagedControlID="lvNewsTable" QueryStringField="page" class="pagination" PageSize="25">
						<Fields>
							<asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
							<asp:NumericPagerField />
							<asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
						</Fields>
					</asp:DataPager>
				</div>
				
				<div id="orgTech" runat="server">
					<asp:ListView ID="lvOrgTech" runat="server" DataSourceID="dataOrgTech">
						<LayoutTemplate>
							<table class="table table-bordered table-hover table-striped">
								<thead>
									<tr>
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
							<tr id="Tr<%#Eval("CatID") %>">
								<td><a href="/admin/categories/edit.aspx?otech=<%#Eval("CatID") %>" title="Edit"><%# Regex.Replace(Eval("CatLong").ToString(), @"<[^>]+>|&nbsp;", "").Trim() %></a></td>
								<td class="text-center">
									<a href="/admin/categories/edit.aspx?otech=<%#Eval("CatID") %>" title="Edit"><i class="fa fa-edit"></i></a>
								</td>
							</tr>
						</ItemTemplate>
					</asp:ListView> 
					<asp:DataPager ID="DataPager2" runat="server" PagedControlID="lvOrgTech" QueryStringField="page" class="pagination" PageSize="25">
						<Fields>
							<asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
							<asp:NumericPagerField />
							<asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
						</Fields>
					</asp:DataPager>
				</div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="TableContent" runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiprep %>" SelectCommand="SELECT cfID, cfFamily FROM cp_roi_Families WHERE cfTypeID = 2">
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="dataOrgTech" runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiprep %>" SelectCommand="SELECT CatID, CatLong FROM cp_roi_AnTechs">
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="TableCulture" runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiprep %>" SelectCommand="SELECT * FROM sp_Culture"></asp:SqlDataSource>
	
</asp:Content>
