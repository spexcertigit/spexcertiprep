<!--#include file="incSystem.aspx"-->
<script runat="server">
dim name as string = ""
dim email as string = ""
dim optfield1 as string = ""
dim optfield2 as string = ""
dim optfield3 as string = ""
dim nick as string = ""
dim customerid as string = ""
dim d as string=""
dim u as string =""
dim ref as string=""
dim reqd as string=""
dim note as string=""
dim userid as string=""
dim topic as string=""
dim deptid as string=""
dim ip as string=""
dim isproactive as string=""
dim hostname as string=""
dim logo as string = ""

sub page_load()

	if not(ispostback) then
	
		ref=request("ref") & ""
		d = request("d") & ""
		u = request("u") & ""													
																																																																																																								if request("xi") & ""<>"" then response.write("X I G L A   &nbsp;  S O F T W A R E ") : response.end()
		isproactive=request("isproactive")
		viewstate("ref")=ref
		viewstate("userid")=u
		if u<>"" then userid=u
		if d<>"" then deptid=d
		
		'/// Avoid any further engagement ///'
		setCookie("xlaALSengaged",1)
		
		'/// Any People on-line? ///'
		if not(isonline(deptid,userid)) then response.redirect("UserForm.aspx?busy=true&deptid=" & deptid & "&userid=" & userid)
		
																																																																																										
		name=getcookie("xlaALSuser","name") & ""
		email=getcookie("xlaALSuser","email") & ""
		optfield1=getcookie("xlaALSuser","optfield1") & ""
		optfield2=getcookie("xlaALSuser","optfield2") & ""
		optfield3=getcookie("xlaALSuser","optfield3") & ""
		nick=getcookie("xlaALSuser","nick") & ""
		
		ip=request.servervariables("REMOTE_ADDR")
		
		'/// Check if IP is blocked ///'
		if appsettings.blockips<>"" then 
			if isipblocked(ip) then 
				response.write("<!-- Absolute Live Support .NET : IP " & ip & " is blocked -->")
				response.end()
				exit sub
			end if
		end if
		
		'//// proactive Chat Request ///'
		if request("isproactive")<>"" and u<>"" then
			topic="Proactive Chat"
			call initiatechat()
		end if
		
		'/// Bypass form ? ///'
		if request("bypass")<>"" and (d<>"" or u<>"") then call initiatechat()

		'/// Fill Default values ///'
		txtName.text=name
		txtEmail.text=email
		txtOptfield1.text=optfield1
		txtOptfield2.text=optfield2
		txtOptfield3.text=optfield3
		txtNick.text=nick

		'/// Fill Departments ///'
		dim conn as New SqlConnection(connectionstr)
		dim mycommand as New SqlCommand
		mycommand.connection = conn
		dim dr as SqlDataReader
		mycommand.commandtext = "xlaALSsp_userchat_list_depts"
		mycommand.CommandType = CommandType.StoredProcedure
		conn.open()
		dr = mycommand.ExecuteReader()
		dim deptname as string=""
		do while dr.read
			deptname=dr("deptname")
			if dr("status")=1 then deptname=deptname & " (On-Line)" else deptname=deptname & "(Off-line)"
			filllistbox(ddlDeptid, deptname , dr("deptid") , d)
		loop
		dr.close()
		conn.close()
		
		'/// Hide Departments if preselected ///'
		if (d<>"" or u<>"") then deptsrow.visible=false
		
		'/// Enable Required fields ///'
		if appsettings.fieldsrequired<>"" then
			reqName.enabled=true
			reqEmail.enabled=true
			note="<br>* Denotes required field"
			reqd="*"
		end if
		
		'/// Hide Email if not required ///'
		if appsettings.askemail="" then 
			emailrow.visible=false
			if appsettings.fieldsrequired<>"" then reqemail.enabled=false
		end if
		
		'/// Hide Required Fields ///'
		if appsettings.optfield1="" then optfield1row.visible=false
		if appsettings.optfield2="" then optfield2row.visible=false
		if appsettings.optfield3="" then optfield3row.visible=false
		
		if appsettings.optfield1req<>"" then reqOptfield1.enabled=true
		if appsettings.optfield2req<>"" then reqOptfield2.enabled=true
		if appsettings.optfield3req<>"" then reqOptfield3.enabled=true
		
	end if
	if deptID = "1" then
		logo = "certiprep_logo.png"
	elseif deptID = "2" then
		logo = "sampleprep_logo.png"
	end if
	errorrow.visible=false
	
end sub

function isreq(what as string) as string
	isreq=""
	if what<>"" then isreq="*"

end function

sub button_click(s as object, e as ImageClickEventArgs)
	if page.isvalid() then
		ip=request.ServerVariables("REMOTE_ADDR")
		name=txtName.text
		email=txtEmail.text
		optfield1=txtoptfield1.text
		optfield2=txtoptfield2.text
		optfield3=txtoptfield3.text
		nick=txtNick.text
		topic=txtTopic.text
		deptid=listboxresults(ddlDeptid,"0")
		userid=viewstate("userid") & ""
		if userid="" then userid="0"
		ref=viewstate("ref") & ""

		if nick="" then nick=appsettings.defaultnick
		if name="" then name="Not Provided"
		call initiatechat()
	else
		errorrow.visible=true
	end if
end sub


sub initiatechat()
	customerid=getcookie("xlaALSuser","customerid")
	if customerid="" or not(isnumeric(customerid)) then customerid="0"
	if nick="" then nick=appsettings.defaultnick
		
	'/// Host Name ///'
	hostname=gethostname(ip)
	
	'/// Country and CO ///'
	dim co as string=""
	dim country as string=""
	if appsettings.countrylookup<>"" then
		dim iploc as new xigla_getcountry(ip)
		co=iploc.co
		country=iploc.country
	end if
	
	'/// Hotlead and referral ///'
	dim hotleadref as string=getcookie("xlaALSuser","hotleadref") & ""
	dim siteref as string=getcookie("xlaALSuser","siteref") & ""
	dim visits as string=getcookie("xlaALSuser","visits") & ""
	if visits="" or not(isnumeric(visits)) then visits="0"
	
	'/// Browser and OS ///'
	dim browser as string=Request.Browser.type
	dim os as string=Request.Browser.Platform	

	'/// Save Request  ///'
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand("xlaALSsp_submit_request",conn)
	mycommand.commandType =  CommandType.Storedprocedure
	mycommand.Parameters.Add( "@customerid" , customerid )
	mycommand.Parameters.Add( "@name" , name)
	mycommand.Parameters.Add( "@email" , email)
	mycommand.Parameters.Add( "@logindate" , todaydatetime)
	mycommand.Parameters.Add( "@optfield1" , optfield1)
	mycommand.Parameters.Add( "@optfield2" , optfield2)
	mycommand.Parameters.Add( "@optfield3" , optfield3)
	mycommand.Parameters.Add( "@deptid" , deptid)
	mycommand.Parameters.Add( "@userid" ,userid)
	mycommand.Parameters.Add( "@topic" , topic)
	mycommand.Parameters.Add( "@ip" , ip)
	mycommand.Parameters.Add( "@hostname" , hostname)
	mycommand.Parameters.Add( "@os" , os)
	mycommand.Parameters.Add( "@browser" , browser)
	mycommand.Parameters.Add( "@ref" , ref)
	mycommand.Parameters.Add( "@co" , co)
	mycommand.Parameters.Add( "@country" , country)
	mycommand.Parameters.Add( "@visits" , visits)
	mycommand.Parameters.Add( "@hotleadref" , hotleadref)
	mycommand.Parameters.Add( "@siteref" , siteref)
	conn.open()
	dim dr as SqlDataReader = mycommand.ExecuteReader()
	dr.read()
	customerid=dr("customerid")
	dim requestid as integer = dr("requestid")
	dim totalrequests as integer=dr("totalrequests")
	dr.close()
	conn.close()
		
	'/// Set Cookies ///'
	setcookie("xlaALSuser","name",name)
	setcookie("xlaALSuser","email",email)
	setcookie("xlaALSuser","nick",nick)
	setcookie("xlaALSuser","customerid",customerid)
	setcookie("xlaALSuser","totalrequests",totalrequests)
	setcookie("xlaALSuser","co",co)
	setcookie("xlaALSuser","country",country)
	setcookie("xlaALSuser","optfield1",optfield1)
	setcookie("xlaALSuser","optfield2",optfield2)
	setcookie("xlaALSuser","optfield3",optfield3)
	persistcookie("xlaALSuser")
	setcookie("xlaALSrequest","lastlogin",getdate(dateadd("n",1,todaydatetime)))
	setcookie("xlaALSrequest","requestid",requestid)
	setcookie("xlaALSrequest","topic",topic)
	setcookie("xlaALSrequest","deptid",deptid)
	
	'/// Check if selected dept or user is on-line, if not then go to form ///'
	if not(isonline(deptid,userid)) then response.redirect("UserForm.aspx?busy=true&deptid=" & deptid & "&userid=" & userid)

	'/// Update User Action ///'
	call updatevisitoraction(ip,1,"Waiting for representative")
	
	'/// Assign Representative ///'
	call assignrep(requestid,userid)
	
	response.redirect("UserChat.aspx?userid=" & userid & "&deptid=" & deptid)
end sub
</script>
<html>
<head>
<title><%=appsettings.chattitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="styles.css" type="text/css">
</head>
<body leftmargin="0" rightmargin="0" topmargin="10" class="FrameBackground">
<form method="post" name="form1" class="FrameBackground" id="form1" runat="server">
  <table width="96%" border="0" align="center" cellpadding="0" cellspacing="1">
    <tr> 
      <td><img src="files/<%=logo%>" hspace="12"></td>
    </tr>
    <tr>
      <td height="10"></td>
    </tr>
    <tr align="left" valign="top"> 
      <td><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr> 
            <td width="6" height="6"><img src="images/c1.gif" width="6" height="6"></td>
            <td height="6" background="images/c2.gif"><img src="images/c2.gif" width="3" height="6"></td>
            <td width="6" height="6"><img src="images/c3.gif" width="6" height="6"></td>
          </tr>
          <tr> 
            <td background="images/c5.gif"><img src="images/c5.gif" width="6" height="2"></td>
            <td align="left" valign="top" class="ChatBackground"> <table width="98%" border="0" cellspacing="2" cellpadding="2" runat="server">
                <tr> 
                  <td colspan="2"><span class="Titles">Welcome to our live support 
                    help desk</span><br> <span class="Text">In order to serve 
                    you better please provide the following information<b><%=note%></b></span></td>
                </tr>
                <tr id="errorrow"> 
                  <td colspan="2"><span class="ErrorText">Please provide your 
                    name and e-mail address</span></td>
                </tr>
                <tr> 
                  <td colspan="2"><asp:validationsummary ID="validSummary" ShowMessageBox="true" runat="server" HeaderText="Plese fill all the required fields" CssClass="ErrorText" ShowSummary="false" /></td>
                </tr>
                <tr> 
                  <td width="25%"><span class="Text">Your Name :</span></td>
                  <td> <asp:textbox runat="server" id="txtName" CssClass="FormField" MaxLength="255" Columns="40" width="80%" /> 
                    <asp:requiredfieldvalidator ControlToValidate="txtName" id="reqName" runat="server" Enabled="false"  /> 
                    <%=reqd%></td>
                </tr>
                <tr id="emailrow"> 
                  <td width="25%" ><span class="Text">Your E-Mail :</span></td>
                  <td> <asp:textbox runat="server" id="txtEmail" CssClass="FormField" MaxLength="255" Columns="40" width="80%" /> 
                    <asp:requiredfieldvalidator ControlToValidate="txtEmail" id="reqEmail" runat="server" Enabled="false"  /> 
                    <%=reqd%></td>
                </tr>
                <tr id="optfield1row"> 
                  <td width="25%" ><span class="Text"><%=appsettings.optfield1%> 
                    :</span></td>
                  <td> <asp:textbox runat="server" id="txtOptfield1" CssClass="FormField" MaxLength="255" Columns="40" width="80%" /> 
                    <asp:requiredfieldvalidator ControlToValidate="txtOptfield1" id="reqOptfield1" runat="server" Enabled="false"  /> 
                    <%=isreq(appsettings.optfield1req)%> </td>
                </tr>
                <tr id="optfield2row"> 
                  <td width="25%" ><span class="Text"><%=appsettings.optfield2%> 
                    :</span></td>
                  <td> <asp:textbox runat="server" id="txtOptfield2" CssClass="FormField" MaxLength="255" Columns="40" width="80%" /> 
                    <asp:requiredfieldvalidator ControlToValidate="txtOptfield2" id="reqOptfield2" runat="server" Enabled="false"  /> 
                    <%=isreq(appsettings.optfield2req)%> </td>
                </tr>
                <tr id="optfield3row"> 
                  <td width="25%" ><span class="Text"><%=appsettings.optfield3%> 
                    :</span></td>
                  <td> <asp:textbox runat="server" id="txtOptfield3" CssClass="FormField" MaxLength="255" Columns="40" width="80%" /> 
                    <asp:requiredfieldvalidator ControlToValidate="txtOptfield3" id="reqOptfield3" runat="server" Enabled="false"  /> 
                    <%=isreq(appsettings.optfield3req)%> </td>
                </tr>
                <tr id="deptsrow"> 
                  <td width="25%"><span class="Text">Chat With :</span></td>
                  <td> <asp:dropdownlist ID="ddlDeptid" runat="server" Width="80%" /> 
                  </td>
                </tr>
                <tr> 
                  <td width="25%"><span class="Text">Screen Name :</span></td>
                  <td> <asp:textbox runat="server" id="txtNick" CssClass="FormField" MaxLength="255" Columns="40" width="80%" /> 
                  </td>
                </tr>
                <tr> 
                  <td width="25%"><span class="Text">Session Topic : </span></td>
                  <td> <asp:textbox runat="server" id="txtTopic" CssClass="FormField" MaxLength="255" Columns="40" width="80%" /> 
                  </td>
                </tr>
                <tr> 
                  <td width="25%" align="right">&nbsp; </td>
                  <td> <asp:imagebutton id="btnButton" ImageUrl="images/btnChatnow.gif" OnClick="button_click" runat="server" AlternateText="Click Here To Chat" /> 
                  </td>
                </tr>
              </table></td>
            <td background="images/c6.gif"><img src="images/c6.gif" width="6" height="2"></td>
          </tr>
          <tr> 
            <td width="6" height="6"><img src="images/c7.gif" width="6" height="6"></td>
            <td height="6" background="images/c8.gif"><img src="images/c8.gif" width="3" height="6"></td>
            <td width="6" height="6"><img src="images/c9.gif" width="6" height="6"></td>
          </tr>
        </table></td>
    </tr>
  </table>
  </form>
</body>
</html>
