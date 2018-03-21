<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<!--#include file="incSystem.aspx" -->
<script runat="server">
dim userid as string=""
dim deptid as string=""
dim logo as string = ""
sub page_load()
	userid=request("userid")
	if userid="0" then userid=""
	deptid=request("deptid")
	dim requestid as string=getcookie("xlaALSrequest","requestid")
	if requestid="" or not(isnumeric(requestid)) then response.redirect("UserPreChat.aspx")
end sub
</script>
<title><%=appsettings.chattitle%></title>
<script language="JavaScript" src="disablerc.js"></script>
<script language="JavaScript" type="text/JavaScript">
var chattop = false;
var chatsession = false;
var chattext= false;
var roomisclosed=false;

function getframes(){
	if (chatsession==false){
		chatsession=true;
		top.loader.location.href='UserChatLoader.aspx';
		top.text.location.href='UserChatText.aspx';
	}
}

var currentuser = 0;
function getphoto(what){
	<%if appsettings.showuserpublicinfo<>"" then%>
	if (what==0){
		document.getElementById("chatphotoframeset").cols='*,0';
		currentuser=0;
	} else {
		if (currentuser!=what){
			top.photo.location.href='UserChatPhoto.aspx?userid=' + what;
			document.getElementById("chatphotoframeset").cols='*,140';
			currentuser=what;

		}
	}
	<%end if%>
}

window.name="ALSRoom";


</script>
<frameset rows="60,*,90,0,0" frameborder="NO" border="0" framespacing="0"> 
<frame name="logo" scrolling="NO" noresize src="UserChatTop.aspx?deptid=<%=DeptID%>" >
  <frameset cols="*,0" id="chatphotoframeset" name="chatphotoframeset">
    <frame name="chat" id="chat" src="UserChatSession.aspx?userid=<%=userid%>&deptid=<%=deptid%>" scrolling="AUTO">
    <frame name="photo" id="photo" src="UserChatPhoto.aspx" scrolling="no">
  </frameset>
<frame name="text" id="text" src="blank.htm" scrolling="NO" noresize>
<frame name="loader" id="loader" src="blank.htm" scrolling="NO">
<frame name="receive" id="receive" src="UserChatReceive.aspx" scrolling="NO">
</frameset><noframes></noframes>

