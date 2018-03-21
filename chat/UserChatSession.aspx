<!--#include file="incSystem.aspx" -->
<script runat="server">
dim name as string=""
dim welcomemsg as string=""
dim timeout as integer=0
dim byemsg as string=""
dim email as string=""
dim userid as string=""
dim deptid as string=""

sub page_load()
	call nocache()
	userid=request("userid")
	deptid=request("deptid")
	name=getcookie("xlaALSuser","name")
	email=getcookie("xlaALSuser","email")
	welcomemsg=replace(appsettings.welcomemsg,"$$NAME$$",name)
	timeout=appsettings.maxwaittime*1000
	if appsettings.byemsg<>"" then byemsg="alert(" & chr(34) & appsettings.byemsg & chr(34) & ");"
end sub
</script>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=windows-1256">
<link rel="stylesheet" href="styles.css" type="text/css">
<script language="JavaScript" src="disablerc.js"></script>
<script language="JavaScript">
var busy='true';
var roomisclosed=0;

// Error Handling
window.onerror = donothing;

function donothing(){return true;}

function userchatexit(){
	var wparams='width=0,height=0,top=9000,left=9000';
	if (busy!='true' && <%if appsettings.allowcomments<>"" then response.write(1) else response.write(0)%>==1){
		wparams='width=340,height=520,top=100,left=100';
	}
	window.open('UserChatExit.aspx?busy=' + busy,'ALSUserChatExit','toolbar=0,location=0,status=0,menubar=0,scrollbars=1,resizable=0,' + wparams);
}

function sessionfinished(){
	top.getphoto(0);
	roomisclosed=1;
	document.getElementById("exitoptions").style.display='';
	doscroll();
	alert('The Representative has left the session');
	
}

function closesession(){
	<%=byemsg%>
	top.close();
}

function printchat(){
	top.chat.focus();
	top.chat.print();
}

function sendchat(){
	document.getElementById("progressbar").style.display='';
	a=document.getElementById("themessages").innerHTML;
	document.formmail.chattranscript.value=a;
	document.formmail.submit();
}

function sendbymail2(){
	var theemail=prompt('Send chat transcript by e-mail :\nPlease enter your e-mail address to send a copy of the chat transcript','<%=preparemsg(email)%>');
	if(theemail!=null && theemail!=''){
		document.formmail.email.value=theemail;
		sendchat();
	}
}

var targetemail='userid=<%=userid%>&deptid=<%=deptid%>';
function leavemessage(){
	top.location.href="UserForm.aspx?" + targetemail;
}

function chatsent(){
	document.getElementById("progressbar").style.display='none';
}
</script>
<body bgcolor="#FFFFFF" text="#000000" class="ChatBackground" onload="javascript:top.getframes();starttimeout(targetemail);" bottommargin="5" onunload="javascript:userchatexit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr valign="top" id="pleasewait" style=""> 
    <td align="left"><span class="Text"><%=welcomemsg%></span></td>
    <td align="right" width="77"><img src="images/imgContacting.gif" width="77" height="25"></td>
  </tr>
  <tr valign="top"> 
    <td colspan="2" align="left"><span id="themessages">&nbsp;</span></td>
  </tr>
  <tr valign="top" id="exitoptions" style="display:none"> 
    <td colspan="2" align="left"><hr>
      <ul class="Text">
        <span class="reptext"><b>The Representative has left the session<img src="i.gif" width="1" height="1" id="imgSetstatus"><br>
        What would you like to do ?</b></span><br>
        <br>
        <%if appsettings.allowemailchat<>"" then%>
        <li> 
          <form method="post" name="formmail" action="UserEmailChat.aspx" target="receive" style="margin:0;">
            <span class="usertext"><b>Send chat transcript by e-mail</b> </span><br>
            Please type your e-mail below and click the Submit button<br>
            <input name="email" type="text" class="Smalltext" id="email" value="<%=email%>">
            <input name="Button" type="button" class="Smalltext" value="Send" onclick="javascript:sendchat();">
            <input name="chattranscript" type="hidden" value="">
            <img src="images/progressbar.gif" alt="Sending" name="progressbar" align="absmiddle" id="progressbar" style="display:none;"><br>
            <br>
          </form>
        </li>
        <%end if%>
        <li><a href="javascript:printchat();" class="usertext" target="_self"><b>Print 
          Chat Transcript <img src="images/imgGo.gif" width="12" height="12" border="0"></b></a><br>
          Select This Option print a copy of the chat transcript<br>
          <br>
        </li>
        <li><a href="javascript:leavemessage();" class="usertext"><b>Leave a message 
          <img src="images/imgGo.gif" width="12" height="12" border="0"> </b></a><br>
          Click this option to leave a message and exit<br>
          <br>
        </li>
        <li><a href="javascript:closesession();" class="usertext" target="_self"><b>Close 
          Window and Exit <img src="images/imgGo.gif" width="12" height="12" border="0"></b></a><br>
          Select this option to close the window and exit</li>
      </ul>
      </td>
  </tr>
</table><script language="JavaScript">
var themsg = document.getElementById("themessages")

function displaymessage(tosay){
	themsg.innerHTML=themsg.innerHTML + tosay + '\n';
	doscroll();
	if (top.text) top.text.gettextfocus();
}

function cmdpush(thisfile,repname){
	themsg.innerHTML=themsg.innerHTML +'<span class=reptext><b>' + repname + '&gt;&nbsp; Pushing : <a href=\'' + thisfile + '\' target=_blank>' + thisfile + '<\/a><\/b><\/span><br><span class=smalltext>If the file does not open on a new window, click on the link above or disable your pop-up blocker<\/span><br>\n';
	window.open(thisfile);
}

function cmdimage(thisfile,repname){
	themsg.innerHTML=themsg.innerHTML +'<br><img src=\'' + thisfile + '\'><br>\n';
	doscroll();
}

function cmdurl(thislink,repname){
	themsg.innerHTML=themsg.innerHTML +'<span class=reptext><b>' + repname + '&gt;&nbsp;</b><a href=\'' + thislink + '\' target=_blank>' + thislink + '<\/a><\/span><br>\n';
	doscroll();
}

function cmdemail(thislink,repname){
	themsg.innerHTML=themsg.innerHTML +'<span class=reptext><b>' + repname + '&gt;&nbsp;</b><a href=\'mailto:' + thislink + '\'>' + thislink + '<\/a><\/span><br>\n';
	doscroll();
}

function doscroll(){
	window.scrollBy(0,99999999);
	<%if appsettings.keepfocus<>"" then response.write("top.focus();")%>
}

var timer1=null;
function starttimeout(what){
	targetemail=what;
	busy='true';
	<%if appsettings.maxwaittime>0 then%>
	timer1=setTimeout("top.location.href='UserForm.aspx?busy=true&" + targetemail + "';", <%=timeout%>);
	<%end if%>
	top.chat.getphoto(0);
	
}

function stoptimeout(what){
	document.getElementById("pleasewait").style.display='none';
	busy='';
	window.clearTimeout(timer1)
	top.getphoto(what);
}
</script></body>