<%@ Page Language="C#" Title="Distributors" MasterPageFile="~/admin/Site.Master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="news_items" %>

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
                        Distributors <small><input type="button" class="btn btn-primary" onclick="relocate('/admin/distributors/add.aspx')" value="Add New" /></small>
                    </h1>
                    <ol class="breadcrumb">
						<li>
                            <i class="fa fa-fw fa-dashboard"></i> <a href="/admin/dashboard.aspx">Dashboard</a>
                        </li>
                        <li class="active">
                            <i class="fa fa-map-marker"></i> Distributors
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
                <asp:ListView ID="lvNewsTable" runat="server">
                    <LayoutTemplate>
                        <table class="table table-bordered table-hover table-striped">
                            <thead>
                                <tr>
									<th>Country</th>
                                    <th>Company</th>
                                    <th style="width:10%;">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr runat="server" id="itemPlaceHolder"></tr>
                            </tbody>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr id="Tr<%#Eval("DistributorSerial") %>">
                            <td><%#Eval("Country").ToString() %></td>
							<td><%#Eval("Company") %></td>
                            <td class="text-center">
								<a href="/admin/distributors/edit.aspx?id=<%#Eval("DistributorSerial") %>" title="Edit"><i class="fa fa-edit"></i></a>
								&nbsp;&nbsp;
								<a onclick="confirmation('<%#Eval("DistributorSerial") %>')" class="red-del" title="Delete"><i class="fa fa-eraser"></i></a>
							</td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>    
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="TableContent" runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiprep %>" SelectCommand="SELECT * FROM certiDistributor ORDER BY Country">
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="TableCulture" runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiprep %>" SelectCommand="SELECT * FROM sp_Culture"></asp:SqlDataSource>
	<asp:DataPager ID="DataPager1" runat="server" PagedControlID="lvNewsTable" QueryStringField="page" class="pagination" PageSize="25">
        <Fields>
            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
            <asp:NumericPagerField />
            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
        </Fields>
    </asp:DataPager>
</asp:Content>
