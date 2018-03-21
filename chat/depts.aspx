<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim lvl as integer=0
dim img as string=""
dim ds as New Dataset
dim x as integer=0
dim code as string=""

sub page_load()
	lvl=uservalidate(0)
	if lvl=0 then img="0" 
	
	code="<scr" &"ipt language=JavaScript src=" & chr(34) & appsettings.applicationurl & "als.aspx?d=$$DEPTID$$" & chr(34) &"></scr" &"ipt>"

	'/// Delete A department if requested
	dim kill as string=request("kill")
	dim killid as integer=0
	if kill<>"" and lvl=1 and isnumeric(kill) then killid=val(kill)
	
	'/// Retrieve Depts And Users
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand("xlaALSsp_depts_list_delete",conn)
	dim myadapter as New SqlDataAdapter(mycommand)
	mycommand.CommandType = CommandType.StoredProcedure
	mycommand.Parameters.Add( "@killid" , killid)
	myadapter.fill(ds,"depts")
end sub
</script>
<html>
<head>
<title><%=apptitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript">
function deletedept(deptid){
<%if lvl=0 then%>
	alert('This option is only available for system administrators');
<%else%>
	if (confirm('Delete This Department?')){
		self.location='depts.aspx?kill=' + deptid;
	}
<%end if%>
}
</script>
<link href="ALSStyles.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="96%" border="0" cellspacing="2" cellpadding="2" align="center">
  <tr> 
    <td colspan="2" align="left" class="MainTitles"><img src="images/icdepts.gif" width="20" height="20" align="absmiddle"> 
      Support Departments </td>
    <td colspan="5" align="right"> 
      <%if lvl=1 then%>
      <a href="editdept.aspx"><img src="images/btnAddDepartment.gif" width="118" height="25" alt="Create a New Department" border="0"></a> 
      <%end if%>
    </td>
  </tr>
  <tr> 
    <td colspan="7" align="left" valign="top" bgcolor="#666666"></td>
  </tr>
  <tr class="SmallNotes"> 
    <td colspan="7" align="left" valign="top">Use the support button code to directly 
      connect the customers with the selected department once they click on the 
      button.<br>
      Make sure that each department has a valid e-mail address and at least one 
      representative assigned.</td>
  </tr>
  <tr>
    <td colspan="7" align="left" valign="top" bgcolor="#666666"></td>
  </tr>
  <tr class="Headers"> 
    <td width="6%" height="30" align="left"> <div align="right">#</div></td>
    <td height="30" align="left">Department / Description</td>
    <td width="20%" height="30" align="left">E-Mail</td>
    <td width="16%" height="30" align="center">Support Button Code</td>
    <td width="8%" height="30" align="center">Reps.</td>
    <td width="8%" height="30" align="left"> <div align="center">View / Edit</div></td>
    <td width="8%" height="30" align="left"> <div align="center">Delete</div></td>
  </tr>
  <%dim rs as object,ishidden as string
  for x=0 to ds.tables("depts").rows.count-1
  rs=ds.tables("depts").rows(x)
  if rs.item("ishidden")<>"" then ishidden=" - Dept is hidden<br>" else ishidden="" %>
  <tr class="OptionFields"> 
    <td width="6%" align="left" valign="top"> <div align="right"><b><%=x+1%>.</b></div></td>
    <td align="left" valign="top"><a href="editdept.aspx?deptid=<%=rs.item("deptid")%>"><b><%=rs.item("deptname")%></b></a><br> 
      <span class="SmallNotes">- URL : <a href="<%=rs.item("depturl")%>" target="_blank"><%=rs.item("depturl")%></a><br><%=ishidden%>
      - Description : <%=rs.item("deptdescription")%></span></td>
    <td width="20%" align="left" valign="top"><a href="mailto:<%=rs.item("deptemail")%>"><b><%=rs.item("deptemail")%></b></a></td>
    <td width="16%" valign="top"><textarea name="textfield" rows="3" class="SmallNotes" style="width:160px" readonly><%=replace(code,"$$DEPTID$$",rs.item("deptid"))%></textarea></td>
    <td width="8%" align="center" valign="top"> <b><a href="users.aspx?deptid=<%=rs.item("deptid")%>"><%=rs.item("totalusers")%></a></b></td>
    <td width="8%" align="center"><a href="editdept.aspx?deptid=<%=rs.item("deptid")%>"><img src="images/btnView.gif" width="27" height="27" alt="Edit dept" border="0"></a> 
      <br> </td>
    <td width="8%" align="center" valign="middle"> <a href="javascript:deletedept(<%=rs.item("deptid")%>)"><img src="images/btnKill<%=img%>.gif" width="27" height="27" alt="Delete Departmentdept" border="0"></a></td>
    <%next%>
  <tr> 
    <td colspan="7" align="left" valign="top" bgcolor="#666666"></td>
  </tr>
  <%if x=0 and lvl=1 then%>
  <tr> 
    <td colspan="7" align="center"> <span class="ErrorNotices"><b><br>
      There are no departments registered<br>
      <a href="editdept.aspx"><img src="images/btnAddDepartment.gif" width="118" height="25" alt="Create a New Department" border="0"></a> 
      </b></span> </td>
  </tr>
  <%end if%>
</table>
</body>
</html>



