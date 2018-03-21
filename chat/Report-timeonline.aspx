<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim x as integer=0
dim logssince as string="There are no logs in the database"
dim conn as SqlConnection
dim mycommand as New  SqlCommand
dim dr as SqlDataReader
dim totalseconds as integer=0

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
		filllistbox(ddlUser," -- ALL --", "0", "0")
		do while dr.read()
			user=dr("name") & " (" & whichlevel(dr("ulevel")) & ")"
			filllistbox(ddlUser,user,dr("userid"),"0")
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
	end if
	
	'//// Run Search ///'
	dim startdate as string=listboxresults(ddlYear1,"") & "/" & right("0" & listboxresults(ddlMonth1,""),2) & "/" & right("0" & listboxresults(ddlDay1,""),2)
	dim enddate as string=listboxresults(ddlYear2,"") & "/" & right("0" & listboxresults(ddlMonth2,""),2) & "/" & right("0" & listboxresults(ddlDay2,""),2)
	
	
	mycommand.connection = conn
	mycommand.parameters.clear()
	mycommand.commandtext = "xlaALSsp_report_login_times"
	mycommand.Parameters.Add( "@userid" , listboxresults(ddlUser,"0"))
	mycommand.Parameters.Add( "@startdate" , startdate)
	mycommand.Parameters.Add( "@enddate" , enddate)
	mycommand.CommandType = CommandType.StoredProcedure
	conn.open()
	dr = mycommand.ExecuteReader()
	if dr.read() then 
		if isdate(dr("logssince")) then logssince="There are logs in the database since " & revertdate(dr("logssince"))
	end if
	dr.nextresult()

end sub
</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Absolute Live Support : Time Online</title>
<link href="ALSStyles.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" rightmargin=0 bottommargin="0" marginheight="0">
<form runat="server" style="margin:0">
<table width="100%" border="0" cellspacing="2" cellpadding="2">
  <tr> 
      <td class="MainTitles">Time Online</td>
    <td width="80" align="right"><a href="javascript:self.print();"><img src="images/btnReportprint.gif" alt="Print Report" width="16" height="16" hspace="4" vspace="2" border="0"></a></td>
  </tr>
</table>
  <table width="100%" border="0" cellspacing="2" cellpadding="2">
    <tr> 
      <td colspan="2" class="SearchCell"></td>
    </tr>
    <tr> 
      <td width="25%" class="OptionName">Representative :</td>
      <td width="80" class="OptionFields"><asp:dropdownlist ID="ddlUser" runat="server" CssClass="SmallNotes" /></td>
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
      <td height="30" valign="middle" class="Headers">User</td>
      <td width="10%" height="30" align="center" valign="middle" class="Headers">Level</td>
      <td width="22%" height="30" align="center" valign="middle" class="Headers">Went 
        Online</td>
      <td width="22%" height="30" align="center" valign="middle" class="Headers">Last 
        Activity</td>
      <td width="22%" height="30" align="center" valign="middle" class="Headers">Session 
        Time</td>
    </tr>
    <%dim sessiontime as string=""
   do while dr.read()
   totalseconds=totalseconds + datediff("s",dr("wentonline"),dr("lastping"))
   sessiontime=getsessiontime(datediff("s",dr("wentonline"),dr("lastping")))  %>
    <tr valign="top"> 
      <td align="left" class="OptionFields"><a href="viewuser.aspx?userid=<%=dr("userid")%>" target="_parent"><%=dr("name")%></a></td>
      <td width="10%" align="center" class="OptionFields"><b><%=whichlevel(dr("ulevel"))%></b></td>
      <td width="22%" align="center" class="OptionFields"><%=dr("wentonline")%></td>
      <td width="22%" align="center" class="OptionFields"><%=dr("lastping")%>&nbsp;</td>
      <td width="22%" align="left" class="OptionFields"><%=left(sessiontime,8)%></td>
    </tr>
    <%loop
  dr.close()
  conn.close()%>
    <tr valign="top"> 
      <td colspan="4" align="right"><span class="GeneralText"><b>TOTAL TIME ONLINE 
        </b></span>:</td>
      <td align="left" class="OptionName"><%=left(getsessiontime(totalseconds),8)%></td>
    </tr>
  </table>
</form>
</body>
</html>
