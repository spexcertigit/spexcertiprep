<!--#include file="incSystem.aspx" -->
<script runat="server">
dim requestid as string=""
dim name as string=""
dim deptname as string=""
dim topic as string=""
dim userid as string=""
dim nick as string=""
dim ip as string=""
dim firstmsg as string=""
dim newmsg as string=""
dim newmsg2 as string=""
dim email as string=""

sub page_load()
	'/// Retrieve Info'
	requestid=request("requestid")
	name=request("name")
	deptname=request("deptname")
	if deptname="" then deptname=appsettings.defaultdeptname
	email=request("email")
	topic=request("topic")
	userid=getusrid
	if userid="" then response.redirect("Logout.aspx")
	nick=getnick
	ip=request("ip")
	
	'/// Prepare Welcome Message'
	if deptname<>"" and topic<>"" then
		firstmsg=replace(appsettings.acceptmsg & "","$$TOPIC$$",topic)
		firstmsg=replace(firstmsg,"$$DEPT$$",deptname)
		firstmsg=replace(firstmsg,"$$NAME$$",nick)
	else
		firstmsg="You're now talking to "  & nick
	end if
		
	'//// Last message date ///'
	dim lastmsgdate=todaydatetime
	

	'//// Accept request'
	newmsg="<table width=96% class=SystemMsg><tr><td>" & firstmsg & "</td></tr></table><br>"
	
	'/// Add welcolme MSG
	if len(getmymsg)>0 then newmsg=newmsg & "<span class=reptext><b>" & nick & "&gt;</b> " & getmymsg & "</span><br>"
	
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand("xlaALSsp_accept_request",conn)
	mycommand.commandType =  CommandType.Storedprocedure
	mycommand.Parameters.Add( "@requestid" , requestid )
	mycommand.Parameters.Add( "@userid" , userid)
	mycommand.Parameters.Add( "@rep_msgs" , newmsg)
	mycommand.Parameters.Add( "@lastmsgdate", lastmsgdate)
	mycommand.Parameters.Add( "@addtolog" , appsettings.logchat)
	conn.open()
	dim istaken as integer=mycommand.executenonquery()
	conn.close()
	
	'//// If the chat was taken, close chat
	if istaken>0 then
		response.write("<sc" &"ript language=JavaScript>alert('This request was already taken by another representative\nThis window will be closed');top.close();</sc" & "ript>")
		response.end
	end if
	
	'/// Update Visitor Action'
	dim actionnote as string=""
	if deptname<>"" then
		actionnote="In chat with " & nick & " from " & deptname
	else
		actionnote="In proactive chat with " & nick
	end if
	call updatevisitoraction(ip,2,actionnote)
end sub
</script>
<script language="JavaScript" type="text/JavaScript">
var chatchat = false;
var chattext = false;
var chattop = false;

var afm=0;
function showafm(){
	afm=afm+1;
	if (afm>1) afm=0;
	if (afm==0){
		document.getElementById("alsframeset").rows='36,0,*,190,0,0';
	} else {
		document.getElementById("alsframeset").rows='36,30,*,190,0,0';
	}
}
</script>

<title>Live Support</title>
<frameset rows="36,0,*,190,0,0" frameborder="NO" border="0" framespacing="0" id="alsframeset"> 
<frame name="logo" id="logo" scrolling="NO" noresize src="ALSChatTop.aspx?requestid=<%=requestid%>&ip=<%=ip%>" >
<frame name="AFMoption" id="AFMoption" scrolling="NO" noresize src="ALSChatAFM.aspx" >
<frame name="chat" id="chat" src="ALSChatSession.aspx?name=<%=server.urlencode(name)%>&deptname=<%=server.urlencode(deptname)%>&topic=<%=server.urlencode(topic)%>&requestid=<%=requestid%>&email=<%=server.urlencode(email)%>" scrolling="AUTO">
<frame name="text" id="text"  src="ALSChatText.aspx?name=<%=server.urlencode(name)%>&deptname=<%=server.urlencode(deptname)%>&topic=<%=server.urlencode(topic)%>&requestid=<%=requestid%>" scrolling="NO" noresize>
<frame name="loader" id="loader" src="blank.htm" scrolling="NO">
<frame name="receive" id="receive" src="ALSChatReceive.aspx?requestid=<%=requestid%>" scrolling="NO">
</frameset><noframes></noframes>
