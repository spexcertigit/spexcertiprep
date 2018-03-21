<%@ Page Language="C#" Title="Update Product" MasterPageFile="~/admin/Site.Master" AutoEventWireup="true" CodeFile="edit.cs" Inherits="news_edit" ValidateRequest="false" debug="true"%>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <section class="featured">
        <div class="content-wrapper">
            <div class="row">
				<div id="result"></div>
				<% if (Request.QueryString["success"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-success alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Successfully</strong> updated the <strong>Product!!</strong>
                    </div>
                </div>
				<% }else if (Request.QueryString["failed"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-danger alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Opps!</strong> something went wrong in updating the <strong>Product!!</strong>
                    </div>
                </div>
				<% }else if (Request.QueryString["created"] != null) {%>
				<div class="col-lg-12">
                    <div class="alert alert-success alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <strong>Successfully</strong> created new <strong>Product!!</strong>
                    </div>
                </div>					
				<% }%>
                <div class="col-lg-12">
                    <h1 class="page-header">
                        Edit Product
                    </h1>
                    <ol class="breadcrumb">
						<li>
                            <i class="fa fa-fw fa-dashboard"></i> <a href="/admin/dashboard.aspx">Dashboard</a>
                        </li>
                        <li>
                            <i class="fa fa fa-diamond"></i> <a href="/admin/products/">Products</a>
                        </li>
                        <li class="active">
                            <i class="fa fa-edit"></i> Edit Product
                        </li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
	<div class="row">
		<div class="col-lg-10"></div>
		<div class="col-lg-2">
		</div>
	</div>
    <div class="row">
        <div class="col-lg-9">
            <div class="table-responsive">
                <div class="form-group input-group">
                    <span class="input-group-addon">Part Number</span>
                    <asp:TextBox ID="txtPart" runat="server" CssClass="form-control" Width="100%" disabled></asp:TextBox>
					<asp:HiddenField ID="txtPartHid" runat="server" />
					<asp:HiddenField ID="txtPNbrHid" runat="server" />
                </div>
                <div class="form-group input-group">
                    <span class="input-group-addon">Product Name</span>
					<asp:TextBox ID="txtName" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
					<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" ValidationGroup="InputCheck" ErrorMessage="Product Name is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
				<div class="form-group input-group">
					<span class="input-group-addon">Product Type</span>
					<asp:DropDownList ID="ddlProdType" runat="server" CssClass="form-control">
						<asp:ListItem Text="Select Product Level" Value="0"/>
						<asp:ListItem Text="Organic Standards" Value="1"/>
						<asp:ListItem Text="Inorganic Standards" Value="2"/>
						<asp:ListItem Text="Laboratory Stuff" Value="6"/>
					</asp:DropDownList>
                </div>
				<div id="inorgBox" class="form-group hidden" runat="server">
					<div class="col-md-6" style="padding-left:0;">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">Product Techniques</h3>
							</div>
							<div class="panel-body">
								<div class="form-group input-group">
									<span class="input-group-addon">Techniques</span>
									<select id="ddlFamilies" class="form-control btn-sm">
										<option value="0">-- Select Techniques -- </option>
										<asp:ListView ID="lvInorgFamilies" runat="server" DataSourceID="dataInorgFamilies">
											<LayoutTemplate>
												<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
											</LayoutTemplate>
											<ItemTemplate>
												<option value="<%# Eval("cfID").ToString().Trim()%>"><%# Eval("cfFamily").ToString().Trim()%></option>
											</ItemTemplate>
										</asp:ListView>
									</select>
								</div>
								<div id="familyContainer" class="assignment">							
									<asp:ListView ID="lvInorgFams" runat="server" DataSourceID="dataInorgFams">
										<LayoutTemplate>
											<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
										</LayoutTemplate>
										<ItemTemplate>
											<div id="close-<%# Eval("relID").ToString().Trim()%>" class="products btn-sm"><%# Eval("Family")%><a class="remove-fam close" onclick="javascript:delFam('<%# Eval("relID").ToString().Trim()%>', '<%# Eval("Family")%>')" >x</a></div>
										</ItemTemplate>
									</asp:ListView>
								</div>
							</div>
						</div>
					</div>
					
					<div class="col-md-6" style="padding-right:0">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">Product Categories</h3>
							</div>
							<div class="panel-body">
								<div class="form-group input-group">
									<span class="input-group-addon">Categories</span>
									<select id="ddlCategories" class="form-control btn-sm">
										<option value="0">-- Select Categories -- </option>
										<asp:ListView ID="lvCategories" runat="server" DataSourceID="dataInorgCat">
											<LayoutTemplate>
												<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
											</LayoutTemplate>
											<ItemTemplate>
												<option value="<%# Eval("ccID").ToString().Trim()%>"><%# Eval("ccCategory").ToString().Trim()%></option>
											</ItemTemplate>
										</asp:ListView>
									</select>
								</div>
								<div id="categoryContainer" class="assignment">
									<asp:ListView ID="lvCats" runat="server" DataSourceID="dataCats">
										<LayoutTemplate>
											<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
										</LayoutTemplate>
										<ItemTemplate>
											<div id="cclose-<%# Eval("relID").ToString().Trim()%>" class="products btn-sm"><%# Eval("Category")%><a class="remove-cat close" onclick="javascript:delCat('<%# Eval("relID").ToString().Trim()%>', '<%# Eval("Category")%>')">x</a></div>
										</ItemTemplate>
									</asp:ListView>
								</div>
							</div>
						</div>
					</div>
					<div class="clear"></div>
				</div>
				
				<div id="orgBox" class ="form-group hidden" runat="server">
					<div class="col-md-6" style="padding-left:0;">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">Product Techniques</h3>
							</div>
							<div class="panel-body">
								<div class="form-group input-group">
									<span class="input-group-addon">Techniques</span>
									<select id="ddlTechniques" class="form-control btn-sm">
										<option value="0">-- Select Techniques -- </option>
										<asp:ListView ID="lvOrgTech" runat="server" DataSourceID="dataAnTech">
											<LayoutTemplate>
												<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
											</LayoutTemplate>
											<ItemTemplate>
												<option value="<%# Eval("CatID").ToString().Trim()%>"><%# Eval("CatLong").ToString().Trim()%></option>
											</ItemTemplate>
										</asp:ListView>
									</select>
								</div>
								<div id="techContainer" class="assignment">							
									<asp:ListView ID="lvTech" runat="server" DataSourceID="dataTechs">
										<LayoutTemplate>
											<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
										</LayoutTemplate>
										<ItemTemplate>
											<div id="tclose-<%# Eval("relID").ToString().Trim()%>" class="products btn-sm"><%# Eval("CatLong")%><a class="remove-tech close" onclick="javascript:delTech('<%# Eval("relID").ToString().Trim()%>', '<%# Eval("CatLong")%>')" >x</a></div>
										</ItemTemplate>
									</asp:ListView>
								</div>
							</div>
						</div>
					</div>
					
					<div class="col-md-6" style="padding-right:0;">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">Product Applications</h3>
							</div>
							<div class="panel-body">
								<div class="form-group input-group">
									<span class="input-group-addon">Applications</span>
									<select id="ddlApplications" class="form-control btn-sm">
										<option value="0">-- Select Applications -- </option>
										<asp:ListView ID="lvOrgApplication" runat="server" DataSourceID="dataOrgApplication">
											<LayoutTemplate>
												<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
											</LayoutTemplate>
											<ItemTemplate>
												<option value="<%# Eval("cfID").ToString().Trim()%>"><%# Eval("cfFamily").ToString().Trim()%></option>
											</ItemTemplate>
										</asp:ListView>
									</select>
								</div>
								<div id="appContainer" class="assignment">							
									<asp:ListView ID="lvOrgApp" runat="server" DataSourceID="dataOrgApp">
										<LayoutTemplate>
											<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
										</LayoutTemplate>
										<ItemTemplate>
											<div id="aclose-<%# Eval("relID").ToString().Trim()%>" class="products btn-sm"><%# Eval("Family")%><a class="remove-app close" onclick="javascript:delApp('<%# Eval("relID").ToString().Trim()%>', '<%# Eval("Family")%>')" >x</a></div>
										</ItemTemplate>
									</asp:ListView>
								</div>
							</div>
						</div>
					</div>
					<div class="clear"></div>
				</div>
				<div class="form-group input-group">
                    <span class="input-group-addon">Description</span>
					<asp:TextBox id="txtDesc" TextMode="multiline" CssClass="main-editor" Columns="50" Rows="5" runat="server" />
                </div>
				
            </div>
			<div class="table-responsive" style="display:none">
				<table class="table table-bordered table-striped">
					<tr>
						<th>Thumbnail Image</th>
						<th>Main Image</th>
					</tr>
					<tr>
						<td>
							<div class="main_image1">
								<% if(System.IO.File.Exists(Server.MapPath("~/images/product_images/" + thumbImg))) {%>
								<img style="width:120px;height:auto" src="/images/product_images/<%=thumbImg%>" />
								<% }%>
								<input type="button" onclick="changeImage(1)" class="btn btn-default" value="Change"/>
							</div>
							<div class="main_image_upload1" style="display:none">
								<asp:FileUpload ID="image_upload1" runat="server" CssClass="form-control" />
							</div>
						</td>
						<td>
							<div class="full_image1">
								<% if(System.IO.File.Exists(Server.MapPath("~/images/product_images/" + mainImg))) {%>
								<img style="width:240px;height:auto" src="/images/product_images/<%=mainImg%>" />
								<% }%>
								<input type="button" onclick="changeFull(1)"class="btn btn-default"  value="Change"/>
							</div>
							<div class="full_image_upload1" style="display:none">
								<asp:FileUpload ID="full_upload1" runat="server" CssClass="form-control" />
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="col-lg-3">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Product Infromation</h3>
                </div>
                <div class="panel-body">
					<div div class="form-group input-group">
						<span class="input-group-addon">Matrix</span>
						<asp:DropDownList ID="ddlMatrix" runat="server" CssClass="form-control" DataSourceID="dataMatrix" DataTextField="T542_Short" DataValueField="T542_Code">
						</asp:DropDownList>
					</div>
					<div div class="form-group input-group">
						<span class="input-group-addon">Volume</span>
						<asp:DropDownList ID="ddlVolume" runat="server" CssClass="form-control" DataSourceID="dataVolumes" DataTextField="cpvVolume" DataValueField="cpvID">
						</asp:DropDownList>
					</div>
					<div div class="form-group input-group">
						<span class="input-group-addon">Units/Pack</span>
						<asp:TextBox ID="txtUnitsPerPack" runat="server" CssClass="form-control"></asp:TextBox>
					</div>
					<div div class="form-group input-group">
						<span class="input-group-addon">Storage</span>
						<asp:DropDownList ID="ddlStorage" runat="server" CssClass="form-control" DataSourceID="dataStorage" DataTextField="csgStore" DataValueField="csgID">
						</asp:DropDownList>
					</div>
					<div div class="form-group input-group">
						<span class="input-group-addon">Shipping Info</span>
						<asp:DropDownList ID="ddlShipInfo" runat="server" CssClass="form-control" DataSourceID="dataShipInfo" DataTextField="csfinfo" DataValueField="csfID">
						</asp:DropDownList>
					</div>
					<div div class="form-group input-group">
						<span class="input-group-addon">Notes</span>
						<asp:TextBox ID="txtProdNotes" runat="server" CssClass="form-control"></asp:TextBox>
					</div>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Methods</h3>
                </div>
				<div class="panel-body">
					<div div class="form-group input-group">
						<span class="input-group-addon">Method Reference</span>
						<select id="ddlMethods" class="form-control btn-sm">
							<option value="0">-- Select Methods -- </option>
							<asp:ListView ID="lvMethods" runat="server" DataSourceID="dataMethods">
								<LayoutTemplate>
									<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
								</LayoutTemplate>
								<ItemTemplate>
									<option value="<%# Eval("cmID").ToString().Trim()%>"><%# Eval("cmName").ToString().Trim()%></option>
								</ItemTemplate>
							</asp:ListView>
						</select>
					</div>
					<div id="methodContainer" class="assignment">
						<asp:ListView ID="lvMeths" runat="server" DataSourceID="dataMeths">
							<LayoutTemplate>
								<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
							</LayoutTemplate>
							<ItemTemplate>
								<div id="mclose-<%# Eval("relID").ToString().Trim()%>" class="products btn-sm"><%# Eval("Method")%><a class="remove-met close" onclick="javascript:delMeth('<%# Eval("relID").ToString().Trim()%>', '<%# Eval("Method")%>')">x</a></div>
							</ItemTemplate>
						</asp:ListView>
					</div>
					<div class="clear"></div>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title"><i class="fa fa-file-pdf-o"></i> SDS</h3>
                </div>
                <div class="panel-body">
					<div class="sds">
						<a target="_blank" href="/msds/<%=sds%>" ><%=sds%></a>
						<input type="button" onclick="changeSDS()"class="btn btn-default "  value="Change"/>
					</div>
					<div class="sdsUpload" style="display:none">
						<asp:FileUpload ID="sds_upload" runat="server" CssClass="form-control" style="width:100%" />
					</div>
				</div>
			</div>
		</div>
		<div id="inorgComp" class="col-lg-12 hidden">
			<div class="panel panel-default">
                <div class="panel-heading">
					<h3 class="panel-title">Components</h3>
                </div>
                <div class="panel-body">
					<div class="col-lg-4">
						<div class="form-group">
							<label for="ddlComponents">Component</label>
							<select id="ddlComponents" class="form-control" style="width:100%">
								<option value="0">-- Select Component --</option>
								<asp:ListView ID="lvComponents" runat="server" DataSourceID="dataComponents">
									<LayoutTemplate>
										<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
									</LayoutTemplate>
									<ItemTemplate>
										<option value="<%# Eval("caID")%>"><%# Eval("caNameWeb")%></option>
									</ItemTemplate>
								</asp:ListView>
							</select>
						</div>
						<div class="col-sm-9" style="padding-left:0">
							<div class="form-group">
								<label for="txtConc">Concentration</label>
								<input type="number" id="txtConc" class="form-control" style="width:100%"/>
							</div>
						</div>
						<div class="col-sm-3" style="padding:0">
							<div class="form-group">
								<label>&nbsp;</label>
								<select id="ddlUnits" class="form-control" style="width:100%">
									<asp:ListView ID="lvUnits" runat="server" DataSourceID="dataUnits">
										<LayoutTemplate>
											<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
										</LayoutTemplate>
										<ItemTemplate>
											<option value="<%# Eval("cuID")%>"><%# Eval("cuUnit")%></option>
										</ItemTemplate>
									</asp:ListView>
								</select>
							</div>
						</div>
						<div class="form-group">
							<input id="addComp" type="button" value="Add new Component" class="btn btn-success" onclick="addComponent()" />
						</div>
					</div>
					<div class="col-lg-8">
						<table id="featTable" class="table table-hover table-striped">
							<%=getComponents()%>
						</table>
					</div>
				</div>
			</div>
		</div>
		
		<div id="orgComp" class="col-lg-12 hidden">
			<div class="panel panel-default">
                <div class="panel-heading">
					<h3 class="panel-title">Components</h3>
                </div>
                <div class="panel-body">
					<div class="col-lg-4">
						<div class="form-group">
							<label for="ddlComponents2">Component</label>
							<select id="ddlComponents2" class="form-control" style="width:100%">
								<option value="0">-- Select Component --</option>
								<asp:ListView ID="lvComponents2" runat="server" DataSourceID="dataOrgComponents">
									<LayoutTemplate>
										<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
									</LayoutTemplate>
									<ItemTemplate>
										<option value="<%# Eval("cmpID")%>"><%# Eval("cmpComp")%></option>
									</ItemTemplate>
								</asp:ListView>
							</select>
						</div>
						<div class="form-group">
							<div class="form-group">
								<label for="txtCasNum">CAS #</label>
								<input type="text" id="txtCasNum" class="form-control" style="width:100%"/>
							</div>
						</div>
						<div class="col-sm-9" style="padding-left:0">
							<div class="form-group">
								<label for="txtConc2">Concentration</label>
								<input type="number" id="txtConc2" class="form-control" style="width:100%"/>
							</div>
						</div>
						<div class="col-sm-3" style="padding:0">
							<div class="form-group">
								<label>&nbsp;</label>
								<select id="ddlUnits2" class="form-control" style="width:100%">
									<asp:ListView ID="lvUnits2" runat="server" DataSourceID="dataUnits">
										<LayoutTemplate>
											<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
										</LayoutTemplate>
										<ItemTemplate>
											<option value="<%# Eval("cuID")%>"><%# Eval("cuUnit")%></option>
										</ItemTemplate>
									</asp:ListView>
								</select>
							</div>
						</div>
						<div class="form-group">
							<input id="addComp2" type="button" value="Add new Component" class="btn btn-success" onclick="addComponent2()" />
						</div>
					</div>
					<div class="col-lg-8">
						<table id="featTable2" class="table table-hover table-striped">
							<%=getOrgComponents()%>
						</table>
					</div>
				</div>
			</div>
		</div>
		
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Kits</h3>
				</div>
				<div class="panel-body">
					<div class="col-md-12">
						<div id="loadingZone"></div>
						<p>Drag items from right to left colum to add product kits to the page and Drag items from left to right column to remove product kits from the page.</p>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<div class="dragColumn">
								<h4>Product Kits</h4>
								<div class="divDragContainer">
									<ul id="product-kits" class="listConnect">
										<%=getKits()%>
									</ul>
								</div>
								<div class="clear"></div>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<div class="dragColumn">
								<h4>Available Product Kits</h4>
								<div class="divDragContainer">
									<ul id="kits-list" class="listConnect">
										<%=getKitsList()%>
									</ul>
								</div>
								<div class="clear"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-lg-12">
            <div class="form-group">&nbsp;</div>
			<div class="form-group"></div>
            <div class="form-group fixed-controls">
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-danger pull-right" TabIndex="7" OnClick="btnCancel_Click" />
                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary pull-right" style="margin-right:10px" ValidationGroup="InputCheck" OnClick="btnSave_Click" />
                <div class="clearfix"></div>
            </div>
            <div class="form-group">&nbsp;</div>
        </div>
    </div>
	
	<script type="text/javascript">
		$(document).ready(function() {		
			reloadDel();
			
			$("#btnSave").click(function(){
				$(".overlay .loadingBox").show();
			});
			
			$("#ddlProdType").val('<%=prodType%>');
			
			var prodt = $("#ddlProdType").val();
			if (prodt == "2") {
				$("#inorgBox").removeClass("hidden");
				$("#inorgComp").removeClass("hidden");
				$("#orgBox").addClass("hidden");
				$("#orgComp").addClass("hidden");
			}else if (prodt == "1") {
				$("#inorgBox").addClass("hidden");
				$("#inorgComp").addClass("hidden");
				$("#orgBox").removeClass("hidden");
				$("#orgComp").removeClass("hidden");
			}else {
				$("#inorgBox").addClass("hidden");
				$("#inorgComp").addClass("hidden");
				$("#orgBox").addClass("hidden");
				$("#orgComp").addClass("hidden");
			}
				
			$("#ddlProdType").change(function() {
				var prodtype = $(this).val();
				if (prodtype == "2") {
					$("#inorgBox").removeClass("hidden");
					$("#inorgComp").removeClass("hidden");
					$("#orgBox").addClass("hidden");
					$("#orgComp").addClass("hidden");
				}else if (prodtype == "1") {
					$("#inorgBox").addClass("hidden");
					$("#inorgComp").addClass("hidden");
					$("#orgBox").removeClass("hidden");
					$("#orgComp").removeClass("hidden");
				}else {
					$("#inorgBox").addClass("hidden");
					$("#inorgComp").addClass("hidden");
					$("#orgBox").addClass("hidden");
					$("#orgComp").addClass("hidden");
				}
			});
			
			// *** PRODUCT Kits Controller *** //
			
			$("#product-kits, #kits-list").sortable({ 
				connectWith: ".listConnect",
				revert: true,
				placeholder: "drag-highlight"
			});
			$( "#product-kits" ).on( "sortreceive", function( event, ui ) {
				var ppart = ui.item.data("ppart")
				var ima = ui.item.data("imassy");
				var cpart = ui.item.data("cpart")
				var imp = ui.item.data("impart");
				$.ajax({
					url: 'edit.aspx/addKit',
					type: "POST",
					data: JSON.stringify({ parent_part: ppart, component_part: cpart, im_assy: ima, im_part: imp }),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						$('#loadingZone').html(data.d);
					}
				});
			} );
			$( "#kits-list" ).on( "sortreceive", function( event, ui ) {
				var kitid = ui.item.data("kitid");
				$.ajax({
					url: 'edit.aspx/delKit',
					type: "POST",
					data: JSON.stringify({  kit_id: kitid }),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						$('#loadingZone').html(data.d);
					}
				});
			} );
			$("#product-kits li").each(function() {
				var wid = $(this).data("wid");
				$("#list-" + wid).remove();
			});
			
			// *** END of PRODUCT Kits Controller *** //
			
			// *** Product Families Controller *** //
			
			$("#ddlFamilies").change(function() {
				var fam = $(this).val();
				var pID = "<%=iID%>";
				var part = "<%=PartNumber%>";
				var fname = $("option:selected", this).text();
				if (fam != "0") {
					$.ajax({
						url: 'edit.aspx/addFamily',
						type: "POST",
						data: JSON.stringify({ famID: fam, cpfID: pID, PartNum: part, famName: fname }),
						contentType: "application/json; charset=utf-8",
						dataType: "json",
						success: function (data) {
							$("#familyContainer").append(data.d);
							reloadDel();
							$("#ddlFamilies option[value='" + fam + "']").remove();
						}
					});
				}
			});
			
			// *** END of Product Families Controller *** //
			
			
			// *** Product Categories Controller *** //
			
			$("#ddlCategories").change(function() {
				var cat = $(this).val();
				var pID = "<%=iID%>";
				var part = "<%=PartNumber%>";
				var cname = $("option:selected", this).text();
				if (cat != "0") {
					$.ajax({
						url: 'edit.aspx/addCategory',
						type: "POST",
						data: JSON.stringify({ catID: cat, cpcID: pID, PartNum: part, catName: cname }),
						contentType: "application/json; charset=utf-8",
						dataType: "json",
						success: function (data) {
							$("#categoryContainer").append(data.d);
							reloadDel();
							$("#ddlCategories option[value='" + cat + "']").remove();
						}
					});
				}
			});
			
			// *** END of Product Categories Controller *** //
			
			// *** Product Methods Controller *** //
			
			$("#ddlMethods").change(function() {
				var met = $(this).val();
				var pID = "<%=iID%>";
				var part = "<%=PartNumber%>";
				var mname = $("option:selected", this).text();
				if (met != "0") {
					$.ajax({
						url: 'edit.aspx/addMethod',
						type: "POST",
						data: JSON.stringify({ metID: met, cpmID: pID, PartNum: part, metName: mname}),
						contentType: "application/json; charset=utf-8",
						dataType: "json",
						success: function (data) {
							$("#methodContainer").append(data.d);
							reloadDel();
							$("#ddlMethods option[value='" + met + "']").remove();
						}
					});
				}
			});
			
			// *** END of Methods Controller *** //
			
			// *** Product Techniques Controller *** //
			
			$("#ddlTechniques").change(function() {
				var tech = $(this).val();
				var pID = "<%=iID%>";
				var part = "<%=PartNumber%>";
				var tname = $("option:selected", this).text();
				if (tech != "0") {
					$.ajax({
						url: 'edit.aspx/addTechnique',
						type: "POST",
						data: JSON.stringify({ techID: tech, cpatID: pID, PartNum: part, techName: tname}),
						contentType: "application/json; charset=utf-8",
						dataType: "json",
						success: function (data) {
							$("#techContainer").append(data.d);
							reloadDel();
							$("#ddlTechniques option[value='" + tech + "']").remove();
						}
					});
				}
			});
			
			// *** END of Techniques Controller *** //
			
			// *** Product Applications Controller *** //
			
			$("#ddlApplications").change(function() {
				var app = $(this).val();
				var pID = "<%=iID%>";
				var part = "<%=PartNumber%>";
				var aname = $("option:selected", this).text();
				if (app != "0") {
					$.ajax({
						url: 'edit.aspx/addApplications',
						type: "POST",
						data: JSON.stringify({ appID: app, cpfID: pID, PartNum: part, appName: aname}),
						contentType: "application/json; charset=utf-8",
						dataType: "json",
						success: function (data) {
							$("#appContainer").append(data.d);
							reloadDel();
							$("#ddlApplications option[value='" + app + "']").remove();
						}
					});
				}
			});
			
			// *** END of Applications Controller *** //
		});
		
		
        function relocate(url) {
            location.replace(url);
        }
		function changeBg(){
			$(".currentBg").hide("fast");
			$(".uploadBg").show("fast");
		}
		function changeImage(num) {
			$(".main_image"+num).hide("fast");
			$(".main_image_upload"+num).show("fast");
		}
		function changeFull(num) {
			$(".full_image"+num).hide("fast");
			$(".full_image_upload"+num).show("fast");
		}
		
		function changeSDS() {
			$(".sds").hide("fast");
			$(".sdsUpload").show("fast");
		}
		
		function addComponent() {
			var comp = $("#ddlComponents").val();
			var txtConc = $("#txtConc").val();
			var unit_id = $("#ddlUnits").val();
			var unitVal = $("#ddlUnits option:selected").text();
			var id = <%=iID%>;
			var part = "<%=PartNumber%>";
			var err = 0;
			var error = "Error:\n";
			
			if (comp == "0") {
				error = error + "• Please select a component.\n";
				err = err + 1;
			}
			if (txtConc == "") {
				error = error + "• Please fill in the concentration.\n";
				err = err + 1;
			}
			
			if (err == 0) {
				$.ajax({
					url: 'edit.aspx/addComp',
					type: "POST",
					data: JSON.stringify({ prodID: id, PartNum: part, caID: comp, conc: txtConc, unitID: unit_id, units: unitVal}),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						$('#featTable').html(data.d);
						reloadDel();
						$("#ddlComponents").val("0");
						$("#txtConc").val("");
					}
				});
			}else {
				alert(error);
				err = 0;
			}
		}
		
		function addComponent2() {
			var comp = $("#ddlComponents2").val();
			var txtCAS = $("#txtCasNum").val();
			var txtConc = $("#txtConc2").val();
			var unit_id = $("#ddlUnits2").val();
			var unitVal = $("#ddlUnits2 option:selected").text();
			var txtComp = $("#ddlComponents2 option:selected").text();
			var id = <%=iID%>;
			var part = "<%=PartNumber%>";
			var err = 0;
			var error = "Error:\n";
			
			if (comp == "0") {
				error = error + "• Please select a component.\n";
				err = err + 1;
			}
			if (txtConc == "") {
				error = error + "• Please fill in the concentration.\n";
				err = err + 1;
			}
			
			if (txtCAS == "") {
				error = error + "• Please fill in the CAS Number.\n";
				err = err + 1;
			}
			
			if (err == 0) {
				$.ajax({
					url: 'edit.aspx/addComp2',
					type: "POST",
					data: JSON.stringify({ prodID: id, PartNum: part, compID: comp, conc: txtConc, unitID: unit_id, units: unitVal, casNum: txtCAS, compVal: txtComp}),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						$('#featTable2').html(data.d);
						reloadDel();
						$("#ddlComponents2").val("0");
						$("#txtConc2").val("");
						$("#txtCasNum").val("");
					}
				});
			}else {
				alert(error);
				err = 0;
			}
		}
		
		
		function delFam(id, name) {
			var answer = confirm("Are you sure you want to delete this family?");
			
			if (answer){
				//alert("DELETE!")
				$.ajax({
					url: 'edit.aspx/deleteFam',
					type: "POST",
					data: JSON.stringify({ famID: id, famName: name }),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						$('#ddlFamilies').append(data.d);
						$('#close-'+id).remove();
					}
				});
			}
		}
		
		function delCat(id, name) {
			var answer = confirm("Are you sure you want to delete this category?");
			
			if (answer){
				//alert("DELETE!")
				$.ajax({
					url: 'edit.aspx/deleteCat',
					type: "POST",
					data: JSON.stringify({ catID: id, catName: name }),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						$('#ddlCategories').append(data.d);
						$('#cclose-'+id).remove();
					}
				});
			}
		}
		
		function delMeth(id, name) {
			var answer = confirm("Are you sure you want to delete this method?");
			
			if (answer){
				//alert("DELETE!")
				$.ajax({
					url: 'edit.aspx/deleteMeth',
					type: "POST",
					data: JSON.stringify({ metID: id, metName: name }),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						$('#ddlMethods').append(data.d);
						$('#mclose-'+id).remove();
					}
				});
			}
		}
		
		function delTech(id, name) {
			var answer = confirm("Are you sure you want to delete this technique?");
			
			if (answer){
				//alert("DELETE!")
				$.ajax({
					url: 'edit.aspx/deleteTech',
					type: "POST",
					data: JSON.stringify({ techID: id, techName: name }),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						$('#ddlTechniques').append(data.d);
						$('#tclose-'+id).remove();
					}
				});
			}
		}
		
		function delApp(id, name) {
			var answer = confirm("Are you sure you want to delete this application?");
			
			if (answer){
				//alert("DELETE!")
				$.ajax({
					url: 'edit.aspx/deleteFam',
					type: "POST",
					data: JSON.stringify({ famID: id, famName: name }),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						$('#ddlApplications').append(data.d);
						$('#aclose-'+id).remove();
					}
				});
			}
		}
		
		function delComp(id) {
			var answer = confirm("Are you sure you want to delete this component?")
			if (answer){
				//alert("DELETE!")
				$.ajax({
					url: 'edit.aspx/deleteComp',
					type: "POST",
					data: JSON.stringify({ compID: id }),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						$('#result').html(data.d);
						$('#Tr'+id).remove();
					}
				});
			}
		}
		
		function confirmation(id) {
			var answer = confirm("Are you sure you want to delete this item?")
			if (answer){
				document.getElementById("btnDelete").click();
			}
		}
		
		function reloadDel() {
			$(document).ready(function(){				
				$(".comp-del").click(function() {
					delComp($(this).data("compid"));
				});
			});
			$(document).ready(function(){				
				$(".comp-del2").click(function() {
					delComp($(this).data("compid2"));
				});
			});
		}
		
		tinymce.init({
			selector: '.content-editor',  // change this value according to your html
			content_css : '/css/content.min.css',
			plugins: "code",
			forced_root_block : "", 
			menu : {
				tools: {title: 'Tools', items: 'spellchecker'}
			},
			toolbar: [
				'undo redo | code'
			]
		});
    </script>
	<asp:SqlDataSource ID='dataMatrix' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT LTRIM(RTRIM(T542_Code)) AS T542_Code, T542_Short FROM cp_roi_Matrix" SelectCommandType="Text">
    </asp:SqlDataSource>
	
	<asp:SqlDataSource ID='dataVolumes' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT cpvID, cpvVolume FROM cp_roi_Volumes" SelectCommandType="Text">
    </asp:SqlDataSource>
	
	<asp:SqlDataSource ID='dataStorage' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT csgID, csgStore FROM cp_roi_Storage" SelectCommandType="Text">
    </asp:SqlDataSource>
	
	<asp:SqlDataSource ID='dataShipInfo' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT csfID, csfinfo FROM cp_roi_ShipInfo" SelectCommandType="Text">
    </asp:SqlDataSource>
	
	<asp:SqlDataSource ID='dataMethods' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT cmID, cmName FROM cp_roi_Methods" SelectCommandType="Text">
    </asp:SqlDataSource>
	
	<asp:SqlDataSource ID='dataComponents' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT caID, caNameWeb FROM certiAnalytes" SelectCommandType="Text">
    </asp:SqlDataSource>
	
	<asp:SqlDataSource ID='dataOrgComponents' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT cmpID, cmpCAS, cmpComp FROM certiComps" SelectCommandType="Text">
    </asp:SqlDataSource>
	
	<asp:SqlDataSource ID='dataUnits' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT cuID, cuUnit FROM certiUnits" SelectCommandType="Text">
    </asp:SqlDataSource>
	
	<asp:SqlDataSource ID='dataInorgFamilies' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>" 
		SelectCommand="SELECT cfID, cfFamily FROM cp_roi_Families WHERE cfID NOT IN (SELECT pfam.cpffamID FROM cp_roi_ProdFamilies AS pfam INNER JOIN cp_roi_Families AS fam ON fam.cfID = pfam.cpffamID WHERE pfam.cpfID = @cpID) AND (cfTypeID = 2 OR cfTypeID = 70) ORDER BY cfTypeID, cfFamily" SelectCommandType="Text">
		 <SelectParameters>
            <asp:QueryStringParameter Name="cpID" Type="String" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
	
	<asp:SqlDataSource ID='dataInorgFams' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT pfam.ID AS relID, fam.cfFamily AS Family FROM cp_roi_ProdFamilies AS pfam INNER JOIN cp_roi_Families AS fam ON fam.cfID = pfam.cpffamID WHERE pfam.cpfID = @cpID AND (fam.cfTypeID = 2 OR fam.cfTypeID = 70)" SelectCommandType="Text">
        <SelectParameters>
            <asp:QueryStringParameter Name="cpID" Type="String" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
	
	<asp:SqlDataSource ID='dataOrgApplication' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>" 
		SelectCommand="SELECT cfID, cfFamily FROM cp_roi_Families WHERE cfID NOT IN (SELECT pfam.cpffamID FROM cp_roi_ProdFamilies AS pfam INNER JOIN cp_roi_Families AS fam ON fam.cfID = pfam.cpffamID WHERE pfam.cpfID = @cpID) AND (cfTypeID = 1 OR cfTypeID = 70) ORDER BY cfTypeID, cfFamily" SelectCommandType="Text">
		 <SelectParameters>
            <asp:QueryStringParameter Name="cpID" Type="String" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
	
	<asp:SqlDataSource ID='dataOrgApp' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT pfam.ID AS relID, fam.cfFamily AS Family FROM cp_roi_ProdFamilies AS pfam INNER JOIN cp_roi_Families AS fam ON fam.cfID = pfam.cpffamID WHERE pfam.cpfID = @cpID AND (fam.cfTypeID = 1 OR fam.cfTypeID = 70)" SelectCommandType="Text">
        <SelectParameters>
            <asp:QueryStringParameter Name="cpID" Type="String" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
	
	<asp:SqlDataSource ID='dataAnTech' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT CatID, CatLong FROM cp_roi_AnTechs WHERE CatID NOT IN (SELECT pats.cpatATID FROM cp_roi_ProdATs AS pats INNER JOIN cp_roi_AnTechs AS tec ON tec.CatID = pats.cpatATID WHERE pats.cpatID = @cpID)" SelectCommandType="Text">
		<SelectParameters>
            <asp:QueryStringParameter Name="cpID" Type="String" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
	
	<asp:SqlDataSource ID='dataTechs' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT pats.ID AS relID, tec.CatLong AS CatLong FROM cp_roi_ProdATs AS pats INNER JOIN cp_roi_AnTechs AS tec ON tec.CatID = pats.cpatATID WHERE pats.cpatID = @cpID" SelectCommandType="Text">
        <SelectParameters>
            <asp:QueryStringParameter Name="cpID" Type="String" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
	
	<asp:SqlDataSource ID='dataInorgCat' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT ccID, ccCategory FROM cp_roi_Cats WHERE ccID NOT IN (SELECT pcat.cpcCatID FROM cp_roi_ProdCats AS pcat INNER JOIN cp_roi_Cats AS cat ON cat.ccID = pcat.cpcCatID WHERE pcat.cpcID = @cpID) AND ccFamilyID = 1" SelectCommandType="Text">
		<SelectParameters>
            <asp:QueryStringParameter Name="cpID" Type="String" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
	
	<asp:SqlDataSource ID='dataCats' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT pcat.ID AS relID, cat.ccCategory AS Category FROM cp_roi_ProdCats AS pcat INNER JOIN cp_roi_Cats AS cat ON cat.ccID = pcat.cpcCatID WHERE pcat.cpcID = @cpID" SelectCommandType="Text">
        <SelectParameters>
            <asp:QueryStringParameter Name="cpID" Type="String" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
	
	<asp:SqlDataSource ID='dataMeths' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT pmeth.ID AS relID, met.cmName AS Method FROM cp_roi_ProdMeths AS pmeth INNER JOIN cp_roi_Methods AS met ON met.cmID = pmeth.cpmMethID WHERE pmeth.cpmID = @cpID" SelectCommandType="Text">
        <SelectParameters>
            <asp:QueryStringParameter Name="cpID" Type="String" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
