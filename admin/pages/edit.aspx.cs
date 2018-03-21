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
using System.Data;
using System.Text;
using System.Net.Mail;
using System.IO;
using System.Text.RegularExpressions;

public partial class pages_edit : System.Web.UI.Page
{
    public string iID = "", sTitle = "";
	public string location = "";
	public string layout = "";
	public string status = "";
	public string show_title = "";
	public string slug = "";
	public string bannerBgColor = "", banner = "";
	
    protected void Page_Load(object sender, EventArgs e)
    {
        string SQL = "";
		
        if (Request.QueryString["id"] != null) {
			iID = Request.QueryString["id"];
		}else {
			Response.Redirect("/admin/pages/");
		}
		
        if (!Page.IsPostBack) {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
				SQL = "SELECT name, slug, location, layout, banner, excerpt, meta_title, meta_keys, meta_description, page_order, created_date, active, content1, content2, content3, banner_bgcolor, title, show_title FROM cpPages WHERE id = @ID";
                using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("ID", SqlDbType.Int).Value = iID;
                    cmd.Connection.Open();
                    SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
                        txtName.Text = dr["name"].ToString();
						txtSlug.Text = slug = dr["slug"].ToString();
						location = dr["location"].ToString();
						layout = dr["layout"].ToString();
						ltrBanner.Text = banner = dr["banner"].ToString();
						txtExcerpt.Text = dr["excerpt"].ToString();
						txtMetaTitle.Text = dr["meta_title"].ToString();
						txtMetaKeys.Text = dr["meta_keys"].ToString();
						txtMetaDesc.Text = dr["meta_description"].ToString();
						txtOrder.Text = dr["page_order"].ToString();
						if (dr["active"].ToString() == "True") {
							status = "1";
						}else {
							status = "0";
						}
						if (dr["show_title"].ToString() == "True") {
							show_title = "1";
						}else {
							show_title = "0";
						}
                        txtContent1.Text = dr["content1"].ToString();
						txtContent2.Text = dr["content2"].ToString();
						txtContent3.Text = dr["content3"].ToString();	
						
						txtTitle.Text = sTitle = dr["title"].ToString();
						
						txtBannerBgColor.Value = bannerBgColor = dr["banner_bgcolor"].ToString();
						
                        cmd.Connection.Close();
                    }
                }
            }
        }
    }
	

	
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin/pages/");
    }
    
	protected void btnSave_Click(object sender, EventArgs e) {
		string fileName = ltrBanner.Text;
		string prefix = DateTime.Now.ToString("MMdd-HHmmss-");
		string SQL = "";
		bool active = false;
		bool showtitle = false;
		
		if (ddlStatus.SelectedItem.Value == "1") {
			active = true;
		}
		
		if (ddlTitle.SelectedItem.Value == "1") {
			showtitle = true;
		}
		
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
			if (FileUpload1.HasFile)
			{
				if(File.Exists(mapMethod("~/images/page-banners/" + fileName))) {
					File.Delete(mapMethod("~/images/page-banners/" + fileName));
				}
				fileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
				fileName = prefix + fileName;
				FileUpload1.PostedFile.SaveAs(Server.MapPath("~/images/page-banners/") + fileName);
			}
			
            SQL = "UPDATE [cpPages] " +
                            "SET [name] = @name, " +
							"   [slug] = @slug, " +
                            "   [location] = @location, " +
							"   [layout] = @layout, " + 
							"	[banner] = @banner, " +
							"   [excerpt] = @excerpt, " +
							"   [meta_title] = @meta_title, " +
							"   [meta_keys] = @meta_keys, " +
							"   [meta_description] = @meta_description, " +
							"   [page_order] = @page_order, " +
							"   [edit_date] = @edit_date, " +
							"   [active] = @active, " +
							"   [content1] = @content1, " +
							"   [content2] = @content2, " +
							"   [content3] = @content3, " +
							"   [edit_by] = @edit_by, " +
							"   [banner_bgcolor] = @banner_bgcolor, " +
							"   [title] = @title, " +
							"   [show_title] = @show_title " +
                            " WHERE [id] = @ID";
			
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@ID", SqlDbType.Int).Value = iID;
				cmd.Parameters.Add("@name", SqlDbType.NVarChar, 200).Value = txtName.Text.Trim();
				cmd.Parameters.Add("@slug", SqlDbType.NVarChar, 256).Value = txtSlug.Text.Trim();
				cmd.Parameters.Add("@location", SqlDbType.NVarChar, 256).Value = ddlLocation.SelectedItem.Value;
				cmd.Parameters.Add("@layout", SqlDbType.NVarChar, 20).Value = ddlLayout.SelectedItem.Value;
                cmd.Parameters.Add("@banner", SqlDbType.NVarChar, 256).Value = fileName;
				cmd.Parameters.Add("@excerpt", SqlDbType.Text).Value = txtExcerpt.Text.Trim();
				cmd.Parameters.Add("@meta_title", SqlDbType.NVarChar, 256).Value = txtMetaTitle.Text.Trim();
				cmd.Parameters.Add("@meta_keys", SqlDbType.Text).Value = txtMetaKeys.Text.Trim();
				cmd.Parameters.Add("@meta_description", SqlDbType.Text).Value = txtMetaDesc.Text.Trim();
				cmd.Parameters.Add("@page_order", SqlDbType.Int).Value = txtOrder.Text.Trim();
				cmd.Parameters.Add("@edit_date", SqlDbType.DateTime).Value = DateTime.Now;
				cmd.Parameters.Add("@active", SqlDbType.Bit).Value = active;
				cmd.Parameters.Add("@content1", SqlDbType.Text).Value = txtContent1.Text.Trim();
				cmd.Parameters.Add("@content2", SqlDbType.Text).Value = txtContent2.Text.Trim();
				cmd.Parameters.Add("@content3", SqlDbType.Text).Value = txtContent3.Text.Trim();
                cmd.Parameters.Add("@edit_by", SqlDbType.NVarChar, 100).Value = Session["adminuname"].ToString();
				cmd.Parameters.Add("@banner_bgcolor", SqlDbType.NVarChar, 7).Value = txtBannerBgColor.Value;
				cmd.Parameters.Add("@title", SqlDbType.Text).Value = txtTitle.Text.Trim();
				cmd.Parameters.Add("@show_title", SqlDbType.Bit).Value = showtitle;

                cmd.Connection.Open();
                try {
                    cmd.ExecuteNonQuery();
                } catch (Exception ex) {
                    Response.Write(ex);
                }
                cmd.Connection.Close();
            }			
        }
        Response.Write("<script>location.replace('/admin/pages/edit.aspx?id=" + iID + "&success=1');</script>");
	}
	
	[WebMethod()]
	public string getPageWidgets() {
		string output = "";
		string SQL = "";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			SQL = "SELECT * FROM cpWidgets AS cw INNER JOIN cpPageWidgets AS cpw ON cpw.widget_id = cw.id WHERE cpw.page_id = @page_id";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("page_id", SqlDbType.Int).Value = iID;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while(dr.Read()) {
					output += "<li id='curr-" + dr["widget_id"].ToString() + "' class='drag-item' data-wid='" + dr["widget_id"].ToString() + "' data-wname='" + dr["name"].ToString().Trim() + "' data-pid='" + iID + "'><b>" + dr["name"].ToString() + "</b> " + checkCategory(Convert.ToInt32(dr["category"]), dr["type"].ToString()) + "</li>";
                }
				cmd.Connection.Close();
            }
		}
		
		return output;
	}
	
	[WebMethod()]
	public string getWidgetsList() {
		string output = "";
		string SQL = "";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			SQL = "SELECT * FROM cpWidgets WHERE id NOT IN (SELECT widget_id FROM cpPageWidgets WHERE page_id = @ID)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("ID", SqlDbType.Int).Value = iID;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while(dr.Read()) {
					output += "<li id='list-" + dr["id"].ToString() + "' class='drag-item' data-wid='" + dr["id"].ToString() + "' data-wname='" + dr["name"].ToString().Trim() + "' data-pid='" + iID + "'><b>" + dr["name"].ToString() + "</b> " + checkCategory(Convert.ToInt32(dr["category"]), dr["type"].ToString()) + "</li>";
                }
				cmd.Connection.Close();
            }
		}
		
		return output;
	}
	
	public string checkCategory(int cat, string type) {
		string output = "";
		string SQL = "";
		
		if (type == "news") {
			if (cat == 8) {
				output = ": <small>Inorganic Update</small>";
			}else if (cat == 7) {
				output = ": <small>Organic Update</small>";
			}else {
				output = "";
			}
		}else if (type == "flyers"){
			using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
				SQL = "SELECT * FROM cp_Product_Literature_Category WHERE CategoryID = @cat";
				using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
					cmd.CommandType = CommandType.Text;
					cmd.Parameters.Add("cat", SqlDbType.Int).Value = cat;
					cmd.Connection.Open();
					SqlDataReader dr = cmd.ExecuteReader();
					if (dr.HasRows) {
						dr.Read();
						output = ": <small>" + dr["CategoryName"].ToString() + "</small>";
					}else {
						output = "";
					}
					cmd.Connection.Close();
				}
			}
		}else {
			output = "<small>Custom Widget</small>";
		}
		
		return output;
	}
	
	[WebMethod()]
	public static string addWidget(int page_id, int widget_id) {
		string output = "";
		string SQL = "";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
		
			SQL = "INSERT INTO cpPageWidgets (page_id, widget_id) VALUES (@page_id, @widget_id)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("page_id", SqlDbType.Int).Value = page_id;
				cmd.Parameters.Add("widget_id", SqlDbType.Int).Value = widget_id;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
				cmd.Connection.Close();
            }
		
		}
		
		return "<div class='alert alert-success alert-dismissable'><button type='button' class='close' data-dismiss='alert' aria-hidden='true'>×</button><strong>Successfully</strong> added the <strong>Widget!!</strong></div>";
	}
	
	[WebMethod()]
	public static string delWidget(int page_id, int widget_id) {
		string SQL = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			SQL = "DELETE FROM cpPageWidgets WHERE page_id = @page_id AND widget_id = @widget_id";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("page_id", SqlDbType.Int).Value = page_id;
				cmd.Parameters.Add("widget_id", SqlDbType.Int).Value = widget_id;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
		}
		return "<div class='alert alert-danger alert-dismissable'> <button type='button' class='close' data-dismiss='alert' aria-hidden='true'>×</button><strong>Widget</strong> has been <strong>Removed!!</strong></div>";
	}
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}