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

public partial class blog_add : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack){
		 populate_category_list();  
	  }
	 
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin/blogs/");
    }
	
	
	public void populate_category_list(){
		SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString);
        string com = "SELECT * FROM cms_BlogCategory";
        SqlDataAdapter adpt = new SqlDataAdapter(com, con);
        DataTable dt = new DataTable();
        adpt.Fill(dt);
        blogCatDropDownList.DataSource = dt;
        blogCatDropDownList.DataTextField = "CategoryName";
        blogCatDropDownList.DataValueField = "CategoryID";
        blogCatDropDownList.DataBind();
	}
	
    protected void btnSave_Click(object sender, EventArgs e)
    {
		bool success = false;
		string newPostID = "";
		
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
            string SQL = "INSERT INTO [cms_BlogPost] ([Title],[Description],[PostContent],[AuthorID],[IsPublished],[IsDeleted],[PublishDate],[CreatedBy],[slug],[IsCommentEnabled] ) VALUES ( @Title, @Description, @PostContent, @AuthorID, @IsPublished, @IsDeleted, @PublishDate, @CreatedBy, @slug, @IsCommentEnabled)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 255).Value = blogTitle.Text.Trim();
				cmd.Parameters.Add("@Description", SqlDbType.Text).Value = blogDesc.Text.Trim();
                cmd.Parameters.Add("@PostContent", SqlDbType.Text).Value = txtBody.Text.Trim();
				cmd.Parameters.Add("@AuthorID", SqlDbType.UniqueIdentifier).Value =  new System.Data.SqlTypes.SqlGuid("655C5294-10EF-44DB-88AD-4AF55F868D76");
				cmd.Parameters.Add("@IsPublished", SqlDbType.Int).Value = status.SelectedItem.Value;
				cmd.Parameters.Add("@IsDeleted", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@PublishDate", SqlDbType.DateTime, 100).Value = pub_date.Text.Trim();
                cmd.Parameters.Add("@CreatedBy", SqlDbType.UniqueIdentifier).Value =  new System.Data.SqlTypes.SqlGuid("8D138FE6-AEA7-486E-B1C3-DC2B38453FE7");
				cmd.Parameters.Add("@slug", SqlDbType.NVarChar, 255).Value = slugLink.Text.Trim();
				cmd.Parameters.Add("@IsCommentEnabled", SqlDbType.Int).Value = 1;
				cmd.Connection.Open();
                try{
                    cmd.ExecuteNonQuery();
					//adding cms_BlogPost_Category_xref
					//get the post id and get the category id and add it in the cms_BlogPost_Category_xref
					
					//getting post id
					using (SqlConnection cn2 = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
						using (SqlCommand cmd2 = new SqlCommand("SELECT * FROM cms_BlogPost WHERE Title='"+blogTitle.Text.Trim()+"'", cn2)) {
							cmd2.CommandType = CommandType.Text;
						
							cmd2.Connection.Open();
							SqlDataReader dr = cmd2.ExecuteReader(CommandBehavior.SingleRow);
							if (dr.HasRows) {
								dr.Read();
								newPostID = dr["PostID"].ToString();
								cmd2.Connection.Close();
							}
						}
					}
					
					//add data to cms_BlogPost_Category_xref
					using (SqlConnection cn3 = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
					{
						//string SQL2 = "INSERT INTO [cms_BlogPost_Category_xref] ([PostID],[CategoryID]) VALUES ( @PostID, @CategoryID)";
						using (SqlCommand cmd3 = new SqlCommand("INSERT INTO [cms_BlogPost_Category_xref] ([PostID],[CategoryID]) VALUES ( @PostID, @CategoryID)", cn3))
						{
							
							cmd3.CommandType = CommandType.Text;
							cmd3.Parameters.Add("@PostID", SqlDbType.NVarChar, 255).Value = newPostID;
							cmd3.Parameters.Add("@CategoryID", SqlDbType.NVarChar, 255).Value = blogCatDropDownList.SelectedItem.Value;
							//cmd3.Parameters.Add("@CategoryID", SqlDbType.NVarChar, 255).Value = Request.Form["blogCatDropDownList"];
							cmd3.Connection.Open();
							try{
								cmd3.ExecuteNonQuery();
								
								//Response.Write("<script> alert('Successfully added to"+blogCatDropDownList.SelectedItem.Value+"');</script>");
							} catch (Exception ex) {
								Response.Write("<script> alert('OPPS! Something went wrong when saving the item." + ex.Message +"');location.replace('/admin/blogs/add.aspx');</script>");
							}
							
							cmd3.Connection.Close();
						}
					}
					//Response.Write("<script> alert('"+newPostID+"');</script>");
					Response.Write("<script> location.replace('/admin/blogs/add.aspx?success=1');</script>");
                } catch (Exception ex) {
                    Response.Write("<script> alert('OPPS! Something went wrong when saving the item." + ex.Message +"');location.replace('/admin/blogs/add.aspx');</script>");
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