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
    public string iID = "";
	public int currRegion = 1;
	public string lang = "";
	public string PartNumber = "";
	public string langOption = "";
	public string prodTitle = "", mainImg = "", thumbImg = "";
	public int prodType = 0;
	public string sds = "";
	
    protected void Page_Load(object sender, EventArgs e)
    {
		
        string SQL = "";
		
        if (Request.QueryString["id"] != null) {
			iID = Request.QueryString["id"];
		}else {
			Response.Redirect("/admin/products/");
		}
		
        if (!Page.IsPostBack) {
			orgBox.Visible = true;
			inorgBox.Visible = true;
			
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
				
				SQL = 	"SELECT  prod.cpPart AS PartNumber, " +
						 "		 ISNULL(prod.cpType, '0') AS catID, " + 
						 " 		 prod.cpDescrip AS Title, " +
						 "		 prod.cpLongDescrip AS Description, " +
                         "       prod.cpUnitCnt AS UnitPack, " + 
						 "		 prod.cpiskit AS IsKit, " +
						 "		 prod.Part_Nbr AS pNbr, " +
						 "		 prod.Prod_Notes AS notes, " +
                         "       ISNULL(cm.cmID, '0') AS Method, " +
                         "       ISNULL(cv.cpvID, '0') AS Volume, " +
                         "       ISNULL(si.csfID, '0') AS Shipping, " +
                         "       ISNULL(cs.csgID, '0')AS Storage, " +
                         "       ISNULL(mat.T542_Code, '0') AS Matrix " +
                         "   FROM cp_roi_Prods AS prod LEFT JOIN cp_roi_Matrix AS mat ON mat.T542_Code = prod.cpMatrix " +
                         "       LEFT JOIN cp_roi_ProdMeths AS pm ON pm.cpmProdID = prod.cpPart " +
                         "       LEFT JOIN cp_roi_Methods AS cm ON pm.cpmMethID = cm.cmID " +
                         "       LEFT JOIN cp_roi_Volumes AS cv ON prod.Cpvol = cv.cpvID " +
                         "       LEFT JOIN cp_roi_ProdCats AS cats ON cats.cpcID = prod.cpID " + 
                         "       LEFT JOIN cp_roi_ProdFamilies AS cpf ON prod.cpID = cpf.cpfID " +
                         "       LEFT JOIN cp_roi_Families AS cfam ON cpf.cpffamID = cfam.cfID " +
                         "       LEFT JOIN cp_roi_Cats AS ccats ON ccats.ccID = cats.cpcCatID " +
                         "       LEFT JOIN cp_roi_ProdDetails AS cpd ON cpd.cpdID = prod.cpID " +
                         "       LEFT JOIN cp_roi_ShipInfo AS si ON si.csfID = cpd.cpdShipInf " +
                         "       LEFT JOIN cp_roi_Storage AS cs ON cs.csgID = cpd.cpdStorage " +
                         "       LEFT JOIN cp_roi_ProdDetails_SEOText as SEO ON SEO.Part_Nbr = prod.cpPart " +
                         "   WHERE prod.cpID = @ID";
						 
                using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("ID", SqlDbType.Int).Value = iID;
                    cmd.Connection.Open();
					
                    SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
                        txtPart.Text = txtPartHid.Value = PartNumber =  dr["PartNumber"].ToString().Trim();
                        txtName.Text = prodTitle = dr["Title"].ToString().Trim();
						txtDesc.Text = dr["Description"].ToString().Trim();
						prodType = Convert.ToInt32(dr["catID"]);
						txtPNbrHid.Value = dr["pNbr"].ToString().Trim();
						
						string mat = dr["Matrix"].ToString().Trim();
						ddlMatrix.DataBind();
						ddlMatrix.Items.Insert(0, new ListItem("-- Select Matrix --", "0"));
						ddlMatrix.SelectedValue = mat;
						
						string vol = dr["Volume"].ToString().Trim();
						ddlVolume.DataBind();
						ddlVolume.Items.Insert(0, new ListItem("-- Select Volume --", "0"));
						ddlVolume.SelectedValue = vol;
						
						txtUnitsPerPack.Text = dr["UnitPack"].ToString();
						string store = dr["Storage"].ToString().Trim();
						ddlStorage.DataBind();
						ddlStorage.Items.Insert(0, new ListItem("-- Select Storage --", "0"));
						ddlStorage.SelectedValue = store;
						
						string ship = dr["Shipping"].ToString().Trim();
						ddlShipInfo.DataBind();
						ddlShipInfo.Items.Insert(0, new ListItem("-- Select Shipping Info --", "0"));
						ddlShipInfo.SelectedValue = ship;
						
						txtProdNotes.Text = dr["notes"].ToString();
                    }
					cmd.Connection.Close();
                }
				
				SQL = "SELECT * FROM certiProdImages WHERE PartNumber = @part";
				using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("part", SqlDbType.NVarChar, 30).Value = PartNumber;
                    cmd.Connection.Open();
					
                    SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
                        mainImg = dr["main_image"].ToString();
						thumbImg = dr["thumbnail_image"].ToString();
                    }
					cmd.Connection.Close();
                }
				
				SQL = "SELECT * FROM certiMSDS WHERE PartNumber = @part";
				using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("part", SqlDbType.NVarChar, 30).Value = PartNumber;
                    cmd.Connection.Open();
					
                    SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
                        sds = dr["FileName"].ToString();
                    }
					cmd.Connection.Close();
                }
				
            }			
			ddlProdType.DataBind();
			/*if (prodType == 1) {
				orgBox.Visible = true;
			}else if (prodType == 2){
				inorgBox.Visible = true;
			}*/
        }
    }
		
	[WebMethod()]
	public string getComponents() {
		string output = "";
		string SQL = "";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			SQL = 	"SELECT  cpc.cpmpID, " + 
						"	 cp.cpPart, " +
						"	 cp.cpDescrip, " + 
						" 	 ca.caNameWeb, " +
						" 	 CAST(cpc.cpmpConc AS varchar(10)) AS cpmpConc, " +
						" 	 cu.cuUnit " +
						"FROM certiProdComps AS cpc " +
						"	 JOIN certiAnalytes AS ca ON cpc.cpmpAnalyteID = ca.caID " +
						"	 JOIN cp_roi_Prods AS cp ON cpc.cpmpProd = cp.cpPart " +
						"	 JOIN certiUnits AS cu ON cpc.cpmpUnits = cu.cuID " +
						"WHERE cpc.cpmpConc IS NOT NULL AND cpc.cpmpProd =  @PartNumber " + 
						"ORDER BY cpc.cpmpConc DESC, ca.caNameWeb";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("PartNumber", SqlDbType.NVarChar, 50).Value = PartNumber;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				output += "<thead><tr><th>Component</th><th>Concentration</th><th>Actions</th></tr></thead><tbody>";
                while(dr.Read()) {
					output += "<tr id='Tr"+ dr["cpmpID"].ToString() +"'><td>" + dr["caNameWeb"].ToString() + "</td><td>" + dr["cpmpConc"].ToString() + " " + dr["cuUnit"].ToString() + "</td><td style='text-align:center'><a data-compid='" + dr["cpmpID"].ToString() + "' class='comp-del' title='Delete'><i class='fa fa-remove'></i></a></td></tr>";
                }
				output +="</tbody>";
				cmd.Connection.Close();
            }
		}
		
		return output;
	}
	
	[WebMethod()]
	public string getOrgComponents() {
		string output = "";
		string SQL = "";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			SQL = 	"SELECT cpc.cpmpID, " +
					"	CAST(cpc.cpmpConc AS varchar(10)) AS cpmpConc, " +
					"	cc.cmpComp, " +
					"	cu.cuUnit, " + 
					"	cc.cmpCAS AS CAS " +
					"FROM certiProdComps AS cpc " +
					"	JOIN certiComps AS cc ON cpc.cpmpCompID = cc.cmpID " +
					"	JOIN cp_roi_Prods AS cp ON cpc.cpmpProd = cp.cpPart " +
					"	JOIN certiUnits AS cu ON cpc.cpmpUnits = cu.cuID " +
					"WHERE cpc.cpmpConc IS NOT NULL AND cpc.cpmpProd = @PartNumber ORDER BY cpc.cpmpID DESC, cc.cmpComp";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("PartNumber", SqlDbType.NVarChar, 50).Value = PartNumber;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				output += "<thead><tr><th>Component</th><th>CAS #</th><th>Concentration</th><th>Actions</th></tr></thead><tbody>";
                while(dr.Read()) {
					output += "<tr id='Tr"+ dr["cpmpID"].ToString() +"'><td>" + dr["cmpComp"].ToString() + "</td><td>" + dr["CAS"].ToString() + "</td><td>" + dr["cpmpConc"].ToString() + " " + dr["cuUnit"].ToString() + "</td><td style='text-align:center'><a data-compid2='" + dr["cpmpID"].ToString() + "' class='comp-del2' title='Delete'><i class='fa fa-remove'></i></a></td></tr>";
                }
				output +="</tbody>";
				cmd.Connection.Close();
            }
		}
		
		return output;
	}
	
	[WebMethod()]
	public string getKits() {
		string output = "";
		string SQL = "";

		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			SQL = 	"SELECT  ps.ID AS psID, " +
						"	 IM_1.Item_Part_Nbr AS PartNumber, " +
						"	 cp.cpDescrip AS [Description] " +
						"FROM cp_roi_Prods p " +
						"	 JOIN cp_roi_PS AS ps ON p.cpID = ps.Novo_IM_Assy " + 
						"	 LEFT JOIN cp_roi_IM AS IM_1 ON IM_1.Part_Number = ps.Component_Part " + 
						"	 LEFT JOIN cp_roi_Prods AS cp ON IM_1.Item_Part_Nbr = cp.cpPart " + 
						"	 LEFT JOIN cp_roi_Volumes AS cv ON cp.Cpvol = cv.cpvID " + 
						"WHERE p.cpPart = @PartNumber AND p.cpIsKit = 'Y' " + 
						"ORDER BY IM_1.Item_Part_Nbr";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("PartNumber", SqlDbType.NVarChar, 50).Value = PartNumber;

                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while(dr.Read()) {
					output += "<li id='list-" + dr["psID"].ToString().Trim() + "' class='drag-item' data-kitid='" + dr["psID"].ToString().Trim() + "' data-pid='" + iID + "'><b>" + dr["PartNumber"].ToString().Trim() + ":</b> " + dr["Description"].ToString() + "</li>";
                }
				cmd.Connection.Close();
            }
		}
		
		return output;
	}
	
	[WebMethod()]
	public string getKitsList() {
		string output = "";
		string SQL = "";
		string kitid = "";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			SQL = 	"SELECT  p.Part_Nbr AS kitID, " +
						"	 p.cpPart AS PartNumber, " +
						"	 p.cpDescrip AS [Description], " +
						"	 p.cpID AS [cpID] " +
						"FROM cp_roi_Prods p " +
						"WHERE p.cpIsKit = 'N' AND p.cpPart NOT IN (" +
							"SELECT  IM_1.Item_Part_Nbr " +
							"FROM cp_roi_Prods p " +
							"	 JOIN cp_roi_PS AS ps ON p.cpID = ps.Novo_IM_Assy " + 
							"	 LEFT JOIN cp_roi_IM AS IM_1 ON IM_1.Part_Number = ps.Component_Part " + 
							"	 LEFT JOIN cp_roi_Prods AS cp ON IM_1.Item_Part_Nbr = cp.cpPart " + 
							"	 LEFT JOIN cp_roi_Volumes AS cv ON cp.Cpvol = cv.cpvID " + 
							"WHERE p.cpPart = @PartNumber AND p.cpIsKit = 'Y' " +
						")" + 
						"ORDER BY p.cpPart";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("PartNumber", SqlDbType.NVarChar, 50).Value = PartNumber;

                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while(dr.Read()) {
					kitid = getIMAssy(iID) + "*" + dr["kitID"].ToString().Trim();
					
					output += "<li id='list-" + dr["cpID"].ToString().Trim() + "' class='drag-item' data-impart='" + dr["cpID"].ToString().Trim() + "' data-cpart='" + dr["kitID"].ToString().Trim() + "' data-imassy='" + iID + "' data-ppart='" + getIMAssy(iID) + "' data-kitid='" + kitid + "' ><b>" + dr["PartNumber"].ToString().Trim() + ":</b> " + dr["Description"].ToString() + "</li>";
                }
				cmd.Connection.Close();
            }
		}
		
		return output;
	}
	
	public string getIMAssy(string cpID){
		string output = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			string SQL = "SELECT Part_Nbr FROM cp_roi_Prods WHERE cpID = @cpID";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("cpID", SqlDbType.NVarChar, 50).Value = cpID;

                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows) {
					dr.Read();
					output = dr["Part_Nbr"].ToString().Trim();
				}
				cmd.Connection.Close();
            }
		}
		return output;
	}
	
	[WebMethod()]
	public static string addKit(string parent_part, string component_part, int im_assy, int im_part) {
		string output = "";
		string SQL = "";
		string kit_id = parent_part + "*" + component_part;
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
		
			SQL = "INSERT INTO cp_roi_PS (Parent_Part, ID, Component_Part, Qpa, Novo_IM_Assy, Novo_IM_Part, Novo_Select) VALUES (@parent_part, @kit_id, @component_part, @qpa, @im_assy, @im_part, @novo_sel)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("parent_part", SqlDbType.NVarChar, 50).Value = parent_part;
				cmd.Parameters.Add("kit_id", SqlDbType.NVarChar, 100).Value = kit_id;
				cmd.Parameters.Add("component_part", SqlDbType.NVarChar, 50).Value = component_part;
				cmd.Parameters.Add("qpa", SqlDbType.Int).Value = 1;
				cmd.Parameters.Add("im_assy", SqlDbType.Int).Value = im_assy;
				cmd.Parameters.Add("im_part", SqlDbType.Int).Value = im_part;
				cmd.Parameters.Add("novo_sel", SqlDbType.Char, 6).Value = "1";
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
				cmd.Connection.Close();
            }
		
		}
		
		return "<div class='alert alert-success alert-dismissable'><button type='button' class='close' data-dismiss='alert' aria-hidden='true'>x</button><strong>Successfully</strong> added the <strong>Product kit!!</strong></div>";
	}
	
	[WebMethod()]
	public static string delKit(string kit_id) {
		string SQL = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			SQL = "DELETE FROM cp_roi_PS WHERE ID = @kit_id";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("kit_id", SqlDbType.NVarChar, 50).Value = kit_id;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
		}
		return "<div class='alert alert-danger alert-dismissable'> <button type='button' class='close' data-dismiss='alert' aria-hidden='true'>x</button><strong>Product kit</strong> has been <strong>Removed!!</strong></div>";
	}
	
	[WebMethod()]
	public static string addFamily(int famID, int cpfID, string PartNum, string famName) {
		string output = "";
		string SQL = "";
		string fam_id = cpfID + "_" + famID;
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
		
			SQL = "INSERT INTO cp_roi_ProdFamilies (ID, cpfID, cpfProdID, cpffamID, Web_Exists) VALUES (@ID, @cpfID, @PartNum, @famID, @web)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("ID", SqlDbType.NVarChar, 50).Value = fam_id;
				cmd.Parameters.Add("cpfID", SqlDbType.Int).Value = cpfID;
				cmd.Parameters.Add("PartNum", SqlDbType.NVarChar, 50).Value = PartNum;
				cmd.Parameters.Add("famID", SqlDbType.Int).Value = famID;
				cmd.Parameters.Add("web", SqlDbType.Char, 6).Value = "1";
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
				cmd.Connection.Close();
            }
		
		}
		
		return "<div id='close-" + fam_id+ "' class='products btn-sm'>" + famName + "<a class='remove-fam close' onclick=\"javascript:delCat('" + fam_id + "', '" + famName +"')\">x</a></div>";
	}
	
	[WebMethod()]
	public static string addCategory(int catID, int cpcID, string PartNum, string catName) {
		string output = "";
		string SQL = "";
		string cat_id = cpcID + "_" + catID;
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
		
			SQL = "INSERT INTO cp_roi_ProdCats (ID, cpcID, cpcProdID, cpcCatID) VALUES (@ID, @cpcID, @PartNum, @catID)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("ID", SqlDbType.NVarChar, 50).Value = cat_id;
				cmd.Parameters.Add("cpcID", SqlDbType.Int).Value = cpcID;
				cmd.Parameters.Add("PartNum", SqlDbType.NVarChar, 50).Value = PartNum;
				cmd.Parameters.Add("catID", SqlDbType.Int).Value = catID;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
				cmd.Connection.Close();
            }
		
		}
			
		return "<div id='cclose-" + cat_id + "' class='products btn-sm'>" + catName + "<a class='remove-cat close' onclick=\"javascript:delCat('" + cat_id + "', '" + catName +"')\">x</a></div>";
	}
	
	[WebMethod()]
	public static string addMethod(int metID, int cpmID, string PartNum, string metName) {
		string output = "";
		string SQL = "";
		string met_id = cpmID + "_" + metID;
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
		
			SQL = "INSERT INTO cp_roi_ProdMeths (ID, cpmID, cpmProdID, cpmMethID) VALUES (@ID, @cpmID, @PartNum, @metID)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("ID", SqlDbType.NVarChar, 50).Value = met_id;
				cmd.Parameters.Add("cpmID", SqlDbType.Int).Value = cpmID;
				cmd.Parameters.Add("PartNum", SqlDbType.NVarChar, 50).Value = PartNum;
				cmd.Parameters.Add("metID", SqlDbType.Int).Value = metID;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
				cmd.Connection.Close();
            }
		}
		
		return "<div id='mclose-" + met_id+ "' class='products btn-sm'>" + metName + "<a class='remove-fam close' onclick=\"javascript:delMeth('" + met_id + "', '" + metName +"')\">x</a></div>";
	}
	
	[WebMethod()]
	public static string addTechnique(int techID, int cpatID, string PartNum, string techName) {
		string output = "";
		string SQL = "";
		string tech_id = cpatID + "_" + techID;
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
		
			SQL = "INSERT INTO cp_roi_ProdATs (ID, cpatID, cpatProdId, cpatATID) VALUES (@ID, @cpatID, @PartNum, @techID)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("ID", SqlDbType.NVarChar, 50).Value = tech_id;
				cmd.Parameters.Add("cpatID", SqlDbType.Int).Value = cpatID;
				cmd.Parameters.Add("PartNum", SqlDbType.NVarChar, 50).Value = PartNum;
				cmd.Parameters.Add("techID", SqlDbType.Int).Value = techID;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.ExecuteNonQuery();
				cmd.Connection.Close();
            }
		}
		
		return "<div id='tclose-" + tech_id+ "' class='products btn-sm'>" + techName + "<a class='remove-tech close' onclick=\"javascript:delTech('" + tech_id + "', '" + techName +"')\">x</a></div>";
	}
	
	[WebMethod()]
	public static string addApplications(int appID, int cpfID, string PartNum, string appName) {
		string output = "";
		string SQL = "";
		string fam_id = cpfID + "_" + appID;
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
		
			SQL = "INSERT INTO cp_roi_ProdFamilies (ID, cpfID, cpfProdID, cpffamID, Web_Exists) VALUES (@ID, @cpfID, @PartNum, @famID, @web)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("ID", SqlDbType.NVarChar, 50).Value = fam_id;
				cmd.Parameters.Add("cpfID", SqlDbType.Int).Value = cpfID;
				cmd.Parameters.Add("PartNum", SqlDbType.NVarChar, 50).Value = PartNum;
				cmd.Parameters.Add("famID", SqlDbType.Int).Value = appID;
				cmd.Parameters.Add("web", SqlDbType.Char, 6).Value = "1";
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
				cmd.Connection.Close();
            }
		
		}
		
		return "<div id='aclose-" + fam_id+ "' class='products btn-sm'>" + appName + "<a class='remove-app close' onclick=\"javascript:delApp('" + fam_id + "', '" + appName +"')\">x</a></div>";
	}
	
	[WebMethod()]
	public static string addComp(int prodID, string PartNum, int caID, int conc, int unitID, string units) {
		string output = "";
		string SQL = "";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			SQL = "INSERT INTO certiProdComps (cpmpProdID, cpmpProd, cpmpAnalyteID, cpmpConc, cpmpUnits, tmpUnits, cpmpUnitId) VALUES (@cpmpProdID, @cpmpProd, @cpmpAnalyteID, @cpmpConc, @cpmpUnits, @tmpUnits, @cpmpUnitId)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("cpmpProdID", SqlDbType.Int).Value = prodID;
				cmd.Parameters.Add("cpmpProd", SqlDbType.NVarChar, 50).Value = PartNum;
				cmd.Parameters.Add("cpmpAnalyteID", SqlDbType.Int).Value = caID;
				cmd.Parameters.Add("cpmpConc", SqlDbType.Int).Value = conc;
				cmd.Parameters.Add("cpmpUnits", SqlDbType.NVarChar, 50).Value = unitID;
				cmd.Parameters.Add("tmpUnits", SqlDbType.NVarChar, 50).Value = units;
				cmd.Parameters.Add("cpmpUnitId", SqlDbType.NVarChar, 50).Value = unitID;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
				cmd.Connection.Close();
            }
			
			SQL = 	"SELECT  cpc.cpmpID, " + 
						"	 cp.cpPart, " +
						"	 cp.cpDescrip, " + 
						" 	 ca.caNameWeb, " +
						" 	 CAST(cpc.cpmpConc AS varchar(10)) AS cpmpConc, " +
						" 	 cu.cuUnit " +
						"FROM certiProdComps AS cpc " +
						"	 JOIN certiAnalytes AS ca ON cpc.cpmpAnalyteID = ca.caID " +
						"	 JOIN cp_roi_Prods AS cp ON cpc.cpmpProd = cp.cpPart " +
						"	 JOIN certiUnits AS cu ON cpc.cpmpUnits = cu.cuID " +
						"WHERE cpc.cpmpConc IS NOT NULL AND cpc.cpmpProd =  @PartNumber " + 
						"ORDER BY cpc.cpmpConc DESC, ca.caNameWeb";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("PartNumber", SqlDbType.NVarChar, 50).Value = PartNum;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				output += "<thead><tr><th>Component</th><th>Concentration</th><th>Actions</th></tr></thead><tbody>";
                while(dr.Read()) {
					output += "<tr id='Tr"+ dr["cpmpID"].ToString() +"'><td>" + dr["caNameWeb"].ToString() + "</td><td>" + dr["cpmpConc"].ToString() + " " + dr["cuUnit"].ToString() + "</td><td style='text-align:center'><a data-compid='" + dr["cpmpID"].ToString() + "' class='comp-del' title='Delete'><i class='fa fa-remove'></i></a></td></tr>";
                }
				output +="</tbody>";
				cmd.Connection.Close();
            }
		
		}
			
		return output;
	}
	
	[WebMethod()]
	public static string addComp2(int prodID, string PartNum, int compID, int conc, int unitID, string units, string casNum, string compVal) {
		string output = "";
		string SQL = "";
		int currCompID = compID;
		bool compExist = false;
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			
			SQL = "SELECT * FROM certiComps WHERE cmpID = @cmpID AND cmpCAS = @cmpCAS";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("cmpID", SqlDbType.Int).Value = compID;
				cmd.Parameters.Add("cmpCAS", SqlDbType.NVarChar, 50).Value = casNum;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if(dr.HasRows) {
					compExist = true;
				}
				cmd.Connection.Close();
            }
			
			if (compExist == false) {
				int newID = 0;
				SQL = "SELECT cmpID FROM certiComps ORDER BY cmpID DESC";
				using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
					cmd.CommandType = CommandType.Text;
					cmd.Connection.Open();
					SqlDataReader dr = cmd.ExecuteReader();
					if(dr.HasRows) {
						dr.Read();
						newID = Convert.ToInt32(dr["cmpID"]) + 1;
					}
					cmd.Connection.Close();
				}
				
				SQL = "INSERT INTO certiComps (cmpID, cmpCAS, cmpComp, cmpProlabCompId) VALUES (@cmpID, @cmpCAS, @cmpComp, @cmpID)";
				using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
					cmd.CommandType = CommandType.Text;
					cmd.Parameters.Add("cmpID", SqlDbType.Int).Value = newID;
					cmd.Parameters.Add("cmpCAS", SqlDbType.NVarChar, 50).Value = casNum;
					cmd.Parameters.Add("cmpComp", SqlDbType.NVarChar, 50).Value = compVal;
					cmd.Connection.Open();
					cmd.ExecuteNonQuery();
					cmd.Connection.Close();
				}
				
				currCompID = newID;
			}
			
			SQL = "INSERT INTO certiProdComps (cpmpProdID, cpmpProd, cpmpCompID, cpmpConc, cpmpUnits, tmpUnits, cpmpUnitId) VALUES (@cpmpProdID, @cpmpProd, @cpmpCompID, @cpmpConc, @cpmpUnits, @tmpUnits, @cpmpUnitId)";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("cpmpProdID", SqlDbType.Int).Value = prodID;
				cmd.Parameters.Add("cpmpProd", SqlDbType.NVarChar, 50).Value = PartNum;
				cmd.Parameters.Add("cpmpCompID", SqlDbType.Int).Value = currCompID;
				cmd.Parameters.Add("cpmpConc", SqlDbType.Int).Value = conc;
				cmd.Parameters.Add("cpmpUnits", SqlDbType.NVarChar, 50).Value = unitID;
				cmd.Parameters.Add("tmpUnits", SqlDbType.NVarChar, 50).Value = units;
				cmd.Parameters.Add("cpmpUnitId", SqlDbType.NVarChar, 50).Value = unitID;
				cmd.Connection.Open();
				cmd.ExecuteNonQuery();
				cmd.Connection.Close();
			}
				
			SQL = 	"SELECT cpc.cpmpID, " +
					"	CAST(cpc.cpmpConc AS varchar(10)) AS cpmpConc, " +
					"	cc.cmpComp, " +
					"	cu.cuUnit, " + 
					"	cc.cmpCAS AS CAS " +
					"FROM certiProdComps AS cpc " +
					"	JOIN certiComps AS cc ON cpc.cpmpCompID = cc.cmpID " +
					"	JOIN cp_roi_Prods AS cp ON cpc.cpmpProd = cp.cpPart " +
					"	JOIN certiUnits AS cu ON cpc.cpmpUnits = cu.cuID " +
					"WHERE cpc.cpmpConc IS NOT NULL AND cpc.cpmpProd = @PartNumber ORDER BY cpc.cpmpID DESC, cc.cmpComp";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("PartNumber", SqlDbType.NVarChar, 50).Value = PartNum;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				output += "<thead><tr><th>Component</th><th>CAS #</th><th>Concentration</th><th>Actions</th></tr></thead><tbody>";
                while(dr.Read()) {
					output += "<tr id='Tr"+ dr["cpmpID"].ToString() +"'><td>" + dr["cmpComp"].ToString() + "</td><td>" + dr["CAS"].ToString() + "</td><td>" + dr["cpmpConc"].ToString() + " " + dr["cuUnit"].ToString() + "</td><td style='text-align:center'><a data-compid2='" + dr["cpmpID"].ToString() + "' class='comp-del2' title='Delete'><i class='fa fa-remove'></i></a></td></tr>";
                }
				output +="</tbody>";
				cmd.Connection.Close();
            }
		
		}
			
		return output;
	}
	
	[WebMethod()]
	public static string deleteFam(string famID, string famName) {
		string SQL = "";
		string[] tokens = famID.Split(new[] { "_" }, StringSplitOptions.None);
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			SQL = "DELETE FROM cp_roi_ProdFamilies WHERE ID = @famID";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("famID", SqlDbType.NVarChar, 50).Value = famID;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
		}
		return "<option value='" + tokens[1] + "'>" + famName + "</option>";
	}
	
	[WebMethod()]
	public static string deleteCat(string catID, string catName) {
		string SQL = "";
		string[] tokens = catID.Split(new[] { "_" }, StringSplitOptions.None);
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			SQL = "DELETE FROM cp_roi_ProdFamilies WHERE ID = @catID";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("catID", SqlDbType.NVarChar, 50).Value = catID;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
		}
		return "<option value='" + tokens[1] + "'>" + catName + "</option>";
	}
	
	[WebMethod()]
	public static string deleteMeth(string metID, string metName) {
		string SQL = "";
		string[] tokens = metID.Split(new[] { "_" }, StringSplitOptions.None);
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			SQL = "DELETE FROM cp_roi_ProdMeths WHERE ID = @metID";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("metID", SqlDbType.NVarChar, 50).Value = metID;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
		}
		return "<option value='" + tokens[1] + "'>" + metName + "</option>";
	}
	
	[WebMethod()]
	public static string deleteTech(string techID, string techName) {
		string SQL = "";
		string[] tokens = techID.Split(new[] { "_" }, StringSplitOptions.None);
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			SQL = "DELETE FROM cp_roi_ProdATs WHERE ID = @techID";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("techID", SqlDbType.NVarChar, 50).Value = techID;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
		}
		return "<option value='" + tokens[1] + "'>" + techName + "</option>";
	}
	
	[WebMethod()]
	public static void deleteComp(int compID) {
		string SQL = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			SQL = "DELETE FROM [certiProdComps] WHERE cpmpID = @compID";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@compID", SqlDbType.Int).Value = compID;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
		}
	}
	
    protected void btnCancel_Click(object sender, EventArgs e) {
        Response.Redirect("/admin/products/");
    }
	
    protected void btnSave_Click(object sender, EventArgs e) {
		string prefix = DateTime.Now.ToString("MMdd-HHmmss-");
		string SQL = "";
		string PartNum = txtPartHid.Value.Trim();
		string PartNbr = txtPNbrHid.Value.Trim();
		string thumbnail_image = thumbImg;
		string main_image = mainImg;
	
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {			
			if (image_upload1.HasFile) { // Thumbnail Upload
				if(File.Exists(mapMethod("~/images/product_images/" + thumbnail_image))) {
					//File.Delete(mapMethod("~/images/product_images/" + thumbnail_image));
				}
				thumbnail_image = Path.GetFileName(image_upload1.PostedFile.FileName);
				thumbnail_image = prefix + thumbnail_image;
				image_upload1.PostedFile.SaveAs(Server.MapPath("~/images/product_images/") + thumbnail_image);
			}
			
			if (full_upload1.HasFile) { // Main Image Upload
				if(File.Exists(mapMethod("~/images/product_images/" + main_image))) {
					//File.Delete(mapMethod("~/images/product_images/" + main_image));
				}
				main_image = Path.GetFileName(image_upload1.PostedFile.FileName);
				main_image = prefix + main_image;
				image_upload1.PostedFile.SaveAs(Server.MapPath("~/images/product_images/") + main_image);
			}
			
			if (sds_upload.HasFile) { // SDS Upload
				if(File.Exists(mapMethod("~/msds/" + sds))) {
					File.Delete(mapMethod("~/msds/" + sds));
				}
				sds_upload.PostedFile.SaveAs(Server.MapPath("~/msds/") + PartNum + ".pdf");
				saveSDS(PartNum);
			}
			
            SQL = 	"UPDATE [cp_roi_Prods] " +
					"	SET [cpType] = @catID, " + 
					"		[cpDescrip] = @title, " +
					"		[cpLongDescrip] = @description, " +
					"		[Cpvol] = @volume, " +
					"		[cpUnitCnt] = @unitcnt, " +
					"		[cpMatrix] = @matrix, " +
					"		[cplongMatrix] = @longmatrix, " +
					"		[Prod_Notes] = @notes " +
					"	WHERE [cpID] = @ID";
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@ID", SqlDbType.Int).Value = iID;
				cmd.Parameters.Add("@catID", SqlDbType.Int).Value = ddlProdType.SelectedItem.Value;
				cmd.Parameters.Add("@title", SqlDbType.NVarChar, 50).Value = txtName.Text;
				cmd.Parameters.Add("@description", SqlDbType.Text).Value = txtDesc.Text;
				cmd.Parameters.Add("@volume", SqlDbType.Int).Value = ddlVolume.SelectedItem.Value;
				cmd.Parameters.Add("@unitcnt", SqlDbType.Int).Value = txtUnitsPerPack.Text;
				cmd.Parameters.Add("@matrix", SqlDbType.NVarChar, 6).Value = ddlMatrix.SelectedItem.Value;
				cmd.Parameters.Add("@longmatrix", SqlDbType.NVarChar, 50).Value = ddlMatrix.SelectedItem.Text;
				cmd.Parameters.Add("@notes", SqlDbType.NVarChar, 50).Value = txtProdNotes.Text;
                cmd.Connection.Open();
                try {
                    cmd.ExecuteNonQuery();
                } catch (Exception ex) {
                    Response.Write(ex);
                }
                cmd.Connection.Close();
            }
			
			if (checkProdDetails(iID) == true) {
				SQL = 	"UPDATE [cp_roi_ProdDetails] " +
						"	SET [cpdShipInf] = @ship, " + 
						"		[cpdStorage] = @store " +
						"	WHERE [cpdID] = @ID";
			}else {
				SQL =	"INSERT INTO [cp_roi_ProdDetails] (ID, cpdID, Part_Nbr, cpdShipInf, cpdStorage, Web_Exists) " +
						"	VALUES (@pnbr, @ID, @pnum, @ship, @store, '1')";
			}
			
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@ID", SqlDbType.Int).Value = iID;
				cmd.Parameters.Add("@ship", SqlDbType.Int).Value = ddlShipInfo.SelectedItem.Value;
				cmd.Parameters.Add("@store", SqlDbType.Int).Value = ddlStorage.SelectedItem.Value;
				cmd.Parameters.Add("@pnum", SqlDbType.NVarChar, 50).Value = PartNum;
				cmd.Parameters.Add("@pnbr", SqlDbType.NVarChar, 50).Value = PartNbr;
                cmd.Connection.Open();
                try {
                    cmd.ExecuteNonQuery();
                } catch (Exception ex) {
                    Response.Write(ex);
                }
                cmd.Connection.Close();
            }
        }
		
        Response.Write("<script>location.replace('/admin/products/edit.aspx?id=" + iID + "&success=1');</script>");
    }
	
	public void saveSDS(string part) {
		string SQLsave = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			string SQL = "SELECT PartNumber FROM certiMSDS WHERE PartNumber = @part";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("part", SqlDbType.NVarChar, 50).Value = part;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					SQLsave = "UPDATE certiMSDS SET FileName = @file WHERE PartNumber = @part";
				}else {
					SQLsave = "INSERT INTO certiMSDS (FileName, PartNumber) VALUES (@file, @part)";
				}
				cmd.Connection.Close();
            }
			
			using (SqlCommand cmd = new SqlCommand(SQLsave, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@part", SqlDbType.NVarChar, 50).Value = part;
				cmd.Parameters.Add("@file", SqlDbType.NVarChar, 50).Value = part + ".pdf";
                cmd.Connection.Open();
                try {
                    cmd.ExecuteNonQuery();
                } catch (Exception ex) {
                    Response.Write(ex);
                }
                cmd.Connection.Close();
            }
		}
	}
	
	public bool checkProdDetails(string cpID) {
		bool output = false;
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			string SQL = "SELECT * FROM cp_roi_ProdDetails WHERE cpdID = @cpID";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("cpID", SqlDbType.Int).Value = cpID;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					dr.Read();
					output = true;
				}
				cmd.Connection.Close();
            }
		}
		return output;
	}
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}