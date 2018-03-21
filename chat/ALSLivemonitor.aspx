<!--#include file="incSystem.aspx" -->
<script runat="server">
dim framesize as string="29,140,0,0"
sub page_load()
	dim userid as string=getusrid
	if userid="" or userid="0" then response.redirect("logout.aspx")

	'/// Initialize Monitor ///'
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand
	mycommand.connection = conn
	mycommand.commandtext = "xlaALSsp_monitor_initialize"
	mycommand.CommandType = CommandType.StoredProcedure
	mycommand.Parameters.Add( "@userid" , userid)
	mycommand.Parameters.Add( "@wentonline" , todaydatetime)

	conn.open()
	mycommand.executescalar()
	conn.close()
	if appsettings.messenger<>"" and appsettings.allowtracking<>"" then 
		framesize="29,116,24,21,*"
	elseif appsettings.messenger="" and appsettings.allowtracking<>"" then
		framesize="29,140,0,21,*"
	elseif appsettings.allowtracking="" and appsettings.messenger<>"" then
		framesize="29,140,24,0,0"
	end if
	
end sub

</script>
<title>Live Monitor</title>
<script language="JavaScript" type="text/JavaScript">
var tracking=0;
var isonline=0;
function showhide(){
	if (tracking==0){
		showtrack();
	} else {
		hidetrack();
	}
}

function showtrack(){
	visitors.location.href='LMVisitors.aspx';
	top.resizeTo(700,450);
	tracking=1;
}

function hidetrack(){
	top.resizeTo(512,218);
	visitors.location.href='blank.htm';
	tracking=0;
}

function forceoffline(){
	window.open("LMOffline.aspx?autoclose=true","","toolbar=0,location=0,status=0,menubar=0,scrollbars=0,resizable=0,width=1,height=1,top=9999,left=9999");
}

function AskExit() { 
	if (isonline==1)   event.returnValue = "Closing the live monitor will set your status as offline.\nYou will need to launch the monitor again in order to monitor your requests\nDo you want to close this window and exit from the live monitor?";
} 

window.name="ALS_LM";

function norequests(){
	document.title='Live Monitor';
}

function notifyrequests(what){
	document.title='Live Monitor : You have ' + what + ' incoming chat requests';
}


// Auto Reconnect
var totalreloads=0;
var docheck=1;
function isconnected(){
	<%if appsettings.autoreconnect<>"" then%>
	window.clearTimeout();
	if (docheck==1){
		try {
			var theframe=document.getElementById("lmrequests");
			var framecontent=theframe.contentWindow.document.body.innerHTML;
			if (framecontent.indexOf('<!-- ALS -->')==-1 && docheck==1){
				document.getElementById("requests_frameset").cols="100%,0";
				totalreloads=totalreloads+1;
				
				if (totalreloads==5){
					document.title='Network Congestion';
					<%if appsettings.reconnectnotify<>"" then%>
					top.focus();top.focus();top.focus();
					alert('There seems to be some network congestion or the Live Support application is not reacheable\nClick OK to try again');
					<%end if%>
				}
	
				if (totalreloads==20){
					document.title='Live Support Seems to be Down';
					<%if appsettings.reconnectnotify<>"" then%>				
					top.focus();top.focus();top.focus();
					if (confirm('The Absolute Live Support application seems to be down.\nWould you like to close the monitor and exit?\n')){
						top.close();
						return;
					}
					<%end if%>
				}
	
	
				theframe.src="LMOnline.aspx";
			} else {
				document.getElementById("requests_frameset").cols="0,100%";
				totalreloads=0;
			}
		} catch(e) {
			// Nothing Happens
		}
	}
	window.setTimeout("isconnected()",10000);
	<%end if%>
}


</script>
</head>
<frameset rows="<%=framesize%>" frameborder="NO" border="0" framespacing="0" id="alsframeset" onunload="javascript:forceoffline();" onbeforeunload="AskExit();" onLoad="isconnected();">
  <frame src="LMControl.aspx" name="lmcontrol" id="lmcontrol" scrolling="NO" noresize>
  <frameset cols="0,100%" frameborder="NO" border="0" framespacing="0" id="requests_frameset">
	<frame src="LMconnectionerror.aspx" scrolling="yes">
  	<frame src="LMOnline.aspx" name="lmrequests" id="lmrequests" scrolling="yes">
  </frameset>
  <frame src="LMMessenger.aspx" name="lmpager" id="lmmessenger" scrolling="NO" noresize>
  <frame src="lMTrack.aspx" name="lmtrack" id="lmtrack" scrolling="NO" noresize>
  <frame src="blank.htm" name="visitors" id="lmvisitors" scrolling="yes" noresize>
 </frameset><noframes></noframes>


