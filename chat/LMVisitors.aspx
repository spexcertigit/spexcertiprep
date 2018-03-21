<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim userid as string=""
dim sortby as string=""
dim logindate as string
dim x as integer=0
dim mylastvisitorid as string=""
dim soundstatus as string=""

sub page_load()
	userid=getusrid
	if userid="" or userid=0 then response.redirect("logout.aspx")
	soundstatus=getcookie("xlaALSsoundstatus")
	if soundstatus="" then soundstatus="on"
	mylastvisitorid=getcookie("xlaALSlastvisitorid") & ""
	
	'/// Is Tracking Enabled ///'?
	if appsettings.allowtracking="" then
		response.write("<p>&nbsp;</p><p align=center><font color=#FF0000 size=1 face=Tahoma><b>The user tracking feature is currently disabled</b></font></p>")
		response.end
	end if
	
	sortby=request("sortby")
	if sortby="" then sortby="lastdate desc"
	logindate=todaydatetime
	
	dim proactive as string=request("proactive")
	dim ip as string=request("ip")
	dim a as string
	if proactive<>"" then
		'/// Submit proactive Chat ///'
		call invite(ip)
	end if
	
	'/// Cancel proactive chat ///'
	dim noproactive as string=request("noproactive")
	if noproactive<>"" then
		call cancelinvite(ip)
	end if
	
end sub


sub invite(ip as string)
	dim myinvitemsg as string=request("myinvitemsg") & ""
	if lcase(myinvitemsg)="null" or lcase(myinvitemsg)="undefined" then myinvitemsg=""
	
	dim updateaction as boolean=false
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand("xlaALSsp_invite_to_chat",conn)
	dim dr as SqlDataReader
	mycommand.commandType =  CommandType.Storedprocedure
	mycommand.Parameters.Add( "@ip" , ip )
	mycommand.Parameters.Add( "@invitedby" , userid )
	mycommand.Parameters.Add( "@invitemsg" , myinvitemsg)
	conn.open()
	dr = mycommand.ExecuteReader()
	if dr.read() then updateaction=true
	dr.close()
	conn.close()
	
	if updateaction then call updatevisitoraction(ip,1,"Invited to chat by " & getnick)
	response.redirect("LMVisitors.aspx?sortby=" & server.urlencode(sortby))
end sub


sub cancelinvite(ip as string)
	dim updateaction as boolean=false
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand("xlaALSsp_cancel_invite",conn)
	mycommand.commandType =  CommandType.Storedprocedure
	mycommand.Parameters.Add( "@ip" , ip )
	conn.open()
	mycommand.ExecuteScalar()
	conn.close()
	
	call updatevisitoraction(ip,0,"Last action canceled by " & getnick)
	response.redirect("LMVisitors.aspx?sortby=" & server.urlencode(sortby))
end sub
</script>

<style>
<!--
A:link {text-decoration: font-weight:bolder; color: blue}
A:visited {text-decoration: font-weight:bolder; color: blue}
A:active {text-decoration: font-weight:bolder; color: blue}
A:hover {text-decoration: font-weight:bolder; color: red}
-->
</style>
<script language="JavaScript" type="text/JavaScript">
var timer1=null;
function refreshtimer() {
	timer1=setTimeout("window.location.reload( true );", <%=appsettings.trackrefresh*1000%>);
}

function resettimer(){
	window.clearTimeout(timer1);
	refreshtimer();
}

function alertproactive(ip,what){
	var msg='';
	if (what==3) msg='This user was already in a chat\nInvite to chat again?';
	if (what==5) msg='This user was already invited but didn\'t want to chat\nWould you like to proceed?';
	if (confirm(msg)) inviteuser(ip);
}

function denyproactive(what,ip){
	if(what==1) msg='User is already waiting for a representative to chat';
	if(what==2) msg='User is already in chat with a representative';
	if (confirm(msg+'\nCancel Invitation?')) self.location.href='LMVisitors.aspx?sortby=<%=server.urlencode(sortby)%>&noproactive=1&ip=' + ip;
}

function inviteuser(ip){
	var myinvitemsg;
	<%if appsettings.allowcustominvite<>"" then%>
	myinvitemsg=prompt("If you like,you can enter an invitation for this user","");
	if (myinvitemsg!='' && myinvitemsg!=null && myinvitemsg!='undefined'){self.location.href='LMVisitors.aspx?sortby=<%=server.urlencode(sortby)%>&proactive=1&ip=' + ip + '&myinvitemsg='  + myinvitemsg;}
	<%else%>
	self.location.href='LMVisitors.aspx?sortby=<%=server.urlencode(sortby)%>&proactive=1&ip=' + ip + '&myinvitemsg='  + myinvitemsg;
	<%end if%>
}

</script>
<link href="ALSStyles.css" rel="stylesheet" type="text/css">
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" rightmargin="0" bottommargin="0" onLoad="javascript:refreshtimer();" onClick="javascript:resettimer();">
<table width="100%" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="#999999">
  <tr class="OptionName"> 
    <td width="25%" height="24" align="center"><b><a href="LMVisitors.aspx?sortby=name+asc">Visitor</a></b></td>
    <td height="24" align="center"><b><a href="LMVisitors.aspx?sortby=referer+asc">On 
      Page</a></b></td>
    <td width="6%" height="24" align="center"><b><a href="LMVisitors.aspx?sortby=lastdate+desc">Time</a></b></td>
    <td width="20%" height="24" align="center"><b><a href="LMVisitors.aspx?sortby=actionid+asc">Status</a></b></td>
    <td width="13%" height="24" align="center">Lead</td>
    <td width="8%" height="24" align="center"><b>Invite</b></td>
  </tr>
   <%
 	dim name as string, ip as string, referer as string, timeonpage as integer, user as string,actionid as integer,bgcolor as string,invitelink as string,co as string,country as string
	'/// Date for deleting the visitor tracking ///'
	dim tracktimeout as integer=-5
	if isnumeric(appsettings.tracktimeout) then tracktimeout=-(val(appsettings.tracktimeout))
	dim deletedate as string=getdate(DateAdd("n", tracktimeout, todaydatetime))

	'/// Search Tracked Visitors ///'
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand("xlaALSsp_visitorsview",conn)
	dim myadapter as New SqlDataAdapter(mycommand)
	mycommand.CommandType = CommandType.StoredProcedure
	mycommand.Parameters.Add( "@tracklimit" , appsettings.tracklimit)
	mycommand.parameters.add( "@orderby" , sortby)
	mycommand.parameters.add( "@deletedate" , deletedate)
	mycommand.parameters.add( "@userid" , userid)
	conn.open()
	dim dr as SqlDataReader = mycommand.ExecuteReader()
	do while dr.read()
	name=dr("name")
	ip=dr("ip")
	referer=dr("referer")
	co=dr("co") & ""


	user=""
	if name<>"" then user="<b>" & name & "</b><br>"
	user=user & "IP : " & ip &"<br> (" &  left(dr("hostname") & "",40) & ")<br>"
	if appsettings.countrylookup<>"" and co<>"" and co<>"-" then user &="<img src=flags/" & co & ".gif align=absmiddle width=18 height=12> " & dr("country") & ""
	timeonpage=datediff("n",dr("lastdate"),logindate)
	actionid=dr("actionid")
	dim invitelbl as string="Invite"
	select case actionid
	case 0
		bgcolor="#00CC00"
		invitelink="javascript:inviteuser('" & ip & "');"
	case 1
		bgcolor="#FFCC00"
		invitelink="javascript:denyproactive(1,'" & ip &"');"
		invitelbl="Cancel"
	case 2
		bgcolor="#0099CC"
		invitelink="javascript:denyproactive(2,'" & ip & "');"
		invitelbl="Cancel"
	case 3
		bgcolor="#666666"
		invitelink="javascript:alertproactive('" & ip & "',3);"
	case 4
		bgcolor="#FF3300"
		invitelink="javascript:inviteuser('" & ip & "');"
	case 5
		bgcolor="#9933CC"
		invitelink="javascript:alertproactive('" & ip & "',5);"
	end select

	%>

  <tr> 
    <td width="25%" rowspan="2" valign="top" class="OptionFields"> <span class="SmallNotes"><%=user%></span></td>
    <td rowspan="2" valign="top" class="OptionFields"><a href="<%=referer%>" target="_blank" class="SmallNotes"><%=referer%></a></td>
    <td width="6%" rowspan="2" align="center" valign="middle" class="OptionFields"><span class="SmallNotes"><%=timeonpage%> 
      Mins</span></td>
    <td width="20%" height="4" align="left" valign="top" bgcolor="<%=bgcolor%>"></td>
    <td width="13%" rowspan="2" align="center" valign="top" bgcolor="#F3F3F3" class="SmallNotes"> 
      <%=ishotlead(dr("visits"),dr("hotleadref"),dr("totalrequests"))%> </td>
    <td width="8%" rowspan="2" align="center" valign="middle" bgcolor="#F3F3F3"><a href="<%=invitelink%>" class="SmallNotes"> 
      <img src=images/btn<%=invitelbl%>.gif border=0><br>
      <%=invitelbl%></a></td>
  </tr>
  <tr> 
    <td width="20%" align="center" valign="top" class="OptionFields"><span class="SmallNotes"><%=dr("actionnote")%></span></td>
  </tr>			
  <%
  loop
  dr.nextresult()
  if dr.read() and appsettings.playnewvisitor<>"" then
	'/// Is there a new visitor there ///'
	if mylastvisitorid & "" < dr("trackid").tostring then
		setcookie("xlaALSlastvisitorid",dr("trackid").tostring)
		'/// Play Alert ///'
		if mylastvisitorid<>"" then 
			response.write("<scr" & "ipt language=javascript>top.focus();</s" &"cript>")
			if soundstatus="on" then response.write("<bgsound src=files/newvisitor.au>")
		end if
	end if
  end if
  dr.close()
  conn.close()
  %>

</table>
</body>
