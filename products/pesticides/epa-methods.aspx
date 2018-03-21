<%@ Page Title="EPA Methods | SPEX CertiPrep" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="epa-methods.aspx.cs" Inherits="search" debug="true" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <script src="/js/jquery-ui.js" type="text/javascript"></script>
	<style type="text/css">
		#name {
			*padding-top:11px;
			*height: 22px !important;
		}	
		#email {
			*padding-top:11px;
			*height: 22px !important;
		}
		#breadcrumb {padding:0;}
	</style>
	<script>
		$(document).ready(function () {
			$('#banner-div').show();
		});
	</script>	
		
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/">Home</a> > <a href="/products/pesticides">Pesticides Standards</a> > EPA Methods</asp:Content>
<asp:Content ID="ContentHeader" ContentPlaceHolderID="cpPageBanner" Runat="Server">
	<div id="banner-div" class="pesticides">
		<!--<img class="category-banner-img" src="img/category-banner-organic.png" alt="Organic Certified Reference Materials" />-->
		<div class="banner-label-wrapper">
			<!--<img class="banner-label" src="img/banner-organic-label.png">-->
			<h1 class="banner-header pesticides">EPA Methods</h1>
		</div>
		<div class="banner-shadow"></div>
	</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
<script>
	$(document).ready(listenWidth);
	$(document).load($(window).bind("resize", listenWidth));

    function listenWidth( e ) {
        if($(window).width()<737)
        {
            $(".c30l").remove().insertAfter($(".c66r"));
        } else {
            $(".c30l").remove().insertBefore($(".c66r"));
        }
    }
</script>
        <div id="main">
            <div class="subcolumns">
				<div class="c30l">
					<div class="side-module">
						<h2 id="updates">Methods</h2>
						<div class="pesticides-side">
							<asp:DropDownList ID="s_method" CssClass="select-tech" ClientIDMode="Static" DataSourceID="dataMethod" DataValueField="slug" DataTextField="slug" runat="server" AppendDataBoundItems="true">
								<asp:ListItem Value="0" Text="-- Select Method --" />
							</asp:DropDownList>
						</div>
					</div>
					
					<div class="side-module">
						<h2 id="updates">Latest Product Updates</h2>
						<div class="organic-side">
							<ul>
								<asp:Literal ID="ltrCannabisUpdate" runat="server" />
							</ul>
						</div>
					</div>
					
					
				</div>
				
    		    <div class="c66r" id="main_page">
					<div id="banner-p">	
						<div>
							<div class="classy">
								<img src="/images/water-drop.png" /> Drinking Water
							</div>
							<asp:Literal ID="ltrDR" runat="server" />
							<div class="clearboth"></div>
						</div>
						
						<div>
							<div class="classy">
								<img src="/images/water-drop.png" /> Municipal & Industrial Waste
							</div>
							<asp:Literal ID="ltrMIW" runat="server" />
							<div class="clearboth"></div>
						</div>
						
						<div>
							<div class="classy">
								<img src="/images/water-drop.png" /> Environmental Samples
							</div>
							<asp:Literal ID="ltrES" runat="server" />
							<div class="clearboth"></div>
						</div>
						
						<div>
							<div class="classy">
								<img src="/images/water-drop.png" /> Misc.
							</div>
							<asp:Literal ID="ltrMisc" runat="server" />
							<div class="clearboth"></div>
						</div>
						
						<div id="go-top">
							<a href="#top">Back to top &#9650;</a> 
						</div>
						
					</div>
					
				</div>
			</div>
		</div>
	<asp:SqlDataSource ID='dataMethod' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT * FROM certiPesticidesMethods ORDER BY id" SelectCommandType="Text">
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
    <script type="text/javascript">
		$(document).ready(function(){
			$('a[href^=#]').click(function(event){		
				event.preventDefault();
				$('html,body').animate({scrollTop:$(this.hash).offset().top}, 2000);
			});
			
			$('#s_method').change(function() {
				location.replace('/products/pesticides/' + $(this).val());
			});
		});
	</script>
</asp:Content>

