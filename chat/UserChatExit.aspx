<!--#include file="incSystem.aspx" -->
<script runat="server">
dim currentrating as string=""

function getrating(what as integer) as string
	select case what
		case 5
			getrating="5 - Excellent"
		case 4
			getrating="4 - Good"
		case 3
			getrating="3 - Fair"
		case 2
			getrating="2 - Poor"
		case 1
			getrating="1 - Really Bad"
		case else
			getrating=""
	end select
end function

sub page_load()
	dim requestid as string=getcookie("xlaALSrequest","requestid")
	dim ip as string=request.ServerVariables("REMOTE_ADDR")
	dim busy as string=request("busy")
	dim rating as integer=0
	
	'/// Exit Room ///
	if requestid<>"" then call endsession(requestid)

	'/// Update User Action
	if busy="" then
		call updatevisitoraction(ip,3,"Left chat session")
	else
		call updatevisitoraction(ip,4,"All representatives were busy")
	end if
	if busy<>"" or appsettings.allowcomments="" then
		response.write("<scr" & "ipt language=JavaScript>top.close();</sc" & "ript>")
		response.end
	elseif requestid<>"" and isnumeric(requestid) then
		'/// Load Current Ratings for Survey ///'
		dim conn as New SqlConnection(connectionstr)
		dim mycommand as New SqlCommand
		mycommand.connection = conn
		mycommand.commandtext = "xlaALSsp_get_rating"
		mycommand.CommandType = CommandType.StoredProcedure
		mycommand.Parameters.Add( "@requestid" ,requestid)
		conn.open()
		currentrating=getrating(mycommand.executescalar())
		conn.close()
		if currentrating<>"" then
			rowSessionrating.visible=false
			rowCurrentrating.visible=true
		else
			rowSessionrating.visible=true
			rowCurrentrating.visible=false
		end if
		
		if appsettings.allowrating="" then 
			rowsessionrating.visible=false
			rowCurrentrating.visible=false
		end if
		
		if appsettings.allowcomments="" then rowSessioncomments.visible=false
	end if
end sub



</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title><%=appsettings.chattitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="styles.css" rel="stylesheet" type="text/css">
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" rightmargin="0" bottommargin="0">
<form name="form1" method="post" action="UserChatComments.aspx">
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr> 
      <td class="FrameBackground"><a href="<%=appsettings.siteurl%>" target="_blank"><img src="files/logo.gif" vspace="4" hspace="12" border="0"></a></td>
    </tr>
  </table>
  <table width="96%" border="0" align="center" cellpadding="2" cellspacing="2">
    <tr> 
      <td class="usertext"><b>In order to help us improve, please let us know 
        the following :</b></td>
    </tr>
    <tr> 
      <td class="Text"> <hr></td>
    </tr>
    <!-- PLEASE DO NOT MODIFY : BELOW -->
    <tr runat="server" id="rowCurrentrating"> 
      <td class="Text"><b>You rated this session as <%=currentrating%></b></td>
    </tr>
    <tr> 
      <td class="Text" id="rowSessionrating" runat="server"> <p><b>How would you 
          rate your support session ?</b><br>
          <input type="radio" name="_rating" value="5">
          <%=getrating(5)%><br>
          <input type="radio" name="_rating" value="4">
          <%=getrating(4)%><br>
          <input type="radio" name="_rating" value="3">
          <%=getrating(3)%><br>
          <input type="radio" name="_rating" value="2">
          <%=getrating(2)%><br>
          <input type="radio" name="_rating" value="1">
          <%=getrating(1)%></td>
    </tr>
    <tr> 
      <td class="Text"> 
        <!-- You can add here any number of form fields to create your own custom survey -->
        <p><b><font color="#FF0000">You can add here any number of form fields 
          to create your own custom survey</font></b><br>
          Your name :<br>
          <input name="Name" type="text" id="Name">
          <br>
          <br>
          Would you like us to contact you by phone :<br>
          <input type="radio" name="contact by phone" value="no">
          No 
          <input type="radio" name="contact by phone" value="yes">
          Yes - Phone : 
          <input name="phone number" type="text" id="phone number">
        </p>
        </td>
    </tr>
    <tr id="rowSessioncomments" runat="server"> 
      <td class="Text"><br>
        <b>Let us know your thoughts about the support session?</b><br> 
        <textarea name="_comments" rows="4" id="textarea2" style="width:90%;"></textarea> 
      </td>
    </tr>
    <tr> 
      <td align="right"><hr> <input name="_button" type="submit" class="FormField" id="_button" value="Submit &raquo;"></td>
    </tr>
  </table>
</form>
</body>
</html>

