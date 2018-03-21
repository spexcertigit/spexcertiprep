<!--#include file="incSystem.aspx" -->
<script runat="server">
dim myinvitemsg as string=""
sub page_load
	'/// Is tracking enabled ? ///'
	if appsettings.allowtracking="" then response.end

	'/// Get any sent invite message ///'
	myinvitemsg=getcookie("xlaALSinvite","myinvitemsg") & ""
	if myinvitemsg="" then 
		myinvitemsg=appsettings.invitemsg
	else
		setcookie("xlaALSinvite","myinvitemsg","")
	end if
end sub
</script>
<html>
<head>
<STYLE type="text/css">
<!--
BODY {
scrollbar-face-color: #ffffff;
scrollbar-highlight-color: #ffffff;
scrollbar-3dlight-color: #ffffff;
scrollbar-darkshadow-color: #ffffff;
scrollbar-shadow-color: #ffffff;
scrollbar-arrow-color: #006699;
scrollbar-track-color: #ffffff;
}
-->
</STYLE>
</head>
<body leftmargin="0" marginwidth="0" marginheight="0" rightmargin="0" bottommargin="0"  topmargin="0"  scroll="auto">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center" valign="middle"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><%=server.htmlencode(myinvitemsg)%></font></td>
  </tr>
</table>
</body>
</html>
