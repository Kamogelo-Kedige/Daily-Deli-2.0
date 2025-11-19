using System;
using Daily_Deli_E_Commerce.DailyDeliAPI;

namespace Daily_Deli_E_Commerce
{
    public partial class Edit_Products : System.Web.UI.Page
    {
        Service_DailyDeliClient client = new Service_DailyDeliClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // nothing to load on first view
            }
            // Your markup has OnClientClick="return false;" which blocks postback.
            // Clearing it here does not change your front-end file.
            btnSave.OnClientClick = null;
        }

        // ---------- helpers ----------

        private void FillForm(ProductDTO p)
        {
            pid.Value = p.Id.ToString();
            pname.Text = p.Name ;
            pdesc.Text = p.Description ;
            pprice.Text = p.Price.ToString() ;
            pstock.Text = p.StockQuantity.ToString();
            punit.Text = p.Unit ;

           
            int Category = p.CategoryId;

            pcat.ClearSelection();
            switch (Category)
            {
                case 1: pcat.Items.FindByValue("1").Selected = true; break; 
                case 2: pcat.Items.FindByValue("2").Selected = true; break; 
                case 3: pcat.Items.FindByValue("3").Selected = true; break; 
                case 4: pcat.Items.FindByValue("4").Selected = true; break; 
                case 5: pcat.Items.FindByValue("5").Selected = true; break; 
                case 6: pcat.Items.FindByValue("6").Selected = true; break; 
                case 7: pcat.Items.FindByValue("7").Selected = true; break; 
                case 0:
                default:
                    pcat.Items.FindByValue("0").Selected = true;            
                    break;
            }


            pcat.ClearSelection();
            var opt = pcat.Items.FindByValue(p.CategoryId.ToString());
            if (opt != null) opt.Selected = true;

            pimage.Text = p.ImageURL ?? "";
            pactive.Checked = p.IsActive;
            pcommon.Checked = p.IsCommon;

            if (!string.IsNullOrWhiteSpace(p.ImageURL))
            {
                imgPreview.ImageUrl = p.ImageURL;
                imgPreview.CssClass = imgPreview.CssClass.Replace("d-none", "").Trim();
            }
            else
            {
                imgPreview.ImageUrl = "";
                if (!imgPreview.CssClass.Contains("d-none")) imgPreview.CssClass += " d-none";
            }
        }

        private ProductDTO ReadFormToDto()
        {
            var dto = new ProductDTO();

            // id from hidden field or session
            int id = 0;
            int.TryParse(pid.Value, out id);
            if (id == 0 && Session["Product_Id"] != null)
                int.TryParse(Session["Product_Id"].ToString(), out id);
            dto.Id = id;

            dto.Name = (pname.Text ?? "").Trim();
            dto.Description = (pdesc.Text ?? "").Trim();

            decimal price = 0m; decimal.TryParse(pprice.Text, out price);
            dto.Price = Math.Round(price, 2);

            int qty = 0; int.TryParse(pstock.Text, out qty);
            dto.StockQuantity = qty;

            dto.Unit = string.IsNullOrWhiteSpace(punit.Text) ? null : punit.Text.Trim();

            int catId = 0; int.TryParse(pcat.SelectedValue, out catId);
            dto.CategoryId = catId;

            dto.ImageURL = string.IsNullOrWhiteSpace(pimage.Text) ? null : pimage.Text.Trim();

            dto.IsActive = pactive.Checked;
            dto.IsCommon = pcommon.Checked;

            // dto.CreatedAt left untouched
            return dto;
        }

        private void ClearForm()
        {
            pid.Value = "";
            pname.Text = pdesc.Text = pprice.Text = pstock.Text = punit.Text = pimage.Text = "";
            pcat.ClearSelection();
            pactive.Checked = pcommon.Checked = false;
            imgPreview.ImageUrl = "";
            if (!imgPreview.CssClass.Contains("d-none")) imgPreview.CssClass += " d-none";
            Session.Remove("Product_Id");
        }

        private void Toast(string msg)
        {
            ClientScript.RegisterStartupScript(
                GetType(), Guid.NewGuid().ToString(),
                $"alert({System.Web.HttpUtility.JavaScriptStringEncode(msg, addDoubleQuotes: true)});", true);
        }

        // ---------- events ----------

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                int productId;
                if (!int.TryParse(txtSearch.Text, out productId) || productId <= 0)
                {
                    Toast("Please enter a valid numeric Product ID.");
                    return;
                }

                var prod = client.GetProduct(productId);
                if (prod == null)
                {
                    Toast("Couldn't find that Product ID.");
                    return;
                }

                Session["Product_Id"] = productId;
                pid.Value = productId.ToString();

                FillForm(prod);
                Toast("Product loaded.");
            }
            catch
            {
                Toast("Error while searching. Please try again.");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                var dto = ReadFormToDto();
                if (dto.Id <= 0)
                {
                    Toast("Search and load a product first before saving.");
                    return;
                }

                if (string.IsNullOrWhiteSpace(dto.Name) ||
                    string.IsNullOrWhiteSpace(dto.Description) ||
                    dto.Price < 0 || dto.StockQuantity < 0 ||
                    dto.CategoryId <= 0)
                {
                    Toast("Please complete required fields (Name, Description, valid Price/Stock, Category).");
                    return;
                }

                var ok = client.UpdateProduct(dto);
                Toast(ok ? "Product updated successfully." : "Update failed.");
                if (ok)
                {
                    var refreshed = client.GetProduct(dto.Id);
                    if (refreshed != null) FillForm(refreshed);
                }
            }
            catch
            {
                Toast("Error while saving. Please try again.");
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                int id = 0;
                int.TryParse(pid.Value, out id);
                if (id == 0 && Session["Product_Id"] != null)
                    int.TryParse(Session["Product_Id"].ToString(), out id);

                if (id <= 0)
                {
                    Toast("Search and load a product first before deleting.");
                    return;
                }

                var ok = client.DeleteProduct(new ProductDTO { Id = id });
                Toast(ok ? "Product deleted." : "Delete failed.");
                if (ok) ClearForm();
            }
            catch
            {
                Toast("Error while deleting. Please try again.");
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            ClearForm();
            Toast("Form cleared.");
        }

        protected void btnAdmin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }
    }
}
