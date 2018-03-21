using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text.RegularExpressions;

/// <summary>
/// Summary description for clsAccessory
/// </summary>
public class clsAccessory
{
    private int _ProductID = 0;
    public int ProductID {
        get {
            return _ProductID;
        }
    }
    private string _ProductName = "";
    public string ProductName {
        get {
            return _ProductName;
        }
    }
    private string _ProductNumber = "";
    public string ProductNumber {
        get {
            return _ProductNumber;
        }
    }
    private string _LongDescription = "";
    public string LongDescription {
        get {
            return _LongDescription;
        }
    }
    private string _ProductLevelID = "";
    public string ProductLevelID {
        get {
            return _ProductLevelID;
        }
    }
    private double _BasePrice = 0;
    public double BasePrice {
        get {
            return _BasePrice;
        }
    }
    private double _DiscountedPrice = 0;
    public double DiscountedPrice {
        get {
            return _DiscountedPrice;
        }
    }

    public clsAccessory(string partnumber)
	{
        _ProductNumber = partnumber;
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT * FROM sp_roi_AccessoryProduct WHERE partnumber = @partnumber AND ProductLevelID IS NOT NULL AND ProductName IS NOT NULL";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@partnumber", SqlDbType.Char, 16).Value = _ProductNumber;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                if (dr.HasRows) {
                    dr.Read();
                    _ProductID = Convert.ToInt32(dr["AccessoryProductID"]);
                    _ProductName = dr["ProductName"].ToString().Trim();
                    _LongDescription = dr["LongDescription"].ToString().Trim();
                    _ProductLevelID = dr["ProductLevelID"].ToString().Trim();
                }
                cmd.Connection.Close();
            }

            clsUser myUser = new clsUser();
            if (myUser.LoggedIn && (myUser.Region == "UK" || myUser.Region == "USA")) {
                // this is the discount assigned to the customer, not the item itself
                //myUser.DiscountAmount

                // Get price for this product
                int Novo_Code = 0;
                string Sales_Code = "";
                if (myUser.Region == "UK") {
                    SQL = "SELECT Novo_IM, ISNULL(Sales_Code, '1') AS Sales_Code FROM uk_roi_IM WHERE Item_Part_Nbr = @PartNumber";
                } else {
                    SQL = "SELECT Novo_IM, ISNULL(Sales_Code, '1') AS Sales_Code FROM sp_roi_IM WHERE Item_Part_Nbr = @PartNumber";
                }
                using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("@PartNumber", SqlDbType.Char, 21).Value = _ProductNumber;
                    cmd.Connection.Open();
                    SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
                        Novo_Code = Convert.ToInt32(dr["Novo_IM"]);
                        Sales_Code = dr["sales_code"].ToString();
                    }
                    cmd.Connection.Close();
                }

                // part 2 - get price for Novo IM entry
                //    convert SalesPriceCode to a number
                string ShortSPC = Convert.ToInt32(myUser.PriceCode).ToString();
                if (myUser.Region == "UK") {
                    SQL = "SELECT TOP 1 CD.Catalog_Prices FROM UK_roi_IM_Catalog_Data CD WHERE Cat_Code = @ShortSPC AND from_qty <= 1 AND CD.Price_Currency='GBP' AND CD.part_Nbr = @partnumber AND eff_date = (SELECT MAX(eff_date) FROM uk_roi_IM_Catalog_Data WHERE Cat_Code = @ShortSPC AND Part_Nbr = @partnumber) ORDER BY From_Qty DESC";
                } else {
                    SQL = "SELECT TOP 1 CD.Catalog_Prices FROM sp_roi_IM_Catalog_Data CD WHERE Cat_Code = @ShortSPC AND from_qty <= 1 AND Novo_IM = @Novo_Code and eff_date = (SELECT MAX(eff_date) FROM sp_roi_IM_Catalog_Data WHERE Cat_Code = @ShortSPC AND Novo_IM = @Novo_Code) ORDER BY From_Qty desc";
                }
                using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("@ShortSPC", SqlDbType.Char, 3).Value = ShortSPC;
                    if (myUser.Region == "UK") {
                        cmd.Parameters.Add("@partnumber", SqlDbType.VarChar, 16).Value = _ProductNumber;
                    } else {
                        cmd.Parameters.Add("@Novo_Code", SqlDbType.Int).Value = Novo_Code;
                    }
                    cmd.Connection.Open();
                    SqlDataReader dr2 = cmd.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr2.HasRows) {
                        dr2.Read();
                        _BasePrice = Convert.ToDouble(dr2["Catalog_Prices"]);
                    }
                    cmd.Connection.Close();
                }

                //part 3 - get discount for this item, with the user's discount code
                if (myUser.Region == "UK") {
                    SQL = "SELECT ISNULL(Disc_Mult, 0) AS Disc_Mult FROM uk_roi_TRADE_DISCOUNT_DETAIL WHERE MultiID = @MultiID";
                } else {
                    SQL = "SELECT ISNULL(Disc_Mult, 0) AS Disc_Mult FROM sp_roi_TRADE_DISCOUNT_DETAIL WHERE MultiID = @MultiID";
                }
                using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("@MultiID", SqlDbType.Char, 10).Value = myUser.DiscountCode + "_" + myUser.PriceCode;
                    cmd.Connection.Open();
                    SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
                        _DiscountedPrice = (_BasePrice * (1- Convert.ToDouble(dr["Disc_Mult"]) + myUser.DiscountAmount));
                    } else {
                        _DiscountedPrice = _BasePrice;
                    }
                    cmd.Connection.Close();
                }
            } else {
                _BasePrice = 0;
                _DiscountedPrice = 0;
            }

        }
	}
}