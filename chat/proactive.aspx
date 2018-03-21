<!--#include file="incSystem.aspx" -->
<script runat="server">
dim userid as string=""
dim myinvitemsg as string=""
dim ip as string=""
sub page_load
	'/// Is tracking enabled ? ///'
	if appsettings.allowtracking="" then response.end
	'dim ip as string=request.ServerVariables("REMOTE_ADDR") & ""
	ip=request.ServerVariables("REMOTE_ADDR") & ""

	'/// Is the User queued for proactive chat ?  ///'
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand("xlaALSsp_check_invite",conn)
	dim dr as SqlDataReader
	mycommand.commandType =  CommandType.Storedprocedure
	mycommand.Parameters.Add( "@ip" , ip )
	conn.open()
	dr = mycommand.ExecuteReader()
	if dr.read() then 
		myinvitemsg=dr("invitemsg")
		userid=dr("invitedby")
		if myinvitemsg="" then myinvitemsg=appsettings.invitemsg
	end if
	dr.close()
	conn.close()
	myinvitemsg=server.urlencode(myinvitemsg)
end sub

</script>
<%if userid<>"" then%>
<script language="JavaScript" type="text/JavaScript">
xlaALSwindow=window.open("<%=appsettings.applicationurl%>UserProactive.aspx?u=<%=userid%>&myinvitemsg=<%=myinvitemsg%>" ,"ALSRoom","toolbar=0,location=0,status=0,menubar=0,scrollbars=1,resizable=1,width=<%=appsettings.userwidth%>,height=<%=appsettings.userheight%>,top=9000,left=9000");
</script>
<%
response.end()
end if%>
<script language="JavaScript">var nt=String(Math.random()).substr(2,10);setTimeout( "refresh()",<%=appsettings.proactiverefresh*1000%> );</script>
<script language="JavaScript1.2">
<!--
function refresh(){window.location.reload( true );}
//-->
</script>
<script language="JavaScript1.0">function refresh(){window.location.href = 'proactive.aspx?nt='+nt;}</script>
<meta http-equiv="refresh" content="<%=(appsettings.proactiverefresh+2)*1000%>">

