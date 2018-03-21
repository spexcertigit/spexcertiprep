<%@ Page Language="C#" Title="Edit A Page" MasterPageFile="~/admin/Site.Master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="edit_pages" ValidateRequest="false" debug="true"%>
<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <section class="featured">
        <div class="content-wrapper">
			<div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        <i class="fa fa fa-pencil-square-o"></i> Edit A Page
                    </h1>
                    <ol class="breadcrumb">
						<li>
                            <i class="fa fa-fw fa-dashboard"></i> <a href="/admin/dashboard.aspx">Dashboard</a>
                        </li>
                        <li class="active">
                            <i class="fa fa-pencil-square-o"></i> Edit A Page
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
				
				<a href="/admin/edit-custom-standards/" class="list-group-item"><i class="fa fa-pencil-square-o"></i>Edit Custom Standards Page</a>
				<!--<a href="/admin/users/" class="list-group-item"><i class="fa fa-users"></i>  Users</a>
				<a href="/admin/banners/" class="list-group-item"><i class="fa fa-bullhorn"></i>  Notification Banner </a>
                <a href="/admin/news/" class="list-group-item"><i class="fa fa-newspaper-o"></i>  News </a>
                <a href="/admin/events/" class="list-group-item"><i class="fa fa-calendar"></i>  Events</a>
                <a href="/admin/careers/" class="list-group-item"><i class="fa fa-suitcase"></i>  Careers </a>-->
            </div>
		</div>
		<div class="col-lg-6">
			<div class="list-group"> 
				<!--<a href="/admin/question/" class="list-group-item"><i class="fa fa-question-circle"></i>  "Ask A Chemist" Question</a>	
				<a href="/admin/literatures/" class="list-group-item"><i class="fa fa-book"></i>   Product Literatures</a>
				<a href="/admin/sliders/" class="list-group-item"><i class="fa fa-image"></i>   Sliders</a>
                <a href="/admin/cannabis/" class="list-group-item"><i class="fa fa-pagelines"></i>  Cannabis Pages </a>
                <a href="/admin/cannabisupdates/" class="list-group-item"><i class="fa fa-leaf"></i>  Cannabis Updates</a>-->
            </div>
		</div>
	</div>
	
</asp:Content>

