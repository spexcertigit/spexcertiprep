<%@ Page Title="SPEX CertiPrep - About Us - Careers" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="careers.aspx.cs" Inherits="about_careers" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">


<style type="text/css">

/* Styles For Jobs Accordian */
#job {
	margin: 0;
	padding: 0 10px 0 0;
	width: 100%; /*width of job*/
}
#job dt {
/*	font-size: 13px;	*/
	font-size: 15px;	
	color: #5a5b5d;
	margin: 0;
	padding: 5px 0 10px 0;
	line-height: 18px;
	text-decoration: none;
	font-weight: normal;
}
#job a.title:link, a.title:visited { /*need to add the containing div for style specificty to work*/
/*	font-size: 13px;	*/
	font-size: 15px;
	display: block;
	position: relative;
	width: auto;
	font-weight: bold;
/*	text-decoration: none;
	text-transform: uppercase;	*/
	text-decoration: underline;
	text-transform: none;	
}
#job a.title:active {
/*	font-size: 13px;	*/
	font-size: 15px;
	font-weight: bold;
	text-decoration: underline;
	display: block; 
}
#job a.title:hover { 
/*	font-size: 13px;	*/
	font-size: 15px;
	text-decoration: underline;
	display: block;  /*need to set here to work for IE6 */

}
/*for IE6 only - it will ignore declaration below because it can't understand it*/
#job a.title .statusicon {
	position: relative;
	display: inline;
	float: right;
	top: -34px;
	right: 15px;
	margin-left: 80px;
	border: none;
}
/*for all browsers except IE6*/
	html>body #job a.title .statusicon { /*CSS for icon image that gets dynamically added to headers -- IE6 will ignore this declaration*/
	position: absolute; /*this won't work in IE6 with IE6 png hack*/
	top: 10px;
	right: 25px;
	border: none;
}
#job dd.summary { /*ddthat contains each sub job*/
	display: block;  /*need to set here to work for IE6 */
	margin-bottom: 20px;
	padding: 10px 0 2px 0px;
}
#job dd.summary ul { /*UL of each sub job*/
	list-style-type: none;
	margin: 0;
	padding: 0 0 10px 0;
}
#job dd.summary ul li {
}
#job dd.summary ul li a {
	display: block;
/*	font: normal 13px;	*/
	font: normal 15px;
	color: black;
	text-decoration: none;
	padding: 2px 0;
	padding-left: 10px;
}
#job dd.summary ul li a:hover {
	background: #DFDCCB;
}
.collapsed { /*style for menu header when collapsed */
	font-weight: bold;
}
.expanded { /*style for menu header when expanded */
	font-weight: bold;
	text-decoration: underline;
}
#col3 h2 { border-bottom:2px solid #bfbfbf;padding-bottom:6px; }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="../default.aspx">Home</a> > About Us > Careers</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="mainHeader">
                <h1>Careers</h1>
            </div>
            <div id="main">
                <div id="col1">
                    <div id="col1_content" class="clearfix">
						<asp:PlaceHolder ID="Image" runat="server" />
						<uc1:ShareThis ID="ShareThis1" runat="server" />
                    </div>
                </div>
                <div id="col3">
                    <div id="col3_content" class="clearfix">
						<asp:PlaceHolder ID="BodyContent" runat="server" />

                        <!-- Job entry -->
                        <dl id="job">
                            <asp:Literal ID="ltrJobs" runat="server" />
                        </dl>
                        <br />
						<asp:PlaceHolder ID="BottomContent" runat="server" />
                    </div>
                    <div id="ie_clearing"> &#160; </div>
                </div>
            </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script src="/js/ddaccordion.js" type="text/javascript"></script>
	<script type="text/javascript">

		/***********************************************
		* Accordion Content script- (c) Dynamic Drive DHTML code library (www.dynamicdrive.com)
		* Visit http://www.dynamicDrive.com for hundreds of DHTML scripts
		* This notice must stay intact for legal use
		***********************************************/

		//initialize chemist accordian
		ddaccordion.init({
			headerclass: "title", //Shared CSS class name of headers group
			contentclass: "summary", //Shared CSS class name of contents group
			revealtype: "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click" or "mouseover
			collapseprev: true, //Collapse previous content (so only one open at any time)? true/false 
			defaultexpanded: [], //index of content(s) open by default [index1, index2, etc] [] denotes no content
			onemustopen: false, //Specify whether at least one header should be open always (so never all headers closed)
			animatedefault: false, //Should contents open by default be animated into view?
			persiststate: false, //persist state of opened contents within browser session?
			toggleclass: ["collapsed", "expanded"], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
			togglehtml: ["suffix", "", ""], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
			animatespeed: "normal", //speed of animation: "fast", "normal", or "slow"
			oninit: function (headers, expandedindices) { //custom code to run when headers have initalized
				//do nothing
			},
			onopenclose: function (header, index, state, isuseractivated) { //custom code to run whenever a header is opened or closed
			}
		})

	</script>
</asp:Content>

