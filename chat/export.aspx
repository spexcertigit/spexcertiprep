<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim format as string=""
dim resultquery as string=""
dim depts as new hashtable()

function exporttime(what) as string
	if instr(what,"(")<>0 then what=left(what,8) else what=""
	exporttime=what
end function



sub page_load()
	dim lvl as integer=uservalidate(1)
	format=request("format")
	resultquery=request("resultquery")
	resultquery=server.urldecode(resultquery)
	
	if format<>"" then
		'/// To Excel 
		Response.Clear
		Response.Buffer = TRUE
		Response.Expires = 0
		Response.ContentType="application/octetstream"
		Response.AddHeader("Pragma", "no-cache")
		Response.AddHeader("Content-Disposition", "attachment; filename=Requests.xls")
	end if 
	
end sub


</script>
<%if format="" then%>
<html>
<head>
<title>Absolute Live Support : <%=appsettings.license%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body bgcolor="#FFFFFF" text="#000000" onload="goprint();">
<script language="JavaScript">
function goprint(){
	if (confirm('Print Now?')) self.print();
}
</script>
<%end if%>
<table border="1" cellpadding="2" width="100%" cellspacing="2">
  <tr> 
    <td align="right" width="6%" bgcolor="#FFCC00"><b>#</b></td>
    <td align="center" bgcolor="#FFCC00"><b>Request Topic <br>
      </b></td>
    <td align="center" bgcolor="#FFCC00" width="16%"><b>Customer</b></td>
    <td align="center" bgcolor="#FFCC00" width="16%"><b>E-Mail</b></td>
    <td align="center" width="12%" bgcolor="#FFCC00"><b>Dept.</b></td>
    <td align="center" width="12%" bgcolor="#FFCC00"><b>Date</b></td>
    <td  align="center" width="10%" bgcolor="#FFCC00"><b> ID</b></td>
    <td  align="center" width="10%" bgcolor="#FFCC00"><b>Country</b></td>
    <td  align="center" width="10%" bgcolor="#FFCC00"><b>Visits</b></td>
    <td  align="center" width="10%" bgcolor="#FFCC00"><b>Came From</b></td>
    <td  align="center" width="10%" bgcolor="#FFCC00"><b>Hotlead Referral</b></td>
    <td  align="center" width="8%" bgcolor="#FFCC00"><b>Rating<br>
      </b></td>
    <td  align="center" width="10%" bgcolor="#FFCC00"><b>Comments</b></td>
    <td  align="center" width="10%" bgcolor="#FFCC00"><b>Survey</b></td>
    <td  align="center" width="8%" bgcolor="#FFCC00"><b>Session Time</b></td>
  </tr>
  <%
  	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand
	dim dr as SqlDataReader
	mycommand.connection = conn
	mycommand.commandtext = "xlaALSsp_export_results"
	mycommand.CommandType = CommandType.StoredProcedure
	mycommand.Parameters.Add( "@psql" , resultquery)
	conn.open()
	dr = mycommand.ExecuteReader()
	do while dr.read()
		depts.add(dr("deptid"),dr("deptname"))
	loop
	
	dr.nextresult()
	dim cc as integer=0
	dim rating as string=""
	dim comments as string=""
	dim survey as string=""
  	do while dr.read()
		comments=dr("comments") & ""
		survey=dr("survey") & ""
		if comments<>"" then comments=server.htmlencode(comments)
		comments=replace(comments,vbcrlf,"<br>")
		survey=replace(survey,vbcrlf,"<br>")
		cc=cc+1
		rating=dr("rating")
		if rating="" then rating="Not Rated"%>
  <tr valign="top"> 
    <td width="6%" align="right"><%=cc%>.</td>
    <td align="left"><b><%=dr("topic")%> </b></td>
    <td width="165" valign="middle"><%=dr("name")%> </td>
    <td width="16%" valign="middle"><a href=mailto:<%=dr("email")%>><%=dr("email")%></a>&nbsp;</td>
    <td width="12%" valign="middle"><%=depts(dr("deptid"))%>&nbsp;</td>
    <td width="12%" align="center" valign="middle"><%=dr("requestdate")%>&nbsp;</td>
    <td width="10%" align="center" valign="middle"><b><%=dr("requestid")%></b>&nbsp;</td>
    <td width="10%" valign="middle"><%=dr("country")%>&nbsp;</td>
    <td width="10%" valign="middle"><%=dr("visits")%>&nbsp;</td>
    <td width="10%" valign="middle"><%=dr("hotleadref")%>&nbsp;</td>
    <td width="10%" valign="middle"><a href="<%=dr("siteref")%>"><%=dr("siteref")%></a>&nbsp;</td>
    <td width="8%" valign="middle" align="center"><b><%=rating%>&nbsp;</b></td>
    <td width="10%" valign="middle"><%=comments%>&nbsp;</td>
    <td width="10%" valign="middle"><%=survey%>&nbsp;</td>
    <td width="8%" valign="middle" align="center"><%=exporttime(getsessiontime(dr("totaltime") & ""))%>&nbsp;</td>
  </tr>
  <%loop
	dr.close()
	conn.close()%>
</table>
<%if format="" then%>
</body>
<%end if%>

