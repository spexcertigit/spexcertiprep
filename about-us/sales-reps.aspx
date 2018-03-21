<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="sales-reps.aspx.cs" Inherits="about_reps" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
<style>
	.header {
		background: url('images/header-bg.png') repeat-x;
		border:1px solid #4d501e;
		margin-top:35px;
		border-right:none;
	}
	.header .col {
		width:50%;
		box-sizing:border-box;
		float:left;
		border-right:1px solid #4d501e;
		padding:11px 0;
	}
	#main h2 { font-size:23px; }
	#main .header .col h2 {
		color:#fff;
		font-weight:bold;
		padding:0 25px;
	}
	.support_team_box {
		position: relative; 
		margin: 0 0 20px; 
		border: 1px solid #3a3a3a;
		border-top:none;
	}
	.support_team_box .col1, .support_team_box .col2 {
		width:50%;
		box-sizing:border-box;
		float:left;
		border-right:1px solid #4d501e;
		padding:25px;
		min-height:356px;
	}
	.support_team_box .col1 { background: url('images/col1.png') no-repeat; background-position:bottom}
	.support_team_box .col2 { 
		background: url('images/col2.png') no-repeat;
		border-right:none; 
		background-position:bottom
	}
	.support_team_box div { line-height: 21px;}
	.sep {
		height:4px;
		background: url('images/sep.png') repeat-x;
		margin:5px 0 20px;
	}
	.linkToSample {
		background: #f1f1f1;
		border: 1px solid #e1dcdc;
		position: relative;
		padding: 5px 50px 5px 20px;
		width: 520px;
	}
	.linkToSample img { position:absolute; right: 0; top: 0; }
	.linkToSample a { color:#f49116;}
	#mainHeader h1 { float:left }
	.teri { font-size: 18px; color:#a3b405}
</style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="../default.aspx">Home</a> > About Us > Sales Reps</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">

            <div id="mainHeader">
                <asp:Literal ID="ltrHeadline" runat="server" />
            </div>
            <div id="main" style="margin-bottom:100px">
                <asp:Panel ID="pnlContent" runat="server">
                <asp:Panel ID="pnlUSMap" runat="server" >
                    <div style="padding-bottom: 20px;">
                        <img src="/images/new_spex_usa_map.gif" alt="SPEX US Sales Reps" border="0" usemap="#Map" title="SPEX US Sales Reps"/>
                                       </div>
                                            <div class="sales_rep_skype" style="float: left;">
                       
                                                <br />
                        <div style="height:40px; width:40px; background-color:#9FA615; float:left; margin-right:25px;">&nbsp; </div>
                        <div class="agent_desc" style="float: left; width: 185px; margin-right: 45px;line-height: 21px;">
                            <strong style="color:#9FA615">Matt Snyder</strong><br />
									Tel: 732-623-0497<br />
                            Email: <a href="mailto:msnyder@spex.com">msnyder@spex.com</a><br />
                            <div style="float:left;"><a href="skype:matt.snyder19?chat"></a> </div>
                            Skype ID: matt.snyder19
                        </div>
                        <div style="height:40px; width:40px;  background-color:#9396cb; float:left; margin-right:25px;">&nbsp; </div>
                        <div class="agent_desc" style="float: left; width: 185px; margin-right: 43px;line-height: 21px;">
                            <strong style="color:#9396cb">Jeff Akers</strong><br />
                            Tel: 732-623-0404<br />
                            Email: <a href="mailto:jakers@spex.com">jakers@spex.com</a><br />
                             <div style="float:left;"><a href="skype:Jeffrey.Akers.SPEX?chat"></a> </div>
                            Skype ID: Jeffrey.Akers.SPEX
                        </div>
                        <div style="height:40px; width:40px; background-color:#ff9900; float:left; margin-right:25px;">&nbsp; </div>
                        <div class="agent_desc" style="float: left; width: 185px; margin-right: 45px;line-height: 21px;">
                            <strong style="color:#ff9900">Rebekah Biermann</strong><br />
									Tel: 732-549-7144 x 701<br />
                            Email: <a href="mailto:rbiermann@spex.com">rbiermann@spex.com</a><br />
                        </div>
                        <div style="height:80px; width:80px; background-color:#9396cb; display:none; float:left; margin-right:25px;">&nbsp; </div>
                        <div class="agent_desc" style="float: left; width: 185px;line-height: 21px;  display:none;">
                            <strong>Open Territory</strong><br />
                            Tel: 732-549-7144<br />
                            Email: <a href="mailto:crmsales@spex.com">crmsales@spex.com</a><br />
                        </div>   
                    </div>
                    <div style="clear:both;" />
                </asp:Panel>
                <asp:Panel ID="pnlUK" runat="server">
				<div class="header">
					<div class="col">
						<h2>Sales/Customer Support Teams</h2>
					</div>
					<div class="col">
						<h2>International Sales</h2>
					</div>
					<div style="clear:both"></div>
				</div>
                <div class="support_team_box">
                    <div class="col1">
                        <div style="margin-bottom: 15px;">
                            <strong>Lisa Collins</strong> &#8212; Customer Care Manager<br />
                            Tel: 732-623-0455<br />
                            Email: <a href="mailto:LCollins@spexcsp.com">LCollins@spexcsp.com</a><br />
                            <div style="float:left;"><a href="skype:lisa.collins322?chat"></a> </div>Skype: lisa.collins322 
                        </div> 
                        <div style="margin-bottom: 15px;">
                            <strong>Christy Pedraza</strong> &#8212; Sales Support Specialist<br />
                            Tel: 732-623-0431<br />
                            Email: <a href="mailto:CPedraza@spexcsp.com">CPedraza@spexcsp.com</a><br />
                            <div style="float:left;"><a href="skype:christy.pedraza?chat"></a> </div>Skype: christy.pedraza 
                        </div>
                        <div style="margin-bottom: 15px;">
                            <strong>Sheyeast Thomas</strong> &#8212; Customer Support<br />
                            Tel: 732-549-7144 x 740<br />
                            Email: <a href="mailto:SThomas@spex.com">SThomas@spex.com</a><br />
                    </div>
                        <div style="margin-bottom: 15px;">
                            <strong>Jennifer Ballo</strong> &#8212; Customer Support<br />
                            Tel: 732-549-7144 x 477<br />
                            Email: <a href="mailto:JBallo@spex.com">JBallo@spex.com</a><br />
                    </div>  
                        <div style="margin-bottom: 15px;">
                            <strong>Elizabeth Vlaun</strong> &#8212; Customer Support<br />
                            Tel: 732-549-7144 x 440<br />
                            Email: <a href="mailto:EVlaun@spex.com">EVlaun@spex.com</a><br />
                    </div>  
                    </div>                                     
                    <div class="col2">
                    <!--<div style="float: left; width: 550px;">-->
                        <div style="margin-right: 40px;">
							<strong class="teri">UK / EU</strong><br />
                            <strong>Kshitish Shukla</strong> &#8212; SPEX Europe<br />
                            Tel: +44 (0) 208 204 6656<br />
                            Email: <a href="mailto:KShukla@spex.com">KShukla@spex.com</a><br />
                            <div style="float:left;"><a href="skype:Suzanne.Lepore1?chat"><img style="display:none" src="http://www.skypeassets.com/i/scom/images/skype-buttons/chatbutton_16px.png" alt="Skype:"/></a> </div> Skype: spextish 
                        </div>
                        <div style="margin-top: 40px;">
							<strong class="teri">South America, Canada &amp; Europe</strong><br />
                            <strong>Suzanne Lepore</strong> &#8212; SPEX CertiPrep<br />
                            Tel: 732-623-0419<br />
                            Email: <a href="mailto:SLepore@spexcsp.com">slepore@spexcsp.com</a><br />
                            <div style="float:left;"><a href="skype:Suzanne.Lepore1?chat"><img style="display:none" src="http://www.skypeassets.com/i/scom/images/skype-buttons/chatbutton_16px.png" alt="Skype:"/></a> </div> Skype: Suzanne.Lepore1 
                        </div>   
						<div style="margin-top: 40px;">
							<strong class="teri">Asia, Africa, Middle East, Australia, &amp; New Zealand</strong><br />
                            <strong>Irina Agro</strong> &#8212; SPEX CertiPrep<br />
                            Tel: 732-549-7144 x. 741<br />
                            Email: <a href="mailto:IAgro@spex.com">IAgro@spex.com</a><br />
                            <div style="float:left;"><a href="skype:Suzanne.Lepore1?chat"><img style="display:none" src="http://www.skypeassets.com/i/scom/images/skype-buttons/chatbutton_16px.png" alt="Skype:"/></a> </div> Skype: Irina.Agro.SPEX 
                        </div>
                   </div>
				   <div style="clear: both;"></div>
                </div>
                    </asp:Panel>
                    </asp:Panel>
				<div class="linkToSample">
                    For SamplePrep Sales - Please E-Mail us at: <a href="mailto:SamplePrep@spexcsp.com">SamplePrep@spexcsp.com</a>
					<a href="http://www.spexsampleprep.com/about-us/contact-us"><img src="images/arrow.png" alt="SPEX SamplePrep" /></a>
                </div>
                <p class="sub-p">Your Science is Our Passion&reg;</p>
				<div class="sep"></div>
                <span style="line-height:24px;"><asp:Literal ID="ltrBody" runat="server" /></span>
				<%--<uc1:ShareThis ID="ShareThis1" runat="server" />--%>
            </div>
			</div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script>
		$(document).ready(function(){
			if ($('.col1').height() > $('.col2').height()) {
				$('.col2').height($('.col1').height());
			}else {
				$('.col1').height($('.col2').height());
			}
		});
	</script>
</asp:Content>

