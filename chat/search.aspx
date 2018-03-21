<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim lvl as integer
dim img as string=""
dim name as string=""
dim topic as string=""
dim repname as string=""
dim ref as string=""
dim rating as string=""
dim requestid as string=""
dim datecriteria as string=""
dim date1 as string=""
dim date2 as string=""
dim orderby as string=""
dim deptid as string=""
dim depts as new hashtable()
dim resultquery as string=""

dim ds as New Dataset
dim x as integer=0
dim mypage as integer=1
dim mypagesize as integer=20
dim totalrecs as integer=0
dim totalpages as integer=0


function exporttime(what) as string
	if instr(what,"(")<>0 then what=left(what,8) else what=""
	exporttime=what
end function

sub page_load()
	lvl=uservalidate(0)

	if lvl=0 then
		'/// Hide Admin Only buttons and set faded buttons
		img="0" 
		lnkAdminoptions.visible=false
	end if
	
	if not(ispostback) then
		dim kill as string=request("kill")
		if kill<>"" and lvl>0 then deleterequest(kill)
		
		'/// Retrieve Parameters from external scripts		
		deptid=request("deptid")
		name=request("name")
		repname=request("repname")
		if name<>"" then txtName.text=name
		if repname<>"" then txtRepname.text=repname


		'/// Fill drop-down lists
		'/// Departments
		dim conn as New SqlConnection(connectionstr)
		dim mycommand as New SqlCommand
		mycommand.connection = conn
		mycommand.commandtext = "xlaALSsp_search_list_depts"
		mycommand.CommandType = CommandType.StoredProcedure
		dim dr as SqlDataReader
		conn.open()
		dr = mycommand.ExecuteReader()
		filllistbox(ddlDept," -- ALL --", "", "")
		filllistbox(ddlDept," -- My Departments --", "m", "")
		filllistbox(ddlDept," -- None (proactive chats) --", "0", "")
		do while dr.read()
			filllistbox(ddlDept,dr("deptname"),dr("deptid"),deptid)
			depts.add(dr("deptid"),dr("deptname"))
		loop
		dr.close()
		conn.close()
		viewstate("depts")=depts
		
		'/// Fill Ratings
		dim x as integer=0
		filllistbox(ddlRating," -- ANY --","","")
		filllistbox(ddlRating," -- Not Rated --","","")
		for x=5 to 1 step -1
			filllistbox(ddlRating,x,x,"")
		next
		
		'/// Fill Months, days, years
		'Months
		for x=1 to 12
			filllistbox(ddlMonth1,monthname(x),x,month(todaydate))
			filllistbox(ddlMonth2,monthname(x),x,month(todaydate))
		next
		'Days
		for x=1 to 31
			filllistbox(ddlDay1,x,x,day(todaydate))
			filllistbox(ddlDay2,x,x,day(todaydate))
		next
		'Years
		for x=year(todaydate)-15 to year(todaydate)+15
			filllistbox(ddlYear1,x,x,year(todaydate))
			filllistbox(ddlYear2,x,x,year(todaydate))
		next
		
		'/// Execute First Search
		mypage=1
		call dosearch()
	end if
	depts=viewstate("depts")
end sub

sub dosearch()
	'/// Values that could have been passed as parameters from other scripts
	if deptid="" then deptid=listboxresults(ddlDept,"")
	if name="" then name=txtName.text
	if repname="" then repname=txtRepname.text
	'/// Sorting Parameters
	orderby=tosort.value
	
	datecriteria=docheckbox(chkDatecriteria)
	if datecriteria<>"" then
		date1=listboxresults(ddlYear1,"") & "/" & right("0" & listboxresults(ddlMonth1,""),2) & "/" & right("0" & listboxresults(ddlDay1,""),2)
		date2=listboxresults(ddlYear2,"") & "/" & right("0" & listboxresults(ddlMonth2,""),2) & "/" & right("0" & listboxresults(ddlDay2,""),2)
	end if

	rating=listboxresults(ddlRating,"")
	requestid=Replace(txtRequestid.text," ","") & ""
	if not(isnumeric(requestid)) then requestid=""
	
	
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand("xlaALSsp_search_requests",conn)
	dim myadapter as New SqlDataAdapter(mycommand)
	mycommand.CommandType = CommandType.StoredProcedure
	mycommand.Parameters.Add( "@name" , name)
	mycommand.Parameters.Add( "@userid" , getusrid)
	mycommand.parameters.add( "@topic" , txtTopic.text)
	mycommand.parameters.add( "@repname" , repname)
	mycommand.parameters.add( "@ref" , txtRef.text)
	mycommand.parameters.add( "@deptid" , deptid)
	mycommand.parameters.add( "@rating" , rating)
	mycommand.parameters.add( "@requestid" , requestid)
	mycommand.parameters.add( "@datecriteria" , datecriteria)
	mycommand.parameters.add( "@date1" , date1)
	mycommand.parameters.add( "@date2" , date2)
	mycommand.parameters.add( "@orderby",orderby)
	mycommand.Parameters.Add( "@currentpage" , mypage)
	mycommand.Parameters.Add( "@pagesize" , mypagesize)
	myadapter.fill(ds,"results")
	totalrecs=ds.tables(0).rows(0).item("totalrecs")
	totalpages=ds.tables(0).rows(0).item("totalpages")
	resultquery=ds.tables(2).rows(0).item("resultquery")
	resultquery=server.UrlEncode(resultquery)
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
		call deleterequest(val(tokill.value))
	elseif tokill.value<>"" then
		call deletefound(tokill.value)
	end if
	tokill.value=""
end sub


sub deleterequest(what as integer)
	if lvl=1 then
		dim conn as New SqlConnection(connectionstr)
		dim mycommand as New SqlCommand("xlaALSsp_delete_request",conn)
		mycommand.CommandType = CommandType.StoredProcedure
		mycommand.Parameters.Add( "@killid" , what)
		conn.open()
		mycommand.executenonquery
		conn.close()
	end if
	mypage=val(viewstate("mypage"))
	call dosearch()
end sub

sub deletefound(what as string)
	if lvl=1 then
		what=server.urldecode(what) & ""
		dim conn as New SqlConnection(connectionstr)
		dim mycommand as New SqlCommand("xlaALSsp_delete_results",conn)
		mycommand.CommandType = CommandType.StoredProcedure
		mycommand.Parameters.Add( "@psql" , what)
		conn.open()
		mycommand.executenonquery
		conn.close()
	end if
	call dosearch()
end sub

</script>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript">
function deleterequest(requestid){
	<%if lvl=1 then%>
	if (confirm('Delete request?')){
		form1.tokill.value=requestid;
		form1.submit();
	} else {
		form1.tokill.value="";
	}
	<%else%>
		alert('You\'re not allowed to delete this request');
	<%end if%>
}

function resort(what){
	form1.tosort.value=what;
	form1.btnSearch.click();
}

function deletefound(){
	if (confirm('You have selected to delete these results\nThis action can\'t be undone\nDo you want to proceed?')){
		form1.tokill.value=form2.resultquery.value;
		form1.submit();
	}
}

function printable(format){
	window.open("about:blank","export","toolbar=1,location=0,status=1,menubar=0,scrollbars=1,resizable=1,width=620,height=420");
	form2.action='export.aspx?format=' + format;
	form2.submit();
	
}
</script>
<link href="ALSStyles.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<form name="form1" id="form1" method="post" runat="server">
  <table width="96%" border="0" cellspacing="1" cellpadding="2" align="center">
    <tr> 
      <td colspan="2" class="MainTitles"> <img src="images/icSearch.gif" width="20" height="20" align="absmiddle"> 
        Search / View Requests</td>
    </tr>
    <tr> 
      <td colspan="2" class="SearchCell"></td>
    </tr>
    <tr class="OptionFields"> 
      <td colspan="2"><span class="SmallNotes">Use this option to browse through 
        the submited requests by defining any search criteria. If you don't define 
        any criteria, all the requests will be returned.</span></td>
    </tr>
    <tr> 
      <td colspan="2" class="SearchCell"></td>
    </tr>
    <tr> 
      <td width="27%" class="OptionName">Customer Name, E-mail or ID :</td>
      <td width="73%" class="OptionFields"> 
        <asp:textbox Width="80%" ID="txtName" MaxLength="255" runat="server" /> </td>
    </tr>
    <tr> 
      <td width="27%" class="OptionName">Keywords :</td>
      <td width="73%" class="OptionFields"> 
        <asp:textbox Width="80%" ID="txtTopic" MaxLength="255" runat="server" /> </td>
    </tr>
    <tr> 
      <td width="27%" class="OptionName">Representative Assigned / ID :</td>
      <td width="73%" class="OptionFields"> 
        <asp:textbox Width="80%" ID="txtRepname" MaxLength="255" runat="server" /> </td>
    </tr>
    <tr> 
      <td width="27%" class="OptionName">Requested From Page :</td>
      <td width="73%" class="OptionFields"> 
        <asp:textbox Width="80%" ID="txtRef" MaxLength="255" runat="server" /> </td>
    </tr>
    <tr> 
      <td width="27%" class="OptionName">Assigned To Department :</td>
      <td width="73%" class="OptionFields"> 
        <asp:dropdownlist ID="ddlDept" runat="server" /></td>
    </tr>
    <tr> 
      <td width="27%" class="OptionName">With Rating :</td>
      <td width="73%" class="OptionFields"> 
        <asp:dropdownlist ID="ddlRating" runat="server" /></td>
    </tr>
    <tr> 
      <td width="27%" class="OptionName">Request ID #</td>
      <td width="73%" class="OptionFields"> 
        <asp:textbox Columns="8" ID="txtRequestid" MaxLength="255" runat="server" /> </td>
    </tr>
    <tr> 
      <td width="27%" class="OptionName"> <asp:checkbox ID="chkDatecriteria" runat="server" Text="Made between" /> </td>
      <td width="73%" class="OptionFields"> 
        <asp:dropdownlist ID="ddlMonth1" runat="server" />
        <asp:dropdownlist ID="ddlDay1" runat="server" />
        <asp:dropdownlist ID="ddlYear1" runat="server" />
        And 
        <asp:dropdownlist ID="ddlMonth2" runat="server" />
        <asp:dropdownlist ID="ddlDay2" runat="server" />
        <asp:dropdownlist ID="ddlYear2" runat="server" /> </td>
    </tr>
    <tr class="SearchCell"> 
      <td colspan="2"><b> </b> 
        <div align="right"> 
          <input name="tokill" type="hidden" id="tokill" value="" runat="server" onserverchange="dodelete">
          <input name="tosort" type="hidden" id="tosort" value="" runat="server">
          <textarea name="deletesql" rows="1" style="display:none"></textarea>
          <textarea name="searchsql" rows="1" style="display:none"></textarea>
          <asp:button ID="btnSearch" runat="server" Text="View Requests" onclick="search_Buttonclick"  />
          <font size="2"> </font></div></td>
    </tr>
  </table>
  <br>
  <table width="96%" border="0" align="center" cellpadding="3">
    <%if totalrecs>0 then%>
    <tr> 
      <td colspan="9"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr valign="bottom" class="GeneralText"> 
            <td><b>Requests Found : <%=totalrecs%><br>
              Page <%=mypage%> of <%=totalpages%></b></td>
            <td align="right"><span id="lnkAdminoptions" runat="server"><a href="javascript:printable('1');"><img src="images/btnExportExcel.gif" alt="Export To Excel" width="118" height="25" hspace="2" border="0"></a><a href="javascript:printable('');"><img src="images/btnPrintResults.gif" alt="Printable Version" width="118" height="25" hspace="2" border="0"></a><a href="javascript:deletefound();"><img src="images/btnDeleteResults.gif" alt="Delete Results" width="118" height="25" hspace="2" border="0"></a></span></td>
          </tr>
        </table></td>
    </tr>
    <tr> 
      <td width="6%" align="right" class="Headers"><b>#</b></td>
      <td align="center" class="Headers"><b>Request Topic<br>
        <a href="javascript:resort('topic asc');"><img src="images/btnOrderAsc.gif" width="12" height="9" border="0"></a> 
        <a href="javascript:resort('topic desc');"><img src="images/btnOrderDesc.gif" width="12" height="9" border="0"></a><br>
        </b></td>
      <td width="9%" align="center" class="Headers"><b>Customer<br>
        <a href="javascript:resort('name asc');"><img src="images/btnOrderAsc.gif" width="12" height="9" border="0"></a> 
        <a href="javascript:resort('name desc');"><img src="images/btnOrderDesc.gif" width="12" height="9" border="0"></a> 
        </b></td>
      <td width="9%" align="center" class="Headers"><b>Date<br>
        <a href="javascript:resort('requestdate asc');"><img src="images/btnOrderAsc.gif" width="12" height="9" border="0"></a> 
        <a href="javascript:resort('requestdate desc');"><img src="images/btnOrderDesc.gif" width="12" height="9" border="0"></a></b></td>
      <td width="9%"  align="center" class="Headers"><b>Rating<br>
        <a href="javascript:resort('rating asc');"><img src="images/btnOrderAsc.gif" width="12" height="9" border="0"></a> 
        <a href="javascript:resort('rating desc');"><img src="images/btnOrderDesc.gif" width="12" height="9" border="0"></a> 
        <br>
        </b></td>
      <td width="9%"  align="center" class="Headers"><b>Session Time<br>
        <a href="javascript:resort('totaltime asc');"><img src="images/btnOrderAsc.gif" width="12" height="9" border="0"></a> 
        <a href="javascript:resort('totaltime desc');"><img src="images/btnOrderDesc.gif" width="12" height="9" border="0"></a> 
        </b></td>
      <td width="9%"  align="center" class="Headers"><b> ID <br>
        <a href="javascript:resort('requestid asc');"><img src="images/btnOrderAsc.gif" width="12" height="9" border="0"></a> 
        <a href="javascript:resort('requestid desc');"><img src="images/btnOrderDesc.gif" width="12" height="9" border="0"></a></b></td>
      <td width="8%"  align="center" class="Headers"><b>View</b></td>
      <td width="8%"  align="center" class="Headers">&nbsp;<b>Delete</b></td>
    </tr>
    <%
	dim cc as integer=(mypagesize*mypage)-mypagesize+1
	dim thisrating as string=""
	dim y as integer=0
	for x=0 to ds.tables(1).rows.count-1
	dim rs as object=ds.tables(1).rows(x)
	thisrating=""
	if rs.item("rating")>0 then
		thisrating=rs.item("rating") & "<br>"
		for y=1 to rs.item("rating")
			thisrating=thisrating & "<img src=images/star.gif>"
		next
	else
		thisrating="Not Rated"
	end if
	%>
    <tr valign="top"> 
      <td width="6%" align="right" class="OptionFields"><%=cc+x%>.</td>
      <td align="left" class="OptionFields"><b><a href="viewrequest.aspx?requestid=<%=rs.item("requestid")%>"><%=rs.item("topic")%></a></b><br> 
        <span class="SmallNotes">- Dept : <%=depts(rs.item("deptid"))%><br>
        - Referer : <a href="<%=rs.item("ref")%>" target="_blank"><%=left(rs.item("ref"),50)%></a></span></td>
      <td width="9%" align="center" valign="middle" class="OptionFields"><%=rs.item("Name")%></td>
      <td width="9%" align="center" valign="middle" class="OptionFields"><%=rs.item("requestdate")%></td>
      <td width="9%" align="center" valign="middle" class="OptionFields"><b><%=thisrating%></b></td>
      <td width="9%" align="center" valign="middle" class="OptionFields"><%=exporttime(getsessiontime(rs.item("totaltime") & "") & "")%></td>
      <td width="9%" align="center" valign="middle" class="OptionFields"><b><%=rs.item("requestid")%></b></td>
      <td width="8%" align="center" valign="middle" class="OptionFields"><a href="viewrequest.aspx?requestid=<%=rs.item("requestid")%>"><img src="images/btnView.gif" width="27" height="27" border="0" alt="View request"></a></td>
      <td width="8%" align="center" valign="middle" class="OptionFields"><a href="javascript:deleterequest(<%=rs.item("requestid")%>)"><img src="images/btnKill<%=img%>.gif" width="27" height="27" border="0" alt="Delete Request"></a></td>
    </tr>
    <%next%>
    <tr valign="top"> 
      <td colspan="9" class="SearchCell"></td>
    </tr>
    <tr valign="top"> 
      <td colspan="9" class="GeneralText"><b>Go to Page : 
        <asp:dropdownlist ID="ddlPage" runat="server" OnSelectedIndexChanged="gopage" AutoPostBack="true"/> 
        <asp:LinkButton text="<< Prev" onclick="prev_Buttonclick" id="btnPrev" runat="server"/> 
        <asp:LinkButton text="Next >>" onclick="next_Buttonclick" id="btnNext" runat="server"/> 
        </b></td>
    </tr>
    <%else%>
    <tr align="center"> 
      <td colspan="9" valign="top" class="ErrorNotices">No requests were found 
        for the specified criteria</td>
    </tr>
    <%end if%>
  </table>
  </form>
  <%if lvl=1 then%><form name="form2" method="post" action="export.aspx" target="export"><input name="resultquery" type="hidden" value="<%=resultquery%>"></form><%end if%>
</body>
</html>

