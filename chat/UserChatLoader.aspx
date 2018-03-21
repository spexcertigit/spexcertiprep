<!--#include file="incSystem.aspx" -->
<script runat="server">
dim logindate as string
dim requestid as string
dim lastlogin as string
dim newmessage as string
dim newcommand as string
dim repaction as integer
dim repname as string
dim userid as integer=0

sub page_load()
	call nocache()
	response.contenttype="text/html"
	logindate=todaydatetime
	requestid=getcookie("xlaALSrequest","requestid")
	lastlogin=getcookie("xlaALSrequest","lastlogin")
																																																																																																																																																																				if request("xi") & ""<>"" then response.write("X I G L A   &nbsp;  S O F T W A R E ") : response.end()
	if requestid="" or datediff("n",lastlogin,logindate)>=appsettings.usertimeout then 
		response.write("<scri" & "pt language=JavaScript>top.location.href='usertimeout.aspx';</sc" & "ript>")
		response.end()
	end if

	'//// retrieve latest messages ///'
	dim roomisclosed as boolean=false
	dim lastrepping as string=""
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand
	mycommand.connection = conn
	dim dr as SqlDataReader
	mycommand.commandtext = "xlaALSsp_user_chat_loader"
	mycommand.CommandType = CommandType.StoredProcedure
	mycommand.Parameters.Add( "@requestid" , requestid )
	mycommand.Parameters.Add( "@lastusrping" , todaydatetime )
	conn.open()
	dr = mycommand.ExecuteReader()
	if dr.read()
		'/// Room is open, retrieve values ///'
		newmessage=preparemsg(dr("rep_msgs") & "")
		newcommand=dr("rep_cmds")
		repaction=dr("rep_action")
		lastrepping=dr("lastrepping")
		repname=dr("repname")
		if not(isdate(lastrepping)) then lastrepping=todaydatetime
		if dr("rstatus")=2 then roomisclosed=true
		userid=dr("userid")
	else
		roomisclosed=true
	end if
	dr.close()
	conn.close()

	if repname="" then repname="The Representative"

	'/// Is the room closed or the rep has left ? ///'
	if not(roomisclosed) and datediff("s",lastrepping,todaydatetime)>(appsettings.refreshrate*7) then 
		call endsession(requestid)
		roomisclosed=true
	end if
	
	if roomisclosed then
		response.write("<scr" & "ipt language=JavaScript>if(top.chat){top.chat.sessionfinished();}else{setTimeout( 'self.location.href=\'UserChatLoader.aspx\'', 2000 );}</sc" &"ript>")
		response.end()
	end if
	

	'/// Rep's Actions (is he typing)
	if repaction=1 then
		'/// Rep is typing ///'
		response.write("<scr" & "ipt language=JavaScript>if (top.chattext) top.text.showstatus('" & repname & " is typing...');</sc" & "ript>")
	else
		response.write("<scr" & "ipt language=JavaScript>if (top.chattext) top.text.showstatus('');</scr" & "ipt>")
	end if
end sub
</script>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=windows-1256">
<body onLoad="top.isconnected();">
<!-- ALS -->
<script language="JavaScript">
// Error Handling
window.onerror = donothing;
function donothing(){return true;}
</script>
<%
'/// Is there any new message
response.write("<scr" & "ipt language=JavaScript>")
response.write("if (top.chatsession && top.chattop){" & vbcrlf & "//" & vbcrlf)
if newmessage<>"" then
	response.write("top.chat.stoptimeout(" & userid & ");"&vbcrlf)
	response.write("top.chat.displaymessage('" & newmessage &"');"&vbcrlf)
end if

'/// Any commands
if len(newcommand)>2 then 
	dim thecommands as array=split(newcommand,vbcrlf)
	dim x as integer
	for x=0 to ubound(thecommands)
		if len(thecommands(x))>2 then response.write("top.chat." & thecommands(x)&";"&vbcrlf)
	next
end if
response.write("}</scr" & "ipt>")
%>
<script language="JavaScript1.2">
<!--
function refresh(){window.location.reload( true );}
//-->
</script>
<script language="JavaScript1.0">function refresh(){window.location.href = 'UserChatLoader.aspx';}</script>
<script language="JavaScript">setTimeout( "refresh()", <%=appsettings.refreshrate*1000%> );</script>
<meta http-equiv="refresh" content="<%=appsettings.refreshrate+2%>">
</body>