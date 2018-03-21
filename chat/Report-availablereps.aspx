<!-- #include file="incSystem.aspx" -->
<script runat="server">
sub page_load()
	if getusrid="" or getusrid="0" then response.end
end sub
</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Reprentative's Availability</title>
<link href="ALSStyles.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function refresh(){window.location.reload( true );}

function startrefresh(){
	setTimeout( "refresh()", 60000 );
}
</script>

</head>
<body leftmargin="0" topmargin="0" marginwidth="0" rightmargin=0 bottommargin="0" marginheight="0" onload="javascript:startrefresh();">
<table width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#999999">
  <tr class="OptionName"> 
    <td><b>User</b></td>
    <td align="center"><b>Attending</b></td>
    <td align="center"><b>Time On-line</b></td>
    <td align="center"><b>Status</b></td>
  </tr>
  <%
  	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand
	dim dr as SqlDataReader
	dim c as integer=0
	dim timeonline as string=""
	dim imgstatus as string=""
	mycommand.connection = conn
	mycommand.commandtext = "xlaALSsp_report_available_reps"
	mycommand.CommandType = CommandType.StoredProcedure
  	conn.open()
	dr = mycommand.ExecuteReader()
	do while dr.read()
  		c=c+1
		if isdate(dr("onlinesince")) then 
			timeonline=datediff("n",cdate(dr("onlinesince")),todaydatetime)  & " mins"
		else 
			timeonline=" - "
		end if
		%>
  <tr class="OptionFields"> 
    <td width="40%" class="GeneralText"><%=dr("name")%></td>
    <td width="20%" align="center" class="GeneralText"><%=dr("attending")%></td>
    <td width="20%" align="center" class="GeneralText"><%=timeonline%></td>
    <td width="20%" align="center"><img src="images/imgOnline.gif" width="27" height="27"><br>
      <span class="GeneralText">Online</span> </td>
  </tr>
  <%loop
  dr.close()
  conn.close()%>
</table>
</body>
</html>
