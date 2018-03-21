<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim lvl as integer
dim success as integer=0
dim doconfirmation as string=""

sub page_load
	lvl=uservalidate(1)
	if not(ispostback) then 
		call fillvalues() 
		doconfirmation="checked"
	end if
	if buttonsave.value<>"" then call savevalues()
end sub

sub fillvalues()
	'/// Load Values ///'
	dim currentsettings as AppConfigurationData= AppConfiguration.Settings
	applicationurl.value=currentsettings.applicationurl
	license.value=currentsettings.license
	siteurl.value=currentsettings.siteurl
	timeoffset.value=currentsettings.timeoffset
	usertimeout.value=currentsettings.usertimeout
	reptimeout.value=currentsettings.reptimeout
	refreshrate.value=currentsettings.refreshrate
	requestrate.value=currentsettings.requestrate
	maxwaittime.value=currentsettings.maxwaittime
	reassignattempts.value=currentsettings.reassignattempts
	userwidth.value=currentsettings.userwidth
	userheight.value=currentsettings.userheight
	repwidth.value=currentsettings.repwidth
	repheight.value=currentsettings.repheight
	showlastdays.value=currentsettings.showlastdays
	chattitle.value=currentsettings.chattitle
	docheckbox(allowtracking,currentsettings.allowtracking)
	docheckbox(trackreps,currentsettings.trackreps)
	docheckbox(logchat,currentsettings.logchat)
	docheckbox(buttonstatuscheck,currentsettings.buttonstatuscheck)
	trackrefresh.value=currentsettings.trackrefresh
	tracklimit.value=currentsettings.tracklimit
	tracktimeout.value=currentsettings.tracktimeout
	docheckbox(allowrating,currentsettings.allowrating)
	docheckbox(getfullurl,currentsettings.getfullurl)
	acceptmsg.value=currentsettings.acceptmsg
	welcomemsg.value=currentsettings.welcomemsg
	invitemsg.value=currentsettings.invitemsg
	docheckbox(allowcustominvite,currentsettings.allowcustominvite)
	byemsg.value=currentsettings.byemsg
	mailadmin.value=currentsettings.mailadmin
	smtpserver.value=currentsettings.smtpserver
	subject.value=currentsettings.subject
	purgedays.value=currentsettings.purgedays
	docheckbox(allowemailchat,currentsettings.allowemailchat)
	docheckbox(playsound,currentsettings.playsound)
	docheckbox(playnotify,currentsettings.playnotify)
	docheckbox(playnewvisitor,currentsettings.playnewvisitor)
	docheckbox(keepfocus,currentsettings.keepfocusrep)
	docheckbox(keepfocusrep,currentsettings.keepfocus)
	docheckbox(fieldsrequired,currentsettings.fieldsrequired)
	docheckbox(iplookup,currentsettings.iplookup)
	docheckbox(countrylookup,currentsettings.countrylookup)
	docheckbox(askemail,currentsettings.askemail)
	docheckbox(flashrequest,currentsettings.flashrequest)
	docheckbox(messenger,currentsettings.messenger)
	docheckbox(allowquickwords,currentsettings.allowquickwords)
	docheckbox(allowcomments,currentsettings.allowcomments)
	docheckbox(autoreconnect,currentsettings.autoreconnect)
	docheckbox(reconnectnotify,currentsettings.reconnectnotify)
	docheckbox(showuserpublicinfo,currentsettings.showuserpublicinfo)
	docheckbox(requeue,currentsettings.requeue)
	docheckbox(trackbusy,currentsettings.trackbusy)
	
	defaultnick.value=currentsettings.defaultnick
	defaultdeptname.value=currentsettings.defaultdeptname
	autoengagetime.value=currentsettings.autoengagetime
	hotleads.value=currentsettings.hotleads
	optfield1.value=currentsettings.optfield1
	optfield2.value=currentsettings.optfield2
	optfield3.value=currentsettings.optfield3
	docheckbox(optfield1req,currentsettings.optfield1req)
	docheckbox(optfield2req,currentsettings.optfield2req)
	docheckbox(optfield3req,currentsettings.optfield3req)
	if currentsettings.contactform<>"" then 
		cformcustom.checked=true
		contactform.value=currentsettings.contactform
	else
		cformdefault.checked=true
	end if
	docheckbox(notifytype,currentsettings.notifytype)
	blockips.value=replace(currentsettings.blockips,";",vbcrlf)
	afmneturl.value=currentsettings.afmneturl
	xla_id.value=currentsettings.xla_id
end sub

sub savevalues()
	buttonsave.value=""
	AppConfiguration.resetcache()
	dim newsettings as new AppConfigurationData
	newsettings=AppConfiguration.Settings()
	
	'/// check Defaults ///'
	if not(isnumeric(usertimeout.value)) then usertimeout.value=3
	if not(isnumeric(reptimeout.value)) then reptimeout.value=5
	if not(isnumeric(refreshrate.value)) then refreshrate.value=5
	if not(isnumeric(requestrate.value)) then requestrate.value=14
	if not(isnumeric(maxwaittime.value)) then maxwaittime.value=0
	if not(isnumeric(showlastdays.value)) then showlastdays.value=15
	if not(isnumeric(trackrefresh.value)) then trackrefresh.value=15
	if not(isnumeric(tracklimit.value)) then tracklimit.value=0
	if not(isnumeric(tracktimeout.value)) then tracktimeout.value=5
	if not(isnumeric(autoengagetime.value)) then autoengagetime.value=0
	if not(isnumeric(timeoffset.value)) or timeoffset.value="" then timeoffset.value=0
	
	'/// Get Data ///'
	if isnumeric(timeoffset.value) and timeoffset.value<>"" then newsettings.timeoffset=val(timeoffset.value) else newsettings.timeoffset=0
	newsettings.applicationurl=applicationurl.value & "" 
	newsettings.license=license.value & ""
	newsettings.siteurl=siteurl.value & ""
	newsettings.timeoffset=val(timeoffset.value)	
	newsettings.usertimeout=usertimeout.value 
	newsettings.reptimeout=reptimeout.value 
	newsettings.refreshrate=refreshrate.value 
	newsettings.requestrate=requestrate.value
	newsettings.maxwaittime=maxwaittime.value 
	newsettings.reassignattempts=reassignattempts.value 
	newsettings.userwidth=userwidth.value 
	newsettings.userheight=userheight.value 
	newsettings.repwidth=repwidth.value 
	newsettings.repheight=repheight.value 
	newsettings.showlastdays=showlastdays.value 
	newsettings.chattitle=chattitle.value & ""
	newsettings.allowemailchat=docheckbox(allowemailchat) & ""
	newsettings.allowtracking=docheckbox(allowtracking) & ""
	newsettings.trackreps=docheckbox(trackreps) & ""
	newsettings.buttonstatuscheck=docheckbox(buttonstatuscheck) & ""
	newsettings.logchat=docheckbox(logchat) & ""
	newsettings.trackrefresh=trackrefresh.value
	newsettings.tracklimit=tracklimit.value
	newsettings.tracktimeout=tracktimeout.value
	newsettings.allowrating=docheckbox(allowrating) & ""
	newsettings.allowcomments=docheckbox(allowcomments) & ""
	newsettings.flashrequest=docheckbox(flashrequest) & ""
	newsettings.getfullurl=docheckbox(getfullurl) & ""
	newsettings.acceptmsg=acceptmsg.value & ""
	newsettings.welcomemsg=welcomemsg.value & ""
	newsettings.invitemsg=invitemsg.value & ""
	newsettings.allowcustominvite=docheckbox(allowcustominvite) & ""
	newsettings.messenger=docheckbox(messenger) & ""
	newsettings.allowquickwords=docheckbox(allowquickwords) & ""
	newsettings.byemsg=byemsg.value & ""
	newsettings.mailadmin=mailadmin.value & ""
	newsettings.smtpserver=smtpserver.value & ""
	newsettings.subject=subject.value & ""
	newsettings.playsound=docheckbox(playsound) & ""
	newsettings.playnotify=docheckbox(playnotify) & ""
	newsettings.playnewvisitor=docheckbox(playnewvisitor) & ""
	newsettings.keepfocus=docheckbox(keepfocus) & ""
	newsettings.requeue=docheckbox(requeue) & ""
	newsettings.trackbusy=docheckbox(trackbusy) & ""
	newsettings.keepfocusrep=docheckbox(keepfocusrep) & ""
	newsettings.fieldsrequired=docheckbox(fieldsrequired) & ""
	newsettings.defaultnick=defaultnick.value & ""
	newsettings.defaultdeptname=defaultdeptname.value & ""
	newsettings.autoengagetime=autoengagetime.value 
	newsettings.contactform=""
	if cformcustom.checked=true and contactform.value<>"" then newsettings.contactform=contactform.value & ""
	newsettings.notifytype=docheckbox(notifytype) & ""
	newsettings.iplookup=docheckbox(iplookup) & ""
	newsettings.countrylookup=docheckbox(countrylookup) & ""
	newsettings.askemail=docheckbox(askemail) & ""
	newsettings.optfield1req=docheckbox(optfield1req) & ""
	newsettings.optfield2req=docheckbox(optfield2req) & ""
	newsettings.optfield3req=docheckbox(optfield3req) & ""
	newsettings.optfield1=optfield1.value & ""
	newsettings.optfield2=optfield2.value & ""
	newsettings.optfield3=optfield3.value & ""
	newsettings.blockips=replace(blockips.value,vbcrlf,";") & ""
	newsettings.xla_id=xla_id.value & ""
	newsettings.hotleads=hotleads.value
	newsettings.reconnectnotify=docheckbox(reconnectnotify) & ""
	newsettings.autoreconnect=docheckbox(autoreconnect) & ""
	newsettings.showuserpublicinfo=docheckbox(showuserpublicinfo) & ""
	newsettings.afmneturl=afmneturl.value
	if purgedays.value<>"" and isnumeric(purgedays.value) then newsettings.purgedays=purgedays.value else newsettings.purgedays=0

	
	'/// Check Defaults ///'
	if newsettings.applicationurl<>"" and newsettings.license<>"" and newsettings.siteurl<>"" and newsettings.xla_id<>"" then
		if right(newsettings.applicationurl,1)<>"/" then newsettings.applicationurl &= "/"
		if right(newsettings.siteurl,1)<>"/" then newsettings.siteurl &= "/"
	
		'//// Save Settings ///'
		success=1	'/// Successful ///'
		dim configdata as string=AppConfiguration.SaveSettings(newsettings)
		if configdata<>"" then
			configcode.text=configdata
			success=2	'/// Error saving data ///'
		end if
	
		'//// Fill with new values ///'
		fillvalues()
	else
		response.write("<scr" &"ipt language=JavaScript>alert('The settings could not be saved\nSome fields are missing or are incorrect');history.back();</s" &"cript>")
	end if
end sub

</script>
<html>
<head>
<title><%=apptitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="ALSStyles.css" rel="stylesheet" type="text/css">
</head>
<script language="JavaScript">
function verify(){
	if (document.getElementById("applicationurl").value !='' && document.getElementById("siteurl").value!='' && document.getElementById("license").value!='' && document.getElementById("xla_id").value!='') verify2();
	else alert('You must provide an order ID number, the full URL to the application, the full site URL and licensed company name, and the administrator\'s Username and password');
}

function verify2(){
	if (confirm('Save Changes?')){
		document.getElementById("buttonsave").value='1';
		document.getElementById("form1").submit();
	}
}
	
function dodownload(){
	document.getElementById("configcode2").value=document.getElementById("configcode").value;
	document.getElementById("form2").submit();
}

function confirmation(){
	if (!confirm('You are accessing the system configuration settings\nDo you want to continue?')) self.location.href='search.aspx';
}
<%if doconfirmation<>"" then response.write("confirmation();")%>
</script>
<body bgcolor="#FFFFFF" text="#000000">
<form name="form1" id="form1" method="post" action="options.aspx" runat="server">
  <table width="90%" border="0" cellspacing="2" cellpadding="2" align="center">
    <tr align="left" valign="top"> 
      <td colspan="2" class="MainTitles"><b><img src="images/icOptions.gif" width="20" height="20" align="absmiddle"> 
        Configuration Settings</b></td>
    </tr>
    <tr align="left" valign="top"> 
      <td colspan="2" class="SearchCell"></td>
    </tr>
    <tr align="left" valign="top" class="OptionFields"> 
      <td colspan="2" class="SmallNotes">Use this option to set and configure 
        the application. Write Permission is required on the Application Directory.</td>
    </tr>
    <tr align="left" valign="top"> 
      <td colspan="2" class="SearchCell"></td>
    </tr>
    <%if success=2 then%>
    <tr align="left" valign="top" class="CriticalError"> 
      <td colspan="2">Error : The New Settings could not be saved due to security 
        settings</td>
    </tr>
    <tr align="left" valign="top" class="OptionFields"> 
      <td colspan="2"> <p>To save the new settings you'll have to copy and paste 
          the following code into a blank .txt file and then rename that file 
          to <b>xigla.config</b> and upload it to the application Directory and 
          your new settings will take place.</p>
        <p><b> Here's the code :</b> 
          <asp:textbox ID="configcode" Rows="10" Width="100%" runat="server" TextMode="MultiLine" Wrap="false" />
          <input name="btndownload" type="button" id="btndownload" value="Download this code" onclick="dodownload();">
        </p>
        <p> <br>
          <b>Your current settings :</b></p></td>
    </tr>
    <%elseif success=1 then%>
    <tr align="left" valign="top"> 
      <td colspan="2" class="Headers">The new settings have been saved</td>
    </tr>
    <%end if%>
    <tr align="left" valign="top"> 
      <td width="30%" class="OptionName">Licensed to :<br> </td>
      <td class="OptionName"> <input name="license" type="text" id="license" size="40" runat="server"> 
        <br> <span class="SmallNotes">Administrator Name / Company</span></td>
    </tr>
    <tr align="left" valign="top"> 
      <td class="OptionName">Serial No. :</td>
      <td class="OptionName"> <input name="xla_id" type="text" id="xla_id" size="40" runat="server"> 
        <br> <span class="SmallNotes">Type your Serial Number</span></td>
    </tr>
    <tr align="left" valign="top"> 
      <td width="30%" class="OptionName">Site URL :<br> </td>
      <td class="OptionFields"><input name="siteurl" type="text" id="siteurl" size="40" runat="server"> 
        <br> <span class="SmallNotes">Enter your site's URL</span></td>
    </tr>
    <tr align="left" valign="top"> 
      <td width="30%" class="OptionName">Application URL :<br> </td>
      <td class="OptionFields"> <input name="applicationurl" type="text" id="applicationurl" size="40" runat="server"> 
        <br> <span class="SmallNotes">Full URL to the Application</span></td>
    </tr>
    <tr align="left" valign="top"> 
      <td class="OptionName">Time Offset :</td>
      <td class="OptionFields">Current Time on Server is <%=now%><br>
        Use a time offset of : 
        <input name="timeoffset" type="text" id="timeoffset" size="6" runat="server">
        minutes<br> <span class="SmallNotes">This setting is useful if your local 
        time differs from the server time<b>.</b></span></td>
    </tr>
    <tr align="left" valign="top"> 
      <td width="30%" class="OptionName">Session Timeouts :</td>
      <td class="OptionFields"><table width="100%" border="0" cellspacing="1" cellpadding="1">
          <tr align="left"> 
            <td width="29%" class="OptionName"><b>Representatives :</b></td>
            <td width="71%" class="OptionFields"> <input name="reptimeout" type="text" id="reptimeout" size="6" runat="server">
              Minutes </td>
          </tr>
          <tr align="left"> 
            <td width="29%" class="OptionName"><b>Customers :</b></td>
            <td width="71%" class="OptionFields"> <input name="usertimeout" type="text" id="usertimeout" size="6" runat="server">
              Minutes </td>
          </tr>
        </table></td>
    </tr>
    <tr align="left" valign="top"> 
      <td width="30%" class="OptionName">Chat Refresh Rate :</td>
      <td class="OptionFields"> <input name="refreshrate" type="text" id="refreshrate" size="6" runat="server">
        Seconds<br> <span class="SmallNotes">Refresh the Chat Messages every n 
        seconds</span></td>
    </tr>
    <tr align="left" valign="top"> 
      <td width="30%" class="OptionName">Live Monitor Refresh Rate :</td>
      <td class="OptionFields"> <input name="requestrate" type="text" id="requestrate" size="6" runat="server">
        Seconds<br> <span class="SmallNotes">Look for new requests every n seconds</span></td>
    </tr>
    <tr align="left" valign="top"> 
      <td width="30%" class="OptionName">Max. Customer Wait Time :</td>
      <td class="OptionFields"> <input name="maxwaittime" type="text" id="maxwaittime" size="6" runat="server">
        Seconds<br> <span class="SmallNotes">Maximum time to have a customer on 
        hold before assigning a Representative.<br>
        Type 0 Zero if you don't want to set up a max. time.</span></td>
    </tr>
    <tr align="left" valign="top"> 
      <td class="OptionName">Busy Requests : </td>
      <td class="OptionFields"><input name="requeue" type="checkbox" id="requeue" value="checked" runat="server">
        Requeue the request call if not taken by any representative<br>
        <input name="trackbusy" type="checkbox" id="trackbusy" value="checked" runat="server">
        Keep log of representatives that did not take a call.<br>
        Reassign requests to another representative after 
        <input name="reassignattempts" type="text" id="reassignattempts" size="6" runat="server">
        attempts.<br> <span class="SmallNotes">Use this option to reassign any 
        request not taken by the representative after n attempts.<br>
        Type 0 (zero) to disable this option.</span></td>
    </tr>
    <tr align="left" valign="top"> 
      <td width="30%" class="OptionName">Customer Chat Window : </td>
      <td class="OptionFields"><table width="100%" border="0" cellspacing="1" cellpadding="1">
          <tr valign="top"> 
            <td width="100" class="OptionName"><b>Window Title :</b></td>
            <td class="OptionFields"> <input name="chattitle" type="text" id="chattitle" size="30" runat="server"> 
            </td>
          </tr>
          <tr valign="top"> 
            <td width="100" class="OptionName"><b>Dimensions :</b></td>
            <td class="OptionFields">Width : 
              <input name="userwidth" type="text" id="userwidth" size="6" runat="server">
              - Height : 
              <input name="userheight" type="text" id="userheight" size="6" runat="server"> 
            </td>
          </tr>
        </table></td>
    </tr>
    <tr align="left" valign="top"> 
      <td class="OptionName">Pre-chat form :</td>
      <td class="OptionFields"><input name="fieldsrequired" type="checkbox" id="fieldsrequired" value="checked" runat="server">
        Customer Name and E-Mail are required fields <br> <input name="askemail" type="checkbox" id="askemail" value="checked" runat="server">
        Ask for the user's e-mail in the pre-chat form</td>
    </tr>
    <tr align="left" valign="top"> 
      <td class="OptionName">Optional Form Fields :</td>
      <td class="OptionFields">Field 1 : 
        <input name="optfield1" type="text" id="optfield1" size="30" runat="server"> 
        <input name="optfield1req" type="checkbox" id="optfield1req" value="checked" runat="server">
        Required <br>
        Field 2 : 
        <input name="optfield2" type="text" id="optfield2" size="30" runat="server"> 
        <input name="optfield2req" type="checkbox" id="optfield2req" value="checked" runat="server">
        Required<br>
        Field 3 : 
        <input name="optfield3" type="text" id="optfield3" size="30" runat="server"> 
        <input name="optfield3req" type="checkbox" id="optfield3req" value="checked" runat="server">
        Required</td>
    </tr>
    <tr align="left" valign="top"> 
      <td class="OptionName">Default Customer Nick : </td>
      <td class="OptionFields"> <input name="defaultnick" type="text" id="defaultnick" size="30" runat="server"> 
      </td>
    </tr>
    <tr align="left" valign="top"> 
      <td class="OptionName">Default Department Name :</td>
      <td class="OptionFields"> <input name="defaultdeptname" type="text" id="defaultdeptname" size="30" runat="server"> 
      </td>
    </tr>
    <tr align="left" valign="top"> 
      <td width="30%" class="OptionName">Representative Chat Window :</td>
      <td class="OptionFields">Width : 
        <input name="repwidth" type="text" id="repwidth" size="6" runat="server">
        - Height : 
        <input name="repheight" type="text" id="repheight" size="6" runat="server"> 
      </td>
    </tr>
    <tr align="left" valign="top"> 
      <td width="30%" class="OptionName">Visitor Tracking :</td>
      <td class="OptionFields"> <input name="allowtracking" type="checkbox" id="allowtracking" value="checked" runat="server">
        Enable Visitor Tracking<br> <input name="trackreps" type="checkbox" id="trackreps" value="checked" runat="server">
        Track Representatives<br> <input name="playnewvisitor" type="checkbox" id="playnewvisitor" value="checked" runat="server">
        Play sound alert when a new visitor is tracked<br>
        Refresh Tracking every 
        <input name="trackrefresh" type="text" id="trackrefresh" size="6" runat="server">
        seconds <br>
        Display up to 
        <input name="tracklimit" type="text" id="tracklimit" size="6" runat="server">
        tracked visitors on the live monitor<br>
        Do not track visitors with no activity during the last 
        <input name="tracktimeout" type="text" id="tracktimeout" size="6" runat="server">
        minutes </td>
    </tr>
    <tr align="left" valign="top"> 
      <td class="OptionName">Request Notifications : </td>
      <td class="OptionFields"><p> 
          <input name="playsound" type="checkbox" id="playsound" value="checked" runat="server">
          Play Sound Alert to representatives for new incoming requests<br>
          <input name="flashrequest" type="checkbox" id="flashrequest" value="checked" runat="server">
          Flash Incoming Request to the representative</p></td>
    </tr>
    <tr align="left" valign="top"> 
      <td class="OptionName">Chat Options : </td>
      <td class="OptionFields"><input name="logchat" type="checkbox" id="logchat" value="checked" runat="server">
        Save Session Transcripts To database<br> <input name="playnotify" type="checkbox" id="playnotify" value="checked" runat="server">
        Play Sound Alert to representatives on each customer reply <br> <input name="keepfocus" type="checkbox" id="keepfocus" value="checked" runat="server">
        Focus Chat Window to the user on each representative reply <br> <input name="keepfocusrep" type="checkbox" id="keepfocusrep" value="checked" runat="server">
        Focus Chat Window to the representative on each user reply <br>
        <input name="showuserpublicinfo" type="checkbox" id="showuserpublicinfo" value="checked" runat="server">
        Display the representative photo and public info to the user<br> <input name="notifytype" type="checkbox" id="notifytype" value="checked" runat="server">
        Notify when the other party is typing (high bandwith) </td>
    </tr>
    <tr align="left" valign="top"> 
      <td width="30%" class="OptionName">Other Options :</td>
      <td class="OptionFields"> <p> 
          <input name="buttonstatuscheck" type="checkbox" id="buttonstatuscheck" value="checked" runat="server">
          Update the support button status in real time<br>
          <input name="allowemailchat" type="checkbox" id="allowemailchat" value="checked" runat="server">
          Allow customers to e-mail a copy of the saved session transcript <br>
          <input name="getfullurl" type="checkbox" id="getfullurl" runat="server">
          Save The Full URL of the pages where the requests came from <br>
          <input name="iplookup" type="checkbox" id="iplookup" value="checked" runat="server">
          Perform IP Lookup on users <br>
          <input name="countrylookup" type="checkbox" id="countrylookup" value="checked" runat="server">
          Perform Country Lookup on users </p></td>
    </tr>
    <tr align="left" valign="top">
      <td class="OptionName"> Monitor reconnect :</td>
      <td class="OptionFields"><input name="autoreconnect" type="checkbox" id="autoreconnect" value="checked" runat="server">
        Automatically reconnect the live monitor in case of losing connection<br>
        <input name="reconnectnotify" type="checkbox" id="reconnectnotify" value="checked" runat="server">
        Notify representatives about network congestion.<br>
        <span class="SmallNotes">By checking this option, the representatives 
        will be notified each time that the live monitor loses connection to the 
        web server.</span></td>
    </tr>
    <tr align="left" valign="top"> 
      <td class="OptionName"><b>Absolute FAQ Manager Integration :</b></td>
      <td class="OptionFields">Absolute FAQ Manager .NET Application URL : 
        <input name="afmneturl" type="text" id="afmneturl" runat="server"> <br> 
        <span class="SmallNotes">Use this option to integrate your Absolute Live 
        Support .NET with Absolute FAQ Manager .NET <br>
        For more information about Absolute FAQ Manager .NET <a href="http://www.xigla.com/absolutefmnet" target="_blank">Click 
        Here</a></span></td>
    </tr>
    <tr align="left" valign="top"> 
      <td class="OptionName">Session Feedback and Rating :</td>
      <td class="OptionFields"><input name="allowrating" type="checkbox" id="allowrating" value="checked" runat="server">
        Allow customer to rate the support sessions <br> <input name="allowcomments" type="checkbox" id="allowcomments" value="checked" runat="server">
        Ask the customer for feedback on the support session </td>
    </tr>
    <tr align="left" valign="top"> 
      <td class="OptionName">Instant Messenger : </td>
      <td class="OptionFields"><input name="messenger" type="checkbox" id="messenger" value="checked" runat="server">
        Enable Instant Messenger <br>
        <span class="SmallNotes">The Instant Messenger allows representatives 
        to send instant messages to other users through the live monitor.</span></td>
    </tr>
    <tr align="left" valign="top"> 
      <td class="OptionName">Quick Words :</td>
      <td class="OptionFields"><input name="allowquickwords" type="checkbox" id="allowquickwords" value="checked" runat="server">
        Enable Quick Words<br> <span class="SmallNotes">A Quick Word is a shorcut 
        to your canned commands. Typing a quick word results in execution of its 
        corresponding command.</span></td>
    </tr>
    <tr align="left" valign="top"> 
      <td class="OptionName">Auto Engage :</td>
      <td class="OptionFields"> Enable Auto Engage after 
        <input name="autoengagetime" type="text" id="autoengagetime" size="6" runat="server">
        seconds on a page.<br> <span class="SmallNotes">This feature will automatically 
        invite the users for support if they spend more than this defined time 
        on a page.<br>
        This feature will only work on pages with the Visitor Tracking code. Type 
        0 (Zero) to disable it</span></td>
    </tr>
    <tr align="left" valign="top"> 
      <td class="OptionName">Hot Lead Tracking :</td>
      <td class="OptionFields"><p>A Hot lead is a customer referred to the website 
          with a high purchase potential. <br>
          Customers whose referral contains one of the following keywords will 
          be marked as Hot Leads :<br>
          <textarea name="hotleads" cols="40" rows="10" id="hotleads" runat="server"></textarea>
          <br>
          <span class="SmallNotes">Enter only one domain or keyword per line.<br>
          You can type full domains, but it is recommended to type just part of 
          it (I.E : google , yahoo) </span></p>
        <p>&nbsp;</p></td>
    </tr>
    <tr align="left" valign="top"> 
      <td class="OptionName">IP Filter :</td>
      <td class="OptionFields"><p>Block any requests coming from the following 
          IP Addresses : <br>
          <textarea name="blockips" cols="40" rows="7" id="blockips" runat="server"></textarea>
          <br>
          <span class="SmallNotes">Enter one IP address per line.<br>
          You can type the partial part of an IP address to block a range<br>
          </span><span class="SmallNotes">I.E : Type 200.10.25. to block any IP 
          between 200.10.25.0 and 200.10.25.255</span></p></td>
    </tr>
    <tr align="left" valign="top"> 
      <td width="30%" class="OptionName">Stats and Logs :</td>
      <td class="OptionFields">Display Stats for the Last 
        <input name="showlastdays" type="text" id="showlastdays" size="6" runat="server">
        days<br>
        Delete saved transcripts from the database after 
        <input name="purgedays" type="text" id="purgedays" size="6" runat="server">
        days <br>
        <span class="SmallNotes">Type 0 (zero) to disable</span></td>
    </tr>
    <tr align="left" valign="top"> 
      <td width="30%" class="OptionName">Invitation Messages : </td>
      <td class="OptionFields"> <p> 
          <input name="allowcustominvite" type="checkbox" id="allowcustominvite" value="checked" runat="server">
          Allow Reps. To send custom invites to the users <br>
          Default Inivitation : 
          <input name="invitemsg" type="text" id="invitemsg" size="30" runat="server">
          <br>
          <span class="SmallNotes">Message to invite the user to a proactive chat</span></p></td>
    </tr>
    <tr align="left" valign="top"> 
      <td width="30%" class="OptionName">Welcome Message :</td>
      <td class="OptionFields"> <input name="welcomemsg" type="text" id="welcomemsg" size="30" runat="server"> 
        <br> <span class="SmallNotes">A message to display to the user once the 
        chat window is loaded </span></td>
    </tr>
    <tr align="left" valign="top"> 
      <td width="30%" class="OptionName">Accepted Request Message :</td>
      <td class="OptionFields"> <input name="acceptmsg" type="text" id="acceptmsg" size="30" runat="server"> 
        <br> <span class="SmallNotes">A Message to display to the customer once 
        the request has been assigned to a representative</span></td>
    </tr>
    <tr align="left" valign="top"> 
      <td width="30%" class="OptionName">Bye message : </td>
      <td class="OptionFields"> <input name="byemsg" type="text" id="byemsg" size="30" runat="server">
        (Optional)<br> <span class="SmallNotes">You can pop a bye message to the 
        customer once he closes his chat window.</span></td>
    </tr>
    <tr align="left" valign="top"> 
      <td width="30%" class="OptionName">Leave a Message :</td>
      <td class="OptionFields"> <input type="radio" name="cform" value="1" id="cformdefault" runat="server">
        Use default form to leave a message<br> <input type="radio" name="cform" id="cformcustom" runat="server">
        Use the form at 
        <input name="contactform" type="text" id="contactform" size="20" runat="server">
        to leave a message</td>
    </tr>
    <tr align="left" valign="top"> 
      <td width="30%" class="OptionName">Default E-Mail Address : </td>
      <td class="OptionFields"> <input name="mailadmin" type="text" id="mailadmin" size="20" runat="server"> 
        <br> <span class="SmallNotes">A default e-mail address for sending e-mail 
        messages to the departments</span></td>
    </tr>
    <tr align="left" valign="top"> 
      <td width="30%" class="OptionName">SMTP Server : </td>
      <td class="OptionFields"> <input name="smtpserver" type="text" id="smtpserver" size="20" runat="server"> 
        <br> <span class="SmallNotes">Server to use for sending the e-mail messages</span></td>
    </tr>
    <tr align="left" valign="top"> 
      <td width="30%" class="OptionName">Message Subject : </td>
      <td class="OptionFields"> <input name="subject" type="text" id="subject" size="20" runat="server"> 
        <br> <span class="SmallNotes">Default Subject to use on the Messages</span></td>
    </tr>
    <tr align="left" valign="top" class="SearchCell"> 
      <td width="30%"> <input name="buttonsave" id="buttonsave" type="hidden" value="" runat="server" /></td>
      <td> <input type="button" name="button" value="Save Settings" onClick="javascript:verify()"> 
      </td>
    </tr>
  </table>
</form>
<form id="form2" target="_blank" action="streamconfig.aspx" method="post" >
  <input name="configcode2" type="hidden" id="configcode2" value="">
</form>
</body>
</html>
