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

public partial class cannabisupdates_add : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack){
			//populate_category_list();  
		}
    }
	
	
	
	
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin/cannabisupdates/");
    }
	
	
    protected void btnSave_Click(object sender, EventArgs e)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
            string SQL = "INSERT INTO [certiCannabisUpdates] (title, media, link_url, active) VALUES (@title, @media, @link_url, @active)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@title", SqlDbType.NVarChar, 255).Value = title.Text.Trim();
				cmd.Parameters.Add("@media", SqlDbType.Text).Value = media.Text.Trim();
				cmd.Parameters.Add("@link_url", SqlDbType.Text).Value = link_url.Text.Trim();
				cmd.Parameters.Add("@active", SqlDbType.Int).Value = 1;
			
				
                cmd.Connection.Open();
                try{
                    cmd.ExecuteNonQuery();
					Response.Write("<script>location.replace('/admin/cannabisupdates/add.aspx?success=1');</script>");
                } catch (Exception ex) {
                    Response.Write("<script>alert('OPPS! Something went wrong when saving the item." + ex.Message +"');location.replace('/admin/cannabisupdates/add.aspx');</script>");
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