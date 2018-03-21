<!--#include file="incSystem.aspx" -->
<script runat="server">
dim userid as string=""
dim myinvitemsg as string=""

dim d as string=""
dim bypass as string=""

sub page_load
	'/// Set as engaged ///'
	setCookie("xlaALSengaged","1")
	
	'/// Is Tracking enabled ///'
	if appsettings.allowtracking="" then response.end
	
	dim ip as string=request.ServerVariables("REMOTE_ADDR") & ""
	userid=getcookie("xlaALSinvite","u")
	if userid="" then
		userid=request("u") & ""
		d=request("d") & ""
	end if
	bypass=request("bypass") & ""
	myinvitemsg=getcookie("xlaALSinvite","myinvitemsg")
	response.redirect("UserPreChat.aspx?isproactive=1&u=" & userid & "&d=" & d &"&bypass=" & bypass)
end sub

</script>

