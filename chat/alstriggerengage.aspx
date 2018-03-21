<!--#include file="incSystem.aspx" -->
<script runat="server">
dim applicationurl as string=appsettings.applicationurl
dim myinvitemsg as string=appsettings.invitemsg

sub page_load
	if lcase(request.servervariables("HTTPS")) = "on" then applicationurl = replace(applicationurl, "http:", "https:")
	
	'/// Do not allow Autoengage ///'
	if getcookie("xlaALSengaged")<>"" or getcookie("xlaALSrequest","requestid")<>"" then response.end
	
	'/// Set as engaged ///'
	setCookie("xlaALSengaged","1")
	
	'/// Prepare Default Message ///'
	myinvitemsg=replace(myinvitemsg,chr(34),"\" & chr(34)) '")
end sub
</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" type="text/JavaScript">
<%if appsettings.flypopup="" then%>
function xlaALSrequest(){
	var w = 640, h = 480;
	if (document.all || document.layers) {
	   w = screen.availWidth;
	   h = screen.availHeight;
	}
	var leftPos = (w-<%=appsettings.userwidth%>)/2, topPos = (h-<%=appsettings.userheight%>)/2;
	xlaALSwindow=window.open("<%=appsettings.applicationurl%>UserPreChat.aspx","ALSRoom","toolbar=0,location=0,status=0,menubar=0,scrollbars=1,resizable=1,width=<%=appsettings.userwidth%>,height=<%=appsettings.userheight%>,top=" + topPos + ",left=" + leftPos);
	xlaALSwindow.focus();
}


function xlaALSengage(){
	if (confirm("<%=appsettings.chattitle%> :\n<%=myinvitemsg%>")) xlaALSrequest();
	else self.location.href='alsengage.aspx?blockengage=true';
}

<%else%>
function xlaALSengage(){
	window.open("<%=appsettings.applicationurl%>UserProactive.aspx" ,"ALSRoom","toolbar=0,location=0,status=0,menubar=0,scrollbars=1,resizable=1,width=<%=appsettings.userwidth%>,height=<%=appsettings.userheight%>,top=9000,left=9000");
}
<%end if%>
xlaALSengage();
</script>

