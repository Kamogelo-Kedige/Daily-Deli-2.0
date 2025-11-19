using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Daily_Deli_E_Commerce.DailyDeliAPI;

namespace Daily_Deli_E_Commerce
{


    public partial class Blog_Post : System.Web.UI.Page
    {

        Service_DailyDeliClient client = new Service_DailyDeliClient();




       


        protected void Page_Load(object sender, EventArgs e)
        {
           

            // HANDLE LIKE CLICKS FROM YOUR STRINGBUILDER BUTTONS:
            // those buttons call: __doPostBack('Like','{Comment_Id}')
            if (IsPostBack)
            {
                var target = Request["__EVENTTARGET"];
                var arg = Request["__EVENTARGUMENT"];

                if (string.Equals(target, "Like", StringComparison.Ordinal))
                {
                    if (int.TryParse(arg, out var commentId))
                    {
                        HandleLike(commentId);   // increments on backend via UpdateComment
                    }
                }
            }

            // initial page load only
            if (!IsPostBack)
                BindComments();
        }

        private void HandleLike(int commentId)
        {
            int userId = 2; // swap to Session later if needed

            // 1) fetch latest
            var all = client.getComments();
            if (all == null || all.Length == 0) return;

            var c = all.FirstOrDefault(x => x.Id == commentId);
            if (c == null) return;

            // 2) increment (null-safe)
            c.Likes = (c.Likes ?? 0) + 1;

            // 3) persist
            if (client.UpdateComment(c))
            {
                // 4) remember as liked (so you can render .liked and fill the heart)
                GetLikedSet(userId).Add(commentId);
                Response.Redirect("<script>alert('User has added a like')</script>");
            }
        }

        // Tracks which comments this user has liked in this session
        private HashSet<int> GetLikedSet(int userId)
        {
            string key = $"liked_comments_user_{userId}";
            var liked = Session[key] as HashSet<int>;
            if (liked == null)
            {
                liked = new HashSet<int>();
                Session[key] = liked;
            }
            return liked;
        }


        // runs after BtnPost_Click on the same request
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            // always rebuild on postbacks so new inserts/likes show immediately
            if (IsPostBack)
                BindComments();
        }
        private int GetUserId()
        {
            var o = Session["UserId"];
            if (o == null) return 2;                 // fallback you wanted
            if (o is int i) return i;                // most common
            if (o is string s && int.TryParse(s, out var v)) return v;
            if (o is long l) return checked((int)l); // just in case
            if (o is UserDTO u) return u.Id;         // if you stored the whole user
            return 2;
        }
        private void BindComments()
        {
            CommentDTO[] comments = client.getComments();
            var sb = new StringBuilder();

            if (comments != null && comments.Length > 0)
            {
                foreach (var c in comments)
                {
                    DateTime Comment_Date = c.Date;
                    string Comment_Description = c.Comment;
                    int? Comment_Likes = c.Likes;
                    int Comment_Id = c.Id;
                    
                    string Product_Id = c.ProductId.ToString();
                    string Product_Name = "";

                    switch (Product_Id)
                    {
                        case "0": Product_Name = "-- Choose a product --"; break;
                        case "2": Product_Name = "Tofu"; break;
                        case "3": Product_Name = "Meaty Burger"; break;
                        case "4": Product_Name = "Greens Sandwich"; break;
                        case "5": Product_Name = "Spinach"; break;
                        case "6": Product_Name = "Salted Butter"; break;
                        case "7": Product_Name = "Bell Peppers"; break;
                        case "8": Product_Name = "Pita Bread"; break;
                        case "9": Product_Name = "Hummus"; break;
                        case "10": Product_Name = "Carrots"; break;
                        case "11": Product_Name = "Cucumber"; break;
                        case "12": Product_Name = "Halloumi Cheese"; break;
                        case "13": Product_Name = "Lemons"; break;
                        case "15": Product_Name = "Bananas"; break;
                        case "16": Product_Name = "Avocados"; break;
                        case "17": Product_Name = "Still Water"; break;
                        case "18": Product_Name = "Greek Salad"; break;
                        case "19": Product_Name = "Vegetable Curry"; break;
                        case "20": Product_Name = "Fruit Salad"; break;
                        case "21": Product_Name = "Cheese&ham Panini"; break;
                        case "22": Product_Name = "Almonds"; break;
                        case "23": Product_Name = "Greek Yoghurt"; break;
                        case "24": Product_Name = "Beef Biltong"; break;
                        case "25": Product_Name = "Cheddar Cheese"; break;
                        case "26": Product_Name = "White Bread"; break;
                        case "27": Product_Name = "Whole Wheat Bread"; break;
                        case "28": Product_Name = "Bacon Sandwich"; break;
                        case "29": Product_Name = "Zesty Halal Chicken"; break;
                        case "30": Product_Name = "Halal Lamb & Mint Pie"; break;
                        case "31": Product_Name = "Dates"; break;
                        default: Product_Name = ""; break;
                    }

                    UserDTO usr = client.getUserID(c.UserId);
                    string Usr_Name = usr?.Name ?? "User";
                    string Usr_Surname = usr?.Surname ?? "";
                    bool isLiked = GetLikedSet(GetUserId()).Contains(Comment_Id);
                    string likedClass = isLiked ? " liked" : "";

                    sb.Append($@"
<div class=""c-card mb-4"">
  <div class=""d-flex align-items-start gap-3"">
    <img class=""avatar""
         src='https://static.vecteezy.com/system/resources/previews/018/765/757/original/user-profile-icon-in-flat-style-member-avatar-illustration-on-isolated-background-human-permission-sign-business-concept-vector.jpg'
         alt='user' />
    <div class=""flex-grow-1"">
      <div class=""d-flex align-items-center justify-content-between flex-wrap gap-2"">
        <div>
          <div class=""name"">{Usr_Name} {Usr_Surname}</div>
          <div class=""time"">{Comment_Date}</div>
        </div>
        <div class=""d-flex align-items-center gap-2"">
          <div class=""d-flex align-items-center gap-2"">
  <button type=""button""
class=""btn p-0 border-0 d-inline-flex align-items-center like-pill text-decoration-none{likedClass}""

          onclick=""__doPostBack('Like','{Comment_Id}')"">
    <svg class=""heart"" viewBox=""0 0 24 24"" fill=""none"" style=""width:22px;height:22px"">
      <path d=""M12.1 20.3C7.14 16.24 4 13.39 4 9.9 4 7.2 6.2 5 8.9 5c1.54 0 3.04.72 4 1.87C13.86 5.72 15.36 5 16.9 5 19.6 5 21.8 7.2 21.8 9.9c0 3.49-3.14 6.34-8.1 10.4l-.8.7-.8-.7z"" stroke=""currentColor"" stroke-width=""1.5""/>
    </svg>
  </button>

  <asp:Label ID=""LikeCount2"" runat=""server"" CssClass=""fw-semibold ms-1"" Text=""34"" />{Comment_Likes}
</div>
        </div>
      </div>
      <p class=""mt-3 mb-0"">{Comment_Description}</p>
      <p class=""mt-3 mb-0 time""> Comment on <b>Product name</b> : {Product_Name}</p>
      <div class=""mt-3 d-flex gap-2"">
        <asp:Button ID=""ReplyToggle2"" runat=""server"" Text=""Reply"" CssClass=""btn btn-ghost px-3"" OnClientClick=""toggleReply('reply2'); return false;"" />
      </div>
      <div id=""reply2"" class=""mt-3 d-none"">
        <textarea class=""form-control reply-box p-3"" rows=""3"" placeholder=""Write a reply...""></textarea>
        <div class=""mt-2 d-flex gap-2"">
          <asp:Button ID=""SendReply2"" runat=""server"" Text=""Send"" CssClass=""btn btn-success px-4"" OnClientClick=""alert('Send reply to backend'); return false;"" />
          <asp:Button ID=""CancelReply2"" runat=""server"" Text=""Cancel"" CssClass=""btn btn-outline-secondary px-3"" OnClientClick=""toggleReply('reply2'); return false;"" />
        </div>
      </div>
    </div>
  </div>
</div>");
                }

                phProducts.Controls.Clear();
                phProducts.Controls.Add(new Literal { Text = sb.ToString() });
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('No Products in the Database');", true);
            }
        }
        protected void BtnPost_Click(object sender, EventArgs e)
        {
            try
            {
                // 1) Validate comment text
                var text = txtComment.Text;
                if (string.IsNullOrWhiteSpace(text))
                {
                    Alert("Please write a comment first.");
                    return;
                }

               
                int userId = GetUserId();
                if (userId == null)
                    int.TryParse(Session["UserId"].ToString(), out userId);

                if (userId <= 0)
                {
                    Alert("You must be logged in to post a comment.");
                    return;
                }

                // 3) Resolve product
                int productId = int.Parse(ddlProducts.SelectedValue);

                // Prefer a hidden field if you have one
                var hf = FindControl("hfProductId") as HiddenField;
                if (hf != null)
                    int.TryParse(hf.Value, out productId);

                // Or a dropdown if that’s what you use
                if (productId <= 0)
                {
                    var ddl = FindControl("ddlProducts") as DropDownList;
                    if (ddl != null)
                        int.TryParse(ddl.SelectedValue, out productId);
                }

                if (productId <= 0)
                {
                    // Optional: allow comments not tied to a product → set to 0 if your DB allows it
                    Alert("Please select a product before posting a comment.");
                    return;
                }

                // 4) Build DTO
                var dto = new CommentDTO
                {
                    UserId = userId,
                    ProductId = productId,
                    Comment = text,
                    Likes = 0,
                    Reply = null,
                };

                // 5) Call WCF
                var ok = client.AddComment(dto);   // bool on your service (as we implemented earlier)
                if (!ok)
                {
                    Alert("Could not post comment. Please try again.");
                    return;
                }
                else {
                    Alert("Comment has been posted.");
                }

                // 6) Clear + refresh
                txtComment.Text = string.Empty;
                BindComments();                    // shows the new comment immediately
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);
                Alert("Unexpected error posting your comment.");
            }
        }

        // Small helper to show a client-side alert
        private void Alert(string msg)
        {
            var safe = HttpUtility.JavaScriptStringEncode(msg ?? string.Empty);
            var script = "alert('" + safe + "');";

            ScriptManager.RegisterStartupScript(
                this, GetType(),
                "alert_" + Guid.NewGuid().ToString("N"),
                script,
                true);
        }

        
    }
}