<%@ Page Language="C#" Title="Dashboard" MasterPageFile="Site.Master" AutoEventWireup="true" CodeFile="dashboard.aspx.cs" Inherits="dashboard" %>
<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <section class="featured">
        <div class="content-wrapper">
			<div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        <i class="fa fa-fw fa-dashboard"></i> <%: Title %>
                    </h1>
                    <ol class="breadcrumb">
                        <li class="active">
                            <i class="fa fa-fw fa-dashboard"></i> Dashboard</a>
                        </li>
                    </ol>
                </div>
            </div>            
        </div>
    </section>
</asp:Content>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <div class="row">
		<div class="col-lg-6">
			<div class="list-group">
				<a href="/admin/orders/" class="list-group-item"><i class="fa fa-list-alt"></i>   Web Order Details</a>
				<a href="/admin/users/" class="list-group-item"><i class="fa fa-users"></i>  Users</a>
				<a href="/admin/banners/" class="list-group-item"><i class="fa fa-bullhorn"></i>  Notification Banner </a>
                <a href="/admin/news/" class="list-group-item"><i class="fa fa-newspaper-o"></i>  News </a>
                <a href="/admin/events/" class="list-group-item"><i class="fa fa-calendar"></i>  Events</a>
                <a href="/admin/careers/" class="list-group-item"><i class="fa fa-suitcase"></i>  Careers </a>
            </div>
		</div>
		<div class="col-lg-6">
			<div class="list-group"> 
				<a href="/admin/question/" class="list-group-item"><i class="fa fa-question-circle"></i>  "Ask A Chemist" Question</a>	
				<a href="/admin/literatures/" class="list-group-item"><i class="fa fa-book"></i>   Product Literatures</a>
				<a href="/admin/sliders/" class="list-group-item"><i class="fa fa-image"></i>   Sliders</a>
                <a href="/admin/cannabis/" class="list-group-item"><i class="fa fa-pagelines"></i>  Cannabis Pages </a>
                <a href="/admin/cannabisupdates/" class="list-group-item"><i class="fa fa-leaf"></i>  Cannabis Updates</a>
            </div>
		</div>
	</div>
	<div class="row">	
		<div class="col-lg-6">
			<div class="list-group"> 
				<a  class="list-group-item aspNetDisabled" style="color:#999"><i class="fa fa-database"></i> Categories</a>
				<a href="/admin/products/" class="list-group-item"><i class="fa fa-diamond"></i> Products</a>
				<a href="/admin/product-images/" class="list-group-item"><i class="fa fa-image"></i> Product Images</a>
				<a  class="list-group-item aspNetDisabled" style="color:#999"><i class="fa fa-files-o"></i> Pages</a>
				<a href="/admin/videos/" class="list-group-item"><i class="fa fa-youtube-play"></i> Videos</a>	
				<a href="/admin/spex-speaker/" class="list-group-item"><i class="fa fa-microphone"></i> SPEX Speaker</a>
            </div>
		</div>
		<div class="col-lg-6">
			<div class="list-group">
				<a href="/admin/administerwebinars/" class="list-group-item"><i class="fa fa-cloud-upload"></i> Administer Webinars</a>
				<a href="/admin/post-survey/" class="list-group-item"><i class="fa fa-bar-chart"></i> Post Survey</a>			
				<a href="/admin/survey/" class="list-group-item"><i class="fa fa-area-chart"></i> Survey</a>	
				<a href="/admin/optimizedownload/" class="list-group-item"><i class="fa fa-download"></i> Optimize Downloads</a>
				<a href="/admin/optimize/" class="list-group-item"><i class="fa fa-gears"></i> Optimize Issues</a>
            </div>
		</div>
	</div>
</asp:Content>

