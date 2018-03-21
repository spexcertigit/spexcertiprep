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

public partial class blogs_edit : System.Web.UI.Page
{
    public string iID = "";
	public int pubStatus = 0;
	
	
    protected void Page_Load(object sender, EventArgs e)
    {
		
        string SQL = "";
		
		
        if (Request.QueryString["id"] != null) {
			iID = Request.QueryString["id"].ToString().Trim();
		}else {
			Response.Redirect("/admin/blogs/");
		}
		//Response.Write(iID.ToString().Trim());
        if (!Page.IsPostBack){
			using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)){
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM cms_BlogPost WHERE PostID = @ID", cn)){
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("ID", SqlDbType.NVarChar).Value = iID;

                    cmd.Connection.Open();
                    SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
                        blogTitle.Text = dr["title"].ToString();
						blogDesc.Text = dr["Description"].ToString();
                        slugLink.Text = dr["slug"].ToString();
						txtBody.Text = dr["PostContent"].ToString();
						pub_date.Text = Convert.ToDateTime(dr["PublishDate"]).ToString("yyyy-MM-dd");
						pubStatus =  Convert.ToInt32(dr["IsPublished"]);
                        cmd.Connection.Close();
                    }
                }
				
				//get the product category
				populate_category_list();
				
				using (SqlCommand cmd2 = new SqlCommand("SELECT B.CategoryName, B.CategoryID FROM cms_BlogPost_Category_xref A INNER JOIN cms_BlogCategory B ON A.CategoryID = B.CategoryID WHERE A.PostID = @ID", cn)){
                    cmd2.CommandType = CommandType.Text;
					cmd2.Parameters.Add("ID", SqlDbType.NVarChar).Value = iID;

                    cmd2.Connection.Open();
                    SqlDataReader dr2 = cmd2.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr2.HasRows) {
                        dr2.Read();
						blogCatDropDownList.SelectedValue = dr2["CategoryID"].ToString();
						cmd2.Connection.Close();
                    }
                }
				
            }
			
			
        }
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
	
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin/blogs/");
    }
    
	protected void btnSave_Click(object sender, EventArgs e)
    {
		string cat = "";
		string SQL = "";
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
			
            SQL = "UPDATE cms_BlogPost " +
                            "SET [title] = @Title, " +
							"   [Description] = @Description, " +
                            "   [slug] = @slug, " +
							"   [PostContent] = @PostContent, " + 
							"	[PublishDate] = @PublishDate, " +
							"   [IsPublished] = @IsPublished " +
                            " WHERE [PostID] = @blogsID";
			
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
				
				cmd.Parameters.Add("@blogsID", SqlDbType.NVarChar).Value = iID;
				cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 255).Value = blogTitle.Text.Trim();
				cmd.Parameters.Add("@Description", SqlDbType.Text).Value = blogDesc.Text.Trim();
                cmd.Parameters.Add("@PostContent", SqlDbType.Text).Value = txtBody.Text.Trim();
				cmd.Parameters.Add("@IsPublished", SqlDbType.Int).Value = status.SelectedItem.Value;
                cmd.Parameters.Add("@PublishDate", SqlDbType.DateTime, 100).Value = pub_date.Text.Trim();
				cmd.Parameters.Add("@slug", SqlDbType.NVarChar, 255).Value = slugLink.Text.Trim();
				
                cmd.Connection.Open();
                try {
                    cmd.ExecuteNonQuery();
					
                } catch (Exception ex) {
					Response.Write("<script> alert('OPPS! Something went wrong when saving the item." + ex.Message +"');</script>");
					Response.Write("<script>location.replace('/admin/blogs/edit.aspx?id=" + iID + "');</script>");
				}
                cmd.Connection.Close();
            }	
			
			//update the product category
			SQL = "UPDATE cms_BlogPost_Category_xref " +
                            "SET [CategoryID] = @CategoryID" +
                            " WHERE [PostID] = @blogsID";
			
            using (SqlCommand cmd2 = new SqlCommand(SQL, cn))
            {
                cmd2.CommandType = CommandType.Text;
				cmd2.Parameters.Add("@blogsID", SqlDbType.NVarChar).Value = iID;
				cmd2.Parameters.Add("@CategoryID", SqlDbType.NVarChar, 255).Value = blogCatDropDownList.SelectedItem.Value;
                cmd2.Connection.Open();
                try {
                    cmd2.ExecuteNonQuery();
					
                } catch (Exception ex) {
					Response.Write("<script> alert('OPPS! Something went wrong when saving the item." + ex.Message +"');</script>");
					Response.Write("<script>location.replace('/admin/blogs/edit.aspx?id=" + iID + "');</script>");
				}
                cmd2.Connection.Close();
            }	
		
		
		}
		Response.Write("<script>location.replace('/admin/blogs/edit.aspx?id=" + iID + "&success=1');</script>");		
    }
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}