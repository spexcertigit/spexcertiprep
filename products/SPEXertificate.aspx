<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="SPEXertificate.aspx.cs" Inherits="products_spexertificate" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">

	<style>
	p{
		font-size:1.15em;
	}
	.lotnum {
		float:left;
		padding:0px;
	}
	
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="../default.aspx">Home</a> > Products > SPEXertificate</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="mainHeader">
                <asp:Literal ID="ltrHeadline" runat="server" />
            </div>
            <div id="main">
                <div id="col1">
                    <div id="col1_content" class="clearfix">
						<div class="Spexertificate-Logo">
							<img src="images/Spexertificate.png" alt="Your science is our passion" width="240" height="289" />
						</div>
						<uc1:ShareThis ID="ShareThis1" runat="server" />
                    </div>
                </div>
                <div id="col3">
                    <div id="col3_content" class="clearfix">
                        <asp:Literal ID="ltrSubHeader" runat="server" />
                        <asp:Literal ID="ltrBody" runat="server" />
                        <h2 style="display: block; font-size: 20px;margin: 0; padding: 15px 0;font-weight: normal;">SPEXertificate Download</h2>
                        <br />
                        <p>To search for a SPEXertificate, please enter a Lot Number in the space below.</p>
                        <!--<p>You must be <a class="loginAnchor" href="javascript:void(0)">logged in</a> to download a certificate.</p>-->
                        <div id="search_results"></div>

                        <div class="yform" id="spexertificate" style="padding:0; border:none;">
                            <div id="lotnum" class="type-text">
                                <asp:TextBox ID="lot_number" runat="server" Width="250px" MaxLength="25"  placeholder="Lot Number" />
                                <asp:RequiredFieldValidator ID="rfvlot_number" ControlToValidate="lot_number" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" style="display:block" />
                            </div>
                            <div id="lotnumbtn" class="type-button">
                                <asp:Button ID="cmdSubmit" Text="SUBMIT" runat="server" CssClass="submitbutton" onclick="cmdSubmit_Click" ValidationGroup="vgNew" />
                            </div>
                            <asp:MultiView ID="mvMessage" runat="server" ActiveViewIndex="0">
                                <asp:View ID="vwStart" runat="server">
                                </asp:View>
                                <asp:View ID="vwAnon" runat="server">
                                    <div class="anon"><a class="loginAnchor" href="javascript:void(0)">Log In</a> to download</div>
                                </asp:View>
                                <asp:View ID="vwResult" runat="server">
                                    <div class="anon"><span class="green">Valid certificate number - 
                                    <asp:HyperLink ID="hlDownload" Text="Download" runat="server" /></div>
                                </asp:View>
                                <asp:View ID="vwNotFound" runat="server">
                                   <div class="anon"><span class="red">Certificate number not found</span></div>
                                </asp:View>
                            </asp:MultiView>
                            <div id="updatemessage"></div>
                        </div>
                    </div>
                    <div id="ie_clearing"> &#160; </div>
                </div>
            </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script>

        function showCertificate() {
            theQuery = escape($("#part_number").val());
            theQuery2 = escape($("#lot_number").val());
            $("#updatemessage").load("../inc/checkCertificate.aspx?query1=" + theQuery + "&query2=" + theQuery2);
        }

        $(document).ready(function () {
            $("#submit").click(function () {
                showCertificate();
            });
            $("#lot_number,#part_number").keypress(function (event) {
                if (event.keyCode == '13') { //check if enter key pressed
                    showCertificate();
                }
            });
			$(".loginAnchor").click(function(){
				//alert($('.login-container-opacity').attr("class"));
				$('.login-container-opacity').show(500);
				$(".mask-layout").show();
				$(".mask-layout").css("height", $("body").height());
			});
        });

    </script>
</asp:Content>

