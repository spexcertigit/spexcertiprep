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

public partial class webinars_add : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack){
		 //populate_category_list();  
	  }
	 
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin/administerwebinars/");
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
		
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
            //insert into jobs (title,location,summary,description,category,posteddate,active)
			string SQL = "INSERT INTO [cpWebinar] ([title],[url],[description],[abstract],[created_date]) VALUES ( @title, @url, @description, @abstract, @created_date)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("title", SqlDbType.NVarChar, 255).Value = WebinarTitle.Text.Trim();
				cmd.Parameters.Add("url", SqlDbType.NVarChar, 255).Value = WebinarUrl.Text.Trim();
				cmd.Parameters.Add("abstract", SqlDbType.Text).Value = txtBodyAbstract.Text.Trim();
                cmd.Parameters.Add("description", SqlDbType.Text).Value = txtBodyDescription.Text.Trim();
				cmd.Parameters.Add("@created_date", SqlDbType.DateTime).Value = DateTime.Now;
				cmd.Connection.Open();
                try{
                    cmd.ExecuteNonQuery();
					//Response.Write("<script> alert('"+newPostID+"');</script>");
					Response.Write("<script> location.replace('/admin/administerwebinars/add.aspx?success=1');</script>");
                } catch (Exception ex) {
                    Response.Write("<script> alert('OPPS! Something went wrong when saving the item." + ex.Message +"');location.replace('/admin/administerwebinars/add.aspx');</script>");
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