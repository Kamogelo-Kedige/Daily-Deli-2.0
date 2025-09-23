using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Daily_Deli_E_Commerce.DailyDeliAPI;

namespace Daily_Deli_E_Commerce
{
    public partial class Add_Products : System.Web.UI.Page
    {



        protected void Page_Load(object sender, EventArgs e)
        {

        }

        Service_DailyDeliClient client = new Service_DailyDeliClient();

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string Product_Name = txtName.Text.Trim();
            bool Product_Active = chkActive.Checked;
            string Product_Description = txtDescription.Text.Trim();
            decimal Product_UnitPrice = decimal.Parse(txtPrice.Text.Trim());
            int Product_QuantityInStock = int.Parse(txtStock.Text.Trim());
            bool Product_Common = ChkCommon.Checked;
            int Product_Category = Convert.ToInt32(CategoryList.SelectedValue.Trim());
            string urlImage = Imageurl.Text.Trim();


            if (fuImage.HasFile)
            {
                string fileName = System.IO.Path.GetFileName(fuImage.PostedFile.FileName);
                string Product_Image = "img/Products/" + fileName;

                fuImage.SaveAs(Server.MapPath(Product_Image));

                imgPreview.ImageUrl = Product_Image;
                imgPreview.Visible = true;

                if (client.AddProduct(Product_Name, Product_Description, Product_UnitPrice, Product_QuantityInStock, Product_Image, Product_Active, Product_Common, Product_Category))
                {

                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Product Successfully Saved!!');", true);

                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Product Unsuccessfully Saved!!');", true);

                }

            }
            else
            {

                if (urlImage == null || urlImage == "")
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Could not find Image');", true);

                }
                else
                {


                    if (client.AddProduct(Product_Name, Product_Description, Product_UnitPrice, Product_QuantityInStock, urlImage, Product_Active, Product_Common, Product_Category))
                    {

                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Product Successfully Saved!!');", true);

                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Product Unsuccessfully Saved!!');", true);

                    }


                }



            }
        }

        protected void btnProducts_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin_View_Products.aspx");
        }

        protected void btnAdmin_Page(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }
    }
}
