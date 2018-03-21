<!--#include file="incSystem.aspx" -->
<script runat="server">
dim nick as string=""
sub page_load()
	nick=getcookie("xlaALSuser","nick")
	nick=preparemsg(nick)
end sub
</script>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=windows-1256">
<link rel="stylesheet" href="styles.css" type="text/css">
<script language="JavaScript" src="disablerc.js"></script>
<script language="JavaScript">
<!--
function clearfield(){
	document.getElementById("say").value='';
	tosay=document.getElementById("text").value;
	if (tosay!='' && top.chat){
		regexp1=/</ig;
		regexp2=/>/ig;
		regexp3=/(\S+@\S+.\.\S\S\S?)/ig;
		regexp4=/((ht|f)tps?:\/\/\S+[\/]?[^\\.])([\\.]?.*)/ig;
		
		tosay=tosay.replace(regexp1,'&lt;');
		tosay=tosay.replace(regexp2,'&gt;');
		tosay=tosay.replace(regexp3,"<A href='mailto:$1'>$1</A>");
		tosay=tosay.replace(regexp4,"<A href='$1' target='_blank'>$1</A>$3");
		
		<%if appsettings.notifytype<>"" then response.write("whataction();")%>
		tosay='<span class=UserText><b><%=nick%>&gt;</b> ' + tosay + '</span><br>';
		document.getElementById("say").value=tosay;
		top.chat.displaymessage(tosay);
		document.getElementById("text").value='';
		document.getElementById("text").focus();
		return true;
	} else {
	return false;
	}
}

var timer1=null;

var pretext='';
var preimage='';
function whataction(){
	//Check Typing
	<%if appsettings.notifytype<>"" then%>
	a=document.form1.text.value;
	b='0';  //Not typing
	if (a!=pretext){
		pretext=a;
		if (a!='') b='1';	//Is Typing
	}
	if (b!=preimage){
		var nt=String(Math.random()).substr(2,10);
		document.getElementById("actionimage").src='userActiontrigger.aspx?nt=' + nt + '&u=' + b;
		preimage=b;
	}
	timer1=setTimeout("whataction();", <%=appsettings.refreshrate*700%>);
	<%end if%>
}

var ctext='';
function detectkey(){
	var ntext=document.getElementById("text").value;
	if (ctext!=ntext){
		document.getElementById("text").focus();
		ctext=ntext;
	}
	setTimeout("detectkey();",300);
}




function checkkey(e) {
	var kcode=0;
	if (window.event) {
		var evt=window.event;
		kcode=evt.keyCode;
	} else {
		kcode=e.which;
	}
	if (kcode==13) {
		document.getElementById("btnSubmit").click();
		//document.getElementById("form1").text.value='';
		//document.getElementById("form1").text.focus();
	}

    }


function startcontent(){
	top.chattext=true;
	detectkey();
	
	// Register Handlers : Firefox and IE to detect keypressed
	document.getElementById("text").onkeyup=checkkey;

	
}
function gettextfocus(){
	document.getElementById("text").focus();
}

function showstatus(what){
	document.getElementById('repaction').innerHTML=what;
}
//-->
</script>
<body class="FrameBackground" leftmargin="0" rightmargin="0" topmargin="0" onload="startcontent();">
<form name="form1" method="post" class="Text" onSubmit="return clearfield();" action="UserChatReceive.aspx" target="receive">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
    <tr> 
      <td align="center" valign="middle" class="Text" height="2" bgcolor="#666666"></td>
    </tr>
    <tr> 
      <td align="center" valign="middle" class="Text"><table width="90%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td rowspan="2"><textarea name="text" id="text" cols="50" rows="3" class="FormField" style="width:100%"></textarea></td>
            <td width="110" align="center"> <input type="submit" name="btnSubmit" id="btnSubmit" value="Send" class="FormField" style="width:100px"></td>
          </tr>
          <tr> 
            <td width="110" align="center"> <input type="button" class="FormField" style="width:100px" onclick="javascript:top.logo.closession();" value="Exit"></td>
          </tr>
          <tr>
            <td class="Smalltext">&nbsp;<span id="repaction">&nbsp;</span></td>
            <td class="Smalltext" >&nbsp;<input type="hidden" id="say" name="say" value=""><img src="i.gif" width="0" height="0" id="actionimage" style="visibility:hidden"></td>
          </tr>
        </table> 
      </td>
    </tr>
    <tr>
      <td align="center" valign="middle" class="Text" height="14"><a href="http://www.xigla.com" target="_blank"><img src="images/ImgPoweredBy.gif" width="311" height="14" alt="Absolute Live Support By XIGLA SOFTWARE http://www.xigla.com" border="0" id="xlacp"></a></td>
    </tr>
  </table><script language="JavaScript" type="text/JavaScript">whataction()</script>
</form>
</body>

