<%@ Page Title="SPEX SamplePrep - Purchasing Options - SPoints Rewards" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="SPoints-Rewards.aspx.cs" Inherits="purchase_spoints" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
<style>
	#main #mainHeader h2 {
		padding: 0;
		height:auto;
		float:none;
		background: #fff;
		padding: 12px 0 0;
		font-size:18px;
		text-align:center;
	}
	#mainHeader { height: auto; }
	#col1 { 
		width:287px;
		min-height: 411px;
	}
	#col3 {
		margin:0 0 0 321px;
		width:665px;
	}
	.contact-us-right {
		margin: 0;
		width: auto;
	}
	.contact-us-right { background:#fff; }
	.contact-us-right .add-content { margin: 8px 0 15px; }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/"><a href="/default.aspx">Home</a> > Purchasing Options > SPoints Rewards</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="main">
                <div id="col1">
					<img src="images/Shop-Earn-Redeem.jpg" title="Shop, Earn and Redeem" alt="Shop, Earn and Redeem" />
					<div id="mainHeader">
						<h2>Contact us to redeem your SPoints!</h2>
					</div>
					<div class="contact-us-right">
						<div class="add-content">
							<div class="add-inner">1-800-LAB-SPEX</div>
							<div class="add-inner">crmsales@spex.com</div>
							<div class="add-inner">203 Norcross Avenue<br>
								Metuchen, NJ 08840
							</div>
						</div>
		            </div>
					<div class="spoints_content" style="display:none">
						<ul style="margin-left:20px;">
							<li><span><strong>SPoints</strong> expire after one year of shipment date.</span></li>
							<li><span>For every $10 spent, earn one <strong>SPoint</strong></span></li>
							<li><span><strong>SPoints</strong> can be compiled throughout the year</span></li>
							<li><span>There is NO LIMIT on how many <strong>SPoints</strong> you can earn</span></li>
							<li><span>Total <strong>SPoints</strong> for each order are located on the bottom of the packing list</span></li>
						</ul>
					</div>
					
				</div>
				<div id="col3">
					<div id="mainHeader">
						<h1 style="font-size:30px;padding-bottom:4px">SPoints Rewards Program</h1>
						<p style='font-size:24px;'>Redeem your <strong>SPoints</strong> for valuable merchandise</p>
						<p>You are automatically enrolled when you place an order with us! For every $10 spent, earn one <em><strong>SPoint.</strong></em> <br />
						There is no limit on how many <em><strong>SPoints</strong></em>  you can earn.
						</p>
					</div>
					<!--<div class="spoints_image"><img alt="" src="images/SPoints-Flyer.jpg"/></div>-->
					<!--<div class="spoints_image"><img alt="" src="images/SPoints-Flyer-updated.jpg"/></div>-->
					<div class="spoints_image"><img alt="" src="images/SPoints-Flyer-updated.png"/></div>
					
					<p style="font-size:13px;color:#3e4245;width:607px;">SPoints are not earned on purchases of Fusion Flux, Oil Standards or QC Samples. SPEX CertiPrep has the right to change or withdraw this offer at any time. Prizes subject to change. SPoints expire after one calendar year. Valid only on direct US orders; excludes export, OEM and distributor/reseller orders.</p>
					
					<div style="margin-left:12px;"><uc1:ShareThis ID="ShareThis1" runat="server" /></div>
				</div>
            
				
            </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
</asp:Content>

