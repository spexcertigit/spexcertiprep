<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim x as integer=0
dim logssince as string="There are no logs in the database"
dim conn as SqlConnection
dim mycommand as New  SqlCommand
dim dr as SqlDataReader
dim totalseconds as integer=0

function wasattended(user as integer) as string
	if user=0 then 
		wasattended="Never Attended"
	else
		wasattended="Attended"
	end if
end function

sub page_load()
	dim lvl as integer=uservalidate(1)
	conn=New SqlConnection(connectionstr)
	
	if not(ispostback) then

		dim user as string=""
		mycommand.connection = conn
		mycommand.commandtext = "xlaALSsp_list_all_users"
		mycommand.CommandType = CommandType.StoredProcedure
		conn.open()
		dr = mycommand.ExecuteReader()
		filllistbox(ddlUser,"-- ANY --", "0", "")
		filllistbox(ddlUser,"USER : ", "0", "")
		do while dr.read()
			user=" - " & dr("name") & " (" & whichlevel(dr("ulevel")) & ")"
			filllistbox(ddlUser, user,"u" & dr("userid"),"0")
		loop
		dr.close()
		conn.close()
		
		mycommand.connection = conn
		mycommand.commandtext = "xlaALSsp_list_all_depts"
		mycommand.CommandType = CommandType.StoredProcedure
		conn.open()
		dr = mycommand.ExecuteReader()
		filllistbox(ddlUser,"", "0", "")
		filllistbox(ddlUser,"DEPT : ", "0", "")
		do while dr.read()
			filllistbox(ddlUser," - " & dr("deptname"),"d" & dr("deptid"),"0")
		loop
		dr.close()
		conn.close()
		
		'/// Fill dates ///'
		for x=1 to 12
			filllistbox(ddlMonth1,monthname(x),x,month(todaydate))
			filllistbox(ddlMonth2,monthname(x),x,month(todaydate))
		next
		'Days
		for x=1 to 31
			filllistbox(ddlDay1,x,x,day(todaydate))
			filllistbox(ddlDay2,x,x,day(todaydate))
		next
		'Years
		for x=year(todaydate)-15 to year(todaydate)+15
			filllistbox(ddlYear1,x,x,year(todaydate))
			filllistbox(ddlYear2,x,x,year(todaydate))
		next
		
	
		'/// Attended ///'
		filllistbox(ddlAttended,"Doesn't matter","-","")
		filllistbox(ddlAttended,"Never attended","0","")
		filllistbox(ddlAttended,"Attended","1","")
	end if
	

	
	'//// Run Search ///'
	dim startdate as string=listboxresults(ddlYear1,"") & "/" & right("0" & listboxresults(ddlMonth1,""),2) & "/" & right("0" & listboxresults(ddlDay1,""),2)
	dim enddate as string=listboxresults(ddlYear2,"") & "/" & right("0" & listboxresults(ddlMonth2,""),2) & "/" & right("0" & listboxresults(ddlDay2,""),2)
	dim attended as string=listboxresults(ddlAttended,"")
	dim repdept as string=listboxresults(ddlUser,"0")
	dim deptid as integer=0
	dim userid as integer=0
	if repdept.startswith("d") then deptid=val(repdept)
	if repdept.startswith("u") then userid=val(repdept)

	dim psql as string=""
	psql = "SELECT min(busytime) as logssince from xlaALSBusy_times;" & vbcrlf
	psql &= "SELECT  COUNT(xlaALSBusy_times.requestid) AS totalbusy, xlaALSRequests.topic, xlaALSRequests.requestid, xlaALSRequests.requestdate, xlaALSRequests.userid "
	psql &=" FROM xlaALSBusy_times INNER JOIN xlaALSRequests ON xlaALSBusy_times.requestid = xlaALSRequests.requestid "
	psql &=" WHERE xlaALSBusy_times.busytime>='" & startdate & "' and xlaALSBusy_times.busytime<='" & enddate & "z' "
	if attended="0" then 
		psql &=" and xlaALSrequests.userid=0 "
	else if attended="1" then
		psql &=" and xlaALSrequests.userid<>0 "
	end if
	if deptid<>0 then psql &=" and xlaALSBusy_times.userid in (select userid from xlaALSiDeptsUsers where deptid=" & deptid & ") "
	if userid<>0 then psql &=" and xlaALSBusy_times.userid=" & userid 
	psql &=" GROUP BY xlaALSRequests.topic, xlaALSRequests.requestid, xlaALSRequests.requestdate, xlaALSRequests.userid"
	
	
	mycommand.connection = conn
	mycommand.parameters.clear()
	mycommand.commandtext = "xlaALSsp_report_free_report"
	mycommand.Parameters.Add( "@psql" , psql)
	mycommand.CommandType = CommandType.StoredProcedure
	conn.open()
	dr = mycommand.ExecuteReader()
	if dr.read() then  
		if dr("logssince") & ""<>""  then 
			logssince="There are logs in the database since " & revertdate(dr("logssince"))
		else
			logssince="There are no logs available"
		end if
	end if
	dr.nextresult()

end sub
</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Absolute Live Support : Busy Requests</title>
<link href="ALSStyles.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" rightmargin=0 bottommargin="0" marginheight="0">
<form runat="server" style="margin:0">
<table width="100%" border="0" cellspacing="2" cellpadding="2">
  <tr> 
      <td class="MainTitles">Busy Requests</td>
    <td width="80" align="right"><a href="javascript:self.print();"><img src="images/btnReportprint.gif" alt="Print Report" width="16" height="16" hspace="4" vspace="2" border="0"></a></td>
  </tr>
</table>
  <table width="100%" border="0" cellspacing="2" cellpadding="2">
    <tr> 
      <td colspan="2" class="SearchCell"></td>
    </tr>
    <tr> 
      <td width="25%" class="OptionName">Representative / Department :</td>
      <td width="80" class="OptionFields"><asp:dropdownlist ID="ddlUser" runat="server" CssClass="SmallNotes" /></td>
    </tr>
    <tr>
      <td class="OptionName">Attended :</td>
      <td class="OptionFields"><asp:dropdownlist ID="ddlAttended" runat="server" CssClass="SmallNotes" /></td>
    </tr>
    <tr> 
      <td class="OptionName">Between :</td>
      <td class="OptionFields"> <asp:dropdownlist ID="ddlMonth1" runat="server" CssClass="SmallNotes"  />
        / 
        <asp:dropdownlist ID="ddlDay1" runat="server" CssClass="SmallNotes"  />
        / 
        <asp:dropdownlist ID="ddlYear1" runat="server" CssClass="SmallNotes"  />
        And 
        <asp:dropdownlist ID="ddlMonth2" runat="server" CssClass="SmallNotes"  />
        / 
        <asp:dropdownlist ID="ddlDay2" runat="server" CssClass="SmallNotes"  />
        / 
        <asp:dropdownlist ID="ddlYear2" runat="server" CssClass="SmallNotes"  /> <input type="submit" name="Submit" value="Submit" class="SmallNotes"> 
      </td>
    </tr>
    <tr> 
      <td class="OptionName">Logs Availability :</td>
      <td class="OptionFields"><%=logssince%></td>
    </tr>
    <tr> 
      <td colspan="2" class="SearchCell"></td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="2" cellpadding="2">
    <tr valign="top"> 
      <td width="5%" align="right" valign="middle" class="Headers">#</td>
      <td height="30" valign="middle" class="Headers">Request Topic</td>
      <td width="15%" align="center" valign="middle" class="Headers">ID</td>
      <td width="15%" height="30" align="center" valign="middle" class="Headers">Date</td>
      <td width="15%" height="30" align="center" valign="middle" class="Headers">Busy 
        Hits </td>
      <td width="15%" height="30" align="center" valign="middle" class="Headers">Attended</td>
    </tr>
    <%dim cc as integer=0
	   do while dr.read()  
	   cc=cc+1  %>
    <tr valign="top"> 
      <td width="5%" align="right" class="OptionFields"><%=cc%>.</td>
      <td align="left" class="OptionFields"><a href="viewrequest.aspx?requestid=<%=dr("requestid")%>" target="_parent"><%=dr("topic")%></a></td>
      <td width="15%" align="center" class="OptionFields"><b><a href="viewrequest.aspx?requestid=<%=dr("requestid")%>" target="_parent"><%=dr("requestid")%>&nbsp;</a></b></td>
      <td width="15%" align="center" class="OptionFields"><%=dr("requestdate")%></td>
      <td width="15%" align="center" class="OptionFields"><%=dr("totalbusy")%>&nbsp;</td>
      <td width="15%" align="center" class="OptionFields"><%=wasattended(dr("userid"))%></td>
    </tr>
    <%loop
  dr.close()
  conn.close()%>
  </table>
</form>
</body>
</html>
