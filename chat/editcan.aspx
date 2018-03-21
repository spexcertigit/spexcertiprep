<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim lvl as integer
dim canid as integer=0
dim x as integer=0
dim errormsg as string=""

sub page_load
	lvl=uservalidate(0)
	if not(ispostback) then
		dim conn as New SqlConnection(connectionstr)
		dim mycommand as New SqlCommand
		mycommand.connection = conn
		dim dr as SqlDataReader
		'/// Retrieve can ID
		canid=val(request("canid"))
		if len(canid)=0 then 
			canid=0
			lnkDeletecan.visible=false 
		end if
		txtCanid.value=canid
		
		'/// Get Can Info from DB
		mycommand.commandtext = "xlaALSsp_editcan_loadinfo "
		mycommand.CommandType = CommandType.StoredProcedure
		mycommand.Parameters.Add( "@canid" , canid)
		conn.open()
		dr = mycommand.ExecuteReader()
		dim cancmd as integer=0
		dim canscope as integer=0
		if dr.Read() then
			txtCanname.text=dr("canname")
			txtCanmsg.text=dr("canmsg")
			txtQuickword.text=dr("quickword") & ""
			cancmd=dr("cancmd")
			canscope=dr("canscope")
		end if
		
		'/// Get Assigned Departments
		dr.nextresult
		dim depts as string = drgetstring(dr)
		
		'/// Get Assigned Reps
		dr.nextresult
		dim users as string = drgetstring(dr)
		
		'/// Set general Scope as Checked
		If canscope=2 then 
			chkGeneral.checked=true 
			depts=""
			users=""
		elseif (canid>0 and canscope=0) then
			chkPersonal.checked=true
		end if
		
		'/// Get Departments List
		dr.nextresult
		do while dr.read
			filllistbox(selDepts, dr("deptname") , dr("deptid") , depts)
		loop
		
		'/// Get Users List
		dr.nextresult
		do while dr.read
			filllistbox(selUsers, dr("name") & " (" & whichlevel(dr("ulevel")) & ")" , dr("userid") , users)
		loop
		dr.close()
		conn.close()
		
		'/// Fill commands
		for x=0 to 5
			filllistbox(ddlCancmd, cantype(x) , x , cancmd)
		next
	end if
end sub


sub button_click(s As Object, e As EventArgs)
	'/// Save Can ///
	'/// Retrieve Info
	canid=txtCanid.value
	dim canname as string=txtCanname.text
	dim cancmd as string=listboxresults(ddlCancmd,"")
	dim canmsg as string=txtCanmsg.text
	dim quickword as string=txtQuickword.text & ""
	dim depts as string="0"
	dim users as string="0"
	dim canscope as integer
	if lvl=0 or chkPersonal.checked=true then 
		canscope=0
		users=getusrid
	elseif chkGeneral.checked=true then 
		canscope=2
		users="0"
		depts="0"
	else
		canscope=1
		depts=listboxresults(selDepts,"0")
		users=listboxresults(selUsers,"0")
	end if
	
	'/// Check for errors
	if canscope=1 and depts="0" and users="0" then errormsg="No scope defined<br>"

	'//// Prepare Processed Can
	dim processedcan as string=canmsg
	if cancmd<>0 then 
		if instr(canmsg,vbcrlf)>0 then canmsg=left(canmsg,instr(canmsg,vbcrlf)-1)
		processedcan=preparemsg(canmsg)
	end if

	select case cancmd
		case 0 'Text Answer
			'////Nothing happens
		case 1 'Push URL
			processedcan="cmdpush('" & processedcan & "','$$NICK$$')"
		case 2 'Image
			processedcan="cmdimage('" & processedcan & "','$$NICK$$')"
		case 3 'Hyperlink
			processedcan="cmdurl('" & processedcan & "','$$NICK$$')"
		case 4 'E-Mail
			processedcan="cmdemail('" & processedcan & "','$$NICK$$')"
		case 5 'Reference Link
			processedcan=canmsg
	end select

	'/// Save the Canned Command
	if errormsg="" then
		dim conn as New SqlConnection(connectionstr)
		dim mycommand as New SqlCommand("xlaALSsp_editcan",conn)
		mycommand.commandType =  CommandType.Storedprocedure
		mycommand.Parameters.Add( "@canid" , canid )
		mycommand.Parameters.Add( "@canname" , canname)
		mycommand.Parameters.Add( "@canmsg" , canmsg)
		mycommand.Parameters.Add( "@cancmd" , cancmd)
		mycommand.Parameters.Add( "@processedcan" , processedcan)
		mycommand.Parameters.Add( "@quickword" , quickword)
		mycommand.Parameters.Add( "@canscope" , canscope)
		mycommand.Parameters.Add( "@depts" , depts)
		mycommand.Parameters.Add( "@users" , users)
		conn.open()
		mycommand.ExecuteScalar()
		conn.close()
		response.redirect("cans.aspx")
	end if
end sub

</script>
<html>
<head>
<title><%=apptitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="ALSStyles.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000" topmargin="5">
<form name="form1" id="form1" method="post" action="editcan.aspx" runat="server">
  <table width="96%" border="0" cellspacing="2" cellpadding="2" align="center">
    <tr> 
      <td width="27%" class="MainTitles"><img src="images/icCans.gif" width="20" height="20" align="absmiddle"> 
        Edit Canned Command</td>
      <td align="right"><a href="javascript:deletecan();" id="lnkDeletecan" runat="server"> 
        <script language="JavaScript">
function deletecan(){
	if (confirm('Delete This Canned Command?')) self.location.href='cans.aspx?kill=<%=canid%>';
}
</script>
        <img src="images/btnDeleteCan.gif" width="118" height="25" border="0"></a> 
      </td>
    </tr>
    <tr> 
      <td colspan="2" class="SearchCell"></td>
    </tr>
    <%if errormsg<>"" then%>
    <tr> 
      <td colspan="2"><span class="ErrorNotices">Error : The canned command could 
        not be saved<br>
        <%=errormsg%> </span> </td>
    </tr>
    <tr> 
      <td colspan="2" class="SearchCell"></td>
    </tr>
    <%end if%>
    <tr align="left" valign="top"> 
      <td width="27%" class="OptionName">Name :</td>
      <td class="OptionFields"> <asp:textbox Columns="40" ID="txtCanname" runat="server" MaxLength="250" /> 
        <asp:requiredfieldvalidator ControlToValidate="txtCanname" ErrorMessage="No name provided" CssClass="ErrorNotice" id="reqName" runat="server" /> 
        <br> <span class="SmallNotes">Type a name for this canned command </span></td>
    </tr>
    <tr align="left" valign="top"> 
      <td width="27%" class="OptionName">Command Type :<br> </td>
      <td class="OptionFields"><asp:dropdownlist ID="ddlCancmd" runat="server" /><span class="SmallNotes"> 
        <asp:textbox ID="txtCanmsg" runat="server" columns="40" />
        <asp:requiredfieldvalidator ControlToValidate="txtCanmsg" ErrorMessage="No command provided" CssClass="ErrorNotice" id="reqCanmsg" runat="server" />
        <br>
        Type the URL or message that you want to use in the command </span></td>
    </tr>
    <tr align="left" valign="top"> 
      <td class="OptionName">Quick Word : </td>
      <td class="OptionFields"><asp:textbox ID="txtQuickword" runat="server" MaxLength="50" columns="20" /> 
        <span class="SmallNotes"><br>
        Type a single word that will act as a shorcut to this command. <br>
        If a representative types this single word, the canned command will be 
        executed </span> </tr>
    <%if lvl=1 then%>
    <tr align="left" valign="top"> 
      <td width="27%" rowspan="3" class="OptionName">Scope :<br> <span class="SmallNotes"> 
        Select which representatives will have access to this command</span></td>
      <td class="OptionFields"> <asp:checkbox ID="chkGeneral" runat="server" Text="All the representatives" /> 
        <br> <asp:checkbox ID="chkPersonal" runat="server" Text="Personal Can" /> 
      </td>
    </tr>
    <tr align="left" valign="top"> 
      <td class="OptionFields">Departments :<br> <asp:listbox ID="selDepts" Rows="4" runat="server" SelectionMode="multiple" /> 
      </td>
    </tr>
    <tr align="left" valign="top"> 
      <td class="OptionFields"> Representatives :<br> <asp:listbox ID="selUsers" Rows="4" runat="server" SelectionMode="multiple" /> 
      </td>
    </tr>
    <%end if%>
    <tr align="left" valign="top"> 
      <td width="27%" class="OptionName"> <input type="hidden" name="txtCanid" id="txtCanid" runat="server"/></td>
      <td class="OptionFields"><input type="button" name="btnButton" id="btnButton" value="Save Canned Command" runat="server" onServerclick="button_click" /> 
      </td>
    </tr>
    <tr> 
      <td colspan="2" class="SearchCell"></td>
    </tr>
  </table>
</form>
</body>
</html>
