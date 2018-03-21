<!--#include file="incSystem.aspx" -->
<script runat="server">
dim applicationurl as string=appsettings.applicationurl
dim myinvitemsg as string=appsettings.invitemsg

sub page_load
	if lcase(request.servervariables("HTTPS")) = "on" then applicationurl = replace(applicationurl, "http:", "https:")
	if request("blockengage")<>"" then 
		setCookie("xlaALSengaged","1")
		response.end		
	end if
	
	'/// Do not allow Autoengage ///'
	if getcookie("xlaALSengaged")<>"" then response.end
	
	'/// Prepare Default Message ///'
	myinvitemsg=replace(myinvitemsg,chr(34),"\" & chr(34)) '")
end sub
</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" type="text/JavaScript">
setTimeout( "self.location.href='alstriggerengage.aspx';",<%=appsettings.autoengagetime*60000%> );
</script>

