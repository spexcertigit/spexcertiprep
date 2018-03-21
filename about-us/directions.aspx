<%@ Page Title="SPEX CertiPrep - About Us - Directions" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="directions.aspx.cs" Inherits="about_directions" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <style type="text/css">
        #col3 h2 { border-bottom:2px solid #bfbfbf;padding-bottom:6px; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="../default.aspx">Home</a> > About Us > Directions</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="mainHeader">
                <h1>Directions to SPEX CertiPrep Headquarters</h1>
            </div>
            <div id="main">
                <div id="col1">
                    <div id="col1_content" class="clearfix">
                        <iframe width="240" height="300" frameborder="1" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.com/maps?q=203+Norcross+Avenue,+Metuchen,+NJ+08840&amp;hl=en&amp;ie=UTF8&amp;hq=&amp;hnear=203+Norcross+Ave,+Metuchen,+Middlesex,+New+Jersey+08840&amp;z=16&amp;ll=40.545996,-74.371669&amp;output=embed"></iframe><br />
                        <small><a href="https://maps.google.com/maps?q=203+Norcross+Avenue,+Metuchen,+NJ+08840&amp;hl=en&amp;ie=UTF8&amp;hq=&amp;hnear=203+Norcross+Ave,+Metuchen,+Middlesex,+New+Jersey+08840&amp;z=16&amp;ll=40.545996,-74.371669&amp;source=embed" target="_blank" style="color:#00f;text-align:left">View Larger Map</a></small>
        
                        <div style="margin-top: 60px; line-height:20px;">
                            <span style="color:#a3b405; font-weight:bold; font-size:20px;">SPEX CertiPrep</span><br />
                            <strong>Street Address</strong><br />
                            203 Norcross Avenue<br />
                            Metuchen, NJ 08840<br />
                            +1.732.549.7144<br />
                            1.800.LAB.SPEX<br />
                            +1.732.603.9647 (fax)<br />
                          <!--  <iframe width="240" height="300" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=2+Dalston+Gardens+Middlesex+Stanmore+HA7+1BQ+&amp;sll=37.0625,-95.677068&amp;sspn=42.631141,66.181641&amp;ie=UTF8&amp;hq=&amp;hnear=2+Dalston+Gardens,+Harrow,+Greater+London+HA7+1,+United+Kingdom&amp;ll=51.608796,-0.293026&amp;spn=0.015991,0.024033&amp;z=14&amp;iwloc=A&amp;output=embed"></iframe><br />
                            <small><a href="http://maps.google.com/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=2+Dalston+Gardens+Middlesex+Stanmore+HA7+1BQ+&amp;sll=37.0625,-95.677068&amp;sspn=42.631141,66.181641&amp;ie=UTF8&amp;hq=&amp;hnear=2+Dalston+Gardens,+Harrow,+Greater+London+HA7+1,+United+Kingdom&amp;ll=51.608796,-0.293026&amp;spn=0.015991,0.024033&amp;z=14&amp;iwloc=A" style="color:#0000FF;text-align:left">View Larger Map</a></small>-->
                        </div>
						<uc1:ShareThis ID="ShareThis1" runat="server" />
                    </div>
                </div>
                <div id="col3">
                    <div id="col3_content" class="clearfix">

                        <p><strong>For detailed driving directions click on the map or click on the links listed below:</strong><br />
                            <a href="#dir_001">From the Garden State Parkway North</a><br />
                            <a href="#dir_002">From the Garden State Parkway South</a><br />
                            <a href="#dir_003">From the New Jersey Turnpike</a><br />
                            <a href="#dir_004">From I-287 North</a><br />
                            <a href="#dir_005">From I-287 South</a><br />
                            <a href="#dir_006">From US 1 South</a><br />
                            <a href="#dir_007">From US 1 North</a></p>
                        <h2 id="dir_001">From the Garden State Parkway North</h2>
                        <p> Take exit 127 for State Hwy 440 S toward I-287 N.<br />
                            Merge onto RT-440 S.<br />
                            Continue on I-287 N.<br />
                            Take exit 2A for State Hwy 27 N toward Metuchen.<br />
                            Merge onto Middlesex Ave/RT-27.<br />
                            Continue to follow RT-27.<br />
                            Turn left at Middlesex Ave.<br />
                            Turn right at Central Ave.<br />
                            Turn left at Liberty St.<br />
                            Turn left at Norcross Ave. SPEX CertiPrep is on the corner of Liberty and Norcross.<br />
                            Park in the lot in front of the building. </p>
                        <h2 id="dir_002">From the Garden State Parkway South</h2>
                        <p> Take exit 131 for State Hwy 27 toward Iselin/Metuchen/Rahway.<br />
                            Keep right at the fork; follow signs for METUCHEN/EDISON and merge onto RT-27.<br />
                            Turn right at Central Ave.<br />
                            Turn left at Liberty St.<br />
                            Turn left at Norcross Ave. SPEX CertiPrep is on the corner of Liberty and Norcross.<br />
                            Park in the lot in front of the building. </p>
                        <h2 id="dir_003">From the New Jersey Turnpike</h2>
                        <p> Take exit 10 for State Hwy 440/I-287 toward Edison Twp./Metuchen/Perth Amboy.<br />
                            Keep left at the fork to continue toward I-287 N.<br />
                            Keep left at the fork, follow signs for I-287 N and merge onto I-287 N.<br />
                            Take exit 2A for State Hwy 27 N toward Metuchen.<br />
                            Merge onto Middlesex Ave/RT-27.<br />
                            Continue to follow RT-27.<br />
                            Turn left at Middlesex Ave.<br />
                            Turn right at Central Ave.<br />
                            Turn left at Liberty St.<br />
                            Turn left at Norcross Ave. SPEX CertiPrep is on the corner of Liberty and Norcross.<br />
                            Park in the lot in front of the building. </p>
                        <h2 id="dir_004">From I-287 North</h2>
                        <p> Take exit 2A for State Hwy 27 N toward Metuchen.<br />
                            Merge onto Middlesex Ave/RT-27.<br />
                            Continue to follow RT-27.<br />
                            Turn left at Middlesex Ave.<br />
                            Turn right at Central Ave.<br />
                            Turn left at Liberty St.<br />
                            Turn left at Norcross Ave. SPEX CertiPrep is on the corner of Liberty and Norcross.<br />
                            Park in the lot in front of the building. </p>
                        <h2 id="dir_005">From I-287 South</h2>
                        <p> Take exit 3 for Co Hwy 501 E toward Metuchen.<br />
                            Turn left at New Durham Rd.<br />
                            Slight left at Durham Ave.<br />
                            Turn left at Central Ave.<br />
                            Turn left at Liberty St.<br />
                            Turn left at Norcross Ave. SPEX CertiPrep is on the corner of Liberty and Norcross.<br />
                            Park in the lot in front of the building. </p>
                        <h2 id="dir_006">From US 1 South</h2>
                        <p> Slight right at Woodbridge Ave.<br />
                            Turn left at Plainfield Ave.<br />
                            Turn right at RT-27.<br />
                            Turn left at Middlesex Ave.<br />
                            Turn right at Central Ave.<br />
                            Turn left at Liberty St.<br />
                            Turn left at Norcross Ave. SPEX CertiPrep is on the corner of Liberty and Norcross.<br />
                            Park in the lot in front of the building. </p>
                        <h2 id="dir_007">From US 1 North</h2>
                        <p> Take the exit toward Amboy Ave.<br />
                            Turn right at Amboy Ave.<br />
                            Turn right at Lake Ave/RT-27.<br />
                            Turn left at Middlesex Ave.<br />
                            Turn right at Central Ave.<br />
                            Turn left at Liberty St.<br />
                            Turn left at Norcross Ave. SPEX CertiPrep is on the corner of Liberty and Norcross.<br />
                            Park in the lot in front of the building. </p>
                    </div>
                    <div id="ie_clearing"> &#160; </div>
                </div>
            </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
</asp:Content>

