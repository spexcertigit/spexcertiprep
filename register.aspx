<%@ Page Title="Registration | SPEX CertiPrep" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="login" debug="true"%>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">

    <style type="text/css">
        #loginform { width: 250px;height: 460px;float: left; }	

			#registerform {
				width: 60.7%;
				min-height: 400px;
				float:left;
			}
#registerform fieldset { padding-top: 0; }
#register_left {
	float: left;
	width: 50%;
    border: none;
}
#register_middle {
	float: left;
	width: 50%;
	height: 220px;
}
#register_right {
	float: right;
	width: 295px;
	height: 220px;
}		
div.first_time_shopping {
	width: 280px;
}
div.first_time_online {
	width: 280px; 
}	
div.account_number {
	padding: 20px 0 20px 30px; 
	background-color: #e9e9e9; 
	width: 265px;
}
span.req-left {
    padding: 10px 5px 0 0;
    color: #ff0000;
	float: left;
}
       
.input-260 {
    width: 244px ! important;
}
.input-273 {
	width:93.6%;
}

div#register_left div.type-text, div#register_middle div.type-text, div#register_middle div.type-select.req {
/*    display: inline-flex;	*/
}

#lblRefer {
    padding-top:32px;
}

	.clearboth{ clear: both;}
	.fl{ float: left;}
	.fr{ float: right;}
#gencontent_full .box1{ background-color: red; width: 33.3%; height: 100px;}
#gencontent_full .box2{ background-color: yellow; width: 33.3%; height: 100px;}
#gencontent_full .box3{ background-color: blue; width: 33.3%; height: 100px;}

.cont_list{ list-style: none; margin: 0; padding: 0;} 
.cont_list li{ display: block; margin: 0; padding: 0;}


.type-checkbox > input {
    float: left;
	margin: 5px 9px 5px 20px;
}

.yform label {
    float: left;
}

.type-checkbox {
    margin: 15px 0 17px;
}


.cont_list p {
    margin: 20px 5px 20px 21px;
    font-size: 15px;
}
select#DropDownList1{
    margin-left: 10px;
}
select#DropDownList2{
    margin-left: 10px;
}
select#DropDownList3{
    margin-left: 10px;
}

.type-check > input{ float: left; margin: 4px 5px;}
.type-check > label{ 
	clear: right;
    float: left;
    font-size: 14px;
    font-weight: bold;
    margin-bottom: 12px;
    display: block !important;
	width: 250px;
}

.type-check {
    margin: 0 !important;
    padding: 0 !important;
}
.type-check > div {
    display: block;
    margin: 10px 1px;
}
.hide{ display: none !important;}

.forgot {
    padding-left: 8px;
}
.register-button input.submitbutton{
	background-image: url("/images/button-register.png") !important;
    width: 240px;
    height: 45px;
    border: none !important;
    background-repeat: no-repeat !important;
    background-color: transparent !important;
    color: transparent !important;
}
.headerlabel {width:60.7%; }

#fancybox-wrap{
   background: rgb(255, 255, 255) !important;
   height: 125px !important;
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="/">Home</a> > Login</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">

    <div id="main">
        <asp:Panel ID="errorbox" ClientIDMode="Static" runat="server" Visible="false" EnableViewState="false">
            <asp:Literal ID="ltrErrorMessage" runat="server" />
        </asp:Panel> 
        <div class="headerlabel">
         	<div class="title">Register an Account</div>       
        </div>                       
        <div id="gencontent_full"> 
            <asp:Panel ID="registerform" ClientIDMode="Static" CssClass="yform" DefaultButton="cmdNew" runat="server">
            	
        	    <h3 class="head-text">New Customers &amp; Customers With Offline Accounts - Please fill out the form below.
        	    <!--
        	    <span id="login-handler" style="cursor:pointer;display:block; float:right;color:#ff427a;margin-right:20px;">Existing Customers Please Login Here</span>
        	    !-->
        	    </h3>
                <h3 class="req-label"><span class="req">*</span> Required Fields</h3>
				
        	    <div id="register_left" class="yform" style="padding:0">
					<ul class="cont_list">
						<li>
							<div class="type-text">
							<!--<asp:Label ID="lblfirstname" AssociatedControlID="firstname" Text="First Name: *" runat="server" />-->
							<span class="req-left">*</span>
							<asp:TextBox ID="firstname" placeholder="First Name" runat="server" CssClass="input-260" MaxLength="15" />
							<asp:RequiredFieldValidator ID="rfvfirstname" ControlToValidate="firstname" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
							</div>	
						</li>
						<li>
							  <div class="type-text">
								<!--<asp:Label ID="lbllastname" AssociatedControlID="lastname" Text="Last Name: *" runat="server" />-->
								<span class="req-left">*</span>
								<asp:TextBox ID="lastname" placeholder="Last Name" runat="server" CssClass="input-260" MaxLength="15" />
								<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="lastname" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
							</div>
						</li>
						<li>
							<div class="type-text">
								<!--<asp:Label ID="lblemail_check" AssociatedControlID="email_check" Text="Email Address: *" runat="server" />-->
								<span class="req-left">*</span>
								<asp:TextBox ID="email_check" placeholder="Email Address" runat="server" ClientIDMode="Static" CssClass="input-260" MaxLength="50" />
								<asp:RequiredFieldValidator ID="rfvemail_check" ControlToValidate="email_check" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
								<asp:RegularExpressionValidator ID="revemail_check" ControlToValidate="email_check" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Please enter a valid email address." ValidationGroup="vgNew" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
							</div>
						</li>
						<li>
							<div class="type-text">
								<span class="req-left">*</span>
								<asp:TextBox ID="Add1" placeholder="Address 1" runat="server" CssClass="input-260" MaxLength="15" />
								<asp:RequiredFieldValidator ID="RequiredFieldValidatorAdd1" ControlToValidate="Add1" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
							</div>
						</li>
						<li>
							<div class="type-text">
								<span class="req-left" style="visibility:hidden">*</span>
								<asp:TextBox ID="Add2" placeholder="Address 2" runat="server" CssClass="input-260" MaxLength="15" />
							</div>
						</li>
						<li>
							<div class="type-text">
								<span class="req-left">*</span>
								<asp:TextBox ID="City" placeholder="City" runat="server" CssClass="input-260" MaxLength="15" />
								<asp:RequiredFieldValidator ID="RequiredFieldValidatorCity" ControlToValidate="City" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
							</div>
						</li>
						<li>
							<div class="type-text">
								<span class="req-left">*</span>
								<asp:TextBox ID="State" placeholder="State" runat="server" CssClass="input-260" MaxLength="15" />
								<asp:RequiredFieldValidator ID="RequiredFieldValidatorState" ControlToValidate="State" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
							</div>
						</li>
						<li>
							<div class="type-text">
								<span class="req-left">*</span>
								<asp:TextBox ID="Zip" placeholder="Zip" runat="server" CssClass="input-260" MaxLength="15" />
								<asp:RequiredFieldValidator ID="RequiredFieldValidatorZip" ControlToValidate="Zip" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
							</div>
						</li>
						<li>
							 <div class="type-checkbox">
								<asp:CheckBox ID="mailing_list" Text="Add me to your mailing list" TextAlign="Right" AutoPostBack="True" runat="server" />
								<div class="clearboth"></div>
							</div>
						</li>
						<li>
							<div><p style="margin-top:23px;">How did you hear about us?</p></div>
						</li>

                        <li>
							<div class="type-select">
							<!--<asp:Label ID="Label1" AssociatedControlID="Refer" Text="How did you hear about us?" runat="server" />-->
								<span class="req-left" style="visibility: hidden">*</span>
								<div class="selectbg">
									<div class="IEmagic">
										<asp:DropDownList ID="DropDownList1" CssClass="input-273" runat="server">
											<asp:ListItem Value="" disabled selected style='display:none;' Text="Choose One" />
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
								</div>
							</div>
						</li>

                        <li>
							 <div class="type-text">
								<!--<asp:Label ID="lblpassword" AssociatedControlID="password" Text="Password: *" runat="server" />-->
								<span class="req-left">*</span>
								<asp:TextBox ID="password" placeholder="Password" TextMode="Password" runat="server" CssClass="input-260" MaxLength="20" />
								<asp:RequiredFieldValidator ID="rfvpassword" ControlToValidate="password" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
							</div>
						</li>
						<li>
								<div class="type-text">
								<!--<asp:Label ID="lblconfirm_password" AssociatedControlID="confirm_password" Text="Confirm Password: *" runat="server" />-->
								<span class="req-left">*</span>
								<asp:TextBox ID="confirm_password" placeholder="Confirm Password" TextMode="Password" runat="server" CssClass="input-260" MaxLength="20" />
								<asp:RequiredFieldValidator ID="rfvconfirm_password" ControlToValidate="confirm_password" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
								<asp:CompareValidator ID="cvconfirm_password" ControlToValidate="confirm_password" ControlToCompare="password" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Confirmed password does not match." ValidationGroup="vgNew" />
							</div>
						</li>
						<li>
							<div class="type-text">
							<!--<asp:Label ID="lblCompany" AssociatedControlID="Company" Text="Company: *" runat="server" />-->
							<span class="req-left">*</span>
							<asp:TextBox ID="Company" placeholder="Company Name" runat="server" CssClass="input-260" MaxLength="30" />
							<asp:RequiredFieldValidator ID="rfvCompany" ControlToValidate="Company" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
						</div>
						</li>
						<li>
							<div class="type-select req">
							<!--<asp:Label ID="lblCountry" AssociatedControlID="Country" Text="Country: *"  runat="server" />-->
							<span class="req-left">*</span>
								<div class="selectbg">
									<div class="IEmagic">
										<asp:DropDownList ID="Country" runat="server" CssClass="input-273" AppendDataBoundItems="true" DataSourceID="dataCountries" DataTextField="countryname" DataValueField="countryCode">
											<asp:ListItem Value="" Text="Select Country" selected />
										</asp:DropDownList>
										<asp:RequiredFieldValidator ID="rfvCountry" ControlToValidate="Country" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
									</div>
								</div>
							</div>
						</li>
                        <li>
							<div class="type-text">
								<span class="req-left">*</span>
								<asp:TextBox ID="PhoneNbr" placeholder="Phone Number" runat="server" CssClass="input-260" MaxLength="30" />
								<asp:RequiredFieldValidator ID="rfvPhone" ControlToValidate="PhoneNbr" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgNew" />
							</div>
						</li>
						
						<!-- <li>
							<div><p style="margin-top:24px;">Which product type are you interested in?</p></div>
						</li>
						<li>
							<div><p style="margin-top:21px;">Which application are you interested in?</p></div>
						</li> -->
					</ul>
                </div>

                <div id="register_middle" style="padding:0">
					<ul class="cont_list">
						 <div class="first_time_shopping">
						<div class="type-check">
							<asp:RadioButton ID="first_time_shopping" Checked="true" GroupName="new_customer" runat="server" Text=" This is my first time shopping with SPEX" />
							<div style="padding:5px 0 0 20px">A SPEX CertiPrep account number will be assigned once you place your first order.</div>
						</div>
					</div>
                    <div class="first_time_online">
                        <div class="type-check">
                            <asp:RadioButton ID="first_time_online" GroupName="new_customer" runat="server" Text=" I have shopped with SPEX before,but this is my first time purchasing online." />
                        </div>
                        <!-- <div style="margin:-.5em 0 0 25px;">but this is my first time purchasing online.</div> -->
                        <div style="padding:0 0 10px 10px; margin-bottom:10px" class="type-text">
                            <div class="type-text account">
                                <asp:Label ID="lblaccount_number" style="margin-bottom:10px" AssociatedControlID="account_number" Text="Provide Your SPEX CertiPrep Account Number:" runat="server" />
                                <asp:TextBox ID="account_number" placeholder="SPEX CertiPrep Account Number" runat="server" Width="250px" style="margin-bottom:10px;" />
                            </div>
                            <span class="forgot"><a href="#modal_forgot" class="inlinedialog">Forgot Your Account Number?</a></span>
                        </div>
                    </div>
                       <div class="type-select hide">
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
                  <div class="type-button register-button">
                        <asp:Button ID="cmdNew" Text="CONTINUE" runat="server" CssClass="submitbutton" onclick="cmdNew_Click" ValidationGroup="vgNew" />
                    </div>
						<!-- <li>
							<div class="type-select">
								<span class="req-left" style="visibility: hidden">*</span>
								<div class="selectbg">
									<div class="IEmagic">
										<asp:DropDownList ID="DropDownList2" CssClass="input-273" runat="server">
											<asp:ListItem Value="" disabled selected style='display:none;' Text="Select Product Type" />
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
								</div>
							</div>
						</li>
						<li>
							<div class="type-select">
								<span class="req-left" style="visibility: hidden">*</span>
								<div class="selectbg">
									<div class="IEmagic">
										<asp:DropDownList ID="DropDownList3" CssClass="input-273" runat="server">
											<asp:ListItem Value="" disabled selected style='display:none;' Text="Select Application" />
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
								</div>
							</div>
						</li> -->
					</ul>
                </div>

                      
				

            </asp:Panel>

            <div id="login_form">
            <div class="login_title">
          	    <h3>Login</h3>
                 
            </div>

            <div class="login_content">
            <h5>Existing Online customers</h5>
                   <div class="errormsg_box" id="errormsg_box" runat="server" style="color:Red;">
                            <asp:Literal ID="ltrErrorMsgFromReg" runat="server"></asp:Literal>
                   </div> 
                     
                <div > 
                    <asp:Label ID="lblUsernameFromReg" AssociatedControlID="txtUsernameFromReg" Text="" runat="server" />
                    <asp:TextBox ID="txtUsernameFromReg" CssClass="text-input" placeholder="Enter your username" runat="server"></asp:TextBox> <br />
                    <asp:RequiredFieldValidator ID="rfvUsernameFromReg"  ControlToValidate="txtUsernameFromReg" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server"
                     SetFocusOnError="true" Text="This field is required" ValidationGroup="vgLoginFromReg" />
                </div>
                <div>
                    <asp:Label ID="lblPasswordFromReg" AssociatedControlID="txtPasswordFromReg" runat="server">
        	       </asp:Label>
                    <asp:TextBox ID="txtPasswordFromReg" placeholder="Enter your password" CssClass="text-input" TextMode="Password" runat="server" /><br />
                    <asp:RequiredFieldValidator ID="rfvPasswordFromReg" ControlToValidate="txtPasswordFromReg" CssClass="formerror" Display="Dynamic"
                     EnableClientScript="true" runat="server" SetFocusOnError="true" Text="This field is required" ValidationGroup="vgLoginFromReg" />
                </div>
               			
				<a id="A1" runat="server" href="~/forgotpassword.aspx">Forgot Your Password</a>
				<div class="type-button">
                    <asp:Button ID="cmdLoginFromReg"  runat="server" CssClass="loginbtn" Text="" OnClick="cmdLoginFromReg_Click"  ValidationGroup="vgLoginFromReg" />
                    <asp:HiddenField ID="redirect" runat="server" />
                </div>
            </div>
				
            </div><!-- end login_form!-->
	    </div> 
		
			
    </div>
    <br style="clear:both" />
	<br><br>
    <div style="display:none">
        <div id="modal_forgot">
	        <h3>Forgot your Account Number?</h3>
	        <p style="color:black">Please click on the Chat link on the top of the page to speak with one of our representatives and retrieve your account information.</p>
        </div>
    </div>
	

    <asp:SqlDataSource ID='dataCountries' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
        SelectCommand="sp_GetCountryList" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
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
<script>
    $(function () {
        if (window.PIE) {
            $('input').each(function () {
                PIE.attach(this);
            });
            $('textarea').each(function () {
                PIE.attach(this);
            });
        }

        try {
            if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
                // some code..
            } else {
                //$("#Country").msDropDown();
                //$("#DropDownList1").msDropDown();
            }
        } catch (e) {
            alert(e.message);
        }
    });
</script>
</asp:Content>

