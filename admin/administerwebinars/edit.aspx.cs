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

public partial class webinars_edit : System.Web.UI.Page
{
    public string iID = "";
	public int pubStatus = 0;
	public string video = "";
	
    protected void Page_Load(object sender, EventArgs e)
    {
		
        string SQL = "";
		
		
        if (Request.QueryString["id"] != null) {
			iID = Request.QueryString["id"].ToString().Trim();
			
		}else {
			Response.Redirect("/admin/administerwebinars/");
		}
		
        if (!Page.IsPostBack){
			using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)){
				using (SqlCommand cmd = new SqlCommand("SELECT * FROM cpWebinar WHERE id = @id", cn)){
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("id", SqlDbType.NVarChar).Value = iID;
                    cmd.Connection.Open();
					
                    SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
                        WebinarTitle.Text = dr["title"].ToString();
						WebinarUrl.Text = dr["url"].ToString();
						txtBodyDescription.Text = dr["description"].ToString();
						txtBodyAbstract.Text = dr["abstract"].ToString();
						
						//video.src = dr["url"].ToString();
						video = dr["url"].ToString();
						video = video.Replace("http:", "");
						video = video.Replace("watch?v=", "embed/");
						
                        cmd.Connection.Close();
                    }
                }
				
				
				
            }
			
			
        }
    }
	

	
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin/administerwebinars/");
    }
    
	protected void btnSave_Click(object sender, EventArgs e)
    {
		
		
		
		string SQL = "";
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
			//saving into the cpWebinar table
            SQL = "UPDATE cpWebinar SET [title] = @title, [url] = @url, [description] = @description, [abstract] = @abstract WHERE [id] = @id";
			
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
				
				cmd.Parameters.Add("id", SqlDbType.NVarChar).Value = iID;
				cmd.Parameters.Add("title", SqlDbType.NVarChar, 255).Value = WebinarTitle.Text.Trim();
				cmd.Parameters.Add("url", SqlDbType.NVarChar, 255).Value = WebinarUrl.Text.Trim();
                cmd.Parameters.Add("description", SqlDbType.Text).Value = txtBodyDescription.Text.Trim();
				cmd.Parameters.Add("abstract", SqlDbType.Text).Value = txtBodyAbstract.Text.Trim();
				
                cmd.Connection.Open();
                try {
                    cmd.ExecuteNonQuery();
					
                } catch (Exception ex) {
					Response.Write("<script> alert('OPPS! Something went wrong when saving the item." + ex.Message +"');</script>");
					Response.Write("<script>location.replace('/admin/administerwebinars/edit.aspx?id=" + iID + "');</script>");
				}
                cmd.Connection.Close();
				
            }	
			
		}
		
		Response.Write("<script>location.replace('/admin/administerwebinars/edit.aspx?id=" + iID + "&success=1');</script>");		
		
	}
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}