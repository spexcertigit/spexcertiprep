<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim dr as SqlDataReader
dim conn as new sqlconnection
dim depts as new hashtable()
dim users as new hashtable()

sub page_load()
	dim lvl as integer=uservalidate(0)
	dim lastmsgdate as string=getdate(dateadd("n",-appsettings.reptimeout*1.5,todaydatetime))
	
	conn.connectionstring=connectionstr
	dim mycommand as New SqlCommand
	mycommand.connection = conn
	mycommand.commandtext = "xlaALSsp_report_current_sessions"
	mycommand.CommandType = CommandType.StoredProcedure
	mycommand.Parameters.Add( "@lastmsgdate" , lastmsgdate)
  	conn.open()
	dr = mycommand.ExecuteReader()
	
	'/// get Departments ///'
	depts.add("0"," - ")
	do while dr.read()
		depts.add(dr("deptid"),dr("deptname"))
	loop
	
	'/// Get Representatives ///'
	dr.nextresult()
	users.add("0"," - ")
	do while dr.read()
		users.add(dr("userid"),dr("name"))
	loop

end sub
</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Absolute Live Support : Requests per Day</title>
<link href="ALSStyles.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function refresh(){window.location.reload( true );}

function startrefresh(){
	setTimeout( "refresh()", 60000 );
}
</script>

</head>
<body leftmargin="0" topmargin="0" marginwidth="0" rightmargin=0 bottommargin="0" marginheight="0" onload="javascript:startrefresh();">
<table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#666666">
  <tr> 
    <td width="6%" align="center" class="OptionName">ID</td>
    <td width="15%" class="OptionName">Customer</td>
    <td class="OptionName">Topic</td>
    <td width="16%" class="OptionName">Department</td>
    <td width="16%" class="OptionName">Representative</td>
    <td width="5%" align="center" class="OptionName"> Rating</td>
  </tr>
<%
'/// Get Active requests ///'
dr.nextresult()
do while dr.read()
%>  
  <tr> 
    <td width="6%" align="center" class="OptionFields"><a href="viewrequest.aspx?requestid=<%=dr("requestid")%>" target="main"><b><%=dr("requestid")%></b></a></td>
    <td width="15%" class="OptionFields"><%=dr("name")%></td>
    <td class="OptionFields"><%=dr("topic")%></td>
    <td width="16%" class="OptionFields"><%=depts(dr("deptid"))%></td>
    <td width="16%" class="OptionFields"><a href="viewuser.aspx?userid=<%=dr("userid")%>" target="main"><%=users(dr("userid"))%></a></td>
    <td width="5%" align="center" class="OptionFields"><%=dr("rating")%></td>
  </tr>
  <%loop
  dr.close()
  conn.close()%>
</table>
</body>
</html>
