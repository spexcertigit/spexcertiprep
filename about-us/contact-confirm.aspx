<%@ Import Namespace="System.Web.Mail" %> 
<% @Page Language="VB" aspcompat="true" debug="true" Explicit="false" enableSessionState="true" %>
<!-- #include file="../inc/conn.aspx" -->
<!-- #include file="../inc/login_handler.aspx" -->
<%
FirstName = Trim(Request.Form("first_name"))
LastName = Trim(Request.Form("last_name"))
sTitle = Trim(Request.Form("title"))
CompanyName = Trim(Request.Form("company_name"))
CompanyAddress = Trim(Request.Form("company_address"))
City = Trim(Request.Form("city"))
Region = Trim(Request.Form("state_region"))
Zip = Trim(Request.Form("zip"))
Country = Trim(Request.Form("country"))
phone = Trim(Request.Form("phone_number"))
CustomerMail = Trim(Request.Form("email"))
Inquiry = Trim(Request.Form("inquiry"))


Dim obj As System.Web.Mail.SmtpMail
Dim Mailmsg As New System.Web.Mail.MailMessage()
obj.SmtpServer = "127.0.0.1"
'Mailmsg.To = "emeghdir@bnoinc.com"
Mailmsg.To = "peskow@spexcsp.com;crmsales@spexcsp.com"
'Mailmsg.Bcc = "emeghdir@baldwinandobenauf.com"
Mailmsg.From = "SPEX CertiPrep Contact <contact@spexcsp.com>"
Mailmsg.BodyFormat = MailFormat.Html
Mailmsg.Subject = "Contact Request from SPEX CertiPrep"
Mailmsg.Body = Mailmsg.Body & "Contact name: " & FirstName & " " & LastName & "<br>"
Mailmsg.Body = Mailmsg.Body & "Job Title: " & sTitle & "<br>"
Mailmsg.Body = Mailmsg.Body & "Company Name: " & CompanyName & "<br>"
Mailmsg.Body = Mailmsg.Body & "Address: " & CompanyAddress & ", " & City & ", " & Region & ", " & zip & ", " & Country & "<br>"
Mailmsg.Body = Mailmsg.Body & "Phone: " & Phone & "<br>"
Mailmsg.Body = Mailmsg.Body & "Email: " & CustomerMail & "<br>"
Mailmsg.Body = Mailmsg.Body & "Inquiry: " & Inquiry & "<br>"
Mailmsg.Body = Mailmsg.Body & "<br>Thank you, <br>The spexcsp.com Mailbot"
obj.Send(Mailmsg)
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="icon" type="image/x-icon" href="../favicon_CP.ico" ><link rel="shortcut icon" href="../favicon_CP.ico"><link rel="icon" type="image/ico" href="../favicon_CP.ico">
<title>SPEX CertiPrep - About Us - Contact Us</title>
<link rel="stylesheet" href="../inc/common.css" type="text/css" />
<!--[if gte IE 8]>
<link rel="stylesheet" href="../inc/ie.css" type="text/css" />
<![endif]-->
<!--[if lte IE 7]>
<link rel="stylesheet" href="../inc/ie7.css" type="text/css" />
<![endif]-->
<!-- #include file="../inc/scripts_sub.aspx" -->
<script type="text/javascript" src="../inc/jquery.form.js"></script>
<script type="text/javascript" src="../inc/jquery.validate.js"></script>
<script>
   $(document).ready(function() {
        $("#contact_us").validate({
            submitHandler: function(form) {
                jQuery(form).ajaxSubmit({
                    target: "#submitted"
                });
            }
        });
    });

</script>


<!-- #include file="../inc/google_analytics.aspx" -->
</head>
<body>
<div id="container">
  <!--begin header-->
  <!-- #include file="../inc/header_sub.aspx" -->
  <!--end header-->
  <div id="content">
    <div id="content_main">
      <!-- begin content for 2-column generic content page -->
      <div id="gencontent_header">
        <h1>Contact Us</h1>
      </div>
      <div id="gencontent_left">
        <img src="../images/page-photos/certi_tempimage_29.jpg" alt="Your science is our passion" width="240" height="240" />	  </div>
	  <div id="gencontent_right">
		<h2>Thank You</h2>
		  <p>Your message has been sent and someone from SPEX CertiPrep will be contacting you shortly.</p>
	  </div>
       <div class="bottompad">
        </div>
      <!-- end generic content page -->
    </div>
  </div>
  <div class="clearfooter"></div>
</div>
<div id="fixed_footer">
  <div id="footer_content">
<!-- #include file="../inc/orderbar_sub.aspx" -->
    </div>
</div>
<script type="text/javascript">
//<![CDATA[
/* Replacement calls. Please see documentation for more information. */

if(typeof sIFR == "function"){
	sIFR.replaceElement(named({sSelector:"#nav #menu li.menuitem", sFlashSrc:"../sifr/rotis_small.swf", sColor:"#ffffff", sLinkColor:"#ececec", sBgColor:"#5a5b5d", sHoverColor:"#cce042", sWmode: "transparent", nPaddingTop:7, nPaddingBottom:3, sFlashVars:"textalign=left&offsetTop=0"}));
	 
};

//-->
</script>
</body>
</html>
