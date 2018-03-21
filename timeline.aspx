<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="timeline.aspx.cs" Inherits="timeline" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
	<style type="text/css">
	.page_margins { width:100%; }
	.header-topa, #breadcrumb { display:none; }
	
	</style>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script type="text/javascript" src="js/jquery.stellar.min.js"></script>
	<script type="text/javascript" src="js/waypoints.min.js"></script>
	<script type="text/javascript" src="js/jquery.easing.1.3.js"></script>
    <script type="text/javascript">
	jQuery(document).ready(function ($) {
		//initialise Stellar.js
		$(window).stellar();
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
		//waypoints doesnt detect the first slide when user scrolls back up to the top so we add this little bit of code, that removes the class
		//from navigation link slide 2 and adds it to navigation link slide 1.
		/*mywindow.scroll(function () {
			if (mywindow.scrollTop() == 0) {
				$('.navigation li[data-slide="1"]').addClass('active');
				$('.navigation li[data-slide="2"]').removeClass('active');
				$('.navigation li[data-slide="3"]').removeClass('active');
				$('.navigation li[data-slide="4"]').removeClass('active');
				$('.navigation li[data-slide="5"]').removeClass('active');
				$('.navigation li[data-slide="6"]').removeClass('active');
				$('.navigation li[data-slide="7"]').removeClass('active');				
			}
		});*/
		
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
			<div class="timeline-bar">
				<ul class="navigation">
					<li data-slide="1"></li>
					<li data-slide="2"></li>
					<li data-slide="3"></li>
					<li data-slide="4"></li>
					<li data-slide="5"></li>
					<li data-slide="6"></li>
					<li data-slide="7"></li>
					<!--<li data-slide="7" style="box-shadow: 0 0 0 3px #ffee00;background-color: #ffee00;"></li>-->
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
		<div class="header-b">
		</div>
	</div>
	<div id="content">
		<div class="slide" id="slide1" data-slide="1" data-stellar-background-ratio="0">
			<div class="block-left">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1952">
						<h2>1952</h2>
						<p>Art and Harriet Mitteldorf began making <br/>
						and selling the 'SPEX mix' after being <br />
						rejected by a spectrometer manufacturer
						</p>
					</div>
				</div>
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1955_1">
						<h2>1955</h2>
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
					<div class="time-caption t1955_3">
						<h2>1955</h2>
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
					<div class="time-caption t1954">
						<h2>1954</h2>
						<p>SPEX Industries was founded in <br/>
						Queens, NY. SPEX stands for: <br />
						Sample Preparation and handling <br />
						techniques for the Emission, <br />
						infrared, and X-ray spectroscopist
						</p>
					</div>
				</div>
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1955_2">
						<h2>1955</h2>
						<p>First SPEX Industries catalog</p>
					</div>
				</div>
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1956">
						<h2>1956</h2>
						<p>SPEX Speaker newsletter</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1959">
						<h2>1959</h2>
						<p>First Sample Preparation Catalog</p>
					</div>
				</div>					
			</div>
			<div class="wrapper-bone" style="padding-top:85px;">
				<div class="middle-bone t1950-w">
					<!--1956-->
					<a href="http://www.spexspeaker.com/" target="_blank">
						<div id="hexagon" style="top:485px;right:57px;"></div>
					</a>
					<div class="gobottom goto" data-slide="bottom"></div>
				</div>
			</div>
		</div>
		<!--End Slide 1-->
		<div class="slide" id="slide2" data-slide="2" data-stellar-background-ratio="0">
			<div class="block-left">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1960_1">
						<h2>1960</h2>
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
					<div class="time-caption t1960_2">
						<h2>1960</h2>
						<p>5000 Mixer/Mill</p>
					</div>
				</div>
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1963_1">
						<h2>1963</h2>
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
					<div class="time-caption t1963_2">
						<h2>1963</h2>
						<ul>
							<li>9040 Stabilized DC Arc unit</li>
							<li>90101 Arc/Spark Stand</li>
							<li>8500 Shatterbox</li>
						</ul>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1965">
						<h2>1965</h2>
						<ul>
							<li>XRF liquid cells and consumables</li>
							<li>C-30 Hydraulic Press</li>
						</ul>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1968">
						<h2>1968</h2>
						<ul>
							<li>6700 Freezer/Mill</li>
							<li>5100 Mixer/Mill</li>
						</ul>
					</div>
				</div>					
			</div>
			<div class="block-right">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1964_1">
						<h2>1964</h2>
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
					<div class="time-caption t1964_2">
						<h2>1964</h2>
						<p>SPEX Industries incorporated</p>
					</div>
				</div>
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1967">
						<h2>1967</h2>
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
		<div class="slide" id="slide3" data-slide="3" data-stellar-background-ratio="0">
			<div class="block-left">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1970_1">
						<h2>1970</h2>
						<p>B-25 hydraulic Press</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1973">
						<h2>1973</h2>
						<p>Flame and Atomic Absorption <br />
						Standards</p>
					</div>
				</div>
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1976">
						<h2>1976</h2>
						<p>3624 30-ton X-Press</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1977_1">
						<h2>1977</h2>
						<p>8510 Enclosed Shatterbox</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1977_2">
						<h2>1977</h2>
						<ul>
							<li>HiPure Inorganic Materials</li>
							<li>Multi-element ICP Solution <br />
							Standards</li>
							<li>Organic Solvent Soluble <br />
							Metal Salts</li>
							<li>Gas Standards</li>
						</ul>
					</div>
				</div>					
			</div>
			<div class="block-right">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1970_2">
						<h2>1970</h2>
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
		<div class="slide" id="slide4" data-slide="4" data-stellar-background-ratio="0">
			<div class="block-left">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1981">
						<h2>1981</h2>
						<p>5200 Micro Hammer Cutter Mill</p>
					</div>
				</div>
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1984">
						<h2>1984</h2>
						<p>3624B 35-ton X-Press</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1986">
						<h2>1986</h2>
						<p>3624C X-Press</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1988_1">
						<h2>1988</h2>
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
					<div class="time-caption t1989">
						<h2>1989</h2>
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
					<div class="time-caption t1985">
						<h2>1985</h2>
						<p>5200 Micro Hammer Cutter Mill</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1988_2">
						<h2>1988</h2>
						<p>SPEX was purchased by Jobin <br />
						Yvon SA</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1988_3">
						<h2>1988</h2>
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
		<div class="slide" id="slide5" data-slide="5" data-stellar-background-ratio="0">
			<div class="block-left">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1990_1">
						<h2>1990</h2>
						<p>ICP-MS Calibration Standards</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1990_3">
						<h2>1990</h2>
						<p>3630 Automated X-Press</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1991_1">
						<h2>1991</h2>
						<p>Organometallic CRMs</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1991_2">
						<h2>1991</h2>
						<p>4200 Jaw Crusher</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1992_1">
						<h2>1992</h2>
						<p>5300 Mixer/Mill & Fusion products</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1992_2">
						<h2>1992</h2>
						<ul>
							<li>Anion IC Standards</li>
							<li>Environment Standards line<br />
							expanded</li>
						</ul>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1995_1">
						<h2>1995</h2>
						<ul>
							<li>Cations IC standards</li>
							<li>Cyanide Standards</li>
						</ul>
					</div>
				</div>
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1995_2">
						<h2>1995</h2>
						<p>8000D DualMixer/Mill</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1996">
						<h2>1996</h2>
						<p>8520 3-Speed Enclosed Shatterbox</p>
					</div>
				</div>		
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1997_1">
						<h2>1997</h2>
						<p>6750 Freezer/Mill & 6800 Large<br />
						Freezer/Mill</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1999">
						<h2>1999</h2>
						<p>8515 Enclosed Shatterbox</p>
					</div>
				</div>				
			</div>
			<div class="block-right">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1990_2">
						<h2>1990</h2>
						<p>The Dilut-u-lator was created</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1994_1">
						<h2>1994</h2>
						<p>Began independent operation <br />
						as SPEX CertiPrep Inc. & SPEX <br />
						CertiPrep Ltd. (UK)</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1994_2">
						<h2>1994</h2>
						<ul>
							<li>Caritas line of products for ICP <br />
							and ICP-MS.</li>
							<li>Instituted "brand names":<br />
							Claritas, Assurance, etc.</li>
							<li>Added densities and purities to COA</li>
						</ul>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1994_3">
						<h2>1994</h2>
						<p>Attained ISO 9001 certification<br/>
						through Underwriter's Laboratory</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1994_4">
						<h2>1994</h2>
						<p>Acquired first ICP-MS</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t1997_2">
						<h2>1997</h2>
						<p>SPEX goes online with www.spexcsp.com<br />
						and email@spexcsp.com</p>
					</div>
				</div>	
			</div>
			<div class="wrapper-bone" style="padding:27px 0 0 3px;">
				<div class="middle-bone t1990-w">
					<!--1990_1-->
					<a href="/search_inorganic_category.aspx?cat=3" target="_blank">
						<div id="hexagon" style="top:120px;left:55px;"></div>
					</a>				
					<!--1990_2-->
					<a href="/knowledge-base/dilutulator.aspx" target="_blank">
						<div id="hexagon" style="top:120px;right:56px;"></div>
					</a>
					<!--1990_1-->
					<a href="/search_inorganic_category.aspx?cat=6" target="_blank">
						<div id="hexagon" style="top:298px;left:55px;"></div>
					</a>
					<!--1992_2-->
					<a href="/search_inorganic_category.aspx?cat=4" target="_blank">
						<div id="hexagon" style="top:568px;left:7px;"></div>
					</a>
					<!--1994_2-->
					<a href="/search_inorganic_category.aspx?category=0&cat=3" target="_blank">
						<div id="hexagon" style="top:747px;right:8px;"></div>
					</a>
					<!--1994_3-->
					<a href="/uploads/ISO%209001%202008%20UL%202012.pdf" target="_blank">
						<div id="hexagon" style="top:836px;right:56px;"></div>
					</a>
					<!--1995_1-->
					<a href="/products/inorganic/" target="_blank">
						<div id="hexagon" style="top:1015px;left:55px;"></div>
					</a>
				</div>
			</div>
		</div>
		<!--End Slide 5-->
		<div class="slide" id="slide6" data-slide="6" data-stellar-background-ratio="0">
			<div class="block-left">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2000_1">
						<h2>2000</h2>
						<p>2000 Geno/Grinder & 8000M<br />
						Mixer/Mill</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2001">
						<h2>2001</h2>
						<p>6850 Large Freezer/Mill</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2004_1">
						<h2>2004</h2>
						<p>Contamination control product line</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2006_2">
						<h2>2006</h2>
						<p>6770 Freezer/Mill</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2009_1">
						<h2>2009</h2>
						<p>ROHS/WEEE Standard</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2009_2">
						<h2>2009</h2>
						<p>2010 Geno/Grinder & 3635 X-Press</p>
					</div>
				</div>	
			</div>
			<div class="block-right">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2000_2">
						<h2>2000</h2>
						<p>NVLAP certification attained, <br />
						become Proficiency Testing <br />
						provider</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2003">
						<h2>2003</h2>
						<p>SPEX CertiPrep Group added <br />
						Protocol Organics to expand into <br />
						organic RMs</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2004_2">
						<h2>2004</h2>
						<p>SPEX SamplePrep, LLC began <br />
						Independent operations</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2004_3">
						<h2>2004</h2>
						<p>Web order entry started</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2006_1">
						<h2>2006</h2>
						<p>SPEX CertiPrep increase accreditation <br />
						through A2LA to Guide 34 & ISO 17025</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2007">
						<h2>2007</h2>
						<p>SPEX SamplePrep increase acquired Katanax <br />
						for Fusion Products</p>
					</div>
				</div>	
			</div>
			<div class="wrapper-bone" style="padding:25px 0 0 3px;">
				<div class="middle-bone t2000-w">
					<!--2003-->
					<a href="/products/organic/" target="_blank">
						<div id="hexagon" style="top:214px;right:8px;"></div>
					</a>
					<!--2004_1-->
					<a href="/products/product_labstuff.aspx?part=PIPWASH-1" target="_blank">
						<div id="hexagon" style="top:304px;left:55px;"></div>
					</a>
					<!--2006-->
					<a href="/about-us/certifications.aspx" target="_blank">
						<div id="hexagon" style="top:484px;right:57px;"></div>
					</a>
					<!--2009_1-->
					<a href="/products/product_inorganic.aspx?part=ROHS-25" target="_blank">
						<div id="hexagon" style="bottom:120px;left:7px;"></div>
					</a>
				</div>
			</div>
		</div>
		<!--End Slide 6-->
		<div class="slide" id="slide7" data-slide="7" data-stellar-background-ratio="0">
			<div class="block-left">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2010_1">
						<h2>2010</h2>
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
					<div class="time-caption t2010_2">
						<h2>2010</h2>
						<p>6970 EFM Freezer/Mill with<br />
						external loading and K1' and K2'<br />
						Borate Fusion Fluxers</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2011">
						<h2>2011</h2>
						<p>Robotic Autoclamp 2020 geno/Grinder</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2012_3">
						<h2>2012</h2>
						<ul>
							<li>LC-MS Standards Line</li>
							<li>1 ppm Standards Line for ICP-MS</li>
						</ul>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2012_4">
						<h2>2012</h2>
						<p>1500 ShaQer</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2013_1">
						<h2>2013</h2>
						<ul>
							<li>PVC Phthalate CRM</li>
							<li>SPEXQue QuEChERS Kits</li>
						</ul>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2013_2">
						<h2>2013</h2>
						<p>1600 MiniG</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2014">
						<h2>2014</h2>
						<p>6870D Dual Freezer/Mill</p>
					</div>
				</div>	
			</div>
			<div class="block-right">
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2012_1">
						<h2>2010</h2>
						<p>SPEX CertiPrep went solar with the<br />
						installation of roof-top solar panels</p>
					</div>
				</div>	
				<div class="wrapper-caption">
				&nbsp;
					<div class="time-caption t2012_2">
						<h2>2012</h2>
						<p>Acquired first LC-MS</p>
					</div>
				</div>	
			</div>
			<div class="wrapper-bone" style="padding:24px 0 0 3px;">
				<div class="middle-bone t2010-w">
					<!--2012_2-->
					<a href="/products/inorganic/" target="_blank">
						<div id="hexagon" style="top:572px;left:7px;"></div>
					</a>
					<!--2012_3-->
					<a href="/products/quechers/" target="_blank">
						<div id="hexagon" style="top:661px;left:55px;"></div>
					</a>
					<!--2013-->
					<a href="/products/quechers/" target="_blank">
						<div id="hexagon" style="top:841px;left:55px;"></div>
					</a>
					<div class="gotop goto" data-slide="top"></div>
				</div>
			</div>
			<div class="tags" data-slide="bottom"></div>
		</div>
		<!--End Slide 7-->
		<div class="slide" id="slide8">
		
		</div>		
	</div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">

</asp:Content>

