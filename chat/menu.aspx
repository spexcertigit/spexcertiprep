<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim lvl as integer
sub page_load
	lvl=uservalidate(0)
	
	'/// Logs delete date ///'
	dim deletedate as string=""
	if appsettings.showlastdays>0 then deletedate=getdate(dateadd("d",-appsettings.showlastdays,todaydatetime))
	dim purgedate as string=""
	if appsettings.purgedays>0 then purgedate=getdate(dateadd("d",-appsettings.purgedays,todaydatetime))
	
	'/// Clear Stats ///'
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand
	mycommand.connection = conn
	mycommand.commandtext = "xlaALSsp_clear_stats"
	mycommand.CommandType = CommandType.StoredProcedure
	mycommand.Parameters.Add( "@deletedate" , deletedate)
	mycommand.Parameters.Add( "@purgedate" , purgedate)
	conn.open()
	mycommand.executescalar()
	conn.close()
	
end sub

</script>
<html>
<head>
<title><%=apptitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<frameset rows="74,*" frameborder="NO" border="0" framespacing="0" cols="*"> 
  <frame name="topmenu" scrolling="NO" noresize src="topmenu.aspx" >
  <frame name="main" src="start.aspx">
</frameset><noframes></noframes>
</html>
