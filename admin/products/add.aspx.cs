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

public partial class news_edit : System.Web.UI.Page
{
    public int iID = 0;
	public int currRegion = 1;
	public string lang = "";
	public string PartNumber = "";
	public string langOption = "";
	public string prodTitle = "";
	public int prodType = 0;
	public int prodLvl = 0;
	
    protected void Page_Load(object sender, EventArgs e)
    {
		
        string SQL = "";
				
		currRegion = 1;
		
		if(Request.QueryString["lang"] != null  ) {
			currRegion = Convert.ToInt32(Request.QueryString["lang"]);
			lang = "&lang=" + currRegion;
			Session["currLang"] = currRegion;
		}
		
        if (!Page.IsPostBack) {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {	
				
				SQL = "SELECT sre.ProductTypeID, srel.ProductTyeName FROM sp_roi_EquipmentProductTypes sre INNER JOIN sp_roi_EquipmentProductTypes_Locale srel ON sre.ProductTypeID = srel.prodID WHERE srel.cultureID = @region ORDER BY ProductTyeName";
				using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                    cmd.CommandType = CommandType.Text;
					cmd.Parameters.Add("region", SqlDbType.Int).Value = currRegion;
                    cmd.Connection.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
					Panel divP = new Panel();
					divP.CssClass = "form-group";
					divP.ID = "accEqList";
					Label lbl;
					CheckBox box;
					Panel divCol;
                    while(dr.Read()) {
						accChkBox.Items.Add(new ListItem(dr["ProductTyeName"].ToString(), dr["ProductTypeID"].ToString()));
						lbl = new Label();
						box = new CheckBox();
						divCol = new Panel();
						lbl.CssClass = "checkbox-inline";
						lbl.AssociatedControlID = dr["ProductTypeID"].ToString();
						box.ID = dr["ProductTypeID"].ToString();
						box.Text = dr["ProductTyeName"].ToString();
						box.CssClass = "checkController";
						lbl.Controls.Add(box);
						divCol.CssClass = "col-lg-3";
						divCol.Controls.Add(lbl);
						divP.Controls.Add(divCol);
                    }
					divCol = new Panel();
					divCol.CssClass = "clearfix";
					divP.Controls.Add(divCol);
					accCheckList.Controls.Add(divP);
					cmd.Connection.Close();
                }
            }
			
			SQL = "SELECT sra.AccessoryProductTypeID, sral.AccessoryProductTypeDesc FROM sp_roi_AccessoryProductTypes sra INNER JOIN sp_roi_AccessoryProductTypes_Locale sral ON sra.AccessoryProductTypeID = sral.accID WHERE sral.cultureID = " + currRegion + " ORDER BY sra.OrderBY";
			
			dataProdTypes.SelectCommand = SQL;
        }
    }
		
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin/accessories/");
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
		string prefix = DateTime.Now.ToString("MMdd-HHmmss-");
		string SQL = "";
		string PartNum = txtPart.Text;
	
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
			SQL = "SELECT TOP 1 AccessoryProductID FROM sp_roi_AccessoryProduct ORDER BY AccessoryProductID DESC";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					dr.Read();
					iID = Convert.ToInt32(dr["AccessoryProductID"]) + 1;
				}
				cmd.Connection.Close();
			}
					
			HttpFileCollection fileCollection = Request.Files;
			for (int i = 0; i < fileCollection.Count; i++) {
				HttpPostedFile postedFile = fileCollection[i];
				string filePath = mapMethod("~/images/product_images/accessories/" + PartNum + "/");
				if (postedFile.ContentLength > 0) {
					if(!Directory.Exists(filePath)) {
						Directory.CreateDirectory(filePath);
					}
					if (i == 0) {
						if(File.Exists(filePath + PartNum + ".jpg")) {
							File.Delete(filePath + PartNum + ".jpg");
						}
						postedFile.SaveAs(filePath + PartNum + ".jpg");
					}else {
						if(File.Exists(filePath + PartNum + "_large.jpg")) {
							File.Delete(filePath + PartNum + "_large.jpg");
						}
						postedFile.SaveAs(filePath + PartNum + "_large.jpg");
					}
				}
			}
			
			SQL = "INSERT INTO [sp_roi_AccessoryProduct] ([AccessoryProductID], [PartNumber], [AccessoryProductTypeID], [ProductLevelID]) VALUES (@ID, @part, @prodType, @prodLvl)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@ID", SqlDbType.Int).Value = iID;
				cmd.Parameters.Add("@part", SqlDbType.NVarChar, 255).Value = PartNum;
				cmd.Parameters.Add("@prodLvl", SqlDbType.Int).Value = ddlProdLvl.SelectedItem.Value;
				cmd.Parameters.Add("@prodType", SqlDbType.Int).Value = ddlProdType.SelectedItem.Value;
                cmd.Connection.Open();
                try {
                    cmd.ExecuteNonQuery();
                } catch (Exception ex) {
                    Response.Write(ex);
                }
                cmd.Connection.Close();
            }
			
            SQL = "INSERT INTO [sp_roi_AccessoryProduct_Locale] ([accID], [cultureID], [ProductName], [Description], [LongDescription]) VALUES (@ID, @region, @prodName, @prodDesc, @prodDesc2)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@ID", SqlDbType.Int).Value = iID;
				cmd.Parameters.Add("@region", SqlDbType.Int).Value = currRegion;
				cmd.Parameters.Add("@prodName", SqlDbType.NVarChar, 255).Value = txtName.Text;
				cmd.Parameters.Add("@prodDesc", SqlDbType.Text).Value = txtDesc.Text;
				cmd.Parameters.Add("@prodDesc2", SqlDbType.Text).Value = txtDesc.Text;
                cmd.Connection.Open();
                try {
                    cmd.ExecuteNonQuery();
                } catch (Exception ex) {
                    Response.Write(ex);
                }
                cmd.Connection.Close();
            }
			
			List<String> YrStrList = new List<string>();
			int epta = 0;
			foreach (ListItem item in accChkBox.Items) {
				if (item.Selected) {
					YrStrList.Add(item.Value);
					SQL = "SELECT TOP 1 EquipmentProductTypeAccessoryId FROM sp_roi_EquipmentProductTypeAccessories ORDER BY EquipmentProductTypeAccessoryId DESC";
					using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
						cmd.CommandType = CommandType.Text;
						cmd.Connection.Open();
						SqlDataReader dr = cmd.ExecuteReader();
						if (dr.HasRows) {
							dr.Read();
							epta = Convert.ToInt32(dr["EquipmentProductTypeAccessoryId"]) + 1;
						}
						cmd.Connection.Close();
					}
					
					SQL = "INSERT INTO sp_roi_EquipmentProductTypeAccessories (EquipmentProductTypeAccessoryId, EquipmentProductTypeId, AccessoryProductId, AcessoryPart) VALUES (@epta, @eqID, @accID, @part)";
					using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
						cmd.CommandType = CommandType.Text;
						cmd.Parameters.Add("@epta", SqlDbType.Int).Value = epta;
						cmd.Parameters.Add("@eqID", SqlDbType.Int).Value = Convert.ToInt32(item.Value.Trim());
						cmd.Parameters.Add("@accID", SqlDbType.Int).Value = iID;
						cmd.Parameters.Add("@part", SqlDbType.NVarChar, 200).Value = PartNum + "|01";
						cmd.Connection.Open();
						cmd.ExecuteNonQuery();
						cmd.Connection.Close();
					}
				}
			}
        }
		
        Response.Write("<script>location.replace('/admin/accessories/edit.aspx?id=" + iID + "&lang=" + currRegion+ "&created=1');</script>");
    }
		
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}