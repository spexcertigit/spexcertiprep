<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim lvl as integer
dim userid as integer=0
dim name as string=""
dim ulevel as integer=0
dim userphoto as string=""
dim onlineimg as string=""
dim offlineimg as string=""


sub page_load
	
	lvl=uservalidate(1)
	call nocache()
	if not(ispostback) then
		dim conn as New SqlConnection(connectionstr)
		dim mycommand as New SqlCommand
		mycommand.connection = conn
		dim dr as SqlDataReader
		'/// Retrieve User ID ///'
		userid=val(request("userid"))
		if len(userid)=0 then 
			userid=0
			lnkDeleteuser.visible=false 
		end if
		txtUserid.value=userid
		
		'/// Get User Info from DB ///'
		mycommand.commandtext = "xlaALSsp_edituser_loadinfo "
		mycommand.CommandType = CommandType.StoredProcedure
		mycommand.Parameters.Add( "@userid" , userid)
		conn.open()
		dr = mycommand.ExecuteReader()
		if dr.Read() then
			txtName.text=dr("name")
			txtEmail.text=dr("email")
			txtNick.text=dr("nick")
			txtUsr.text=dr("usr")
			ulevel=dr("ulevel")
			txtPwd.Attributes.Add(" value", dr("pwd"))
			txtSimultaneous.text=dr("simultaneous")
			txtAdditional.text=dr("additional")
			txtMywelcomemsg.text=dr("mywelcomemsg")
			txtPublicinfo.text=dr("publicinfo") & ""
		end if
		
		'/// Get Assigned Departments ///'
		dr.nextresult
		dim depts as string = drgetstring(dr)
		
		'/// Get Departments List ///'
		dr.nextresult
		do while dr.read
			filllistbox(selDepts, dr("deptname") , dr("deptid") , depts)
		loop
		dr.close()
		conn.close()
		
		'/// Get Button Image ///'
		onlineimg=getbutton(userid,"u","on")
		offlineimg=getbutton(userid,"u","off")
		
		'/// Get user photo ///'
		userphoto=getuserphoto(userid) 
	
		'/// Fill Levels ///'
		dim x as integer
		for x=0 to ubound(whichlevel)
			filllistbox(selUlevel, whichlevel(x), x , ulevel)
		next	
	end if
end sub

sub button_click(s As Object, e As EventArgs)
	'/// Save User ///'
	if isnumeric(txtUserid.value) then
		dim conn as New SqlConnection(connectionstr)
		dim mycommand as New SqlCommand("xlaALSsp_edituser",conn)
		mycommand.commandType =  CommandType.Storedprocedure
		mycommand.Parameters.Add( "@userid" , txtUserid.value )
		mycommand.Parameters.Add( "@name" , txtName.text)
		mycommand.Parameters.Add( "@email" , txtEmail.text)
		mycommand.Parameters.Add( "@nick" , txtNick.text)
		mycommand.Parameters.Add( "@usr" , txtUsr.text)
		mycommand.Parameters.Add( "@pwd" , txtPwd.text)
		mycommand.Parameters.Add( "@ulevel" , val(listboxresults(selUlevel,"0")))
		mycommand.Parameters.Add( "@simultaneous" , txtSimultaneous.text)
		mycommand.Parameters.Add( "@mywelcomemsg" , txtMywelcomemsg.text)
		mycommand.Parameters.Add( "@additional" , txtAdditional.text)
		mycommand.Parameters.Add( "@publicinfo" , txtPublicinfo.text)
		mycommand.Parameters.Add( "@depts" , listboxresults(selDepts,"0"))

		conn.open()
		dim newuserid as integer=mycommand.ExecuteScalar()
		conn.close()
		
		'/// Save Online Buttons if Any ///'
		dim uploaded as boolean=true
		dim filename as string="u" & newuserid
		try
		
			if uplOnline.Postedfile.Filename<>"" and newuserid>0 and (uplOnline.Postedfile.Filename.endswith(".gif") or uplOnline.Postedfile.Filename.endswith(".jpg")) then uplOnline.Postedfile.SaveAs (server.mappath("files/") & filename & "on.gif")
			if uplOffline.Postedfile.Filename<>"" and newuserid>0 and (uplOffline.Postedfile.Filename.endswith(".gif") or uplOffline.Postedfile.Filename.endswith(".jpg")) then uplOffline.Postedfile.SaveAs (server.mappath("files/") & filename & "off.gif")
			if upluserphoto.Postedfile.Filename<>"" and newuserid>0 and (upluserphoto.Postedfile.Filename.endswith(".gif") or upluserphoto.Postedfile.Filename.endswith(".jpg")) then upluserphoto.Postedfile.SaveAs (server.mappath("representatives/") & newuserid & ".gif")
		catch
			uploaded=false
		end try
		
		if newuserid>0 and uploaded=true then 
			'/// user has been saved ///'
			response.redirect("viewuser.aspx?userid=" & newuserid)
		else
			txtPwd.Attributes.Add(" value", txtPwd.text)
			if uploaded=false then
				lblErrormsg.text="The images could not be uploaded<br>Check the write permission on the FILES/ and REPRESENTATIVES/ Folders of the application and try again" 
			else
				lblErrormsg.text="The Representative could not be saved : Username '" & txtUsr.text & "' already taken"
			end if
			
			'/// Get Button Image ///'
			onlineimg=getbutton(userid,"u","on")
			offlineimg=getbutton(userid,"u","off")
		
			'/// Get user photo ///'
			userphoto=getuserphoto(userid)
		end if
	end if
end sub
</script>

<html>
<head>
<title><%=apptitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="ALSStyles.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function deleteimage(what,control){
	if (what=='files/online.gif' || what=='files/offline.gif' || what=='representatives/default.gif'){
		alert('This is a default image and cannot be deleted');
	} else {
		if(confirm('Delete This Image?\nThe Default Image will be used instead')){
			if (control=='on') { document.getElementById("imgOnline").src='deleteimage.aspx?img=' + what + '&defaultimg=files/online.gif'}
			if (control=='off') { document.getElementById("imgOffline").src='deleteimage.aspx?img=' + what + '&defaultimg=files/offline.gif'}
			if (control=='rep') { document.getElementById("imgUserphoto").src='deleteimage.aspx?img=' + what + '&defaultimg=representatives/default.gif'}
		}
	}
}

</script>



</head>

<body bgcolor="#FFFFFF" text="#000000">
<form runat="server" method="post" enctype="multipart/form-data" name="form1" id="form1">
  <table width="96%" border="0" cellspacing="2" cellpadding="2" align="center">
    <tr> 
      <td valign="bottom" class="MainTitles"><b><img src="images/icusers.gif" width="20" height="21" align="absmiddle"></b> 
        Edit Representative </td>
      <td align="right"><a href="users.aspx"><img src="images/btnSearchusers.gif" alt="Search / View Representatives" width="118" height="25" border="0"></a> 
        <a href="javascript:deleteuser()" id="lnkDeleteUser" runat="server"> 
        <script language="JavaScript">
	function deleteuser(){
		if (confirm('Delete this representative?')){
			self.location='users.aspx?kill=<%=userid%>';
		}
	}
</script>
        <img src="images/btnDeleteuser.gif" width="118" height="25" border="0" alt="Delete user"></a> 
      </td>
    </tr>
    <tr> 
      <td colspan="2" bgcolor="#666666"></td>
    </tr>
    <tr> 
      <td colspan="2"><asp:label  ID="lblErrormsg" runat="server" CssClass="ErrorNotices" /> 
        <asp:validationsummary id="validSummary" ShowMessageBox="true" runat="server" headertext="Error : The form cannot be submitted :" showsummary="false" /></td>
    </tr>
    <tr valign="top" align="left"> 
      <td width="28%" class="OptionName">Name :</td>
      <td width="72%" class="OptionFields"> <asp:textbox Columns="40" ID="txtName" MaxLength="250" runat="server" /> 
        <asp:requiredfieldvalidator ControlToValidate="txtName" ErrorMessage="No name provided" CssClass="ErrorNotice" id="reqName" runat="server" /></td>
    </tr>
    <tr valign="top" align="left"> 
      <td width="28%" class="OptionName">E-mail :</td>
      <td width="72%" class="OptionFields"> <asp:textbox Columns="40" ID="txtEmail" MaxLength="250" runat="server" /> 
        <asp:requiredfieldvalidator ControlToValidate="txtEmail" ErrorMessage="No email provided" CssClass="ErrorNotice" id="reqEmail" runat="server"  /> 
      </td>
    </tr>
    <tr valign="top" align="left"> 
      <td width="28%" class="OptionName">Username :</td>
      <td width="72%" class="OptionFields"> <asp:textbox Columns="40" ID="txtUsr" MaxLength="250" runat="server" /> 
        <asp:requiredfieldvalidator ControlToValidate="txtUsr" ErrorMessage="No username provided" CssClass="ErrorNotice" id="reqUsr" runat="server" /></td>
    </tr>
    <tr valign="top" align="left"> 
      <td width="28%" class="OptionName">Password :</td>
      <td width="72%" class="OptionFields"> <asp:textbox Columns="40" ID="txtPwd" runat="server" TextMode="Password" /> 
        <asp:requiredfieldvalidator ControlToValidate="txtPwd" ErrorMessage="No password provided" id="reqPwd" runat="server" /> 
      </td>
    </tr>
    <tr valign="top" align="left"> 
      <td width="28%" class="OptionName">Nick (Screen Name) : </td>
      <td width="72%" class="OptionFields"> <asp:textbox Columns="40" ID="txtNick" MaxLength="250" runat="server" /> 
        <asp:requiredfieldvalidator ControlToValidate="txtNick" ErrorMessage="No nick Provided" CssClass="ErrorNotice" id="reqNick" runat="server" /></td>
    </tr>
    <tr valign="top" align="left">
      <td class="OptionName">Public Info :</td>
      <td class="OptionFields"><asp:textbox Columns="40" ID="txtPublicinfo" MaxLength="250" runat="server" /><br>
        <span class="SmallNotes"> Enter any info that you would like to display 
        to the customer about this user (I.E : Area of expertise)</span></td>
    </tr>
    <tr valign="top" align="left"> 
      <td width="28%" class="OptionName">Simultaneous Requests : </td>
      <td width="72%" class="OptionFields"> <asp:textbox Columns="6" ID="txtSimultaneous" MaxLength="5" runat="server" Text="0" /> 
        <asp:RangeValidator runat="Server" id="reqSimultaneous" ControltoValidate="txtSimultaneous" CssClass="ErrorNotice" type="integer" MinimumValue="0" MaximumValue="999999" ErrorMessage="Please provide a valid number of simultaneous requests" /> 
        <br> <span class="SmallNotes">Max. Number of simultaneous request that 
        this representative should be able to handle.<br>
        Type 0 (Zero) for unlimited (Not Recommended)</span></td>
    </tr>
    <tr valign="top" align="left"> 
      <td width="28%" class="OptionName">Level :</td>
      <td width="72%" class="OptionFields"> <asp:dropdownlist ID="selUlevel" runat="server" ></asp:dropdownlist></td>
    </tr>
    <tr valign="top" align="left"> 
      <td width="28%" class="OptionName">Welcome Message : </td>
      <td width="72%" class="OptionFields"> <asp:textbox Columns="40" ID="txtMywelcomemsg" MaxLength="250" runat="server" /> 
        <br> <span class="SmallNotes">Select a message to begin your chat sessions 
        and welcome your customer</span></td>
    </tr>
    <tr valign="top" align="left"> 
      <td width="28%" class="OptionName">Assigned Departments :</td>
      <td width="72%" class="OptionFields"> <asp:listbox ID="selDepts" Rows="5" runat="server" SelectionMode="multiple" /> 
        <br> <span class="SmallNotes">Use CTRL-Click to select several departments</span></td>
    </tr>
    <tr valign="top" align="left"> 
      <td class="OptionName">Representative Photo :</td>
      <td class="OptionFields"><table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr class="GeneralText"> 
            <td align="center"><b>Current Photo</b><br> <img src="<%=userphoto%>" hspace="10" id="imgUserphoto" ><br> 
              <a href="javascript:deleteimage('<%=userphoto%>','rep')" class="GeneralText">Delete 
              Photo</a> </td>
            <td width="75%">Replace with : 
              <input name="uplUserphoto" type="file" id="uplUserphoto" size="15" runat="server"> 
            </td>
          </tr>
        </table></td>
    </tr>
    <tr valign="top" align="left"> 
      <td class="OptionName">Support Buttons : <br> <span class="SmallNotes"> 
        You can use custom support buttons for each user.</span></td>
      <td class="OptionFields"> <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr class="GeneralText"> 
            <td align="center"><b>Online Image</b><br> <img src="<%=onlineimg%>" hspace="10" id="imgOnline"><br> 
              <a href="javascript:deleteimage('<%=onlineimg%>','on')" class="GeneralText">Delete 
              Button</a> </td>
            <td width="75%">Replace with : 
              <input name="uplOnline" type="file" id="uplOnline" size="15" runat="server"> 
            </td>
          </tr>
          <tr> 
            <td colspan="2" align="center"><hr size="1" noshade></td>
          </tr>
          <tr class="GeneralText"> 
            <td align="center"><b>Offline Image</b><br> <img src="<%=offlineimg%>" hspace="10" id="imgOffline"><br> 
              <a href="javascript:deleteimage('<%=offlineimg%>','off')" class="GeneralText">Delete 
              Button</a> </td>
            <td width="75%">Replace with : 
              <input name="uplOffline" type="file" id="uplOffline" size="15" runat="server" > 
            </td>
          </tr>
        </table></td>
    </tr>
    <tr valign="top" align="left"> 
      <td width="28%" class="OptionName">Additional Info :</td>
      <td width="72%" class="OptionFields"> <asp:textbox Columns="50" ID="txtAdditional" MaxLength="3000" Rows="4" runat="server" TextMode="MultiLine" /></td>
    </tr>
    <tr> 
      <td width="28%" class="OptionName"> <input type="hidden" name="txtUserid" id="txtUserid" value="<%=userid%>" runat="server"/> 
      </td>
      <td width="72%" class="OptionFields"> <input type="button" name="btnButton" id="btnButton" value="Save Representative" runat="server" onServerclick="button_click" /> 
      </td>
    </tr>
  </table>
  </form>
</body>
</html>
