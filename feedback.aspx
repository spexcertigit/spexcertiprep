<%@ Page Title="Survey | SPEX CertiPrep" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="feedback.cs" Inherits="knowledge_base_Presentations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
	
	<style> #breadcrumb { display:none }</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="main">
                <div id="col1" class="feedback">
                    <div id="col1_content" class="clearfix">
						<div class="leftcol_details">
							<img src="/images/spex_feedback.jpg" alt="SPEX Feedback" />
							<div class="surveyIntroBox">THANK YOU FOR BEING ONE OF OUR BEST CUSTOMERS!</div>
						</div>
                    </div>
                </div>
                <div id="col3" class="feedback" style="border:none">
                    <div id="col3_content" class="clearfix">
						<div id="mainHeader">
							<h1 style="visibility:hidden">SPEX Survey</h1>
							<br />
						</div>
						<div id="surveyForm">
							<p>
								<span>THANK YOU FOR CHOOSING SPEX CERTIPREP!</span><br /><br />
								Your opinion is valuable to us! We actively use customer feedback to help us improve our products and service. Please complete this quick survey and let us know how we are doing. We really appreciate your feedback! Your response will be kept confidential and will not be sent to third party establishment.<br><br>
								Enjoy a cup of coffee on us! For completing this survey, you will receive a $5 Starbucks Gift Card.
								<br><br>
							</p>
							<asp:MultiView ID="mvrForm" runat="server" ActiveViewIndex="0">
								<asp:View ID="vwrForm" runat="server">
									<div id="ratings">
										<div class="ratestar" data-rate="1"></div>
										<div class="ratestar" data-rate="2"></div>
										<div class="ratestar" data-rate="3"></div>
										<div class="ratestar" data-rate="4"></div>
										<div class="ratestar" data-rate="5"></div>
										<p>&nbsp;&nbsp;Please rate your overall experience with our company.</p>
										<asp:HiddenField id="RateScore" runat="server" value="0" />
										<div style="clear:both"></div>
									</div>
									<p><strong>1. Which product(s) did you purchase?</strong></p>
									<div class="type-select">
										<asp:DropDownList ID="txtProductType" runat="server" AppendDataBoundItems="true" required>
											<asp:ListItem Value="Single or Multi Component Inorganics" Text="Single or Multi Component Inorganics" />
											<asp:ListItem Value="Single or Multi Component Organics" Text="Single or Multi Component Organics" />
											<asp:ListItem Value="Petroleum, Petrochemical or BioDiesel Standards" Text="Petroleum, Petrochemical or BioDiesel Standards" />
											<asp:ListItem Value="Wine Standards" Text="Wine Standards" />
											<asp:ListItem Value="QuEChERS" Text="QuEChERS" />
											<asp:ListItem Value="QC Samples" Text="QC Samples" />
											<asp:ListItem Value="Organometallic Single or Multi Element Oil Standards" Text="Organometallic Single or Multi Element Oil Standards" />
											<asp:ListItem Value="Fusion, Fluxes or Additives" Text="Fusion, Fluxes or Additives" />
											<asp:ListItem Value="USP Elemental Impurities" Text="USP Elemental Impurities" />
											<asp:ListItem Value="pH Buffers" Text="pH Buffers" />
											<asp:ListItem Value="Custom Inorganic Standards" Text="Custom Inorganic Standards" />
											<asp:ListItem Value="Custom Organic Standards" Text="Custom Organic Standards" />
											<asp:ListItem Value="Others" Text="Others" />
										</asp:DropDownList>
									</div><br />
									
									<!-- Question 2 -->
									<div class="question-box">
										<p><strong>2. Based on your recent purchasing experience, how satisfied are you with SPEX CertiPrep?</strong><br /></p>
										<asp:RadioButtonList ID="rblQue2" runat="server" CssClass="vertQue">
											<asp:ListItem Text="<span><span></span></span>Very Satisfied" Value="Very Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Satisfied" Value="Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Neither satisfied or dissatisfied" Value="Neither satisfied or dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Dissatisfied" Value="Dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Very dissatisfied" Value="Very dissatisfied" />
										</asp:RadioButtonList>
										<asp:RequiredFieldValidator ID="rfvQ2" ControlToValidate="rblQue2" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Please choose your answer."  ValidationGroup="vgRNew" style="line-height:36px;" />
										
										<div class="clear"></div>
									</div>				
									<div class="type-text">
										<p>Please provide details below:</p>
										<asp:TextBox ID="Que2" runat="server" Rows="7" TextMode="MultiLine" CssClass="surveyTxtbox" />
										<div class="queLimit"><span id="Que2-limit">300</span> word limit</div>
									</div>
									<!-- Question 2 -->
									
									<!-- Question 3 -->
									<div class="question-box">
										<p><strong>3. Based on your recent purchasing experience, would you purchase another product from SPEX CertiPrep?</strong><br /></p>
										<asp:RadioButtonList ID="rblQue3" runat="server" CssClass="vertQue">
											<asp:ListItem Text="<span><span></span></span>Definitely" Value="Definitely" />
											<asp:ListItem Text="<span><span></span></span>Probably" Value="Probably" />
											<asp:ListItem Text="<span><span></span></span>Might or might not" Value="Might or might not" />
											<asp:ListItem Text="<span><span></span></span>Probably not" Value="Probably not" />
											<asp:ListItem Text="<span><span></span></span>Definitely not" Value="Definitely not" />
										</asp:RadioButtonList>
										<asp:RequiredFieldValidator ID="rfvQ3" ControlToValidate="rblQue3" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Please choose your answer."  ValidationGroup="vgRNew" style="line-height:36px;" />
										<div class="clear"></div>
									</div>
									<div class="type-text">
										<p>Please provide details below:</p>
										<asp:TextBox ID="Que3" runat="server" Rows="7" TextMode="MultiLine" CssClass="surveyTxtbox" />
										<div class="queLimit"><span id="Que3-limit">300</span> word limit</div>
									</div>
									<!-- Question 3 -->
									
									<!-- Question 4 -->
									<div class="question-box">
										<p><strong>4. How satisfied are you with SPEX CertiPrep products in the following areas?</strong><br /></p>
										
										<p class="sub-ans">Value for the price</p>
										<asp:RadioButtonList ID="rblQue4Ans1" runat="server" CssClass="overSizeQue" RepeatDirection="Horizontal">
											<asp:ListItem Text="<span><span></span></span>Very Satisfied" Value="Very Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Satisfied" Value="Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Neither satisfied or dissatisfied" Value="Neither satisfied or dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Dissatisfied" Value="Dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Very dissatisfied" Value="Very dissatisfied" />
										</asp:RadioButtonList>
										<asp:RequiredFieldValidator ID="rfvQ4Ans1" ControlToValidate="rblQue4Ans1" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Please choose your answer."  ValidationGroup="vgRNew" style="line-height:36px;" />
										
										<p class="sub-ans">Lead time</p>
										<asp:RadioButtonList ID="rblQue4Ans2" runat="server" CssClass="overSizeQue"  RepeatDirection="Horizontal">
											<asp:ListItem Text="<span><span></span></span>Very Satisfied" Value="Very Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Satisfied" Value="Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Neither satisfied or dissatisfied" Value="Neither satisfied or dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Dissatisfied" Value="Dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Very dissatisfied" Value="Very dissatisfied" />
										</asp:RadioButtonList>
										<asp:RequiredFieldValidator ID="rfvQ4Ans2" ControlToValidate="rblQue4Ans2" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Please choose your answer."  ValidationGroup="vgRNew" style="line-height:36px;" />
										
										<p class="sub-ans">Quality</p>
										<asp:RadioButtonList ID="rblQue4Ans3" runat="server" CssClass="overSizeQue"  RepeatDirection="Horizontal">
											<asp:ListItem Text="<span><span></span></span>Very Satisfied" Value="Very Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Satisfied" Value="Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Neither satisfied or dissatisfied" Value="Neither satisfied or dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Dissatisfied" Value="Dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Very dissatisfied" Value="Very dissatisfied" />
										</asp:RadioButtonList>
										<asp:RequiredFieldValidator ID="rfvQ4Ans3" ControlToValidate="rblQue4Ans3" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Please choose your answer."  ValidationGroup="vgRNew" style="line-height:36px;" />
										
										<p class="sub-ans">Product satisfied your requirements</p>
										<asp:RadioButtonList ID="rblQue4Ans4" runat="server" CssClass="overSizeQue"  RepeatDirection="Horizontal">
											<asp:ListItem Text="<span><span></span></span>Very Satisfied" Value="Very Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Satisfied" Value="Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Neither satisfied or dissatisfied" Value="Neither satisfied or dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Dissatisfied" Value="Dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Very dissatisfied" Value="Very dissatisfied" />
										</asp:RadioButtonList>
										<asp:RequiredFieldValidator ID="rfvQ4Ans4" ControlToValidate="rblQue4Ans4" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Please choose your answer."  ValidationGroup="vgRNew" style="line-height:36px;" />
										
										<p class="sub-ans">On-time delivery</p>
										<asp:RadioButtonList ID="rblQue4Ans5" runat="server" CssClass="overSizeQue"  RepeatDirection="Horizontal">
											<asp:ListItem Text="<span><span></span></span>Very Satisfied" Value="Very Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Satisfied" Value="Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Neither satisfied or dissatisfied" Value="Neither satisfied or dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Dissatisfied" Value="Dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Very dissatisfied" Value="Very dissatisfied" />
										</asp:RadioButtonList>
										<asp:RequiredFieldValidator ID="rfvQ4Ans5" ControlToValidate="rblQue4Ans5" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Please choose your answer."  ValidationGroup="vgRNew" style="line-height:36px;" />
										
										<div class="clear"></div>
									</div>
									<div class="type-text">
										<p>Please provide details below:</p>
										<asp:TextBox ID="Que4" runat="server" Rows="7" TextMode="MultiLine" CssClass="surveyTxtbox" />
										<div class="queLimit"><span id="Que4-limit">300</span> word limit</div>
									</div>
									<!-- Question 4 -->
									
									<!-- Question 5 -->
									<div class="question-box">
										<p><strong>5. How satisfied are you with SPEX CertiPrep Sales and Sales Support in the following areas?</strong><br /></p>
										
										<p class="sub-ans">Timeliness of response to your inquiries</p>
										<asp:RadioButtonList ID="rblQue5Ans1" runat="server" CssClass="overSizeQue" RepeatDirection="Horizontal">
											<asp:ListItem Text="<span><span></span></span>Very Satisfied" Value="Very Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Satisfied" Value="Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Neither satisfied or dissatisfied" Value="Neither satisfied or dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Dissatisfied" Value="Dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Very dissatisfied" Value="Very dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>N/A" Value="N/A" />
										</asp:RadioButtonList>
										<asp:RequiredFieldValidator ID="rfvQ5Ans1" ControlToValidate="rblQue5Ans1" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Please choose your answer."  ValidationGroup="vgRNew" style="line-height:36px;" />
										
										<p class="sub-ans">Frequency of contact to stay in touch with you regarding your CRM needs</p>
										<asp:RadioButtonList ID="rblQue5Ans2" runat="server" CssClass="overSizeQue"  RepeatDirection="Horizontal">
											<asp:ListItem Text="<span><span></span></span>Very Satisfied" Value="Very Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Satisfied" Value="Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Neither satisfied or dissatisfied" Value="Neither satisfied or dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Dissatisfied" Value="Dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Very dissatisfied" Value="Very dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>N/A" Value="N/A" />
										</asp:RadioButtonList>
										<asp:RequiredFieldValidator ID="rfvQ5Ans2" ControlToValidate="rblQue5Ans2" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Please choose your answer."  ValidationGroup="vgRNew" style="line-height:36px;" />
										
										<p class="sub-ans">Frequency of contact to provide you information on our new products</p>
										<asp:RadioButtonList ID="rblQue5Ans3" runat="server" CssClass="overSizeQue"  RepeatDirection="Horizontal">
											<asp:ListItem Text="<span><span></span></span>Very Satisfied" Value="Very Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Satisfied" Value="Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Neither satisfied or dissatisfied" Value="Neither satisfied or dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Dissatisfied" Value="Dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Very dissatisfied" Value="Very dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>N/A" Value="N/A" />
										</asp:RadioButtonList>
										<asp:RequiredFieldValidator ID="rfvQ5Ans3" ControlToValidate="rblQue5Ans3" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Please choose your answer."  ValidationGroup="vgRNew" style="line-height:36px;" />
										
										<p class="sub-ans">Product knowledge</p>
										<asp:RadioButtonList ID="rblQue5Ans4" runat="server" CssClass="overSizeQue"  RepeatDirection="Horizontal">
											<asp:ListItem Text="<span><span></span></span>Very Satisfied" Value="Very Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Satisfied" Value="Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Neither satisfied or dissatisfied" Value="Neither satisfied or dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Dissatisfied" Value="Dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Very dissatisfied" Value="Very dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>N/A" Value="N/A" />
										</asp:RadioButtonList>
										<asp:RequiredFieldValidator ID="rfvQ5Ans4" ControlToValidate="rblQue5Ans4" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Please choose your answer."  ValidationGroup="vgRNew" style="line-height:36px;" />
										
										<p class="sub-ans">Understanding your business needs</p>
										<asp:RadioButtonList ID="rblQue5Ans5" runat="server" CssClass="overSizeQue"  RepeatDirection="Horizontal">
											<asp:ListItem Text="<span><span></span></span>Very Satisfied" Value="Very Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Satisfied" Value="Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Neither satisfied or dissatisfied" Value="Neither satisfied or dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Dissatisfied" Value="Dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Very dissatisfied" Value="Very dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>N/A" Value="N/A" />
										</asp:RadioButtonList>
										<asp:RequiredFieldValidator ID="rfvQ5Ans5" ControlToValidate="rblQue5Ans5" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Please choose your answer."  ValidationGroup="vgRNew" style="line-height:36px;" />
										
										<p class="sub-ans">Ability to solve an issue</p>
										<asp:RadioButtonList ID="rblQue5Ans6" runat="server" CssClass="overSizeQue"  RepeatDirection="Horizontal">
											<asp:ListItem Text="<span><span></span></span>Very Satisfied" Value="Very Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Satisfied" Value="Satisfied" />
											<asp:ListItem Text="<span><span></span></span>Neither satisfied or dissatisfied" Value="Neither satisfied or dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Dissatisfied" Value="Dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>Very dissatisfied" Value="Very dissatisfied" />
											<asp:ListItem Text="<span><span></span></span>N/A" Value="N/A" />
										</asp:RadioButtonList>
										<asp:RequiredFieldValidator ID="rfvQ5Ans6" ControlToValidate="rblQue5Ans6" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Please choose your answer."  ValidationGroup="vgRNew" style="line-height:36px;" />
										
										<div class="clear"></div>
									</div>
									<div class="type-text">
										<p>Please provide details below:</p>
										<asp:TextBox ID="Que5" runat="server" Rows="7" TextMode="MultiLine" CssClass="surveyTxtbox" />
										<div class="queLimit"><span id="Que5-limit">300</span> word limit</div>
									</div>
									<!-- Question 5 -->
									
									<!-- Question 6 -->
									<div class="question-box">
										<p><strong>6. How often do you buy from SPEX CertiPrep?</strong><br /></p>
										<asp:RadioButtonList ID="rblQue6" runat="server"  RepeatDirection="Horizontal">
											<asp:ListItem Text="<span><span></span></span>Weekly" Value="Weekly" />
											<asp:ListItem Text="<span><span></span></span>Monthly" Value="Monthly" />
											<asp:ListItem Text="<span><span></span></span>Quarterly" Value="Quarterly" />
											<asp:ListItem Text="<span><span></span></span>Annually" Value="Annually" />
										</asp:RadioButtonList>
										<asp:RequiredFieldValidator ID="rfvQ6" ControlToValidate="rblQue6" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Please choose your answer."  ValidationGroup="vgRNew" style="line-height:36px;" />
										<div class="clear"></div>
									</div>
									<!-- Question 6 -->
									
									<!-- Question 7 -->
									<div class="question-box">
										<p><strong>7. Do you currently purchase from other CRM Manufacturers?</strong><br /></p>
										<asp:RadioButtonList ID="rblQue7" runat="server"  RepeatDirection="Horizontal">
											<asp:ListItem Text="<span><span></span></span>Yes" Value="Yes" />
											<asp:ListItem Text="<span><span></span></span>No" Value="No" />
										</asp:RadioButtonList>
										<asp:RequiredFieldValidator ID="rfvQ7" ControlToValidate="rblQue7" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Please choose your answer."  ValidationGroup="vgRNew" style="line-height:36px;" />
										<div class="clear"></div>
									</div>									
									<!-- Question 7 -->
									
									<!-- Question 8 -->
									<div class="question-box">
										<p><strong>8. Would you consider being part of our Refer a Friend Program and receive an additional one time discount?</strong><br /></p>
										<asp:RadioButtonList ID="rblQue8" runat="server"  RepeatDirection="Horizontal">
											<asp:ListItem Text="<span><span></span></span>Yes" Value="Yes" />
											<asp:ListItem Text="<span><span></span></span>No" Value="No" />
										</asp:RadioButtonList>
										<asp:RequiredFieldValidator ID="rfvQ8" ControlToValidate="rblQue8" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true" Text="Please choose your answer."  ValidationGroup="vgRNew" style="line-height:36px;" />
										<div class="clear"></div>
									</div>									
									<!-- Question 8 -->
									
									<!-- Question 9 -->
									<div class="type-text">
										<p><strong>9. What can we do to improve your experience with SPEX CertiPrep?</strong></p>
										<asp:TextBox ID="Que9" runat="server" Rows="7" TextMode="MultiLine" CssClass="surveyTxtbox" style="height:90px"/>
										<div class="queLimit"><span id="Que9-limit">300</span> word limit</div>
									</div>
									<!-- Question 9 -->
										
									<div class="type-text">
										<p><strong>We truly appreciate your feedback. As a way to say thanks, we will send you a $5 Starbucks gift card. Enjoy your next cup of coffee on us!</strong></p>
									</div>
									<br />
									<div>
										<asp:TextBox ID="FName" placeholder="First Name:*" runat="server" CssClass="surveyTxtbox" />
										<asp:RequiredFieldValidator ID="rfvFName" ControlToValidate="FName" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true"  Text="<br>Please enter your first name." ValidationGroup="vgRNew" />
									</div>
									<div>
										<asp:TextBox ID="LName" placeholder="Last Name:*" runat="server" CssClass="surveyTxtbox" />
										<asp:RequiredFieldValidator ID="rfvLName" ControlToValidate="LName" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true"  Text="<br>Please enter your last name." ValidationGroup="vgRNew" />
									</div>
									<div>
										<asp:TextBox ID="RCompany" placeholder="Company Name:*" runat="server" CssClass="surveyTxtbox" />
										<asp:RequiredFieldValidator ID="rfvRCompany" ControlToValidate="RCompany" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server"   SetFocusOnError="true" Text="<br>Please enter your company name" ValidationGroup="vgRNew" />
									</div>
									<div>
										<asp:TextBox ID="Address" placeholder="Address:*" runat="server" CssClass="surveyTxtbox" />
										<asp:RequiredFieldValidator ID="rfvAddress" ControlToValidate="Address" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server"   SetFocusOnError="true" Text="<br>Please enter your address" ValidationGroup="vgRNew" />
									</div>
									<div>
										<asp:TextBox ID="City" placeholder="City:*" runat="server" CssClass="surveyTxtbox" style="width:39.9%" />
										<span style="color:#9d9d9d">&nbsp;State:*&nbsp;</span><asp:TextBox ID="State" runat="server" CssClass="surveyTxtbox" style="width:10%" />
										<span style="color:#9d9d9d">&nbsp;Zip Code:*&nbsp;</span><asp:TextBox ID="Zip" runat="server" CssClass="surveyTxtbox" style="width:15%" />
										<asp:RequiredFieldValidator ID="rfvRCity" ControlToValidate="City" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server"   SetFocusOnError="true" Text="<br>Please enter your city" ValidationGroup="vgRNew" />
										<asp:RequiredFieldValidator ID="rfvRState" ControlToValidate="State" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server"   SetFocusOnError="true" Text="<br>Please enter your state" ValidationGroup="vgRNew" />
										<asp:RequiredFieldValidator ID="rfvRZip" ControlToValidate="Zip" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server"   SetFocusOnError="true" Text="<br>Please enter your zip code" ValidationGroup="vgRNew" />
									</div>
									<div>
										<asp:TextBox ID="Phone" placeholder="Work Phone Number:*" runat="server" CssClass="surveyTxtbox" />
										<asp:RequiredFieldValidator ID="rfvPhone" ControlToValidate="Phone" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server"   SetFocusOnError="true" Text="<br>Please enter your phone number" ValidationGroup="vgRNew" />
									</div>
									<div>
										<asp:TextBox ID="REmail" placeholder="Email Address:*" runat="server" CssClass="surveyTxtbox" />
										<asp:RequiredFieldValidator ID="rfvREmail" ControlToValidate="REmail" CssClass="formerror" ForeColor="Red" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true"  Text="<br>Please enter your email address" ValidationGroup="vgRNew" />
										<asp:RegularExpressionValidator ID="revREmail" ControlToValidate="REmail" CssClass="formerror" Display="Dynamic" EnableClientScript="true" runat="server" SetFocusOnError="true"  Text="<br>Please enter a valid email address" ValidationGroup="vgRNew" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
									</div>
									<br />
									
									<div class="type-button">
										<asp:Button ID="cmdSubmit" Text="SUBMIT" runat="server" AutoPostBack="false" CssClass="submitbutton" onclick="cmdSubmit_Click" ValidationGroup="vgRNew" />
									</div>
								</asp:View>
								<asp:View ID="vwThank" runat="server">
									<span class="green">Thank you!  Your request for a Application Help was sent successfully.  You should be receiving a Reply shortly.</span>
								</asp:View>
							</asp:MultiView>
						</div>
                    </div>
                    <div id="ie_clearing"> &#160; </div>
                </div>
				<div style="clear:both"></div>
            </div>
	<asp:SqlDataSource ID='dataProducts' runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" ProviderName="<%$ ConnectionStrings:SPEXCertiPrep.ProviderName %>"
	SelectCommand="SELECT cfFamily FROM cp_roi_Families ORDER BY cfID" SelectCommandType="Text">
	</asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script>
		$(document).ready(function(){
			$(".ratestar").mouseover(function() {
				var rate = $(this).data("rate");
				$(".ratestar").each(function(){
					if ($(this).data("rate") <= rate) {
						$(this).css("background-position", "-3px -1px");
					}
				});
			});
			
			$(".ratestar").mouseout(function() {
				$(".ratestar").removeAttr("style");
			});
			
			$(".ratestar").click(function() {
				if ($(this).hasClass("ratestar-select")) {
					$(".ratestar").each(function() {
						$(this).removeClass("ratestar-select");
					});
					rate = $(this).data("rate");
					rateScoring(rate);
				}else {
					var rate = $(this).data("rate");
					rateScoring(rate);
				}
			});
			
			function rateScoring(rate) {
				$(".ratestar").each(function() {
					$(this).removeClass("ratestar-select");
					if ($(this).data("rate") <= rate) {
						$(this).addClass("ratestar-select");
					}
				});
				$("#RateScore").val(rate);
			}
			
			var maxWords = 300;
			$('textarea').keypress(function() {
				var $this, wordcount, temp;
				$this = $(this);
				wordcount = $this.val().split(/\b[\s,\.-:;]*/).length;
				if (wordcount > maxWords) {
					return false;
				} else {
					temp = $("#" + $(this).attr("id") + "-limit").text(maxWords - wordcount);	
					return temp;					
				}
				if (temp < (maxWords - wordcount)) { 
					temp = $("#" + $(this).attr("id") + "-limit").text(maxWords + wordcount);
					return temp;
				}
				
			});

			$('textarea').change(function() {
				var words = $(this).val().split(/\b[\s,\.-:;]*/);
				if (words.length > maxWords) {
					//words.splice(maxWords);
					//$(this).val(words.join(""));
					//alert("You've reached the maximum allowed words. Extra words removed.");
					
				}
			});
		});
	</script>
</asp:Content>


