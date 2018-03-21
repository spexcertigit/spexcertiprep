<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim vtrack as string=""
dim alsbutton as string=""
dim showlastdays as string=""
dim lvl as integer

sub page_load()
	lvl=uservalidate(0)
	
	'/// Visitor Tracking Code : ///'
	vtrack="<scr" &"ipt language=JavaScript src=" & chr(34) & appsettings.applicationurl & "vtrack.aspx" & chr(34) &"></scr" &"ipt>"

	'/// Live Support Button Code : ///'
	alsbutton="<scr" &"ipt language=JavaScript src=" & chr(34) & appsettings.applicationurl & "als.aspx" & chr(34) &"></scr" &"ipt>"
	
	'/// Last days Stats ///'
	if appsettings.showlastdays>0 then showlastdays=" (last " & appsettings.showlastdays & " days period)"
end sub

</script>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title><%=apptitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript">
function launchmonitor(){
	ALSLM=window.open("ALSLiveMonitor.aspx","ALS_LM","toolbar=0,location=0,status=0,menubar=0,scrollbars=1,resizable=1,width=500,height=180");
	ALSLM.focus();
}

function goreport(what){
	if (what!='') {
		startframe.location.href=what;
		startframe.focus();
	}
}
</script>
<link href="ALSStyles.css" rel="stylesheet" type="text/css">
</head>

<body topmargin="5">
<table width="96%" height="100%" border="0" align="center" cellpadding="2" cellspacing="2">
  <tr> 
    <td height="30" align="left" class="MainTitles"><img src="images/icStart.gif" width="20" height="20" align="absmiddle"> 
      Start Screen </td>
    <td width="220" height="30" align="right"><a href="javascript:launchmonitor();"><img src="images/btnLaunchmonitor2.gif" width="118" height="25" border="0"></a></td>
  </tr>
  <tr> 
    <td align="left" valign="top"> <table width="100%" height="90%" border="0" cellpadding="3" cellspacing="1" class="OptionName">
        <tr> 
          <td height="30" align="left" valign="middle"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="50%" class="MainTitles"><b>Reports and tools</b></td>
                <td width="50%" align="right"><span class="GeneralText"><b>View 
                  :</b></span> 
                  <select name="select" style="font-size:9px" onchange="javascript:goreport(this.value);">
                    <optgroup label="Reports<%=showlastdays%>"> 
                    <option value="Report-requestsperday.aspx" selected>Requests 
                    Per Day</option>
                    <option value="Report-requestsperdept.aspx">Requests Per Department</option>
                    <option value="Report-requestsperrep.aspx">Requests Per Representative</option>
                    <option value="Report-referrals.aspx">Top 50 Site referrals</option>
                    <option value="Report-requestsperpage.aspx">Requests Per Page</option>
                    <option value="Report-requestspercountry.aspx">Requests Per 
                    Country</option>
                    <option value="Report-ratingperdept.aspx">Department's Average 
                    Rating</option>
                    <option value="Report-avgsessiontimedept.aspx">Department's 
                    Average Session Time</option>
                    <option value="Report-totaltimedept.aspx">Department's Total 
                    Session Time</option>
                    <option value="Report-ratingperrep.aspx">Representative's 
                    Average Rating</option>
					<option value="Report-availablereps.aspx">Representative's 
                    Availability</option>
                    <option value="Report-avgsessiontimerep.aspx">Representative's 
                    Average Session Time</option>
                    <option value="Report-totaltimerep.aspx">Representative's 
                    Total Session Time</option>
                    <option value="Report-timeonline.aspx">Representative's Time 
                    Online</option>
					<option value="Report-busyrequests.aspx">Busy Requests</option>
                    </optgroup>
                    <optgroup label="Tools"> 
                    <option value="Report-VisitorTracking.aspx">Visitor Tracking</option>
                    <option value="Report-Currentsessions.aspx">Current Sessions</option>
                    <%if appsettings.messenger<>"" then%>
                    <option value="Viewmessages.aspx">My Received Messages</option>
                    <%end if%>
                    <option value="generatecode.aspx">Code Generator</option>
                    </optgroup>
                  </select></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td align="left" valign="top" bgcolor="#FFFFFF"> <iframe src="Report-requestsperday.aspx" frameborder=0 height=100% width=100% scrolling="yes" name="startframe" marginwidth="0" marginheight="0"></iframe></td>
        </tr>
      </table></td>
    <td width="220" align="left" valign="top" class="SmallNotes"> 
      <table width="100%" border="0" cellpadding="4" cellspacing="1" class="OptionName" style="table-layout:fixed">
        <tr> 
          <td align="center"><strong>Visitor tracking / Auto Engage code</strong></td>
        </tr>
        <tr> 
          <td align="center" bgcolor="#FFFFFF"> 
            <textarea name="textarea2" cols="24" rows="4" readonly style="font-size:11px;width:100%"><%=vtrack%></textarea>
            <span class="SmallNotes"><strong>Add this code to each page where 
            you want to track your visitors <br>
            </strong></span></td>
        </tr>
        <tr> 
          <td align="center" class="GeneralText"><b>Live support button code</b></td>
        </tr>
        <tr> 
          <td align="center" bgcolor="#FFFFFF"> 
            <textarea name="textarea" cols="24" rows="4" readonly style="font-size:11px;width:100%"><%=alsbutton%></textarea>
            <span class="SmallNotes">Use this code to display the live support 
            button on your pages<br>
            </span></td>
        </tr>
        <tr> 
          <td align="center" class="GeneralText"><b>Button displayed on site</b></td>
        </tr>
        <tr> 
          <td align="center" valign="middle" bgcolor="#FFFFFF"> <br>
            <script language="JavaScript" src="als.aspx" type="text/JavaScript"></script>
            <br>
            <br>
          </td>
        </tr>
      </table>
      <br>
      <br>
    </td>
  </tr>
</table>
</body>
</html>
