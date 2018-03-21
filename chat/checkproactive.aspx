<!--#include file="incSystem.aspx" -->
<script runat="server">
dim myinvitemsg as string=""
dim doproactive as boolean=false

sub page_load
	dim userid as string=""
	dim ip as string=""
	
	'/// Is tracking enabled ? ///'
	if appsettings.allowtracking="" then doend()
	ip=request.ServerVariables("REMOTE_ADDR") & ""
	
	'/// Cancel Invite ///'
	dim action as string=request("action") & ""
	if action="cancel" then 
		setCookie("xlaALSengaged","1")
		call updatevisitoraction(ip,5,"Do Not Disturb")
		call doend()
	elseif action="engage" then
		setCookie("xlaALSengaged","1")
		call updatevisitoraction(ip,1,"Engaged")
		call showproactive()
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
		doproactive=true
	end if
	dr.close()
	conn.close()
	if doproactive then showproactive() else doend()

end sub

sub showproactive()
	response.write("<!-- ALS -->")
	response.write("<table border=0 cellspacing=0 cellpadding=0><tr><td>")
	response.write("<div style='position:relative; left:142px; top:124px; width:150px; height:80px; z-index:1; overflow:auto; font-size:11; font-family:verdana;'>")
	response.write(server.hmlencode(myinvitemsg))
	response.write("</div><a href=javascript:; onclick=xlaALSacceptinvite();><img src=" & appsettings.applicationurl & "files/invite.gif border=0></a></td></tr><tr><td>")
	response.write("<a href=javascript:xlaALScancelinvite();><img src=" & appsettings.applicationurl & "files/invite-close.gif border=0></a></td></tr></table></div>")
	response.end()
end sub

sub doend()
	response.write("<!-- ALS -->")
	response.end()
end sub
</script>


