<%@ Page Title="SPEX CertiPrep - Knowledge Base - FAQs" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="ask-our-chemists.aspx.cs" Inherits="knowledge_base_FAQs" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">

<style type="text/css">
/* Styles For Ask-Our-Chemists Accordian */
#chemist {
	margin: 0;
	padding: 0 10px 0 0;
	width: 100%; /*width of chemist*/
}
#chemist dt {
	font-size: 13px;
	color: #94a232;
	margin: 0;
	padding: 5px 0 10px 0;
	line-height: 18px;
	text-decoration: none;
	font-weight: normal;
}
#chemist a.question:link, a.question:visited { /*need to add the containing div for style specificty to work*/
	font-size: 13px;
	color: #94a232;
	display: block;
	position: relative;
	width: auto;
	text-decoration: none;
}
#chemist a.question:active {
	font-size: 13px;
	color: #737a43;
	font-weight: bold;
	text-decoration: underline;
	display: block;
}
#chemist a.question:hover {
	font-size: 13px;
	color: #737a43;
	text-decoration: underline;
	display: block;  /*need to set here to work for IE6 */
}
/*for IE6 only - it will ignore declaration below because it can't understand it*/
#chemist a.question .statusicon {
	position: relative;
	display: inline;
	float: right;
	top: -34px;
	right: 15px;
	margin-left: 80px;
	border: none;
}
/*for all browsers except IE6*/
	html>body #chemist a.question .statusicon { /*CSS for icon image that gets dynamically added to headers -- IE6 will ignore this declaration*/
	position: absolute; /*this won't work in IE6 with IE6 png hack*/
	top: 10px;
	right: 25px;
	border: none;
}
#chemist dd.answer { /*ddthat contains each sub chemist*/
	display: block;  /*need to set here to work for IE6 */
	background-color:#EFEFEF;
	margin: 0;
	margin-top: -10px;
	padding: 10px 0 2px 10px;
}
#chemist dd.answer ul { /*UL of each sub chemist*/
	list-style-type: none;
	margin: 0;
	padding: 0 0 10px 0;
}
#chemist dd.answer ul li {
}
#chemist dd.answer ul li a {
	display: block;
	font: normal 13px;
	color: black;
	text-decoration: none;
	padding: 2px 0;
	padding-left: 10px;
}
#chemist dd.answer ul li a:hover {
	background: #DFDCCB;
}
.collapsed { /*style for menu header when collapsed */
	font-weight: normal;
}
.expanded { /*style for menu header when expanded */
	font-weight: bold;
	color: #FFFFFF;
	text-decoration: underline;
	background-color:#EFEFEF;
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/default.aspx">Home</a> > Knowledge Base > Ask A Chemist</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="mainHeader">
                <asp:Literal ID="ltrHeadline" runat="server" />
            </div>
            <div id="main">
                <div id="col1">
                    <div id="col1_content" class="clearfix">
                        <img src="images/certi_tempimage_29.jpg" alt="Your science is our passion" width="240" height="240" />	  
						<uc1:ShareThis ID="ShareThis1" runat="server" />
                    </div>
                </div>
                <div id="col3">
                    <div id="col3_content" class="clearfix">
		                <dl id="chemist">
                            <asp:Literal ID="ltrSubHeader" runat="server" />
                            <asp:Literal ID="ltrContent" runat="server" />
                            <asp:Literal ID="ltrBody" runat="server" />
	                   </dl>
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
			headerclass: "question", //Shared CSS class name of headers group
			contentclass: "answer", //Shared CSS class name of contents group
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

		$(document).ready(function () { //oddtable row coloring and tablesorter for chemist table 
			$("#chemist_table tr:odd").addClass("oddtablerow");
			$("#chemist_table").tablesorter();

		});
	</script>
</asp:Content>

