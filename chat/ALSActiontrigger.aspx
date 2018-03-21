<!--#include file="incSystem.aspx" -->
<script runat="server">
sub page_load()
	dim r as string=request("r")
	dim requestid as string=request("requestid")
	if requestid<>""  and r<>"" then
		dim conn as New SqlConnection(connectionstr)
		dim mycommand as New SqlCommand("xlaALSsp_reps_chat_action",conn)
		mycommand.commandType =  CommandType.Storedprocedure
		mycommand.Parameters.Add( "@requestid" , requestid )
		mycommand.Parameters.Add( "@rep_action" , r )
		conn.open()
		mycommand.ExecuteScalar()
		conn.close()
	end if
	response.redirect("i.gif")
end sub
</script>
