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

public partial class prod_image_items : System.Web.UI.Page
{	
	public string com = "";
	 
    protected void Page_Load(object sender, EventArgs e)
    {		
	  lvProductImageTable.DataSource = populate_prod_img_list();
	  lvProductImageTable.DataBind();
    }
	
	/*public DataTable populate_banner_list(){
		SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString);
        string com = "SELECT * FROM Notification_Banner ORDER BY id DESC";
        SqlDataAdapter adpt = new SqlDataAdapter(com, con);
        DataTable dt = new DataTable();
       	adpt.Fill(dt);
		dt.Columns.Add("setValue", typeof(String));
		
        foreach(DataRow row in dt.Rows)
        {
			 
            foreach(DataColumn column in dt.Columns)
            {
				if(column.ColumnName == "setFeatured"){
					if(row[column].ToString() == "1"){
						row["setValue"] = "<span style='color:#5cb85c'><i class='fa fa-fw fa-toggle-on'></i></span>";
					}else{
						row["setValue"] = "<span style='color:#d9534f'><i class='fa fa-fw fa-toggle-off'></i></span>";
					}
					
				}
                
            }
        }
		
		return dt;
	
		
	}*/
	
	/*public DataTable populate_prod_img_list(){
		SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString);
        string com = "SELECT DISTINCT main_image FROM certiProdImages";
        SqlDataAdapter adpt = new SqlDataAdapter(com, con);
        DataTable dt = new DataTable();
        adpt.Fill(dt);
		return dt;
		
	}*/
	public DataTable populate_prod_img_list(){
		SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString);
        string com = "SELECT DISTINCT main_image FROM certiProdImages";
        string prod = "";
		int i = 0;
		SqlDataAdapter adpt = new SqlDataAdapter(com, con);
        DataTable dt = new DataTable();
        adpt.Fill(dt);
		
		dt.Columns.Add("product", typeof(String));
		
        foreach(DataRow row in dt.Rows)
        {
			 
           
				//string.Format("your right part {0} Your left Part", yourValue);
				
				string com2 = string.Format("SELECT * FROM certiProdImages WHERE main_image = '{0}'", row["main_image"]);	
				SqlDataAdapter adpt2 = new SqlDataAdapter(com2, con);
				DataTable dt2 = new DataTable();
				adpt2.Fill(dt2);
				prod = "";
				foreach(DataRow row2 in dt2.Rows)
				{
						prod += row2["PartNumber"];
						i++;
						//if(i < dt2.Rows.Length){
							prod += ", ";
						//}
						
						
				}
                
            
				row["product"] = "<span>"+prod+"</span>";
			
        }
		
		
		return dt;
		
	}
	
	
	
	protected void ddlDisplay_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataPager1.PageSize = Convert.ToInt32(ddlDisplay.SelectedValue);
        lvProductImageTable.DataSource = populate_prod_img_list();
        lvProductImageTable.DataBind();
    }
	
	/*[WebMethod()]
	public static string deleteItem(string bannersid)
	{
		string SQL = "";
		string SQL2 = "";
		string imgname = "";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			
			SQL2 =  "SELECT * FROM [Notification_Banner] WHERE id = @ID2";
			using (SqlCommand cmd2 = new SqlCommand(SQL2, cn)) {
                cmd2.CommandType = CommandType.Text;
				cmd2.Parameters.Add("ID2", SqlDbType.NVarChar).Value = bannersid;
                cmd2.Connection.Open();
                SqlDataReader dr = cmd2.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
						imgname = dr["thumb"].ToString();
                        cmd2.Connection.Close();
                    }
            }
			
			
			
			
			SQL = "DELETE FROM [Notification_Banner] WHERE id = @ID";
			
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("ID", SqlDbType.NVarChar).Value = bannersid;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
			
			
			//delete image
			File.Delete(mapMethod("~/notification-banner/uploads/" + imgname));
			
				
		}
		return "true";
		
	}
	
	*/
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}