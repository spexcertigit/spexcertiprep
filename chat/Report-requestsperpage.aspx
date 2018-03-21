<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim dr as SqlDataReader
dim conn as New SqlConnection
dim maxtotal as integer=0
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
	mycommand.commandtext = "xlaALSsp_report_requests_per_page"
	mycommand.CommandType = CommandType.StoredProcedure
	if appsettings.showlastdays>0 then lastdate=getdate(dateadd("d",-appsettings.showlastdays,todaydatetime))
	mycommand.Parameters.Add( "@lastdate" , lastdate)
  	conn.open()
	dr = mycommand.ExecuteReader()
	dr.read()
	maxtotal=dr("maxtotal")
	sumtotal=dr("sumtotal")
	if maxtotal>0 then scalingfactor=1/maxtotal else scalingfactor=0
	if sumtotal>0 then percentfactor=1/sumtotal else percentfactor=0

	if maxtotal=0 then
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
<title>Absolute Live Support : Requests per Referer<%=showlastdays%></title>
<link href="ALSStyles.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" rightmargin=0 bottommargin="0" marginheight="0">
<table width="100%" border="0" cellspacing="2" cellpadding="2">
  <tr> 
    <td class="MainTitles">Requests per page<%=showlastdays%></td>
    <td width="80" align="right"><a href="javascript:self.print();"><img src="images/btnReportprint.gif" alt="Print Report" width="16" height="16" hspace="4" vspace="2" border="0"></a></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
  <%dim c as integer=0
  dim imgwidth as integer=0
  dim percentage as double=0
  dim ref as string=""
  do while dr.read()
	c=c+1
	ref=dr("ref")
	if len(ref)<2 then ref="Local"
	if len(ref)>55 then ref=left(ref,55) & "..."
	if c>4 then c=1
	imgwidth=int(dr("totalrequests")*scalingfactor*240)
	percentage=formatnumber(dr("totalrequests")*percentfactor*100,1)%>
  <tr> 
    <td width="36%" class="OptionFields"><a href="<%=dr("ref")%>" target="_blank" class="SmallNotes" title="<%=dr("ref")%>"><%=ref%></a></td>
    <td width="7%" align="right" class="GeneralText"><%=percentage%>%</td>
    <td class="GeneralText"><img src="images/bar4.gif" width="<%=imgwidth%>" height="12" align="absmiddle"> 
      <%=dr("totalrequests")%></td>
  </tr>
  <%loop
  dr.close()
  conn.close()%>
</table>
</body>
</html>
