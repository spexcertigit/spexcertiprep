using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;

/// <summary>
/// Summary description for BlogPost
/// </summary>
public class BlogPost
{
	#region Fields
	private int m_PostSerial = 0;
	private Guid m_PostID = System.Guid.Empty;
	private string m_Title = "";
	private string m_Author = "";
	private string m_Description = "";
	private string m_PostContent = "";
	private Guid m_AuthorID = System.Guid.Empty;
	private int m_AuthorSerial = 0;
	private bool m_IsPublished = false;
	private bool m_IsCommentEnabled = false;
	private string m_Slug = "";
	private DateTime m_PublishDate = DateTime.MinValue;
	private string m_Tags = "";
	private string m_PostURL = "";
	private List<Guid> m_AssignedCategories = new List<Guid>();
	#endregion

	#region Constructor
	public BlogPost() {
	}
	public BlogPost(int PostSerial) {
		m_PostSerial = PostSerial;

		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString)) {
			using (SqlCommand cmd = new SqlCommand("SELECT bp.*, a.FirstName + ' ' + a.LastName AS Author, a.AccountID FROM cms_BlogPost bp LEFT JOIN Account a ON bp.AuthorID = a.UserId WHERE PostSerial = @PostSerial", cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("PostSerial", SqlDbType.Int).Value = m_PostSerial;

				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				if (dr.HasRows) {
					dr.Read();
					m_PostID = new Guid(dr["PostID"].ToString());
					m_Title = dr["Title"].ToString();
					m_Author = dr["Author"].ToString();
					m_Description = dr["Description"].ToString();
					m_PostContent = dr["PostContent"].ToString();
					m_AuthorSerial = Convert.ToInt32(dr["AccountID"].ToString());
					m_AuthorID = new Guid(dr["AuthorID"].ToString());
					m_IsPublished = dr["IsPublished"].ToString().ToLower() == "true" ? true : false;
					m_IsCommentEnabled = dr["IsCommentEnabled"].ToString().ToLower() == "true" ? true : false;
					m_Slug = dr["Slug"].ToString();
					DateTime.TryParse(dr["PublishDate"].ToString(), out m_PublishDate);
				} else {
					m_PostSerial = 0;
				}
				cmd.Connection.Close();
			}
		}
		FillCategories();
		FillTags();
	}
	public BlogPost(Guid PostID) {
		m_PostID = PostID;

		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString)) {
			using (SqlCommand cmd = new SqlCommand("SELECT bp.*, a.FirstName + ' ' + a.LastName AS Author, a.AccountID FROM cms_BlogPost bp LEFT JOIN Account a ON bp.AuthorID = a.UserId WHERE PostID = @PostID", cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("PostID", SqlDbType.UniqueIdentifier).Value = m_PostID;

				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				if (dr.HasRows) {
					dr.Read();
					m_PostSerial = Convert.ToInt32(dr["PostSerial"]);
					m_Title = dr["Title"].ToString();
					m_Author = dr["Author"].ToString();
					m_Description = dr["Description"].ToString();
					m_PostContent = dr["PostContent"].ToString();
					m_AuthorSerial = Convert.ToInt32(dr["AccountID"].ToString());
					m_AuthorID = new Guid(dr["AuthorID"].ToString());
					m_IsPublished = dr["IsPublished"].ToString().ToLower() == "true" ? true : false;
					m_IsCommentEnabled = dr["IsCommentEnabled"].ToString().ToLower() == "true" ? true : false;
					m_Slug = dr["Slug"].ToString();
					DateTime.TryParse(dr["PublishDate"].ToString(), out m_PublishDate);
				} else {
					m_PostSerial = 0;
					m_PostID = System.Guid.Empty;
				}
				cmd.Connection.Close();
			}
		}
		FillCategories();
		FillTags();
	}
	#endregion

	#region Private Methods
	private void FillCategories() {
		m_AssignedCategories.Clear();
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString)) {
			string SQL = "SELECT CategoryID FROM cms_BlogPost_Category_xref WHERE PostID = @PostID";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("PostID", SqlDbType.UniqueIdentifier).Value = PostID;

				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				while (dr.Read()) {
					m_AssignedCategories.Add(new Guid(dr[0].ToString()));
				}
				cmd.Connection.Close();
			}
		}
	}
	private void SaveCategories() {
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString)) {
			string SQL = "DELETE FROM cms_BlogPost_Category_xref WHERE PostID = @PostID";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("PostID", SqlDbType.UniqueIdentifier).Value = PostID;
				cmd.Connection.Open();
				cmd.ExecuteNonQuery();
				cmd.Connection.Close();

				cmd.CommandText = "INSERT INTO cms_BlogPost_Category_xref (PostID, CategoryID) VALUES (@PostID, @CategoryID)";
				cmd.Parameters.Add("CategoryID", SqlDbType.UniqueIdentifier);
				foreach (Guid cat in m_AssignedCategories) {
					cmd.Parameters["CategoryID"].Value = cat;
					cmd.Connection.Open();
					cmd.ExecuteNonQuery();
					cmd.Connection.Close();
				}
			}
		}
	}
	private void FillTags() {
		m_Tags = "";

		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString)) {
			string SQL = "SELECT Tag FROM cms_BlogPostTag WHERE PostID = @PostID";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("PostID", SqlDbType.UniqueIdentifier).Value = PostID;

				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				while (dr.Read()) {
					m_Tags += dr[0].ToString() + ", ";
				}
				cmd.Connection.Close();
				if (m_Tags.Length > 2) {
					m_Tags = m_Tags.Substring(0, m_Tags.Length - 2);
				}
			}
		}
	}
	private void SaveTags() {
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString)) {
			string SQL = "DELETE FROM cms_BlogPostTag WHERE PostID = @PostID";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("PostID", SqlDbType.UniqueIdentifier).Value = PostID;
				cmd.Connection.Open();
				cmd.ExecuteNonQuery();
				cmd.Connection.Close();

				if (Tags.Length > 0) {
					char[] delimiterChars = { ',' };
					string[] tags = Tags.Split(delimiterChars);
					cmd.CommandText = "INSERT INTO cms_BlogPostTag (PostID, Tag) VALUES (@PostID, @Tag)";
					cmd.Parameters.Add("Tag", SqlDbType.VarChar, 50);
					foreach (string tag in tags) {
						cmd.Parameters["Tag"].Value = tag.Trim();
						cmd.Connection.Open();
						cmd.ExecuteNonQuery();
						cmd.Connection.Close();
					}
				}
			}
		}
	}
	#endregion

	#region Public Methods
	public void Delete() {
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString)) {
			using (SqlCommand cmd = new SqlCommand("cms_DeleteBlog", cn)) {
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.Parameters.Add("@PostID", SqlDbType.UniqueIdentifier).Value = m_PostID;

				cmd.Connection.Open();
				cmd.ExecuteNonQuery();
				cmd.Connection.Close();
			}
		}
	}
	public void New() {
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString)) {
			using (SqlCommand cmd = new SqlCommand("cms_InsertBlogPost", cn)) {
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 255).Value = Title;
				cmd.Parameters.Add("@Description", SqlDbType.NVarChar).Value = Description;
				cmd.Parameters.Add("@PostContent", SqlDbType.NVarChar).Value = PostContent;
				if (AuthorID != System.Guid.Empty) {
					cmd.Parameters.Add("@AuthorID", SqlDbType.UniqueIdentifier).Value = AuthorID;
				} else {
					cmd.Parameters.Add("@AuthorID", SqlDbType.UniqueIdentifier).Value = SqlGuid.Null;
				}
				cmd.Parameters.Add("@IsPublished", SqlDbType.Bit).Value = IsPublished ? 1 : 0;
				cmd.Parameters.Add("@IsCommentEnabled", SqlDbType.Bit).Value = IsCommentEnabled ? 1 : 0;
				cmd.Parameters.Add("@Slug", SqlDbType.NVarChar, 255).Value = Slug;
				if (PublishDate != DateTime.MinValue) {
					cmd.Parameters.Add("@PublishDate", SqlDbType.Date).Value = PublishDate;
				} else {
					cmd.Parameters.Add("@PublishDate", SqlDbType.Date).Value = DateTime.Now.ToShortDateString();
				}
				cmd.Parameters.Add("@CreatedBy", SqlDbType.UniqueIdentifier).Value = (Guid)Membership.GetUser().ProviderUserKey;
				cmd.Parameters.Add("@PostID", SqlDbType.UniqueIdentifier);
				cmd.Parameters["@PostID"].Direction = ParameterDirection.Output;

				cmd.Connection.Open();
				cmd.ExecuteNonQuery();
				m_PostID = new Guid(cmd.Parameters["@PostID"].Value.ToString());
				cmd.Connection.Close();
			}
		}
		SaveCategories();
		SaveTags();
	}
	public void Save() {
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString)) {
			using (SqlCommand cmd = new SqlCommand("cms_UpdateBlogItem", cn)) {
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.Parameters.Add("@PostID", SqlDbType.UniqueIdentifier).Value = PostID;
				cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 255).Value = Title;
				cmd.Parameters.Add("@Description", SqlDbType.NVarChar).Value = Description;
				cmd.Parameters.Add("@PostContent", SqlDbType.NVarChar).Value = PostContent;
				if (AuthorID != System.Guid.Empty) {
					cmd.Parameters.Add("@AuthorID", SqlDbType.UniqueIdentifier).Value = AuthorID;
				} else {
					cmd.Parameters.Add("@AuthorID", SqlDbType.UniqueIdentifier).Value = SqlGuid.Null;
				}
				cmd.Parameters.Add("@IsPublished", SqlDbType.Bit).Value = IsPublished ? 1 : 0;
				cmd.Parameters.Add("@IsCommentEnabled", SqlDbType.Bit).Value = IsCommentEnabled ? 1 : 0;
				cmd.Parameters.Add("@Slug", SqlDbType.NVarChar, 255).Value = Slug;
				if (PublishDate != DateTime.MinValue) {
					cmd.Parameters.Add("@PublishDate", SqlDbType.Date).Value = PublishDate;
				} else {
					cmd.Parameters.Add("@PublishDate", SqlDbType.Date).Value = DateTime.Now.ToShortDateString();
				}

				cmd.Connection.Open();
				cmd.ExecuteNonQuery();
				cmd.Connection.Close();
			}
		}
		SaveCategories();
		SaveTags();
	}
	#endregion

	#region Properties
	public int PostSerial { get { return m_PostSerial; } }
	public Guid PostID { get { return m_PostID; } }
	public string Title { 
		get { return m_Title; }
		set { m_Title = value.Trim(); }
	}
	public string Author {
		get { return m_Author; }
	}
	public Guid AuthorID {
		get { return m_AuthorID; }
		set { m_AuthorID = value; }
	}
	public string AuthorURL {
		get { return "<a href='/blog/author/" + m_AuthorSerial.ToString() + "/" + tksUtil.FormatRouteURL(Author) + "'>" + Author + "</a>"; }
	}
	public string Description { 
		get { return m_Description; }
		set { m_Description = value.Trim(); }
	}
	public string PostContent {
		get { return m_PostContent; }
		set { m_PostContent = value.Trim(); }
	}
	public string Tags {
		get { return m_Tags; }
		set { m_Tags = value.Trim(); }
	}
	public string TagsURL {
		get {
			string ret = "";
			using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString)) {
				using (SqlCommand cmd = new SqlCommand("SELECT PostTagID, Tag FROM cms_BlogPostTag WHERE PostID = @PostID ORDER BY Tag", cn)) {
					cmd.CommandType = CommandType.Text;
					cmd.Parameters.Add("PostID", SqlDbType.UniqueIdentifier).Value = PostID;
					cmd.Connection.Open();
					SqlDataReader dr = cmd.ExecuteReader();
					while (dr.Read()) {
						ret += "<a href='/blog/tag/" + dr[0].ToString() + "/" + tksUtil.FormatRouteURL(dr[1].ToString()) + "'>" + dr[1].ToString() + "</a>, ";
					}
					cmd.Connection.Close();
				}
			}
			if (ret.Length > 2) { ret = ret.Substring(0, ret.Length - 2); }
			if (ret.Contains(",")) {
				return "Tags: " + ret;
			} else {
				return "Tag: " + ret;
			}
		}
	}
	public bool IsPublished { 
		get { return m_IsPublished; }
		set { m_IsPublished = value; }
	}
	public bool IsCommentEnabled { 
		get { return m_IsCommentEnabled; }
		set { m_IsCommentEnabled = value; }
	}
	public string Slug {
		get {
			if (m_Slug.Length > 0) { return m_Slug; } else { return tksUtil.FormatRouteURL(m_Title); }
		}
		set { m_Slug = tksUtil.FormatRouteURL(value.Trim()); }
	}
	public string MetaDescription {
		get {
			if (Description.Length > 0) {
				return Description;
			} else {
				PostContent = Regex.Replace(PostContent, @"<(.|\n)*?>", string.Empty);
				if (PostContent.Length > 200) {
					return PostContent.Substring(0, 200);
				} else {
					return PostContent;
				}
			}

			if (m_Slug.Length > 0) { return m_Slug; } else { return tksUtil.FormatRouteURL(m_Title); }
		}
	}
	public DateTime PublishDate { 
		get { return m_PublishDate; }
		set { m_PublishDate = value; }
	}
	public string Permalink { get { return "/blog/post.aspx?guid=" + m_PostID; } }
	public string URL { get { return "/blog/" + m_PostSerial.ToString() + "/" + m_Slug; } }
	public List<Guid> AssignedCategories { 
		get { return m_AssignedCategories; }
		set { m_AssignedCategories = value; }
	}
	public string AssignedCategoriesURL {
		get {
			string ret = "";
			using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString)) {
				using (SqlCommand cmd = new SqlCommand("cms_GetBlogPostCategories", cn)) {
					cmd.CommandType = CommandType.StoredProcedure;
					cmd.Parameters.Add("PostID", SqlDbType.UniqueIdentifier).Value = PostID;
					cmd.Connection.Open();
					SqlDataReader dr = cmd.ExecuteReader();
					while (dr.Read()) {
						ret += "<a href='/blog/cat/" + dr["CategoryRowID"].ToString() + "/" + tksUtil.FormatRouteURL(dr["categoryname"].ToString()) + "'>" + dr["CategoryName"].ToString() + "</a>, ";
					}
					cmd.Connection.Close();
				}
			}
			if (ret.Length > 2) { ret = ret.Substring(0, ret.Length - 2); }
			if (ret.Contains(",")) {
				return "Catgories: " + ret;
			} else {
				return "Catgory: " + ret;
			}
		}
	}
	public string AdminLink {
		get {
			if (HttpContext.Current.User.IsInRole("Admin") || HttpContext.Current.User.IsInRole("BlogAdmin")) {
				return "<p><a href='/admin/blog/post.aspx?id=" + PostID.ToString() + "'>Edit</a></p>";
			} else {
				return HttpContext.Current.User.Identity.IsAuthenticated.ToString();
			}
		}
	}
	#endregion
}