using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using Daily_Deli_E_Commerce.DailyDeliAPI;

namespace Daily_Deli_E_Commerce
{
    public partial class AboutProductCommentPage : System.Web.UI.Page
    {
        Service_DailyDeliClient client = new Service_DailyDeliClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["productId"] != null && int.TryParse(Request.QueryString["productId"], out int productId))
                {
                    // Fetch product details to get name
                    ProductDTO product = client.GetProduct(productId);
                    if (product != null)
                    {
                        litProductName.Text = product.Name;
                    }
                    else
                    {
                        litProductName.Text = "Product";
                    }

                    // Fetch top 3 comments
                    DailyDeliAPI.CommentDTO[] commentArray = client.GetCommentsByProductId(productId);
                    List<DailyDeliAPI.CommentDTO> comments = commentArray != null ? commentArray.ToList() : new List<DailyDeliAPI.CommentDTO>();

                    if (comments != null && comments.Count > 0)
                    {
                        rptComments.DataSource = comments;
                        rptComments.DataBind();
                    }
                    else
                    {
                        litNoComments.Visible = true;
                    }
                }
                else
                {
                    // Invalid or missing productId - redirect or show error
                    Response.Redirect("Checkout.aspx");
                }
            }
        }
    }
}