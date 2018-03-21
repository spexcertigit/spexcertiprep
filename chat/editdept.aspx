<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim lvl as integer
dim deptid as integer=0
dim filename as string=""

sub page_load
	lvl=uservalidate(0)
	errormsg.visible=false
	if not(ispostback) then
		dim conn as New SqlConnection(connectionstr)
		dim mycommand as New SqlCommand
		mycommand.connection = conn
		dim dr as SqlDataReader
		
		'/// Request Dept for Edition ///'
		deptid=val(request("deptid"))
		if len(deptid)=0 then 
			deptid=0
			lnkDeletedept.visible=false 
		end if
		txtDeptid.value=deptid
		
		'/// Get Button Image ///'
		onlinebutton.src=getbutton(deptid,"d","on")
		offlinebutton.src=getbutton(deptid,"d","off")
		
		'/// Get Department info from db ///'
		mycommand.commandtext = "xlaALSsp_editdept_loadinfo "
		mycommand.CommandType = CommandType.StoredProcedure
		mycommand.Parameters.Add( "@deptid" , deptid)
		conn.open()
		dr = mycommand.ExecuteReader()
		if dr.Read() then
			txtDeptname.text=dr("deptname")
			txtDeptdescription.text=dr("deptdescription")
			txtDeptemail.text=dr("deptemail")
			txtDepturl.text=dr("depturl")
			docheckbox(chkIshidden,dr("ishidden"))
		end if
		
		'/// Get Assigned Users ///'
		dr.nextresult
		dim users as string = drgetstring(dr)
		
		'/// Get Users List ///'
		dr.nextresult
		do while dr.read
			filllistbox(selUsers, dr("name")&" (" & whichlevel(dr("ulevel")) & ")" , dr("userid") , users)
		loop
		dr.close()
		conn.close()		
		
		'/// Disable controls forrepresentatives ///'
		if lvl=0 then
			txtDeptname.readonly=true
			txtDeptdescription.readonly=true
			txtDeptemail.readonly=true
			txtDepturl.readonly=true
			lnkDeleteDept.visible=false
			savepanel.visible=false
			uploadpanelon.visible=false
			uploadpaneloff.visible=false
			deleteoff.visible=false
			deleteon.visible=false
		end if 
	end if
end sub


sub button_click(s As Object, e As EventArgs)
'/// Save User ///'
	if isnumeric(txtDeptid.value) and Page.isvalid and lvl>0 then
		dim conn as New SqlConnection(connectionstr)
		dim mycommand as New SqlCommand("xlaALSsp_editdept",conn)
		mycommand.commandType =  CommandType.Storedprocedure
		mycommand.Parameters.Add( "@deptid" , txtDeptid.value )
		mycommand.Parameters.Add( "@deptname" , txtDeptname.text)
		mycommand.Parameters.Add( "@deptemail" , txtDeptemail.text)
		mycommand.Parameters.Add( "@depturl" , txtDepturl.text)
		mycommand.Parameters.Add( "@ishidden" , docheckbox(chkIshidden))
		mycommand.Parameters.Add( "@deptdescription" , txtDeptdescription.text)
		mycommand.Parameters.Add( "@users" , listboxresults(selUsers,"0"))
		conn.open()
		dim newdeptid as integer=mycommand.ExecuteScalar()
		conn.close()
		
		'/// Save Online Buttons if Any ///'
		dim uploaded as boolean=true
		filename="d" & newdeptid
		try
			if onlineimg.Postedfile.Filename<>"" and (onlineimg.Postedfile.Filename.endswith(".gif") or onlineimg.Postedfile.Filename.endswith(".jpg")) then onlineimg.Postedfile.SaveAs (server.mappath("files/") & filename & "on.gif")
			if offlineimg.Postedfile.Filename<>"" and (offlineimg.Postedfile.Filename.endswith(".gif") or offlineimg.Postedfile.Filename.endswith(".jpg"))then offlineimg.Postedfile.SaveAs (server.mappath("files/") & filename & "off.gif")
		catch
			uploaded=false
		end try
		
		if uploaded=false then 
			errormsg.visible=true
			txtDeptid.value=newdeptid
		else
			response.redirect("depts.aspx")
		end if
	end if
end sub

</script>
<html>
<head>
<title><%=apptitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript">
function visiturl(){
	theurl=form1.txtDepturl.value;
	if (theurl!=''){
		window.open(theurl);
	} else {
		alert('No URL Provided');
	}
}

function sendmail(){
	themail=form1.txtDeptemail.value;
	if (themail!=''){
		window.open('mailto:' + themail);
	} else {
		alert('No E-Mail Provided');
	}
}


function deletebutton(what){
	var deptid = form1.txtDeptid.value;
	if(deptid=="0") { alert('This is the default button image and cannot be deleted'); return; }
	if(confirm('Delete This button?\nThe Default button will be used instead')){
		if (what=='on') { document.getElementById("onlinebutton").src='deletebutton.aspx?deptid=' + deptid + '&status=on'}
		if (what=='off') { document.getElementById("offlinebutton").src='deletebutton.aspx?deptid=' + deptid + '&status=off'}
	}
	
}
</script>
<link href="ALSStyles.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<form action="editdept.aspx" method="post" enctype="multipart/form-data" name="form1" id="form1" runat="server">
  <table width="96%" border="0" cellspacing="2" cellpadding="2" align="center">
    <tr valign="top" align="left"> 
      <td valign="bottom" class="MainTitles"><img src="images/icdepts.gif" width="20" height="20" align="absmiddle"> 
        View / Edit Department</td>
      <td align="right" valign="bottom"><a href="depts.aspx"><img src="images/btnListDepartments.gif" width="118" height="25" border="0" alt="Show / List depts"></a> 
        <a href="javascript:deletedept()" id="lnkDeleteDept" runat="server"> 
        <script language="JavaScript">
			function deletedept(){
				if (confirm('Delete this Department?')){
					self.location='depts.aspx?kill=<%=deptid%>';
				}
			}
			
</script>
        <img src="images/btnDeleteDepartment.gif" width="118" height="25" alt="Delete dept" border="0"></a> 
      </td>
    </tr>
    <tr> 
      <td colspan="2" bgcolor="#666666"></td>
    </tr>
    <tr> 
      <td colspan="2" id="errormsg" runat="server"><span class="ErrorNotices">Warning 
        : The buttons could not be uploaded due to write permissions on the files/ 
        folder</span><br> <span class="GeneralText"> Upload these files to the 
        <b>files/</b> folder of Absolute Live Support<br>
        Please name the files as <b>&quot;<%=filename & "on.gif"%>&quot;</b> for 
        the online button and <b>&quot;<%=filename & "off.gif"%>&quot;</b> for 
        the offline button</span></td>
    </tr>
    <tr valign="top" align="left"> 
      <td width="27%" class="OptionName">Department Name :</td>
      <td width="73%" class="OptionFields"> <asp:textbox Columns="40" ID="txtDeptname" MaxLength="250" runat="server" /> 
        <asp:requiredfieldvalidator ControlToValidate="txtDeptname" ErrorMessage="No department provided" CssClass="ErrorNotice" id="reqDeptname" runat="server" /> 
      </td>
    </tr>
    <tr valign="top" align="left"> 
      <td width="27%" class="OptionName">Department E-Mail : </td>
      <td width="73%" class="OptionFields"> <asp:textbox ID="txtDeptemail" runat="server" Columns="40"/> 
        <input type="button" name="Button2" value="&gt;&gt;" onClick="javascript:sendmail();"> 
        <asp:requiredfieldvalidator ControlToValidate="txtDeptemail" ErrorMessage="A valid e-mail is required" CssClass="ErrorNotice" id="reqDeptemail" runat="server" /> 
      </td>
    </tr>
    <tr valign="top" align="left"> 
      <td class="OptionName">Department URL : </td>
      <td class="OptionFields"> <asp:textbox ID="txtDepturl" runat="server" Columns="40"/> 
        <input type="button" name="Button" value="&gt;&gt;" onclick="javascript:visiturl();"> 
      </td>
    </tr>
    <tr valign="top" align="left">
      <td class="OptionName">Options :</td>
      <td class="OptionFields"><asp:checkbox id="chkIshidden" Text="Set department as hidden" runat="server"/></td>
    </tr>
    <tr valign="top" align="left"> 
      <td width="27%" class="OptionName"> Assigned Reps : </td>
      <td width="73%" class="OptionFields"> <asp:listbox ID="selUsers" Rows="5" runat="server" SelectionMode="multiple" /><br> 
        <span class="SmallNotes">Make sure to highlight at least one<br>
        You can select several representatives by CTRL-Clicking each name</span></td>
    </tr>
    <tr valign="top" align="left"> 
      <td class="OptionName">Support Buttons : <br> <span class="SmallNotes"> 
        You can use custom support buttons for each department. If no buttons 
        are assigned, the default buttons will be used.</span></td>
      <td class="OptionFields"> <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr class="GeneralText"> 
            <td width="160" align="center"><b>Online Image</b><br> <img src="files/online.gif" hspace="10" id="onlinebutton" runat="server"><br> 
              <a href="javascript:deletebutton('on')" class="GeneralText" runat="server" id="deleteon">Delete 
              Button</a> </td>
            <td id="uploadpanelon" runat="server">Replace with : 
              <input name="onlineimg" type="file" id="onlineimg" size="15" runat="server"> 
            </td>
          </tr>
          <tr> 
            <td colspan="2" align="center"><hr size="1" noshade></td>
          </tr>
          <tr class="GeneralText"> 
            <td width="160" align="center"><b>Offline Image</b><br> <img src="files/offline.gif" hspace="10" id="offlinebutton" runat="server"><br> 
              <a href="javascript:deletebutton('off')" class="GeneralText" runat="server" id="deleteoff">Delete 
              Button</a> </td>
            <td id="uploadpaneloff" runat="server">Replace with : 
              <input name="offlineimg" type="file" id="offlineimg" size="15" runat="server" > 
            </td>
          </tr>
        </table></td>
    </tr>
    <tr valign="top" align="left"> 
      <td class="OptionName">Optional Description :</td>
      <td class="OptionFields"> <asp:textbox Columns="40" ID="txtDeptdescription" MaxLength="1200" Rows="3" runat="server" TextMode="MultiLine" /> 
      </td>
    </tr>
    <tr valign="top" align="left" id="savepanel" runat="server"> 
      <td width="27%" class="OptionName"><input type="hidden" name="txtDeptid" value="" id="txtDeptid" runat="server"/> 
      </td>
      <td width="73%" class="OptionFields"> <input type="button" name="btnButton" id="btnButton" value="Save Department" runat="server" onServerclick="button_click" /> 
        <asp:validationsummary id="validSummary" ShowMessageBox="true" runat="server" headertext="Error : The form cannot be submitted :" showsummary="false" /> 
      </td>
    </tr>
    <tr> 
      <td colspan="2" bgcolor="#666666"></td>
    </tr>
  </table>
  </form>
</body>
</html>

