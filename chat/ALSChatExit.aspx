<!--#include file="incSystem.aspx" -->
<script runat="server">
sub page_load()
	dim requestid as string=request("requestid")
	
	'/// Exit Room'
	if requestid<>"" then call endsession(requestid)
end sub
</script>
<script language="JavaScript" type="text/JavaScript">
top.close();
</script>

