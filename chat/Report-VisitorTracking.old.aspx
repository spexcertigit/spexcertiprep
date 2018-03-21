<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim sortby as string=""
dim logindate as string
dim x as integer=0

sub page_load()	
	dim lvl as integer=uservalidate(0)
	
	'/// Is Tracking Enabled ?'
		if appsettings.allowtracking="" then
		response.write("<p>&nbsp;</p><p align=center><font color=#FF0000 size=1 face=Tahoma><b>The user tracking feature is currently disabled</b></font></p>")
		response.end
	end if
	
	sortby=request("sortby")
	if sortby="" then sortby="lastdate desc"
	logindate=getlogin(now)
	
end sub
</script>

<style>
<!--
A:link {text-decoration: font-weight:bolder; color: blue}
A:visited {text-decoration: font-weight:bolder; color: blue}
A:active {text-decoration: font-weight:bolder; color: blue}
A:hover {text-decoration: font-weight:bolder; color: red}
-->
</style>

<link href="ALSStyles.css" rel="stylesheet" type="text/css">
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" rightmargin="0" bottommargin="0">
<table width="100%" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="#999999">
  <tr class="OptionName"> 
    <td width="20%" align="center"><b><a href="Report-VisitorTracking.aspx?sortby=name+asc">Visitor</a></b></td>
    <td align="center"><b><a href="Report-VisitorTracking.aspx?sortby=referer+asc">On Page</a> 
      </b></td>
    <td width="8%" align="center"><b><a href="Report-VisitorTracking.aspx?sortby=lastdate+desc">Time</a></b></td>
    <td width="30%" colspan="2" align="center"><b><a href="Report-VisitorTracking.aspx?sortby=actionid+asc">Status</a></b></td>
  </tr>
  <%
 	dim name as string, ip as string, referer as string, timeonpage as integer, user as string,actionnote as string,actionid as integer,bgcolor as string,invitelink as string
	dim userid as integer=0

	'/// Date for deleting the visitor tracking ///'
	dim tracktimeout as integer=-5
	
	if isnumeric(appsettings.tracktimeout) then tracktimeout=-(val(appsettings.tracktimeout))
	dim deletedate as string=getlogin(DateAdd("n", tracktimeout, Now))

	'/// Search Tracked Visitors'
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand("xlaALSsp_visitorsview",conn)
	dim myadapter as New SqlDataAdapter(mycommand)
	mycommand.CommandType = CommandType.StoredProcedure
	mycommand.Parameters.Add( "@tracklimit" , appsettings.tracklimit)
	mycommand.parameters.add( "@orderby" , sortby)
	mycommand.parameters.add( "@deletedate" , deletedate)
	mycommand.parameters.add( "@userid" , userid)
	conn.open()
	dim dr as SqlDataReader = mycommand.ExecuteReader()
	do while dr.read()
	name=dr("name")
	ip=dr("ip")
	referer=dr("referer")
	if name="" then user=ip else user="<b>" & name & "</b><br>" & ip
	timeonpage=datediff("n",dr("lastdate"),logindate)
	actionnote=dr("actionnote")
	actionid=dr("actionid")
	select case actionid
	case 0
		bgcolor="#00CC00"
	case 1
		bgcolor="#FFCC00"
	case 2
		bgcolor="#0099CC"
	case 3
		bgcolor="#666666"
	case 4
		bgcolor="#FF3300"
	case 5
		bgcolor="#9933CC"
	end select	%>
  <tr> 
    <td width="20%" valign="top" class="OptionFields"><%=user%></td>
    <td valign="top" class="OptionFields"><a href="<%=referer%>" target="_blank"><%=referer%></a></td>
    <td width="8%" align="center" valign="top" class="OptionFields"> <%=timeonpage%> Mins</td>
    <td width="3%" bgcolor="<%=bgcolor%>"></td>
    <td width="27%" align="left" valign="top" class="OptionFields"><%=actionnote%></td>
  </tr>
  <%loop
  dr.close()
  conn.close()%>
</table>
</body>
