<!--#include file="incSystem.aspx" -->
<script runat="server">
dim currentrating as string=""
dim requestid as string
dim rating as string=""
dim byemsg as string=""
dim logo as string =""
dim deptid as string =""

sub page_load()
	deptid = request("deptid")
	if deptid = "1" then
		logo = "certiprep_logo.png"
	elseif deptid = "2" then
		logo = "sampleprep_logo.png"
	end if
	rating=request("rating")
	requestid=getcookie("xlaALSrequest","requestid")
	if rating<>"" and isnumeric(rating) then call ratesession()
	if currentrating="" then currentrating="-- Rate Support --"
	if appsettings.byemsg<>"" then byemsg="alert(" & chr(34) & appsettings.byemsg & chr(34) & ");"
	if appsettings.allowemailchat<>"" then lnkSendbymail.visible=true else lnkSendbymail.visible=false
	
end sub

sub ratesession()
	'/// Rate session ///'
	if rating>"0" and rating<"6" then
		dim conn as New SqlConnection(connectionstr)
		dim mycommand as New SqlCommand("xlaALSsp_rate_session",conn)
		mycommand.commandType =  CommandType.Storedprocedure
		mycommand.Parameters.Add( "@requestid" , requestid )
		mycommand.Parameters.Add( "@rating" , rating)
		conn.open()
		mycommand.executenonquery()
		conn.close()
		currentrating="Session Rating : " & rating
	end if
end sub
</script>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="styles.css" type="text/css">
<script language="JavaScript">
<!--
// Error Handling
window.onerror = donothing;
function donothing(){return true;}

function rate(){if (document.form1.rating.value!='') document.form1.submit();}

function closession(){
	if (confirm('Close This Window and Leave the session?')){
		<%=byemsg%>
		top.close();
		}
}

function sendbymail(){
	top.chat.sendbymail2();
}

function leavemsg(){
	if (confirm('Would you like to leave a message and close the session?')){
	<%if appsettings.contactform="" then response.write("top.chat.leavemessage();") else response.write("window.open('" & appsettings.contactform & "');top.close();")%>
	}
}

function printchat(){
	top.chat.focus();
	top.chat.print();
}
//-->
</script>
<body leftmargin="0" rightmargin="0" topmargin="0" bottommargin="0" class="FrameBackground" onLoad="javascript:top.chattop=true;">
<form name="form1" id="form1" method="post" style="margin:0">
  <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
    <tr> 
      <td> 
        <table width="96%" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr> 
            <td class="Titles"><img src="files/<%=logo%>" hspace="12">&nbsp; </td>
            <td align="right" class="Titles"> 
              <%if appsettings.allowrating<>"" then%>
              <select name="rating" onChange="javascript:rate();">
                <option value=""><%=currentrating%></option>
                <option value="5">5 - Excellent</option>
                <option value="4">4 - Good</option>
                <option value="3">3 - Fair</option>
                <option value="2">2 - Poor</option>
                <option value="1">1 - Really Bad</option>
              </select>
              <%end if%>
             <a href="javascript:sendbymail();" id="lnkSendbymail" runat="server"><img src="images/btnEmail.gif" alt="Send Chat Transcript By E-mail" hspace="1" vspace="4" border="0" align="absmiddle"></a><a href="javascript:parent.chat.focus();window.print()"></a><a href="javascript:printchat();"><img src="images/btnPrint.gif" alt="Print Session Transcript" hspace="1" vspace="4" border="0" align="absmiddle"></a><a href="javascript:closession();"><img src="images/btnExit.gif" alt="Close Chat and Exit" hspace="1" vspace="4" border="0" align="absmiddle"></a></td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td align="center" valign="middle" class="Text" height="2" bgcolor="#666666"></td>
    </tr>
  </table>
</form>
</body>