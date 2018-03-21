<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim depts as string=""
dim lvl as integer
dim img as string=""
dim ds as New Dataset
dim x as integer=0
dim mypage as integer=1
dim mypagesize as integer=10
dim totalrecs as integer=0
dim totalpages as integer=0
dim deptid as string=""

sub page_load()
	lvl=uservalidate(0)
	if lvl=0 then
		img="0" 
		lnkEdituser.visible=false
	end if
	
	'/// Hide Message for users found
	errormsg.visible=false
	
	if not(ispostback) then
		mypage=1
		dim kill as string=request("kill")
		if kill<>"" then deleteuser(kill)
		
		'/// Retrieve Parameters from external scripts		
		deptid=request("deptid")
				
		'/// Fill drop-down lists
		'/// Departments
		dim conn as New SqlConnection(connectionstr)
		dim mycommand as New SqlCommand
		mycommand.connection = conn
		mycommand.commandtext = "xlaALSsp_user_search_loadinfo"
		mycommand.CommandType = CommandType.StoredProcedure
		dim dr as SqlDataReader
		conn.open()
		dr = mycommand.ExecuteReader()
		filllistbox(ddlDept," -- ANY --", "", "")
		do while dr.read()
			filllistbox(ddlDept,dr("deptname"),dr("deptid"),deptid)
		loop
		dr.close()
		conn.close()
		
		'/// Fill Levels
		dim x as integer=0
		filllistbox(ddlUlevel," -- ANY --","","")
		for x=0 to ubound(whichlevel)
			filllistbox(ddlUlevel,whichlevel(x),x,"")
		next
		
		'/// Fill Status
		filllistbox(ddlStatus," -- ANY --","","")
		for x=0 to ubound(whichstatus)
			filllistbox(ddlStatus,whichstatus(x),x,"")
		next
		
		'/// Execute First Search
		mypage=1
		call dosearch()
		
	end if
end sub

sub dosearch()
	'/// Values that could have been passed as parameters from other scripts
	if deptid="" then deptid=listboxresults(ddlDept,"")

	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand("xlaALSsp_users_search",conn)
	dim myadapter as New SqlDataAdapter(mycommand)
	mycommand.CommandType = CommandType.StoredProcedure
	mycommand.Parameters.Add( "@name" , txtName.text)
	mycommand.parameters.add( "@dept" , deptid)
	mycommand.Parameters.Add( "@ulevel" , listboxresults(ddlUlevel,""))
	mycommand.Parameters.Add( "@status" , listboxresults(ddlStatus,""))
	mycommand.Parameters.Add( "@currentpage" , mypage)
	mycommand.Parameters.Add( "@pagesize" , mypagesize)
	myadapter.fill(ds,"results")
	totalrecs=ds.tables(0).rows(0).item("totalrecs")
	totalpages=ds.tables(0).rows(0).item("totalpages")
	if totalrecs=0 then mypage=1
	viewstate("mypage")=mypage

	'/// Hide Prev / Next buttons
	btnPrev.visible=true
	btnNext.visible=true
	if mypage<=1 or totalpages=0 then btnPrev.visible=false
	if mypage>=totalpages or totalpages=0 then btnNext.visible=false
	
	'/// Fill Pages Selector
	clearlistbox(ddlPage)
	for x=1 to totalpages
		filllistbox(ddlpage,x,x,mypage)
	next
end sub


sub search_buttonclick(s as object, e as EventArgs)
	mypage=1
	call dosearch()
end sub

sub gopage(s as object, e as EventArgs)
	mypage=val(listboxresults(ddlPage,""))
	call dosearch()
end sub

sub prev_buttonclick(s as object, e as EventArgs)
	mypage=val(viewstate("mypage"))
	mypage=mypage-1
	if mypage<1  then mypage=1
	call dosearch()
end sub

sub next_buttonclick(s as object, e as EventArgs)
	mypage=val(viewstate("mypage"))
	mypage=mypage+1
	call dosearch()
end sub

sub dodelete(s as object, e as EventArgs)
	if tokill.value<>"" and isnumeric(tokill.value) then
		call deleteuser(val(tokill.value))
	end if
	tokill.value=""
end sub

sub deleteuser(what as integer)
	if lvl=1 then
		if what<>val(getusrid) then
			dim conn as New SqlConnection(connectionstr)
			dim mycommand as New SqlCommand("xlaALSsp_users_delete",conn)
			mycommand.CommandType = CommandType.StoredProcedure
			mycommand.Parameters.Add( "@killid" , what)
			conn.open()
			mycommand.executenonquery
			conn.close()
			try
				System.IO.File.Delete(server.mappath("representatives") & what & ".gif")
			catch
				'/// Nothing Happens ///'
			end try
		else
			errormsg.visible=true
		end if
	end if
	mypage=val(viewstate("mypage"))
	call dosearch()
end sub
</script>

<html>
<head>
<title><%=apptitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript">
<%if lvl=1 then%>
function edituser(userid){
	self.location='edituser.aspx?userid=' + userid;
}

function deleteuser(userid){
	if (confirm('Delete this representative?')){
		form1.tokill.value=userid;
		form1.submit();
	} else {
		form1.tokill.value="";
	}
}
<%else%>
function edituser(userid){
	alert('This option is only available to system administrators');
}

function deleteuser(userid){
	edituser(userid);
}
<%end if%>
</script>
<link href="ALSStyles.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<form name="form1" id="form1" runat="server" action="users.aspx">
  <table width="96%" border="0" align="center" cellpadding="2" cellspacing="1">
    <tr> 
      <td class="MainTitles"><b><img src="images/icusers.gif" width="20" height="21" align="absmiddle"> 
        Representatives</b></td>
      <td align="right"><a href="edituser.aspx" id="lnkEditUser" runat="server"><img src="images/btnAdduser.gif" width="118" height="25" border="0" alt="Register a New Representative"></a> 
      </td>
    </tr>
    <tr> 
      <td colspan="2" align="left" valign="top" class="SearchCell"></td>
    </tr>
    <tr id="errormsg" runat="server"> 
      <td colspan="2" align="left" valign="top" class="ErrorNotices">Error - The 
        representative could not be deleted : <br>You cannot delete yourself</td>
    </tr>
    <tr> 
      <td width="28%" class="OptionName">Name / Nick / Email:</td>
      <td width="72%" class="OptionFields"><asp:textbox Columns="50" ID="txtName" MaxLength="255" runat="server" />
        </td>
    </tr>
    <tr> 
      <td width="28%" class="OptionName">Level :</td>
      <td width="72%" class="OptionFields"> 
        <asp:dropdownlist ID="ddlUlevel" runat="server" /></td>
    </tr>
    <tr> 
      <td width="28%" class="OptionName">Department : </td>
      <td width="72%" class="OptionFields"><asp:dropdownlist ID="ddlDept" runat="server" />
      </td>
    </tr>
    <tr> 
      <td width="28%" class="OptionName">Current Status : </td>
      <td width="72%" class="OptionFields">
        <asp:dropdownlist ID="ddlStatus" runat="server" />
       </td>
    </tr>
    <tr align="right" class="SearchCell"> 
      <td colspan="2"><input name="tokill" type="hidden" id="tokill" value="" runat="server" onserverchange="dodelete">
        <asp:button ID="btnSearch" runat="server" Text="List Representatives" onclick="search_Buttonclick"  />
	  </td>
    </tr>
  </table>
  <br>
  <table width="96%" border="0" cellspacing="2" cellpadding="1" align="center" id="ResultsTable">
    <%if totalrecs>0 then%>
    <tr> 
      <td colspan="8" align="left" class="GeneralText"> <b>Representatives Found 
        : <%=totalrecs%><br>
        Page <%=mypage%> of <%=totalpages%></b></td>
    </tr>
    <tr class="Headers"> 
      <td width="5%" height="30" align="right"> #</td>
      <td height="30" align="left"> Representative</td>
      <td width="20%" height="30" align="left"> Email</td>
      <td width="8%" height="30" align="center"> Level</td>
      <td width="8%" height="30" align="center">Status</td>
      <td width="8%" height="30" align="center"> View</td>
      <td width="8%" height="30" align="center"> Edit</td>
      <td width="8%" height="30" align="center"> Delete</td>
    </tr>
    <%
	dim imgstatus as string="imgOnline.gif"
	dim cc as integer=(mypagesize*mypage)-mypagesize+1
	for x=0 to ds.tables(1).rows.count-1
	dim rs as object=ds.tables(1).rows(x)
	if rs.item("status")=0 then imgstatus="imgOffline.gif" else imgstatus="imgOnline.gif"
	%>
    <tr bgcolor="#CCCCCC" class="OptionFields"> 
      <td width="5%" align="right" valign="top"><b><%=x+cc%>.</b></td>
      <td align="left" valign="top"><b><a href="viewuser.aspx?userid=<%=rs.item("userid")%>"><%=rs.item("name")%></a><br>
        </b><span class="SmallNotes">- Nick : <%=rs.item("nick")%><br>
        - Last login : <%=revertdate(rs.item("lastlogin"))%></span><b><br>
        </b></td>
      <td width="20%" align="left" valign="top"><b><a href=mailto:<%=rs.item("email")%>><%=rs.item("email")%></a></b></td>
      <td width="8%" align="center" valign="top"><%=whichlevel(rs.item("ulevel"))%></td>
      <td width="8%" align="center" valign="top"><span class="SmallNotes"><img src="images/<%=imgstatus%>" width="27" height="27"><br>
        <%=whichstatus(rs.item("status"))%></span></td>
      <td width="8%" align="center"> <a href="viewuser.aspx?userid=<%=rs.item("userid")%>"><img src="images/btnView.gif" width="27" height="27" border="0"></a></td>
      <td width="8%" align="center"> <a href="javascript:edituser(<%=rs.item("userid")%>)"><img src="images/btnEdit<%=img%>.gif" width="27" height="27" alt="Edit representative" border="0"></a></td>
      <td width="8%" align="center"> <a href="javascript:deleteuser(<%=rs.item("userid")%>)"><img src="images/btnKill<%=img%>.gif" width="27" height="27" alt="Delete representative" border="0"></a></td>
    </tr>
    <%next%>
    <tr> 
      <td colspan="8" align="left" valign="top" bgcolor="#666666"></td>
    </tr>
    <tr> 
      <td colspan="8" align="left" valign="top" class="GeneralText"><b>Go to Page 
        : 
        <asp:dropdownlist ID="ddlPage" runat="server" OnSelectedIndexChanged="gopage" AutoPostBack="true"/>
        <asp:LinkButton text="<< Prev" onclick="prev_Buttonclick" id="btnPrev" runat="server"/>
        <asp:LinkButton text="Next >>" onclick="next_Buttonclick" id="btnNext" runat="server"/>
        </b></td>
    </tr>
	<%else%>
    <tr align="center"> 
      <td colspan="8" valign="top" class="ErrorNotices">No representatives were 
        found for the specified criteria</td>
    </tr>
	<%end if%>
  </table>
  </form>
</body>
</html>

