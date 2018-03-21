<!--#include file="incSystem.aspx" -->
<script runat="server">
sub page_load()

	dim userid as string=getusrid
	if userid="" or userid="0" then response.redirect("logout.aspx")
	dim onlinesince as string=todaydatetime
	dim lastdate as string=getdate(DateAdd("n", -10, todaydatetime))
	
	'/// Initialize Monitor : Set user as on-line  ///'
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand
	mycommand.connection = conn
	mycommand.commandtext = "xlaALSsp_monitor_start_stop"
	mycommand.CommandType = CommandType.StoredProcedure
	mycommand.Parameters.Add( "@userid" , userid)
	mycommand.Parameters.Add( "@onlinesince" , onlinesince)
	mycommand.Parameters.Add( "@lastdate" , lastdate)
	mycommand.Parameters.Add( "@action" , "start")
	conn.open()
	mycommand.ExecuteScalar()
	conn.close()
	response.redirect("LMRequests.aspx")	
end sub
</script>



