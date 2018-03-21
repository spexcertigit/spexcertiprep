<!--#include file="incSystem.aspx" -->
<script runat="server">
dim currentrating as string=""
dim requestid as string
dim rating as string=""
dim byemsg as string=""

sub page_load()
	rating=request("rating")
	requestid=getcookie("xlaALSrequest","requestid")
	if rating<>"" and isnumeric(rating) then call ratesession()
	if currentrating="" then currentrating="-- Rate Support --"
	if appsettings.byemsg<>"" then byemsg="alert(" & chr(34) & appsettings.byemsg & chr(34) & ");"
	if appsettings.allowemailchat<>"" then lnkSendbymail.visible=true else lnkSendbymail.visible=false
end sub

sub ratesession()
	'/// Rate session ///'
	if rating>"0" and rating<"6" then
		dim conn as New SqlConnection(connectionstr)
		dim mycommand as New SqlCommand("xlaALSsp_rate_session",conn)
		mycommand.commandType =  CommandType.Storedprocedure
		mycommand.Parameters.Add( "@requestid" , requestid )
		mycommand.Parameters.Add( "@rating" , rating)
		conn.open()
		mycommand.executenonquery()
		conn.close()
		currentrating="Session Rating : " & rating
	end if
end sub
</script>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=windows-1256">
<link rel="stylesheet" href="styles.css" type="text/css">
<script language="JavaScript" src="disablerc.js"></script>
<script language="JavaScript">
<!--
// Error Handling
window.onerror = donothing;
function donothing(){return true;}

function rate(){if (document.form1.rating.value!='') document.form1.submit();}

function closession(){
	if (confirm('Close This Window and Leave the session?')){
		<%=byemsg%>
		top.close();
		}
}

function sendbymail(){
	top.chat.sendbymail2();
}

function leavemsg(){
	if (confirm('Would you like to leave a message and close the session?')){
	<%if appsettings.contactform="" then response.write("top.chat.leavemessage();") else response.write("window.open('" & appsettings.contactform & "');top.close();")%>
	}
}

function printchat(){
	top.chat.focus();
	top.chat.print();
}
//-->
</script>
<body leftmargin="0" rightmargin="0" topmargin="0" class="FrameBackground" onload="javascript:top.chattop=true;">
<form name="form1" id="form1" method="post" style="margin:0">
<table width="96%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr><td><img src="files/logo.gif" vspace="4"></td>
    <td align="center" width="160">
	<%if appsettings.allowrating<>"" then%>
	<select name="rating" onchange="javascript:rate();" class="FormField">
	<option value=""><%=currentrating%></option>
	<option value="5">5 - Excellent</option>
	<option value="4">4 - Good</option>
	<option value="3">3 - Fair</option>
	<option value="2">2 - Poor</option>
	<option value="1">1 - Really Bad</option>
  </select>
  <%end if%>
    </td>
      <td align="right" width="100"><a href="javascript:sendbymail();" id="lnkSendbymail" runat="server"><img src="images/btnEmail.gif" width="27" height="27" vspace="4" hspace="1" alt="Send chat transcript by e-mail" border="0"></a><a href="javascript:parent.chat.focus();window.print()"></a><a href="javascript:printchat();"><img src="images/btnPrint.gif" width="27" height="27" vspace="4" hspace="1" alt="Print Session Transcript" border="0"></a><a href="javascript:closession();"><img src="images/btnKill.gif" width="27" height="27" border="0" vspace="4" hspace="1" alt="Close Window"></a></td>
    </tr>
</table>
</form>
</body>