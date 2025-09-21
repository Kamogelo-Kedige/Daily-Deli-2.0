using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Daily_Deli_E_Commerce.DailyDeliAPI;


namespace Daily_Deli_E_Commerce
{
    public partial class AboutProduct : System.Web.UI.Page
    {
        Service_DailyDeliClient client = new Service_DailyDeliClient();
        protected void Page_Load(object sender, EventArgs e)
        {
            //Extract product id 
            string productId = Request.QueryString["id"];

            if (Session["UserId"] != null && !string.IsNullOrEmpty(productId) && int.TryParse(productId, out int prodId))
            {
                var product = client.GetProduct(prodId); // get the actual product

                if (product != null)
                {
                    //dynamically populate page for products in the database
                    string image = "<img src='" + product.ImageURL + "' alt='" + product.Name +
                                   "' class='img-fluid w-100 h-100' " +
                                   "style='object-fit:cover;border-radius:1.5rem;max-height:560px;max-width:100%;' />";

                    image += "<div class='product-category' " +
                             "style='position:absolute;top:16px;right:16px;" +
                             "background:rgba(255,255,255,0.65);color:var(--accent-color);" +
                             "padding:4px 16px;border-radius:8px;font-size:0.9rem;font-weight:600;" +
                             "backdrop-filter:blur(8px);text-transform:capitalize;'>"
                             + product.CategoryName +
                             "</div>";




                    string description =
                    "<h3 class='product-name fw-bold mb-2 text-start' style='color:var(--brand-color);'>"
                    + product.Name + "</h3>" +

                    "<div class='product-price display-6 fw-bold mb-3 text-start' style='color:var(--accent-color);'>"
                    + "R " + product.Price +
                    "<span class='product-unit' style='font-size:1rem;color:#888;margin-left:8px;'>"
                    + product.Unit + "</span>" +
                    "</div>" +

                    "<p class='product-description mb-4 text-start' style='color:var(--brand-color);'>"
                    + product.Description +
                    "</p>";


                    ProductImage.InnerHtml = image;
                    ProductDescription.InnerHtml = description;
                }
                else
                {
                    ProductDescription.InnerHtml = "<p class='product-description mb-4 text-start' style='color:var(--brand-color);'> Could not load product </p>";
                }

            }
            else
            {
                Response.Redirect("Home.aspx");
            }
        }
    }
}