<!--#include file="incSystem.aspx" -->
<script runat="server">
dim requestid as string=""
dim repid as string=""
dim ip as string=""
dim todo as string=""
dim userid as string=""
dim toclose as string=""

sub page_load()
	requestid=request("requestid")
	repid=request("repid")
	ip=request("ip")
	todo=request("todo")
	userid=getusrid
	if userid="" then response.redirect("Logout.aspx")

	'/// Transfer a Request  ///'
	if todo="transfer" then
		if "u" & userid <> repid then call setbusy(requestid,userid)

		call updateattending(userid)
		dim reptarget as string=transfer(requestid,repid)
		call updatevisitoraction(ip,1,"Waiting for representative, the user has been transfered")

		'/// Add Transfer Message  ///'
		dim loggedcan as string=""
		dim lastmsgdate as string=todaydatetime
		dim newmsg as string="<br><table width=96% class=SystemMsg><tr><td><!--ALSTRANSFER-->Transfering request to &quot;" & reptarget & "&quot;, please wait...</td></tr></table><br>"
		if left(repid,1)="u" then reptarget="userid=" & replace(repid,"u","") else reptarget="deptid=" & replace(repid,"d","")
		dim	cancmd as string="starttimeout('" & reptarget & "');"
		dim conn as New SqlConnection(connectionstr)
		dim mycommand as New SqlCommand("xlaALSsp_reps_chat_receive",conn)
		mycommand.commandType =  CommandType.Storedprocedure
		mycommand.Parameters.Add( "@requestid" , requestid )
		mycommand.Parameters.Add( "@message" , newmsg  )
		mycommand.Parameters.Add( "@cancmd" , cancmd )
		mycommand.Parameters.Add( "@loggedcan" ,loggedcan )
		mycommand.Parameters.add( "@lastmsgdate", lastmsgdate)
		mycommand.Parameters.Add( "@addtolog" , appsettings.logchat  )
		conn.open()
		mycommand.ExecuteScalar()
		conn.close()
		
		response.write("<scr" & "ipt language=JavaScript>alert('The request has been transfered\nThis window will be closed');top.close();</scr" &"ipt>")
		response.end
	end if
	
	'/// FAQ Manager Support ///'
	lnkAFMnet.visible=false
	if appsettings.afmneturl<>"" then lnkAFMnet.visible=true

end sub

sub listrepsndepts()
	response.write("<optgroup label='Departments :'>")
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand
	mycommand.connection = conn
	mycommand.commandtext = "xlaALSsp_list_depts_reps_online"
	mycommand.CommandType = CommandType.StoredProcedure
	conn.open()
	dim dr as SqlDataReader=mycommand.Executereader()
	do while dr.read()
		response.write("<option value=d" & dr("deptid") & ">" & dr("deptname") & " (" & dr("repsonline") & " Reps Online)</option>")
	loop
	response.write("</optgroup>")
	dr.nextresult()
	response.write("<optgroup label='Hidden Departments :'>")
	do while dr.read()
		response.write("<option value=d" & dr("deptid") & ">" & dr("deptname") & " (" & dr("repsonline") & " Reps Online)</option>")
	loop
	response.write("</optgroup>")
	response.write("<optgroup label='Representatives :'>")
	dr.nextresult()
	dim availability as string=""
	dim simultaneous as integer=0
	dim attending as integer=0
	do while dr.read()
		simultaneous=dr("simultaneous")
		attending=dr("attending")
		
		if simultaneous=0 or attending=0 then 
			availability=""
		elseif attending>=simultaneous then
			availability=" &nbsp;BUSY : " & attending & "/" & simultaneous
		else
			availability=" &nbsp; " & attending & "/" & simultaneous
		end if
		response.write("<option value=u" & dr("userid") & ">" & dr("name") & " (" & whichlevel(dr("ulevel")) & ")" & availability & "</option>")
	loop
	dr.close()
	conn.close()
	response.write("</optgroup>")
end sub



</script>

<style type="text/css">
.transferlist {  font-family: Tahoma, Verdana, sans-serif; font-size: 10px}
</style>
<script language="JavaScript">
// Error Handling
window.onerror = donothing;
function donothing(){
	return true;
}

function transfer(){
	if (form1.repid.value=='refresh'){
		dorefresh();
		return;
	}
	if (form1.repid.value!='') {
		if (confirm('Do you really want to transfer this request?')){ 
		isexit=0;
		form1.submit();
		}
	}
}

function closession(){
	if (confirm('Close This Window and Leave The Session?'))top.close();
}

function timeout(){
	if (confirm('The customer has left the session or has timeout.\nClose This Window?')) top.close();
}

var isexit=1;
function repchatexit(){
	if (isexit==1) window.open("ALSChatExit.aspx?requestid=<%=requestid%>","","toolbar=0,location=0,status=0,menubar=0,scrollbars=0,resizable=0,width=1,height=1,top=9999,left=9999");
}

function dorefresh(){
	isexit=0;
	window.location.reload(true);
}
</script>
<body leftmargin="0" rightmargin="0" topmargin="0" class="FrameBackground" bgcolor="#666666" onUnload="repchatexit();" onload="javascript:top.chattop=true;">
<form name="form1" method="post" action="ALSChatTop.aspx?requestid=<%=requestid%>&todo=transfer">
<table width="96%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
      <td><img src="images/imgLogo3.gif" width="165" height="23" vspace="4"></td>
      <td align="right"><font color="#CCCCCC" size="1" face="Arial, Helvetica, sans-serif"> 
        <input name="ip" type="hidden" value="<%=ip%>">
        </font>
	<select name="repid" onchange="javascript:transfer()" class="transferlist" style="width:260px;">
		<option value=''> -- TRANSFER -- </option>
      	<%listrepsndepts()%>
		<optgroup label="Options">
		<option value="refresh">Refresh List</option>
		</optgroup>
        </select>
      </td>
      <td width="110" align="right"><a href="javascript:top.showafm();" id="lnkAFMnet" runat="server"><img src="images/btnFaqManager.gif" alt="Open FAQ Manager" width="27" height="27" hspace="2" vspace="4" border="0"></a><a href="javascript:parent.chat.focus();window.print()"><img src="images/btnPrint.gif" width="27" height="27" vspace="4" hspace="2" alt="Print Session Transcript" border="0"></a><a href="javascript:closession();"><img src="images/btnKill.gif" width="27" height="27" hspace="2" vspace="4" border="0" alt="Close The Session"></a></td>
  </tr>
</table>
</form>
</body>