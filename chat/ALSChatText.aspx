<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim nick as string=""
dim userid as string=""
dim name as string=""
dim deptname as string=""
dim topic as string=""
dim requestid as string=""
dim cans(5) as string
dim rating as string=""
dim thequickwords as string=""

sub page_load()
	nick=getnick
	userid=getusrid
	if userid="" then response.redirect("Logout.aspx")

	name=request("name")
	deptname=request("deptname")
	topic=request("topic")
	requestid=request("requestid")
	
	nick=preparemsg(nick)

	'//// Load canned commands and Quick Links  ///'
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand
	mycommand.connection = conn
	dim dr as SqlDataReader
	mycommand.commandtext = "xlaALSsp_load_rep_cans"
	mycommand.CommandType = CommandType.StoredProcedure
	mycommand.Parameters.Add( "@userid" , userid)
	conn.open()
	dr = mycommand.ExecuteReader()
	dim processedcan as string=""
	dim quickword as string=""
	dim canmsg as string=""
	'/// Canned Commands  ///'
	do while dr.read()
		processedcan=replace(dr("processedcan") & "","$$NICK$$",nick,1,-1,1)
		if dr("cancmd")=0 then processedcan=server.htmlencode(processedcan)
		cans(dr("cancmd")) &= "<option value=" & chr(34) & processedcan & chr(34) & ">" & dr("canname") & "</option>"
		
		'/// Are Quick Words enabled ///'
		if appsettings.allowquickwords<>"" then
			'/// If the can has a quickword, add it ///'
			quickword=dr("quickword") & ""
			if quickword<>"" then
				canmsg=dr("canmsg")
				processedcan=replace(canmsg,vbcrlf,"\r\n")
				processedcan=replace(processedcan,"'","\'")
				quickword=replace(quickword,"'","\'")
				if dr("cancmd")=0 then 
					thequickwords &= "if (tosay=='" & quickword & "') tosay='" & processedcan & "';" & vbcrlf
				else
					thequickwords &= "if (tosay=='" & quickword & "'){setcmd(" & dr("cancmd") & ",'" & processedcan & "');return false;}" & vbcrlf
				end if
			end if
		end if
	loop
	
	
	'/// Additional Links  ///'
	dr.nextresult()
	dim addtionallinks as string="<option value=''> -- Select Link -- </option><option value=" & chr(34) & appsettings.applicationurl & "menu.aspx" & chr(34) &">- Absolute Live Support System</option>"
	do while dr.read()
		addtionallinks &= "<option value=" & chr(34) & dr("depturl") & chr(34) & ">- Dept: " & dr("deptname") & "</option>"
	loop
	cans(5)=addtionallinks & "<option value=''> ---------- </option>" & cans(5)

	dr.close()
	conn.close()
	
	'/// Rating  ///'
	if appsettings.allowrating<>"" then rating="<br><b>Session Rating : </b><span id=therating> - Not Rated - </span>"
end sub

</script>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=windows-1256">
<style type="text/css">
<!--
.tabOff {  border: #666666; border-style: solid; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; cursor=hand;; text-align: center}
.Panel {  background-color: #EAEAEA; border: #666666 solid; border-width: 0px 1px; font-family: Tahoma, Verdana, sans-serif; font-size: 12px}
.tabOn {  border-color: #666666 #666666 black; cursor=default;; text-align: center; border-style: solid; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 0px; border-left-width: 1px}
.space {  border-color: black black #666666; width: 3px; border-style: solid; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 1px; border-left-width: 0px}
.tab {  border-color: #666666 #666666 black; border-style: solid; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 0px; border-left-width: 1px; text-align: center}
.text {  font-family: Tahoma, Verdana, sans-serif; font-size: 12px}
.PanelBottom { background-color: #EAEAEA; border: #666666 solid; border-width: 0px 1px 1px}
.smalltextbox {  font-family: Arial, Helvetica, sans-serif; font-size: 9px}
-->
</style>
<script language="JavaScript">
// Error Handling
window.onerror = donothing;
function donothing(){
	return true;
}


function clearfield(){
	document.getElementById("form1").say.value='';
	tosay=document.getElementById("form1").typetext.value;
	//// Quick Words
	<%=thequickwords%>

	regexp1=/</ig;
	regexp2=/>/ig;
	regexp3=/(\S+@\S+.\.\S\S\S?)/ig;
	regexp4=/((ht|f)tps?:\/\/\S+[\/]?[^\\.])([\\.]?.*)/ig;
	regexp5=/\r\n/g;
	tosay=tosay.replace(regexp1,'&lt;');
	tosay=tosay.replace(regexp2,'&gt;');
	tosay=tosay.replace(regexp3,"<A href='mailto:$1'>$1</A>");
	tosay=tosay.replace(regexp4,"<A href='$1' target=_blank>$1</A>$3");
	tosay=tosay.replace(regexp5,"<br>");
	if (tosay!=''){
		tosay='<span class=reptext><b><%=nick%>&gt;</b> ' + tosay + '</span><br>';
		document.getElementById("form1").say.value=tosay;
		document.getElementById("form1").typetext.value='';
		parent.chat.displaymessage(tosay);
		document.getElementById("form1").typetext.focus();
	} else {
	return(0);
	}
}

function gettab(n){
	for(x=1;x<=11;x++){
		thetab=eval('document.all.tab' + x + '.style;');
		thepan=eval('document.all.pan' + x + '.style;');
		if(x==n){
		thetab.backgroundColor='#EAEAEA';
		thetab.borderBottomWidth='0px;';
		thepan.display='';
		thetab.cursor='default';
		} else {
		thetab.backgroundColor='#CCCCCC';
		thetab.borderBottomWidth='1px;';
		thepan.display='none';
		thetab.cursor='hand';
		}
	}
}

function startpage(){
	top.chattext=true;
	gettab(1);
	starttimer();
	detectkey();
	<%if appsettings.notifytype<>"" then response.write("whataction();")%>
}

function passmsg(){
	var a=document.getElementById("form3").cancmd.value;
	document.getElementById("form1").typetext.value=a;
	document.getElementById("form1").btn1.click();
}

function loadmsg(){
	var a=document.getElementById("form3").cancmd.value;
	gettab(1);
	document.getElementById("form1").typetext.focus();
	document.getElementById("form1").typetext.value=a;
}

function setcmd(cmdid,cmdvalue){
	selectThisItem(document.getElementById("form2").selectcmd,cmdid);
	document.getElementById("form2").what.value=cmdvalue;
	gettab(2);
	document.getElementById("form2").form2btn.click();
	gettab(1);
	document.getElementById("form1").say.value='';
	document.getElementById("form1").typetext.value='';
}

function focustext(){
	document.getElementById("form1").typetext.focus();
	document.getElementById("form1").typetext.focus();
	document.getElementById("form1").typetext.focus();
}

function sendcmd(){
	document.getElementById("form2").cancmd.value='';
	whichcmd=document.getElementById("form2").selectcmd.value;
	sendwhat=document.getElementById("form2").what.value;

	if (sendwhat!=''){
		/// Push
		if (whichcmd==1){
			a='cmdpush(\'' + sendwhat + '\',\'<%=nick%>\')';
		}
		
		/// Image
		if (whichcmd==2){
			a='cmdimage(\'' + sendwhat + '\',\'<%=nick%>\')';
		}
		
		/// URL
		if (whichcmd==3){
			a='cmdurl(\'' + sendwhat + '\',\'<%=nick%>\')';
		}
		
		/// e-mail
		if (whichcmd==4){
			a='cmdemail(\'' + sendwhat + '\',\'<%=nick%>\')';
		}
		document.getElementById("form2").cancmd.value=a;
		document.getElementById("form2").what.value='';
		document.getElementById("form2").what.focus();
	}
}

function selectThisItem(selObj, selVal) { for(var x=0; x<selObj.length; x++) {
if(selObj.options[x].value == selVal) { selObj.selectedIndex = x;
break; } } }

var currentrating=0;
function rating(n){
	if (currentrating!=n){
		currentrating=n;
		img='<img src=images\/star.gif>';
		var totalrating='';
		for (x=1;x<=n;x++){
			totalrating=totalrating + img;
		}
		document.all.therating.innerHTML=totalrating;
	}
}

function starttimer(){
	now=new Date();
	started=now.getTime();
	gotimer();
}

function gotimer(){
	now = new Date() ;
	// Starting at 0 to increase one second
	stime = new Date( now.getTime() - started) ;
	sminutes = stime.getMinutes() ;
	sseconds = stime.getSeconds() ;
	// tack on 0 if on digit
	if ( sminutes <= 9 ) sminutes = "0" + sminutes ;
	if ( sseconds <= 9 ) sseconds = "0" + sseconds ;
	tsessiontime= sminutes + ":" + sseconds ;
	document.all.sessiontime.innerHTML=tsessiontime;
	setTimeout( "gotimer()", 1000 ) ;
}

function openurl(what){
	var h=what.value;
	if (h!='') window.open(h);
}

var pretext='';
var preimage='';
function whataction(){
	<%if appsettings.notifytype<>"" then%>
	a=document.document.getElementById("form1").typetext.value;
	b='0';	//Not typing
	if (a!=pretext){
		pretext=a;
		if (a!='') b='1';	//Typing
	}
	if (b!=preimage){
		var nt=String(Math.random()).substr(2,10);
		document.getElementById("actionimage").src='ALSActiontrigger.aspx?requestid=<%=requestid%>&nt=' + nt + '&r=' + b;
		preimage=b;
	}
	timer1=setTimeout("whataction();", <%=appsettings.refreshrate*700%>);
	<%end if%>
}

var currentusrpage='';
function setfootstep(what){
	if (what!=currentusrpage){
		document.getElementById("footsteps").innerHTML='<li><a href=' + what + ' target=_blank>' + what + '</a></li>' + document.getElementById("footsteps").innerHTML;
		currentusrpage=what;
		}
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

function spellcheck(){
	try {
		var tmpis = new ActiveXObject("ieSpell.ieSpellExtension");
		tmpis.CheckAllLinkedDocuments(document.getElementById("text"));
		//tmpis.CheckDocumentNode(document.getElementById("text"));
	}
	catch(exception) {
		if(exception.number==-2146827859) {
			if (confirm("ieSpell not detected.  Click Ok to go to download page."))
				window.open("http://www.iespell.com/download.php","DownLoad");
		}
		else
			alert("Error Loading ieSpell: Exception " + exception.number);
	}
}

function checkkey(evt) {
	var kcode=0;
	if (document.all) {
		var evt=window.event;
		kcode=evt.keyCode;
	} else kcode=evt.which;
	if (kcode==13) {
		//document.getElementById("btn1").click();
		//document.getElementById("form1").submit();
		document.getElementById("form1").text.value='';
		document.getElementById("form1").text.focus();
	}
}	
</script>
<body topmargin="0" bgcolor="#C0C0C0" leftmargin="0" rightmargin="0" onload="javascript:startpage();">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr>
    <td height="4" bgcolor="#666666"></td>
  </tr>
  <tr>
    <td align="center" valign="middle">
      <table border="0" cellspacing="0" cellpadding="0" width="96%" align="center">
        <tr> 
          <td align="left" valign="top"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top"> 
                <td class="tab" id="tab1" onClick="javascript:gettab(1);"><img src="images/tabChat.gif" width="42" height="34" alt="Send Message To The Customer"></td>
                <td width="4" class="space">&nbsp;</td>
                <td class="tab" id="tab2" onClick="javascript:gettab(2);"><img src="images/tabCommand.gif" width="42" height="34" alt="Send Command To The Customer"></td>
                <td width="4" class="space">&nbsp;</td>
                <td class="tab" id="tab3" onClick="javascript:gettab(3);"><img src="images/tabCannedReply.gif" width="42" height="34" alt="Send An Automated Reply"></td>
                <td width="4" class="space">&nbsp;</td>
                <td class="tab" id="tab4" onClick="javascript:gettab(4);"><img src="images/tabCannedPush.gif" width="42" height="34" alt="Push an URL to the Customer"></td>
                <td width="4" class="space">&nbsp;</td>
                <td class="tab" id="tab5" onClick="javascript:gettab(5);"><img src="images/tabCannedImage.gif" width="42" height="34" alt="Show an Image To The Customer"></td>
                <td width="4" class="space">&nbsp;</td>
                <td class="tab" id="tab6" onClick="javascript:gettab(6);"><img src="images/tabCannedLink.gif" width="42" height="34" alt="Show an URL to The Customer"></td>
                <td width="4" class="space">&nbsp;</td>
                <td class="tab" id="tab7" onClick="javascript:gettab(7);"><img src="images/tabCannedEmail.gif" width="42" height="34" alt="Display An E-Mail Address to the Customer"></td>
                <td width="4" class="space">&nbsp;</td>
                <td class="tab" id="tab8" onClick="javascript:gettab(8);"><img src="images/tabBrowseTheWeb.gif" width="42" height="34" alt="Launch My Browser"></td>
                <td width="4" class="space">&nbsp;</td>
                <td class="tab" id="tab9" onClick="javascript:gettab(9);"><img src="images/tabMyLinks.gif" width="42" height="34" alt="My Reference Links"></td>
                <td width="4" class="space">&nbsp;</td>
                <td class="tab" id="tab10" onClick="javascript:gettab(10);"><img src="images/tabFootsteps.gif" width="42" height="34" alt="Pages Visited By The User"></td>
                <td width="4" class="space">&nbsp;</td>
                <td class="tab" id="tab11" onClick="javascript:gettab(11);"><img src="images/tabOtherOptions.gif" width="42" height="34" alt="Pages Visited By The User"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td align="center" valign="middle" class="Panel"> 
            <table width="100%" border="0" cellspacing="2" cellpadding="2">
              <tr id=pan1 style=""> 
                <td height="80" align="center" valign="middle"> 
                  <form name="form1" method="post" id="form1" action="ALSChatReceive.aspx?requestid=<%=requestid%>"  target="receive" onSubmit="return clearfield();" style="margin:0;"><span class="smalltextbox">Type what you want to say to the customer</span><table width="96%" border="0" cellpadding="0" cellspacing="0">
                      <tr> 
                        <td width="80" align="right"><font face="Tahoma, Verdana, sans-serif" size="2"><b>Message 
                          :</b></font></td>
                        <td align="center"> 
                          <input name="typetext" id="typetext" onkeyup="checkkey()" type="text" class="FormField" style="width:98%;height:40px" value="" size="40">
                          <textarea name="say" id="say" cols="2" rows="1" style="display:none"></textarea> 
                          <input type="hidden" id="iddletime" name="iddletime" value="0">
                        </td>
                        <td width="90"> 
						  <BUTTON NAME="btn1" id="btn1" type="submit" style="width:40px;height:40px"><IMG src="images/btnSay.gif" alt="Send &raquo;"></BUTTON>
                          <BUTTON NAME="spcheck" id="spcheck" onClick="javascript:spellcheck();" style="width:40px;height:40px"><IMG src="images/btnSpellcheck.gif" alt="Spell Check"></BUTTON>
                          </td>
                      </tr>
                    </table>
                  </form>
                </td>
              </tr>
              <tr id=pan2 style="display:none"> 
                <td height="80" align="center" valign="middle"> 
                  <form name="form2" id="form2" method="post" action="ALSChatReceive.aspx?requestid=<%=requestid%>"  target="receive" onSubmit="javascript:sendcmd();" style="margin:0;">
                    <span class="smalltextbox">Select the command and type the URL that you want to send to the customer<br></span> 
                    <select name="selectcmd" id="selectcmd" class="FormField">
                      <option value="1" selected>Push :</option>
                      <option value="2">Image :</option>
                      <option value="3">URL :</option>
                      <option value="4">EMail :</option>
                    </select>
                    <input type="text" name="what" id="what" size="30" class="FormField">
                    <input type="submit" name="form2btn" id="form2btn" value="Send" style="width:20%" class="FormField">
                    <textarea name="cancmd" id="cancmd" style="display:none";></textarea>
                   </form>
                </td>
              </tr>
              <tr id=pan3 style="display:none"> 
                <td height="80" align="center" valign="middle"> 
                  <form name="form3" method="post" id="form3" style="margin:0;">
                    <b><font face="Tahoma, Verdana, sans-serif" size="2"><span class="smalltextbox">Select 
                    an Automated Reply to say to the customer, Click LOAD to customize 
                    the reply </span><br>
                    Reply :</font></b> 
                    <select name="cancmd" id="cancmd" class="FormField" style="width:50%">
                      <%=cans(0)%> 
                    </select>
                    <input type="button" name="Submit2" id="Submit2" value="Send" onClick="javascript:passmsg();" class="FormField" style="width:12%">
                    <input type="button" name="Submit3" id="Submit3" value="Load" style="width:12%" class="FormField" onClick="javascript:loadmsg();"><br>
                  </form>
                </td>
              </tr>
              <tr id=pan4 style="display:none"> 
                <td height="80" align="center" valign="middle"> 
                  <form name="form4" id="form4" method="post" action="ALSChatReceive.aspx?requestid=<%=requestid%>"  target="receive" style="margin:0;">
                    <span class="smalltextbox">Type The URL of the page or file 
                    that you want to Push to the customer</span><br>
                    <font size="2" face="Tahoma, Verdana, sans-serif"><b>Push 
                    :</b></font> 
                    <select name="cancmd" id="cancmd" class="FormField" style="width:50%">
                      <%=cans(1)%> 
                    </select>
                    <input type="submit" id="Submit22" name="Submit22" value="Send" class="FormField" style="width:20%">
                  </form>
                </td>
              </tr>
              <tr id=pan5 style="display:none"> 
                <td height="80" align="center" valign="middle"> 
                  <form name="form5" id="form5" method="post" action="ALSChatReceive.aspx?requestid=<%=requestid%>"  target="receive" style="margin:0;">
                    <b><font face="Tahoma, Verdana, sans-serif" size="2"><span class="smalltextbox">Type 
                    The URL of the Imager file that you want to show to the customer</span><br>
                    Image : 
                    <select name="cancmd" id="cancmd" class="FormField" style="width:50%">
                      <%=cans(2)%> 
                    </select>
                    <input type="submit" id="Submit23" name="Submit23" value="Send" class="FormField" style="width:20%">
                    </font></b> 
                  </form>
                </td>
              </tr>
              <tr id=pan6 style="display:none"> 
                <td height="80" align="center" valign="middle"> 
                  <form name="form6" id="form6"  method="post" action="ALSChatReceive.aspx?requestid=<%=requestid%>"  target="receive" style="margin:0;">
                    <b><font face="Tahoma, Verdana, sans-serif" size="2"><span class="smalltextbox">Type 
                    The URL that you want to display to the customer</span><br>
                    URL : </font></b> 
                    <select name="cancmd" id="cancmd" class="FormField" style="width:50%">
                      <%=cans(3)%> 
                    </select>
                    <input type="submit" id="Submit24" name="Submit24" value="Send" class="FormField" style="width:20%">
                  </form>
                </td>
              </tr>
              <tr id=pan7 style="display:none"> 
                <td height="80" align="center" valign="middle"> 
                  <form name="form7" id="form7" method="post" action="ALSChatReceive.aspx?requestid=<%=requestid%>"  target="receive" style="margin:0;">
                    <b><font size="2" face="Tahoma, Verdana, sans-serif"><span class="smalltextbox">Type 
                    The E-Mail Address that you want to display to the customer</span><br>
                    EMail :</font></b> 
                    <select name="cancmd" id="cancmd" class="FormField" style="width:50%">
                      <%=cans(4)%> 
                    </select>
                    <input type="submit" id="Submit25" name="Submit25" value="Send" class="FormField" style="width:20%">
                  </form>
                </td>
              </tr>
              <tr id=pan8 style="display:none">
                <td height="80" align="center" valign="middle"> 
                  <form name="form8" id="form8" style="margin:0" onsubmit="return false;openurl(form8.targeturl);">
                    <span class="smalltextbox">Type the URL that you want to browse 
                    (This URL will not be sent or opened to the customer)<br>
                    </span> 
                    <input type="text" name="typedurl" id="typedurl" style="width:70%" class="smalltextbox" value="http://">
                    <input type="submit" id="Submit4" value="Browse" style="width:15%" class="smalltextbox" onClick="javascript:openurl(form8.typedurl);" name="Submit4">
                  </form>
                </td>
              </tr>
              <tr id=pan9 style="display:none">
                <td height="80" align="center" valign="middle"> <span class="smalltextbox">Select 
                  The Link That you Want To Open (This Link will not be sent or 
                  opened to the customer)<br>
                    </span> 
                    <select name="targeturl" id="targeturl" class="FormField" style="width:70%" onchange="javascript:openurl(this);this.value='';">
                      <%=cans(5)%> 
                    </select>
                 </td>
              </tr>
              <tr id=pan10 style="display:none"> 
                <td height="80" > 
                  <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                      <td><font size="2" face="Tahoma, Arial, Verdana"><b>Last 
                        Page Visited :</b></font></td>
                    </tr>
                    <tr>
                      <td><div id="footsteps" style="overflow:auto; height:48px; align:left;" class="smalltextbox">-</div></td>
                    </tr>
                  </table> </td>
              </tr>
              <tr id=pan11 style="display:none">
                <td height="80" align="center" valign="middle"> 
                  <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr align="left" valign="top"> 
                      <td width="40"><a href="reviewsession.aspx?requestid=<%=requestid%>" target="ALSoptions"><img src="images/btnReview.gif" alt="Review Chat Session" width="36" height="13" vspace="1" border="0"></a><a href="userinfo.aspx?requestid=<%=requestid%>" target="ALSoptions"><img src="images/btnUserInfo.gif" alt="Customer Info" width="36" height="13" vspace="1" border="0"></a><a href="Report-availablereps.aspx" target="ALSoptions"><img src="images/btnOnline.gif" alt="Representatives Online" width="36" height="13" vspace="1" border="0"></a><a href="LMMessenger.aspx" target="ALSoptions"><img src="images/btnMessenger.gif" alt="Messenger" width="36" height="13" border="0"></a></td>
                      <td> 
                        <iframe name="ALSoptions" height=66 width=100% src=blank.htm></iframe></td>
                    </tr>
                  </table></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td align="left" valign="top" class="PanelBottom"> 
            <table width="96%" border="0" cellspacing="0" cellpadding="1" align="center">
              <tr> 
                <td bgcolor="#999999" height="1" colspan="2"></td>
              </tr>
              <tr valign="top"> 
                <td align="left"><b><font face="Tahoma, Verdana, sans-serif" size="1">Request 
                  ID # <%=requestid%> - </font></b><font face="Tahoma, Verdana, sans-serif" size="1"><%=name%> 
                  &nbsp; &nbsp;<br>
                  <b>Department :</b> <%=deptname%> <%=rating%><br>
                  <b> </b></font></td>
                <td align="left" width="50%"><font face="Tahoma, Verdana, sans-serif" size="1"><b>Topic 
                  : </b><%=topic%><br>
                  <b>Session Time :</b><span id="sessiontime">&nbsp;</span></font></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td align="left" valign="top"><font face="Tahoma, Verdana, Arial" size="1" color="#666666"><b><span id="useraction">&nbsp;</span>&nbsp;<img src="i.gif" width="0" height="0" id="actionimage" style="visibility:hidden"></b></font></td>
        </tr>
      </table>
      </td>
  </tr>
</table>
</body>

