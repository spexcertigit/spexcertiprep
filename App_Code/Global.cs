using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Global
/// </summary>
public static class Global
{
	private static string _ColorPrompt = "";
	private static string _ContactPhone = "1-800-LAB-SPEX";
	private static string _ContactAddress1Line = "203 Norcross Ave - Metuchen, NJ 08840";
	private static string _SizePrompt = "";
	private static string _TitleSuffix = "SPEX CertiPrep";
	private static string _TitleSuffixSep = " :: ";
	private static string _BlogCommentNotificationAddress = "tom@eerieglow.com";
	private static string _OrderNoticeEmail = "peskow@spex.com";

	public static string BlogCommentNotificationAddress {
		get { return _BlogCommentNotificationAddress; }
	}
	public static string OrderNoticeEmail {
		get { return _OrderNoticeEmail; }
	}
	public static string ColorPrompt {
		get { return _ColorPrompt; }
	}
	public static string ContactPhone {
		get { return _ContactPhone; }
	}
	public static string ContactAddress1Line {
		get { return _ContactAddress1Line; }
	}
	public static bool ModerateReviews {
		get { return false; }
	}
	public static string SizePrompt {
		get { return _SizePrompt; }
	}
	public static string TitleSuffix {
		get { return _TitleSuffix; }
	}
	public static string TitleSuffixSep {
		get { return _TitleSuffixSep; }
	}
	public static bool WholesaleOnly {
		get { return false; }
	}
}