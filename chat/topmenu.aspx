<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim lvl as integer
sub page_load
	lvl=uservalidate(0)
	'/// Hide the Options button ///'
	if lvl<>1 then optionslink.visible=false
	
	'/// Hide logout button for Absolute Control Panel ///'
	if getCookie("xlaCPadmin","lvl")<>"" then lnkLogout.visible=false
end sub
</script>
<html>
<head>
<title><%=apptitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript">
function launchmonitor(){
	ALSLM=window.open("ALSLiveMonitor.aspx","ALS_LM","toolbar=0,location=0,status=0,menubar=0,scrollbars=1,resizable=1,width=500,height=180");
	ALSLM.focus();
}

</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" link="#FFFFFF" vlink="#FFFFFF">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      
    <td><table width="100%" height="58" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="10" align="center" background="images/Topmenulogobkg.gif">&nbsp;</td>
          <td width="230" align="center" valign="bottom" background="images/Topmenulogobkg.gif"><a href="http://www.xigla.com/" target="_blank"><img src="images/ALSToplogo.gif" alt="Absolute Live Support - Developed by Xigla Software" width="202" height="30" vspace="8" border="0"></a></td>
          <td width="116" align="center"><img src="images/TopmenuCurve.gif" width="126" height="58"></td>
          <td align="center" background="images/Topmenubkg.gif"><a href="start.aspx" target="main"><img src="images/btnStart.gif" vspace="2" alt="Start Screen and Digital Dashboard" border="0"></a><a href="javascript:launchmonitor()"><img src="images/btnMonitor.gif" border="0" vspace="2" alt="Launch Live Monitor"></a><a href="search.aspx" target="main"><img src="images/btnSearch.gif" border="0" vspace="2" alt="Search /  Browse Requests"></a><a href="depts.aspx" target="main"><img src="images/btnDepartments.gif" border="0" vspace="2" alt="View / Edit  Departments"></a><a href="users.aspx" target="main"><img src="images/btnReps.gif" alt="View / Edit Users" border="0" vspace="2"></a><a href="cans.aspx" target="main"><img src="images/btnCans.gif" alt="Canned Commands" border="0" vspace="2"></a><a href="options.aspx" target="main" id="optionslink" runat="server"><img src="images/btnOptions.gif" alt="Configuration Settings" vspace="2" border="0"></a><a href="logout.aspx" target="main" id="lnkLogout" runat="server"><img src="images/btnLogout.gif" alt="Log Out" vspace="2" border="0"></a></td>
        </tr>
      </table></td>
    </tr>
    <tr> 
      
    <td height="1" bgcolor="#FFFFFF"></td>
    </tr>
    <tr> 
    <td height="6" background="images/barTopMenu.gif" bgcolor="#CCCCCC"></td>
    </tr>
    <tr>
      <td bgcolor="#666666" height="1" align="left"></td>
    </tr>
  </table>

</body>
</html>

