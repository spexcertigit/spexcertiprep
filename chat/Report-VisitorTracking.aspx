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
	logindate=todaydatetime
	
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
<table width="100%" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="#999999" style="table-layout:fixed">
  <tr class="OptionName"> 
    <td width="25%" height="24" align="center"><b><a href="Report-VisitorTracking.aspx?sortby=name+asc">Visitor</a></b></td>
    <td height="24" align="center"><b><a href="Report-VisitorTracking.aspx?sortby=referer+asc">On 
      Page</a></b></td>
    <td width="6%" height="24" align="center"><b><a href="Report-VisitorTracking.aspx?sortby=lastdate+desc">Time</a></b></td>
    <td width="20%" height="24" align="center"><b><a href="Report-VisitorTracking.aspx?sortby=actionid+asc">Status</a></b></td>
    <td width="13%" height="24" align="center">Lead</td>
  </tr>
  <%
 	dim name as string, ip as string, referer as string, timeonpage as integer, user as string,actionid as integer,bgcolor as string,co as string,country as string
	dim userid as integer=0
	
	'/// Date for deleting the visitor tracking ///'
	dim tracktimeout as integer=-5
	if isnumeric(appsettings.tracktimeout) then tracktimeout=-(val(appsettings.tracktimeout))
	dim deletedate as string=getdate(DateAdd("n", tracktimeout, todaydatetime))

	'/// Search Tracked Visitors ///'
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
	co=dr("co") & ""

	user=""
	if name<>"" then user="<b>" & name & "</b><br>"
	user=user & "IP : " & ip &"<br> (" &  left(dr("hostname") & "",40) & ")<br>"
	if appsettings.countrylookup<>"" and co<>"" and co<>"-" then user &="<img src=flags/" & co & ".gif align=absmiddle width=18 height=12> " & dr("country") & ""
	timeonpage=datediff("n",dr("lastdate"),logindate) 
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
	end select
	%>
  <tr> 
    <td width="25%" rowspan="2" valign="top" class="OptionFields"> <span class="SmallNotes"><%=user%></span></td>
    <td rowspan="2" valign="top" class="OptionFields"><a href="<%=referer%>" target="_blank" class="SmallNotes"><%=referer%></a></td>
    <td width="6%" rowspan="2" align="center" valign="middle" class="OptionFields"><span class="SmallNotes"><%=timeonpage%> Mins</span></td>
    <td width="20%" height="4" align="left" valign="top" bgcolor="<%=bgcolor%>"></td>
    <td width="13%" rowspan="2" align="center" valign="top" bgcolor="#F3F3F3" class="SmallNotes"><%=ishotlead(dr("visits"),dr("hotleadref"),dr("totalrequests"))%> 
    </td>
  </tr>
  <tr> 
    <td width="20%" align="center" valign="top" class="OptionFields"><span class="SmallNotes"><%=dr("actionnote")%></span></td>
  </tr>
  <%
  loop
  dr.close()
  conn.close()
  %>
</table>
</body>
