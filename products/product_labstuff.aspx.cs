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

public partial class product_labstuff : System.Web.UI.Page
{
    protected string CurrencySymbol = "$";
    protected string PartNumber = "";
    protected string ProductID = "";
    protected string ProdTitle = "";
    protected string ProdDescription = "";
    protected string UnitsPerPack = "";
    protected string IsKit = "";
    protected string Method = "";
    protected string Volume = "";
    protected string InStock = "";
    protected string Shipping = "";
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

    protected string SEOText = "";
	protected string demo_video = "";
	protected string additional_info = "";
	protected string product_features = "";
	protected string related_products = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["part"] == null || Request.QueryString["part"].ToString().Length == 0) { Response.Redirect("/search_labstuff.aspx"); }

        if (Request.ServerVariables["HTTP_REFERER"] != null) {
            string Referrer = Request.ServerVariables["HTTP_REFERER"].ToString();
            
        }

        clsUser myUser = new clsUser();
        CurrencySymbol = myUser.CurrencySymbol;
        string SQL = "";

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            SQL = "SELECT  prod.cpPart AS PartNumber, prod.cpID AS UniqueID, prod.cpDescrip as Title, prod.cpLongDescrip AS Description, " +
                         "       prod.cpUnitCnt AS UnitPack, " +
                         "       cm.cmName AS Method, " +
                         "       'Yes' AS InStock, " +
                         "       si.csfinfo AS Shipping, " +
                         "       cs.csgStore AS Storage, " +
                         "       isnull(SEO.cpdSEOtext,'') AS cpdSEOtext " +
						 "   FROM cp_roi_Prods AS prod LEFT JOIN cp_roi_ProdMeths AS pm ON pm.cpmProdID = prod.cpPart " +
                         "       LEFT JOIN cp_roi_Methods AS cm ON pm.cpmMethID = cm.cmID " +
                         "       LEFT JOIN cp_roi_ProdDetails AS cpd ON cpd.cpdID = prod.cpID " +
                         "       LEFT JOIN cp_roi_ShipInfo AS si ON si.csfID = cpd.cpdShipInf " +
                         "       LEFT JOIN cp_roi_Storage AS cs ON cs.csgID = cpd.cpdStorage " +
                         "       LEFT JOIN cp_roi_ProdDetails_SEOText as SEO ON SEO.Part_Nbr = prod.cpPart " +
                         "   WHERE prod.cpType = '6' " +
                         "   AND prod.cpPart = @part";

            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@part", SqlDbType.VarChar).Value = Request.QueryString["part"].ToString();
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                if (dr.HasRows) {
                    dr.Read();
                    PartNumber = dr["PartNumber"].ToString();
                    Method = dr["Method"].ToString();
                    UnitsPerPack = dr["UnitPack"].ToString();
                    InStock = dr["InStock"].ToString();
                    Storage = dr["Storage"].ToString();
                    Shipping = dr["Shipping"].ToString();
                    ProdDescription = dr["Description"].ToString();
                    ProdTitle = dr["Title"].ToString();
                    ProductID = dr["UniqueID"].ToString();

					SEOText = dr["cpdSEOtext"].ToString();

					if (SEOText.Length > 0) {
						SEOText = "<h1>Additional Information</h1>" + SEOText + "<p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>";
						//video = SEOText.Substring(SEOText.IndexOf("<b>"),SEOText.IndexOf("<b>Demonstration Video</b>"));
						if (SEOText.IndexOf("SPEX CertiPrep meets your QuEChERS") > 0) {
							additional_info = SEOText.Substring(SEOText.IndexOf("<h1>"),SEOText.IndexOf("</p>"));
							product_features = "";
						}
						else {
							additional_info = SEOText.Substring(SEOText.IndexOf("<h1>"),SEOText.IndexOf("<b>Product Features</b>"));
							product_features = SEOText.Substring(SEOText.IndexOf("<b>Product Features</b>"),SEOText.IndexOf("<b>Related Products</b>") - SEOText.IndexOf("<b>Product"));
							related_products = SEOText.Substring(SEOText.IndexOf("<b>Related Products</b>"),SEOText.IndexOf("<b>Demonstration Video</b>") - SEOText.IndexOf("<b>Related Products</b>"));
							demo_video = SEOText.Substring(SEOText.IndexOf("<b>Demonstration Video</b>"),SEOText.IndexOf("<p>&nbsp;</p><p>&nbsp;</p>") - SEOText.IndexOf("<b>Demonstration Video</b>"));
						}
					}
				} else {
					cmd.Connection.Close();
					Response.Redirect("product_labstuff.aspx");
				}

				Page.Title = ProdTitle + " - " + PartNumber + " - Lab Stuff " + ConfigurationManager.AppSettings["gsDefaultPageTitle"];

                cmd.Connection.Close();
            }

			if (Method.Length > 0) {
				Method = " - Methods: " + Method;
			}

			Page.MetaDescription = "Certified Reference Materials: "  + ProdTitle  + Method ;

            //Get appropriate image
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

            clsItemPrice item = new clsItemPrice(Request.QueryString["part"].ToString(), myUser);
            ThePriceText = item.PriceText;
            DiscountPriceText = item.DiscountPriceText;
        }
    }
	
	public string getThumbnail(string img) {
		string imgURL = "";
		imgURL = img.Replace(".png", "-thumbnail.png");
		imgURL = img.Replace(".jpg", "-thumbnail.png");
		
		if(File.Exists(mapMethod("~/images/product_images/" + imgURL))) {
			imgURL = "/images/product_images/" + imgURL;
		}else {
			imgURL = "/images/product_example.jpg";
		}
		return imgURL;
	}
	
	public string getProdFylers() {
		string output="";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT * FROM cp_prodManual WHERE partNum = @partNum";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@partNum", SqlDbType.VarChar).Value = Request.QueryString["part"].ToString();
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows) {
                    while(dr.Read()) {
						output += "<li class='pdf_dl'><a href='/knowledge-base/catalogs/" + dr["prodManual"].ToString() + "' target='_blank'>" + dr["title"].ToString() + "</a></li>";
					}
                }
                cmd.Connection.Close();
            }
        }
		return output;
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
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}