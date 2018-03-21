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

public partial class career_add : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack){
		 //populate_category_list();  
	  }
	 
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin/careers/");
    }
	
	
	/*public void populate_category_list(){
		SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString);
        string com = "SELECT * FROM cms_CareerCategory";
        SqlDataAdapter adpt = new SqlDataAdapter(com, con);
        DataTable dt = new DataTable();
        adpt.Fill(dt);
        careerCatDropDownList.DataSource = dt;
        careerCatDropDownList.DataTextField = "CategoryName";
        careerCatDropDownList.DataValueField = "CategoryID";
        careerCatDropDownList.DataBind();
	}*/
	
    protected void btnSave_Click(object sender, EventArgs e)
    {
		bool success = false;
		string newPostID = "";
		//string sum = jobSummary.Text.Trim().Substring(0,100)+"...";
		string sum = jobSummary.Text.Trim();
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
            //insert into jobs (title,location,summary,description,category,posteddate,active)
			string SQL = "INSERT INTO [jobs] ([title],[location],[description],[category],[posteddate],[active]) VALUES ( @title, @location, @description, @category, @posteddate, @active)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@title", SqlDbType.NVarChar, 255).Value = jobTitle.Text.Trim();
				cmd.Parameters.Add("@location", SqlDbType.Text).Value = jobLocation.Text.Trim();
                cmd.Parameters.Add("@description", SqlDbType.Text).Value = jobSummary.Text.Trim();
				//cmd.Parameters.Add("@summary", SqlDbType.Text).Value =  sum;
				cmd.Parameters.Add("@category", SqlDbType.Text).Value = jobCategory.SelectedItem.Value;
				cmd.Parameters.Add("@posteddate", SqlDbType.DateTime).Value = DateTime.Now;
                cmd.Parameters.Add("@active", SqlDbType.Int, 100).Value = 1;
                //cmd.Parameters.Add("@CreatedBy", SqlDbType.UniqueIdentifier).Value =  new System.Data.SqlTypes.SqlGuid("8D138FE6-AEA7-486E-B1C3-DC2B38453FE7");
				cmd.Connection.Open();
                try{
                    cmd.ExecuteNonQuery();
					//Response.Write("<script> alert('"+newPostID+"');</script>");
					Response.Write("<script> location.replace('/admin/careers/add.aspx?success=1');</script>");
                } catch (Exception ex) {
                    Response.Write("<script> alert('OPPS! Something went wrong when saving the item." + ex.Message +"');location.replace('/admin/careers/add.aspx');</script>");
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