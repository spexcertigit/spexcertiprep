<%@ Page Language="C#" Debug="true" EnableSessionState="True" %>
<%

	if (Request.Form["hdnAction"] == null)
		Response.Redirect("default.aspx");

%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		
		<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
		Remove this if you use the .htaccess -->
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		
		<title>SPEX Fusion Flux</title>
		
		<!-- add your meta tags here -->
		<meta name="description" content="">
		<meta name="author" content="">
		
		<!-- Mobile viewport optimized: j.mp/bplateviewport -->
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		
		<!-- Place favicon.ico & apple-touch-icon.png in the root of your domain and delete these references -->
		<link rel="shortcut icon" href="/favicon.ico">
		<link rel="apple-touch-icon" href="/apple-touch-icon.png">

		<link href="css/my_layout.css" rel="stylesheet" type="text/css" />
		
		<!--[if lte IE 7]>
			<link href="css/patches/patch_my_layout.css" rel="stylesheet" type="text/css" />
			<link rel="stylesheet" href="http://www.spexcertiprep.com/inc/ie7.css" type="text/css" />
		<![endif]-->
		<!--[if gte IE 8]>
			<link rel="stylesheet" href="http://www.spexcertiprep.com/inc/ie.css" type="text/css" />
		<![endif]-->

<script type="text/javascript">

function validateForm()
{
if (document.forms["frmMain"]["firstName"].value == null || document.forms["frmMain"]["firstName"].value == "") {
 alert("First name is required");
 return false;
 }

if (document.forms["frmMain"]["lastName"].value == null || document.forms["frmMain"]["lastName"].value == "") {
 alert("Last name is required");
 return false;
 }

if (document.forms["frmMain"]["address1"].value == null || document.forms["frmMain"]["address1"].value == "") {
 alert("Address line 1 is required");
 return false;
 }

if (document.forms["frmMain"]["city"].value == null || document.forms["frmMain"]["city"].value == "") {
 alert("City is required");
 return false;
 }

if (document.forms["frmMain"]["state"].value == null || document.forms["frmMain"]["state"].value == "") {
 alert("State is required");
 return false;
 }

if (document.forms["frmMain"]["zipCode"].value == null || document.forms["frmMain"]["zipCode"].value == "") {
 alert("ZIP code is required");
 return false;
 }

if (document.forms["frmMain"]["phone"].value == null || document.forms["frmMain"]["phone"].value == "") {
 alert("Phone is required");
 return false;
 }

if (document.forms["frmMain"]["email"].value == null || document.forms["frmMain"]["email"].value == "") {
 alert("Email address is required");
 return false;
 }


if (document.forms["frmMain"]["supplier1"].checked == false && document.forms["frmMain"]["supplier2"].checked == false && document.forms["frmMain"]["supplier3"].checked == false && document.forms["frmMain"]["supplier4"].checked == false && (document.forms["frmMain"]["supplierOther"].value == null || document.forms["frmMain"]["supplierOther"].value == "")) {
 alert("Supplier is required");
 return false;
 }



if (document.forms["frmMain"]["blends"].value == null || document.forms["frmMain"]["blends"].value == "") {
 alert("Blends is required");
 return false;
 }



}

</script>
</script>

	</head>
	
	<body>
		<!-- start: skip link navigation -->
		<a class="skip" title="skip link" href="#navigation">Skip to the navigation</a><span class="hideme">.</span>
    	<a class="skip" title="skip link" href="#content">Skip to the content</a><span class="hideme">.</span>
    	<!-- end: skip link navigation -->
    	
    	<div id="header"> <!--BEGIN HEADER-->
    		<div class="page_margins">
    			<div class="grid_12">
    				<img class="float_left" src="images/header_logo.jpg" alt="Spex CertiPrep">
    				<div id="header_right" class="float_right position_relative">
    					<h2 class="display_block position_absolute"><a href="http://www.spexcertiprep.com"><strong>www.spexcertiprep.com</strong></a></h2>
    				</div>
    			</div>
    		</div>
    	</div> <!--END HEADER-->
    
    	<div id="main"> <!--BEGIN MAIN-->
    		<div class="page_margins">
    			
    			<div class="grid_3"> <!--begin main grid_9-->
    				<img class="requestform" src="images/01-fusion_flux_v1_Cropped.jpg">
    			</div> <!--end main grid_9-->
    			
    			<div class="grid_9"> <!--begin main grid_3-->
    				<p class="requestform">
    					<strong>To process your request for a free sample, we need some additional information. Please complete the form below, and then click on the "Submit My Request" button to receive your free sample.</strong>
    				</p>
    			</div> <!--end main grid_3-->
    			
    			<div class="grid_12 textalign_center"> <!--begin main grid_12-->
    					<form id="frmMain" action="thankyou.aspx" method="post" onsubmit="return validateForm()">

    					<input type="hidden" name="hdnProduct" value="<%=Request.Form["hdnProduct"]%>" />
    					<input type="hidden" name="hdnPart" value="<%=Request.Form["hdnPart"]%>" />
    					<input type="hidden" name="hdnUnitPk" value="<%=Request.Form["hdnUnitPk"]%>" />
    					<input type="hidden" name="hndAction" value=""/>



    					<ul id="info_request">
    					
    						<li class="clearfix">
    							<ul>
    								<li class="display_block float_left">
    									<p>Title</p>
    									<select name="nameTitle">
    										<option value="Mr.">Mr.</option>
											<option value="Mrs.">Mrs.</option> 
											<option value="Mrs.">Ms.</option> 
											<option value="Miss">Miss</option> 
											<option value="Dr.">Dr.</option>
    									</select>
    								</li>
    								<li class="display_block float_left">
    									<p>First Name</p>
    									<input type="text" name="firstName" maxLength="80" size="30">
    								</li>
    								<li class="display_block float_left">
    									<p>MI</p>
    									<input type="text" name="middleInitial" maxLength="80" size="1">
    								</li>
    								<li class="display_block float_left">
    									<p>Last Name</p>
    									<input type="text" name="lastName" maxLength="80" size="30">
    								</li>
    							</ul>
    						</li>
    						
    						<li>
    							<p>Title</p>
    							<input type="text" maxlength="80" size="75" name="businessTitle">
    						</li>
    						
    						<li>
    							<p>Company Name</p>
    							<input type="text" maxlength="80" size="50" name="companyName">
    						</li>
    						
    						<li>
    							<p>Street Address 1</p>
    							<input type="text" maxlength="80" size="70" name="address1">
    						</li>
    						
    						<li>
    							<p>Street Address 2</p>
    							<input type="text" maxlength="80" size="70" name="address2">
    						</li>
    						
    						<li class="clearfix">
    							<ul>
    								<li class="display_block float_left">
    									<p>City</p>
    									<input type="text" maxlength="80" size="30" name="city">
    								</li>
    								<li class="display_block float_left">
    									<p>State</p>
    									<select name="state" size="1">
    										<option value="AL">AL</option>
											<option value="AK">AK</option>
											<option value="AZ">AZ</option>
											<option value="AR">AR</option>
											<option value="CA">CA</option>
											<option value="CO">CO</option>
											<option value="CT">CT</option>
											<option value="DE">DE</option>
											<option value="DC">DC</option>
											<option value="FL">FL</option>
											<option value="GA">GA</option>
											<option value="HI">HI</option>
											<option value="ID">ID</option>
											<option value="IL">IL</option>
											<option value="IN">IN</option>
											<option value="IA">IA</option>
											<option value="KS">KS</option>
											<option value="KY">KY</option>
											<option value="LA">LA</option>
											<option value="ME">ME</option>
											<option value="MD">MD</option>
											<option value="MA">MA</option>
											<option value="MI">MI</option>
											<option value="MN">MN</option>
											<option value="MS">MS</option>
											<option value="MO">MO</option>
											<option value="MT">MT</option>
											<option value="NE">NE</option>
											<option value="NV">NV</option>
											<option value="NH">NH</option>
											<option value="NJ">NJ</option>
											<option value="NM">NM</option>
											<option value="NY">NY</option>
											<option value="NC">NC</option>
											<option value="ND">ND</option>
											<option value="OH">OH</option>
											<option value="OK">OK</option>
											<option value="OR">OR</option>
											<option value="PA">PA</option>
											<option value="RI">RI</option>
											<option value="SC">SC</option>
											<option value="SD">SD</option>
											<option value="TN">TN</option>
											<option value="TX">TX</option>
											<option value="UT">UT</option>
											<option value="VT">VT</option>
											<option value="VA">VA</option>
											<option value="WA">WA</option>
											<option value="WV">WV</option>
											<option value="WI">WI</option>
											<option value="WY">WY</option>
    									</select>
    								</li>
    								<li class="display_block float_left">
    									<p>Zip Code</p>
    									<input type="text" maxlength="80" size="10" name="zipCode">
    								</li>
    							</ul>
    						</li>
    						
    						<li><div class="linebreak"></div></li>
    						
    						<li class="clearfix">
    							<ul>
    								<li class="display_block float_left">
    									<p>Phone</p>
    									<input type="text" maxlength="80" size="14" name="phone">
    								</li>
    								<li class="display_block float_left">
    									<p>Ext.</p>
    									<input type="text" maxlength="80" size="6" name="extension">
    								</li>
    								<li class="display_block float_left">
    									<p>Fax</p>
    									<input type="text" maxlength="80" size="14" name="fax">
    								</li>

    							</ul>
    						</li>
    						
    						<li>
    							<p>E&ndash;Mail</p>
    							<input type="text" maxlength="80" size="60" name="email">
    						</li>
    						
    						<li><div class="linebreak"></div></li>
    						
    						<li class="clearfix">
    							<ul class="vertlist">
    								<li><p>Who is your current supplier of Fusion Flux and Additive samples?</p></li>
    								<li class="clearfix"><input class="display_block float_left" type="checkbox" name="supplier1" value="SPEX CertiPrep / SPEX SamplePrep / Katanax"><p class="display_block float_left">SPEX CertiPrep / SPEX SamplePrep / Katanax</p></li>
    								<li class="clearfix"><input class="display_block float_left" type="checkbox" name="supplier2" value="Claisse"><p class="display_block float_left">Claisse</p></li>
    								<li class="clearfix"><input class="display_block float_left" type="checkbox" name="supplier3" value="Alpha Aesar"><p class="display_block float_left">Alpha Aesar</p></li>
    								<li class="clearfix"><input class="display_block float_left" type="checkbox" name="supplier4" value="other"><p class="display_block float_left">Other</p><input class="display_block float_left" type="text" name="supplierOther" size="50"></li>
    							</ul>
    						</li>
    						
    						<li><div class="linebreak"></div></li>
    						
    						<li>
    							<ul class="vertlist">
    								<li><p>What blend(s) of flux do you use most often?</p></li>
    								<li><textarea rows="4" name="blends" cols="60"></textarea></li>
    							</ul>
    						</li>
    						
    						<li><div class="linebreak"></div></li>
    						
    						<li class="clearfix">
    							<ul class="vertlist">
    								<li><p>What is the physical composition of the flux you use?</p></li>
    								<li class="clearfix"><input class="display_block float_left" type="radio" value="Prefused Beads" name="composition"><p class="display_block float_left">Prefused Beads</p></li>
    								<li class="clearfix"><input class="display_block float_left" type="radio" value="Prefused Crushed" name="composition"><p class="display_block float_left">Prefused Crushed</p></li>
    								<li class="clearfix"><input class="display_block float_left" type="radio" value="Blended Powder" name="composition"><p class="display_block float_left">Blended Powder</p></li>
    								<li class="clearfix"><input class="display_block float_left" type="radio" value="other" name="composition"><p class="display_block float_left">Other</p><input class="display_block float_left" type="text" name="compositionOther" size="50"/></li>
    							</ul>
    						</li>
    						
    						<li><div class="linebreak"></div></li>
    						
    						<li class="clearfix">
    							<ul class="vertlist">
    								<li><p>What analytical technique(s) are you using?</p></li>
    								<li class="clearfix"><input class="display_block float_left" type="checkbox" name="technique1" value="XRF (X-Ray Fluorescence)"><p class="display_block float_left">XRF (X-Ray Fluorescence)</p></li>
    								<li class="clearfix"><input class="display_block float_left" type="checkbox" name="technique2" value="AA (Atomic Absorption)"><p class="display_block float_left">AA (Atomic Absorption)</p></li>
    								<li class="clearfix"><input class="display_block float_left" type="checkbox" name="technique3" value="ICP (Inductively Coupled Plasma)"><p class="display_block float_left">ICP (Inductively Coupled Plasma)</p></li>
    								<li class="clearfix"><input class="display_block float_left" type="checkbox" name="technique4" value="other"><p class="display_block float_left">Other</p><input class="display_block float_left" type="text" name="techniqueOther" size="50"/></li>
    							</ul>
    						</li>
    						
    						<li><div class="linebreak"></div></li>
    						
    						<li>
    							<ul class="vertlist">
    								<li><p>What is your industry?</p></li>
    								<li>
    									<select size="1" name="industry">
    										<option value="Select an industry">Select an industry</option>
											<option value=" Academia ">Academia</option>
											<option value=" Agriculture & Forestry ">Agriculture & Forestry</option>
											<option value=" Construction ">Construction</option>
											<option value=" Consumer Chemical Manufacturer ">Consumer Chemical Manufacturer</option>
											<option value=" Distributors & Purchasing Agents ">Distributors & Purchasing Agents</option>
											<option value=" Drilling, Mining & Metallurgical ">Drilling, Mining & Metallurgical</option>
											<option value=" Electronics ">Electronics</option>
											<option value=" Energy, Power & Utilities ">Energy, Power & Utilities</option>
											<option value=" Food Production & Safety ">Food Production & Safety</option>
											<option value=" Government - Aerospace ">Government - Aerospace</option>
											<option value=" Government - Agriculture ">Government - Agriculture</option>
											<option value=" Government - Biomedical ">Government - Biomedical</option>
											<option value=" Government - Chemical ">Government - Chemical</option>
											<option value=" Government - Defense ">Government - Defense</option>
											<option value=" Government - Energy ">Government - Energy</option>
											<option value=" Government - Environment ">Government - Environment</option>
											<option value=" Government - Geological ">Government - Geological</option>
											<option value=" Industrial Chemical Manufacturers ">Industrial Chemical Manufacturers</option>
											<option value=" Industrial Manufacture & Supply ">Industrial Manufacture & Supply</option>
											<option value=" Instrument Manufacturer ">Instrument Manufacturer</option>
											<option value=" International Distributor ">International Distributor</option>
											<option value=" Laboratory - Environmental ">Laboratory - Environmental</option>
											<option value=" Laboratory - Research ">Laboratory - Research</option>
											<option value=" Laboratory & Scientific Manufacture & Service ">Laboratory & Scientific Manufacture & Service</option>
											<option value=" Laboratory- Biological ">Laboratory- Biological</option>
											<option value=" Laboratory- Environmental ">Laboratory- Environmental</option>
											<option value=" Medical ">Medical</option>
											<option value=" Petroleum ">Petroleum</option>
											<option value=" Pharmaceutical ">Pharmaceutical</option>
											<option value=" Services ">Services</option>
											<option value=" Transporation & Aerospace ">Transporation & Aerospace</option>
											<option value=" Waste Management ">Waste Management</option>
    									</select>
    								</li>
    							</ul>
    						</li>
    						
    						<li><div class="linebreak"></div></li>
    						
    						<li>
    							<ul class="vertlist">
    								<li><p>Comments?</p></li>
    								<li><textarea rows="4" name="comments" cols="60"></textarea></li>
    							</ul>
    						</li>
    						
    						<li><div class="linebreak"></div></li>
    						
    						<li><input type="submit" value="Submit My Request"></li>
    					</ul>
    					
    				</form>

    			</div> <!--end main grid_12-->
    				    			
    		</div> <!-end main page_margins--->
    	</div> <!--END MAIN-->
    
    	<div id="footer">
    		<div class="page_margins">
    		</div> <!--end footer page_margins-->
    	</div> <!--END FOOTER-->
	
  				
		<!-- mathiasbynens.be/notes/async-analytics-snippet Change UA-XXXXX-X to be your site's ID -->
  		<script type="text/javascript">
    		var _gaq=[["_setAccount","UA-XXXXX-X"],["_trackPageview"]];
    		(function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];g.async=1;
    		g.src=("https:"==location.protocol?"//ssl":"//www")+".google-analytics.com/ga.js";
    		s.parentNode.insertBefore(g,s)}(document,"script"));
  		</script>
	</body>
	
</html>
