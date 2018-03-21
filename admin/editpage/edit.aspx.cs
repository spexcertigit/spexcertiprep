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
			
		}else {
			Response.Redirect("/admin/editpage/");
		}
		//Response.Write(iID.ToString().Trim());
        if (!Page.IsPostBack){
			using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)){
                //SELECT p.PageTitle, m.Contents FROM cms_Page p INNER JOIN cms_Module m on p.PageID = m.PageID WHERE m.PageID = @PageID AND ModuleName = @BodyContent
				using (SqlCommand cmd = new SqlCommand("SELECT p.PageTitle, m.Contents FROM cms_Page p INNER JOIN cms_Module m on p.PageID = m.PageID WHERE m.PageID = @PageID AND ModuleName = @BodyContent", cn)){
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("PageID", SqlDbType.NVarChar).Value = iID;
					cmd.Parameters.Add("BodyContent", SqlDbType.NVarChar).Value = "BodyContent";
                    cmd.Connection.Open();
					
                    SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
                        PageTitle.Text = dr["PageTitle"].ToString();
						txtBody.Text = dr["Contents"].ToString();
						/*jobLocation.Text = dr["location"].ToString();
                        jobSummary.Text = dr["description"].ToString();
						jobCategory.SelectedValue = dr["category"].ToString();*/
						
                        cmd.Connection.Close();
                    }
                }
				
				
				
            }
			
			
        }
    }
	

	
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin/editpage/");
    }
    
	protected void btnSave_Click(object sender, EventArgs e)
    {
		
		
		
		string SQL = "";
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
			//saving into the cms_Page table
            SQL = "UPDATE cms_Page SET [PageTitle] = @PageTitle WHERE [PageID] = @PageID";
			
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
				
				cmd.Parameters.Add("PageTitle", SqlDbType.NVarChar, 255).Value = PageTitle.Text.Trim();
				cmd.Parameters.Add("PageID", SqlDbType.NVarChar).Value = iID;
               
				
                cmd.Connection.Open();
                try {
                    cmd.ExecuteNonQuery();
					
                } catch (Exception ex) {
					Response.Write("<script> alert('OPPS! Something went wrong when saving the item." + ex.Message +"');</script>");
					Response.Write("<script>location.replace('/admin/editpage/edit.aspx?id=" + iID + "');</script>");
				}
                cmd.Connection.Close();
				
            }	
			
			//saving into the cms_Module
			SQL = "UPDATE cms_Module SET [Contents] = @Contents WHERE [PageID] = @PageID AND ModuleName = @BodyContent";
			
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
				
				cmd.Parameters.Add("Contents", SqlDbType.Text).Value = txtBody.Text.Trim();
				cmd.Parameters.Add("BodyContent", SqlDbType.NVarChar).Value = "BodyContent";
				cmd.Parameters.Add("PageID", SqlDbType.NVarChar).Value = iID;
               
				
                cmd.Connection.Open();
                try {
                    cmd.ExecuteNonQuery();
					
                } catch (Exception ex) {
					Response.Write("<script> alert('OPPS! Something went wrong when saving the item." + ex.Message +"');</script>");
					Response.Write("<script>location.replace('/admin/editpage/edit.aspx?id=" + iID + "');</script>");
				}
                cmd.Connection.Close();
				
            }	
			
			
			
			
		}
		
		Response.Write("<script>location.replace('/admin/editpage/edit.aspx?id=" + iID + "&success=1');</script>");		
		
	}
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}