using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text.RegularExpressions;
using System.IO;
using System.Reflection;

/// <summary>
/// Summary description for tksUtil
/// </summary>
public static class tksUtil
{
    public static string NL2BR(string value) {
        return value.Replace(Convert.ToString((char)10), "<br>");
    }
    public static string ExtractNumbers(string expr) {
        return string.Join(null, Regex.Split(expr, "[^\\d]"));
    }
    public static string FormatDateTime(string date, string time) {
        string result = string.Format("{0:d}", DateTime.Parse(date));
        if (!string.IsNullOrEmpty(time)) {
            result += " - " + string.Format("{0:t}", DateTime.Parse(time));
        }
        return result;
    }
    public static DateTime UTCtoTZ(DateTime input) {
        return TimeZoneInfo.ConvertTimeFromUtc(input, TimeZoneInfo.FindSystemTimeZoneById("Eastern Standard Time"));
    }
	public static string FormatRouteURL(string Segment) {
		Regex rgx = new Regex("[^a-zA-Z0-9 -]");
		Segment = rgx.Replace(Segment, "");
		Segment = Segment.Replace("  ", " ");
		Segment = Segment.Replace(" ", "-");
		return Segment.ToLower();
	}
	public static string MakeValidFileName(string name) {
		string invalidChars = Regex.Escape(new string(Path.GetInvalidFileNameChars()));
		string invalidReStr = string.Format(@"[{0}]+", invalidChars);
		return Regex.Replace(name, invalidReStr, "_");
	}

	/// <summary>
	/// This attribute is used to represent a string value
	/// for a value in an enum.
	/// </summary>
	public class StringValueAttribute : Attribute {

		#region Properties

		/// <summary>
		/// Holds the stringvalue for a value in an enum.
		/// </summary>
		public string StringValue { get; protected set; }

		#endregion

		#region Constructor

		/// <summary>
		/// Constructor used to init a StringValue Attribute
		/// </summary>
		/// <param name="value"></param>
		public StringValueAttribute(string value) {
			this.StringValue = value;
		}

		#endregion

	}
	/// <summary>
	/// Will get the string value for a given enums value, this will
	/// only work if you assign the StringValue attribute to
	/// the items in your enum.
	/// </summary>
	/// <param name="value"></param>
	/// <returns></returns>
	public static string GetStringValue(this Enum value) {
		// Get the type
		Type type = value.GetType();

		// Get fieldinfo for this type
		FieldInfo fieldInfo = type.GetField(value.ToString());

		// Get the stringvalue attributes
		StringValueAttribute[] attribs = fieldInfo.GetCustomAttributes(
			typeof(StringValueAttribute), false) as StringValueAttribute[];

		// Return the first if there was a match.
		return attribs.Length > 0 ? attribs[0].StringValue : null;
	}
}
