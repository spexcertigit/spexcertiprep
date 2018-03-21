<%@ Page Title="SPEX CertiPrep - Knowledge Base - Conversion Table" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="conversion-table.aspx.cs" Inherits="knowledge_conversion" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="../default.aspx">Home</a> > Knowledge Base > Conversion Table</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="mainHeader">
                <h1>Conversion Table</h1>
            </div>
            <div id="main">
                <div id="col1">
                    <div id="col1_content" class="clearfix">
						<div class="CustomOS_logo">
							<asp:PlaceHolder ID="Image" runat="server" />
						</div>
						<uc1:ShareThis ID="ShareThis1" runat="server" />
                    </div>
                </div>
                <div id="col3">
                    <div id="col3_content" class="clearfix">
						<asp:PlaceHolder ID="BodyContent" runat="server" />
      	                <table cellpadding="0" cellspacing="0" id="conversion_table">
                          <col width="269" />
                          <col width="244" />
                          <col width="86" />
                         <thead>
                         <tr>
                            <th scope="col">From (X)</th>
                            <th scope="col">To (Y)</th>
                            <th scope="col">Conversion Formula</th>
                         </tr>
                          </thead>
                          <tbody>
                          <tr height="20">
                            <td width="269" height="20" colspan="3" class="sectiontitle"><h2>Temperature</h2></td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">&deg;F</td>
                            <td width="269">&deg;C</td>
                            <td width="269">0.556X- 17.8</td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">&deg;C</td>
                            <td width="269">&deg;F</td>
                            <td width="269">1.8X + 32</td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">&deg;C</td>
                            <td width="269">&deg;K</td>
                            <td width="269">1.0X + 273</td>
                          </tr>
                          <tr height="20">
                            <td height="20" colspan="3"></td>
                            </tr>
		                  </tbody>
                          <tr height="20">
                            <td width="269" height="20" colspan="3" class="sectiontitle"><h2>Length</h2></td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">mils</td>
                            <td width="269">microns</td>
                            <td align="right" width="269">Y = 25.4X</td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">mils</td>
                            <td width="269">millimeters</td>
                            <td align="right" width="269">Y = 0.0254X</td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">inches</td>
                            <td width="269">mils</td>
                            <td align="right" width="269">Y = 1000X</td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">centimeters</td>
                            <td width="269">inches</td>
                            <td align="right" width="269">Y = 2.54X</td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">feet</td>
                            <td width="269">meters</td>
                            <td align="right" width="269">Y = 0.3048X</td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">feet</td>
                            <td width="269">miles</td>
                            <td align="right" width="269">Y = 5280X</td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">feet</td>
                            <td width="269">yards</td>
                            <td align="right" width="269">Y = 3X</td>
                          </tr>
                          <tr height="20">
                            <td height="20" colspan="3"></td>
                          </tr>
                          <tr height="20">
                            <td width="269" height="20" colspan="3" class="sectiontitle"><h2>Mass</h2></td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">grams</td>
                            <td width="269">ounces</td>
                            <td align="right" width="269">Y = 28.4X</td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">kilograms</td>
                            <td width="269">pounds</td>
                            <td align="right" width="269">Y = 0.45X</td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">ounces    (troy)</td>
                            <td width="269">grams</td>
                            <td align="right" width="269">Y = 0.03215X</td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">pounds</td>
                            <td width="269">tons</td>
                            <td align="right" width="269">Y = 2000X</td>
                          </tr>
                          <tr height="20">
                            <td height="20" colspan="3"></td>
                          </tr>
                          <tr height="20">
                            <td width="269" height="20" colspan="3" class="sectiontitle"><h2>Area</h2></td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">square    centimeters</td>
                            <td width="269">square inches</td>
                            <td align="right" width="269">Y = 6.5X</td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">square    meters</td>
                            <td width="269">square feet</td>
                            <td align="right" width="269">Y = 0.09X</td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">square    meters</td>
                            <td width="269">square yards</td>
                            <td align="right" width="269">Y = 0.8X</td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">square    kilometers</td>
                            <td width="269">square miles</td>
                            <td align="right" width="269">Y = 2.6X</td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">hectares</td>
                            <td width="269">arces</td>
                            <td align="right" width="269">Y = 0.4X</td>
                          </tr>
                          <tr height="20">
                            <td height="20" colspan="3"></td>
                          </tr>
                          <tr height="20">
                            <td width="269" height="20" colspan="3" class="sectiontitle"><h2>Volume</h2></td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">teaspoons</td>
                            <td width="269">mililiters</td>
                            <td align="right" width="269">Y = 5X</td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">tablespoons</td>
                            <td width="269">mililiters</td>
                            <td align="right" width="269">Y = 15X</td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">fluid    ounces</td>
                            <td width="269">mililiters</td>
                            <td align="right" width="269">Y = 30X</td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">quarts</td>
                            <td width="269">liters</td>
                            <td align="right" width="269">Y = 0.95X</td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">gallons</td>
                            <td width="269">liters</td>
                            <td align="right" width="269">Y = 3.8X</td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">cubic    meters</td>
                            <td width="269">cubic feet</td>
                            <td align="right" width="269">Y = 0.03X</td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">cubic    meters</td>
                            <td width="269">cubic yards</td>
                            <td align="right" width="269">Y = 0.76X</td>
                          </tr>
                          <tr height="20">
                            <td height="20" colspan="3"></td>
                          </tr>
                          <tr height="20">
                            <td height="20" colspan="3" class="sectiontitle"><h2>Constants</h2></td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">Universal Gas Constant</td>
                            <td width="269">R = 0.0821(Atm)(l)/(&deg;K)(mole)</td>
                            <td></td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">Acceleration Due to Gravity</td>
                            <td width="269">g = 32.17 ft/sec<sup class="superscript">2</sup>, 9.8 m/sec<sup class="superscript">2</sup></td>
                            <td></td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">Avogadro's Constant</td>
                            <td width="269">N = 6.022 x 10<sup class="superscript">23</sup> molecules/mole</td>
                            <td></td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">Speed of Light</td>
                            <td width="269">c = 186,000 miles/sec, 3 X 1010    cm/sec</td>
                            <td></td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">Heat of Fusion (water 1 atm, 0&deg;C)</td>
                            <td width="269">Hf = 79.7 cal/g</td>
                            <td></td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">Heat of Vaporization (water 1 atm, 100&deg;C)</td>
                            <td width="269">Hv = 540 cal/g</td>
                            <td></td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">Volume of Perfect Gas</td>
                            <td width="269">22.4l at 0&deg;C, 760 torr</td>
                            <td></td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">Faraday's Constant</td>
                            <td width="269">F = 96.494 coulombs/equiv.    weight</td>
                            <td></td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">Planck's Constant</td>
                            <td width="269">h = 6.626 X 10-27 erg/sec</td>
                            <td></td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">Bragg's Law</td>
                            <td width="269">nl = 2d sinq</td>
                            <td></td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">Absolute Zero</td>
                            <td width="269">-273.15 &deg;C</td>
                            <td></td>
                          </tr>
                          <tr height="20">
                            <td height="20" width="269">Temperature of Liquid Nitrogen</td>
                            <td width="269">-195.8 &deg;C</td>
                            <td></td>
                          </tr>
                        </table>
                    </div>
                    <div id="ie_clearing"> &#160; </div>
                </div>
            </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script type="text/javascript">
		$(document).ready(function () {
			$("#conversion_table tr:odd").addClass("odd");
		});
	</script>
</asp:Content>

