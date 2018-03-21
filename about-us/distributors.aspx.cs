using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;

public partial class purchase_distributors : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {


    }

    public void UpdateUrlBasedOnCountry(object sender, EventArgs e)
    {
              //countryLabel.Text = "Distributors in: " + country.SelectedValue.ToString();
       if (IsPostBack)
        {

            Response.Redirect("distributors.aspx?country=" + country.SelectedValue.ToString());

        };
   }
    public void OnCountriesDDLDataBound(object sender, EventArgs e)
    {

            if (!IsPostBack)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["country"]))
            {



                ListItem item = country.Items.FindByValue(Request.QueryString["country"].ToLower());
                if (item != null) 
                {
                    //querystring contains id
                    country.SelectedValue = Request.QueryString["country"].ToLower();
                    countryLabel.Text = country.SelectedItem.Text.ToString() + ":";
                }
                else
                {
                    Response.Redirect("distributors.aspx");
                }
            }

    }


        }




}