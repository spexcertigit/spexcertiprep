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

public partial class careers_edit : System.Web.UI.Page
{
    public string iID = "";
	public int pubStatus = 0;
	
	
    protected void Page_Load(object sender, EventArgs e)
    {
		
        string SQL = "";
		
		
        if (Request.QueryString["id"] != null) {
			iID = Request.QueryString["id"].ToString().Trim();
			//iID = "9f55a20c-2875-4111-be81-57b78d927617";
		}else {
			Response.Redirect("/admin/careers/");
		}
		//Response.Write(iID.ToString().Trim());
        if (!Page.IsPostBack){
			using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)){
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM jobs WHERE id = @ID", cn)){
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("ID", SqlDbType.NVarChar).Value = iID;
                    cmd.Connection.Open();
					
                    SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
                        jobTitle.Text = dr["title"].ToString();
						jobLocation.Text = dr["location"].ToString();
                        jobSummary.Text = dr["description"].ToString();
						jobCategory.SelectedValue = dr["category"].ToString();
						
                        cmd.Connection.Close();
                    }
                }
				
				
				
            }
			
			
        }
    }
	

	
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin/careers/");
    }
    
	protected void btnSave_Click(object sender, EventArgs e)
    {
		//Response.Write(iID);
		//iID = Request.QueryString["id"].ToString().Trim();
		string SQL = "";
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
			
            SQL = "UPDATE jobs " +
                            "SET [title] = @title, " +
							"   [description] = @description, " +
                            "   [location] = @location, " +
							"   [category] = @category, " + 
							"	[summary] = @summary " +
                            " WHERE [id] = @careersID";
			
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
				
				cmd.Parameters.Add("@careersID", SqlDbType.NVarChar).Value = iID;
				cmd.Parameters.Add("@title", SqlDbType.NVarChar, 255).Value = jobTitle.Text.Trim();
				cmd.Parameters.Add("@location", SqlDbType.Text).Value = jobLocation.Text.Trim();
                cmd.Parameters.Add("@description", SqlDbType.Text).Value = jobSummary.Text.Trim();
				cmd.Parameters.Add("@summary", SqlDbType.Text).Value = jobSummary.Text.Trim();
				cmd.Parameters.Add("@category", SqlDbType.Int).Value = jobCategory.SelectedItem.Value;
               
				
                cmd.Connection.Open();
                try {
                    cmd.ExecuteNonQuery();
					
                } catch (Exception ex) {
					Response.Write("<script> alert('OPPS! Something went wrong when saving the item." + ex.Message +"');</script>");
					Response.Write("<script>location.replace('/admin/careers/edit.aspx?id=" + iID + "');</script>");
				}
                cmd.Connection.Close();
            }	
			
			
		
		
		}
		Response.Write("<script>location.replace('/admin/careers/edit.aspx?id=" + iID + "&success=1');</script>");		
		
	}
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}