using System;
using System.Collections.Generic;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

/// <summary>
/// Summary description for clsItemPrice
/// </summary>
public class clsItemPrice
{
    private string _PriceText = "Call for price";
    public string PriceText {
        get {
            return _PriceText;
        }
    }
    private double _Price = 0;
    public double Price {
        get {
            return _Price;
        }
    }
    private string _DiscountPriceText = "Call for price";
    public string DiscountPriceText {
        get {
            return _DiscountPriceText;
        }
    }
    private double _DiscountPrice = 0;
    public double DiscountPrice {
        get {
            return _DiscountPrice;
        }
    }
    private string _SalesCode = "";
    public string SalesCode {
        get {
            return _SalesCode;
        }
    }
    public clsItemPrice(string PartNumber, clsUser myUser)
	{
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "";
            int ShortSPC = 0;
            Int32.TryParse(myUser.PriceCode, out ShortSPC);
            if (ShortSPC == 0) { ShortSPC = 1; }

            if (myUser.Region == "UK") {
                SQL = "SELECT cp.cpID as NOVO_IM, NULLIF(im.Sales_Code, 1) AS Sales_Code, cd.Catalog_Prices " +
                      "  FROM cp_roi_Prods cp LEFT JOIN uk_roi_IM im ON cp.cppart = im.Item_Part_Nbr " +
                      "      LEFT JOIN uk_roi_IM_Catalog_Data cd ON im.Item_Part_Nbr = cd.part_nbr " +
                      "  WHERE cp.cppart = @PartNumber " +
                      "      AND cd.Cat_Code = @CatCode " +
                      "      AND cd.Price_Currency = 'GBP' " +
                      "      AND cp.For_Web = 'Y' " +
                      "      --AND im.Eff_Date <= GETDATE() " +
                      "      AND cd.Eff_Date <= GETDATE() " +
                      "  ORDER BY im.Eff_Date DESC, cd.Eff_Date DESC";

                using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("@PartNumber", SqlDbType.VarChar, 21).Value = PartNumber;
                    cmd.Parameters.Add("@CatCode", SqlDbType.Char, 3).Value = ShortSPC;
                    cmd.Connection.Open();
                    SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleResult);
                    if (dr.HasRows) {
                        dr.Read();
                        _PriceText = myUser.CurrencySymbol + " " + string.Format("{0:##,##0.00}", dr["Catalog_Prices"]);
                        _Price = Convert.ToDouble(dr["Catalog_Prices"]);
                        _SalesCode = dr["Sales_Code"].ToString();
                    }
                    cmd.Connection.Close();
                }

                // Get discount for this item, with the user's discount code
                double ItemDiscount = 0;
                SQL = "SELECT TOP 1 ISNULL(Disc_Mult, 0) AS Disc_Mult FROM uk_roi_TRADE_DISCOUNT_DETAIL where MultiID = @MultiID";

                using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("@MultiID", SqlDbType.Char, 10).Value = myUser.DiscountCode.Trim() + "_" + _SalesCode.Trim();
                    cmd.Connection.Open();
                    SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
                        ItemDiscount = Convert.ToDouble(dr["Disc_Mult"]);
                    }
                    cmd.Connection.Close();
                }
                double AmountToTakeOff = _Price * (ItemDiscount); /* + myUser.DiscountAmount); */
                _DiscountPrice = _Price - AmountToTakeOff; 
                _DiscountPriceText = myUser.CurrencySymbol + " " + string.Format("{0:##,##0.00}", _DiscountPrice);
            }
            else if(myUser.Region == "USA") {
                using (SqlCommand cmd = new SqlCommand("sp_certGetItemPrice", cn)) {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@cp_roi_Contact_Master_ID", SqlDbType.VarChar, 10).Value = myUser.UserID.ToString();
                    cmd.Parameters.Add("@cp_roi_Prods_cpPart", SqlDbType.VarChar, 21).Value = PartNumber;
                    cmd.Parameters.Add("@Price", SqlDbType.Decimal);
                    cmd.Parameters.Add("@DiscountPrice", SqlDbType.Decimal);
                    cmd.Parameters["@Price"].Direction = ParameterDirection.Output;
                    cmd.Parameters["@Price"].Precision = 16;
                    cmd.Parameters["@Price"].Scale = 2;
                    cmd.Parameters["@DiscountPrice"].Direction = ParameterDirection.Output;
                    cmd.Parameters["@DiscountPrice"].Precision = 16;
                    cmd.Parameters["@DiscountPrice"].Scale = 2;

                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                    if (cmd.Parameters["@Price"].Value != System.DBNull.Value){
                        _Price = Convert.ToDouble(cmd.Parameters["@Price"].Value);
                    }else {
                       _Price = 0;
                    }
                    if (cmd.Parameters["@DiscountPrice"].Value != System.DBNull.Value){
                        _DiscountPrice = Convert.ToDouble(cmd.Parameters["@DiscountPrice"].Value);
                    }
                    //_SalesCode = dr["Sales_Code"].ToString();
                    cmd.Connection.Close();
                }

                if (_Price > 0) {
                    _PriceText = myUser.CurrencySymbol + " " + string.Format("{0:##,##0.00}", _Price);
                }
                if (_DiscountPrice > 0) {
                    _DiscountPriceText = myUser.CurrencySymbol + " " + string.Format("{0:##,##0.00}", _DiscountPrice);
                }
            }
            else {
                using (SqlCommand cmd = new SqlCommand("sp_certGetItemPriceOther", cn)) {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@cp_roi_Contact_Master_ID", SqlDbType.VarChar, 10).Value = myUser.UserID.ToString();
                    cmd.Parameters.Add("@cp_roi_Prods_cpPart", SqlDbType.VarChar, 21).Value = PartNumber;
                    cmd.Parameters.Add("@Price", SqlDbType.Decimal);
                    cmd.Parameters.Add("@DiscountPrice", SqlDbType.Decimal);
                    cmd.Parameters["@Price"].Direction = ParameterDirection.Output;
                    cmd.Parameters["@Price"].Precision = 16;
                    cmd.Parameters["@Price"].Scale = 2;
                    cmd.Parameters["@DiscountPrice"].Direction = ParameterDirection.Output;
                    cmd.Parameters["@DiscountPrice"].Precision = 16;
                    cmd.Parameters["@DiscountPrice"].Scale = 2;

                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                    if (cmd.Parameters["@Price"].Value != System.DBNull.Value){
                        _Price = Convert.ToDouble(cmd.Parameters["@Price"].Value);
                    }else {
                       _Price = 0;
                    }
                    if (cmd.Parameters["@DiscountPrice"].Value != System.DBNull.Value){
                        _DiscountPrice = Convert.ToDouble(cmd.Parameters["@DiscountPrice"].Value);
                    }
                    //_SalesCode = dr["Sales_Code"].ToString();
                    cmd.Connection.Close();
                }

                if (_Price > 0) {
                    _PriceText = myUser.CurrencySymbol + " " + string.Format("{0:##,##0.00}", _Price);
                }
                if (_DiscountPrice > 0) {
                    _DiscountPriceText = myUser.CurrencySymbol + " " + string.Format("{0:##,##0.00}", _DiscountPrice);
                }
            }
        }
    }
}