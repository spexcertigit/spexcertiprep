<!--#include file="incSystem.aspx" -->
<script runat="server">
dim name as string=""
dim email as string=""
dim deptname as string=""
dim topic as string=""
dim requestid as string=""
dim mywelcomemsg as string=""
dim nick as string=""
dim optfield1 as string=""
dim optfield2 as string=""
dim optfield3 as string=""
dim transcript as string=""
dim country as string=""
dim ip as string=""
dim hostname as string=""
dim siteref as string=""
dim visits as string=""
dim hotleadref as string=""
dim browseros as string=""



sub page_load()

	'/// Retrieve Chat info ///'
	deptname=request("deptname")
	mywelcomemsg=preparemsg(getmymsg)
	nick=preparemsg(getnick)
	requestid=request("requestid")

	
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand
	mycommand.connection = conn
	dim dr as SqlDataReader
	mycommand.commandtext = "xlaALSsp_get_request_info"
	mycommand.CommandType = CommandType.StoredProcedure
	mycommand.Parameters.Add( "@requestid" , requestid )
	conn.open()
	dr = mycommand.ExecuteReader()
	dr.read()
		name=dr("name")
		email=dr("email")
		topic=dr("topic")
		optfield1=setaslink(dr("optfield1")) 
		optfield2=setaslink(dr("optfield2")) 
		optfield3=setaslink(dr("optfield3")) 
		transcript=dr("transcript")
		ip=dr("ip")
		hostname=dr("hostname")
		siteref=dr("siteref") & ""
		visits=dr("visits")
		hotleadref=dr("hotleadref") & ""
		browseros=dr("browser") & " / " & dr("os")
	dr.close()
	conn.close()
	
	if deptname="" then 
		topic="Proactive chat requested by " & getcookie("xlaALSadmin","nick")
		deptname=" - "
	end if
	
	if visits="" or not(isnumeric(visits)) then visits="N/A"
	if siteref<>"" then siteref="<a href='" & siteref & "' alt='" & siteref & "' target=_blank>" & left(siteref,50) & "...</a>"
	if hotleadref<>"" then  hotleadref="This user is a Hot lead"
	
	dim countrylookup as new xigla_getcountry(ip)
	imgFlag.src="flags/" & lcase(countrylookup.co & ".gif")
	country=countrylookup.country
end sub

function istransfered()
	if instr(1,transcript,"<!--ALSTRANSFER-->",1)<>0 then 
		transcript=replace(transcript,"<sc" & "ript language","<!" & "-- <sc" & "ript language")
		transcript=replace(transcript,"</sc" & "ript>","</scri!" & "ipt> -->")
		response.write("<a name=tstart><br><table width=80% border=0 cellpadding=8 cellspacing=0 class=SystemMsg><tr><td></a><span class=ErrorText>This is a Tranfered Call</span><br><span class=Smalltext>Below, is a transcript of the chat session with the previous representatives</span></td></tr><tr><td bgcolor=#FFFFFF>" & transcript & "</td></tr><tr><td align=right><a href=#tstart class=SmallText>[ Up ]</a></tr></table><br><br>")
	end if
end function
</script>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=windows-1256">
<link rel="stylesheet" href="styles.css" type="text/css">
<script language="JavaScript">
// Error Handling
window.onerror = donothing;
function donothing(){
	return true;
}

function displaymessage(tosay){
	<%if appsettings.keepfocusrep<>"" then response.write("top.focus();")%>
	document.body.innerHTML = document.body.innerHTML + tosay + '\n';
	doscroll();
	top.text.focustext();
}

function cmdpush(thisfile,repname){
	document.body.innerHTML = document.body.innerHTML + '<span class=reptext><b>' + repname +'&gt; PUSH : <\/b><a href=\'' + thisfile + '\' target=_blank>' + thisfile + '<\/a><br><\/span>\n';
	doscroll();
}


function cmdimage(thisfile,repname){
	document.body.innerHTML = document.body.innerHTML + '<br><img src=\'' + thisfile + '\'><br>\n';
	doscroll();
}

function cmdurl(thislink,repname){
	document.body.innerHTML = document.body.innerHTML + '<span class=reptext><b>' + repname + '&gt;&nbsp;<\/b><a href=\'' + thislink + '\' target=_blank>' + thislink + '<\/a><\/span><br>\n';
	doscroll();
}

function cmdemail(thislink,repname){
	document.body.innerHTML = document.body.innerHTML + '<span class=reptext><b>' + repname + '&gt;&nbsp;<\/b><a href=\'mailto:' + thislink + '\'>' + thislink + '<\/a><\/span><br>\n';
	doscroll();
}

function doscroll(){
	a=document.body.scrollHeight;
	a=a+99999
	window.scrollTo(0,a);
}

</script>

<body bgcolor="#FFFFFF" text="#000000" rightmargin="0" onload="doscroll();">
<table width="99%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td colspan="2"><table border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="27" align="right"><img src="images/requestid1.gif" width="13" height="24"></td>
          <td bgcolor="#737373" class="Smalltext"><font color="#FFFFFF"><b>Request 
            ID # <font class="Text"><%=requestid%></font></b></font></td>
          <td width="32"><img src="images/requestid2.gif" width="32" height="24"></td>
        </tr>
      </table></td>
</tr>
  <tr> 
    <td align="left" valign="top" class="SystemMsg"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr align="left" valign="top"> 
          <td width="50%"><table width="99%" border="0" align="center" cellpadding="3" cellspacing="2">
              <tr align="left" valign="top" class="Text"> 
                <td width="25%" bgcolor="#CCCCCC" class="Smalltext"><b>Customer 
                  :</b><br> </td>
                <td width="25%" class="Smalltext"><%=name%></td>
              </tr>
              <tr align="left" valign="top" class="Text"> 
                <td width="25%" bgcolor="#CCCCCC" class="Smalltext"><b>E-mail 
                  : </b><br> </td>
                <td width="25%" class="Smalltext"><a href="mailto:<%=email%>"><%=email%></a></td>
              </tr>
              <%if appsettings.optfield1<>"" and optfield1<>"" then%>
              <tr align="left" valign="top" class="Text"> 
                <td bgcolor="#CCCCCC" class="Smalltext"><b><%=appsettings.optfield1%> 
                  : </b><br> </td>
                <td class="Smalltext"><%=optfield1%></td>
              </tr>
              <%end if
		if appsettings.optfield2<>"" and optfield2<>"" then%>
              <tr align="left" valign="top" class="Text"> 
                <td bgcolor="#CCCCCC" class="Smalltext"><b><%=appsettings.optfield2%> 
                  : </b><br> </td>
                <td class="Smalltext"><%=optfield2%></td>
              </tr>
              <%end if
		if appsettings.optfield3<>"" and optfield3<>"" then%>
              <tr align="left" valign="top" class="Text"> 
                <td bgcolor="#CCCCCC" class="Smalltext"><b><%=appsettings.optfield3%> 
                  : </b><br> </td>
                <td class="Smalltext"><%=optfield3%></td>
              </tr>
              <%end if
		if appsettings.countrylookup<>"" then%>
              <tr align="left" valign="top" class="Text"> 
                <td bgcolor="#CCCCCC" class="Smalltext"><b>Dept : </b><br> </td>
                <td class="Smalltext"><%=deptname%></td>
              </tr>
              <tr align="left" valign="top" class="Text"> 
                <td bgcolor="#CCCCCC" class="Smalltext"><b>Topic : </b><br> </td>
                <td class="Smalltext"><%=topic%></td>
              </tr>
              <%end if%>
            </table></td>
          <td width="50%"><table width="99%" border="0" align="center" cellpadding="3" cellspacing="2">
              <tr align="left" valign="top" class="Text"> 
                <td width="50%" bgcolor="#CCCCCC" class="Smalltext"><b>IP / Host 
                  :</b> <br>
                </td>
                <td width="50%" class="Smalltext"><%=ip%> (<%=hostname%>) </td>
              </tr>
              <tr align="left" valign="top" class="Text"> 
                <td width="50%" bgcolor="#CCCCCC" class="Smalltext"><b>Browser 
                  / OS :</b><br>
                </td>
                <td width="50%" class="Smalltext"><%=browseros%></td>
              </tr>
              <tr align="left" valign="top" class="Text"> 
                <td width="50%" bgcolor="#CCCCCC" class="Smalltext"><b>Site Visits 
                  :<br>
                  </b></td>
                <td width="50%" class="Smalltext"><%=visits%></td>
              </tr>
              <tr align="left" valign="top" class="Text"> 
                <td width="50%" bgcolor="#CCCCCC" class="Smalltext"><b>Site Referral 
                  :</b><br>
                </td>
                <td width="50%" class="Smalltext"><%=hostname%></td>
              </tr>
              <tr align="left" valign="top" class="Text"> 
                <td width="50%" bgcolor="#CCCCCC" class="Smalltext"><b>Country 
                  : </b></td>
                <td width="50%" class="Smalltext"><img src="flags/-.gif" align="absmiddle" id="imgFlag" width="18" height="12" runat="server"> 
                  <%=country%></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
<br>
<%istransfered%>
<%if len(mywelcomemsg)>0 then response.write("<span class=reptext><b>" & nick & "&gt;</b> " & mywelcomemsg & "</span><br>")%>
</body>
<script language="JavaScript">
top.chatchat=true;
top.loader.location.href='ALSChatLoader.aspx?requestid=<%=requestid%>';
</script>
