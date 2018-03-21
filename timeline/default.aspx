<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="timeline" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
	<style type="text/css">
	.page_margins { width:100%; }
	.header-topa, #breadcrumb, .header-topa-blockb, .header-topa-nav { display:none; }
	.simple-footer { position:relative; z-index:2; }
	.footer-wrapper {
		position: relative ! important;
		bottom: 0;
		width: 100%;
		z-index: 2;	
	}
	#content { padding-bottom:0; }	
	</style>
	<script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="/js/jquery.stellar.min.js"></script>
	<script type="text/javascript" src="/js/waypoints.min.js"></script>
	<script type="text/javascript" src="/js/jquery.easing.1.3.js"></script>
	<script type="text/javascript" src="/js/jquery.sticky.js"></script>
    <script type="text/javascript">
	jQuery(document).ready(function ($) {
		//initialise Stellar.js
		$(window).stellar();
		
		$.stellar ({
			verticalScrolling: true,
			horizontalScrolling:false
		})
		
		//Cache variables for Stellar.js in the document
		var links = $('.navigation').find('li');
		slide = $('.slide');
		button = $('.button');
		mywindow = $(window);
		htmlbody = $('html,body');
		//Set up for waypoints navigation
		slide.waypoint(function (direction) {
			//cache the variable of the data-slide attribute associated with each slide
			dataslide = $(this).attr('data-slide');

			//If the user scrolls up change the navigation link that has the same data-slide attribute as the slide to active and
			//remove the active class from the previous navigation link
			if (direction === 'down') {
				$('.navigation li[data-slide="' + dataslide + '"]').addClass('active').prev().removeClass('active');
				
			}
			// else If the user scrolls down change the navigation link that has the same data-slide attribute as the slide to active and
			
			//remove the active class from the next navigation link
			else {
				$('.navigation li[data-slide="' + dataslide + '"]').addClass('active').next().removeClass('active');
			}
		});
		
		//Create a function that will be passed a slide number and then will scroll to that slide using jquerys animate. The Jquery
		//easing plugin is also used, so we passed in the easing method of 'easeInOutQuint' which is available throught the plugin.
		function goToByScroll(dataslide) {
			htmlbody.animate({
			scrollTop: $('.slide[data-slide="' + dataslide + '"]').offset().top
			}, 2000, 'easeInOutQuint');
		}

		//When the user clicks on the navigation links, get the data-slide attribute value of the link and pass that variable to the goToByScroll function
		links.click(function (e) {
			e.preventDefault();
			dataslide = $(this).attr('data-slide');
			goToByScroll(dataslide);
		});
		
		function goTopBotByScroll(dataslide) {
			htmlbody.animate({
			scrollTop: $('.tags[data-slide="' + dataslide + '"]').offset().top
			}, 2000, 'easeInOutQuint');
		}
		
		$('.goto').click(function (e) {
			e.preventDefault();
			dataslide = $(this).attr('data-slide');
			goTopBotByScroll(dataslide);
		});		

		//When the user clicks on the button, get the get the data-slide attribute value of the button and pass that variable to the goToByScroll function
		button.click(function (e) {
			e.preventDefault();
			dataslide = $(this).attr('data-slide');
			goToByScroll(dataslide);
		});
		//Mouse-wheel scroll easing
		if (window.addEventListener) window.addEventListener('DOMMouseScroll', wheel, false);
		window.onmousewheel = document.onmousewheel = wheel;
		var time = 350;
		var distance = 100;
		function wheel(event) {
			if (event.wheelDelta) delta = event.wheelDelta / 50;
			else if (event.detail) delta = -event.detail / 1;
				handle();
			if (event.preventDefault) event.preventDefault();
				event.returnValue = false;
		}
		function handle() {

			$('html, body').stop().animate({
				scrollTop: $(window).scrollTop() - (distance * delta)
			}, time);
		}

		//keyboard scroll easing
		$(document).keydown(function (e) {
			switch (e.which) {
			//up
			case 38:
				$('html, body').stop().animate({
				scrollTop: $(window).scrollTop() - distance
				}, time);
			break;
			//down
			case 40:
				$('html, body').stop().animate({
				scrollTop: $(window).scrollTop() + distance
				}, time);
			break;
			}
		});
		
	});
    </script>
	<script>
	//var st = jQuery.noConflict();
	$(document).ready(function(){
		$(".header-b").sticky({topSpacing:-41}); 
		$("#header-b2").sticky({topSpacing:-41}); 
		$("#header-b2-sticky-wrapper").css("height", "0px");
	});
	</script>
	<script type="text/javascript">
		$(function () {
			$(".sticky-wrapper").css("height", "94px");
			$(".sticky-wrapper").css("overflow", "visible");
		});
	</script>
	<!--[if IE 7]>
		<script>
			$(function() {
				   var zIndexNumber = 1000;
				   // Put your target element(s) in the selector below!
				   $(".slide").each(function() {
						   $(this).css('zIndex', zIndexNumber);
						   zIndexNumber -= 10;
				   });
				$("#slide1").append($(".building-bg"));
				$(".headerAfter").css("z-index", "2000");
				$(".header-b").css("z-index", "1900");
				$(".building-bg").css("display", "none");
			});
		</script>
	<![endif]-->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server">

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
	<div class="tags" data-slide="top"></div>
	<div class="wrapper-header">
		<div class="homelink">
			<span style="float:left;margin:12px;">back to homepage</span>
			<a href="/default.aspx"> <img src="/images/home-btn.png" width="64" height="41"></a>
		</div>
		<div class="header-banner">
			<h1>SPEX CertiPrep &#8212; 60 Years of Serving <br>the Scientific Industry</h1>
		</div>
		<!--<div class="header-b" id="header-b">
			<div class="sticky-wrap">
				<div class="timeline-bar">
					<ul class="navigation">
						<li data-slide="1"></li>
						<li data-slide="2"></li>
						<li data-slide="3"></li>
						<li data-slide="4"></li>
						<li data-slide="5"></li>
						<li data-slide="6"></li>
						<li data-slide="7"></li>
						<!--<li data-slide="7" style="box-shadow: 0 0 0 3px #ffee00;background-color: #ffee00;"></li>
					</ul>
					<img src="/images/parallax/timeline-bar.png">
					<ul class="timeline-year">
						<li>1950's</li>
						<li>1960's</li>
						<li>1970's</li>
						<li>1980's</li>
						<li>1990's</li>
						<li>2000's</li>
						<li>2010's</li>
					</ul>
				</div>
			</div>
		</div>-->
		
	</div>
	<div id="content" class="headerAfter" style="position:relative">
		<div class="header-b" id="header-b">
			<div class="sticky-wrap">
				<div class="timeline-bar">
					<ul class="navigation">
						<li data-slide="1"></li>
						<li data-slide="2"></li>
						<li data-slide="3"></li>
						<li data-slide="4"></li>
						<li data-slide="5"></li>
						<li data-slide="6"></li>
						<li data-slide="7"></li>
					</ul>
					<img src="/images/parallax/timeline-bar.png">
					<ul class="timeline-year">
						<li>1950's</li>
						<li>1960's</li>
						<li>1970's</li>
						<li>1980's</li>
						<li>1990's</li>
						<li>2000's</li>
						<li>2010's</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="building-bg"></div>
		<div class="slide" id="slide1" data-slide="1">
			<div class="bldg-bg"></div>
			<div class="block-left">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1952" data-stellar-ratio="0.7">
						<span>1952</span>
						<p>Art and Harriet Mitteldorf began making <br/>
						and selling the 'SPEX mix' after being <br />
						rejected by a spectrometer manufacturer
						</p>
					</div>
				</div>
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1955_1" data-stellar-ratio="0.7">
						<span>1955</span>
						<ul>
							<li>Semi-Quantitative Standards <br/>
							(G, L & Z standards)</li>
							<li>Ultra Purity Graphite Electrodes, <br />
							Rods and Powders</li>
							<li>Spectroscopic Plates & Films</li>
						</ul>
					</div>
				</div>
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1955_3" data-stellar-ratio="0.7">
						<span>1955</span>
						<p>SPEX Industries presented its <br/>
						products for the first time at the <br />
						Pittsburgh Conference (Pittcon)
						</p>
					</div>
				</div>
			</div>
			<div class="block-right">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1954" data-stellar-ratio="0.8">
						<span>1954</span>
						<p>SPEX Industries was founded in <br/>
						Queens, NY. SPEX stands for: <br />
						<b><u>S</u></b>ample <b><u>P</u></b>reparation and handling <br />
						techniques for the <b><u>E</u></b>mission, <br />
						infrared, and <b><u>X</u></b>-ray spectroscopist
						</p>
					</div>
				</div>
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1955_2" data-stellar-ratio="0.8">
						<span>1955</span>
						<p>First SPEX Industries catalog</p>
					</div>
				</div>
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1956" data-stellar-ratio="0.9">
						<span>1956</span>
						<p><a href="http://www.spexspeaker.com/">SPEX Speaker newsletter</a></p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1959" data-stellar-ratio="1">
						<span>1959</span>
						<p>First Sample Preparation Catalog</p>
					</div>			
				</div>
			</div>
			<div class="wrapper-bone" style="padding-top:85px;" >
				<div class="middle-bone t1950-w">
					<!--1956-->
					<div>
					<a href="http://www.spexspeaker.com/" target="_blank">
						<div id="hexagon" style="top:454px;right:55px;"></div>
					</a></div>
					<div class="gobottom goto" data-slide="bottom"></div>
				</div>
			</div>
		</div>
		<!--End Slide 1-->
		<div class="slide" id="slide2" data-slide="2">	
			<div class="block-left" >
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1960_1" data-stellar-ratio="0.7">
						<span>1960</span>
						<p>Semi-Quantitative Standards for:</p>
						<ul>
							<li>Rare Earth Elements</li>
							<li>Noble Metals</li>
							<li>Pure Materials</li>
							<li>Steel</li>
						</ul>
					</div>
				</div>
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1960_2" data-stellar-ratio="0.7">
						<span>1960</span>
						<p>5000 Mixer/Mill</p>
					</div>
				</div>
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1963_1" data-stellar-ratio="0.7">
						<span>1963</span>
						<ul>
							<li>The Master Plate</li>
							<li>Pre-weighted and<br />
							Fluxing chemicals
							</li>
						</ul>
					</div>
				</div>
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1963_2" data-stellar-ratio="0.7">
						<span>1963</span>
						<ul>
							<li>9040 Stabilized DC Arc unit</li>
							<li>90101 Arc/Spark Stand</li>
							<li>8500 Shatterbox</li>
						</ul>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1965" data-stellar-ratio="1">
						<span>1965</span>
						<ul>
							<li>XRF liquid cells and consumables</li>
							<li>C-30 Hydraulic Press</li>
						</ul>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1968" data-stellar-ratio="1">
						<span>1968</span>
						<ul>
							<li>6700 Freezer/Mill</li>
							<li>5100 Mixer/Mill</li>
						</ul>
					</div>
				</div>					
			</div>
			<div class="block-right" >
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1964_1" data-stellar-ratio="0.8">
						<span>1964</span>
						<p>SPEX 3.4 meter Ebert <br />
						Spectrograph was constructed <br />
						and used to produce first SPEX <br />
						Certified Reference Materials <br />
						featured in the very first Certified <br />
						Reference Materials Catalog</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1964_2" data-stellar-ratio="0.8">
						<span>1964</span>
						<p>SPEX Industries incorporated</p>
					</div>
				</div>
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1967" data-stellar-ratio="0.9">
						<span>1967</span>
						<p>Acquired first DCP spectrometer for QC <br />
						of CRMs</p>
					</div>
				</div>					
			</div>
			<div class="wrapper-bone" style="padding:27px 0 0 4px;">
				<div class="middle-bone t1960-w">
				</div>
			</div>
		</div>
		<!--End Slide 2-->
		<div class="slide" id="slide3" data-slide="3">	
			<div class="block-left">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1970_1" data-stellar-ratio="0.8">
						<span>1970</span>
						<p>B-25 hydraulic Press</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1973" data-stellar-ratio="0.8">
						<span>1973</span>
						<p>Flame and Atomic Absorption <br />
						Standards</p>
					</div>
				</div>
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1976" data-stellar-ratio="0.9">
						<span>1976</span>
						<p>3624 30-ton X-Press</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1977_1" data-stellar-ratio="0.9">
						<span>1977</span>
						<p>8510 Enclosed Shatterbox</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1977_2" data-stellar-ratio="0.9">
						<span>1977</span>
						<ul>
							<li>HiPure Inorganic Materials</li>
							<li>Multi-element ICP Solution <br />
							Standards</li>
							<li>Organic Solvent Soluble Metal Salts</li>
							<li>Gas Standards</li>
						</ul>
					</div>
				</div>					
			</div>
			<div class="block-right">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1970_2" data-stellar-ratio="0.8">
						<span>1970</span>
						<p>SPEX Industries, GmbH -European office <br />
						opens in West Germany</p>
					</div>
				</div>	
			</div>
			<div class="wrapper-bone" style="padding:27px 0 0 3px;">
				<div class="middle-bone t1970-w">
				</div>
			</div>
		</div>
		<!--End Slide 3-->
		<div class="slide" id="slide4" data-slide="4">		
			<div class="block-left">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1981" data-stellar-ratio="0.9">
						<span>1981</span>
						<p>5200 Micro Hammer Cutter Mill</p>
					</div>
				</div>
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1984" data-stellar-ratio="0.9">
						<span>1984</span>
						<p>3624B 35-ton X-Press</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1986" data-stellar-ratio="0.9">
						<span>1986</span>
						<p>3624C X-Press</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1988_1" data-stellar-ratio="0.9">
						<span>1988</span>
						<p>Many Popular Standard Lines:</p>
						<ul>
							<li>Single element</li>
							<li>Instrument Check & Interferance Check</li>
							<li>Quality Control</li>
							<li>Pollution Control Checks</li>
							<li>Custom Multi-Element Spectroscopy <br />
							Standards</li>
						</ul>
					</div>
				</div>
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1989" data-stellar-ratio="0.9">
						<span>1989</span>
						<ul>
							<li>Stock environmental ICP <br />
							multi-standards for the Superfund <br />
							Contract Laboratory Program (CLP)</li>
							<li>Multi-element ICP standard for <br />
							matrix-matching</li>
						</ul>
					</div>
				</div>					
			</div>
			<div class="block-right">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1985" data-stellar-ratio="0.8">
						<span>1985</span>
						<p>5200 Micro Hammer Cutter Mill</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1988_2" data-stellar-ratio="0.8">
						<span>1988</span>
						<p>SPEX was purchased by Jobin <br />
						Yvon SA</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1988_3" data-stellar-ratio="0.8">
						<span>1988</span>
						<p>Acquired first ICP for inclusion of ICP <br />
						analysis on certificates</p>
					</div>
				</div>	
			</div>
			<div class="wrapper-bone" style="padding:27px 0 0 4px;">
				<div class="middle-bone t1980-w">
				</div>
			</div>
		</div>
		<!--End Slide 4-->
		<div class="slide" id="slide5" data-slide="5">		
			<div class="block-left">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1990_1" data-stellar-ratio="0.8">
						<span>1990</span>
						<p><a href="/search_inorganic_category.aspx?cat=3">ICP-MS Calibration Standards</a></p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1990_3" data-stellar-ratio="0.8">
						<span>1990</span>
						<p>3630 Automated X-Press</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1991_1" data-stellar-ratio="0.8">
						<span>1991</span>
						<p><a href="/search_inorganic_category.aspx?cat=6">Organometallic CRMs</a></p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1991_2" data-stellar-ratio="0.8">
						<span>1991</span>
						<p>4200 Jaw Crusher</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1992_1" data-stellar-ratio="0.8">
						<span>1992</span>
						<p>5300 Mixer/Mill & Fusion products</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1992_2" data-stellar-ratio="0.8">
						<span>1992</span>
						<ul>
							<li><a href="/search_inorganic_category.aspx?cat=4">Anion IC Standards</a></li>
							<li>Environment Standards line<br />
							expanded</li>
						</ul>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1995_1" data-stellar-ratio="1">
						<span>1995</span>
						<ul>
							<li><a href="/products/inorganic/">Cations IC standards</a></li>
							<li><a href="/products/inorganic/">Cyanide Standards</a></li>
						</ul>
					</div>
				</div>
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1995_2" data-stellar-ratio="1">
						<span>1995</span>
						<p>8000D DualMixer/Mill</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1996" data-stellar-ratio="1">
						<span>1996</span>
						<p>8520 3-Speed Enclosed Shatterbox</p>
					</div>
				</div>		
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1997_1" data-stellar-ratio="1">
						<span>1997</span>
						<p>6750 Freezer/Mill & 6800 Large<br />
						Freezer/Mill</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1999" data-stellar-ratio="1">
						<span>1999</span>
						<p>8515 Enclosed Shatterbox</p>
					</div>
				</div>				
			</div>
			<div class="block-right">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1990_2" data-stellar-ratio="0.75">
						<span>1990</span>
						<p><a href="/knowledge-base/dilutulator.aspx">The Dilut-u-lator was created</a></p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1994_1" data-stellar-ratio="0.75">
						<span>1994</span>
						<p>Began independent operation <br />
						as SPEX CertiPrep Inc. & SPEX <br />
						CertiPrep Ltd. (UK)</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1994_2" data-stellar-ratio="0.75">
						<span>1994</span>
						<ul>
							<li><a href="/search_inorganic_category.aspx?category=0&cat=3">Caritas line of products for ICP <br />
							and ICP-MS.</a></li>
							<li>Instituted "brand names":<br />
							Claritas, Assurance, etc.</li>
							<li>Added densities and purities to COA</li>
						</ul>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1994_3" data-stellar-ratio="0.75">
						<span>1994</span>
						<p><a href="/uploads/ISO%209001%202008%20UL%202012.pdf">Attained ISO 9001 certification<br/>
						through Underwriter's Laboratory</a></p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1994_4" data-stellar-ratio="0.75">
						<span>1994</span>
						<p>Acquired first ICP-MS</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1997_2" data-stellar-ratio="0.9">
						<span>1997</span>
						<p>SPEX goes online with www.spexcsp.com<br />
						and email@spexcsp.com</p>
					</div>
				</div>	
			</div>
			<div class="wrapper-bone" style="padding:27px 0 0 3px;">
				<div class="middle-bone t1990-w">
					<!--1990_1-->
					<a href="/search_inorganic_category.aspx?cat=3" target="_blank">
						<div id="hexagon" style="top:98px;left:49px;"></div>
					</a>				
					<!--1990_2-->
					<a href="/knowledge-base/dilutulator.aspx" target="_blank">
						<div id="hexagon" style="top:97px;right:57px;"></div>
					</a>
					<!--1991_1-->
					<a href="/search_inorganic_category.aspx?cat=6" target="_blank">
						<div id="hexagon" style="top:276px;left:49px;"></div>
					</a>
					<!--1992_2-->
					<a href="/search_inorganic_category.aspx?cat=4" target="_blank">
						<div id="hexagon" style="top:545px;left:2px;"></div>
					</a>
					<!--1994_2-->
					<a href="/search_inorganic_category.aspx?category=0&cat=3" target="_blank">
						<div id="hexagon" style="top:724px;right:8px;"></div>
					</a>
					<!--1994_3-->
					<a href="/uploads/ISO%209001%202008%20UL%202012.pdf" target="_blank">
						<div id="hexagon" style="top:813px;right:57px;"></div>
					</a>
					<!--1995_1-->
					<a href="/products/inorganic/" target="_blank">
						<div id="hexagon" style="top:992px;left:50px;"></div>
					</a>
				</div>
			</div>
		</div>
		<!--End Slide 5-->
		<div class="slide" id="slide6" data-slide="6">		
			<div class="block-left">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2000_1" data-stellar-ratio="0.95">
						<span>2000</span>
						<p>2000 Geno/Grinder & 8000M<br />
						Mixer/Mill</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2001" data-stellar-ratio="0.95">
						<span>2001</span>
						<p>6850 Large Freezer/Mill</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2004_1" data-stellar-ratio="0.8">
						<span>2004</span>
						<p><a href="/products/product_labstuff.aspx?part=PIPWASH-1">Contamination control product line</a></p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2006_2" data-stellar-ratio="0.9">
						<span>2006</span>
						<p>6770 Freezer/Mill</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2009_1" data-stellar-ratio="0.95">
						<span>2009</span>
						<p><a href="/products/product_inorganic.aspx?part=ROHS-25">ROHS/WEEE Standard</a></p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2009_2" data-stellar-ratio="0.95">
						<span>2009</span>
						<p>2010 Geno/Grinder & 3635 X-Press</p>
					</div>
				</div>	
			</div>
			<div class="block-right">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2000_2" data-stellar-ratio="0.9">
						<span>2000</span>
						<p>NVLAP certification attained, <br />
						become Proficiency Testing <br />
						provider</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2003" data-stellar-ratio="0.8">
						<span>2003</span>
						<p><a href="/products/organic/">SPEX CertiPrep Group added <br />
						Protocol Organics to expand into <br />
						organic RMs</a></p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2004_2" data-stellar-ratio="0.8">
						<span>2004</span>
						<p>SPEX SamplePrep, LLC began <br />
						Independent operations</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2004_3" data-stellar-ratio="0.8">
						<span>2004</span>
						<p>Web order entry started</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2006_1" data-stellar-ratio="0.8">
						<span>2006</span>
						<p><a href="/about-us/certifications.aspx">SPEX CertiPrep increase accreditation <br />
						through A2LA to Guide 34 & ISO 17025</a></p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2007" data-stellar-ratio="0.8">
						<span>2007</span>
						<p>SPEX SamplePrep increase acquired Katanax <br />
						for Fusion Products</p>
					</div>
				</div>	
			</div>
			<div class="wrapper-bone" style="padding:25px 0 0 3px;">
				<div class="middle-bone t2000-w">
					<!--2003-->
					<a href="/products/organic/" target="_blank">
						<div id="hexagon" style="top:186px;right:6px;"></div>
					</a>
					<!--2004_1-->
					<a href="/products/product_labstuff.aspx?part=PIPWASH-1" target="_blank">
						<div id="hexagon" style="top:276px;left:52px;"></div>
					</a>
					<!--2006-->
					<a href="/about-us/certifications.aspx" target="_blank">
						<div id="hexagon" style="top:456px;right:55px;"></div>
					</a>
					<!--2009_1-->
					<a href="/products/product_inorganic.aspx?part=ROHS-25" target="_blank">
						<div id="hexagon" style="bottom:95px;left:4px;"></div>
					</a>
				</div>
			</div>
		</div>
		<!--End Slide 6-->
		<div class="slide" id="slide7" data-slide="7">		
			<div class="block-left">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2010_1" data-stellar-ratio="0.9">
						<span>2010</span>
						<ul>
							<li>Polyethylene Phthalates<br />
							Standards</li>
							<li>EMPT Toy Safety Standards</li>
							<li>USP Standards</li>
						</ul>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2010_2" data-stellar-ratio="0.9">
						<span>2010</span>
						<p>6970 EFM Freezer/Mill with<br />
						external loading and K1' and K2'<br />
						Borate Fusion Fluxers</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2011" data-stellar-ratio="0.9">
						<span>2011</span>
						<p>Robotic Autoclamp 2020 geno/Grinder</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2012_3" data-stellar-ratio="0.9">
						<span>2012</span>
						<ul>
							<li><a href="/products/inorganic/">LC-MS Standards Line</a></li>
							<li><a href="/products/inorganic/">1 ppm Standards Line for ICP-MS</a></li>
						</ul>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2012_4" data-stellar-ratio="0.9">
						<span>2012</span>
						<p><a href="/products/quechers/">1500 ShaQer</a></p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2013_1" data-stellar-ratio="0.9">
						<span>2013</span>
						<ul>
							<li><a href="/products/organic/">PVC Phthalate CRM</a></li>
							<li><a href="/products/quechers/">SPEXQue QuEChERS Kits</a></li>
						</ul>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2013_2" data-stellar-ratio="0.9">
						<span>2013</span>
						<p>1600 MiniG</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2014" data-stellar-ratio="0.9">
						<span>2014</span>
						<p>6870D Dual Freezer/Mill</p>
					</div>
				</div>	
			</div>
			<div class="block-right">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2012_1" data-stellar-ratio="0.8">
						<span>2010</span>
						<p>SPEX CertiPrep went solar with the<br />
						installation of roof-top solar panels</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2012_2" data-stellar-ratio="0.8">
						<span>2012</span>
						<p>Acquired first LC-MS</p>
					</div>
				</div>	
			</div>
			<div class="wrapper-bone" style="padding:24px 0 0 3px;">
				<div class="middle-bone t2010-w">
					<!--2012_2-->
					<a href="/products/inorganic/" target="_blank">
						<div id="hexagon" style="top:455px;left:52px;"></div>
					</a>
					<!--2012_3-->
					<a href="/products/quechers/" target="_blank">
						<div id="hexagon" style="top:634px;left:53px;"></div>
					</a>
					<!--2013_1-->
					<a href="/products/organic/" target="_blank">
						<div id="hexagon" style="top:812px;left:52px;"></div>
					</a>
					<!--2013_1.2-->
					<a href="/products/quechers/" target="_blank">
						<div id="hexagon" style="top:904px;left:2px;"></div>
					</a>					
					<div class="gotop goto" data-slide="top"></div>
				</div>
			</div>
			<div class="tags" data-slide="bottom"></div>
		</div>
		<!--End Slide 7-->
		<div class="slide" id="slide8">
			<div class="logo_slide_wrapper">
				<%--<p class="logo_nav prv"></p>--%>
				<div class="logo_slideshow">
					<div class="slide_logo">
						<div class="logo_images">
							<img src="/images/parallax/spex-logo-1.png" height="65">
							<img src="/images/parallax/spex-logo-2.png" height="65" style="margin-left:-20px;">
							<img src="/images/parallax/spex-logo-3.png" height="65" style="margin-left:-20px;">
							<img src="/images/parallax/spex-logo-4.png" height="65" style="margin-left:-20px;">
							<img src="/images/parallax/spex-logo-5.png" height="65" style="margin-left:-20px;">
							<img src="/images/parallax/spex-logo-6.png" height="65" style="margin-left:-20px;">
							<img src="/images/parallax/spex-logo-7.png" height="65" style="margin-left:-20px;">
						</div>
						<div class="logo_dates">
							<ul>
								<li>Early 1950's</li>
								<li>1950's</li>
								<li>1960's</li>
								<li>1970's</li>
								<li>1980's</li>
								<li>1990's</li>	
								<li>2010's</li>								
							</ul>
						</div>
					</div>			
				</div>
				<%--<p class="logo_nav nxt"></p>--%>
			</div>
		</div>		
	</div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">

</asp:Content>

