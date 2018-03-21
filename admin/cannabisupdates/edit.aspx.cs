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

public partial class cannabisupdates_edit : System.Web.UI.Page
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
			Response.Redirect("/admin/cannabisupdates/");
		}
		//Response.Write(iID.ToString().Trim());
        if (!Page.IsPostBack){
			using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)){
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM certiCannabisUpdates WHERE id = @ID", cn)){
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("ID", SqlDbType.NVarChar).Value = iID;
                    cmd.Connection.Open();
					
                    SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
                        
						title.Text = dr["title"].ToString();
						media.Text = dr["media"].ToString();
                        link_url.Text = dr["link_url"].ToString();
						
						//populate dropdown  with datatable
						DataTable dt = new DataTable();
						dt.Clear();
						dt.Columns.Add("setText", typeof(String));
						dt.Columns.Add("setValue", typeof(String));
						dt.Rows.Add(new object[] { "Activated", '1' });
						dt.Rows.Add(new object[] { "DeActivated", '0' });
						
						statusDrop.DataSource = dt;
						statusDrop.DataTextField = "setText";
						statusDrop.DataValueField = "setValue";
						statusDrop.DataBind();
						
						if(dr["active"].ToString() == "1"){
							statusDrop.SelectedValue = "1";						
						}else{
							statusDrop.SelectedValue = "0";							
						}
						
						
                        cmd.Connection.Close();
                    }
                }
            }
			
			
        }
    }
		
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin/cannabisupdates/");
    }
    
	protected void btnSave_Click(object sender, EventArgs e)
    {
		string SQL = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
			SQL = "UPDATE [certiCannabisUpdates]" +
			"SET [title] = @title, " +
			"   [media] = @media, " +
			"   [link_url] = @link_url, " +
			"	[active] = @active " +
			" WHERE [id] = @cannabisupdatesID";
			
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@cannabisupdatesID", SqlDbType.Int).Value = iID;
				cmd.Parameters.Add("@title", SqlDbType.NVarChar, 255).Value = title.Text.Trim();
				cmd.Parameters.Add("@media", SqlDbType.Text).Value = media.Text.Trim();
				cmd.Parameters.Add("@link_url", SqlDbType.Text).Value = link_url.Text.Trim();
				cmd.Parameters.Add("@active", SqlDbType.NVarChar, 255).Value =  statusDrop.SelectedItem.Value;
				
                cmd.Connection.Open();
                try {
                    cmd.ExecuteNonQuery();
					
                } catch (Exception ex) {
					Response.Write("<script> alert('OPPS! Something went wrong when saving the item." + ex.Message +"');</script>");
					Response.Write("<script>location.replace('/admin/cannabisupdates/edit.aspx?id=" + iID + "');</script>");
				}
                cmd.Connection.Close();
            }			
		}
		Response.Write("<script>location.replace('/admin/cannabisupdates/edit.aspx?id=" + iID + "&success=1');</script>");		
		
	}
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}