<%@ Page Title="" Language="C#" Debug="true" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default"%>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
	<style type="text/css">
		#youtubepopup
		{
			border: 0 none;
			border-radius: 15px;
			display: none;
			height: 332px;
			left: 33%;
			position: fixed;
			top: 28%;
			width: 560px;
			z-index: 9999;
			background-color: white;
			padding:15px;
		}
		#lowerabody
		{
			width:100%;
			margin-bottom: 20px;
		}
		
		.lowerabody-header h3
		{
			font-size:24px;;
			width:50%;
			float:left;
		}
		.lowerabody-viewall
		{
			width: 30%;
			float: right;
			color: #9fa615;
			font-size: 16px;
			text-align: right;
			margin-top: 6px;
			font-style: italic;
		}
		.lowerabody-newsholder
		{
			width:100%;
			margin-top: 22px;
		}
		.page_margins
		{
			width:100%;
		}
		.top-searchbar {
		float: none !important;
		}
		#breadcrumb
		{
			display:none!important;
		}
		#content
		{
			padding-bottom: 40px;
			width: 100%;
			z-index: -2;
		}
		#mainContent {
			width:960px;
			margin: 0 auto;
		}
		.nav-go {
			background-color: transparent;
		}
	</style>
	
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server">
</asp:Content>
<asp:Content ID="ContentHeader" ContentPlaceHolderID="cpPageBanner" Runat="Server">
	<div id="youtubepopup">
		<a href='javascript:void(0);' onclick='youtubeclose()'>Close</a>
		<iframe id="youtubeiframe" width="560" height="315" src="" frameborder="0" allowfullscreen></iframe>
	</div>
	<div class="slideContainer">
		<div class="slide-wrapper">
			
			<div class="category-box-links">	 
				<a href="/products/inorganic/" title="Inorganic Standards">
					<div class="sidebtn inorganic">Inorganic Standards</div>
				</a>
				<a href="/products/organic/" title="Organic Standards">
					<div class="sidebtn organic">Organic Standards</div>
				</a>
				<a href="/products/custom-standards.aspx" title="Custom Products">
					<div class="sidebtn custom">Custom Products</div>
				</a>
				<a href="/knowledge-base/periodic-table" title="Interactive Periodic Table">
					<div class="sidebtn ipt">Interactive Periodic Table</div>
				</a>
				<a href="/knowledge-base/MSDS.aspx" title="SDS">
					<div class="sidebtn sds">SDS</div>
				</a>
				<br style="clear:both;">
			</div>
			
			<div class="slide-wrapper2">
				<div id="slideshow">
					<div id="slideshowWindow">
						<%=getSlides()%>
					</div>
					<span class="slideControl">
						<ul class="nav">
							<%=getSlideNav()%>
							<li><p id="play" class="play-pause-1"></li>
							<li><p id="stop" class="play-pause-0"></li>
						</ul>
					</span>
				</div>
			</div>
							 
			
		</div>
		<div style="clear:both"></div>
	</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
	<div id="mainContent">
		<br style='clear:both;'/>	
		<div class="after-768"></div>
		<div class="moblie-category-box-links">	 			 
			<div class="organicbox sliderlinkboxes" onclick="window.location = '/products/organic/'">
				<div>
					<div style="float:left;">
						<img class="organicboximg" src="/images/organic.png">
					</div>
					<div class="sliderlinklabels">
						<h2>Organic <br> Standards</h2>
					</div>	
					<br style="clear:both;">								
				</div>
			</div>
								 
			<div class="inorganicbox sliderlinkboxes" onclick="window.location = '/products/inorganic/'">
				<div>
					<div style="float:left;">
						<img class="inorganicboximg" src="/images/inorganic.png">
					</div>
					<div class="sliderlinklabels">
						<h2>Inorganic <br> Standards</h2>
					</div>	
					<br style="clear:both;">								
				</div>	 
			</div>
								 
			<div class="labstuffbox sliderlinkboxes" onclick="window.location = '/search_labstuff.aspx'">
				<div>
					<div style="float:left;">
						<img class="labstuffboximg" src="/images/labsupplies.png">
					</div>
					<div class="sliderlinklabels">
						<h2>Laboratory <br> Products</h2>
					</div>	
					<br style="clear:both;">								
				</div>	 	 
			</div>	 				 
			<br style="clear:both;">
		</div>
		<div class="intro_text"><div class="intro_badge"><a href="/about-us/certifications.aspx"><img src="/images/badge-iso.png"></a></div><h1 class="intro_h1">SPEX CertiPrep</h1>&nbsp;has been servicing the scientific community since 1954.  We are a leading manufacturer of Certified Reference Materials (CRMs) and Calibration Standards for Analytical Spectroscopy and Chromatography. We offer a full range of Inorganic and Organic CRMs. We are certified by DQS to ISO 9001:2015 and are proud to be accredited by A2LA to ISO/IEC 17025:2005 and ISO 17034:2016. The scope of our accreditation is the most comprehensive in the industry and encompasses all our manufactured products.</div>				 
		
		<div class="col2-content">
						
			<div class="col2-main">
				<!--Default Category Links-->
				<div class="row">
					<div class="col-lg-12">
						<div class="default_category_links">
							<div class="category_links">
								<div class="inorganic_col">
									<div class="col_header"><a href="/products/inorganic/"><h2>Inorganic Products</h2></a></div>
									<ul>
										<li><a href="/inorganic-standards/aa-icp-standards">AA/ICP Standards</a></li>
										<li><a href="/inorganic-standards/clp-standards">CLP Standards</a></li>
										<li><a href="/inorganic-standards/icp-ms-standards">ICP-MS Standards</a></li>
										<li><a href="/30mL-plasma-shots/">30mL Plasma Shots&reg;</a></li>
										<li><a href="/testing-kits/">Testing Kits</a></li>                               
										<li><a href="/inorganic-standards/ic-ise-standards">IC/ISE Standards</a></li>
										<li><a href="/inorganic-standards/organometallic-oil-standards">Organometallic Oil Standards</a></li>
									</ul>
									<ul>
										<li><a href="/inorganic-standards/fusion-fluxes">XRF / Fusion</a></li>
										<li><a href="/products/USP">USP Standards</a></li>
										<li><a href="/inorganic_international.aspx">Inorganic International</a></li>
										<li><a href="/knowledge-base/speciation">Speciation Standards</a></li>
										<li><a href="/knowledge-base/carbon-black-reagents">Carbon Black</a></li>
										<li><a href="/inorganic-standards/consumer-safety-standards-inorganic">Consumer Safety Standards </a></li>
									</ul>
									<div class="clear"></div>
								</div>
								<div class="organic_col">
									<div class="col_header"><a href="/products/organic/"><h2>Organic Products</h2></a></div>
									<ul>
										<li><a href="/organic-standards/gas-chromatography-and-mass-spectrometry">GC/MS Standards</a></li>
										<li><a href="/ECS/">ECS Standards for GC/MS</a></li>
										<li><a href="/organic-standards/liquid-chromatography-and-mass-spectrometry">LC/MS Standards</a></li>
										<li><a href="/products/pesticides">Pesticide Standards</a></li>
										<li><a href="/products/USP">USP Standards</a></li>
										<li><a href="/products/Wine-Standards/">Standards for Wine</a></li>
                                        <li><a href="/products/cannabis">Cannabis</a></li>
									</ul>
									<ul>
										<li><a href="/organic_international.aspx">Organic International</a></li>
										<li><a href="/knowledge-base/speciation">Speciation Standards</a></li>
										<li><a href="/organic-standards/consumer-safety-standards-organic">Consumer Safety Standards </a></li>
										<li><a href="/organic-standards/semivolatiles">Semivolatiles</a></li>
										<li><a href="/organic-standards/volatiles">Volatiles</a></li>
									</ul>
									<div class="clear"></div>
								</div>
							</div>
							<div class="clear"></div>
						</div>
					</div>
				</div>
				<!--EOF Default Category Links-->
				
				<div class="upcoming_events">
					
					<asp:ListView ID="lvUpNews" runat="server" DataSourceID="dataUpNews">
						<LayoutTemplate>
							<h2>Upcoming <span class="greentext">Events</span></h2>
							<a href="/news-and-events/tradeshow-calendar.aspx" target="_blank" class="lowerabody-viewall">View All Events</a>
							<div class="event_slideshow_wrapper">
								<div class="event_slideshow">
									<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
								</div>
								<p class="nw_nav prv"></p>
								<p class="nw_nav nxt"></p>
							</div>
							<div class="clear"></div>
						</LayoutTemplate>
						<ItemTemplate>
							<div class="slide_news">
								<div class="evnt_image">
									<img src="/images/events/<%# Eval("ImageUrl").ToString() == "" ? "def-img.gif" : Eval("ImageUrl").ToString() %>" height="90">
								</div>
								<div class="evnt_details">
									<span class="evnt_title"><%# Eval("Headline")%></span><br />
									<span class="evnt_date"><%# string.Format("{0:MMM dd, yyyy}", Eval("EventDate"))%><%# GetEndDate(string.Format("{0:MMM dd, yyyy}", Eval("EventDate")), string.Format("{0:MMM dd, yyyy}", Eval("EventEndDate"))) %>
									</span> <br/>
									<span class="evnt_location"><%# Eval("EventLocation")%></span><br />
								</div>
							</div>
						</ItemTemplate>
						<EmptyDataTemplate>
									
						</EmptyDataTemplate>
					</asp:ListView> 		
				</div>
				
			</div>

			<br style='clear:both;'/>
			
		</div>		
		
		<br/><br/><br/>	
		<div id='lowerabody'>
			<div id='lowerabody-left'>
				<div class="row">
					<div class="col-lg-12">
						<div class='lowerabody-header'>
							<h2>Featured <span style='color:#9fa615;'>Videos</span></h2>
							<a href='http://www.youtube.com/user/SPEXCertiPrep' target="_blank" class='lowerabody-viewall'>View All Videos</a>
							<br style='clear:both;'/>	
						</div>
					</div><br/>
					<asp:ListView ID="lvFeatured" runat="server" PageSize="5">
						<LayoutTemplate>
							<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
						</LayoutTemplate>
						<ItemTemplate>
							<div class="col-lg-3">
								<div style="padding:8px;">
									<div class="video_wrap">
										<!--<iframe width="218" height="142" src="https://www.youtube.com/embed/<%# getYoutube(Eval("VideoUrl").ToString())%>" frameborder="0" allowfullscreen></iframe>-->															
										<div class="video_container" style='background:url(https://img.youtube.com/vi/<%# getYoutube(Eval("VideoUrl").ToString())%>/0.jpg) no-repeat center #000; background-size: 100%;'>
											<img src="/images/youtubebutton.png" style="margin-top: 48px;margin-left: 75px;cursor:pointer;" onclick="youtubepopup('https://www.youtube.com/embed/<%# getYoutube(Eval("VideoUrl").ToString())%>')">
										</div>
									</div>
									<div class="video_details">
										<strong><%# Eval("Title") %></strong><br />
										<div class="video-ellipsis-box">
											<%# Excerpt(Eval("body").ToString())%>
										</div>
										<a href="<%# Eval("VideoUrl")%>" class="newsitem video-lnk">
											<span style='font-size: 14px;float: left;margin-top: 2px;font-style:italic;text-decoration:underline;'>Watch Video</span>
										</a>
									</div>	
									<br style="clear:both;">								
								</div>	 
							</div>								
						</ItemTemplate>
						<EmptyDataTemplate>
							<h3>There are no Videos for this time.</h3>
						</EmptyDataTemplate>
					</asp:ListView> 
					<asp:DataPager ID="NewsPager2" runat="server" PagedControlID="lvFeatured" QueryStringField="pg" PageSize="4"></asp:DataPager>		
				</div>
			</div>
			<div id='lowerabody-right'>
				<div class="row">
					<div class="col-lg-12">
						<div class='lowerabody-header'>
							<h2>Latest <span style='color:#9fa615;'>News</span></h2>
							<a href='/news-and-events/news_updates.aspx' class='lowerabody-viewall'>View All News</a>
							<br style='clear:both;'/>
						</div>
					</div><br/>
					<asp:ListView ID="lvNews" runat="server" PageSize="5">
						<LayoutTemplate>
							<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
						</LayoutTemplate>
						<ItemTemplate>
							<div class="col-lg-3">
								<div>
									<div class="news_thumb">
										<div class="news_thumb_hider">
											<img src="/news-and-events/uploads/<%# (Eval("thumb").ToString() == "") ?  "defaultnews.jpg" : Eval("thumb")%>" />
										</div>
									</div>
									<div class="news_details">
										<strong><%# Eval("title") %></strong><br />
										<div class="news-ellipsis-wrapper">
											<div class="news-ellipsis-box">
												Posted <%# string.Format("{0:d}", Eval("posteddate")) %> | <%# Excerpt(Eval("body").ToString())%>
											</div>
										</div>
										<a href="/news-and-events/news.aspx?id=<%# Eval("id")%>" class="newsitem">
											<span style='font-size: 14px;float: left;margin-top: 2px;font-style:italic;text-decoration:underline;'>Read more</span>
										</a>
									</div>	
									<br style="clear:both;">								
								</div>	 
							</div>								
						</ItemTemplate>
						<EmptyDataTemplate>
							<h3>There are no news stories for this category.</h3>
						</EmptyDataTemplate>
					</asp:ListView> 
					<!--<asp:DataPager ID="NewsPager" runat="server" PagedControlID="lvNews" QueryStringField="pg" PageSize="4"></asp:DataPager>-->
				</div>
				<br style='clear:both;'/>	
				<div class="spexertificate-box">
					<a href=""><img src="/images/SPEXertificate.jpg" /></a>
				</div>
				<div class="materialsafety-box">
					<a href=""><img src="/images/MaterialSafety.jpg" /></a>
				</div>
			</div>
		</div>
		
		
	</div>
										
	<asp:SqlDataSource ID='dataNews' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
		SelectCommand="SELECT id, title, category, body, posteddate, active, thumb FROM news WHERE category IN ('1','2','3','7','8') AND active = '1' ORDER BY posteddate DESC" SelectCommandType="Text">
	</asp:SqlDataSource> 	

	<asp:SqlDataSource ID='dataFeatured' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
		SelectCommand="SELECT Id,Title,VideoUrl,body,PostDate FROM FeaturedVideo WHERE active = '1' ORDER BY PostDate DESC" SelectCommandType="Text">
	</asp:SqlDataSource> 
	
	<asp:SqlDataSource ID='dataUpNews' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
		SelectCommand="SELECT * FROM cms_Event WHERE Site = 'cp' AND IsActive = 1 AND (EventDate >= GETDATE() OR EventEndDate >= GETDATE()) ORDER BY EventDate ASC" SelectCommandType="Text">
	</asp:SqlDataSource>	
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script type="text/javascript">
		$(function () {
			var currentPosition = 0;
			var slideWidth = 630;
			var slides = $('.slide');
			var numberOfSlides = slides.length;
			$('#play').hide();
			$('#stop').show();
			
			slides.wrapAll('<div id="slidesHolder"></div>');
			slides.css({ 'float': 'left' });
			
			$('#slidesHolder').css('width', slideWidth * numberOfSlides);
			
			$('.nav-go').click(function() {
				var targetPosition = $(this).attr('id');
				currentPosition = targetPosition - 1;
				moveSlide();
				$('.nav-go').css('backgroundPosition', '-19px 0');
				$(this).css('backgroundPosition', '0 0');
			});
			
			$(".video-lnk").click(function() {
				$.fancybox({
					'padding'		: 0,
					'autoScale'		: false,
					'transitionIn'	: 'none',
					'transitionOut'	: 'none',
					'title'			: this.title,
					'width'			: 640,
					'height'		: 385,
					'href'			: this.href.replace(new RegExp("watch\\?v=", "i"), 'v/'),
					'type'			: 'swf',
					'swf'			: {
					'wmode'				: 'transparent',
					'allowfullscreen'	: 'true'
					}
				});

				return false;
			});
			function runSlideShow() {
				setInterval(changePosition, 6000);
			}
			
			function changePosition() {
				if (currentPosition == numberOfSlides - 1) {
					currentPosition = 0;
				}
				else {
					currentPosition++;
				}
				$('.nav-go').css('backgroundPosition', '-19px 0');
				
				var countPosition = currentPosition + 1;
				$('.nav-go[id=' + countPosition + ']').css('backgroundPosition', '0 0');
				
				moveSlide();
			}

			function moveSlide() {
				$('#slidesHolder').animate({ 'marginLeft': slideWidth * (-currentPosition) },3500);
			}
			
			
			var interval = null;
			
			$('#stop').click( function() {
				clearInterval(interval);
				$('#slidesHolder').stop();
				showPlay();
			});
			
			$('#play').click( function() {
				clearInterval(interval);
				interval = setInterval(changePosition, 17000);
				//runSlideShow();
				showPause();
			});
			
			interval = setInterval(changePosition, 17000);
			
			function showPause() {
				$('#play').parent().hide();
				$('#stop').parent().show();
				$('#play').hide();
				$('#stop').show();
			}
			
			function showPlay() {
				$('#stop').parent().hide();
				$('#play').parent().show();
				$('#stop').hide();
				$('#play').show();
			}
		});
	</script>
	<script type="text/javascript">
		var buttons = new Array(7);
		buttons[0] = "certiprep_frontpage_links";
		buttons[1] = "certiprep_frontpage_links_ask";
		buttons[2] = "certiprep_frontpage_links_loyal";
		buttons[3] = "certiprep_frontpage_links_email";
		buttons[4] = "certiprep_frontpage_links_cal";
		buttons[5] = "certiprep_frontpage_links_news";
	</script>
	
	<script type="text/javascript">
		$(document).ready(function() {
			function open_chat_win() {
				var w = 640, h = 480;
				if (document.all || document.layers) {
				   w = screen.availWidth;
				   h = screen.availHeight;
				}
				var leftPos = (w-640)/2, topPos = (h-480)/2;
				xlaALSwindow=window.open("http://spexcsp.com/chat/UserPreChat.aspx?ref=http%3a%2f%2fdev.spexcertiprep.com%2fdefault.aspx&d=1&u=&bypass=","ALSRoom","toolbar=0,location=0,status=0,menubar=0,scrollbars=1,resizable=1,width=640,height=480,top=" + topPos + ",left=" + leftPos);
				xlaALSwindow.focus();
			}
			$("li.live_chat_click").click(function() {
				//$('topa-right_link.chat a').click();
				open_chat_win();
			})
			//alert($(".BannerSection .BannerImage.left img").length);
			if ($(".BannerSection .BannerImage.left img").length == "0") {
				$(".BannerSection").css("min-height","0px");
			}
		});
	</script>	
	
	<!-- UPCOMING EVENTS -->
	<script type="text/javascript">
		$(function () {
			var nw_currentPosition = 0;
			var nw_slideWidth = $(".slide_news").width() * 2;
			var nw_slides = $('.slide_news');
			var nw_numberOfSlides = Math.ceil(nw_slides.length / 2);
			if (nw_slideWidth <= 384) {
				$(".evnt_date").each(function(){
					var event_date = "";
					var day1 = "";
					var day2 = "";
					event_date = $(this).text().split("–");
					if (event_date.length == 2) {
						day1 = event_date[0].split(" ");
						day2 = event_date[1].split(" ");
						if (day1[0] == day2[1]) {
							var combined_date = day1[0] + " " + day1[1].substring(0,2) +" - " + day2[2] + " " + day1[2];
							$(this).text(combined_date);
						}
					}
				});
			}
			console.log("Width: " + nw_slideWidth + "| Slides: " + nw_numberOfSlides);
			setInterval(function(){
				/*if (nw_slideWidth <= 384) {
					$(".evnt_date").each(function(){
						var event_date = "";
						var day1 = "";
						var day2 = "";
						event_date = $(this).text().split("–");
						if (event_date.length == 2) {
							day1 = event_date[0].split(" ");
							day2 = event_date[1].split(" ");
							if (day1[0] == day2[1]) {
								var combined_date = day1[0] + " " + day1[1].substring(0,2) +" - " + day2[2] + " " + day1[2];
								$(this).text(combined_date);
							}
						}
					});
				}
				if ($(window).width() >= 751 && $(window).width() <= 959) {
					$(".col2-content").after($(".upcoming_events"));
					$(".intro_badge").after("<div style='clear:both'></div>");
				}else {
					$(".default_category_links").after($(".upcoming_events"));
				}*/
			}, 1000);

			nw_slides.wrapAll('<div id="slide_newsHolder"></div>');
			nw_slides.css({ 'float': 'left' });
			
			$('#slide_newsHolder').css('width', nw_slideWidth * nw_numberOfSlides);
			
			$('.nw_nav.nxt').click(function() {
				if (nw_currentPosition == nw_numberOfSlides - 1) {
					nw_currentPosition = 0;
				}
				else {
					nw_currentPosition++;
				}
				
				nw_moveSlide();
			})
			$('.nw_nav.prv').click(function() {
				if (nw_currentPosition == 0) {
					nw_currentPosition = nw_numberOfSlides - 1;
				}
				else {
					nw_currentPosition--;
				}
				nw_moveSlide();
			})			

			function nw_moveSlide() {
				$('#slide_newsHolder').animate({ 'marginLeft': nw_slideWidth * (-nw_currentPosition) });
				console.log("Width: " + nw_slideWidth + "| Slides: " + nw_numberOfSlides);
			}
		});
	</script>		
		<!-- Google Code for Homepage Conversion Page -->
		<script type="text/javascript">
		/* <![CDATA[ */
		var google_conversion_id = 1051567786;
		var google_conversion_language = "en";
		var google_conversion_format = "3";
		var google_conversion_color = "ffffff";
		var google_conversion_label = "GkPoCPHd4WgQqs229QM";
		var google_remarketing_only = false;
		/* ]]> */
		</script>
		<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
		</script>
		<noscript>
		<div style="display:inline;">
		<img height="1" width="1" style="border-style:none;" alt="" src="//www.googleadservices.com/pagead/conversion/1051567786/?label=GkPoCPHd4WgQqs229QM&amp;guid=ON&amp;script=0"/>
		</div>
		</noscript>
		
		<script type="application/ld+json">
		{
		  "@context" : "http://schema.org",
		  "@type" : "WebSite",
		  "name" : "SPEX CertiPrep",
		  "alternateName" : "SPEX CertiPrep",
		  "url" : "http://www.spexcertiprep.com/",
		  "potentialAction": {
			"@type": "SearchAction",
			"target": "http://www.spexcertiprep.com/search.aspx?search={search_term_string}",
			"query-input": "required name=search_term_string"
		  }
		}
		</script>			
		<script type="application/ld+json">
		{
		 "@context": "http://schema.org",
		 "@type": "BreadcrumbList",
		 "itemListElement":
		 [
		  {
		   "@type": "ListItem",
		   "position": 1,
		   "item":
		   {
			"@id": "http://www.spexcertiprep.com/about-us/corporate-profile.aspx",
			"name": "Corporate Profile"
			}
		  },
		  {
		   "@type": "ListItem",
		  "position": 2,
		  "item":
		   {
			 "@id": "http://www.spexcertiprep.com/about-us/sales-reps.aspx",
			 "name": "Sales Representatives"
		   }
		  },
		  {
		   "@type": "ListItem",
		  "position": 3,
		  "item":
		   {
			 "@id": "http://www.spexcertiprep.com/contact-us.aspx",
			 "name": "Contact Us"
		   }
		  }
		 ]
		}
		</script>
</asp:Content>

