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

public partial class product_inorganic : System.Web.UI.Page
{
    protected string CurrencySymbol = "$";
    protected string PartNumber = "";
    protected string ProductID = "";
    protected string ProdTitle = "";
    protected string ProdDescription = "";
    protected string UnitsPerPack = "";
    protected string IsKit = "";
	protected string Notes = "";
    protected string Method = "";
	protected string MethodUL = "";
	protected string CASMeta = "";
    protected string Volume = "";
    protected string InStock = "";
    protected string Shipping = "";
    protected string Category = "";
    protected string Family = "";
    protected string Storage = "";
    protected string Matrix = "";
    protected string ThePriceText = "";
    protected string DiscountPriceText = "";
	protected string ImageURL = "";
	protected string ImageThumb = "";
	protected string ImageTitle = "";
	protected string ImageAltText = "";
	protected string ImageDesc = "";
	protected string prevPages = "";
	protected string Asterisk = "";
	protected string certiLCICPMS = "";

    protected string SEOText = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["part"] == null || Request.QueryString["part"].ToString().Length == 0) { Response.Redirect("/"); }

        if (Request.ServerVariables["HTTP_REFERER"] != null) {
            /*string Referrer = Request.ServerVariables["HTTP_REFERER"].ToString();
            if (Referrer.Contains("search") || Referrer.Contains("category")) {
                hlBackLink.Text = "&lt; Return to results";
                hlBackLink.NavigateUrl = Referrer;
            } else {
                hlBackLink.Text = "&lt; Back";
                hlBackLink.NavigateUrl = Referrer;
            }*/
        }
		
		if (Request.QueryString["part"].ToString().Contains("SPEC-DUAL") == true) { Asterisk = "*"; certiLCICPMS = "* Certified by LC-ICP-MS"; }

        clsUser myUser = new clsUser();
        CurrencySymbol = myUser.CurrencySymbol;
        string SQL = "";

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            SQL = "SELECT  prod.cpPart AS PartNumber, prod.cpID AS UniqueID, prod.cpDescrip as Title, prod.cpLongDescrip AS Description, " +
                         "       prod.cpUnitCnt AS UnitPack, prod.cpiskit as IsKit, " +
						 "       prod.Prod_Notes AS Notes, " +
                         "       cm.cmName AS Method, " +
                         "       cv.cpvVolume AS Volume, " +
                         "       'Yes' AS InStock, " +
                         "       si.csfinfo AS Shipping, " +
                         "       ccats.ccCategory AS Category, " +
                         "       cfam.cfFamily AS Family, " +
                         "       cs.csgStore AS Storage, " +
                         "       mat.T542_Short AS Matrix, " +
                         "       isnull(SEO.cpdSEOtext,'') AS cpdSEOtext " +
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
                         "   WHERE prod.cpType = '2' " +
                         "   AND prod.cpPart = @part";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@part", SqlDbType.VarChar).Value = Request.QueryString["part"].ToString();
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                if (dr.HasRows) {
                    dr.Read();
                    ProdTitle = dr["Title"].ToString();
                    PartNumber = dr["PartNumber"].ToString();
                    Method = dr["Method"].ToString();
                    Matrix = dr["Matrix"].ToString();
                    Volume = dr["Volume"].ToString();
                    UnitsPerPack = dr["UnitPack"].ToString();
                    Storage = dr["Storage"].ToString();
                    Shipping = dr["Shipping"].ToString();
                    ProdDescription = dr["Description"].ToString();
                    ProductID = dr["UniqueID"].ToString();
                    IsKit = dr["IsKit"].ToString().Trim();
                    InStock = dr["InStock"].ToString();
					Notes = dr["Notes"].ToString();
                    Category = dr["Category"].ToString();
                    Family = dr["Family"].ToString();

					SEOText = dr["cpdSEOtext"].ToString();

					if (SEOText.Length > 0) {
                        SEOText = "<h1>Additional Information</h1>" + SEOText + "<p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>";
					}
				} else {
					cmd.Connection.Close();
					Response.Redirect("product-not-found.aspx?part=" + Request.QueryString["part"].ToString());
				}
				Page.Title = ProdTitle + " - " + PartNumber + " - Inorganic Standards" + ConfigurationManager.AppSettings["gsDefaultPageTitle"];
                
				cmd.Connection.Close();

            }
						
			SQL = 	"SELECT TOP 4  t.Part AS PartNumber, t.Qty AS Quantity FROM (" +
						"SELECT woi.Item_Id COLLATE DATABASE_DEFAULT AS 'Part', SUM(woi.Item_Quantity) AS 'Qty' " +
						"FROM WebOrderItems woi WITH (NOLOCK) " +
							"INNER JOIN WebOrderItems woi2 WITH (NOLOCK) ON woi.Order_Number = woi2.Order_Number AND woi2.Item_Id = @part " +
						"WHERE woi.Item_id != @part " +
						"GROUP BY woi.Item_Id " +
					"UNION ALL " +
						"SELECT DISTINCT cpPart COLLATE DATABASE_DEFAULT, -1 " +
						"FROM cp_roi_Prods p WITH (NOLOCK) " +
							"INNER JOIN cp_roi_ProdCats pc WITH (NOLOCK) ON p.cpPart = pc.cpcProdId " +
							"AND pc.cpcCatId = (SELECT cpcCatId FROM cp_roi_ProdCats WITH (NOLOCK) WHERE cpcProdId = @part) " +
						"WHERE cpPart != @part " +
					") AS t " +
					"ORDER BY Qty DESC";

            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@part", SqlDbType.VarChar).Value = Request.QueryString["part"].ToString();
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					prevPages = "<span>Customers Also Viewed</span><br /><br /><ul>";
					while(dr.Read()) {
						string PartNumber2 = dr["PartNumber"].ToString();
						string Size2 = dr["Quantity"].ToString();
						
						if (getProductName(PartNumber2) != "Product Missing") {
							prevPages += 	"<li style='background: url(/images/" + getProdImage(PartNumber2) + ") no-repeat left top;background-size:50px;'>" +
											"<a class='prevViewed' data-partnum='" + PartNumber2 + "' data-prodtype='" + getProdType(PartNumber2) + "'>" + getProductName(PartNumber2) + "</a>" +
											"Volume: " + getProductVolume(PartNumber2) +
											"<br>Part #: " + PartNumber2 +
										"</li>";
							prevPages += 	"<li class='forslim' style='background: url(/images/" + getProdImage(PartNumber2) + ") no-repeat left top;background-size:50px;'>" +
												"<a data-partnum='" + PartNumber2 + "' data-prodtype='" + getProdType(PartNumber2) + "'>" + getProductName(PartNumber2) + "</a>" +
												"Volume: " + getProductVolume(PartNumber2) +
												"<br>Part #: " + PartNumber2 +
											"</li>";	
						}
						
					}
					prevPages += "<br style='clear:both'></ul>";
				}

				cmd.Connection.Close();
            }
			
			//Get the all methods descriptions associated with this product
            SQL = "SELECT m.cmSource + '  ' + m.cmName,  m.cmDesc " +
 	              "    FROM cp_roi_Prods p JOIN  cp_roi_ProdMeths pm ON p.cpPart = pm.cpmProdID " + 
                  "    INNER JOIN cp_roi_Methods m ON pm.cpmMethID = m.cmID " +
                  "    WHERE p.cpPart = @PartNumber " +
				  "    AND m.cmDesc is not null ORDER BY m.cmName";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@PartNumber", SqlDbType.VarChar).Value = Request.QueryString["part"].ToString();
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows) {

					  MethodUL = "<UL>";
                    while (dr.Read()) {
						Method += dr[0].ToString() + ", ";
		                MethodUL += "<LI><span>" + dr[0].ToString() + ":</span> <br>" + dr[1].ToString() + "</LI>";
                    }
					if (Method.Length > 2) { Method = Method.Substring(0, Method.Length - 2); }
                   MethodUL += "</UL>";
                }
                cmd.Connection.Close();
            } 

			if (MethodUL.Length > 0) {
				MethodUL = MethodUL + "";
			}
			
			
			//Get the all CAS# descriptions associated with this product
			SQL = "select cmpComp, cmpCAS " +
 	              "    from certiComps " +
 	              "    where cmpID in (select cpmpCompID from  certiProdComps where  cpmpProd = @PartNumber) " +
 	              "    order by cmpCAS ";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@PartNumber", SqlDbType.VarChar).Value = Request.QueryString["part"].ToString();
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows) {
					CASMeta = "";
                    while (dr.Read()) {
		               CASMeta += "CAS# " + dr[1].ToString() + ", ";
                    }
                    CASMeta = CASMeta.Substring(0, CASMeta.Length - 2);
                }
                cmd.Connection.Close();
            }
            clsItemPrice item = new clsItemPrice(Request.QueryString["part"].ToString(), myUser);
            ThePriceText = item.PriceText;
            DiscountPriceText = item.DiscountPriceText;

			Page.MetaDescription = "Certified Reference Materials: " + ProdTitle +" "+ PartNumber ; // + " - $" + ThePriceText + " / " + Volume + " (US Customers) ";

			//Get appropriate image
			SQL = "SELECT * FROM certiProdImages WHERE PartNumber = @PartNumber";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@PartNumber", SqlDbType.VarChar).Value = Request.QueryString["part"].ToString();
				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				if (dr.HasRows) {
					dr.Read();
					ImageURL = "product_images/" + dr["main_image"].ToString();
					ImageThumb = "product_images/" + dr["thumbnail_image"].ToString();
				} else {
					ImageThumb = ImageURL = "product_example.jpg";
				}
				cmd.Connection.Close();
			}
			
			SQL = "SELECT cpil.img, cpil.title, cpil.altText, cpil.description FROM certiProdImages AS cpi INNER JOIN certiProdImages_List AS cpil ON cpil.id = cpi.img_id WHERE cpi.PartNumber = @PartNumber";
			//SQL = "SELECT * FROM certiProdImages WHERE PartNumber = @PartNumber";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@PartNumber", SqlDbType.VarChar).Value = Request.QueryString["part"].ToString();
				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				if (dr.HasRows) {
					dr.Read();
					ImageURL = "/images/product_images/" + dr["img"].ToString();
					ImageThumb = getThumbnail(dr["img"].ToString());
					ImageTitle = dr["title"].ToString();
					ImageAltText = dr["altText"].ToString();
					ImageDesc = dr["description"].ToString();
				} else {
					ImageThumb = ImageURL = "/images/product_example.jpg";
					ImageTitle = ImageAltText = "Inorganic Product";
				}
				cmd.Connection.Close();
			}
        }
    }
	
	public string getThumbnail(string img) {
		string imgURL = img;
		//imgURL = img.Replace(".png", "-thumbnail.png");
		//imgURL = img.Replace(".jpg", "-thumbnail.png");
		
		if(File.Exists(mapMethod("~/images/product_images/" + imgURL))) {
			imgURL = "/images/product_images/" + imgURL;
		}else {
			imgURL = "/images/product_example.jpg";
		}
		return imgURL;
	}
	
	protected void cmdSubmit_Click(object sender, EventArgs e) {
		string currURL = Request.Url.AbsoluteUri;
		string email = emails.Text.Trim();
		string name = fullname.Text.Trim();
		string emailfrom = emailsfrom.Text.Trim();
		
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "INSERT INTO cp_Email_To_Colleague (product, reciever_email, sender, sender_email, datesend) VALUES ('" + PartNumber + "', '" + email + "', '" + name + "', '" + emailfrom + "', GETDATE())";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
        }
		
		StringBuilder sb = new StringBuilder();
		sb.AppendLine("<html><body>");
		sb.AppendLine("<div style='padding:30px 25px; border: 1px solid #b9b9b9;width:525px;'><a href='http://www.spexcertiprep.com/'><img src='http://www.spexcertiprep.com/images/certiprep_logo_new.png' alt='SPEX CertiPrep'></a>");
		sb.AppendLine("<table border='0' style='font-family:arial;font-size:100%'><tbody>");
        sb.AppendLine("<tr><td style='padding:10px 0;'>Hi there,</td></tr>");
        sb.AppendLine("<tr><td style='padding:10px 0' colspan='2'>A colleague of yours has recommended a SPEX CertiPrep product for you. Check it out at <a href='http://www.spexcertiprep.com/'>SPEX CertiPrep " + ProdTitle +"</a> or click the item below. </td></tr>");
        sb.AppendLine("<tr><td style='font-weight:bold;padding:10px'></td></tr>");
        sb.AppendLine("<tr><td style='vertical-align:top;width:38%'><a href='"+currURL+"'><img style='height:166px; width:166px' src='http://www.spexcertiprep.com/images/" + getProdImage(PartNumber) + "' /></a><br /><br /><a href='"+currURL+"'>" + ProdTitle + "</a></td><td><table border='0' style='width:100%;border-spacing:0; font-size:100%; border-collapse: collapse;'><tbody><tr><td colspan='2' style='background:#9EA515 url(http://dev.spexcertiprep.com/images/header-title-bg.png) repeat-x;color:#fff;font-weight:bold;font-size:16px;border:1px solid #d1d3d2;padding:10px'> Product Information</td></tr>");
			sb.AppendLine("<tr style='border:1px solid #d1d3d2;border-top:none;border-bottom:none'><td style='width:40%;padding:10px 20px;border-left:1px solid #d1d3d2;'>Part #:</td><td>" + PartNumber + "</td></tr>");
			sb.AppendLine("<tr style='border:1px solid #d1d3d2;border-top:none;border-bottom:none; background:#f2f2f2'><td style='width:40%;padding:10px 20px;border-left:1px solid #d1d3d2;'>Product Name:</td><td>" + ProdTitle + "</td></tr>");
			sb.AppendLine("<tr style='border:1px solid #d1d3d2;border-top:none;border-bottom:none;'><td style='width:40%;padding:10px 20px;border-left:1px solid #d1d3d2;'>Description:</td><td>" + ProdDescription + "</td></tr>");
			sb.AppendLine("<tr style='border:1px solid #d1d3d2;border-top:none;border-bottom:none; background:#f2f2f2'><td style='width:40%;padding:10px 20px;border-left:1px solid #d1d3d2;'>Matrix:</td><td>" + Matrix + "</td></tr>");
			sb.AppendLine("<tr style='border:1px solid #d1d3d2;border-top:none'><td style='padding:10px 20px;border-left:1px solid #d1d3d2;border-bottom:1px solid #d1d3d2;'>Volume:</td><td>" + Volume + "</td></tr>");
			
		sb.AppendLine("</tbody></table></td></tr>");
		sb.AppendLine("</tbody></table></div>");
        sb.AppendLine("</body></html>");
        string strBody = sb.ToString();
		
		MailMessage mm = new MailMessage();
        mm.Subject = "Product Recommendation";
        mm.To.Add(email);

        mm.From = new MailAddress("contact@spexcsp.com", name + " (SPEX CertiPrep)");
        mm.BodyEncoding = System.Text.Encoding.GetEncoding("utf-8");

        AlternateView plainView = AlternateView.CreateAlternateViewFromString(Regex.Replace(strBody, @"<(.|\n)*?>", string.Empty), System.Text.Encoding.GetEncoding("utf-8"), "text/plain");
        AlternateView htmlView = AlternateView.CreateAlternateViewFromString(strBody, System.Text.Encoding.GetEncoding("utf-8"), "text/html");
        mm.AlternateViews.Add(plainView);
        mm.AlternateViews.Add(htmlView);

        SmtpClient smtp = new SmtpClient();
		
        smtp.Send(mm);
		
		Response.Write("<script>alert('Product has been sent to your colleague!');location.replace('"+currURL+"')</script>");
	}
    protected string GetComponentCount(string partnumber) {
        string componentCount = "";

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT COUNT(*) FROM certiProdComps where cpmpProd = @partnumber";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@partnumber", SqlDbType.VarChar).Value = partnumber;
                cmd.Connection.Open();
                componentCount = cmd.ExecuteScalar().ToString();
                cmd.Connection.Close();
            }
        }

        return componentCount;
    }
	
	protected string getProdImage(string partnumber) {
        string ImageURL = "";

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT * FROM certiProdImages WHERE PartNumber = @PartNumber";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@PartNumber", SqlDbType.VarChar).Value = partnumber;
				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				if (dr.HasRows) {
					dr.Read();
					ImageURL = "product_images/" + dr["main_image"].ToString();
				} else {
					ImageURL = "product_images/InOrganicProducts.jpg";
				}
				cmd.Connection.Close();
			}
        }

        return ImageURL;
    }
	
	protected string getProductName(string partnumber) {
        string prodname = "";

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT cpLongDescrip FROM cp_roi_Prods WHERE cpPart = @PartNumber";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@PartNumber", SqlDbType.VarChar).Value = partnumber;
				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				if (dr.HasRows) {
					dr.Read();
					prodname = dr["cpLongDescrip"].ToString();
				} else {
					prodname = "Product Missing";
				}
				cmd.Connection.Close();
			}
        }
        return prodname;
    }
	
	protected string getProdType(string partnumber) {
        string type = "";

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT cpType FROM cp_roi_Prods WHERE cpPart = @PartNumber";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@PartNumber", SqlDbType.VarChar).Value = partnumber;
				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				if (dr.HasRows) {
					dr.Read();
					type = dr["cpType"].ToString();
				} else {
					type = "Product Missing";
				}
				cmd.Connection.Close();
			}
        }
        return type;
    }
	
	protected string getProductVolume(string partnumber) {
        string vol = "";

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT cv.cpvVolume AS Volume FROM cp_roi_Volumes AS cv INNER JOIN cp_roi_Prods AS cp ON cp.Cpvol = cv.cpvID WHERE cp.cpPart = @PartNumber";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@PartNumber", SqlDbType.VarChar).Value = partnumber;
				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				if (dr.HasRows) {
					dr.Read();
					vol = dr["Volume"].ToString();
				} else {
					vol = "";
				}
				cmd.Connection.Close();
			}
        }
        return vol;
    }
	
	[WebMethod()]
	public static string GetDataCAS(string partnumber)
	{
		string Concentration = "";
		string Component = "";
		string Unit = "";
		string CAS = "";
		string CAStable = "";
		string DescTable = "";
		string CasClass = "";
		int ctr = 0;
	
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
		string SQL = "SELECT CAST(cpc.cpmpConc AS varchar(10)) AS cpmpConc, " +
						"		cc.cmpComp, " +
						"		cu.cuUnit, " +
						"		cc.cmpCAS AS CAS " +
						"	FROM certiProdComps AS cpc JOIN certiComps AS cc ON cpc.cpmpCompID = cc.cmpID " + 
						"		JOIN cp_roi_Prods AS cp ON cpc.cpmpProd = cp.cpPart " + 
						"		JOIN certiUnits AS cu ON cpc.cpmpUnits = cu.cuID " +
						"	WHERE cpc.cpmpConc IS NOT NULL AND cpc.cpmpProd = @partnumber " +
						"	ORDER BY cpc.cpmpConc DESC, cc.cmpComp";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@partnumber", SqlDbType.VarChar).Value = partnumber;
                cmd.Connection.Open();
                //SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					CAStable = "<tbody>";
					while (dr.Read()) {
						ctr++;
						
						Concentration = dr["cpmpConc"].ToString();
						Component = dr["cmpComp"].ToString();
						Unit = dr["cuUnit"].ToString();
						CAS = dr["CAS"].ToString();
						
						CasClass = ctr%2 == 0 ? " " : "class='odd'";
						
						CAStable += "<tr "+ CasClass +">";
						CAStable += "<td class='desc'>" + Component + "</td>";
						CAStable += "<td class='desc'>" + CAS + "</td>";
						CAStable += "<td class='desc'>" + Concentration + " " + Unit + "</td>";
						CAStable += "</tr>";
                    }
					CAStable += "</tbody>";
				} 
				else {
					cmd.Connection.Close();
				}
				cmd.Connection.Close();
            }
					
			SQL = "SELECT  prod.cpPart AS PartNumber, prod.cpID AS UniqueID, prod.cpDescrip, prod.cpLongDescrip as Title, convert(text,cpd.cpdnotes) AS Description, " +
                         "       prod.cpUnitCnt AS UnitPack, prod.cpiskit as IsKit, " +
                         "       cv.cpvVolume AS Volume, " +
                         "       'Yes' AS InStock, " +
                         "       si.csfinfo AS Shipping, " +
                         "       antech.CatName AS Technique, " +
                         "       cfam.cfFamily AS Family, " +
                         "       cs.csgStore AS Storage, " +
                         "       mat.T542_Short AS Matrix, " +
                         "       isnull(SEO.cpdSEOtext,'') AS cpdSEOtext " +
                         "   FROM cp_roi_Prods AS prod LEFT JOIN cp_roi_Matrix AS mat ON mat.T542_Code = prod.cpMatrix " +
                         "       LEFT JOIN cp_roi_Volumes AS cv ON prod.Cpvol = cv.cpvID " +
                         "       LEFT JOIN cp_roi_ProdATs AS cpats ON cpats.cpatID = prod.cpID " +
                         "       LEFT JOIN cp_roi_ProdCats AS cats ON cats.cpcID = prod.cpID " + 
                         "       LEFT JOIN cp_roi_ProdFamilies AS cpf ON prod.cpID = cpf.cpfID " +
                         "       LEFT JOIN cp_roi_Families AS cfam ON cpf.cpffamID = cfam.cfID " +
                         "       LEFT JOIN cp_roi_AnTechs AS antech ON cpats.cpatATID = antech.CatID " +
                         "       LEFT JOIN cp_roi_ProdDetails AS cpd ON cpd.cpdID = prod.cpID " +
                         "       LEFT JOIN cp_roi_ShipInfo AS si ON si.csfID = cpd.cpdShipInf " +
                         "       LEFT JOIN cp_roi_Storage AS cs ON cs.csgID = cpd.cpdStorage " +
                         "       LEFT JOIN cp_roi_ProdDetails_SEOText as SEO ON SEO.Part_Nbr = prod.cpPart " +
                         "   WHERE prod.cpType = '1' AND prod.For_web = 'Y' " +
                         "   AND prod.cpPart = @part";

            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@part", SqlDbType.VarChar).Value = partnumber;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				if (dr.HasRows) {
					dr.Read();
					string PartNumber3 = dr["PartNumber"].ToString();
					string ProductID3 = dr["UniqueID"].ToString();
					string ProdTitle3 = dr["Title"].ToString();
					string ProdDescription3 = dr["Description"].ToString();
					string UnitsPerPack3 = dr["UnitPack"].ToString();
					string IsKit3 = dr["IsKit"].ToString().Trim();
					string Volume3 = dr["Volume"].ToString();
					string InStock3 = dr["InStock"].ToString();
					string Shipping3 = dr["Shipping"].ToString();
					string Family3 = dr["Family"].ToString();
					string Storage3 = dr["Storage"].ToString();
					string Matrix3 = dr["Matrix"].ToString();
					string CurrencySymbol = "$";
					clsUser myUser = new clsUser();
					CurrencySymbol = myUser.CurrencySymbol;
					clsItemPrice item = new clsItemPrice(partnumber, myUser);
					string ThePriceText = item.PriceText;
					string DiscountPriceText = item.DiscountPriceText;	
					DescTable = "<table id='productdata_table2' style='float:none; width:100%'>" +
								"	<thead>"+
								"		<tr class='odd'>"+
								"			<th scope='col'>Part #</th>"+
								"			<th scope='col'>Product Name</th>"+
								"			<th scope='col'>Description</th>"+
								"			<th scope='col'>Matrix </th>"+
								"			<th scope='col'>Volume</th>"+
								"			<th scope='col'>Price</th>"+
								"		</tr>"+
								"	</thead> "+ 
								"	<tbody>"+
								"		<tr class='odd'>"+
								"			<td>" + PartNumber3 + "</td>"+
								"			<td>" + ProdTitle3 + "</td>"+
								"			<td>" + ProdDescription3 + "</td>"+
								"			<td>" + Matrix3 + "</td>"+
								"			<td>" + Volume3 + "</td>"+
								"			<td class='price'>" + DiscountPriceText + "</td>"+
								"		</tr>"+
								"	</tbody> "+
								"	</table>";
				}
			}
			
			CAStable = "<table id='productdata_table2'>"+
					"	<thead>"+
					"		<tr class='odd'>"+
					"			<th scope='col'>Components</th>"+
					"			<th scope='col'>CAS#</th>"+
					"			<th scope='col'>Concentration</th>"+
					"		</tr>"+
					"	</thead> "+ 
							CAStable + 
					"	</table>";
			CAStable += "<script>" +
						"$(document).ready(function() {" +
							"$('.addtocart_button3').click(function () {" +
								"theQuantity = document.getElementById('select_quantity3').value;" +
								"if(theQuantity == '' || theQuantity == '0' ) {" +
									"alert('Quantity must be greater than 0');" +
									"return false;" +
								"}" +
								"$('.float-footer').css('display', 'block');" +
								"$('#footer_cart').load('/utility/addtocart.aspx?productid=" + partnumber + "&pq=' + theQuantity);" +
								"$('.addtocart_button3').html('In Cart');" +
								"$('#totalitems').effect('highlight', { color: '#ffffff' }, 5000);" +
								"$('#totalcost').effect('highlight', { color: '#ffffff' }, 5000);" +
								"$('#totalsavings').effect('highlight', { color: '#ffffff' }, 5000);" +
								"$('#SPoints').effect('highlight', { color: '#ffffff' }, 5000);" +
							"});" +
							"$('#dropQty').click(function() {" +
								"$('#qb3').slideDown('fast');" +
								"$('#qb3').attr('tabindex',-1).focus();" +
							"});" +
							"$('.quantity_box_list').focusout(function() {" +
								"$(this).css('display', 'none');" +
							"});" +
							"$('.quantity_box_list li').click(function() {" +
								"var par = $(this).parent().attr('id');" +
								"$('.quantitybox.' + par).val($(this).text());" +
								"$(this).parent().css('display', 'none');" +
							"});" +
							"$('.quantitybox').keydown(function (e) {" +
								"if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 || (e.keyCode == 65 && ( e.ctrlKey === true || e.metaKey === true ) ) || (e.keyCode >= 35 && e.keyCode <= 40)) { " +
									"return; " +
								"}" +
								"if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {" +
									"e.preventDefault();" +
								"}" +
							"});" +
						"});</script>";
						
			CAStable += "<div id='product_orderbox' style='padding:0;margin:0;float:right'>" +
				"<div id='quantity_box'>" +
					"<div class='quantity_label'><span style='color:#000'>Quantity:</span></div>" + 
					"<div class='quantity_field'>" + 
						"<input type='text' name='quantity' id='select_quantity3' value='1' size='2' class='quantitybox qb3' onchange='checkNumber();' />" +
						"<img class='quantity_arrow' src='/images/arrow-down.png' id='dropQty' />" +
						"<ul id='qb3' class='quantity_box_list'>" +
							"<li>1</li>" +
							"<li>2</li>" +
							"<li>3</li>" +
							"<li>4</li>" +
							"<li>5</li>" +
							"<li>6</li>" +
							"<li>7</li>" +
							"<li>8</li>" +
							"<li>9</li>" +
							"<li>10</li>" +
							"<li>15</li>" +
							"<li>20</li>" +
							"<li>25</li>" +
						"</ul>" +
					"</div>" +
				"</div>" +
                "<div id='addtocart_button' class='addtocart_button3'>" +
                    "Add To Cart" +
                "</div>" +
            "</div>";
		}
		return DescTable + CAStable;
	}
	
	[WebMethod()]
	public static string GetProduct(string partnumber)
	{
		string Concentration = "";
		string Component = "";
		string Unit = "";
		string CAS = "";
		string CAStable = "";
		string fullCAStable = "";
		string DescTable = "";
		string CasClass = "";
		string ImageURL = "";
		int ctr = 0;
	
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT * FROM certiProdImages WHERE PartNumber = @PartNumber";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@PartNumber", SqlDbType.VarChar).Value = partnumber;
				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				if (dr.HasRows) {
					dr.Read();
					ImageURL = "product_images/" + dr["main_image"].ToString();
				} else {
					ImageURL = "product_images/InOrganicProducts.jpg";
				}
				cmd.Connection.Close();
			}
			      
			SQL = "SELECT  cp.cpPart, cp.cpDescrip, " +
						"		ca.caNameWeb, " +
						"		CAST(cpc.cpmpConc AS varchar(10)) AS cpmpConc, " +
						"		cu.cuUnit  " +
						"	FROM certiProdComps AS cpc JOIN certiAnalytes AS ca ON cpc.cpmpAnalyteID = ca.caID " + 
						"		JOIN cp_roi_Prods AS cp ON cpc.cpmpProd = cp.cpPart " + 
						"		JOIN certiUnits AS cu ON cpc.cpmpUnits = cu.cuID " +
						"	WHERE cpc.cpmpConc IS NOT NULL AND cpc.cpmpProd =  @partnumber " +
						"	ORDER BY cpc.cpmpConc DESC, ca.caNameWeb";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@partnumber", SqlDbType.VarChar).Value = partnumber;
                cmd.Connection.Open();
                //SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					CAStable = "";
					fullCAStable = "<tbody>";
					while (dr.Read()) {
						ctr++;
						
						Concentration = dr["cpmpConc"].ToString();
						Component = dr["caNameWeb"].ToString();
						Unit = dr["cuUnit"].ToString();
						
						CasClass = ctr%2 == 0 ? " " : "class='odd'";
						CAStable += "<table class='miniTbl'>";
						CAStable += "<tr><td class='greenHead' style='width:40%'>Component:</td><td style='width:60%'>" + Component + "</td></tr>";
						CAStable += "<tr><td class='greenHead'>Concentration:</td><td class='desc'>" + Concentration + " " + Unit + "</td>";
						CAStable += "</tr>";
						CAStable += "</table>";
						
						fullCAStable += "<tr "+ CasClass +">";
						fullCAStable += "<td class='desc'>" + Component + "</td>";
						fullCAStable += "<td class='desc'>" + Concentration + " " + Unit + "</td>";
						fullCAStable += "</tr>";
                    }
					fullCAStable += "</tbody>";
				} 
				else {
					cmd.Connection.Close();
				}
				cmd.Connection.Close();
            }
					
			SQL = "SELECT  prod.cpPart AS PartNumber, prod.cpID AS UniqueID, prod.cpDescrip, prod.cpLongDescrip as Title, convert(text,cpd.cpdnotes) AS Description, " +
                         "       prod.cpUnitCnt AS UnitPack, prod.cpiskit as IsKit, " +
                         "       cv.cpvVolume AS Volume, " +
                         "       'Yes' AS InStock, " +
                         "       si.csfinfo AS Shipping, " +
                         "       antech.CatName AS Technique, " +
                         "       cfam.cfFamily AS Family, " +
                         "       cs.csgStore AS Storage, " +
                         "       mat.T542_Short AS Matrix, " +
                         "       isnull(SEO.cpdSEOtext,'') AS cpdSEOtext " +
                         "   FROM cp_roi_Prods AS prod LEFT JOIN cp_roi_Matrix AS mat ON mat.T542_Code = prod.cpMatrix " +
                         "       LEFT JOIN cp_roi_Volumes AS cv ON prod.Cpvol = cv.cpvID " +
                         "       LEFT JOIN cp_roi_ProdATs AS cpats ON cpats.cpatID = prod.cpID " +
                         "       LEFT JOIN cp_roi_ProdCats AS cats ON cats.cpcID = prod.cpID " + 
                         "       LEFT JOIN cp_roi_ProdFamilies AS cpf ON prod.cpID = cpf.cpfID " +
                         "       LEFT JOIN cp_roi_Families AS cfam ON cpf.cpffamID = cfam.cfID " +
                         "       LEFT JOIN cp_roi_AnTechs AS antech ON cpats.cpatATID = antech.CatID " +
                         "       LEFT JOIN cp_roi_ProdDetails AS cpd ON cpd.cpdID = prod.cpID " +
                         "       LEFT JOIN cp_roi_ShipInfo AS si ON si.csfID = cpd.cpdShipInf " +
                         "       LEFT JOIN cp_roi_Storage AS cs ON cs.csgID = cpd.cpdStorage " +
                         "       LEFT JOIN cp_roi_ProdDetails_SEOText as SEO ON SEO.Part_Nbr = prod.cpPart " +
                         "   WHERE prod.cpType = '2' AND prod.For_web = 'Y' " +
                         "   AND prod.cpPart = @part";

            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@part", SqlDbType.VarChar).Value = partnumber;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				//if (dr.HasRows) {
					dr.Read();
					string PartNumber3 = dr["PartNumber"].ToString();
					string ProductID3 = dr["UniqueID"].ToString();
					string ProdTitle3 = dr["Title"].ToString();
					string ProdDescription3 = dr["Description"].ToString();
					string UnitsPerPack3 = dr["UnitPack"].ToString();
					string IsKit3 = dr["IsKit"].ToString().Trim();
					string Volume3 = dr["Volume"].ToString();
					string InStock3 = dr["InStock"].ToString();
					string Shipping3 = dr["Shipping"].ToString();
					string Family3 = dr["Family"].ToString();
					string Storage3 = dr["Storage"].ToString();
					string Matrix3 = dr["Matrix"].ToString();
					string CurrencySymbol = "$";
					clsUser myUser = new clsUser();
					CurrencySymbol = myUser.CurrencySymbol;
					clsItemPrice item = new clsItemPrice(partnumber, myUser);
					string ThePriceText = item.PriceText;
					string DiscountPriceText = item.DiscountPriceText;	
					DescTable = "<p class='popUpTitle'>" + ProdTitle3 + "</p>" +
								"<div class='leftSide'>" +
									"<div id='product_image' class='floatProdImg'>" +
										"<img src='/images/" + ImageURL +"' alt='Product Image' />" +
									"</div>" +
									"<div style='clear:both'></div>" +
								"</div>" +
								"<div id='product_topright' class='rightSide'>" +
									"<div id='product_prices'>" +
										"In Stock: <span style='margin-left:6.3em'>" + InStock3 + "</span><br>" +
										"Retail Price: <span class='price' style='margin-left:5em'>" + ThePriceText + "</span><br>";
					if (HttpContext.Current.Session["userid"] != null) {
						DescTable +=		"Discounted Price: <span class='price' style='margin-left:2.4em'>"+ DiscountPriceText +"</span>";
					}
					DescTable +=	"</div>" +
									"<div id='product_orderbox'>" +
										"<div id='quantity_box'>" +
											"<div class='quantity_label'>Quantity:</div>" + 
											"<div class='quantity_field'>" + 
												"<input type='text' name='quantity' id='select_quantity4' value='1' size='2' class='quantitybox qb4' onchange='checkNumber();'>" +
												"<img class='quantity_arrow' src='/images/arrow-down.png' id='dropQty2'>" +
												"<ul id='qb4' class='quantity_box_list'>" +
													"<li>1</li><li>2</li><li>3</li><li>4</li><li>5</li><li>6</li><li>7</li><li>8</li><li>9</li><li>10</li><li>15</li><li>20</li><li>25</li>" +
												"</ul>" +
											"</div>" +
										"</div>" +
										"<div id='addtocart_button' class='addtocart_button4' style='width:50%;background-size:contain;margin-top:6px'>" +
											"Add To Cart" +
										"</div><div style='clear:both'></div>" +
									"</div>" +
									"<div id='product_payment'>" +
										"<p style='margin-top:4px;font-size:13px;'>Or call 1-800-LAB-SPEX</p>" +
										"<img src='/images/payment.png' alt='Payment' style='width:107px'>" +
									"</div>" +
								"</div>";
					fullCAStable = "<div class='fullCasHeader rightSide'><table id='productdata_table2' class='fullTable' style='margin:0'>"+
								"	<thead>"+
								"		<tr class='odd'>"+
								"			<th scope='col'>Components</th>"+
								"			<th scope='col'>Conc.</th>"+
								"		</tr>"+
								"	</thead></table></div><div id='fullCas' class='rightSide'><table id='productdata_table2' class='fullTable'>"+ 
										fullCAStable + 
								"	</table></div>";
					
					DescTable += "<div class='leftSide'><table id='productdata_table2' class='prodDataTable' style='width:100%'>" +
									"<thead><tr><th scope='col' colspan='2'>Product Information</th></tr></thead>" +
									"<tbody><tr>" +
										"<td style='width:48%'>Part #:</td><td style='width:52%'><span class='shade'>" + PartNumber3 +"</span></td>" +
									"</tr>" +
									"<tr style='background:#f2f2f2'>" +
										"<td>Matrix:</td><td><span class='shade'>" + Matrix3 + "</span></td>" +
									"</tr>" +
									"<tr>" +
										"<td>Volume:</td><td><span class='shade'>" + Volume3 + "</span></td>" +
									"</tr>" +
									"<tr style='background:#f2f2f2'>" +
										"<td>Units/Pack:</td><td><span class='shade'>" + UnitsPerPack3 + "</span></td>" +
									"</tr>" +
									"<tr>" +
										"<td>In Stock:</td><td><span class='shade'>" + InStock3 + "</span></td>" +
									"</tr>" +
									"<tr style='background:#f2f2f2'>" +
										"<td>Storage Condition:</td><td><span class='shade'>" + Storage3 + "</span></td>" +
									"</tr>" +
									"<tr>" +
										"<td>Shipping Info:</td><td><span class='shade'>" + Shipping3 + "</span></td>" +
									"</tr>" +
									"<tr style='background:#f2f2f2'>" +
										"<td>Method Reference:</td><td><span class='shade'>EPA  524.2, EPA  624, EPA  8260B</span></td>" +
									"</tr>" +
									getSDS(PartNumber3) +
									"</tbody>" +
								"</table></div>";
				//}
			}
			
			CAStable = 	"<div class='casSec rightSide'>" +
								CAStable + 
						"</div>";
			CAStable += "<script>" +
						"$(document).ready(function() {" +
							"$('.addtocart_button3').click(function () {" +
								"theQuantity = document.getElementById('select_quantity3').value;" +
								"callAddToCart(theQuantity);" +
							"});" +
							"$('.addtocart_button4').click(function () {" +
								"theQuantity = document.getElementById('select_quantity4').value;" +
								"callAddToCart(theQuantity);" +
							"});" +
							"function callAddToCart(theQuantity) {" +
								"if(theQuantity == '' || theQuantity == '0' ) {" +
									"alert('Quantity must be greater than 0');" +
									"return false;" +
								"}" +
								"$('.float-footer').css('display', 'block');" +
								"$('#footer_cart').load('/utility/addtocart.aspx?productid=" + partnumber + "&pq=' + theQuantity);" +
								"$('.addtocart_button3').html('In Cart');" +
								"$('#totalitems').effect('highlight', { color: '#ffffff' }, 5000);" +
								"$('#totalcost').effect('highlight', { color: '#ffffff' }, 5000);" +
								"$('#totalsavings').effect('highlight', { color: '#ffffff' }, 5000);" +
								"$('#SPoints').effect('highlight', { color: '#ffffff' }, 5000);" +
							"}" +
							"$('#dropQty').click(function() {" +
								"$('#qb3').slideDown('fast');" +
								"$('#qb3').attr('tabindex',-1).focus();" +
							"});" +
							"$('#dropQty2').click(function() {" +
								"$('#qb4').slideDown('fast');" +
								"$('#qb4').attr('tabindex',-1).focus();" +
							"});" +
							"$('.quantity_box_list').focusout(function() {" +
								"$(this).css('display', 'none');" +
							"});" +
							"$('.quantity_box_list li').click(function() {" +
								"var par = $(this).parent().attr('id');" +
								"$('.quantitybox.' + par).val($(this).text());" +
								"$(this).parent().css('display', 'none');" +
							"});" +
							"$('.quantitybox').keydown(function (e) {" +
								"if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 || (e.keyCode == 65 && ( e.ctrlKey === true || e.metaKey === true ) ) || (e.keyCode >= 35 && e.keyCode <= 40)) { " +
									"return; " +
								"}" +
								"if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {" +
									"e.preventDefault();" +
								"}" +
							"});" +
						"});</script>";
						
			CAStable += "<div id='product_orderbox' style='padding:0;margin:0;float:right'>" +
				"<div id='quantity_box'>" +
					"<div class='quantity_label'><span style='color:#000;font-size:13px;'>Quantity:</span></div>" + 
					"<div class='quantity_field'>" + 
						"<input type='text' name='quantity' id='select_quantity3' value='1' size='2' class='quantitybox qb3' onchange='checkNumber();' />" +
						"<img class='quantity_arrow' src='/images/arrow-down.png' id='dropQty' />" +
						"<ul id='qb3' class='quantity_box_list'>" +
							"<li>1</li>" +
							"<li>2</li>" +
							"<li>3</li>" +
							"<li>4</li>" +
							"<li>5</li>" +
							"<li>6</li>" +
							"<li>7</li>" +
							"<li>8</li>" +
							"<li>9</li>" +
							"<li>10</li>" +
							"<li>15</li>" +
							"<li>20</li>" +
							"<li>25</li>" +
						"</ul>" +
					"</div>" +
				"</div>" +
                "<div id='addtocart_button' class='addtocart_button3'>" +
                    "Add To Cart" +
                "</div><div style='clear:both'></div>" +
            "</div>";
		}
		return DescTable + fullCAStable + CAStable ;
	}
	
	public static string getSDS(string part) {
		string SDS = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT FileName FROM certiMSDS WHERE PartNumber = @PartNumber";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@PartNumber", SqlDbType.VarChar).Value = part;
				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				if (dr.HasRows) {
					dr.Read();
					SDS = "<tr>" +
							"<td>Product Notes:<br /><br /><img src='/images/bullet-pdf-ico.png'/> <a target='_blank' href='/MSDS/" + dr["FileName"].ToString() +"'>SDS</a></td><td></td>" +
						"</tr>";
				}
				cmd.Connection.Close();
			}
		}
		return SDS;
	}
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}