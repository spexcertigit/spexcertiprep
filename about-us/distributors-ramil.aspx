<%@ Page Title="SPEX CertiPrep - About Us - Distributors" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="distributors.aspx.cs" Inherits="purchase_distributors" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/default.aspx">Home</a> > About Us > Distributors</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="mainHeader">
                <asp:Literal ID="ltrHeadline" runat="server" />
            </div>
            <div id="main">
                <div id="col1">
                    <div id="col1_content" class="clearfix">
                        <asp:DropDownList id="country" runat="server" style="font-size:13px" AutoPostBack="true" DataSourceID="dataCountries" DataTextField="Country" DataValueField="CountryId" AppendDataBoundItems="true" OnSelectedIndexChanged="UpdateUrlBasedOnCountry" OnDataBound="OnCountriesDDLDataBound">
							<asp:ListItem Value="" Text="Select your country" />
                        </asp:DropDownList>
						<uc1:ShareThis ID="ShareThis1" runat="server" />
                    </div>
                </div>
                <div id="col3">
                    <div id="col3_content" class="clearfix">
                        <div id="distributors">
						
                            <h2>SPEX CertiPrep Distributors</h2>
                            <br />
							<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
									<script>
									var country = new Array();
									var str = '<%= Request.QueryString["country"] %>';

									
									function addmarker(map,country){
										for(var i=0;i < country.length;i++){
										
										if(country[i][0] == str){
										
											var myLatlng = new google.maps.LatLng(country[i][1],country[i][2]);
											var marker = new google.maps.Marker({
												  position: myLatlng,
												  map: map,
												  title: country[i][3]
											  });
											  
												// infoWindow
												var infowindow = new google.maps.InfoWindow({
												content: '<div style="height:80px;" class="info-window">'+country[i][3]+'</div>',
												maxHeight: 300
												});
												
												google.maps.event.addListener(marker, 'click',(function(marker, i) {
													return function(){
														infowindow.open(map,marker);
													}
												  })(marker, i));
											}
										}
									}
									
									function initialize() {
										var x=0;
										var y=0;
										
					var country =[	['argentina','-34.5976557','-58.4027539','Paraguay 2452 3B, Buenos Aires C1121ABN, Argentina'],
									['australia','40.5459946','-74.3716795','Street: 5 Caribbean Dv (Postal: PO Box 9092) Scoresby 3179, Vic'], 
									['austria','48.066078','11.614799','Hauptstrasse 1 82008 Unterhaching'],
									['belarus','53.949229','27.671789','Gintovta Str. 12A, Minsk, BY, 220125, BELARUS'],	
									['belguim','51.12028','4.972233','ENA 23, Zone 1, nr 1350 Janssen Pharmaceuticalaan 3a 2440 Geel, Belgium'],	
									['brazil','-19.902365','-43.930167','Av. Cristiano Machado 1648/505 Belo Horizonte MG 31170-800'],	
									['bulgaria','42.698838','23.319114','Blvd. Ovcha Kupel Nr. 13 Sofia 1618'],
									['canada','45.455314','-73.661324','Corporate office 255 Norman Lachine PQ H8R1A3'],
									['chile','-33.41364','-70.543216','Los Canteros 8666 Parque Industrial La Reina Santiago de Chile 788 0340'],
									['china','40.053176','116.302639','2nd Building, 1st Place, Shangdi 10th Road Room 2008 Haidian District Beijing 100085 China'],
									['colombia','4.713046','-74.125017','Calle 73 No. 20C - 87 Bogota'],
									['cyprus','35.147652','33.385045','2 Pythagorou Str Platy Aglandjia, Nicosia, 2122 Cyprus'],	
									['czech republic','49.183849','16.599952','Polni 23/340 639 00 BRNO Czech Republic'],	
									['finland','60.21782','24.878448','Valimotie 9, 6 krs 00380 Helsinki Finland'],	
									['france','48.695011','2.288908','16-18 Rue du Canal, Longjumeau 91165 Cedex'],	
									['germany','48.066135','11.614734','Hauptstrasse 1, 82008 Unterhaching'],	
									['athens','37.993795','23.754798','6-8 Spyridogianni Str., 115 22, Athens, Greece'],	
									['india','17.39047','78.480338','4-1-10/1, Tilak Road, Opp Church Building, Hyderabad, A. P. India'],	
									['israel','32.008804','34.885513','Arava St. Airport-City, POB 1134, Ben-Gurion Airport, 70100 Israel'],	
									['italy','45.433154','9.174997','via Neera 8/A, 20141 Milano'],	
									['italy','44.80661','11.051685','Via Bosco,21, 41030 San Prospero (MO), Italy'],	
									['japan','34.660922','135.217835','1-4-4, Minatojima- Minamimachi, Chuo-ku, Kobe Japan 650-0047'],	
									['korea','37.515751','127.064174','Scinco Building, #109-2 Samseong-dong, Gangnam-gu, Seoul, 135-090, Korea'],	
									['kuwait','29.358838','47.90105','P.O. Box 867 Safat, 13009 Safat, Kuwait'],	
									['malaysia','3.106171','101.592688','Unit 1010, Block B, Kelana Square 17. Jalan SS7/26, Kelana Jaya, Petaling Jaya, Selangor 47301'],
									['malta','35.895065','14.449075','36/6, Manol Mansions, De Paule Avenue, Balzan BZN 9022, Malta'],
									['mexico','18.942843','-99.225729','Subida del Club #62. Col. Reforma 62260 Cuernavaca, Morelos, Mexico'],
									['morocco','33.53712','-7.605182','Andalous 5, rue 19, No. 43, 20150 Casablanca, Morocco'],
									['netherlands','52.711365','6.202291','Postbus BOX 37, 7940 AA Meppel, MEPPEL'],
									['new zealand','-36.755167','174.702155','Private Bag 102922, North Shore, North Shore City 0745'],
									['nigeria','6.436083','3.413505','No. 17 Kofo Abayomi Street, Apapa Lagos, Nigeria'],
									['norway','59.92684','10.799986','Økernveien 121, 0579 Oslo, Norway'],
									['norway','59.965881','10.772521','Frysjaveien 33 E 0884, Oslo, Norway'],
									['paraguay','-34.597613','-58.402747','Paraguay 2452 3B, Buenos Aires C1121ABN, Argentina'],
									['philippines','14.588085','121.034689','NO. 10A H. Poblador Street. Brgy. Hagdang BatoLibis, Mandaluyong City 014786'],
									['poland','52.245014','21.077374','ul. Lubomira 4 lok 4, 04-002 Warszawa, Poland'],
									['portugal','38.688893','-9.337907','Av. S. Miguel, Edifício Arcadas de S. Miguel Encosta, nº249 esc. 15, 2775-751 Carcavelos, Portugal'],
									['portugal','38.74113','-9.158138','Rua Dr Alvaro de Castro, 77, Lisboa 1600-058'],
									['portugal','38.858441','-9.069131','Praceta Anibul Faustino No 6B, 626-505 POVOA DE SANTA IRIA'],
									['romania','44.440399','26.007103','Bucuresti, str. Catinei, nr. 38, Sector 6, cod 062346, Romania'],
									['singapore','1.336584','103.757175','55 Toh Guan Road East, #03-05 Unitech Centre, Singapore 608601'],
									['slovenia','46.54099','15.607084','Lackova 78, SI-2000 MARIBOR'],
									['spain','40.50631', '-3.5323','Apdo. De Correos 5, 28860 Paracuellos De Jarma (Madrid), Spain'],
									['spain','36.801536','-2.637902','C\ Los Plateros No. 1004738 Almeria Vicar'],
									['spain','40.431138','-3.646563','Logo Constonza. 46, 28017 MADRID'],
									['sweden','59.856163','17.663502','PO Box 15120, SE-750 15 UPPSALA'],
									['switzerland','48.066078','11.614713','Hauptstrasse 1, 82008 Unterhaching'],
									['thailand','13.865612','100.499692','68/876 Moo 8, Rattanathibet Rd, Bangkrasor, Muang Nonthaburi, Nonthaburi 11000, THAILAND'],
									['united kingdom','51.601533','-0.295226','2 Dalston Gardens, Stanmore, Middlesex HA7 1BQ'],
									['united kingdom','52.785115','-1.223906','LOUGHBOROUGH, LE11, 5RG'],
									['united kingdom','53.198803','-3.003164','Unit 7, Glendale Avenue, SANDYCROFT, CH5, 2QP'],
									['united states','40.546104','-74.371665','203 Norcross Ave. , Metuchen, NJ 08840 USA'],
									['united states','40.454491','-80.189127','2000 Park Lane, Pittsburgh, PA	15275'],				
									['uruguay','-34.597613','-58.402747','Paraguay 2452 3B, Buenos Aires C1121ABN, Argentina']
										];
												for(var i=0;i < country.length;i++){	
													if(country[i][0] == str){
														x = country[i][1];
														y = country[i][2];
													}
												}
							
											  var myLatlng = new google.maps.LatLng(x,y);
											  var mapOptions = {
												zoom: 10, 
												center: myLatlng
											  }
											  var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
					
											  addmarker(map,country);  
											}
											
											google.maps.event.addDomListener(window, 'load', initialize);
											
											</script>
											
										<div id="map-canvas" style="width:665px;height:300px"></div>
										
										<br />
                            <h2><asp:Label ID="countryLabel" runat="server" text=""></asp:Label></h2>
							<asp:ListView ID="lvItems" DataSourceID="dataItems" runat="server">
								<LayoutTemplate>
									<asp:PlaceHolder runat="server" ID="itemPlaceHolder" />
								</LayoutTemplate>
								<ItemTemplate>
									<div style="font-weight:bold"><%# Eval("Company") %></div>
									<div><%# Eval("Phone") %></div>
									<div><%# Eval("Fax").ToString().Length > 0 ? Eval("Fax").ToString() + " (fax)" : "" %></div>
									<div><%# Eval("Email").ToString().Length > 0 ? "<a href='mailto:" + Eval("Email").ToString() + "'>" + Eval("Email").ToString() + "</a>" : "" %></div>
									<div><%# Eval("Site").ToString().Length > 0 ? "<a href='" + Eval("Site").ToString() + "' target='_blank'>" + Eval("Site").ToString() + "</a>" : "" %></div>
									<div><%# Eval("Address1") %></div>
									<div><%# Eval("Address2") %></div>
									<div><%# Eval("Address3") %></div>
									<div><%# Eval("Address4") %></div> 									
								</ItemTemplate>
								<EmptyDataTemplate>
									    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
											<script>
									            function initialize() {
											      var myLatlng = new google.maps.LatLng(-34.597271,-58.40283);
											      var mapOptions = {
												    zoom: 15,
												    center: myLatlng
											      }
											      var map = new google.maps.Map(document.getElementById('map-spexcertiprep'), mapOptions);

											      var marker = new google.maps.Marker({
												      position: myLatlng,
												      map: map,
												      title: 'Hello World!'
											      });
											    }
											google.maps.event.addDomListener(window, 'load', initialize);
											</script>
										<div id="map-spexcertiprep" style="width:665px;height:300px"></div>
									<p>SPEX CertiPrep has a worldwide network of distributors. Select your country to the left to  find a dealer near you. Can&#8217;t  find a dealer in your country? Or are  you interested in distributing SPEX CertiPrep products? Contact us at <a href="mailto:crmsales@spexcsp.com">crmsales@spexcsp.com</a>.</p>
								</EmptyDataTemplate>
							</asp:ListView>
                        </div>
                    </div>
                    <div id="ie_clearing"> &#160; </div>
                </div>
            </div>
<asp:SqlDataSource ID='dataCountries' runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" ProviderName="<%$ ConnectionStrings:ApplicationServices.ProviderName %>"
    SelectCommand="SELECT DISTINCT LOWER(Country) AS CountryId, Country FROM certiDistributor ORDER BY Country" SelectCommandType="Text">
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

