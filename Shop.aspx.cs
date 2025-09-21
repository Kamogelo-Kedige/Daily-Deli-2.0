using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Daily_Deli_E_Commerce.DailyDeliAPI;


namespace Daily_Deli_E_Commerce
{
    public partial class Shop : System.Web.UI.Page
    {
        Service_DailyDeliClient client = new Service_DailyDeliClient();
        protected void Page_Load(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("Page_Load started");
            if (Session["UserId"] != null)
            {
                int UserId;
                try
                {
                    UserId = (int)Session["UserId"];
                    System.Diagnostics.Debug.WriteLine($"UserId retrieved: {UserId}");
                }
                catch (InvalidCastException ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Invalid UserId cast: {ex.Message}");
                    Response.Redirect("Home.aspx");
                    return;
                }

                // Fetch products with debug
                var products = client.FilterProductsByDiet(UserId);
                System.Diagnostics.Debug.WriteLine($"Products fetched: {products?.Count() ?? 0} items");

                // Inject products with debug
                string json = new JavaScriptSerializer().Serialize(products);
                System.Diagnostics.Debug.WriteLine($"Serialized JSON: {json}");
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "productsData",
                    $"var products = {json}; console.log('Products injected:', {json});",
                    true
                );
                System.Diagnostics.Debug.WriteLine("Products script injected");

                // Inject recipes (preserve existing logic)
                var recipes = client.GetRecipesForUser(UserId);
                string recipeJson = new JavaScriptSerializer().Serialize(recipes);
                ClientScript.RegisterStartupScript(this.GetType(), "recipeData", $"var quickRecipes= {recipeJson};", true);

                // Cart injection with error handling and assignment instead of declaration
                try
                {
                    System.Diagnostics.Debug.WriteLine("Attempting to load cart");
                    string cartJson = client.GetUserCart(UserId) ?? "[]";
                    if (string.IsNullOrEmpty(cartJson) || cartJson == "[]")
                    {
                        System.Diagnostics.Debug.WriteLine("Empty cart JSON returned");
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine($"Cart JSON: {cartJson}");
                    }
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "cartData",
                        $"cart = {cartJson}; console.log('Cart assigned:', cart);",
                        true
                    );
                    System.Diagnostics.Debug.WriteLine("Cart script injected");
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Cart load failed: {ex.Message}");
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "cartData",
                        "cart = []; console.log('Cart load failed, using empty cart');",
                        true
                    );
                }
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("No UserId, redirecting to Home.aspx");
                Response.Redirect("Home.aspx");
            }
        }
    }
}