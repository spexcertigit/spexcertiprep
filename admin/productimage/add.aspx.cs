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

public partial class banners_add : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack){
			//populate_category_list();  
		}
    }
	
	
	
	
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin/banners/");
    }
	
	
    protected void btnSave_Click(object sender, EventArgs e)
    {
		
		string fileName2 = "";
		int setfeat = 0;
		
		
		
		string prefix = DateTime.Now.ToString("MMdd-HHmmss-");
		bool success = false;
		
		
		if (FileUpload2.HasFile)
		{
			fileName2 = Path.GetFileName(FileUpload2.PostedFile.FileName);
			fileName2 = prefix + fileName2;
			FileUpload2.PostedFile.SaveAs(Server.MapPath("~/notification-banner/uploads/") + fileName2);
		}
		
		if (setFeatured.Checked){
			setfeat = 1;
		}else{
			setfeat = 0;
		}
		
		
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
            string SQL = "INSERT INTO [Notification_Banner] (title, body, posteddate, active, thumb, setFeatured) VALUES (@title, @body, @posteddate, @active, @thumb, @setFeatured)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@title", SqlDbType.NVarChar, 255).Value = title.Text.Trim();
				cmd.Parameters.Add("@body", SqlDbType.Text).Value = txtBody.Text.Trim();
				cmd.Parameters.Add("@thumb", SqlDbType.Text).Value = fileName2;
				cmd.Parameters.Add("@active", SqlDbType.Int).Value = 1;
				cmd.Parameters.Add("@posteddate", SqlDbType.DateTime, 100).Value = DateTime.Now;
				cmd.Parameters.Add("@setFeatured", SqlDbType.Int).Value = setfeat;
				
				 
				
                cmd.Connection.Open();
                try{
                    cmd.ExecuteNonQuery();
					Response.Write("<script>location.replace('/admin/banners/add.aspx?success=1');</script>");
                } catch (Exception ex) {
                    Response.Write("<script>alert('OPPS! Something went wrong when saving the item." + ex.Message +"');location.replace('/admin/banners/add.aspx');</script>");
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