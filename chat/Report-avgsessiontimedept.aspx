<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim dr as SqlDataReader
dim conn as New SqlConnection
dim maxavgdepttime as integer=0
dim sumtotal as integer=0
dim scalingfactor as double
dim percentfactor as double
dim showlastdays as string=""

sub page_load()
	dim lvl as integer=uservalidate(0)
	dim lastdate as string=""
	conn.connectionstring=connectionstr
	dim mycommand as New SqlCommand
	mycommand.connection = conn
	mycommand.commandtext = "xlaALSsp_report_times_per_dept"
	mycommand.CommandType = CommandType.StoredProcedure
	if appsettings.showlastdays>0 then lastdate=getdate(dateadd("d",-appsettings.showlastdays,todaydatetime))
	mycommand.Parameters.Add( "@lastdate" , lastdate)
  	conn.open()
	dr = mycommand.ExecuteReader()
	if dr.read() then maxavgdepttime=dr("maxavgdepttime")
	if maxavgdepttime>0 then scalingfactor=1/maxavgdepttime else scalingfactor=0

	if maxavgdepttime=0 then
		dr.close()
		conn.close()
		response.write("<p>&nbsp;</p><p>&nbsp;</p><p align=center><font color=#FF0000 size=2 face=Tahoma><b>No Graphic Available</b></font></p>")
		response.end
	end if
	dr.nextresult()
	
	'/// Last days Stats ///'
	if appsettings.showlastdays>0 then showlastdays=" (last " & appsettings.showlastdays & " days period)"
end sub
</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Absolute Live Support : Average session time per department<%=showlastdays%></title>
<link href="ALSStyles.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" rightmargin=0 bottommargin="0" marginheight="0">
<table width="100%" border="0" cellspacing="2" cellpadding="2">
  <tr> 
    <td class="MainTitles">Average session time per department<%=showlastdays%></td>
    <td width="80" align="right"><a href="javascript:self.print();"><img src="images/btnReportprint.gif" alt="Print Report" width="16" height="16" hspace="4" vspace="2" border="0"></a></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
  <%dim c as integer=0
  dim imgwidth as integer=0
  dim avgdepttime as string=""
  dim deptname as string=""

  do while dr.read()
	c=c+1
	deptname=dr("deptname")
	imgwidth=int(dr("avgdepttime")*scalingfactor*240)
	avgdepttime=getsessiontime(dr("avgdepttime") & "")%>
  <tr align="left" valign="top"> 
    <td width="25%" class="OptionFields"><%=deptname%></td>
    <td class="GeneralText"><img src="images/bar4.gif" width="<%=imgwidth%>" height="12" align="absmiddle"> 
      <%=avgdepttime%></td>
  </tr>
  <%loop
  dr.close()
  conn.close()%>
</table>
</body>
</html>
