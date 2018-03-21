<!--#include file="incSystem.aspx" -->
<script runat="server">
sub page_load
	dim userid as string=""
	dim myinvitemsg as string=""
	dim ip as string=""
	dim proactiveimg as string="images/proactiveoff.gif"
	
	'/// Is tracking enabled ? ///'
	if appsettings.allowtracking="" then response.end
	ip=request.ServerVariables("REMOTE_ADDR") & ""
	
	'/// Cancel Invite ///'
	dim action as string=request("action") & ""
	if action="cancel" then 
		setCookie("xlaALSengaged","1")
		call updatevisitoraction(ip,5,"Do Not Disturb")
		response.redirect("images/proactiveon.gif")
		response.end
	elseif action="engage" then
		setCookie("xlaALSengaged","1")
		call updatevisitoraction(ip,1,"Engaged")
		response.redirect("images/proactiveon.gif")
		response.end
	end if

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
		setcookie("xlaALSinvite","u",userid)
		setcookie("xlaALSinvite","myinvitemsg",myinvitemsg)
		proactiveimg="images/proactiveon.gif"
	end if
	dr.close()
	conn.close()
	response.Redirect(proactiveimg)
end sub
</script>


