<%@ Page Title="" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
<script type="text/javascript">
    $(document).ready(function () {
        $(".inlinedialog").fancybox({
            'autoDimensions': false,
            'width': 300,
            'padding': 16,
            'centerOnScroll': true
        });
    });

</script>
    <style type="text/css">
        #loginform { width: 250px;height: 460px;float: left; }	
        /*#loginform input { margin-bottom:20px; }
        #register_left input { margin-bottom:20px; }*/

#registerform {
	width: 630px;
	min-height: 460px;
	float: right;
	margin:0 0 150px 15px;
}
#registerform fieldset { padding-top: 0; }
#register_left {
	float: left;
	width: 280px;
}
#register_right {
	float: right;
	width: 295px;
	height: 220px;
}		
div.first_time_shopping {
	width: 280px;
	background-color: #e9e9e9;
	padding:10px 10px 10px 5px;
    margin-top: 21px;
}
div.first_time_online {
	width: 280px; 
	margin-top: 10px; 
	background-color: #e9e9e9;
	padding:5px 10px 0 5px;
}	
div.account_number {
	padding: 20px 0 20px 30px; 
	background-color: #e9e9e9; 
	width: 265px;
}

#lblRefer
        {
    padding-top:32px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server">><a href="/">Home</a> > Login</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
    <div id="main">
        <asp:Panel ID="errorbox" ClientIDMode="Static" runat="server" Visible="false" EnableViewState="false">
            <asp:Literal ID="ltrErrorMessage" runat="server" />
        </asp:Panel>
        <div id="gencontent_header">
            <h1>Please login or register:</h1>
        </div>
        <div id="gencontent_full">
            <asp:Panel ID="loginform" ClientIDMode="Static" CssClass="yform" DefaultButton="cmdLogin" runat="server">
                <h3>Existing Online Customers</h3>
                <div class="type-text">
                    <asp:Label ID="lblEmail" AssociatedControlID="Email" Text="Email Address / Username:" runat="server" />
                    <asp:TextBox ID="Email" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvEmail" ControlToValidate="Email" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgLogin" />
                </div>
                <div class="type-text">
                    <asp:Label ID="lbllogin_password" AssociatedControlID="login_password" runat="server">
        	        Password: <a href="forgotpassword.aspx">Forgot Your Password?</a></asp:Label>
                    <asp:TextBox ID="login_password" TextMode="Password" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvlogin_password" ControlToValidate="login_password" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgLogin" />
                </div>
                <div class="type-button">
                    <asp:Button ID="cmdLogin" Text="CONTINUE" runat="server" CssClass="submitbutton" onclick="cmdLogin_Click" ValidationGroup="vgLogin" />
                    <asp:HiddenField ID="redirect" runat="server" />
                </div>
            </asp:Panel>

            <asp:Panel ID="registerform" ClientIDMode="Static" CssClass="yform" DefaultButton="cmdNew" runat="server">
        	    <h3>New Customers &amp; Customers With Offline Accounts- Please Register:</h3>
        	    <div id="register_left" class="yform" style="padding:0">
                    <div class="type-text">
                        <asp:Label ID="lblemail_check" AssociatedControlID="email_check" Text="Email Address: *" runat="server" />
                        <asp:TextBox ID="email_check" runat="server" ClientIDMode="Static" MaxLength="50" />
                        <asp:RequiredFieldValidator ID="rfvemail_check" ControlToValidate="email_check" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
                        <asp:RegularExpressionValidator ID="revemail_check" ControlToValidate="email_check" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Please enter a valid email address." ValidationGroup="vgNew" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                    </div>

                    <div class="type-text">
                        <asp:Label ID="lblfirstname" AssociatedControlID="firstname" Text="First Name: *" runat="server" />
                        <asp:TextBox ID="firstname" runat="server" Width="250px" MaxLength="15" />
                        <asp:RequiredFieldValidator ID="rfvfirstname" ControlToValidate="firstname" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
                    </div>

                    <div class="type-text">
                        <asp:Label ID="lbllastname" AssociatedControlID="lastname" Text="Last Name: *" runat="server" />
                        <asp:TextBox ID="lastname" runat="server" MaxLength="15" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="lastname" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
                    </div>

                    <div class="type-text">
                        <asp:Label ID="lblpassword" AssociatedControlID="password" Text="Password: *" runat="server" />
                        <asp:TextBox ID="password" TextMode="Password" runat="server" MaxLength="20" />
                        <asp:RequiredFieldValidator ID="rfvpassword" ControlToValidate="password" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
                    </div>

                    <div class="type-text">
                        <asp:Label ID="lblconfirm_password" AssociatedControlID="confirm_password" Text="Confirm Password: *" runat="server" />
                        <asp:TextBox ID="confirm_password" TextMode="Password" runat="server" MaxLength="20" />
                        <asp:RequiredFieldValidator ID="rfvconfirm_password" ControlToValidate="confirm_password" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
                        <asp:CompareValidator ID="cvconfirm_password" ControlToValidate="confirm_password" ControlToCompare="password" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Confirmed password does not match." ValidationGroup="vgNew" />
                    </div>

                    <div class="type-text">
                        <asp:Label ID="lblCompany" AssociatedControlID="Company" Text="Company: *" runat="server" />
                        <asp:TextBox ID="Company" runat="server" MaxLength="30" />
                        <asp:RequiredFieldValidator ID="rfvCompany" ControlToValidate="Company" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
                    </div>

                    <div class="type-select">
                        <asp:Label ID="lblCountry" AssociatedControlID="Country" Text="Country: *"  runat="server" />
			            <asp:DropDownList ID="Country" runat="server" DataSourceID="dataCountries" DataTextField="countryname" DataValueField="countryCode" />
                        <asp:RequiredFieldValidator ID="rfvCountry" ControlToValidate="Country" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
                    </div>
                </div>
                <div id="register_right">
                    <div class="first_time_shopping">
						<div class="type-check">
							<asp:RadioButton ID="first_time_shopping" Checked="true" GroupName="new_customer" runat="server" Text=" This is my first time shopping with SPEX" />
							<div style="padding:5px 0 0 20px">A SPEX CertiPrep account number will be assiged once you place your first order.</div>
						</div>
					</div>
                    <div class="first_time_online">
                        <div class="type-check">
                            <asp:RadioButton ID="first_time_online" GroupName="new_customer" runat="server" Text=" I have shopped with SPEX before," />
                        </div>
                        <div style="margin:-.5em 0 0 25px;">but this is my first time purchasing online.</div>
                        <div style="padding:0 0 20px 10px; margin-bottom:10px" class="type-text">
                            <div class="type-text">
                                <asp:Label ID="lblaccount_number" AssociatedControlID="account_number" Text="Provide Your SPEX CertiPrep Account Number:" runat="server" />
                                <asp:TextBox ID="account_number" runat="server" Width="250px" style="margin-bottom:10px;" />
                            </div>
                            <span class="forgot"><a href="#modal_forgot" class="inlinedialog">Forgot Your Acount Number?</a></span>
                        </div>
                    </div>
                       <div class="type-select">
						<asp:Label ID="lblRefer" AssociatedControlID="Refer" Text="How did you hear about us?" runat="server" />
						<asp:DropDownList ID="Refer" runat="server" style="width:100%">
							<asp:ListItem Value="" Text="" />
							<asp:ListItem Value="Coworker" Text="Coworker" />
							<asp:ListItem Value="Current Customer" Text="Current Customer" />
							<asp:ListItem Value="E-blast" Text="E-blast" />
							<asp:ListItem Value="Magazine ad" Text="Magazine ad" />
							<asp:ListItem Value="Internet search" Text="Internet search" />
							<asp:ListItem Value="Postcard" Text="Postcard" />
							<asp:ListItem Value="Tradeshow" Text="Tradeshow" />
							<asp:ListItem Value="Web ad" Text="Web ad" />
						</asp:DropDownList>
					</div>
                  <div class="type-button">
                        <asp:Button ID="cmdNew" Text="CONTINUE" runat="server" CssClass="submitbutton" onclick="cmdNew_Click" ValidationGroup="vgNew" />
                    </div>
                </div>        
            </asp:Panel>
	    </div>
    </div>
    <br style="clear:both" />
    <div style="display:none">
        <div id="modal_forgot">
	        <h3>Forgot your Account Number?</h3>
	        <p>Please click on the Chat link on the top of the page to speak with one of our representatives and retrieve your account information.</p>
        </div>
    </div>

    <asp:SqlDataSource ID='dataCountries' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="sp_GetCountryList" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
</asp:Content>
 
