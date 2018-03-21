<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim customerid as string=""
dim name as string=""
dim email as string=""
dim optfield1 as string=""
dim optfield2 as string=""
dim optfield3 as string=""
dim dateregistered as string=""
dim lastrequestdate as string=""
dim ip as string=""
dim hostname as string=""
dim os as string=""
dim browser as string=""
dim avgrating as integer=0
dim ratedsessions as integer=0
dim totalrequests as integer=0
dim co as string=""
dim country as string=""
dim browseros as string=""
dim visits as string=""
dim hotleadref as string=""


sub page_load()
	dim requestid as string=request("requestid")
	if requestid="" or requestid="0" or not(isnumeric(requestid)) or getusrid="" or getusrid="0" then response.end 
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand
	dim dr as SqlDataReader
	mycommand.connection = conn
	mycommand.commandtext = "xlaALSsp_user_info"
	mycommand.CommandType = CommandType.StoredProcedure
	mycommand.Parameters.Add( "@requestid" , requestid)
	conn.open()
	dr = mycommand.ExecuteReader()
	if dr.read() then 
		customerid=dr("customerid")
		name=dr("name")
		email=dr("email")
		optfield1=setaslink(dr("optfield1"))
		optfield2=setaslink(dr("optfield2"))
		optfield3=setaslink(dr("optfield3"))
		
		dateregistered=dr("dateregistered")
		lastrequestdate=dr("lastrequestdate")
		ip=dr("ip")
		hostname=dr("hostname")

		co=dr("co")
		country=dr("country")
		visits=dr("visits")
		hotleadref=dr("hotleadref") & ""
		browseros=dr("browser") & " / " & dr("os")
	end if
	
	imgFlag.src="flags/" & lcase(co & ".gif")
	
	dr.nextresult()
	if dr.read() then totalrequests=dr("totalrequests")
	
	dr.nextresult()
	if dr.read() then
		avgrating=dr("avgrating")
		ratedsessions=dr("ratedsessions")
	end if
	dr.close()
	conn.close()
end sub
</script>
<html>
<head>
<title>User Info</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="ALSStyles.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" rightmargin="0" bottommargin="0">
<table width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
  <tr align="left" valign="top" class="Text"> 
    <td width="160" class="OptionName">Customer ID :</td>
    <td class="OptionFields"><%=customerid%></td>
  </tr>
  <tr align="left" valign="top" class="Text"> 
    <td width="160" class="OptionName">Customer :<br> </td>
    <td class="OptionFields"><%=name%></td>
  </tr>
  <tr align="left" valign="top" class="Text"> 
    <td width="160" class="OptionName">E-mail : <br> </td>
    <td class="OptionFields"><a href="mailto:<%=email%>"><%=email%></a></td>
  </tr>
  <%if appsettings.optfield1<>"" and optfield1<>"" then%>
  <tr align="left" valign="top" class="Text"> 
    <td width="160" class="OptionName"><%=appsettings.optfield1%> : <br> </td>
    <td class="OptionFields"><%=optfield1%></td>
  </tr>
  <%end if
		if appsettings.optfield2<>"" and optfield2<>"" then%>
  <tr align="left" valign="top" class="Text"> 
    <td width="160" class="OptionName"><%=appsettings.optfield2%> : <br> </td>
    <td class="OptionFields"><%=optfield2%></td>
  </tr>
  <%end if
		if appsettings.optfield3<>"" and optfield3<>"" then%>
  <tr align="left" valign="top" class="Text"> 
    <td width="160" height="25" class="OptionName"><%=appsettings.optfield3%> 
      : <br> </td>
    <td class="OptionFields"><%=optfield3%></td>
  </tr>
  <tr align="left" valign="top" class="Text"> 
    <td width="160" class="OptionName">IP / Host : <br> </td>
    <td class="OptionFields"><%=ip%> (<%=hostname%>) </td>
  </tr>
  <tr align="left" valign="top" class="Text"> 
    <td width="160" class="OptionName">Browser / OS :<br> </td>
    <td class="OptionFields"><%=browseros%></td>
  </tr>
  <tr> 
    <td width="160" class="OptionName"><b>Date Registered :</b></td>
    <td class="OptionFields"><%=dateregistered%></td>
  </tr>
  <tr> 
    <td width="160" class="OptionName"><b>Last Request Date :</b></td>
    <td class="OptionFields"><%=lastrequestdate%></td>
  </tr>
  <tr> 
    <td width="160" class="OptionName"><b>Total Requests :</b></td>
    <td class="OptionFields"><%=totalrequests%></td>
  </tr>
  <tr> 
    <td width="160" class="OptionName"><b>Average Session Rating :</b></td>
    <td class="OptionFields"><%=formatnumber(avgrating,2) & " on " & ratedsessions & " sessions"%></td>
  </tr>
  <tr align="left" valign="top" class="Text"> 
    <td width="160" class="OptionName">Site Visits :<br> </td>
    <td class="OptionFields"><%=visits%></td>
  </tr>
  <tr align="left" valign="top" class="Text"> 
    <td width="160" class="OptionName">Site Referral :<br> </td>
    <td class="OptionFields"><%=hostname%></td>
  </tr>
  <tr align="left" valign="top" class="Text"> 
    <td width="160" class="OptionName">Country : </td>
    <td class="OptionFields"><img src="flags/-.gif" align="absmiddle" id="imgFlag" width="18" height="12" runat="server"> 
      <%=country%></td>
  </tr>
  <%end if
		if appsettings.countrylookup<>"" then%>
  <%end if%>
</table>
</body>
</html>
