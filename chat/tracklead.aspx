<!--#include file="incSystem.aspx" -->
<script runat="server">
'/// Hot Lead Xigla Software Tracking ///'

sub page_load()
	dim siteref as string=request("lead") & ""
	dim ip as string=request.servervariables("REMOTE_ADDR")
	dim visits as string=getcookie("xlaALSuser","visits") & ""
	if not(isnumeric(visits)) then visits=1 else visits=val(visits) + 1
	dim co as string=""
	dim country as string=""
	
	'/// Perform Country Look up ///'
	if appsettings.countrylookup<>"" then
		dim iploc as new xigla_getcountry(ip)
		co=iploc.co
		country=iploc.country
	end if
		
	if siteref<>"" then
		dim keywords() as string=split(appsettings.hotleads,chr(10))
		
		dim hotleadref as string=getcookie("xlaALSuser","hotleadref")
		dim x as integer=0
		for x=0 to ubound(keywords)
			if instr(1,siteref,keywords(x),1)<>0 and keywords(x)<>"" then
				hotleadref=left(siteref,399)			
				setcookie("xlaALSuser","hotleadref", hotleadref)
				exit for
			end if
		next
		
		siteref=left(siteref,399)
		
		'/// Update Hotlead in database ///'
		dim conn as New SqlConnection(connectionstr)
		dim mycommand as New SqlCommand
		mycommand.connection = conn
		mycommand.commandtext = "xlaALSsp_set_hotlead"
		mycommand.CommandType = CommandType.StoredProcedure
		mycommand.Parameters.Add( "@ip" , ip)
		mycommand.Parameters.Add( "@hotleadref" , hotleadref)
		mycommand.Parameters.Add( "@siteref" , siteref)
		mycommand.Parameters.Add( "@co" , co)
		mycommand.Parameters.Add( "@country" , country)
		mycommand.Parameters.Add( "@visits" , visits)
		conn.open()
		mycommand.ExecuteScalar()
		conn.close()
		
		'/// Set site referral ///'
		setcookie("xlaALSuser","siteref",siteref)

		setcookie("xlaALSuser","co",co)
		setcookie("xlaALSuser","country",country)

		'/// Update Visits ///'
		setcookie("xlaALSuser","visits",visits)
		persistcookie("xlaALSuser")
		
	end if
	
	response.redirect("i.gif")
end sub
</script>

