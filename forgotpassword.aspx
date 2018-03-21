<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="forgotpassword.aspx.cs" Inherits="forgotpassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="mainHeader">
                <h1>Forgotten Password</h1>
            </div>
            <div id="main">
                <div id="col1">
                    <div id="col1_content" class="clearfix">
                        <img src="images/generic_temp_image.jpg" alt="Your science is our passion" width="240" height="240" />	  
                    </div>
                </div>
                <div id="col3">
                    <div id="col3_content" class="clearfix">
                        <h3>Are you having trouble logging in? </h3>
                        <asp:MultiView ID="mvForm" runat="server" ActiveViewIndex="0">
                            <asp:View ID="vwForm" runat="server">
                                <p>To reset your password, please enter your email address below. Instructions on how to change your password will be emailed to your email address shortly.</p>
								<div class="form-group">
									<asp:TextBox ID="email_username" CssClass="form-control" runat="server" placeholder="Email Address" style="width:50%" autocomplete="off" />
									<asp:Button ID="cmdSubmit" Text="Submit" CssClass="btn btn-success" runat="server" onclick="cmdSubmit_Click" ValidationGroup="vgNew" />
									<br />
									<asp:RequiredFieldValidator ID="rfvemail_username" ControlToValidate="email_username" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
									<asp:Label ID="lblNotFound" runat="server" ForeColor="#ff0000" Font-Bold="true" Text="This username is not found" EnableViewState="false" Visible="false" />
								</div>
                            </asp:View>
                            <asp:View ID="vwThank" runat="server">
	                            <div style="color:Green">Your password has been sent to your registered email address. Please check your email. </div>
                            </asp:View>
                        </asp:MultiView>
                    </div>
                    <div id="ie_clearing"> &#160; </div>
                </div>
            </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
</asp:Content>

