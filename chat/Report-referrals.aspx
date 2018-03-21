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
	if appsettings.showlastdays>0 then lastdate=getdate(dateadd("d",-appsettings.showlastdays,todaydatetime))
	conn.connectionstring=connectionstr
	dim mycommand as New SqlCommand
	mycommand.connection = conn
	mycommand.commandtext = "xlaALSsp_report_site_referrals"
	mycommand.CommandType = CommandType.StoredProcedure
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
    <td class="MainTitles">Top 50 site referrals<%=showlastdays%></td>
    <td width="80" align="right"><a href="javascript:self.print();"><img src="images/btnReportprint.gif" alt="Print Report" width="16" height="16" hspace="4" vspace="2" border="0"></a></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
  <%
  dim imgwidth as integer=0
  dim percentage as double=0
  dim siteref as string=""
  do while dr.read()
	siteref=dr("siteref") & ""
	if siteref="" then siteref="Undefined"
	if len(siteref)>55 then siteref=left(siteref,55) & "..."
	imgwidth=int(dr("totalrefs")*scalingfactor*240)
	percentage=formatnumber(dr("totalrefs")*percentfactor*100,1)%>
  <tr> 
    <td width="36%" class="OptionFields"><a href="<%=dr("siteref")%>" target="_blank" class="SmallNotes" title="<%=dr("siteref")%>"><%=siteref%></a></td>
    <td width="7%" align="right" class="GeneralText"><%=percentage%>%</td>
    <td class="GeneralText"><img src="images/bar4.gif" width="<%=imgwidth%>" height="12" align="absmiddle"> 
      <%=dr("totalrefs")%></td>
  </tr>
  <%loop
  dr.close()
  conn.close()%>
</table>
</body>
</html>
