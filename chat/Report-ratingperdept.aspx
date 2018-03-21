<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim showlastdays as string=""
sub page_load()
	dim lvl as integer=uservalidate(0)
	'/// Last days Stats ///'
	if appsettings.showlastdays>0 then showlastdays=" (last " & appsettings.showlastdays & " days period)"
end sub
</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Absolute Live Support : Average Rating per Department<%=showlastdays%></title>
<link href="ALSStyles.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" rightmargin=0 bottommargin="0" marginheight="0">
<table width="100%" border="0" cellspacing="2" cellpadding="2">
  <tr>
    <td class="MainTitles">Average rating per department<%=showlastdays%></td>
    <td width="80" align="right"><a href="javascript:self.print();"><img src="images/btnReportprint.gif" alt="Print Report" width="16" height="16" hspace="4" vspace="2" border="0"></a></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
  <%
  	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand
	dim dr as SqlDataReader
	dim x as integer=0
	dim lastdate as string=""
	dim avgrating as integer=0
	dim stars as string=""
	dim totalrequests as integer=0
	mycommand.connection = conn
	mycommand.commandtext = "xlaALSsp_report_rating_per_dept"
	mycommand.CommandType = CommandType.StoredProcedure
	if appsettings.showlastdays>0 then lastdate=getdate(dateadd("d",-appsettings.showlastdays,todaydatetime))
	mycommand.Parameters.Add( "@lastdate" , lastdate)
  	conn.open()
	dr = mycommand.ExecuteReader()
	do while dr.read()
		avgrating=formatnumber(dr("avgrating"),2)
		totalrequests=dr("totalrequests")
		stars=""
		
		for x=1 to int(avgrating)
			stars=stars & "<img src=images/star.gif>"
		next%>
  <tr> 
    <td width="24%" bgcolor="#EFEFEF" class="OptionFields"><%=dr("deptname")%></td>
    <td width="10%" align="left"><%=stars%></td>
    <td class="GeneralText"><b><%=avgrating%></b>&nbsp; on <%=totalrequests%> 
      Requests</td>
  </tr>
  <%loop
	dr.close()
	conn.close()%>
</table>
</body>
</html>
