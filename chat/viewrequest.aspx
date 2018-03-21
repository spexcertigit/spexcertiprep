<!--#include file="incSystem.aspx" -->
<script runat="server">
dim lvl as integer
dim requestid as string=""
dim name as string=""
dim email as string=""
dim optfield1 as string=""
dim optfield2 as string=""
dim optfield3 as string=""
dim customerid as string=""
dim transcript as string=""
dim rating as string=""
dim dateregistered as string=""
dim lastrequestdate as string=""
dim requestdate as string=""
dim deptid as string=""
dim deptname as string=""
dim userid as string=""
dim topic as string=""
dim totalrequests as integer=0
dim avgrating as integer=0
dim ratedsessions as integer=0
dim ref as string=""
dim repname as string=""
dim ip as string=""
dim hostname as string=""
dim x as integer=0
dim browser as string=""
dim os as string=""
dim co as string=""
dim country as string=""
dim sessiontime as string=""
dim hotleadref as string=""
dim visits as string=""
dim siteref as string=""
dim opportunity as string=""
dim comments as string=""
dim survey as string=""
dim busy(3,0) as string

sub page_load()
	lvl=uservalidate(0)
	requestid=request("requestid")
	if requestid="" or not(isnumeric(requestid)) then response.redirect("logout.aspx")
	
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand
	dim dr as SqlDataReader
	mycommand.connection = conn
	mycommand.commandtext = "xlaALSsp_view_request"
	mycommand.CommandType = CommandType.StoredProcedure
	mycommand.Parameters.Add( "@requestid" , requestid)
	conn.open()
	dr = mycommand.ExecuteReader()
	if dr.read() then
		name=dr("name")
		email=dr("email")
		optfield1=setaslink(dr("optfield1"))
		optfield2=setaslink(dr("optfield2"))
		optfield3=setaslink(dr("optfield3"))
		customerid=dr("customerid")
		transcript=dr("transcript") & ""
		rating=dr("rating")
		dateregistered=dr("dateregistered")&""
		lastrequestdate=dr("lastrequestdate")
		requestdate=dr("requestdate")
		deptid=dr("deptid")
		userid=dr("userid")
		topic=dr("topic")
		if topic="" then topic="Undefined"
		ref=dr("ref")
		hostname=dr("hostname")
		ip=dr("ip")
		browser=dr("browser")
		os=dr("os")
		sessiontime=getsessiontime(dr("totaltime") & "")
		visits=dr("visits")
		hotleadref=dr("hotleadref")
		siteref=dr("siteref")
		co=dr("co")
		country=dr("country")
		comments=dr("comments")
		survey=dr("survey")
	end if
	
	if comments<>"" then comments=server.htmlencode(comments)
	comments=replace(comments,vbcrlf,"<br>")
	
	survey=replace(survey,vbcrlf,"<br>")
	
	dr.nextresult()
	repname=" - Not Found -"
	if dr.read() then repname="<a href=viewuser.aspx?userid=" & dr("userid") & ">" & dr("name") & " (" & dr("usr") & ")</a>"


	dr.nextresult()
	deptname="None (Proactive Chat)"
	if dr.read() then deptname=dr("deptname")
	
	dr.nextresult()
	totalrequests=0
	avgrating=0
	if dr.read() then totalrequests=dr("totalrequests")
	
	dr.nextresult()
	if dr.read() then 
		avgrating=dr("avgrating")
		ratedsessions=dr("ratedsessions")
	end if
	
	dr.nextresult()
	x=0
	do while dr.read()
		redim preserve busy(3,x)
		busy(0,x)=dr("userid")
		busy(1,x)=dr("name") & " (" & whichlevel(dr("ulevel")) & ")"
		busy(2,x)=dr("busytime")
		if dr("simultaneous")=0 then 
			busy(3,x)=dr("attending") & " / Undefined"
		else
			busy(3,x)=dr("attending") & " / " & dr("simultaneous")
		end if
		x=x+1
	loop

	dr.close()
	conn.close()
	
	if rating<>"0" then
		dim stars as string=""
		for x=1 to val(rating)
			stars=stars & "<img src=images/star.gif>"
		next
		rating=stars & " : " & rating
	else
		rating="<b> - Not Rated - </b>"
	end if
	
	
	if siteref<>"" then siteref="<a href='" & siteref & "' alt='" & siteref & "' target=_blank>" & siteref & "</a>" else siteref="Not Available"
	
	if visits="" or not(isnumeric(visits)) or visits="0" then visits="" else opportunity="The user has visited the site " & visits & " times.<br>"
	if hotleadref<>"" then 	opportunity &="The user is a hotlead. First visit was referred from : <a href='" & hotleadref & "' alt='" & hotleadref & "' target=_blank>" & hotleadref & "</a>."
	
	if len(transcript)<1 then transcript="<span class=ErrorNotices> - No Transcript Available -</span>"

	if co="-" then imgFlag.visible=false else imgFlag.src="flags/" & lcase(co & ".gif")
	
end sub

</script>

<html>
<head>
<title><%=apptitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="styles.css" type="text/css">
<link href="ALSStyles.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
function printrequest(){
	document.all.menuoptions.style.display='none';
	self.print();
	document.all.menuoptions.style.display='';	
}

function deleterequest(){
	if (confirm('Delete request?')){
		self.location.href='search.aspx?kill=<%=requestid%>';
	}
}


// Error Handling
window.onerror = donothing;
function donothing(){
	return true;
}

function displaymessage(tosay){
	document.write(tosay + '\n');
}

function cmdpush(thisfile,repname){
	document.write('<span class=reptext><b>' + repname +'&gt; PUSH : <\/b><a href=\'' + thisfile + '\' target=_blank>' + thisfile + '<\/a><\/span>\n');
}


function cmdimage(thisfile,repname){
	document.write('<br><img src=\'' + thisfile + '\'><br>\n');
}

function cmdurl(thislink,repname){
	document.write('<span class=reptext><b>' + repname + '&gt;&nbsp;<\/b><a href=\'' + thislink + '\' target=_blank>' + thislink + '<\/a><\/span>\n');
}

function cmdemail(thislink,repname){
	document.write('<span class=reptext><b>' + repname + '&gt;&nbsp;<\/b><a href=\'mailto:' + thislink + '\'>' + thislink + '<\/a><\/span>\n');
}

</script>
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="96%" border="0" align="center" cellpadding="0" cellspacing="3">
  <tr id="menuoptions" style="display:"> 
    <td width="28%" class="MainTitles"><img src="images/icSearch.gif" width="20" height="20" align="absmiddle"> 
      View Request</td>
    <td align="right"><a href="javascript:printrequest();"><img src="images/btnPrintRequest.gif" width="118" height="25" border="0" alt="Print Request"></a> 
      <%if lvl=1 then%>
      <a href="javascript:deleterequest();"><img src="images/btnDeleteRequest.gif" width="118" height="25" border="0"></a> 
      <%end if%>
    </td>
  </tr>
  <tr align="left" valign="top"> 
    <td width="28%">
<table width="98%" border="1" cellspacing="1" cellpadding="3" style="table-layout:fixed">
        <tr> 
          <td height="30" class="Headers"><b>Customer Information</b></td>
        </tr>
        <tr> 
          <td class="OptionName"><b>Customer ID # <%=customerid%></b></td>
        </tr>
        <tr> 
          <td class="OptionFields"><b>Name :</b><br> <%=name%> </td>
        </tr>
        <tr> 
          <td class="OptionFields"><b>E-Mail :</b><br> <a href="mailto:<%=email%>"><%=email%></a> 
          </td>
        </tr>
        <%if appsettings.optfield1<>"" and optfield1<>"" then%>
        <tr> 
          <td class="OptionFields"><b><%=appsettings.optfield1%> :</b><br> <%=optfield1%> 
          </td>
        </tr>
        <%end if%>
        <%if appsettings.optfield2<>"" and optfield2<>"" then%>
        <tr> 
          <td class="OptionFields"><b><%=appsettings.optfield2%> :</b><br> <%=optfield2%> 
          </td>
        </tr>
        <%end if%>
        <%if appsettings.optfield3<>"" and optfield3<>"" then%>
        <tr> 
          <td class="OptionFields"><b><%=appsettings.optfield3%> :</b><br> <%=optfield3%> 
          </td>
        </tr>
        <%end if%>
        <tr> 
          <td class="OptionFields"><b>Date registered :</b><br> <%=dateregistered%> 
          </td>
        </tr>
        <tr> 
          <td class="OptionFields"><b>Last request :</b><br> <%=lastrequestdate%> 
          </td>
        </tr>
        <tr> 
          <td class="OptionFields"><b>Total Requests :</b><br> <a href="search.aspx?name=<%=customerid%>"><%=totalrequests%></a> 
          </td>
        </tr>
        <tr> 
          <td class="OptionFields"><b>Average session rating :</b><br> <%=formatnumber(avgrating,2)%> 
            on <%=ratedsessions%> sessions </td>
        </tr>
        <tr> 
          <td class="OptionFields"><strong> IP Address / Host :</strong><br> <%=ip%> 
            (<%=hostname%>)</td>
        </tr>
        <tr> 
          <td class="OptionFields"><b>Browser :</b><%=browser%><br> <b>OS :</b> 
            <%=os%> </td>
        </tr>
        <tr> 
          <td class="OptionFields"><b>Site Refererral :</b><br> <%=siteref%></td>
        </tr>
        <tr> 
          <td class="OptionFields"><b>Lead / Opportunity :</b><br> <%=opportunity%> 
          </td>
        </tr>
        <tr> 
          <td class="OptionFields"><b>Country Lookup :</b><br> <img src="flags/-.gif" align="absmiddle" id="imgFlag" width="18" height="12" runat="server"> 
            <%=country%></td>
        </tr>
      </table></td>
    <td><table width="100%" border="0" cellspacing="1" cellpadding="3" align="center">
        <tr class="Headers"> 
          <td height="30" colspan="2"><b>Request Information</b></td>
        </tr>
        <tr align="left" valign="top"> 
          <td class="OptionName"><b>Topic :</b></td>
          <td class="OptionFields"><%=topic%></td>
        </tr>
        <tr align="left" valign="top"> 
          <td width="29%" class="OptionName"><b>Request ID #</b></td>
          <td width="71%" class="OptionFields"><b><%=requestid%></b></td>
        </tr>
        <tr align="left" valign="top"> 
          <td width="29%" class="OptionName"><b>Request Date :</b></td>
          <td width="71%" class="OptionFields"><%=requestdate%></td>
        </tr>
        <tr align="left" valign="top"> 
          <td width="29%" class="OptionName"><b>Department :</b></td>
          <td width="71%" class="OptionFields"><%=deptname%></td>
        </tr>
        <tr align="left" valign="top"> 
          <td width="29%" class="OptionName"><b>Representative :</b></td>
          <td width="71%" class="OptionFields"><%=repname%></td>
        </tr>
        <tr align="left" valign="top"> 
          <td class="OptionName">Session Time : </td>
          <td class="OptionFields"><%=sessiontime%></td>
        </tr>
        <tr align="left" valign="top"> 
          <td class="OptionName"><b>Rating :</b></td>
          <td class="OptionFields"><%=rating%></td>
        </tr>
        <tr align="left" valign="top"> 
          <td class="OptionName">User Comments :</td>
          <td class="OptionFields"><%=comments%></td>
        </tr>
        <tr align="left" valign="top">
          <td class="OptionName">Survey :</td>
          <td class="OptionFields">&nbsp;</td>
        </tr>
      </table>
      <br>
      <table width="100%" border="0" cellpadding="2" cellspacing="1" class="Headers">
        <tr> 
          <td height="30">Session Transcript</td>
        </tr>
        <tr> 
          <td height="120" align="left" valign="top" bgcolor="#FFFFFF"><%=transcript%></td>
        </tr>
      </table>
      <br>
      <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center">
        <tr class="Headers"> 
          <td height="30" colspan="3"><b>Busy Representatives (Reps who were assigned 
            this call but refused it)</b></td>
        </tr>
        <tr align="left" valign="top"> 
          <td width="25%" align="center" class="OptionName">Time</td>
          <td class="OptionName">Representative</td>
          <td align="center" class="OptionName">Attending</td>
        </tr>
        <%for x=0 to busy.getupperbound(1)%>
        <tr align="left" valign="top"> 
          <td width="25%" align="center" class="OptionFields"><%=busy(2,x)%>&nbsp;</td>
          <td class="OptionFields"><a href="viewuser.aspx?userid=<%=busy(0,x)%>"><%=busy(1,x)%></a></td>
          <td align="center" class="OptionFields"><%=busy(3,x)%>&nbsp;</td>
        </tr>
        <%next%>
      </table></td>
  </tr>
</table>
</body>
</html>
