using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Daily_Deli_E_Commerce.DailyDeliAPI;


namespace Daily_Deli_E_Commerce
{
    public partial class Edit_Products : System.Web.UI.Page
    {
        Service_DailyDeliClient client = new Service_DailyDeliClient();
        ProductDTO prod = new ProductDTO();

        protected void Page_Load(object sender, EventArgs e)
        {


        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try {
                int Product_Id = int.Parse(txtSearch.Text);

                Session["Product_Id"] = Product_Id;

                prod = client.GetProduct(Product_Id);

                if ((prod == null))
                {



                }
                else
                {

                    Response.Write("<script>alert('Couldnt find Id or Name in the DataBase ,Please try again')</script>");
                }



            }
            catch {

                Response.Write("<script>alert('Please enter the ID to edit the product')</script>");


            }



        }

        protected void btnAdmin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }
    }
}