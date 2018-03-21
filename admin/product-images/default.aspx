<%@ Page Language="C#" Title="Product Images" MasterPageFile="~/admin/Site.Master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="news_items" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <script type="text/javascript">
		$(document).ready(function() {
			$(".langSelect option").removeAttr("selected");
			
			$(".langSelect").val("<%=currRegion%>");

			$("#addNew").click(function() {
				$("#formUpload").fadeIn();
			});
			
			loadFunction();

			$("div#formUpload").dropzone({ 
				url: "/admin/product-images/default.aspx/uploadImage",
				createImageThumbnails: true,
				thumbnailWidth: 148,
				thumbnailHeight: null,
				thumbnailMethod: "contain",
				dictDefaultMessage: "Drop product images here to upload",
				acceptedFiles: "image/*",
				addRemoveLinks: true,
				autoProcessQueue: false,
				parallelUploads: 1,
				init: function() {
					var myDropzone = this;
					myDropzone.on("thumbnail", function(file, thumb) { 
						file.thumbnail = thumb.trim();
						//console.log(file.name + " : " + file.thumbnail + " | Thumb: " + thumb);
						myDropzone.processFile(file);
					});
					myDropzone.on("sending", function(file, xhr, formData) {
						//console.log(file);
						//console.log(file.thumbnail);
						if (file.thumbnail != null) {
							var blob = dataURItoBlob(file.thumbnail);
							formData.append("thumb", blob, "thumbnail.png");
						}
					});
				}
			});
			
			$(".btnAdd").click(function() {
				var img = $(this).data("imgid");
				$("#addPart"+img).show().focus();
				$("#savePart"+img).show();
				$("#btnAdd"+img).hide();
			});
			
			$(".btnSavePart").click(function() {
				var img = $(this).data("imgid");
				var part = $("#addPart"+img).val();
				$.ajax({
					url: 'default.aspx/saveImgProduct',
					type: "POST",
					data: JSON.stringify({ id: img, partnum: part }),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						$('#assResult'+img).html(data.d);
						if (data.d.indexOf("Product has been added.") !== -1) {
							$("<div id='close-" + img + "' class='products'>" + part + "<a class='close' data-id='" + img + "'>x</a></div>").insertAfter($('#assResult'+img));
							$("#addPart"+img).hide();
							$("#savePart"+img).hide();
							$("#btnAdd"+img).show();
						}
						$("#addPart"+img).focus();
						loadFunction();
					}
				});
			});
		});
		$(document).mouseup(function(e)  {
			var container = $(".img-details");

			// if the target of the click isn't the container nor a descendant of the container
			if (!container.is(e.target) && container.has(e.target).length === 0)  {
				//$(".img-box").each(function() { $(this).removeClass("selected"); });
				//container.each(function() { $(this).fadeOut("fast"); });
			}
		});
		
		function loadFunction() {
			$(".img-box").mouseover(function(){
				$(".hover-box", this).show();
			}).mouseout(function() {
				$(".hover-box", this).hide();
			});
			
			$(".img-zoom").fancybox();

			$(".img-box").click(function() {
				var id = $(this).data("imgid");
				if ($(this).hasClass("selected")) {
					$("#img-details-" + id).fadeOut("fast");
					$(this).removeClass("selected");
					$(".img-box").each(function() { $(this).removeClass("selected"); });
					$(".img-details").each(function() { $(this).fadeOut("fast"); });
				}else{
					$(".img-box").each(function() { $(this).removeClass("selected"); });
					$(".img-details").each(function() { $(this).fadeOut("fast"); $(this).removeClass("right") });
					$(this).addClass("selected");
					$("#img-details-" + id).fadeIn("fast", function() {
						var elem = document.getElementById("img-details-" + id);
						var rect = elem.getBoundingClientRect();
						if (rect.right > window.innerWidth) {
							$(this).addClass("right");
						}
					});
					var width = $("#img-" + id).width();
					var height = $("#img-" + id).height();
					$("<img />").attr("src", $("#for-dimension-" + id).attr("src"))
					.load(function() {
						width = this.width;   // Note: $(this).width() will not
						height = this.height; // work for in memory images.
						$("#img-dimension-" + id).text(width +" x "+ height + " pixels");
					});
					
					location.replace("#img-details-" + id);
				}
			});
			$(".btnClose").click(function() {
				$(".img-box").each(function() { $(this).removeClass("selected"); });
				$(".img-details").each(function() { $(this).fadeOut("fast"); });
			});
			$(".btnSave").click(function() {
				var img = $(this).data("imgid");
				var tit = $("#title-"+img).val();
				var cap = $("#caption-"+img).val();
				var alt = $("#altText-"+img).val();
				var desc = $("#desc-"+img).val();
				$.ajax({
					url: 'default.aspx/saveImgDetails',
					type: "POST",
					data: JSON.stringify({ id: img, title: tit, caption: cap, alttext: alt, description: desc}),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						$('#result'+img).html(data.d);
						loadFunction();
					}
				});
			});
			
			$(".assignment .products .close").click(function() {
				var id = $(this).data("id");
				removePart(id);
			});
		}

		function dataURItoBlob(dataURI) {
			// convert base64/URLEncoded data component to raw binary data held in a string
			var byteString;
			if (dataURI.split(',')[0].indexOf('base64') >= 0)
				byteString = atob(dataURI.split(',')[1]);
			else
				byteString = unescape(dataURI.split(',')[1]);

			// separate out the mime component
			var mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0];

			// write the bytes of the string to a typed array
			var ia = new Uint8Array(byteString.length);
			for (var i = 0; i < byteString.length; i++) {
				ia[i] = byteString.charCodeAt(i);
			}

			return new Blob([ia], {type:mimeString});
		}
		jQuery.expr.filters.offscreen = function(el) {
		  var rect = el.getBoundingClientRect();
		  return (
				   (rect.x + rect.width) < 0 
					 || (rect.y + rect.height) < 0
					 || (rect.x > window.innerWidth || rect.y > window.innerHeight)
				 );
		};
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
		
		function removePart(id) {
			var answer = confirm("Are you sure you want to unset this Part Number?");
			if (answer){
				//alert("DELETE!")
				$.ajax({
					url: 'default.aspx/removePart',
					type: "POST",
					data: JSON.stringify({ itemid: id }),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (data) {
						$('#result').html(data.d);
						$('#close-'+id).remove();
					}
				});
			}
		}
    </script>
	<style>
		.img-box img { max-width: 100%; }
	</style>
    <section class="featured">
		<div id="result"></div>
        <div class="content-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        Product Images <small><a id="addNew" class="btn btn-primary">Add New</a> </small>
                    </h1>
                    <ol class="breadcrumb">
						<li>
                            <i class="fa fa-fw fa-dashboard"></i> <a href="/admin/dashboard.aspx">Dashboard</a>
                        </li>
                        <li class="active">
                            <i class="fa fa-photo"></i> Product Images
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
			<div id="formUpload" class="dropzone">
			</div>
		</div>
	</div>
	<div class="row">
        <div class="col-lg-3">
            <div class="form-group input-group">
                <span class="input-group-addon">Display</span>                  
                <asp:DropDownList ID="ddlDisplay" runat="server" AutoPostBack="True" CssClass="form-control" OnSelectedIndexChanged="ddlDisplay_SelectedIndexChanged" Width="75px">
                    <asp:ListItem>24</asp:ListItem>
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
			<div class="form-group input-group" style="display:none;">
                <span class="input-group-addon">Language</span>                  
                <asp:DropDownList ID="ddlLang" runat="server" AutoPostBack="True" CssClass="form-control langSelect"  DataSourceID="TableCulture" DataTextField="displayname" DataValueField="id" OnSelectedIndexChanged="ddlLang_SelectedIndexChanged">
                    
                </asp:DropDownList>
            </div>
		</div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div>
                <asp:ListView ID="lvNewsTable" runat="server">
                    <LayoutTemplate>
                        <div id="img-gallery">
							<div runat="server" id="itemPlaceHolder"></div>
							<div class="clear"></div>
						</div>
                    </LayoutTemplate>
                    <ItemTemplate>
						<div class="img-box-container">
							<div id="img-box-<%#Eval("id").ToString()%>" class="img-box" data-imgid="<%#Eval("id").ToString()%>">
								<img id="img-<%#Eval("id").ToString()%>" class="img" src="<%#getThumbnail(Eval("img").ToString())%>" data-imgid="<%#Eval("id").ToString()%>" />
								<div class="hover-box">
									<a href="/images/product_images/<%#Eval("img").ToString()%>" class="img-zoom"><i class="fa fa-search-plus"></i></a>
								</div>
							</div>
							<div id="img-details-<%#Eval("id").ToString()%>" class="img-details">
								<div class="primary-details">
									<div class="pd-img-box">
										<img src="/images/product_images/<%#Eval("img").ToString()%>" id="for-dimension-<%#Eval("id").ToString()%>" />
									</div>
									<div class="pd-img-details">
										<span class="img-name"><b><%#Eval("img").ToString()%></b></span><br />
										<span class="uploaddate"><%# Eval("dateupload", "{0:MMMM dd, yyyy}") %></span><br />
										<!--<span id="img-size-<%#Eval("id").ToString()%>" class="img-size"></span><br />-->
										<span id="img-dimension-<%#Eval("id").ToString()%>" class="img-dimension"></span><br />
										<%--(Eval("defaultImg").ToString() == "False") ? "<a class='del-img' data-imgid='" + Eval("id").ToString() + "'><i class='fa fa-eraser'></i> Delete Image</a>" : "<span style='color:#f0ad4e'>Default Image</span>"--%>
										<a href="/images/product_images/<%#Eval("img").ToString()%>" class="img-zoom" style='color:#f0ad4e'><span>Default Image</span></a>
									</div>
									<div class="clear"></div>
								</div>
								<div class="assignment">
									<div id="assResult<%#Eval("id").ToString()%>"></div>
									<%#getProducts(Eval("id").ToString())%>
									<input type="text" style="margin-right:5px;display:none" id="addPart<%#Eval("id").ToString()%>" class="form-control pull-left btn-sm txtPart" placeholder="Enter Part #" /> 
									<button type="button" style="margin-right:5px;display:none" id="savePart<%#Eval("id").ToString()%>" class="btn btn-primary pull-left btn-sm btnSavePart" data-imgid="<%#Eval("id").ToString()%>"><i class="fa fa-save" aria-hidden="true"></i></button>
									<button id="btnAdd<%#Eval("id").ToString()%>" type="button" class="btn btn-success pull-left btn-sm btnAdd" data-imgid="<%#Eval("id").ToString()%>"><i class="fa fa-plus" aria-hidden="true" title="Add product to use this image."></i></button>
									<div class="clear"></div>
								</div>
								<div class="secondary-details">
									<table>
										<tr>
											<td class="right">URL</td>
											<td><input type="text" class="form-control" style="width:100%" value="http://<%=HttpContext.Current.Request.Url.Host%>/images/product_images/<%#Eval("img").ToString()%>" disabled /></td>
										</tr>
										<tr>
											<td class="right">Title</td>
											<td><input type="text" id="title-<%#Eval("id").ToString()%>" class="form-control" style="width:100%" value="<%#Eval("title").ToString()%>" /></td>
										</tr>
										<tr>
											<td class="right">Caption</td>
											<td><textarea id="caption-<%#Eval("id").ToString()%>" class="form-control" style="width:100%"><%#Eval("caption").ToString()%></textarea></td>
										</tr>
										<tr>
											<td class="right">Alt Text</td>
											<td><input type="text" id="altText-<%#Eval("id").ToString()%>" class="form-control" style="width:100%" value="<%#Eval("altText").ToString()%>" /></td>
										</tr>
										<tr>
											<td class="right">Description</td>
											<td><textarea id="desc-<%#Eval("id").ToString()%>" class="form-control" style="width:100%"><%#Eval("description").ToString()%></textarea></td>
										</tr>
										<tr>
											<td colspan="2">
												<hr style="border-color:#ddd" />
												<div id="result<%#Eval("id").ToString()%>"></div>
												<button type="button" id="btnClose" class="btn btn-danger pull-right btnClose" data-imgid="<%#Eval("id").ToString()%>">Close</button>
												<button type="button" id="btnSave"  style="margin-right:10px;" class="btn btn-success pull-right btnSave" data-imgid="<%#Eval("id").ToString()%>">Save</button>
											</td>
										</tr>
									</table>
								</div>
								<div class="clear"></div>
							</div>
						</div>
                    </ItemTemplate>
                </asp:ListView>    
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="TableContent" runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiprep %>" SelectCommand="SELECT * FROM certiProdImages_List ORDER BY id DESC">
		<SelectParameters>
            <asp:ControlParameter ControlID="ddlLang" Name="region" PropertyName="SelectedValue" Type="String" DefaultValue="1" />
        </SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="TableCulture" runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiprep %>" SelectCommand="SELECT * FROM sp_Culture"></asp:SqlDataSource>
	<asp:DataPager ID="DataPager1" runat="server" PagedControlID="lvNewsTable" QueryStringField="page" class="pagination" PageSize="24">
        <Fields>
            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" />
            <asp:NumericPagerField />
            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
        </Fields>
    </asp:DataPager>
</asp:Content>
