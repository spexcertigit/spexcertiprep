<%@ Page Language="C#" Title="Post Survey Results" MasterPageFile="~/admin/Site.Master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="news_items" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <script type="text/javascript">
		$(document).ready(function() {
			$(".langSelect option").removeAttr("selected");
			
			$(".langSelect").val("<%=currRegion%>");
			
			
				function exportTableToCSV($table, filename) {
					var $rows = $table.find('tr:has(td)'),

						// Temporary delimiter characters unlikely to be typed by keyboard
						// This is to avoid accidentally splitting the actual contents
						tmpColDelim = String.fromCharCode(11), // vertical tab character
						tmpRowDelim = String.fromCharCode(0), // null character

						// actual delimiter characters for CSV format
						colDelim = '","',
						rowDelim = '"\r\n"',

						// Grab text from table into CSV formatted string
						csv = '"' + $rows.map(function (i, row) {
							var $row = $(row),
								$cols = $row.find('td');

							return $cols.map(function (j, col) {
								var $col = $(col),
								text = $col.text();

								return text.replace('"', '""'); // escape double quotes

							}).get().join(tmpColDelim);

						}).get().join(tmpRowDelim)
							.split(tmpRowDelim).join(rowDelim)
							.split(tmpColDelim).join(colDelim) + '"',

						// Data URI
						csvData = 'data:application/csv;charset=utf-8,' + encodeURIComponent(csv);

					$(this)
						.attr({
						'download': filename,
							'href': csvData,
							'target': '_blank'
					});
				}
				
				// This must be a hyperlink
				$(".exportToExcel").on('click', function (event) {
					// CSV
					var currentdate = new Date(); 
					var datetime = (currentdate.getMonth()+1)  + "/"
								+  currentdate.getDate() + "/" 
								+ currentdate.getFullYear() + "-"  
								+ currentdate.getHours() + ":"  
								+ currentdate.getMinutes() + ":" 
								+ currentdate.getSeconds();
					var filename = "Post-Survey-Result-" + datetime + ".csv";
					//alert(datetime);
					exportTableToCSV.apply(this, [$('#exportTable'), filename]);
					
					// IF CSV, don't do event.preventDefault() or return false
					// We actually need this to be a typical hyperlink
				});
			$( "#fromDate" ).datepicker();
			$( "#toDate" ).datepicker();
			
			$("#filterBtn").click(function(){
				$("#btnFilter").trigger("click");
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
                        Post Survey Results
                    </h1>
                    <ol class="breadcrumb">
						<li>
                            <i class="fa fa-fw fa-dashboard"></i> <a href="/admin/dashboard.aspx">Dashboard</a>
                        </li>
                        <li class="active">
                            Post Survey Results
                        </li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
	<div class="row">
        <div class="col-lg-2">
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
		<div class="col-lg-3"></div>
        <div class="col-lg-3">
			<div class="form-group input-group">
				<span class="input-group-addon">Filter by Date</span>
				<asp:TextBox ID="fromDate" runat="server" CssClass="form-control" placeholder="From" />
			</div>
		</div>
		<div class="col-lg-2" style="padding-left:0">
			<div class="form-group input-group">
				<asp:TextBox ID="toDate" runat="server" CssClass="form-control" placeholder="To" />
				<span class="input-group-btn"><button id="filterBtn" class="btn btn-success" type="button" style="border-radius: 0 4px 4px 0;"><i class="fa fa-search"></i></button></span>
				<asp:Button ID="btnFilter" runat="server" Text="Save" CssClass="btn btn-primary pull-right" style="margin-right:10px; display:none; " ValidationGroup="InputCheck" OnClick="btnFilter_Click" />
			</div>
		</div>
        <div class="col-lg-2" style="text-align:right">
			<a href="javascript:void()" class="btn btn-success exportToExcel">Export</a>
			<div class="form-group input-group" style="display:none;">
                <span class="input-group-addon">Language</span>
            </div>
		</div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div id="exportbox" class="table-responsive" style="height:auto;">
                <asp:ListView ID="PostSurveyResultTable" runat="server">
                    <LayoutTemplate>
                        <table id="exportTable" class="table table-bordered table-hover table-striped">
                            <thead>
                                <tr>                            									
									<th>OrderID</th>
									<th>Customer ID</th>
									<th>Name</th>
									<th>Email Address</th>
									<th>Address</th>
									<th>Phone</th>
									<th>Question</th>
									<th>Answer</th>
									<th>Comment</th>
									<th>Date</th>
									
                                </tr>
                            </thead>
                            <tbody>
                                <tr runat="server" id="itemPlaceHolder"></tr>
                            </tbody>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr id="Tr<%#Eval("OrderID") %>">
							<td><%#Eval("OrderID") %></td>
							<td><%#Eval("customer_id")%></td>
							<td><%#Eval("First_Name")+" "+Eval("Last_Name") %></td>
							<td><%#Eval("Email_Addr")%></td>
							<td><%#Eval("billing_address1")+", "+Eval("billing_address2")+", "+Eval("billing_city")+", "+Eval("billing_area")+", "+Eval("billing_postcode")+", "+Eval("billing_country")%></td>
							<td><%#Eval("Cust_Nbr")%></td>
							<td><%#Eval("QuestionText")%></td>
							<td><%#Eval("QuestionAnswer") %></td>
							<td><%#Eval("QuestionComment")%></td>
							<td><%#Eval("DateCreated")%></td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>    
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="TableContent" runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiprep %>" SelectCommand="SELECT pos.OrderID, pos.customer_id, cm.First_Name, cm.Last_Name, cm.Email_Addr, wod.billing_address1, wod.billing_address2, wod.billing_city, wod.billing_area, wod.billing_postcode, wod.billing_country, cm.Cust_Nbr, pos.QuestionText, pos.QuestionAnswer, pos.QuestionComment, pos.DateCreated FROM certiPostOrderSurvey pos INNER JOIN cp_roi_CONTACT_MASTER cm ON pos.customer_id = cm.ID INNER JOIN WebOrderDetails wod ON wod.id = pos.OrderID ORDER BY pos.DateCreated DESC">
	</asp:SqlDataSource>
	<asp:DataPager ID="DataPager1" runat="server" PagedControlID="PostSurveyResultTable" QueryStringField="page" class="pagination" PageSize="25">
        <Fields>
            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
            <asp:NumericPagerField />
            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
        </Fields>
    </asp:DataPager>
</asp:Content>

