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

public partial class cannabis_edit : System.Web.UI.Page
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
			Response.Redirect("/admin/cannabis/");
		}
		//Response.Write(iID.ToString().Trim());
        if (!Page.IsPostBack){
			using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)){
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM certiCannabis a INNER JOIN cp_roi_Families b ON a.cpfamID = b.cfID WHERE a.cpfamID = @cpfamID", cn)){
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("cpfamID", SqlDbType.NVarChar).Value = iID;
                    cmd.Connection.Open();
					
                    SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
                        
						title.Text = dr["cfFamily"].ToString();
						txtBody.Text = dr["description"].ToString();
						FlyerLink.Text = dr["flyer_link"].ToString();
						FlyerTitle.Text = dr["flyer_title"].ToString();
						slug.Text = dr["slug"].ToString();
                        cmd.Connection.Close();
                    }
                }
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
	
	[WebMethod()]
	public static string getProducts(string state)
	{

		string SQL2 = "";
		string output = "";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			
			SQL2 =  "SELECT * FROM certiPesticidesResidueStateProd WHERE stateID = @stateID ORDER BY id DESC";
			using (SqlCommand cmd2 = new SqlCommand(SQL2, cn)) {
                cmd2.CommandType = CommandType.Text;
				cmd2.Parameters.Add("@stateID", SqlDbType.NVarChar).Value = state;
                cmd2.Connection.Open();
                SqlDataReader dr = cmd2.ExecuteReader();
				output += "<table class='table table-bordered table-hover table-striped'>";
                while(dr.Read()) {
					output += "<tr><td style='width:25%'>" + dr["partNum"].ToString() + "</td><td>" + getProdName(dr["partNum"].ToString()) + "</td></td>";
				}
				output += "</table>";
				cmd2.Connection.Close();
            }
		}	
		return output;
	}
	
	[WebMethod()]
	public static void addProduct(string state, string partNum)
	{
		string SQL2 = "";
		string output = "";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			SQL2 =  "INSERT INTO certiPesticidesResidueStateProd (partNum, stateID) VALUES (@partNum, @stateID)";
			using (SqlCommand cmd2 = new SqlCommand(SQL2, cn)) {
                cmd2.CommandType = CommandType.Text;
				cmd2.Parameters.Add("@partNum", SqlDbType.NVarChar).Value = partNum;
				cmd2.Parameters.Add("@stateID", SqlDbType.NVarChar).Value = state;
                cmd2.Connection.Open();
				cmd2.ExecuteNonQuery();
				cmd2.Connection.Close();
            }
		}	
	}
	
	public static string getProdName(string id) {
		string output = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			string SQL2 =  "SELECT cpLongDescrip FROM cp_roi_Prods WHERE cpPart = @ID";
			using (SqlCommand cmd2 = new SqlCommand(SQL2, cn)) {
                cmd2.CommandType = CommandType.Text;
				cmd2.Parameters.Add("@ID", SqlDbType.NVarChar).Value = id;
                cmd2.Connection.Open();
                SqlDataReader dr = cmd2.ExecuteReader(CommandBehavior.SingleRow);
                if (dr.HasRows) {
					dr.Read();
					output = dr["cpLongDescrip"].ToString().Trim();
				}else {
					output = "Undefined Product";
				}
				cmd2.Connection.Close();
            }
		}
		return output;
	}
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin/cannabis/");
    }
    
	protected void btnSave_Click(object sender, EventArgs e)
    {
		string SQL = "";
		string SQL2 = "";

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
			
            			
			SQL = "UPDATE [certiCannabis] " +
                            "SET [description] = @description, " +
                            "   [flyer_link] = @flyer_link, " +
							"	[flyer_title] = @flyer_title " +
                            " WHERE [cpfamID] = @cannabisID";
			
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@cannabisID", SqlDbType.Int).Value = iID;
				cmd.Parameters.Add("@description", SqlDbType.Text).Value = txtBody.Text.Trim();
				cmd.Parameters.Add("@flyer_link", SqlDbType.Text).Value = FlyerLink.Text.Trim();
				cmd.Parameters.Add("@flyer_title", SqlDbType.Text).Value = FlyerTitle.Text.Trim();
				
				
                cmd.Connection.Open();
                try {
                    cmd.ExecuteNonQuery();
					
                } catch (Exception ex) {
					Response.Write("<script> alert('OPPS! Something went wrong when saving the item." + ex.Message +"');</script>");
					Response.Write("<script>location.replace('/admin/cannabis/edit.aspx?id=" + iID + "');</script>");
				}
                cmd.Connection.Close();
            }
			
			string slugValue = "";
			if (iID == "1") {
				slugValue = "aa-icp-standards";
			}else {
				slugValue = slug.Text.Trim();
			}
			
			
			
			SQL2 = "UPDATE [cp_roi_Families]" +
                            "SET [cfFamily] = @cfFamily, [slug] = @slug" +
                            " WHERE [cfID] = @cfID";	
			using (SqlCommand cmd2 = new SqlCommand(SQL2, cn))
            {
                cmd2.CommandType = CommandType.Text;
				cmd2.Parameters.Add("@cfID", SqlDbType.Int).Value = iID;
				cmd2.Parameters.Add("@cfFamily", SqlDbType.Text).Value = title.Text.Trim();
				cmd2.Parameters.Add("@slug", SqlDbType.Text).Value = slugValue;
				cmd2.Connection.Open();
                try {
                    cmd2.ExecuteNonQuery();
					
                } catch (Exception ex) {
					Response.Write("<script> alert('OPPS! Something went wrong when saving the item." + ex.Message +"');</script>");
					Response.Write("<script>location.replace('/admin/cannabis/edit.aspx?id=" + iID + "');</script>");
				}
                cmd2.Connection.Close();
            }
				
		}
		Response.Write("<script>location.replace('/admin/cannabis/edit.aspx?id=" + iID + "&success=1');</script>");		
		
	}
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}