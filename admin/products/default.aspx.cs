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
			if (Session["txtSearch"] != null) {
				if (Session["txtSearch"].ToString() != "") {
					txtSearch.Text = Session["txtSearch"].ToString();
					TableContent.SelectCommand = "SELECT * FROM cp_roi_Prods WHERE (cpPart LIKE '" + txtSearch.Text + "%' OR cpDescrip LIKE '%" + txtSearch.Text + "%')";
				}				
			}
		}
	
        lvProdTable.DataSource = TableContent;
        lvProdTable.DataBind();
    }
	
	protected void btnSearch_Click(object sender, EventArgs e) {
		
		if (txtSearch.Text != "") {
			
			TableContent.SelectCommand = "SELECT * FROM cp_roi_Prods WHERE (cpPart LIKE '" + txtSearch.Text + "%' OR cpDescrip LIKE '%" + txtSearch.Text + "%')";
			Session["txtSearch"] = txtSearch.Text;
			
			lvProdTable.DataSource = TableContent;
			lvProdTable.DataBind();
		}else {
			Session.Remove("txtSearch");
		}
	}
	
	protected void btnClearSearch_Click(object sender, EventArgs e) {
		txtSearch.Text = "";
			
		Session.Remove("txtSearch");
		lvProdTable.DataSource = TableContent;
		lvProdTable.DataBind();
	}
	
	protected void ddlDisplay_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataPager1.PageSize = Convert.ToInt32(ddlDisplay.SelectedValue);
		if (Session["txtSearch"] != null) {
			if (Session["txtSearch"].ToString() != "") {
				txtSearch.Text = Session["txtSearch"].ToString();
				TableContent.SelectCommand = "SELECT * FROM cp_roi_Prods WHERE (cpPart LIKE '" + txtSearch.Text + "%' OR cpDescrip LIKE '%" + txtSearch.Text + "%')";
			}				
		}
        lvProdTable.DataSource = TableContent;
        lvProdTable.DataBind();
    }
	
	[WebMethod()]
	public static string deleteItem(int newsid)
	{
		string SQL = "";
		string prodid = newsid.ToString();
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			SQL = "SELECT AccessoryFeatureId FROM sp_roi_AccessoryFeatures WHERE AccessoryProductID = @prodID";
			using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
				cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@prodID", SqlDbType.Int).Value = prodid;
                cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				while(dr.Read()) {
					//deleteFeat(Convert.ToInt32(dr["AccessoryFeatureId"]));
				}
				cmd.Connection.Close();
			}
			
			
			SQL = "SELECT AccessorySpecificationID FROM sp_roi_AccessorySpecifications WHERE AccessoryProductID = @prodID";
			using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
				cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@prodID", SqlDbType.Int).Value = prodid;
                cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				while(dr.Read()) {
					//deleteSpecs(dr["AccessorySpecificationID"].ToString());
				}
				cmd.Connection.Close();
			}
			
			SQL = "DELETE FROM sp_roi_EquipmentProductTypeAccessories WHERE AccessoryProductId = @ID";
			using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@ID", SqlDbType.Int).Value = prodid;
                cmd.Connection.Open();
				cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
			
			using (SqlCommand cmd = new SqlCommand("SELECT PartNumber FROM sp_roi_AccessoryProduct WHERE AccessoryProductId = @ID", cn))
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@ID", SqlDbType.Int).Value = prodid;

                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                if (dr.HasRows) {
                    dr.Read();
					string filePath = mapMethod("~/images/product_images/accessories/" + dr["PartNumber"].ToString().Trim() + "/");
					/*if(Directory.Exists(filePath)) {
						Directory.Delete(filePath, true);
					}*/
					if(File.Exists(filePath + dr["PartNumber"].ToString().Trim() + ".jpg")) {
						File.Delete(filePath + dr["PartNumber"].ToString().Trim() + ".jpg");
					}
					if(File.Exists(filePath + dr["PartNumber"].ToString().Trim() + "_large.jpg")) {
						File.Delete(filePath + dr["PartNumber"].ToString().Trim() + "_large.jpg");
					}
                    cmd.Connection.Close();
                }
            }
			
			SQL = "DELETE FROM [sp_roi_AccessoryProduct] WHERE AccessoryProductId = " + prodid;
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
			
			SQL = "DELETE FROM [sp_roi_AccessoryProduct_Locale] WHERE accID = " + prodid;
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
			
		}
		
		return "<div class='alert alert-success alert-dismissable bg-success'><button type='button' class='close' data-dismiss='alert' aria-hidden='true'>×</button>Accessory has been Deleted</div>";
	}
	
	protected string getImage(string part, string type) {
		string img = "";

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT * FROM certiProdImages WHERE PartNumber = @PartNumber";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@PartNumber", SqlDbType.VarChar).Value = part;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					dr.Read();
					img = "<img src='/images/product_images/" + dr["thumbnail_image"].ToString() +"' alt='" + part + "' style='width:40px;height:auto' />";
				}else {
					if (type == "1") {
						img = "<img src='/images/product_images/OrganicProducts.jpg' alt='No Image' style='width:40px;height:auto' />";
					}else if (type == "2") {
						img = "<img src='/images/product_example.jpg' alt='No Image' style='width:40px;height:auto' />";
					}
				}
                cmd.Connection.Close();
            }
        }

        return img;
	}
	
	public string getProdType(string type) {
		string output = "";
		if (type == "1") {
			output = "Organic Standards";
		}else if (type == "2") {
			output = "Inorganic Standards";
		}else if (type == "6") {
			output = "Lab Stuff";
		}
        return output;
	}
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}