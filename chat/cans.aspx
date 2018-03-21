<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim depts as string=""
dim lvl as integer
dim ds as New Dataset
dim x as integer=0
dim mypage as integer=1
dim mypagesize as integer=10
dim totalrecs as integer=0
dim totalpages as integer=0

sub page_load()
	lvl=uservalidate(0)
	if not(ispostback) then
		mypage=1
		dim kill as string=request("kill")
		if kill<>"" then deletecan(kill)
		
		'/// Fill drop-down lists
		'/// Can Scopes
		dim conn as New SqlConnection(connectionstr)
		dim mycommand as New SqlCommand
		mycommand.connection = conn
		mycommand.commandtext = "xlaALSsp_cans_search_loadinfo"
		mycommand.CommandType = CommandType.StoredProcedure
		dim dr as SqlDataReader
		conn.open()
		dr = mycommand.ExecuteReader()
		filllistbox(ddlCanscope," -- Any --","","")
		filllistbox(ddlCanscope," -- All Representatives --","g","")
		filllistbox(ddlCanscope," -- Personal Cans --","p","")
		filllistbox(ddlCanscope," -- My Personal Cans --","m","")
		do while dr.read()
			filllistbox(ddlCanscope,dr("deptname"),dr("deptid"),"")
		loop
		dr.close()
		conn.close()
		
		'/// Fill Commands
		dim x as integer=0
		filllistbox(ddlCancmd," -- ALL --","","")
		for x=0 to 5
			filllistbox(ddlCancmd,cantype(x),x,"")
		next
			
		'/// Execute First Search
		mypage=1
		call dosearch()
		
	end if	
end sub


sub deletecan(what as integer)
	dim userid as integer=getusrid
	if lvl=1 then userid=0
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand("xlaALSsp_cans_delete",conn)
	mycommand.CommandType = CommandType.StoredProcedure
	mycommand.Parameters.Add( "@killid" , what)
	mycommand.Parameters.Add( "@userid" , userid)
	conn.open()
	mycommand.executenonquery
	conn.close()
	mypage=val(viewstate("mypage"))
	call dosearch()
end sub

sub dosearch()
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand("xlaALSsp_cans_search",conn)
	dim myadapter as New SqlDataAdapter(mycommand)
	dim canscope as string=listboxresults(ddlCanscope,"")
	if lvl=0 then canscope="m"
	mycommand.CommandType = CommandType.StoredProcedure
	mycommand.Parameters.Add( "@canname" , txtCanname.text)
	mycommand.parameters.add( "@username" , txtUsername.text)
	mycommand.Parameters.Add( "@canscope" , canscope)
	mycommand.Parameters.Add( "@cancmd" , listboxresults(ddlCancmd,""))
	mycommand.Parameters.Add( "@userid" , getusrid)
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
		call deletecan(val(tokill.value))
	end if
	tokill.value=""
end sub


</script>
<html>
<head>
<title>View Canned Commands</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript">
function deletecan(canid){
	if (confirm('Delete this canned coomand?')){
		form1.tokill.value=canid;
		form1.submit();
	} else {
		form1.tokill.value='';
	}
}
</script>
<link href="ALSStyles.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<form name="form1" id="form1" method="post" action="cans.aspx" runat="server">
  <table width="96%" border="0" cellspacing="1" cellpadding="2" align="center">
    <tr> 
      <td class="MainTitles"><img src="images/icCans.gif" width="20" height="20" align="absmiddle"> 
        Canned Commands </td>
      <td align="right"><b><a href="editcan.aspx"><img src="images/btnCreateNewCan.gif" width="118" height="25" border="0" alt="Create a New Canned Command"></a></b></td>
    </tr>
    <tr> 
      <td colspan="2" bgcolor="#666666"></td>
    </tr>
	<%if lvl=1 then%>
    <tr> 
      <td width="28%" class="OptionName"><font size="2">Can Name / Keyword :</font></td>
      <td width="75%" class="OptionFields"> <asp:textbox Columns="40" ID="txtCanname" runat="server" /> 
      </td>
    </tr>
    <tr> 
      <td width="28%" class="OptionName"><font size="2">User Name : </font></td>
      <td width="75%" class="OptionFields"><asp:textbox Columns="40" ID="txtUsername" runat="server" /> 
      </td>
    </tr>
    <tr> 
      <td width="28%" class="OptionName"><font size="2">Scope :</font></td>
      <td width="75%" class="OptionFields"> <asp:dropdownlist ID="ddlCanscope" runat="server" /> </td>
    </tr>
    <tr> 
      <td width="28%" class="OptionName"><font size="2">Command :</font></td>
      <td width="75%" class="OptionFields"> <asp:dropdownlist ID="ddlCancmd" runat="server" /> </td>
    </tr>
    <tr align="right"> 
      <td colspan="2" class="SearchCell"><input name="tokill" type="hidden" id="tokill" value="" runat="server" onserverchange="dodelete"> 
        <asp:button ID="btnSearch" runat="server" Text="View Cans" onclick="search_Buttonclick"  /></td>
    </tr>
	<%end if%>
  </table>

  <br>
  <table width="96%" border="0" align="center" cellpadding="3">
    <%if totalrecs>0 then%>
    <tr class="GeneralText"> 
    <td colspan="6"><b>Cans Found : <%=totalrecs%><br>
        Page <%=mypage%> of <%=totalpages%></b></td>
  </tr>
  <tr class="Headers"> 
      <td width="5%" height="30" align="right">#</td>
      <td width="25%" height="30" align="left">Name<br> </td>
      <td height="30" align="left">Command <br> </td>
      <td width="16%" height="30" align="center"> Scope</td>
      <td width="8%" height="30"  align="center">View / Edit</td>
      <td width="8%" height="30"  align="center">Delete</td>
  </tr>
  <%dim cc as integer=(mypagesize*mypage)-mypagesize+1
  	dim canmsg as string
	dim canscope as string
	for x=0 to ds.tables(1).rows.count-1
	dim rs as object=ds.tables(1).rows(x)
	canmsg=rs.item("canmsg")
	if len(canmsg)>300 then canmsg=left(rs.item("canmsg"),300) & "..."
	canmsg="<b>" & cantype(rs.item("cancmd")) & "</b> : " & server.HtmlEncode(canmsg)
	select case rs.item("canscope")
		case 0
			canscope="Personal Can"
		case 1
			canscope="Several Reps. / Depts."
		case 2
			canscope="All Representatives" 
	end select
	%>
  <tr class="OptionFields"> 
    <td width="5%" align="right" valign="top"><%=x+cc%>.</td>
    <td width="25%" align="left" valign="top"><%=rs.item("canname")%> </td>
    <td align="left" valign="top"><%=canmsg%></td>
      <td width="16%" align="center" valign="top"><%=canscope%></td>
    <td width="8%" align="center" valign="top"><a href="editcan.aspx?canid=<%=rs.item("canid")%>"><img src="images/btnView.gif" width="27" height="27" alt="View / Edit Canned Command" border="0"></a></td>
    <td width="8%" align="center" valign="top"><a href="javascript:deletecan('<%=rs.item("canid")%>');"><img src="images/btnKill.gif" width="27" height="27" border="0" alt="Delete Canned Command"></a></td>
  </tr>
  <%next%>
  <tr> 
    <td colspan="6" align="right" class="SearchCell"></td>
  </tr>
  <tr> 
    <td colspan="6" valign="top" class="GeneralText"><b>Go to Page : 
      <asp:dropdownlist ID="ddlPage" runat="server" OnSelectedIndexChanged="gopage" AutoPostBack="true"/> 
      <asp:LinkButton text="<< Prev" onclick="prev_Buttonclick" id="btnPrev" runat="server"/> 
      <asp:LinkButton text="Next >>" onclick="next_Buttonclick" id="btnNext" runat="server"/> 
      </b></td>
  </tr>
  <%else%>
  <tr align="center" valign="middle"> 
      <td colspan="6" class="ErrorNotices">No canned commands were found<a href="editcan.aspx"><br>
        <img src="images/btnCreateNewCan.gif" width="118" height="25" border="0" alt="Create a New Canned Command"></a> 
      </td>
  </tr>
  <%end if%>
</table>
</form>
</body>
</html>
