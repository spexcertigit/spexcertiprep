using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Services;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Data;
using System.Text;
using System.Net.Mail;
using System.Text.RegularExpressions;

public partial class cannabis_page: System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack){
			//populate_category_list();  
		}
    }
	
	protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin/cannabis/");
    }
	
	
    protected void btnSave_Click(object sender, EventArgs e)
    {
		
		int cpfamID = 0;
		string SQL2 = "";
		string SQL = "";
		string SQL3 = "";
		
		//bool success = false;
		
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
            
			
			//working with cp_roi_Families table
			SQL2 = "SELECT TOP 1 cfID FROM cp_roi_Families ORDER BY cfID DESC";
			using (SqlCommand cmd2 = new SqlCommand(SQL2, cn)) {
				cmd2.CommandType = CommandType.Text;
			
				cmd2.Connection.Open();
				SqlDataReader dr = cmd2.ExecuteReader(CommandBehavior.SingleRow);
				if (dr.HasRows) {
					dr.Read();
					cpfamID = Convert.ToInt32(dr["cfID"]) + 1;
					cmd2.Connection.Close();
				}
			}
			//SQL3 = "INSERT INTO cp_roi_Families (T537_Exists, cfID, cfTypeID, cfFamily, cfOrd) VALUES ('1', '" & newID & "', '7', '" & cannTitle & "', '" & newID & "')"
			SQL3 = "INSERT INTO cp_roi_Families (T537_Exists, cfID, cfTypeID, cfFamily, cfOrd, slug) VALUES (@T537_Exists, @cfID, @cfTypeID, @cfFamily, @cfOrd, @slug)";
			using (SqlCommand cmd3 = new SqlCommand(SQL3, cn))
            {
                cmd3.CommandType = CommandType.Text;
				cmd3.Parameters.Add("@T537_Exists",  SqlDbType.Text).Value = '1';
				cmd3.Parameters.Add("@cfID", SqlDbType.Int).Value = cpfamID;
				cmd3.Parameters.Add("@cfTypeID", SqlDbType.Int).Value = 70;
				cmd3.Parameters.Add("@cfFamily", SqlDbType.Text).Value = title.Text.Trim();
				cmd3.Parameters.Add("@cfOrd", SqlDbType.Int).Value = cpfamID;
				cmd3.Parameters.Add("@slug", SqlDbType.NVarChar).Value = slug.Text.Trim();
				 
                cmd3.Connection.Open();
                try{
                    cmd3.ExecuteNonQuery();
					Response.Write("<script>location.replace('/admin/cannabis/add.aspx?success=1');</script>");
                } catch (Exception ex) {
                    Response.Write("<script>alert('OPPS! Something went wrong when saving the item." + ex.Message +"');location.replace('/admin/cannabis/add.aspx');</script>");
                }
                cmd3.Connection.Close();
            }
			
			//working with certiCannabis table
			SQL = "INSERT INTO [certiCannabis] (cpfamID, description) VALUES (@cpfamID, @description)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@cpfamID", SqlDbType.Int).Value = cpfamID;
				cmd.Parameters.Add("@description", SqlDbType.Text).Value = txtBody.Text.Trim();
				 
                cmd.Connection.Open();
                try{
                    cmd.ExecuteNonQuery();
					Response.Write("<script>location.replace('/admin/cannabis/add.aspx?success=1');</script>");
                } catch (Exception ex) {
                    Response.Write("<script>alert('OPPS! Something went wrong when saving the item." + ex.Message +"');location.replace('/admin/cannabis/add.aspx');</script>");
                }
                cmd.Connection.Close();
            }
			
        }
       
    }
	
	[WebMethod()]
	public static string CheckSlug(string slugval)
	{

		string SQL2 = "";
		string output = "";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			
			SQL2 =  "SELECT COUNT(*) AS cnt FROM cp_roi_Families WHERE slug = @slug";
			using (SqlCommand cmd2 = new SqlCommand(SQL2, cn)) {
                cmd2.CommandType = CommandType.Text;
				cmd2.Parameters.Add("@slug", SqlDbType.NVarChar).Value = slugval;
                cmd2.Connection.Open();
                SqlDataReader dr = cmd2.ExecuteReader(CommandBehavior.SingleRow);
                if (dr.HasRows) {
					dr.Read();
					if (dr["cnt"].ToString() != "0") {
						output = slugval + "-" + dr["cnt"].ToString();
					}else {
						output = slugval;
					}
				}
				cmd2.Connection.Close();
            }
		}	
		return output;
	}
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}