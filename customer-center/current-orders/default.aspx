<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="hipure_inorganic" Debug="True"%>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <style type="text/css">
        a.aspNetDisabled { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        a.aspNetDisabled:hover { font-weight:normal; text-decoration:none;color:#5A5B5D; } 
        #ProductListPagerSimple span,
        #ProductListPagerSimple2 span { font-weight:bold; }
		.buybutton { border-right: 1px solid #727272; }
		#breadcrumb { padding:0;}
    </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
	<!--CAS Pop Up-->
	<div id="cas-container-opacity">
		<div id="cas-container">
			<div class="close-x"></div>
			<div class="CAStable"></div>
		</div>
	</div>
	<!--EOF CAS Pop Up-->
	<div id="main" style="margin-bottom:2em">
		<h1 class="cc">Customer Center</h1>
            <div class="subcolumns">			
				<div class="c30l">
					<div>
						<h2 id="cusOrders">Orders</h2>
						<div class="customer-center">
							<ul>
								<li><a class="selected">Current Orders</a></li>
								<li><a href="/customer-center/order-summary/">Order Summary</a></li>
								<li><a href="/customer-center/order-details/">Order Details</a></li>
								<li><a href="/customer-center/previous-orders/">Previous Orders</a></li>
								<li><a href="/customer-center/loyal-customer-rewards/">My SPoints</a></li>
								<li><a href="/customer-center/settings/">Account Settings</a></li>
							</ul>
						</div>
					</div>
					 
				</div>	
				<div class="c66r ">
    			    <div style="">
						<div id="cc-p">		
							<h2 class="ccClient">Hello, <%=DisplayName%>!</h2>
							<p>Welcome to our Customer Center page. From here you have a access to your entire order history for your account. You can easily see the status of current orders, access prior orders, view SDS by part number and easily re-order. In addition you now have access to view your SPoints Rewards balance.</p>
							<p>Contact <a href="mailto:CRMMarketing@spex.com">CRMMarketing@spex.com</a> with any questions.</p>
						</div> 											
    			    </div>
    		    </div>	
            </div>
    <div id="resultstable" style="margin-top:3em">
		<!--<div style="text-align: right; margin: 1.5em 0 0;">-->
		<div class="pagers1_wrapper">									
			<div style="clear:both"></div>
		</div>
		<div><h2 class="cc">Current Orders</h2></div>
		<div class="customer-center-nav">
			<a data-id="frequent_orders" class="tabselector selected" href="javascript:void()">Frequent Orders</a>
			<a data-id="custom_orders" class="tabselector" href="javascript:void()">Custom Orders</a>
			<a data-id="blanket_orders" class="tabselector" href="javascript:void()">Blanket Orders</a>
			<a data-id="quotes" class="tabselector" href="javascript:void()">Quotes</a>
			<div class="bottom-line"></div>
		</div>
        <div id="frequent_orders" class="tab" style="margin:2em 0 6em;display:block"> 
			<div id="web-freq-orders" class="freqOrderTabs">
				<table id="freq-orders" width="958" class="tablesorter cc" align="center" >
					<thead>
						<tr>
							<th scope="col" id="selector">&nbsp;</th>
							<th scope="col" id="partnumber" onclick="doSort('partnumber')" class="header sorter">Part #</th>
							<th scope="col" id="prodname" onclick="doSort('prodname')" class="header sorter">Product Name</th>
							<th scope="col" id="count" onclick="doSort('count')" class="header sorter">Times Ordered</th>
							<th scope="col" id="price" onclick="doSort('price')" class="">Price</th>
							<th scope="col" style="border-right:1px solid;">Add to Cart</th>
						</tr>
					</thead>
					<tbody>
						<asp:ListView ID="lvFreqOrders2" runat="server" DataSourceID="dataFreqOrders2">
							<LayoutTemplate>
								<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
							</LayoutTemplate>
							<ItemTemplate>
								<tr class="webUser">
									<td><input type="checkbox" class="selector" data-partnum="<%#Eval("item_id").ToString().Trim() %>" /></td>
									<td>
										<%# checkProductType(Eval("item_id").ToString().Trim()) %>
									</td>
									<td style="text-align:left"><%# getProdName(Eval("item_id").ToString().Trim()) %></td>
									<td><%# Eval("cnt").ToString() %></td>
									<td><%# GetPrice(Eval("item_id").ToString().Trim()) %></td>
									<td class="buybutton" style="white-space:nowrap;">
										<input name='quantity_<%# Eval("item_id").ToString().Trim() %>' type="text" id='quantity_<%# Eval("item_id").ToString().Trim() %>' class="search_quantity" value="1" />
										<input type="button" id='buy_<%# Eval("item_id").ToString().Trim() %>' name='buy_<%# Eval("item_id").ToString().Trim() %>' value="" class="search_buy" onclick="buyIt2('<%# Eval("item_id").ToString().Trim() %>');" />
									</td>
								</tr>
							</ItemTemplate>
							<EmptyDataTemplate>
								
							</EmptyDataTemplate>
						</asp:ListView> 
						
						<asp:ListView ID="lvFreqOrders" runat="server" DataSourceID="dataFreqOrders">
							<LayoutTemplate>
										<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
							</LayoutTemplate>
							<ItemTemplate>
								<tr class="webUser">
									<td><input type="checkbox" class="selector" data-partnum="<%#Eval("Item_Part_Nbr").ToString().Trim() %>" /></td>
									<td>
										<%# checkProductType(Eval("Item_Part_Nbr").ToString().Trim()) %>
									</td>
									<td style="text-align:left"><%# getProdName(Eval("Item_Part_Nbr").ToString().Trim()) %></td>
									<td><%# Eval("cnt").ToString() %></td>
									<td><%# GetPrice(Eval("Item_Part_Nbr").ToString().Trim()) %></td>
									<td class="buybutton" style="white-space:nowrap;">
										<input name='quantity_<%# Eval("Item_Part_Nbr").ToString().Trim() %>' type="text" id='quantity_<%# Eval("Item_Part_Nbr").ToString().Trim() %>' class="search_quantity" value="1" />
										<input type="button" id='buy_<%# Eval("Item_Part_Nbr").ToString().Trim() %>' name='buy_<%# Eval("Item_Part_Nbr").ToString().Trim() %>' value="" class="search_buy" onclick="buyIt2('<%# Eval("Item_Part_Nbr").ToString().Trim() %>');" />
									</td>
								</tr>
							</ItemTemplate>
							<EmptyDataTemplate>
								
							</EmptyDataTemplate>
						</asp:ListView> 
					</tbody>
				</table>
			</div>
			
			<div style="padding:15px;display:block"></div>
			<div><h2 class="cc">Current Order Status</h2></div>
            <table id="curr-orders" width="958" class="tablesorter cc" align="center" >
                <thead>
                    <tr>
                        <th scope="col" id="partnumber" onclick="doSort('partnumber')" class="header sorter">Part #</th>
                        <th scope="col" id="title" onclick="doSort('title')" class="header sorter">Lot #</th>
                        <th scope="col" id="matrix" onclick="doSort('matrix')" class="header sorter">Date Ordered</th>
                        <th scope="col" id="volume" onclick="doSort('volume')" class="">Certificate</th>
                        <th scope="col">SDS</th>
						<th scope="col" id="status" onclick="doSort('status')" class="header sorter">Status</th>
                        <th scope="col" id="price" onclick="doSort('price')" style="border-right:1px solid;">&nbsp;</th>
                    </tr>
                </thead>
                <tbody>
					<asp:Literal ID="ltrCurrOrders" runat="server" />	
                </tbody>
            </table>
		</div>
		
		<div id="custom_orders" class="tab" style="margin:2em 0 6em; display:none">
			<div class="order-nav">
				<a data-id="inorganicRqForm" class="order-tabselector" href="javascript:void()">Custom Inorganic Standards Request</a>
				<a data-id="organicRqForm" class="order-tabselector" href="javascript:void()">Custom Organic Standards Request</a>
				<div style="clear:both"></div>
			</div>
			<div id="inorganicRqForm" class="prodForms">
				<div id="cisr_gencontent_full">
					<div id="cisr_headerlabel" class="headerlabel">
						<span class="label-left">
							<h1 class="title">Custom Inorganic Standards Request Form</h1>
						</span>
					</div>
					<div id="cisrForm">
						<asp:MultiView ID="mvForm" runat="server" ActiveViewIndex="0">
                            <asp:View ID="vwForm" runat="server">
								<p>SPEX CertiPrep can customize any Standard to meet your specific needs. Enter the Analyte. Next, enter the Concentration.</p>
								<div class="subcolumns">
									<div class="c33l">
										<div class="type-select">
											<asp:DropDownList ID="component" ClientIDMode="Static" runat="server" Width="95%" DataSourceID="dataComponents" DataTextField="caNameWeb" DataValueField="caNameWeb" AppendDataBoundItems="true">
												<asp:ListItem Value="" disabled selected style='display:none;' Text="Component *" />
											</asp:DropDownList>
										</div>
									</div>
									<div class="c33l">
										<div class="cisr-type-text" id="cisr_center_wrap" style="text-align:center;margin:0 auto !important">
                                            <asp:TextBox ID="concentration" placeholder="Concentration *" ClientIDMode="Static" runat="server" Width="95%" />
                                        </div>
									</div>
									<div class="c33r" style="text-align:right;">
										<div class="type-select">
											<asp:DropDownList ID="units_menu" ClientIDMode="Static" runat="server" Width="95%" DataSourceID="dataUnits" DataTextField="cuUnit" DataValueField="cuUnit" AppendDataBoundItems="true">
												<asp:ListItem Text="Other" Value="Other" />
											</asp:DropDownList>
                                         </div>
									</div>
									<div style="clear:both"></div>
								</div>
								
								<div class="subcolumns">
									<div class="footer_item footer_checkout clear" id="add_component">
										ADD COMPONENT
									</div>
									<div style="clear:both"></div>
								</div>
								
								<div class="subcolumns">
									<table id="component_table" align="center" style="clear: both;">
                                        <thead>
                                            <tr>
                                                <th scope="col">Component</th>
                                                <th scope="col">Concentration</th>
                                                <th scope="col">Units</th>
                                                <th scope="col">Remove</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr id="first_row">
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                        </tbody>
                                    </table>
									
									<div style="clear:both"></div>
								</div>
								
								<div class="subcolumns">
									<div class="c33l">
										<div class="type-select">
											<asp:DropDownList ID="instrument_type" runat="server" Width="95%">
												<asp:ListItem Value="" disabled selected style='display:none;' Text="Instrument Type *" />
												<asp:ListItem Text="ICP" Value="ICP" />
												<asp:ListItem Text="ICP-MS" Value="ICP-MS" />
												<asp:ListItem Text="AA" Value="AA" />
												<asp:ListItem Text="GF-AA" Value="GF-AA" />
												<asp:ListItem Text="XRF" Value="XRF" />
												<asp:ListItem Text="Other" Value="Other" />
											</asp:DropDownList>
											<asp:RequiredFieldValidator ID="rfvinstrument_type" ControlToValidate="instrument_type" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
										</div>
										
										<div class="cisr-type-text" style="margin-top:18px;">
											<asp:TextBox ID="volume3" runat="server" Width="98%" placeholder="Volume *" />
											<asp:RequiredFieldValidator ID="rfvvolume3" ControlToValidate="volume3" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
										</div>
									</div>
									<div class="c33l">
										<div class="type-select" id="cisr_center_wrap" style="text-align:center;margin:0 auto">
											<asp:DropDownList ID="matrix3" runat="server" Width="95%" DataSourceID="dataMatrix" DataTextField="T542_Short" DataValueField="T542_Short" AppendDataBoundItems="true">
												<asp:ListItem Value="" disabled selected style='display:none;' Text="Matrix *" />
											</asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="rfvMatrix3" ControlToValidate="matrix3" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
                                        </div>
										
										<div class="cisr-type-text" id="cisr_center_wrap" style="margin:18px auto 0; text-align:center">
											<asp:TextBox ID="quantity" runat="server" Width="98%" placeholder="Quantity *"/>
											<asp:RequiredFieldValidator ID="rfvQuantity" ControlToValidate="quantity" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
										</div>
									</div>
									<div class="c33r">
										<div class="cisr-type-text" style="float:right">
											<asp:TextBox ID="comments" runat="server" Width="95%" TextMode="MultiLine" Rows="4" placeholder="Comments/Notes" />
										</div>
									</div>
									<div style="clear:both"></div>
								</div>
								<div class="subcolumns" id="cisr_checkbox_wrap">
									<asp:TextBox ID="components" runat="server" TextMode="MultiLine" ClientIDMode="Static" style="visibility:hidden;position:absolute;" />
									<div class="c20l">
										<asp:CheckBox ID="measured_values" Text=" Measured Values" runat="server" />&nbsp;&nbsp;&nbsp;
									</div>
                                    <div class="c20l">
										<asp:CheckBox ID="impurities" Text=" Impurities" runat="server" />&nbsp;&nbsp;&nbsp;
									</div>
                                    <div class="c20l"> 
										<asp:CheckBox ID="density_reported" Text=" Density Reported" runat="server" />&nbsp;&nbsp;&nbsp;
									</div>
									<div class="c40l">
										<span>(These options incurr an additional charge)</span>      
									</div>
								</div>
								<div class="subcolumns" style="text-align:right;">
									
									<asp:Button ID="cmdSubmit" Text="SUBMIT" runat="server" ClientIDMode="Static" CssClass="submitbutton" onclick="cmdSubmit_Click" ValidationGroup="vgNew" />
									<div class="required_div">* Required</div>
                                </div>
							</asp:View>
                            <asp:View ID="vwThank" runat="server">
                                <h2>Thank You</h2>
                                <p>Your Custom Standards Request has been sent and a Sales Support Specialist will be contacting you shortly.</p>
                            </asp:View>
                        </asp:MultiView>
					</div>
				</div>
			</div>
			<div id="organicRqForm" class="prodForms">
				<div id="cisr_headerlabel" class="headerlabel">
            		<span class="label-left">
            			<h1 class="title">Custom Organic Standards Request Form</h1>
            		</span>
            	</div>
				<div id="cisr_gencontent_full">
					<div id="cisrForm">
						<asp:MultiView ID="mvForm2" runat="server" ActiveViewIndex="0">
                            <asp:View ID="vwForm2" runat="server">
								<p>SPEX CertiPrep can customize any Standard to meet your specific needs. Enter the Component or CAS#. Next, enter the Concentration.</p>
								<div style="display: block;margin: 0.5em 0;padding: 3px 0.5em;position: relative;">
                                    <input type="radio" name="SearchBy" value="CAS" checked="checked" /> Search by CAS &nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="radio" name="SearchBy" value="Component" /> Search by Component Name
                                </div>
								<div class="subcolumns">
									<div class="c33l">
										<div id="pnlComponent" style="display:none;">
                                            <div class="subcl type-select">
												<div class="selectbgCAS">
													<div class="IEmagicCAS">
														<asp:DropDownList ID="component2" ClientIDMode="Static" runat="server" DataSourceID="dataComponents2" style="width:95%;" DataTextField="CompCAS" DataValueField="cmpComp" AppendDataBoundItems="true">
															<asp:ListItem Value="0" disabled selected style='display:none;' Text="Component *" />
														</asp:DropDownList>
													</div>
												</div>
                                            </div>
                                        </div>
                                        <div id="pnlCAS">
                                            <div class="subcl type-select">
												<div class="selectbgCAS">
													<div class="IEmagicCAS">
														<asp:DropDownList ID="CASNumber2" ClientIDMode="Static" runat="server" DataSourceID="dataCAS" style="width:95%;" DataTextField="CompCAS" DataValueField="cmpCAS" AppendDataBoundItems="true">
															<asp:ListItem Value="0" disabled selected style='display:none;' Text="CAS Number *" />
														</asp:DropDownList>
													</div>
												</div>
                                            </div>
                                        </div>
									</div>
									<div class="c33l">
										<div class="cisr-type-text" id="cisr_center_wrap" style="text-align:center;margin:0 auto !important">
                                            <asp:TextBox ID="concentration2" placeholder="Concentration *" ClientIDMode="Static" runat="server" Width="95%" />
                                        </div>
									</div>
									<div class="c33r" style="text-align:right;">
										<div class="type-select">
											<div class="selectbgCusOrg ieUnits">
												<div class="IEmagicCusOrg">
													<asp:DropDownList ID="units_menu2" ClientIDMode="Static" runat="server" Width="95%" DataSourceID="dataUnits" DataTextField="cuUnit" DataValueField="cuUnit" AppendDataBoundItems="true">
														<asp:ListItem Text="Units" Value="" disabled selected style="display:none;"/>
													</asp:DropDownList>
												</div>
											</div>
                                        </div>
										<div style="text-align:center">
											or
										</div>
										<div class="cisr-type-text ieOthers" style="float:right">
											<asp:TextBox ID="other" ClientIDMode="Static" runat="server" Width="98%" placeholder="Other" />
										</div>
									</div>
									<div style="clear:both"></div>
								</div>
								
								<div class="subcolumns" style="text-align:right">
									<div class="footer_item footer_checkout clear" id="add_component2">
										ADD COMPONENT
									</div>
									<div style="clear:both"></div>
								</div>
								
								<div class="subcolumns">
									<table id="component_table_org" align="center" style="clear: both;">
                                        <thead>
                                            <tr>
                                                <th scope="col">Component</th>
												<th scope="col" class="organic">CAS Number</th>
                                                <th scope="col">Concentration</th>
                                                <th scope="col">Units</th>
                                                <th scope="col">Remove</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr id="first_row2">
                                                <td>&nbsp;</td>
												<td class="desc organic">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                        </tbody>
                                    </table>
									<asp:TextBox ID="components2" runat="server" TextMode="MultiLine" ClientIDMode="Static" style="visibility:hidden;position:absolute;" />
									<div style="clear:both"></div>
								</div>
								
								<div class="subcolumns">
									<div class="c33l">
										<div class="type-select">
											<div class="selectbgCusOrg">
												<div class="IEmagicCusOrg">
													<asp:DropDownList ID="instrument_type2" runat="server" Width="95%">
														<asp:ListItem Value="" disabled selected style='display:none;' Text="Instrument Type *" />
														<asp:ListItem Text="ICP" Value="ICP" />
														<asp:ListItem Text="ICP-MS" Value="ICP-MS" />
														<asp:ListItem Text="AA" Value="AA" />
														<asp:ListItem Text="GF-AA" Value="GF-AA" />
														<asp:ListItem Text="XRF" Value="XRF" />
														<asp:ListItem Text="Other" Value="Other" />
													</asp:DropDownList>
												</div>
											</div>
											<asp:RequiredFieldValidator ID="rfvinstrument_type2" ControlToValidate="instrument_type2" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew2" style="display:block" />
										</div>
										
										<div class="cisr-type-text ievolume" style="margin-top:18px;">
											<asp:TextBox ID="volume2" runat="server" Width="98%" placeholder="Volume *" />
											<asp:RequiredFieldValidator ID="rfvvolume2" ControlToValidate="volume2" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew2" style="display:block" />
											<div style="font-size:14px;margin-top:5px;">Volume of 1mL requires minimum quantity of 5</div>
										</div>
									</div>
									<div class="c33l">
										<div class="type-select" id="cisr_center_wrap" style="text-align:center;margin:0 auto">
											<div class="selectbgCusOrg ieMatrix">
												<div class="IEmagicCusOrg">
													<asp:DropDownList ID="matrix2" runat="server" Width="95%" DataSourceID="dataMatrix" DataTextField="T542_Short" DataValueField="T542_Short" AppendDataBoundItems="true">
														<asp:ListItem Value="" disabled selected style='display:none;' Text="Matrix *" />
													</asp:DropDownList>
												</div>
											</div>
                                            <asp:RequiredFieldValidator ID="rfvMatrix2" ControlToValidate="matrix2" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew2" style="display:block" />
                                        </div>
										
										<div class="cisr-type-text" id="cisr_center_wrap" style="margin:18px auto 0; text-align:center">
											<asp:TextBox ID="quantity2" runat="server" Width="98%" placeholder="Quantity *"/>
											<asp:RequiredFieldValidator ID="rfvQuantity2" ControlToValidate="quantity2" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew2" style="display:block" />
										</div>
									</div>
									<div class="c33r">
										<div class="cisr-type-text" style="float:right">
											<asp:TextBox ID="comments2" runat="server" Width="95%" TextMode="MultiLine" Rows="4" placeholder="Comments/Notes" />
										</div>
									</div>
									<div style="clear:both"></div>
								</div>
								<div class="subcolumns" style="text-align:right;">
									<asp:Button ID="cmdSubmit2" Text="SUBMIT" runat="server" ClientIDMode="Static" CssClass="submitbutton" onclick="cmdSubmit2_Click" ValidationGroup="vgNew2" />
									<div class="required_div">* Required</div>
                                </div>
							</asp:View>
                            <asp:View ID="vwThank2" runat="server">
                                <h2>Thank You</h2>
                                <p>Your Custom Standards Request has been sent and a Sales Support Specialist will be contacting you shortly.</p>
                            </asp:View>
                        </asp:MultiView>
					</div>
				</div>
			</div>
			 <table width="958" class="tablesorter cc" align="center" >
                <thead>
                    <tr>
                        <th scope="col" id="partnumber" class="header">Specifications</th>
                        <th scope="col" id="itype" onclick="doSort('itype')" class="header sorter">Instrument Type</th>
						<th scope="col" id="matrix" onclick="doSort('matrix')" class="header sorter">Matrix</th>
						<th scope="col" id="volume" onclick="doSort('volume')" class="">Volume</th>
						<th scope="col" id="qty" onclick="doSort('qty')" class="header sorter">Qty.</th>
                        <th scope="col" id="date" onclick="doSort('date')" class="header sorter">Date Submitted</th>
                        <th scope="col" id="stats" onclick="doSort('stats')" class="">Status</th>
                        <th scope="col" id="ptype" onclick="doSort('ptype')" style="border-right:1px solid;">&nbsp;</th>
                    </tr>
                </thead>
                <tbody>
					<tr>
						<asp:ListView ID="lvCustomOrders" runat="server" DataSourceID="dataCustomOrders">
							<LayoutTemplate>
								<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
							</LayoutTemplate>
							<ItemTemplate>
								<tr>
									<td><%#Eval("specification").ToString().Trim() %></td>
									<td><%#Eval("instrument_type").ToString().Trim() %></td>
									<td><%#Eval("matrix").ToString().Trim() %></td>
									<td><%#Eval("volume").ToString().Trim() %></td>
									<td style="text-align:center"><%#Eval("quantity").ToString().Trim() %></td>
									<td><%# string.Format("{0:MM/dd/yyyy}", Eval("datesubmitted"))%></td>
									<td><%#Eval("stats").ToString().Trim() %></td>
									<td><%#(Eval("prod_type").ToString() == "1") ? "Organic" : "Inorganic"%></td>
								</tr>
							</ItemTemplate>
							<EmptyDataTemplate>
								
							</EmptyDataTemplate>
						</asp:ListView> 
					</tr>
                </tbody>
            </table>
		</div>
		
		<div id="blanket_orders" class="tab" style="margin:2em 0 6em; display:none"> 
			<table width="958" class="tablesorter cc" align="center" >
                <thead>
                    <tr>
                        <th scope="col" id="partnumber" onclick="doSort('partnumber')" class="header sorter">Part #</th>
                        <th scope="col" id="title" onclick="doSort('title')" class="header sorter">Lot #</th>
                        <th scope="col" id="matrix" onclick="doSort('matrix')" class="header sorter">Date Ordered</th>
                        <th scope="col" id="volume" onclick="doSort('volume')" class="">Certificate</th>
                        <th scope="col">SDS</th>
                        <th scope="col" id="price" onclick="doSort('price')" style="border-right:1px solid;">&nbsp;</th>
                    </tr>
                </thead>
                <tbody>
					<tr>
						<td colspan="7" style="text-align:center">There are no records found.</td>
					</tr>
                </tbody>
            </table>
		</div>
		
		<div id="quotes" class="tab" style="margin:2em 0 6em; display:none"> 
			There are no records found.
		</div>
		
		<a class='viewOrder' href="#viewOrderBox" style="display:none">Show Order</div>
		<div style="display:none">
			<div id="viewOrderBox">
				
			</div>
		</div>
    </div>
	</div>
	
	<asp:SqlDataSource ID='dataCustomOrders' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>" SelectCommandType="Text">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataCategory' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT DISTINCT ccID, ccCategory FROM cp_roi_Cats WHERE ccFamilyID = @Family ORDER BY ccCategory" SelectCommandType="Text">
        <SelectParameters>
            <asp:QueryStringParameter Name="Family" Type="Int32" DefaultValue="1" QueryStringField="cat" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataProducts' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommandType="Text" onselected="dataProducts_Selected">
    </asp:SqlDataSource>
	<asp:SqlDataSource ID='dataFreqOrders' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommandType="Text" onselected="dataFreqOrders_Selected">
    </asp:SqlDataSource>	
	<asp:SqlDataSource ID='dataFreqOrders2' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommandType="Text" onselected="dataFreqOrders2_Selected">
    </asp:SqlDataSource>
	
	<asp:SqlDataSource ID='dataComponents' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT caNameWeb FROM certiAnalytes ORDER BY caNameWeb" SelectCommandType="Text">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataUnits' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT cuUnit FROM certiUnits ORDER BY cuUnit" SelectCommandType="Text">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='dataMatrix' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT DISTINCT T542_Short from cp_roi_Matrix ORDER BY T542_Short" SelectCommandType="Text">
    </asp:SqlDataSource>
	<asp:SqlDataSource ID='dataCAS' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT cmpCAS, cmpCAS + ' (' + cmpComp + ')' AS CompCAS FROM certiComps WHERE cmpCAS IS NOT NULL AND cmpCAS <> '' AND cmpCAS <> 'MULTIPLE' AND cmpCAS <> 'N/A' AND cmpCAS <> 'NA' AND cmpCAS <> 'NONE' AND cmpCAS <> 'NOTNEEDED' AND cmpCAS <> 'UNKNOWN' ORDER BY cmpCAS" SelectCommandType="Text">
    </asp:SqlDataSource>
	<asp:SqlDataSource ID='dataComponents2' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="SELECT cmpComp, cmpCAS, cmpComp + ' (CAS: ' + ISNULL(cmpCAS, 'No CAS') + ')' AS CompCAS FROM certiComps ORDER BY cmpComp" SelectCommandType="Text">
    </asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script src="/js/jquery-ui.js" type="text/javascript"></script>
	<script src="/js/jquery.tablesorter.min.js" type="text/javascript"></script>	
    <script type="text/javascript">
        $(document).ready(function () {
			$(".tablesorter tr:odd").addClass("odd");
			
			$(".reorder").click(function() {
				var prodID = $(this).attr('name');
				buyIt(prodID);
			});
			$(".noprod").click(function() {
				var prodID = $(this).attr('name');
				alert("Product " + prodID + " is no longer available.");
			});
			
			$(".viewOrder").fancybox();
			
			$(".viewOrderBtn").click(function(){
				var part = $(this).attr('data-so');
				location.replace("/customer-center/order-summary/default.aspx?id=" +part);
			});
			
			$(".tabselector").click(function(){
				var id = $(this).data("id");
				$(".tab").fadeOut("fast");
				$("#" + id).fadeIn("slow");
				$(".tabselector").each(function() {
					$(this).removeClass("selected");
				});
				$(this).addClass("selected");
			});
			
			$(".order-tabselector").click(function(){
				$(".prodForms").fadeOut("fast");
				if ($(this).hasClass("selected")) {
					$(".order-tabselector").each(function() { $(this).removeClass("selected");});
				}else {
					var id = $(this).data("id");
					$("#" + id).fadeIn("slow");
					$(".order-tabselector").each(function() { $(this).removeClass("selected");});
					$(this).addClass("selected");
				}
			});
			
			$('#freq-orders').DataTable( {
				"ordering": 	false,
				"info":     	false,
				"searching": 	false,
				"pageLength":	5,
				"lengthChange":	false,
				"processing":	true,
				language: {
					paginate: {
						first:    '<<',
						previous: '<',
						next:     '>',
						last:     '>>'
					},
					aria: {
						paginate: {
							first:    'First',
							previous: 'Previous',
							next:     'Next',
							last:     'Last'
						}
					}
				}
			} );
			
			$('#curr-orders').DataTable( {
				"ordering": 	false,
				"info":     	false,
				"searching": 	false,
				"pageLength":	25,
				"lengthChange":	false,
				"processing":	true,
				language: {
					paginate: {
						first:    '<<',
						previous: '<',
						next:     '>',
						last:     '>>'
					},
					aria: {
						paginate: {
							first:    'First',
							previous: 'Previous',
							next:     'Next',
							last:     'Last'
						}
					}
				}
			});
        });
        function buyIt(productid) {
            theQuantity = 1;
            if(theQuantity == '' || theQuantity == '0' ) {
            	alert('Quantity must be greater than 0');
            	return false;
            }
            $("#footer_cart").load("/utility/addtocart.aspx?productid=" + productid + "&pq=" + theQuantity, function () {
                //$("#totalitems").effect("highlight", { color: "#ffffff" }, 5000);
                $("#totalcost").effect("highlight", { color: "#ffffff" }, 5000);
                $("#totalsavings").effect("highlight", { color: "#ffffff" }, 5000);
                $("#SPoints").effect("highlight", { color: "#ffffff" }, 5000);
            });
			setTimeout(function(){itemAddShow();},500);
        }
		function buyIt2(productid) {
            theQuantity = document.getElementById("quantity_" + productid).value;
            if(theQuantity == '' || theQuantity == '0' ) {
            	alert('Quantity must be greater than 0');
            	return false;
            }
            $("#footer_cart").load("/utility/addtocart.aspx?productid=" + productid + "&pq=" + theQuantity, function () {
                //$("#totalitems").effect("highlight", { color: "#ffffff" }, 5000);
                $("#totalcost").effect("highlight", { color: "#ffffff" }, 5000);
                $("#totalsavings").effect("highlight", { color: "#ffffff" }, 5000);
                $("#SPoints").effect("highlight", { color: "#ffffff" }, 5000);
            });
            $("#buy_" + productid).removeClass("search_buy");
            $("#buy_" + productid).addClass("search_buy_clicked");
            setTimeout(function(){itemAddShow();},500);
        }
		$(document).ready(function(){ 
			$(".tablesorter").tablesorter({
				headers: {
					3: {sorter: false}, 
					4: {sorter: false}, 
					5: {sorter: false}, 
					6: {sorter: false}, 
					7: {sorter: false}
				}
			});	
		}); 		
		
		function itemAddShow() {
			$('.float-footer').addClass("mobshow");
			$(".itemAddBox").fadeIn("slow");
			setTimeout(function() {
				$(".itemAddBox").fadeOut("slow");
			}, 4000);
		}
		
		var first_row = "not filled";
        var component_counter = 0;

        $("input[name='SearchBy']").click(function () {
            if ($("input[name='SearchBy']:checked").val() == "CAS") {
                $("#pnlComponent").hide();
                $("#pnlCAS").show();
                $("#component2").val("");
            } else if ($("input[name='SearchBy']:checked").val() == "Component") {
                $("#pnlComponent").show();
                $("#pnlCAS").hide();
                $("#CASNumber2").val("");
            }
        });

        $("select#units2").change(function () {
            //if other selected - show textbox
            val = $("select#units").val();
            if (val == "Other") {
                $("#units_input").html("<label for=\"units\" class=\"100wide block\" style=\"width: 50px;\">Other: </label><input type=\"text\" name=\"units\" id=\"units\" class=\"input_50wide_block\">");
            }
        });

        $('#add_component2').click(function () {
            error = "";
            component = $('#component2').val();
            CASNumber = $('#CASNumber2').val();
            if (component == '' && CASNumber == '') {
                error += "Component / CAS number is missing. ";
            }
			alert("componet: '" +component +"'" + "cas: '" + CASNumber +"'");
            if (component) {
                compText = $("#component2 option:selected").text();
                CASNumber = compText.substring(compText.indexOf('CAS: ') + 5);
                CASNumber = CASNumber.substring(0, CASNumber.length - 1);
            } else {
                casText = $("#CASNumber2 option:selected").text();
                component = casText.substring(casText.indexOf('(') + 1);
                component = component.substring(0, component.length - 1);
            }

            concentration = $('#concentration2').val();
            if (concentration == '') {
            	error += "Concentration is missing. ";
            }

            var units = $('#units_menu2').val();
            other = $('#other').val();
            if (units == '' || units == "Units") {
                if (other == '') {
                	error += "Units are missing. ";
                } else {
                    units = other;
                }
            }

			if ($('#component_table_org').text().indexOf(CASNumber) != -1) {
			    if (CASNumber != '')
					error = "Duplicate CAS Number: " + CASNumber + " has already been added.";
			}

            if (error != "") {
                alert(error);
            } else {
				$('#CASNumber2').val('');

                if (first_row == "not filled") {
                    //if first_row not filled, insert into first row		
                    first_row = "filled";
                    component_counter = component_counter + 1;
                    $("#first_row2").html("<td>" + component + "</td><td>" + CASNumber + "</td><td>" + concentration + "</td><td>" + units + "</td><td><img src=\"/images/remove_button.gif\" width=\"27\" height=\"27\" alt=\"Remove Item\" class=\"removeicon\"></td>");
                    $('textarea#components2').text("Component#" + component_counter + " = " + component + " CASNumber = " + CASNumber + " Concentration = " + concentration + units);
					
                } else {
                    //if first_row is already filled, just append	
                    $('<tr><td>' + component + '</td><td>' + CASNumber + '</td><td>' + concentration + '</td><td>' + units + '</td><td><img src=\"/images/remove_button.gif\" width=\"27\" height=\"27\" alt=\"Remove Item\" class=\"removeicon\"></td></tr>').appendTo("#component_table_org > tbody:last").show('slow');
                    component_counter = component_counter + 1;
                    $('textarea#components2').append("\nComponent#" + component_counter + " = " + component + " CASNumber = " + CASNumber + " Concentration = " + concentration + units);
                    $("#component_table_org tr:odd").addClass("oddtablerow"); //make odd table rows grey reach time after new row is added or deleted
                }
            }
        });

        $('#cmdSubmit2').click(function (event) {
        	if (first_row == "not filled") {
        		alert("Please select a component.");
        		event.preventDefault();
        	}
        });


		$('table#component_table_org td img.removeicon').live('click', function () {
            $(this).parent().parent().remove();
            $("#component_table_org tr:odd").addClass("oddtablerow"); //make odd table rows grey reach time after new row is added or deleted
        });
		
		$('table#component_table_org td img.removeicon2').live('click', function () {
            $(this).parent().parent().parent().remove();
        });
		
		var first_row2 = "not filled";
		var component_counter2 = 0;

        $('#add_component').click(function () {
            error = "";
            component = $('#component').val();
            if (component == '') {
            	error += "Component is missing.\n";
            }
            concentration = $('#concentration').val();
            if (concentration == '') {
            	error += "Concentration is missing.\n";
            }
            var units = $('#units_menu').val();
            other = $('#other').val();
            if (units == '' || units == 'Other') {
                if (other == '') {
                	error += "Units are missing.";
                } else {
                    units = other;
                }
            }
            $("#component_table tr").each(function () {
            	if ($(this).find(".comp").html() == component) {
            		error = "Duplicate Compound: " + component + " has already been added.";
            	}
            });

            if (error != "") {
                alert(error);
            } else {
                if (first_row2 == "not filled") { 
                    first_row2 = "filled";
                    component_counter2 = component_counter2 + 1;

                    $("#first_row").html("<td class='comp'>" + component + "</td><td>" + concentration + "</td><td>" + units + "</td><td><img src=\"/images/remove_button.gif\" width=\"27\" height=\"27\" alt=\"Remove Item\" class=\"removeicon\"></td>");
                    $('#components').text("Component #" + component_counter2 + " = " + component + " Concentration = " + concentration + units);
                } else { 
                    //if first_row is already filled, just append	
                    component_counter2 = component_counter2 + 1;

                    $('<tr><td>' + component + '</td><td>' + concentration + '</td><td>' + units + '</td><td><img src=\"/images/remove_button.gif\" width=\"27\" height=\"27\" alt=\"Remove Item\" class=\"removeicon\"></td></tr>').appendTo("#component_table > tbody:last").show('slow');
                    $('#components').append("\nComponent #" + component_counter2 + " = " + component + " Concentration = " + concentration + units);
                    $("#component_table tr:odd").addClass("oddtablerow"); //make odd table rows grey reach time after new row is added or deleted
                }
            }
        });

        $('#cmdSubmit').click(function (event) {
        	if (first_row2 == "not filled") {
        		alert("Please select a component.");
        		event.preventDefault();
        	}
        });

        $('table#component_table td img.removeicon').live('click', function () {
            $(this).parent().parent().remove();
            $("#component_table tr:odd").addClass("oddtablerow"); //make odd table rows grey reach time after new row is added or deleted
        });

		$('table#component_table td img.removeicon2').live('click', function () {
            $(this).parent().parent().parent().remove();
        });
		
        $('#units_menu').change(function () {
        	if ($('#units_menu').val() == 'Other') {
        		$('#other').show();
        	} else {
        		$('#other').hide();
			}
		});
    </script>
</asp:Content>

