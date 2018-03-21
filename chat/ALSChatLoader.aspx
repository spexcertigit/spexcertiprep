<!--#include file="incSystem.aspx" -->
<script runat="server">
dim userrating as string=""
dim useraction as integer=0
dim newmessage as string=""
dim userpage as string=""
dim soundstatus as string=""
dim lastmsgdate as string=""
	
sub page_load()
	call nocache()
	response.contenttype="text/html"
	dim requestid as string=request("requestid")
	dim logindate as string=todaydatetime
	soundstatus=getcookie("xlaALSsoundstatus") 
	
	if requestid="" then 
		response.write("<scr" & "ipt language=JavaScript>alert('An Error Ocurred');top.close();</scr" &"ipt>")
		response.end()
	end if
	
	lastmsgdate=getcookie("ALSRoomlastmsgdate" & requestid)
	
	'//// retrieve latest messages ///'
	dim roomisclosed as boolean=false
	dim lastusrping as string=""
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand
	mycommand.connection = conn
	dim dr as SqlDataReader
	mycommand.commandtext = "xlaALSsp_reps_chat_loader"
	mycommand.CommandType = CommandType.StoredProcedure
	mycommand.Parameters.Add( "@requestid" , requestid )
	mycommand.Parameters.Add( "@lastrepping" , todaydatetime )
	conn.open()
	dr = mycommand.ExecuteReader()
	if dr.read()
		'/// Room is open, retrieve values ///'
		newmessage=preparemsg(dr("usr_msgs"))
		userrating=dr("usr_rating")
		useraction=dr("usr_action")
		userpage=dr("usr_page")
		lastusrping=dr("lastusrping")
		if not(isdate(lastusrping)) then lastusrping=todaydatetime
		setcookie("ALSRoomlastmsgdate" & requestid,logindate)
		if dr("rstatus")=2 then roomisclosed=true
	end if
	dr.close()
	conn.close()

	'/// Is the room closed or the rep has left ? ///'
	if not(roomisclosed) and datediff("s",lastusrping,todaydatetime)>(appsettings.refreshrate*4) then 
		call endsession(requestid)
		roomisclosed=true
	end if
	
	
	'/// Is the Room Closed ///'
	if roomisclosed and lastmsgdate<>"" then
		response.write("<scr" & "ipt language=JavaScript>if (top.chattop) parent.logo.timeout();</scr" &"ipt>")
		response.end()
	end if

	'/// A Timeout has ocurred ? ///'
	if lastmsgdate<>"" and isdate(lastmsgdate) then
		if datediff("n",lastmsgdate,logindate)>appsettings.usertimeout then
			response.write("<scr" & "ipt language=JavaScript>if (top.chattop) parent.logo.timeout();</sc" &"ript>")
			response.end()
		end if
	end if
	setcookie("ALSRoomlastmsgdate" & requestid,logindate)
	
end sub

</script>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=windows-1256">
<script language="JavaScript">

// Error Handling
window.onerror = donothing;
function donothing(){
	return true;
}

function playnotify(){
	<%if appsettings.playnotify<>"" and soundstatus="on" or soundstatus="" then%>document.write("<bgsound src='files/notify.au'>");<%end if%>
}
</script>
<%
	'/// User rating : The user rated the session ///'
	if appsettings.allowrating<>"" and userrating<>0 then response.write("<scr" & "ipt language=JavaScript>if (top.chattext) parent.text.rating(" & userrating & ");</scr" & "ipt>")
	
	'//// User Action (Is he typing?) ///'
	if useraction=1 then response.write("<scr" & "ipt language=JavaScript>if (top.chattext) parent.text.document.all.useraction.innerHTML='User is typing...';</sc" & "ript>") else response.write("<scr" & "ipt language=JavaScript>if (top.chattext) parent.text.document.all.useraction.innerHTML='';</scr" & "ipt>")
	
	'/// New Message ///'
	if newmessage<>"" then response.write("<scr" & "ipt language=JavaScript>top.chat.displaymessage('" & newmessage & "');playnotify();</sc" & "ript>")

	
	'/// New User Page ///'
	if userpage<>"" then response.write("<scr" & "ipt language=JavaScript>if (top.chattext) parent.text.setfootstep('" & userpage & "');</scr" & "ipt>")
%>
<script language="JavaScript">
function refresh(){
	window.location.reload(true);
}

setTimeout( "refresh()", <%=appsettings.refreshrate*1000%> );
</script>