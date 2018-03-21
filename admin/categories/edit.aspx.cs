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

public partial class news_edit : System.Web.UI.Page
{
    public string iID = "";
	public int currRegion = 1;
	public string lang = "";
	public string langOption = "";
	
    protected void Page_Load(object sender, EventArgs e)
    {
		
        string SQL = "";
		
        if (Request.QueryString["itech"] != null) {
			iID = Request.QueryString["itech"];
		}else if (Request.QueryString["otech"] != null) {
			iID = Request.QueryString["otech"];
		}else {
			Response.Redirect("/admin/categories/");
		}
		
        if (!Page.IsPostBack) {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
				
				if (Request.QueryString["itech"] != null) {
					SQL = "SELECT * FROM cp_roi_Families WHERE cfID = @ID AND cfTypeID = 2";
					using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
						cmd.CommandType = CommandType.Text;
						cmd.Parameters.Add("ID", SqlDbType.Int).Value = iID;
						cmd.Connection.Open();
						SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
						if (dr.HasRows) {
							dr.Read();
							txtTitle.Text = dr["title"].ToString();
							txtBody.Text = dr["description"].ToString();
							txtSlug.Text = dr["slug"].ToString();
							cmd.Connection.Close();
						}
					}
				}else if (Request.QueryString["otech"] != null) {
					SQL = "SELECT * FROM cp_roi_AnTechs WHERE CatID = @ID";
					using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
						cmd.CommandType = CommandType.Text;
						cmd.Parameters.Add("ID", SqlDbType.Int).Value = iID;
						cmd.Connection.Open();
						SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
						if (dr.HasRows) {
							dr.Read();
							txtTitle.Text = dr["CatLong"].ToString();
							txtBody.Text = dr["description"].ToString();
							txtSlug.Text = dr["slug"].ToString();
							cmd.Connection.Close();
						}
					}
				}
				
                
            }
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin/categories/");
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
		string fileName = "";
		string prefix = DateTime.Now.ToString("MMdd-HHmmss-");
		string SQL = "";
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
			if (Request.QueryString["itech"] != null) {
				SQL = "UPDATE [cp_roi_Families] SET [slug] = @slug, [title] = @title, [description] = @description WHERE cfID = @cfID";
				using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
					cmd.CommandType = CommandType.Text;
					cmd.Parameters.Add("@cfID", SqlDbType.Int).Value = iID;
					cmd.Parameters.Add("@slug", SqlDbType.NVarChar, 256).Value = txtSlug.Text;
					cmd.Parameters.Add("@title", SqlDbType.NVarChar, 100).Value = txtTitle.Text;
					cmd.Parameters.Add("@description", SqlDbType.Text).Value = txtBody.Text;
					cmd.Connection.Open();
					try {
						cmd.ExecuteNonQuery();
					} catch (Exception ex) {
						Response.Write(ex);
					}
					cmd.Connection.Close();
					Response.Write("<script>location.replace('/admin/categories/edit.aspx?itech=" + iID + "&success=1');</script>");
				}
			}else if (Request.QueryString["otech"] != null) {
				SQL = "UPDATE [cp_roi_AnTechs] SET [CatLong] = @title, [slug] = @slug, [description] = @description WHERE CatID = @CatID";
				using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
					cmd.CommandType = CommandType.Text;
					cmd.Parameters.Add("@CatID", SqlDbType.Int).Value = iID;
					cmd.Parameters.Add("@title", SqlDbType.NVarChar, 100).Value = txtTitle.Text;
					cmd.Parameters.Add("@slug", SqlDbType.NVarChar, 256).Value = txtSlug.Text;
					cmd.Parameters.Add("@description", SqlDbType.Text).Value = txtBody.Text;
					cmd.Connection.Open();
					try {
						cmd.ExecuteNonQuery();
					} catch (Exception ex) {
						Response.Write(ex);
					}
					cmd.Connection.Close();
					Response.Write("<script>location.replace('/admin/categories/edit.aspx?otech=" + iID + "&success=1');</script>");
				}

			}
			
        }
       
    }
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}