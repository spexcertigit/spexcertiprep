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

public partial class banners_edit : System.Web.UI.Page
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
			Response.Redirect("/admin/banners/");
		}
		//Response.Write(iID.ToString().Trim());
        if (!Page.IsPostBack){
			using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)){
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM Notification_Banner WHERE id = @ID", cn)){
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("ID", SqlDbType.NVarChar).Value = iID;
                    cmd.Connection.Open();
					
                    SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
                        
						LitName.Text = dr["title"].ToString();
						txtBody.Text = dr["body"].ToString();
                        imgAtt.Text = dr["thumb"].ToString();
						sf = dr["setFeatured"].ToString();
						//imgAtt.Text = dr["setFeatured"].ToString();
						if ( sf == "1"){
							setFeatured.Checked = true;
						} 
						
						
                        cmd.Connection.Close();
                    }
                }
				
				
			
				
            }
			
			
        }
    }
	
	

	
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin/banners/");
    }
    
	protected void btnSave_Click(object sender, EventArgs e)
    {
		string SQL = "";
		int setfeat = 0;
		string fileName2 = imgAtt.Text;
		string prefix = DateTime.Now.ToString("MMdd-HHmmss-");
		
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
			if (FileUpload2.HasFile)
			{
				if(File.Exists(mapMethod("~/notification-banner/uploads/" + fileName2))) {
					File.Delete(mapMethod("~/notification-banner/uploads/" + fileName2));
				}
				fileName2 = Path.GetFileName(FileUpload2.PostedFile.FileName);
				fileName2 = prefix + fileName2;
				FileUpload2.PostedFile.SaveAs(Server.MapPath("~/notification-banner/uploads/") + fileName2);
				//Response.Redirect(Request.Url.AbsoluteUri);
			}
			
			if (setFeatured.Checked){
				setfeat = 1;
				SQL = "UPDATE Notification_Banner SET [setFeatured] = 0";
				using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
					cmd.CommandType = CommandType.Text;
					cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
					cmd.Connection.Close();
				}
			}else{
				setfeat = 0;
			}
			
			SQL = "UPDATE Notification_Banner " +
                            "SET [title] = @title, " +
							"   [body] = @body, " +
                            "   [thumb] = @thumb, " +
							"	[setFeatured] = @setFeatured " +
                            " WHERE [id] = @bannersID";
			
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@bannersID", SqlDbType.Int).Value = iID;
				cmd.Parameters.Add("@title", SqlDbType.NVarChar, 255).Value = LitName.Text.Trim();
				cmd.Parameters.Add("@body", SqlDbType.Text).Value = txtBody.Text.Trim();
				cmd.Parameters.Add("@thumb", SqlDbType.Text).Value = fileName2;
				cmd.Parameters.Add("@setFeatured", SqlDbType.Int).Value = setfeat;
				
                cmd.Connection.Open();
                try {
                    cmd.ExecuteNonQuery();
					
                } catch (Exception ex) {
					Response.Write("<script> alert('OPPS! Something went wrong when saving the item." + ex.Message +"');</script>");
					Response.Write("<script>location.replace('/admin/banners/edit.aspx?id=" + iID + "');</script>");
				}
                cmd.Connection.Close();
            }	
			
			
		
		
		}
		Response.Write("<script>location.replace('/admin/banners/edit.aspx?id=" + iID + "&success=1');</script>");		
		
	}
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}