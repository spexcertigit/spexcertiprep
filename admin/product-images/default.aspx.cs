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

public partial class news_items : System.Web.UI.Page
{
	public int currRegion = 1;
	
    protected void Page_Load(object sender, EventArgs e)
    {
		if (!IsPostBack) {
			if (Session["currLang"] != null) {
				TableContent.SelectParameters["region"].DefaultValue = Session["currLang"].ToString();
				currRegion = Convert.ToInt32(Session["currLang"]);
			}
		}
		
		string uniqStr = Guid.NewGuid().ToString();
		string thumbnail = "-thumbnail";
		foreach (string s in Request.Files) {
			HttpPostedFile file = Request.Files[s];

			int fileSizeInBytes = file.ContentLength;
			string fileName = file.FileName;
			
			string fileExtension = "";

            if (!string.IsNullOrEmpty(fileName)) {
				fileExtension = Path.GetExtension(fileName);
			}
				
            // IMPORTANT! Make sure to validate uploaded file contents, size, etc. to prevent scripts being uploaded into your web app directory
            string savedFileName = Path.Combine(Server.MapPath("~/images/product_images/"), uniqStr + thumbnail + fileExtension);
			file.SaveAs(savedFileName);
			
			//Response.Write("<script>alert('Filename:  " + fileName + "|| Extention: " + fileExtension + "||" + savedFileName + " || Query: " + Request.QueryString + "');</script>");
			
			if (thumbnail == "") {
				using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
					string SQL = "INSERT INTO certiProdImages_List (img, title, dateupload) VALUES (@img, @title, @dateupload)";
					using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
						cmd.CommandType = CommandType.Text;
						cmd.Parameters.Add("@img", SqlDbType.NVarChar, 255).Value = uniqStr + fileExtension;
						cmd.Parameters.Add("@title", SqlDbType.NVarChar, 100).Value = fileName.Replace(fileExtension, "");
						cmd.Parameters.Add("@dateupload", SqlDbType.DateTime).Value = DateTime.Now;
						cmd.Connection.Open();
						cmd.ExecuteNonQuery();
						cmd.Connection.Close();
					}
				}
			}
			
			thumbnail = "";
			
        }
		
		lvNewsTable.DataSource = TableContent;
        lvNewsTable.DataBind();
    }
	
	protected void ddlDisplay_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataPager1.PageSize = Convert.ToInt32(ddlDisplay.SelectedValue);
        lvNewsTable.DataSource = TableContent;
        lvNewsTable.DataBind();
    }
	
	protected void ddlLang_SelectedIndexChanged(object sender, EventArgs e)
    {
		currRegion = Convert.ToInt32(ddlLang.SelectedValue);
		Session["currLang"] = currRegion;
    }

	[WebMethod()]
	public static string saveImgDetails(int id, string title, string caption, string alttext, string description)
	{
		string SQL = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			SQL = "UPDATE certiProdImages_List SET [title] = @title, [caption] = @caption, [altText] = @altText, [description] = @desc WHERE id = @ID";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
				cmd.Parameters.Add("ID", SqlDbType.Int).Value = id;
				cmd.Parameters.Add("title", SqlDbType.NVarChar, 256).Value = title;
				cmd.Parameters.Add("caption", SqlDbType.NVarChar, 256).Value = caption;
				cmd.Parameters.Add("altText", SqlDbType.NVarChar, 256).Value = alttext;
				cmd.Parameters.Add("desc", SqlDbType.Text).Value = description;
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
			
		}
		return "<div class='alert alert-success alert-dismissable bg-success'><button type='button' class='close' data-dismiss='alert' aria-hidden='true'>×</button>Image details has been updated!</div>";
	}
	
	[WebMethod()]
	public static string saveImgProduct(int id, string partnum) {
		string SQL = "";
		string output = "";
		bool exist = false;

		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			SQL = "SELECT cpPart FROM cp_roi_Prods WHERE cpPart = @part";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("part", SqlDbType.NVarChar, 50).Value = partnum;
				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					exist = true;
				}else {
					output = "<div class='alert alert-danger alert-dismissable bg-danger'><button type='button' class='close' data-dismiss='alert' aria-hidden='true'>×</button>Product does not exist! Please check your Part Number.</div>";
				}
				cmd.Connection.Close();
			}
			
			if (exist == true) {
				SQL = "INSERT INTO certiProdImages (PartNumber, img_id) VALUES (@part, @ID)";
				using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
					cmd.CommandType = CommandType.Text;
					cmd.Connection.Open();
					cmd.Parameters.Add("ID", SqlDbType.Int).Value = id;
					cmd.Parameters.Add("part", SqlDbType.NVarChar, 50).Value = partnum;
					cmd.ExecuteNonQuery();
					cmd.Connection.Close();
				}
				output = "<div class='alert alert-success alert-dismissable bg-success'><button type='button' class='close' data-dismiss='alert' aria-hidden='true'>×</button>Product has been added.</div>";
			}
		}
		return output;
	}
	
	[WebMethod()]
	public static string deleteItem(int newsid)
	{
		string SQL = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			using (SqlCommand cmd = new SqlCommand("SELECT thumb FROM sp_News WHERE id = @ID", cn))
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("ID", SqlDbType.Int).Value = newsid;

                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                if (dr.HasRows) {
                    dr.Read();
					
					if(File.Exists(mapMethod("~/news-and-events/images/" + dr["thumb"].ToString()))) {
						File.Delete(mapMethod("~/news-and-events/images/" + dr["thumb"].ToString()));
					}
                    cmd.Connection.Close();
                }
            }
			
			SQL = "DELETE FROM [sp_News] WHERE id = " + newsid;
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
			
			SQL = "DELETE FROM [sp_News_Locale] WHERE newsID = " + newsid;
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
		}
		return "<div class='alert alert-success alert-dismissable bg-success'><button type='button' class='close' data-dismiss='alert' aria-hidden='true'>×</button>News Item has been Deleted</div>";
	}
	
	[WebMethod()]
	public static string removePart(int itemid) {
		string SQL = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			SQL = "DELETE FROM [certiProdImages] WHERE id = " + itemid;
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
		}
		return "";
	}
	
	[WebMethod()]
	public static string uploadImage() {
		string SQL = "";
		/*using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			SQL = "DELETE FROM [certiProdImages] WHERE id = " + itemid;
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
		}*/
		return "<script>alert('Upload return')</script>";
	}
	
	public string getThumbnail(string img) {
		string imgURL = img;
		//imgURL = img.Replace(".png", "-thumbnail.png");
		//imgURL = img.Replace(".jpg", "-thumbnail.png");
		
		if(File.Exists(mapMethod("~/images/product_images/" + imgURL))) {
			imgURL = "/images/product_images/" + imgURL;
		}else {
			imgURL = "https://placehold.it/145x145";
		}
		return imgURL;
	}
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
	public string getProducts(string id) {
		string output = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			using (SqlCommand cmd = new SqlCommand("SELECT * FROM certiProdImages WHERE img_id = @ID", cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("ID", SqlDbType.Int).Value = id;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while(dr.Read()) {
					output += "<div id='close-" + dr["id"].ToString().Trim() + "' class='products'>" + dr["PartNumber"].ToString().Trim() + "<a class='close' data-id='" + dr["id"].ToString().Trim() + "'>x</a></div>";
                }
            }
		}
		return output;
	}
}
