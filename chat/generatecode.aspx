<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim thecode as string=""

sub page_load()
	call uservalidate(0)
	
	if not(ispostback) then
		'/// Fill Drop Down lists ///'
		dim conn as New SqlConnection(connectionstr)
		dim mycommand as New SqlCommand
		dim dr as SqlDataReader
		mycommand.connection = conn
		mycommand.commandtext = "xlaALSsp_codegenerator_loadinfo"
		conn.open()
		dr = mycommand.ExecuteReader()
		
		'/// Fill Departments ///'
		do while dr.read()
			filllistbox(selDepts, dr("deptname") , dr("deptid") , "")
		loop
		
		dr.nextresult()
		'/// Fill Users ///'
		do while dr.read()
			filllistbox(selUsers, dr("name") & " (" & dr("nick") & ")" , dr("userid") , "")
		loop
		dr.close()
		conn.close()
		call generatecode()
		radSystem.checked=true
	end if
end sub

sub button_click(s As Object, e As EventArgs)
	call generatecode()
end sub

sub generatecode()
	dim c as string = chr(34)
	dim codeparams as string=""
	
	'/// Normal code ///'
	thecode="<scr" & "ipt language=JavaScript src=" & c &"[APPURL]als.aspx[PARAMS]" & c &"></sc" &"ript>"
	
	if docheckbox(chkText)<>"" and docheckbox(chkEmail)<>"" then
		thecode="<a href=" & c & "[APPURL]alsemail.aspx[PARAMS]" & c &" target=_blank>Click for support</a>"
		codeparams = "getstatus=1&"
	elseif docheckbox(chkEmail)<>"" then
		thecode="<a href=" & c & "[APPURL]alsemail.aspx[PARAMS]" & c &" target=_blank><img src=" & c & "[APPURL]als.aspx[PARAMS]" & c & " border=0></a>"
		codeparams = "getstatus=1&"
	elseif docheckbox(chkText)<>"" then
		thecode="<scr" & "ipt language=JavaScript src=" & c &"[APPURL]alstext.aspx[PARAMS]" & c &"></sc" &"ript>"
		thecode &="<a href=" & c & "javascript:xlaALSrequest();" & c &" target=_self>Click for support</a>"
	end if
	

	if radDept.checked then codeparams &= "d=" & listboxresults(selDepts,"") & "&"
	if radUser.checked then codeparams &= "u=" & listboxresults(selUsers,"") & "&"
	
	if docheckbox(chkBypass)<>"" then codeparams &= "bypass=1&"
	if codeparams<>"" then codeparams="?" & left(codeparams,len(codeparams)-1)
	
	thecode=replace(thecode,"[APPURL]",appsettings.applicationurl)
	thecode=replace(thecode,"[PARAMS]",codeparams)
	txtCode.text=thecode
end sub

</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Code Generator</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="ALSStyles.css" rel="stylesheet" type="text/css">
</head>

<body>
<form name="form1" runat="server">
  <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1">
    <tr> 
      <td colspan="2" class="GeneralText"> <b>Generate Code For :</b></td>
    </tr>
    <tr> 
      <td class="GeneralText"> <input type="radio" name="codetype" id="radSystem" runat="server">
        System </td>
      <td width="70%" class="GeneralText">&nbsp;</td>
    </tr>
    <tr> 
      <td class="GeneralText"> <input type="radio" name="codetype" id="radDept" runat="server">
        Department :</td>
      <td width="70%" class="GeneralText"> <asp:dropdownlist ID="selDepts" runat="server" CssClass="SmallNotes" width="170px" /></td>
    </tr>
    <tr> 
      <td height="22" class="GeneralText"> <input type="radio" name="codetype" id="radUser" runat="server">
        User :</td>
      <td width="70%" class="GeneralText"> <asp:dropdownlist ID="selUsers" runat="server" CssClass="SmallNotes" width="170px" /></td>
    </tr>
    <tr> 
      <td colspan="2" class="GeneralText">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="2" class="GeneralText"><b>Additional Options :</b></td>
    </tr>
    <tr> 
      <td colspan="2" class="GeneralText"> <input name="chkBypass" type="checkbox" id="chkBypass" value="checked" runat="server">
        Bypass Form (direct chat connection)</td>
    </tr>
    <tr> 
      <td colspan="2" class="GeneralText"> <input name="chkEmail" type="checkbox" id="chkEmail" value="checked" runat="server">
        E-Mail Signature (Code for adding a support button to e-mail messages) 
      </td>
    </tr>
    <tr>
      <td colspan="2" class="GeneralText"><input name="chkText" type="checkbox" id="chkText" value="checked" runat="server">
        Text Link (do not display graphic button)</td>
    </tr>
    <tr> 
      <td colspan="2"><table width="100%" border="2" cellspacing="2" cellpadding="2">
          <tr align="center" valign="top" class="OptionFields"> 
            <td width="50%"><b>Generated Code : </b><br>
              <asp:textbox ID="txtCode"  Rows="4" runat="server" TextMode="MultiLine" CssClass="SmallNotes" width="210px" /></td>
            <td width="50%"><b>Preview :</b><br> <%=thecode%> </td>
          </tr>
        </table></td>
    </tr>
    <tr align="right"> 
      <td colspan="2"> <input type="button" name="btnButton" id="btnButton" value="Generate Code" runat="server" onServerclick="button_click" /> 
      </td>
    </tr>
  </table>
  </form>
</body>
</html>
