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
using System.Text.RegularExpressions;

public partial class search : System.Web.UI.Page
{
    protected string SearchTerm = "";
    protected string SearchTermEnc = "";
    protected int EquipTypeCount = 0;
    protected int AccessoryCount = 0;
    protected int ProdResCnt = 0;
    protected int FaqCount = 0;

    protected string Region = "US";
    protected string CurrencySymbol = "$";
    protected string CatCode = "1";
    protected clsUser myUser;

	protected string txtMessage = "";

    protected void Page_Load(object sender, EventArgs e) {
        myUser = new clsUser();
        Region = myUser.Region;
        CurrencySymbol = myUser.CurrencySymbol;
        CatCode = myUser.DiscountCode;

        if (!Page.IsPostBack) {
            string SQL = 	"SELECT DISTINCT cp.cpPart AS PartNumber, cp.cpDescrip AS Title, cv.cpvVolume AS Volume " +
							"FROM  cp_roi_Prods cp INNER JOIN cp_roi_Volumes AS cv ON cp.Cpvol = cv.cpvID " +
							"WHERE cp.cpPart IN ('182002','183134') " +
							"AND cp.For_Web = 'Y' ORDER BY cp.cpPart";

            dataProducts.SelectCommand = SQL;
            dataProducts.DataBind();
        }
    }
    protected void cmdSubmit_Click(object sender, EventArgs e) {
		string currURL = Request.Url.AbsoluteUri;
		string email = emails.Text.Trim();
		
		StringBuilder sb = new StringBuilder();
		sb.AppendLine("<html><body>");
		sb.AppendLine("<div style='padding:30px 25px; border: 1px solid #b9b9b9;width:525px;'><a href='http://www.spexcertiprep.com/'><img src='http://www.spexcertiprep.com/images/certiprep_logo_new.png' alt='SPEX CertiPrep'></a>");
		sb.AppendLine("<table border='0' style='font-family:arial;font-size:100%'><tbody>");
        sb.AppendLine("<tr><td style='padding:10px 0;'>Hi there,</td></tr>");
        sb.AppendLine("<tr><td style='padding:10px 0' colspan='2'>A colleague of yours has recommended a SPEX CertiPrep product for you. Check it out at <a href='http://www.spexcertiprep.com/'>SPEX CertiPrep " +"</a> or click the item below. </td></tr>");
        sb.AppendLine("<tr><td style='font-weight:bold;padding:10px'></td></tr>");
        sb.AppendLine("<tr><td style='vertical-align:top;width:38%'><a href='"+currURL+"'><img style='height:166px; width:166px' src='http://www.spexcertiprep.com/images/"  + "' /></a><br /><br /><a href='"+currURL+"'>"  + "</a></td><td><table border='0' style='width:100%;border-spacing:0; font-size:100%; border-collapse: collapse;'><tbody><tr><td colspan='2' style='background:#9EA515 url(http://dev.spexcertiprep.com/images/header-title-bg.png) repeat-x;color:#fff;font-weight:bold;font-size:16px;border:1px solid #d1d3d2;padding:10px'> Product Information</td></tr>");
			sb.AppendLine("<tr style='border:1px solid #d1d3d2;border-top:none;border-bottom:none'><td style='width:40%;padding:10px 20px;border-left:1px solid #d1d3d2;'>Part #:</td><td>"  + "</td></tr>");
			sb.AppendLine("<tr style='border:1px solid #d1d3d2;border-top:none;border-bottom:none; background:#f2f2f2'><td style='width:40%;padding:10px 20px;border-left:1px solid #d1d3d2;'>Product Name:</td><td>"  + "</td></tr>");
			sb.AppendLine("<tr style='border:1px solid #d1d3d2;border-top:none;border-bottom:none;'><td style='width:40%;padding:10px 20px;border-left:1px solid #d1d3d2;'>Description:</td><td>" + "</td></tr>");
			sb.AppendLine("<tr style='border:1px solid #d1d3d2;border-top:none;border-bottom:none; background:#f2f2f2'><td style='width:40%;padding:10px 20px;border-left:1px solid #d1d3d2;'>Matrix:</td><td>" + "</td></tr>");
			sb.AppendLine("<tr style='border:1px solid #d1d3d2;border-top:none'><td style='padding:10px 20px;border-left:1px solid #d1d3d2;border-bottom:1px solid #d1d3d2;'>Volume:</td><td>"  + "</td></tr>");
			
		sb.AppendLine("</tbody></table></td></tr>");
		sb.AppendLine("</tbody></table></div>");
        sb.AppendLine("</body></html>");
        string strBody = sb.ToString();
		
		MailMessage mm = new MailMessage();
        mm.Subject = "Product Recommendation";
        mm.To.Add(email);

        mm.From = new MailAddress("contact@spexcsp.com", "SPEX CertiPrep Contact");
        mm.BodyEncoding = System.Text.Encoding.GetEncoding("utf-8");

        AlternateView plainView = AlternateView.CreateAlternateViewFromString(Regex.Replace(strBody, @"<(.|\n)*?>", string.Empty), System.Text.Encoding.GetEncoding("utf-8"), "text/plain");
        AlternateView htmlView = AlternateView.CreateAlternateViewFromString(strBody, System.Text.Encoding.GetEncoding("utf-8"), "text/html");
        mm.AlternateViews.Add(plainView);
        mm.AlternateViews.Add(htmlView);

        SmtpClient smtp = new SmtpClient();
		
        //smtp.Send(mm);
		
		Response.Write("<script>alert('Email has been sent!');location.replace('"+currURL+"')</script>");
	}
    protected string GetPrice(string PartNumber) {
        clsItemPrice price = new clsItemPrice(PartNumber, myUser);
        return price.PriceText;
    }
    
}