<!--#include file="incSystem.aspx" -->
<script runat="server">
dim userid as string=""
dim myinvitemsg as string=""

sub page_load
	'/// Is tracking enabled ? ///'
	setCookie("xlaALSengaged","1")
	
	if appsettings.allowtracking="" then response.end
	dim ip as string=request.ServerVariables("REMOTE_ADDR") & ""
	if request("dontbother")<>"" then 
		call updatevisitoraction(ip,5,"Do Not Disturb")
		response.write("<sc" & "ript language=""JavaScript"">self.close();</" & "script>")
		response.end()
	end if
	
	userid=request("u")
	myinvitemsg=request("myinvitemsg")
	if myinvitemsg="" then myinvitemsg=appsettings.invitemsg
end sub

</script>

<html>
<head>
<title><%=appsettings.chattitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="styles.css" type="text/css">
<script  language="JavaScript">
var w = 640, h = 480;
if (document.all || document.layers) {
   w = screen.availWidth;
   h = screen.availHeight;
}
var popwindowleft=0-<%=appsettings.userwidth%>;
var popwindowtop=(h-<%=appsettings.userheight%>)/2;
var pagecenter=(w-<%=appsettings.userwidth%>)/2
var step=40;
var pause=4;
var timer;
function movewindow(){
	top.focus();
	if (popwindowleft<=pagecenter) {
		this.moveTo(popwindowleft,popwindowtop)
		popwindowleft+=step
			timer= setTimeout("movewindow();",pause)
		}
		else {
			clearTimeout(timer)
		}
}

</script>
</head>
<body leftmargin="0" rightmargin="0" topmargin="0" class="ChatBackground" onload="javascript:top.focus();top.focus();top.focus();movewindow();">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td class="FrameBackground"><a href="<%=appsettings.siteurl%>" target="_blank"><img src="files/logo.gif" vspace="4" hspace="12" border="0"></a></td>
  </tr>
  <tr>
    <td height="100%"><table width="90%" border="0" align="center" cellpadding="2" cellspacing="2">
        <tr align="center"> 
          <td colspan="2"><span class="Titles">Live Support Message :<br>
            <br>
            </span><span class="Text"> <%=myinvitemsg%><br>
            </span></td>
        </tr>
        <tr valign="top"> 
          <td align="right"> <input type="button"  value="Accept" onClick="javascript:self.location.href='<%=appsettings.applicationurl%>UserPreChat.aspx?u=<%=userid%>&isproactive=1';"></td>
          <td align="left"> <input type="button"  value="Cancel" onClick="javascript:self.location.href='UserProactive.aspx?dontbother=true'"></td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html>
