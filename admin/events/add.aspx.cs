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
using System.Collections.Generic;

public partial class events_page: System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack){
			//populate_category_list();  
		}
    }
	
	protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin/events/");
    }
	
	
    protected void btnSave_Click(object sender, EventArgs e)
    {
		
		string fileName2 = "";
		string SQL = "";
		string site = "cp";
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
				
		if (FileUpload2.HasFile)
		{
			fileName2 = Path.GetFileName(FileUpload2.PostedFile.FileName);
			fileName2 = fileName2;
			FileUpload2.PostedFile.SaveAs(Server.MapPath("~/images/events/") + fileName2);
		}
		
		
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
			
			//working with certiCannabis table
			SQL = "INSERT INTO cms_Event (Site, Headline, FullDescription, EventDate, EventEndDate, EventLocation, EventCategory, IsActive, ImageUrl) VALUES (@Site, @Headline, @FullDescription, @EventDate, @EventEndDate, @EventLocation, @EventCategory, @IsActive, @ImageUrl)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@Site", SqlDbType.Text).Value = site;
				cmd.Parameters.Add("@Headline", SqlDbType.Text).Value = title.Text.Trim();
				cmd.Parameters.Add("@FullDescription", SqlDbType.Text).Value = txtBody.Text.Trim();
				cmd.Parameters.Add("@EventLocation", SqlDbType.Text).Value = location.Text.Trim();
				cmd.Parameters.Add("@EventDate", SqlDbType.DateTime, 100).Value = startDate.Text.Trim();
				cmd.Parameters.Add("@EventEndDate", SqlDbType.DateTime, 100).Value = end_Date;
				cmd.Parameters.Add("@IsActive", SqlDbType.Int).Value = chcked;
				cmd.Parameters.Add("@ImageUrl", SqlDbType.Text).Value = fileName2;
				cmd.Parameters.Add("@EventCategory", SqlDbType.Int).Value = 1;
				

				
                cmd.Connection.Open();
                try{
                    cmd.ExecuteNonQuery();
					Response.Write("<script>location.replace('/admin/events/add.aspx?success=1');</script>");
                } catch (Exception ex) {
                    Response.Write("<script>alert('OPPS! Something went wrong when saving the item." + ex.Message +"');location.replace('/admin/events/add.aspx');</script>");
                }
                cmd.Connection.Close();
            }
			
        }
       
    }
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}