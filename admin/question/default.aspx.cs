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

public partial class question : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack){
		
	  }
	 
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin/dashboard.aspx");
    }
	
    protected void btnAdd_Click(object sender, EventArgs e)
    {
		bool success = false;
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
            string SQL = "INSERT INTO AskAChemist (question, answer, askedby, responsedate, active) VALUES ( @question, @answer, @askedby, @responsedate, @active)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@question", SqlDbType.Text).Value = questionID.Text.Trim();
				cmd.Parameters.Add("@answer", SqlDbType.Text).Value = answer.Text.Trim();
                cmd.Parameters.Add("@askedby", SqlDbType.Text).Value = "anon";
				cmd.Parameters.Add("@responsedate", SqlDbType.DateTime).Value = DateTime.Now;
				cmd.Parameters.Add("@active", SqlDbType.Int).Value = 1;
				cmd.Connection.Open();
                try{
                    cmd.ExecuteNonQuery();
					Response.Write("<script> location.replace('/admin/question?success=1');</script>");
                } catch (Exception ex) {
                    Response.Write("<script> alert('OPPS! Something went wrong when saving the item." + ex.Message +"');location.replace('/admin/question');</script>");
                }
				
                cmd.Connection.Close();
            }
        }
    }
	
	protected void btnSave_Click(object sender, EventArgs e)
    {
		bool success = false;
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
            string SQL = "UPDATE AskAChemist SET question=@question, answer=@answer WHERE id=@ID";
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@ID", SqlDbType.Int).Value = queID.Value;
				cmd.Parameters.Add("@question", SqlDbType.Text).Value = questionID.Text.Trim();
				cmd.Parameters.Add("@answer", SqlDbType.Text).Value = answer.Text.Trim();
				cmd.Parameters.Add("@responsedate", SqlDbType.DateTime).Value = DateTime.Now;
				cmd.Connection.Open();
                try{
                    cmd.ExecuteNonQuery();
					Response.Write("<script> location.replace('/admin/question?saved=1');</script>");
                } catch (Exception ex) {
                    Response.Write("<script> alert('OPPS! Something went wrong when saving the item." + ex.Message +"');location.replace('/admin/question');</script>");
                }
				
                cmd.Connection.Close();
            }
		}
    }
	
	[WebMethod()]
	public static string deleteItem(int newsid)
	{
		string SQL = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {			
			SQL = "DELETE FROM [AskAChemist] WHERE id = " + newsid;
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
			
		}
		return "<div class='alert alert-success alert-dismissable bg-success'><button type='button' class='close' data-dismiss='alert' aria-hidden='true'>×</button>The question has been deleted!</div>";
	}
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
	
}