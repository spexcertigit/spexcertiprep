<%@ Page Title="SPEX CertiPrep - About Us - Distributors" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="distributors.aspx.cs" Inherits="purchase_distributors" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
<script src="/js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="/js/jquery-ui.js" type="text/javascript"></script>
<style>
	#distributors {
		z-index:0;
	}
	#map-canvas {
		z-index:1;
	}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/default.aspx">Home</a> > About Us > Distributors</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
    <div id="mainHeader">
        <asp:Literal ID="ltrHeadline" runat="server" />
        <h1 style="margin:0px;padding:0px">Distributors</h1>
    </div>
    <div id="main">
        <div id="col1">
            <div id="col1_content" class="clearfix">
				<div class="select-wrap" style="float:none;">
					<asp:DropDownList id="country" runat="server" AutoPostBack="true" DataSourceID="dataCountries" DataTextField="Country" DataValueField="CountryId" AppendDataBoundItems="true" OnSelectedIndexChanged="UpdateUrlBasedOnCountry" OnDataBound="OnCountriesDDLDataBound">
						<asp:ListItem Value="" Text="Select Country" disabled selected style="display:none;"/>
					</asp:DropDownList>
				</div>
				<uc1:ShareThis ID="ShareThis1" runat="server" />
            </div>
        </div>
        <div id="col3">
            <div id="col3_content" class="clearfix">
                <div id="distributors">
					<h2>SPEX CertiPrep Distributors</h2>
					<script>
						$(function(){
							var maxHeight = 0;
							$(".floatersBox").each(function(){	
								if ($(this).height() > maxHeight) { maxHeight = $(this).height(); }
							});
							$(".floatersBox").each(function(){
								$(this).height(maxHeight);
							});
						});
					</script>
					<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
					<script src="gmaps.js"></script>
					<script>
						var str = '<%= Request.QueryString["country"] %>';
						var ccountry = new Array();
						var infoWindowContent = [];	
						function addmarker(map,country,ctryDetails){
							for(var i=0;i < country.length;i++){
								if(country[i][0].toLowerCase() == str.toLowerCase()){
									if (country[i][1] != "" && country[i][2] != ""){
										infoWindowContent[i] = getInfoWindowDetails(i, country, ctryDetails);
										var image = '/images/google_marker.png';
										var myLatlng = new google.maps.LatLng(country[i][1],country[i][2]);
										// infoWindow
										var infowindow = new google.maps.InfoWindow({
										});
													
										var marker = new google.maps.Marker({
											position: myLatlng,
											map: map,
											icon: image,
											title: country[i][3]
										});
																	
										google.maps.event.addListener(marker, 'click',(function(marker, i) {
											return function(){
												infowindow.setContent(infoWindowContent[i]);
												infowindow.open(map,marker);
											}
										})(marker, i));
									}
								}
							}
						}
						function getInfoWindowDetails(details, country, ctryDetails) {
							$('#ctry').val(country[details][0]);
							$('#cmpy').val(country[details][3]);
							var contentString = '<div style="min-height:150px;min-width:200px;height:auto;width:auto" class="info-window">' +
													'<div style="font-weight:bold">'+ ctryDetails[details][9] +'</div>' +
														'<div>'+ ctryDetails[details][0] + '</div>' +
														'<div>'+ ctryDetails[details][1] +'</div>' +
														'<div style="color:#F7941E;text-decoration:underline">'+ ctryDetails[details][2] +'</div>' +
														'<div style="color:#F7941E;text-decoration:underline">'+ ctryDetails[details][3] +'</div>' +
														'<div>'+ ctryDetails[details][4] +'</div>' +
														'<div>'+ ctryDetails[details][5] +'</div>' +
														'<div>'+ ctryDetails[details][6] +'</div>' +
														'<div>'+ ctryDetails[details][7] +'</div>' +
													'</div>';
							return contentString;
						}
									
						function initialize() {
							var x=0;
							var y=0;
							<asp:ListView ID="lvCountry1" DataSourceID="dataCountryDetails" runat="server">
								<LayoutTemplate><asp:PlaceHolder runat="server" ID="itemPlaceHolder" /></LayoutTemplate>
								<ItemTemplate>
								ccountry['<%# Eval("Country").ToString().ToLower() %>'] = ["<%# Eval("Latitude") %>", "<%# Eval("Longitude") %>", "<%# Eval("Company") %>", <%# Eval("ZoomLevel")%>];
								</ItemTemplate>
								<EmptyDataTemplate></EmptyDataTemplate>
							</asp:ListView>
							
							var country = [<asp:ListView ID="lvCtryDetails" DataSourceID="dataCountryDetails" runat="server"><LayoutTemplate><asp:PlaceHolder runat="server" ID="itemPlaceHolder" /></LayoutTemplate><ItemTemplate>
							["<%# Eval("Country") %>", "<%# Eval("Latitude") %>", "<%# Eval("Longitude") %>", "<%# Eval("Company") %>", "<%# Eval("Phone") %>", "<%# Eval("Fax") %>", "<%# Eval("Email") %>", "<%# Eval("Site") %>", "<%# Eval("Address1") %>", "<%# Eval("Address2") %>", "<%# Eval("Address3") %>", "<%# Eval("Address4") %>"],</ItemTemplate><EmptyDataTemplate></EmptyDataTemplate></asp:ListView>
							];
																				
							var ctryDetails = [<asp:ListView ID="lvCtryDetails2" DataSourceID="dataCountryDetails" runat="server"><LayoutTemplate><asp:PlaceHolder runat="server" ID="itemPlaceHolder" /></LayoutTemplate><ItemTemplate>["<%# Eval("Phone") %>", "<%# Eval("Fax") %>", "<%# Eval("Email") %>","<%# Eval("Site") %>", "<%# Eval("Address1") %>", "<%# Eval("Address2") %>", "<%# Eval("Address3") %>","<%# Eval("Address4") %>", "<%# Eval("Country")%>", "<%# Eval("Company")%>"],</ItemTemplate><EmptyDataTemplate></EmptyDataTemplate></asp:ListView>];

							var myLatlng = new google.maps.LatLng(ccountry[str][0],ccountry[str][1]);
							var mapOptions = {
								zoom: ccountry[str][3], 
								center: myLatlng
							}
							var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
								addmarker(map,country, ctryDetails);  
							}
							google.maps.event.addDomListener(window, 'load', initialize);
										
						</script>
						<%
							if (!string.IsNullOrEmpty(Request.QueryString["country"]))
							{ %>
								<div id="map-canvas" style="width:665px;height:300px"></div>
						<%	} %>
											 
                        <h2 style="margin-top:18px;"><asp:Label ID="countryLabel" runat="server" text=""></asp:Label></h2>
						<asp:ListView ID="lvItems" DataSourceID="dataItems" runat="server">
							<LayoutTemplate>
								<asp:PlaceHolder runat="server" ID="itemPlaceHolder" />
							</LayoutTemplate>
							<ItemTemplate>
								<div class="floatersBox">
									<div class="disAdd" style="font-weight:bold"><%# Eval("Company") %></div>
									<div><%# Eval("Phone") %></div>
									<div><%# Eval("Fax").ToString().Length > 0 ? Eval("Fax").ToString() + " (fax)" : "" %></div>
									<div><%# Eval("Email").ToString().Length > 0 ? "<a href='mailto:" + Eval("Email").ToString() + "'>" + Eval("Email").ToString() + "</a>" : "" %></div>
									<div><%# Eval("Site").ToString().Length > 0 ? "<a href='" + Eval("Site").ToString() + "' target='_blank'>" + Eval("Site").ToString() + "</a>" : "" %></div>
									<div><%# Eval("Address1") %></div>
									<div><%# Eval("Address2") %></div>
									<div><%# Eval("Address3") %></div>
									<div><%# Eval("Address4") %></div>	
									<div style="margin-bottom:15px;"></div>
								</div>
							</ItemTemplate>
							<EmptyDataTemplate>
								<script>
									var country = new Array();
									
									<asp:ListView ID="lvCountry2" DataSourceID="dataCountryDetails" runat="server">
										<LayoutTemplate><asp:PlaceHolder runat="server" ID="itemPlaceHolder" /></LayoutTemplate>
										<ItemTemplate>
										country['<%# Eval("Country")%><%# Eval("DistributorSerial")%>'] = ["<%# Eval("Latitude") %>", "<%# Eval("Longitude") %>", "<%# Eval("Company") %>", "<%# Eval("Phone") %>", "<%# Eval("Fax") %>", "<%# Eval("Email") %>", "<%# Eval("Site") %>", "<%# Eval("Address1") %>", "<%# Eval("Address2") %>", "<%# Eval("Address3") %>", "<%# Eval("Address4") %>", "<%# Eval("Country")%>"];
										</ItemTemplate>
										<EmptyDataTemplate></EmptyDataTemplate>
									</asp:ListView>
									
									jQuery(document).ready(function(){
										var map;
												
										map = new GMaps({
									      	div: '#googleMap',
											lat: 17.862025,
											lng: 31.720393,
											zoom: 2,
											minZoom: 2
											//draggable: false
									    });
												  
										//////
										var allowedBounds = new google.maps.LatLngBounds(
										//	 new google.maps.LatLng(-59.950415, -179.568671), 
										//	 new google.maps.LatLng(73.692187, 179.025082)
											new google.maps.LatLng(28.70, -127.50), 
											new google.maps.LatLng(48.85, -55.90)
										);

										// Listen for the dragend event
										//alert("moved1");
										google.maps.event.addListener(map, 'dragend', function() {
											alert("moved2");
											if (allowedBounds.contains(map.getCenter())) return;

											// Out of bounds - Move the map back within the bounds
											var c = map.getCenter(),
												x = c.lng(),
												y = c.lat(),
												maxX = allowedBounds.getNorthEast().lng(),
												maxY = allowedBounds.getNorthEast().lat(),
												minX = allowedBounds.getSouthWest().lng(),
												minY = allowedBounds.getSouthWest().lat();

											if (x < minX) x = minX;
											if (x > maxX) x = maxX;
											if (y < minY) y = minY;
											if (y > maxY) y = maxY;
													
											map.setCenter(new google.maps.LatLng(y, x));
										});
										//////
										function getInfoWindowDetails2(details, country, ctryDetails2, key) {
											var contentString = '<div style="min-height:150px;min-width:200px;height:auto;width:auto" class="info-window">' +
																	'<div style="font-weight:bold">'+ ctryDetails2[details][9] +'</div>' +
																	'<div>'+ ctryDetails2[details][0] + '</div>' +
																	'<div>'+ ctryDetails2[details][1] +'</div>' +
																	'<div style="color:#a3b405;text-decoration:underline">'+ ctryDetails2[details][2] +'</div>' +
																	'<div style="color:#a3b405;text-decoration:underline">'+ ctryDetails2[details][3] +'</div>' +
																	'<div>'+ ctryDetails2[details][4] +'</div>' +
																	'<div>'+ ctryDetails2[details][5] +'</div>' +
																	'<div>'+ ctryDetails2[details][6] +'</div>' +
																	'<div>'+ ctryDetails2[details][7] +'</div>' +
																'</div>';
											return contentString;
										}
										function getCountryName(num) {
											return ctryDetails2[num][8];
										}
										counter = 0;
									    for (var key in country) {
											var x = country[key][0];
											var y = country[key][1];
											// console.log(country[key][0]);

											map.addMarker({
											    lat: x,
										        lng: y,
										        title: getCountryName(counter),
												icon: "/images/google_marker.png",
												infoWindow: {
										        	content: getInfoWindowDetails2(counter, country, ctryDetails2, key)
										        }
											});
											//console.log(key + getInfoWindowDetails2(counter, country, ctryDetails2, key) + "---------" + counter);
											counter++;
										}
									});
									var ctryDetails2 = [<asp:ListView ID="lvCtryDetails2" DataSourceID="dataCountryDetails" runat="server"><LayoutTemplate><asp:PlaceHolder runat="server" ID="itemPlaceHolder" /></LayoutTemplate><ItemTemplate>["<%# Eval("Phone") %>", "<%# Eval("Fax") %>", "<%# Eval("Email") %>","<%# Eval("Site") %>", "<%# Eval("Address1") %>", "<%# Eval("Address2") %>", "<%# Eval("Address3") %>","<%# Eval("Address4") %>", "<%# Eval("Country")%>", "<%# Eval("Company")%>"],</ItemTemplate><EmptyDataTemplate></EmptyDataTemplate></asp:ListView>];

								</script>
								<!--width:535-->
								<div id="googleMap" style="width:830px;height:390px;"></div>

								<p>SPEX CertiPrep has a worldwide network of distributors. Select your country to the left to  find a dealer near you. Can&#8217;t  find a dealer in your country? Or are  you interested in distributing SPEX CertiPrep products? Contact us at <a href="mailto:crmsales@spexcsp.com">crmsales@spexcsp.com</a>.</p>
							</EmptyDataTemplate>
						</asp:ListView>
                    </div>
                </div>
                <div id="ie_clearing"> &#160; </div>
            </div>
        </div>
		<asp:SqlDataSource ID='dataCountries' runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" ProviderName="<%$ ConnectionStrings:ApplicationServices.ProviderName %>"
		    SelectCommand="SELECT DISTINCT LOWER(Country) AS CountryId, Country FROM certiDistributor WHERE (Latitude IS NOT NULL AND Latitude != '') AND (Longitude IS NOT NULL AND Longitude != '') ORDER BY Country" SelectCommandType="Text">
		</asp:SqlDataSource>
		<asp:SqlDataSource ID='dataCountryDetails' runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" ProviderName="<%$ ConnectionStrings:ApplicationServices.ProviderName %>"
		    SelectCommand="SELECT * FROM certiDistributor WHERE (Latitude IS NOT NULL AND Latitude != '') AND (Longitude IS NOT NULL AND Longitude != '') ORDER BY SortOrder DESC" SelectCommandType="Text">
		</asp:SqlDataSource>
		<asp:SqlDataSource ID='dataItems' runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" ProviderName="<%$ ConnectionStrings:ApplicationServices.ProviderName %>"
		    SelectCommand="SELECT * FROM certiDistributor WHERE Country = @Country ORDER BY SortOrder, Company" SelectCommandType="Text" CancelSelectOnNullParameter="true">
			<SelectParameters>
				<asp:ControlParameter Name="Country" ControlID="country" Type="String" ConvertEmptyStringToNull="true" />
			</SelectParameters>
		</asp:SqlDataSource>
	</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
</asp:Content>


