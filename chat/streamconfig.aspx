<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim lvl as integer
sub page_load
	lvl=uservalidate(1)
	dim configcode as string
	configcode=request("configcode2")
	Response.Clear()
	Response.ContentType="application/octetstream"
	Response.AddHeader("Pragma", "no-cache")
	Response.AddHeader("Content-Disposition", "attachment; filename=xigla.config")
	Response.write(configcode)
	Response.end()
end sub
</script>

