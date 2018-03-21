<!--#include file="incSystem.aspx" -->
<script runat="server">
sub page_load()
	dim u as string=request("u")
	dim requestid as string=getcookie("xlaALSrequest","requestid")
	if requestid<>"" and u<>"" then
		dim conn as New SqlConnection(connectionstr)
		dim mycommand as New SqlCommand("xlaALSsp_user_chat_action",conn)
		mycommand.commandType =  CommandType.Storedprocedure
		mycommand.Parameters.Add( "@requestid" , requestid )
		mycommand.Parameters.Add( "@usr_action" , u )
		conn.open()
		mycommand.ExecuteScalar()
		conn.close()
	end if
	response.redirect("i.gif")
end sub
</script>
