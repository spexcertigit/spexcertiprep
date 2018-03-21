<%@ Page Language="C#" Debug="true" EnableSessionState="True" %>
<%

String Part = "";
String Product = "";
String Unit = "";
String Background = "";

const String Background1 = "#fff";
const String Background2 = "#EAEAEA";

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

		<script lang="javascript">
		
			function submitform(Part,Product,UnitPk)
			{

				document.frmMain.hdnPart.value				= Part;
				document.frmMain.hdnProduct.value			= Product;
				document.frmMain.hdnUnitPk.value			= UnitPk;

				document.frmMain.hdnAction.value			= "submit";			  
				document.frmMain.submit();
			}
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
    					<h2 class="display_block position_absolute"><a href="http://www.spexcertiprep.com" target="_blank"><strong>www.spexcertiprep.com</strong></a></h2>
    				</div>
    			</div>
    		</div>
    	</div> <!--END HEADER-->
    
    	<div id="main"> <!--BEGIN MAIN-->
    		<div class="page_margins">
    			
    			<div class="grid_9"> <!--begin main grid_9-->
    				<img class="float_left" src="images/fusionflux.png">
    				<div class="grid_9 float_right">
    					<h2><strong>Pure and Ultra-Pure</strong></h2>
    					<h1><strong>SPEX Fusion Flux</strong></h1>
    					<p>Announcing SPEX CertiPrep's lines of Pure and Ultra-Pure Fusion Fluxes and additives. Both lines are made from a "Micro Bead" formula to guarantee the same ratio of components in every bead. These beads prevent harmful dust from clogging your instruments. To maintain a higher level of consistency and quality, each batch of Flux is made identically with no lot-to-lot variation.
    						<br>
							<br>Request a free 100g sample of the SPEX Fusion Flux of your choice.
    						<br>No purchase necessary.
    					</p>
    				</div>
    			</div> <!--end main grid_9-->
    			
    			<div class="grid_3"> <!--begin main grid_3-->
    				<div>
    					<p><strong>Key Benefits:</strong></p>
    					<ul class="custom_bullets">
    						<li>Pre-Fused with additives for better accuracy</li>
    						<li>New Micro Beads eliminate dust that clogs equipment!</li>
    						<li>Consistency &mdash; Each bead has the exact same ratio of components</li>
    						<li>Our Ultra-Pure line is 99.998% pure!</li>
    					</ul>
    				</div>
    			</div> <!--end main grid_3-->
    				
    			<!--NOTE: the table styles need to be pulled out of inline and
    				added to the css-->
    				<div class="grid_12 bottom_margin50px"> <!--begin main grid_12 for table-->
    					<form name="frmMain" action="requestform.aspx" method="post">

							<input type='hidden' name='hdnPart' value=''>
							<input type='hidden' name='hdnProduct' value=''>
							<input type='hidden' name='hdnUnitPk' value=''>
							<input type='hidden' name='hdnAction' value=''>

	    					<table class="productdata_table1 center" align="center">
	            				<thead>
	              					<tr>
	                					<th scope="col" id="PartNumber" onclick="doSort('PartNumber')" class="header" >Part #</th>
	                					<th scope="col" id="title" onclick="doSort('title')" class="header">Product Name</th>
	                					<th scope="col">Select Your<br/>Free Sample</th>
	              					</tr>
	              				</thead>
	              				<tbody>

<%
	Part = "FFB-0000-02";
	Product = "Lithium Metaborate, Pure Grade";
	Unit = "1";
	Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%
	Part = "FFB-0000-03";
	Product = "Lithium Metaborate, Ultra Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%
	Part = "FFB-0005-02";
	Product = "LiM/LiBr 99.50/0.50, Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%
	Part = "FFB-0005-03";
	Product = "LiM/LiBr 99.50/0.50, Ultra Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%
	Part = "FFB-0007-02";
	Product = "LiM/LiBr 98.50/1.50, Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%
	Part = "FFB-0007-03";
	Product = "LiM/LiBr 98.50/1.50, Ultra Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%
	Part = "FFB-1000-02";
	Product = "Lithium Tetraborate, Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%
	Part = "FFB-1000-03";
	Product = "Lithium Tetraborate, Ultra Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%
	Part = "FFB-1005-02";
	Product = "LiT/LiBr 99.50/0.50, Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%
	Part = "FFB-1005-03";
	Product = "LiT/LiBr 99.50/0.50, Ultra Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%
	Part = "FFB-1007-02";
	Product = "LiT/LiI 99.50/0.50, Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%
	Part = "FFB-1007-03";
	Product = "LiT/LiI 99.50/0.50, Ultra Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%
	Part = "FFB-3500-02";
	Product = "LiT/LiM 35/65 (12/22), Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%
	Part = "FFB-3500-03";
	Product = "LiT/LiM 35/65 (12/22), Ultra Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%
	Part = "FFB-3505-02";
	Product = "LiT/LiM/LiBr 34.83/64.67/0.50, Pure Grade";
	Unit = "10";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%
	Part = "FFB-3505-03";
	Product = "LiT/LiM/LiBr 34.83/64.67/0.50, Ultra Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%
	Part = "FFB-5000-02";
	Product = "50% Lithium Tet/50% Lithium Met, Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%
	Part = "FFB-5000-03";
	Product = "50% Lithium Tet/50% Lithium Met, Ultra Pure Grade";
	Unit = "10";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%
	Part = "FFB-5005-02";
	Product = "LiT/LiM/LiBr 49.75/49.75/0.50 Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%
	Part = "FFB-5005-03";
	Product = "LiT/LiM/LiBr 49.75/49.75/0.50 Ultra Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>


<%

	Part = "FFB-5007-02";
	Product = "LiT/LiM/LiI 49.75/49.75/0.50 Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%
	Part = "FFB-5007-03";
	Product = "LiT/LiM/LiI 49.75/49.75/0.50 Ultra Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%

	Part = "FFB-6700-02";
	Product = "67% Lithium Tet/33% Lithium Met, Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%

	Part = "FFB-6700-03";
	Product = "67% Lithium Tet/33% Lithium Met, Ultra Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%

	Part = "FFB-6705-02";
	Product = "LiT/LiM/LiBr 66.67/32.83/0.50 Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%

	Part = "FFB-6705-03";
	Product = "LiT/LiM/LiBr 66.67/32.83/0.50 Ultra Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
<%

	Part = "FFB-6707-02";
	Product = "LiT/LiM/LiI 66.67/32.83/0.50 Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>

<%
	Part = "FFB-6707-03";
	Product = "LiT/LiM/LiI 66.67/32.83/0.50 Ultra Pure Grade";
	Unit = "1";
	if (Background == Background1) 
		Background = Background2;
	else
		Background = Background1;
%>
	              					<tr style="background-color:<%=Background%>">
	                					<td class="partno"><%=Part%></td>
	                					<td class="desc"><a href="../products/product_inorganic.aspx?part=<%=Part%>"><%=Product%></a></td>
	                					
	                					<td class="buybutton">
	                						<input type="button" onclick="javascript: submitform('<%=Part%>','<%=Product%>','<%=Unit%>')" value="Free Sample">
										</td>
	              					</tr>
	              
	            				</tbody>
	            			</table>
            			</form>
    				</div> <!--end grid 12 for table-->
    			
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
