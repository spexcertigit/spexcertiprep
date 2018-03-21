<!--#include file="incSystem.aspx" -->
<script runat="server">
dim name as string=""
dim email as string=""
dim optfield1 as string = ""
dim optfield2 as string = ""
dim optfield3 as string = ""
dim requestid as string=""
dim ip as string=""
dim busy as string=""
dim topic as string=""
dim deptid as string=""
dim userid as string=""
dim message as string=""
dim emailsent as boolean=false
dim errormsg as boolean=false
dim logo as string = ""



sub page_load()
	if not(ispostback) then
		'/// Use contact Form
		if appsettings.contactform<>"" then
			response.write("<scr" & "ipt language=JavaScript>alert('Live support is currently unavailable\nPlease use our contact form to leave a message');if (!opener.closed){opener.location.href='" & appsettings.contactform & "'} else {window.open('" & appsettings.contactform & "');};self.close();</sc" &"ript>")
			response.end ()
		end if
		
		txtName.text=getcookie("xlaALSuser","name")
		txtEmail.text=getcookie("xlaALSuser","email")
		txtOptfield1.text=getcookie("xlaALSuser","optfield1")
		txtOptfield2.text=getcookie("xlaALSuser","optfield2")
		txtOptfield3.text=getcookie("xlaALSuser","optfield3")
		txtTopic.text=getcookie("xlaALSrequest","topic")

		requestid=request("requestid")
		busy=request("busy")
		userid=request("userid")
		deptid=request("deptid")
		
		viewstate("requestid")=requestid
		viewstate("ip")=request.ServerVariables("REMOTE_ADDR")
		viewstate("busy")=busy
	

		if userid<>"" and userid<>"0" then viewstate("userid")=userid
		if deptid<>"" and deptid<>"0" then viewstate("deptid")=deptid
		
		'/// Fill Departments ///'
		''if (userid="0" or userid="") and (deptid="" or deptid="0") then
			dim conn as New SqlConnection(connectionstr)
			dim mycommand as New SqlCommand
			mycommand.connection = conn
			dim dr as SqlDataReader
			mycommand.commandtext = "xlaALSsp_userform_list_depts"
			mycommand.CommandType = CommandType.StoredProcedure
			mycommand.Parameters.Add("@deptid", "0")
			mycommand.Parameters.Add("@userid","0")
			conn.open()
			dr = mycommand.ExecuteReader()
			do while dr.read
				filllistbox(ddlDeptid, dr("deptname"), dr("deptid") , deptid)
			loop
			dr.close()
			conn.close()
		''end if
		
		'/// Hide Required Fields ///'
		if appsettings.optfield1="" then optfield1row.visible=false
		if appsettings.optfield2="" then optfield2row.visible=false
		if appsettings.optfield3="" then optfield3row.visible=false
		
		if appsettings.optfield1req<>"" then reqOptfield1.enabled=true
		if appsettings.optfield2req<>"" then reqOptfield2.enabled=true
		if appsettings.optfield3req<>"" then reqOptfield3.enabled=true
	
	end if
	if deptID = "1" then
		logo = "certiprep_logo.png"
	elseif deptID = "2" then
		logo = "sampleprep_logo.png"
	elseif deptID = "4" then
		logo = "certiprep_logo.png"
	elseif deptID = "5" then
		logo = "sampleprep_logo.png"
	elseif deptID = "6" then
		logo = "criminalistics_logo.png"
	end if
end sub

sub button_click(s as object,e as eventargs)
	if page.isvalid() then
		name=txtName.text
		email=txtEmail.text
		optfield1=txtOptfield1.text
		optfield2=txtOptfield2.text
		optfield3=txtOptfield3.text
		topic=txttopic.text
		message=txtMessage.text
		userid=viewstate("userid")
		if userid="" then userid="0"
		deptid=listboxresults(ddlDeptid,"0")
		if deptid="0" then deptid=viewstate("deptid")
		if deptid="" then deptid="0"

		'/// Update Cookie
		setcookie("xlaALSuser","name",name)
		setcookie("xlaALSuser","email",email)
		setcookie("xlaALSuser","optfield1",optfield1)
		setcookie("xlaALSuser","optfield2",optfield2)
		setcookie("xlaALSuser","optfield3",optfield3)
		persistcookie("xlaALSuser")
		
		'/// Prepare Message
		dim msg as string
		msg=msg & "Received : " & todaydatetime & vbcrlf
		msg=msg & topic & vbcrlf
		if requestid<>"" then msg=msg & "Request ID # " & requestid & vbcrlf
		msg=msg & "________________________________________" & vbcrlf
		msg=msg & "Subject : " & topic & vbcrlf
		msg=msg & "Name : " & name & vbcrlf
		msg=msg & "E-Mail : " & email & vbcrlf
	
		'/// Add optional fields ///'
		if appsettings.optfield1<>"" then msg=msg & appsettings.optfield1 & " : " & optfield1 & vbcrlf
		if appsettings.optfield2<>"" then msg=msg & appsettings.optfield2 & " : " & optfield2 & vbcrlf
		if appsettings.optfield3<>"" then msg=msg & appsettings.optfield3 & " : " & optfield3 & vbcrlf
		
		msg=msg & "Message : " & message

		'/// Get Department's E-mail
		dim conn as New SqlConnection(connectionstr)
		dim mycommand as New SqlCommand
		dim targetemail as string=""
		mycommand.connection = conn
		dim dr as SqlDataReader
		mycommand.commandtext = "xlaALSsp_userform_list_depts"
		mycommand.CommandType = CommandType.StoredProcedure
		mycommand.Parameters.Add( "@deptid" , deptid)
		mycommand.Parameters.Add( "@userid" , userid)
		conn.open()
		dr = mycommand.ExecuteReader()
		if dr.read() then targetemail=dr("email")
		dr.close()
		conn.close()
		
		'/// Update Action //'
		if busy<>"" then
			call updatevisitoraction(ip,4,"Left a message : All representatives were busy")
		elseif requestid="" then
			call updatevisitoraction(ip,4,"Left a message : All representatives were Offline")
		else
			call updatevisitoraction(ip,3,"Left chat session and sent a message")
		end if
		
		'/// Send E-Mail //'
		try
			call sendmail(targetemail,email,appsettings.subject & " (" & topic & ")",msg)
		catch
			response.write("<sc" & "ript language=JavaSc" &"ript>alert('The message could not be sent :\nAn Error has occurred while trying to send an e-mail from this application\nPlease check the SMTP Server configuration settings or contact the system administrator');history.back()</sc" &"ript>")
		end try
		emailsent=true
	else
		errormsg=true
	end if
end sub
</script>

<html>
<head>
<title><%=appsettings.chattitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="styles.css" type="text/css">
<!-- script language="JavaScript" src="disablerc.js"></script -->
</head>
<body leftmargin="0" rightmargin="0" topmargin="10" class="FrameBackground">
<form name="form1" method="post" action="UserForm.aspx" runat="server">
  <table width="96%" border="0" align="center" cellpadding="0" cellspacing="1">
    <tr> 
      <td><img src="files/<%=logo%>" border="0" hspace="12"></td>
    </tr>
    <tr> 
      <td height="10"></td>
    </tr>
    <tr align="left" valign="top"> 
      <td><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr> 
            <td width="6" height="6"><img src="images/c1.gif" width="6" height="6"></td>
            <td height="6" background="images/c2.gif"><img src="images/c2.gif" width="3" height="6"></td>
            <td width="6" height="6"><img src="images/c3.gif" width="6" height="6"></td>
          </tr>
          <tr> 
            <td background="images/c5.gif"><img src="images/c5.gif" width="6" height="2"></td>
            <td align="left" valign="top" class="ChatBackground"><table width="98%" border="0" cellpadding="2" cellspacing="1" class="Text">
                <%if not(emailsent) then
	if busy<>"" then%>
                <tr> 
                  <td colspan="2"><b>Our representatives are currently unavailable</b></td>
                </tr>
                <%end if%>
                <tr> 
                  <td colspan="2">Please fill this form to leave a message 
                    (* Denotes required field)</td>
                </tr>
                <%if errormsg then%>
                <tr> 
                  <td colspan="2" class="ErrorText">Please provide a name, an 
                    e-mail an a message</td>
                </tr>
                <tr> 
                  <td colspan="2">&nbsp;</td>
                </tr>
                <%end if%>
                <tr valign="top"> 
                  <td width="25%" align="left">Your Name :</td>
                  <td align="left"> <asp:textbox Columns="40" ID="txtName" CssClass="FormField" MaxLength="250" runat="server" Width="80%" />
                    * 
                    <asp:requiredfieldvalidator ControlToValidate="txtName" id="reqName" runat="server" Enabled="true"  /></td>
                </tr>
                <tr valign="top"> 
                  <td  width="25%" align="left">Your E-Mail :</td>
                  <td align="left"> <asp:textbox Columns="40" ID="txtEmail" CssClass="FormField" MaxLength="250" runat="server" Width="80%" />
                    * 
                    <asp:requiredfieldvalidator ControlToValidate="txtEmail" id="reqEmail" runat="server" Enabled="true"  /></td>
                </tr>
                <tr valign="top"> 
                  <td width="25%" align="left">Subject :</td>
                  <td align="left"> <asp:textbox Columns="40" ID="txttopic" CssClass="FormField" MaxLength="250" runat="server" Width="80%" /> 
                  </td>
                </tr>
                <tr id="optfield1row" runat="server"> 
                  <td width="25%" ><%=appsettings.optfield1%> :</td>
                  <td> <asp:textbox runat="server" id="txtOptfield1" CssClass="FormField" MaxLength="255" Columns="40" width="80%" /> 
                    <asp:requiredfieldvalidator ControlToValidate="txtOptfield1" id="reqOptfield1" runat="server" Enabled="false"  /> 
                  </td>
                </tr>
                <tr id="optfield2row" runat="server"> 
                  <td width="25%" ><%=appsettings.optfield2%> :</td>
                  <td> <asp:textbox runat="server" id="txtOptfield2" CssClass="FormField" MaxLength="255" Columns="40" width="80%" /> 
                    <asp:requiredfieldvalidator ControlToValidate="txtOptfield2" id="reqOptfield2" runat="server" Enabled="false"  /> 
                  </td>
                </tr>
                <tr id="optfield3row" runat="server"> 
                  <td width="25%" ><%=appsettings.optfield3%> :</td>
                  <td> <asp:textbox runat="server" id="txtOptfield3" CssClass="FormField" MaxLength="255" Columns="40" width="80%" /> 
                    <asp:requiredfieldvalidator ControlToValidate="txtOptfield3" id="reqOptfield3" runat="server" Enabled="false"  /> 
                  </td>
                </tr>
                <%if userid="" then%>
                <tr valign="top"> 
                  <td width="25%" align="left"></td>
                  <td align="left"> <asp:dropdownlist ID="ddlDeptid" runat="server" Visible="false" /> 
                  </td>
                </tr>
                <%end if%>
                <tr valign="top"> 
                  <td width="25%" align="left">Message : </td>
                  <td align="left"> <asp:textbox Columns="40" ID="txtMessage" Rows="5"  TextMode="MultiLine" CssClass="FormField" runat="server" Width="80%" />
                    * 
                    <asp:requiredfieldvalidator ControlToValidate="txtMessage" id="reqMessage" runat="server" Enabled="true"  /></td>
                </tr>
                <tr valign="top">
                  <td align="left">&nbsp;</td>
                  <td align="left"><input type="button" value="Close Window" class="FormField" onClick="javascript:window.close();"> 
                    <asp:button id="btnButton" Text="Send Message >>" CssClass="FormField" OnClick="button_click" runat="server" /></td>
                </tr>
                <tr align="center"> 
                  <td colspan="2"><asp:validationsummary ID="validSummary" ShowMessageBox="true" runat="server" HeaderText="Please provide your name, e-mail and a message" CssClass="ErrorText" ShowSummary="false" /> 
                  </td>
                </tr>
                <%else%>
                <tr align="center"> 
                  <td height="300" colspan="2"> <span class="usertext"><b>Thanks!</b><br>
                    </span> Your Message Has been sent.<br>
                    One of our representatives will contact you soon.<br> <input type="button" value="Close Window" class="FormField" onClick="javascript:window.close();"> 
                  </td>
                </tr>
                <%end if%>
              </table></td>
            <td background="images/c6.gif"><img src="images/c6.gif" width="6" height="2"></td>
          </tr>
          <tr> 
            <td width="6" height="6"><img src="images/c7.gif" width="6" height="6"></td>
            <td height="6" background="images/c8.gif"><img src="images/c8.gif" width="3" height="6"></td>
            <td width="6" height="6"><img src="images/c9.gif" width="6" height="6"></td>
          </tr>
        </table></td>
    </tr>
  </table>

</form>
</body>
</html>