using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

public partial class events_edit : System.Web.UI.Page
{
    public string iID = "";
	public int pubStatus = 0;
	public string sf = "";
	
	
    protected void Page_Load(object sender, EventArgs e)
    {
		
        string SQL = "";
		
		
		
        if (Request.QueryString["id"] != null) {
			iID = Request.QueryString["id"].ToString().Trim();
			
		}else {
			Response.Redirect("/admin/events/");
		}
		//Response.Write(iID.ToString().Trim());
        if (!Page.IsPostBack){
			using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)){
				//using (SqlCommand cmd = new SqlCommand("SELECT * FROM certiCannabis a INNER JOIN cp_roi_Families b ON a.cpfamID = b.cfID WHERE a.cpfamID = @cpfamID", cn))
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM cms_Event WHERE EventSerial = @EventSerial ORDER BY CreateDate DESC", cn)){
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("EventSerial", SqlDbType.NVarChar).Value = iID;
                    cmd.Connection.Open();
					
                    SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
                        												
						title.Text = dr["Headline"].ToString();
						location.Text = dr["EventLocation"].ToString();
						txtBody.Text = dr["FullDescription"].ToString();
						startDate.Text = Convert.ToDateTime(dr["EventDate"]).ToString("yyyy-MM-dd");
						endDate.Text = Convert.ToDateTime(dr["EventEndDate"]).ToString("yyyy-MM-dd");
                        imgAtt.Text = dr["ImageUrl"].ToString();
						sf = dr["IsActive"].ToString();
						if ( sf == "1"){
							active.Checked = true;
						} 
						
						
                        cmd.Connection.Close();
                    }
                }
            }
			
			
        }
    }
	
	

	
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin/events/");
    }
    
	protected void btnSave_Click(object sender, EventArgs e)
    {
		string SQL = "";
		string fileName2 = imgAtt.Text;
		string end_Date = "";
        int chcked = 0;
		
		//check if oneday event
		if (noenddate.Checked){
			end_Date = startDate.Text.Trim();
		}else{
			end_Date = endDate.Text.Trim();
		}
		//active or not
		if (active.Checked){
			chcked = 1;
		}
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
			
            
			if (FileUpload2.HasFile)
			{
				if(File.Exists(mapMethod("~/images/events/" + fileName2))) {
					File.Delete(mapMethod("~/images/events/" + fileName2));
				}
				fileName2 = Path.GetFileName(FileUpload2.PostedFile.FileName);
				fileName2 = fileName2;
				FileUpload2.PostedFile.SaveAs(Server.MapPath("~/images/events/") + fileName2);
			}
			
			SQL = "UPDATE [cms_Event] " +
                            "SET [Headline] = @Headline, " +
							"   [FullDescription] = @FullDescription, " +
                            "   [EventDate] = @EventDate, " +
							"	[EventEndDate] = @EventEndDate, " +
							"   [EventLocation] = @EventLocation, " +
							"   [IsActive ] = @IsActive, " +
							"   [ImageUrl] = @ImageUrl " +
                            " WHERE [EventSerial] = @eventsID";
			
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@eventsID", SqlDbType.Int).Value = iID;
				cmd.Parameters.Add("@Headline", SqlDbType.Text).Value = title.Text.Trim();
				cmd.Parameters.Add("@FullDescription", SqlDbType.Text).Value = txtBody.Text.Trim();
				cmd.Parameters.Add("@EventLocation", SqlDbType.Text).Value = location.Text.Trim();
				cmd.Parameters.Add("@EventDate", SqlDbType.DateTime, 100).Value = startDate.Text.Trim();
				cmd.Parameters.Add("@EventEndDate", SqlDbType.DateTime, 100).Value = end_Date;
				cmd.Parameters.Add("@IsActive", SqlDbType.Int).Value = chcked;
				cmd.Parameters.Add("@ImageUrl", SqlDbType.Text).Value = fileName2;
				
						
				
				
                cmd.Connection.Open();
                try {
                    cmd.ExecuteNonQuery();
					
                } catch (Exception ex) {
					Response.Write("<script> alert('OPPS! Something went wrong when saving the item." + ex.Message +"');</script>");
					Response.Write("<script>location.replace('/admin/events/edit.aspx?id=" + iID + "');</script>");
				}
                cmd.Connection.Close();
            }
			
			
		}
		Response.Write("<script>location.replace('/admin/events/edit.aspx?id=" + iID + "&success=1');</script>");		
		
	}
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}