using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;
using System.Net.Mail;
using System.Text.RegularExpressions;

public partial class knowledge_base_catalog : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "Request a Catalog - Knowledge Base" + ConfigurationSettings.AppSettings["gsDefaultPageTitle"];
    }
    protected void cmdSubmit_Click(object sender, EventArgs e) {
        // send email to Spex telling them a new user has registered
        StringBuilder sb = new StringBuilder();
        sb.AppendLine("<html><body>");
        sb.AppendLine("Contact name: " + first_name.Text.Trim() + " " + last_name.Text.Trim() + "<br>");
        sb.AppendLine("Job Title: " + txtTitle.Text.Trim() + "<br>");
        sb.AppendLine("Company name: " + company_name.Text.Trim() + "<br>");
        sb.AppendLine("Address: " + company_address.Text.Trim() + ", " + city.Text.Trim() + ", " + state_region.Text.Trim() + ", " + zip.Text.Trim() + ", " + Country.SelectedItem.Text + "<br>");
        sb.AppendLine("Phone: " + phone_number.Text.Trim() + "<br>");
        sb.AppendLine("Email: " + email.Text.Trim() + "<br>");
        if (OrganicCatalog.Checked || InorganicCatalog.Checked) {
            sb.AppendLine("Please send hard copy of:<br>");
            if (OrganicCatalog.Checked) {
                sb.AppendLine("Organic Catalog<br>");
            }
            if (InorganicCatalog.Checked) {
                sb.AppendLine("Inorganic Catalog<br>");
            }
            sb.AppendLine("<br>");
        }
		//CDROMCatalogs.Checked ||
        if (Accreditations.Checked || SPEXertificate.Checked || SPoints.Checked || SVOADrinkingWater.Checked || Pesticides.Checked || OrganicConsumerSafety.Checked || Wine.Checked || LCMSPostcard.Checked || PharmaResidualSolvents.Checked || GeneralOrganics.Checked || FusionFlux.Checked || ICHGlobalCompliance.Checked || PHBuffers.Checked || Claritas1PPMSingles.Checked || USP232.Checked || InorganicConsumerSafety.Checked || GeneralInorganics.Checked || AcidStill.Checked || PipetteWasher.Checked || OdorEroder.Checked || NewProdSupplement.Checked || cbQuechers.Checked || OrganicUSP467.Checked || cbLCPestRes.Checked)
        {
            sb.AppendLine("Please send the following literature:<br>");
            //if (CDROMCatalogs.Checked)
            //{
            //    sb.AppendLine("Catalogs on CD-ROM<br>");
            //}
            if (NewProdSupplement.Checked)
            {
                sb.AppendLine("2013 New Products Supplement<br>");
            }
            if (Accreditations.Checked)
            {
                sb.AppendLine("Accreditations<br>");
            }
            if (SPEXertificate.Checked)
            {
                sb.AppendLine("SPEXertificate<br>");
            }
            if (SPoints.Checked)
            {
                sb.AppendLine("SPoints<br>");
            }
            if (OrganicUSP467.Checked)
            {
                sb.AppendLine("USP 467<br>");
            }

            if (cbQuechers.Checked)
            {
                sb.AppendLine("QuEChERS Kits<br>");
            }
            if (SVOADrinkingWater.Checked)
            {
                sb.AppendLine("SVOA Drinking Water Standards<br>");
            }
            if (Pesticides.Checked)
            {
                sb.AppendLine("Pesticide Standards<br>");
            }
            if (OrganicConsumerSafety.Checked)
            {
                sb.AppendLine("Organic Consumer Safety Standards<br>");
            }
            if (Wine.Checked)
            {
                sb.AppendLine("Organic Wine Standards<br>");
            }
            if (cbLCPestRes.Checked)
            {
                sb.AppendLine("LC Pesticide Residue<br>");
            }
            if (LCMSPostcard.Checked)
            {
                sb.AppendLine("LC-MS Standards<br>");
            }
            if (PharmaResidualSolvents.Checked)
            {
                sb.AppendLine("Pharmaceutical Residual Solvent Standards<br>");
            }
            if (GeneralOrganics.Checked)
            {
                sb.AppendLine("General Organics Overview<br>");
            }
            if (FusionFlux.Checked)
            {
                sb.AppendLine("Fusion Flux<br>");
            }
            if (ICHGlobalCompliance.Checked)
            {
                sb.AppendLine("ICH Global Compliance Standards<br>");
            }
            if (PHBuffers.Checked)
            {
                sb.AppendLine("pH Buffers<br>");
            }
            if (Claritas1PPMSingles.Checked)
            {
                sb.AppendLine("Claritas 1ppm Standards<br>");
            }
            if (USP232.Checked)
            {
                sb.AppendLine("USP 232<br>");
            }
            if (InorganicConsumerSafety.Checked)
            {
                sb.AppendLine("Inorganic Consumer Safety Standards<br>");
            }
            if (GeneralInorganics.Checked)
            {
                sb.AppendLine("General Inorganics Overview<br>");
            }
			if (DualSingleSpeciation.Checked)
            {
                sb.AppendLine("Dual & Single Speciation Standards<br>");
            }
            if (AcidStill.Checked)
            {
                sb.AppendLine("Acid Still<br>");
            }

            if (PipetteWasher.Checked)
            {
                sb.AppendLine("Pipette Washer / Dryer<br>");
            }
            if (OdorEroder.Checked)
            {
                sb.AppendLine("OdorEroder<br>");
            }



            sb.AppendLine("<br>");
        }
        sb.AppendLine("</body></html>");
        string strBody = sb.ToString();

        MailMessage mm = new MailMessage();
        mm.Subject = "Catalog Request from SPEX CertiPrep";
        mm.To.Add("crmsales@spexcsp.com");
        mm.To.Add("peskow@spexcsp.com");
		mm.To.Add("crmsales@spex.com");
		mm.Bcc.Add("spexcertiprepmarcom@gmail.com");


        mm.From = new MailAddress("contact@spexcsp.com", "SPEX CertiPrep Contact");
        mm.BodyEncoding = System.Text.Encoding.GetEncoding("utf-8");

        AlternateView plainView = AlternateView.CreateAlternateViewFromString(Regex.Replace(strBody, @"<(.|\n)*?>", string.Empty), System.Text.Encoding.GetEncoding("utf-8"), "text/plain");
        AlternateView htmlView = AlternateView.CreateAlternateViewFromString(strBody, System.Text.Encoding.GetEncoding("utf-8"), "text/html");
        mm.AlternateViews.Add(plainView);
        mm.AlternateViews.Add(htmlView);

        SmtpClient smtp = new SmtpClient();
        smtp.Send(mm);

        mvForm.SetActiveView(vwThank);
    }
}