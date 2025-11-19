using Daily_Deli_E_Commerce.DailyDeliAPI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Daily_Deli_E_Commerce
{
    public partial class Loyalty_Discoumt : System.Web.UI.Page
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

        // ---------- helper functions ----------

        private void FillForm(PromoCodeDTO t)
        {
            pid.Value = t.Id.ToString();
            userid.Text = t.UserId.ToString();
            code.Text = t.Code.ToString();
            type.Text = t.Type.ToString();
            value.Text = t.Value.ToString();
            status.Text = t.Status.ToString();
        }

        private PromoCodeDTO ReadFormToDto()
        {
            var dto = new PromoCodeDTO();

            // id from hidden field or session
            int id = 0;
            int.TryParse(pid.Value, out id);
            if (id == 0 && Session["Promo_ID"] != null)
                int.TryParse(Session["Promo_ID"].ToString(), out id);
            dto.Id = id;

            dto.UserId = Convert.ToInt32((userid.Text ?? "").Trim());
            dto.Value = Convert.ToDecimal((value.Text ?? "").Trim());

            dto.Code = code.Text;

            dto.Type = string.IsNullOrWhiteSpace(type.Text) ? "" : type.Text.Trim();

            dto.Status = string.IsNullOrWhiteSpace(status.Text) ? "" : status.Text.Trim();

            // dto.CreatedAt left untouched
            return dto;
        }

        private void ClearForm()
        {
            pid.Value = "";
            userid.Text = value.Text = code.Text = status.Text = type.Text = "";
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
                int promo_id;
                if (!int.TryParse(txtSearch.Text, out promo_id) || promo_id <= 0)
                {
                    Toast("Please enter a valid numeric Promo ID.");
                    return;
                }

                //var prod = client.GetProduct(transaction_id);
                var promo = client.GetPromo(promo_id);
                if (promo == null)
                {
                    Toast("Couldn't find that Promo ID.");
                    return;
                }

                Session["Promo_ID"] = promo_id;
                pid.Value = promo_id.ToString();

                FillForm(promo);
                Toast("Promo loaded.");
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
                    Toast("Search and load a Promo first before saving.");
                    return;
                }

                if (string.IsNullOrWhiteSpace(dto.Status) ||
                    string.IsNullOrWhiteSpace(dto.Type) ||
                    dto.Value < 0 || dto.UserId < 0)
                {
                    Toast("Please complete required fields (Name, Description, valid Price/Stock, Category).");
                    return;
                }

                var ok = client.UpdatePromo(dto);
                Toast(ok ? "Promo updated successfully." : "Update failed.");
                if (ok)
                {
                    var refreshed = client.GetPromo(dto.Id);
                    if (refreshed != null) FillForm(refreshed);
                }

                gvPromoCode.DataBind();
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
                if (id == 0 && Session["Promo_ID"] != null)
                    int.TryParse(Session["Promo_ID"].ToString(), out id);

                if (id <= 0)
                {
                    Toast("Search and load a Promo first before deleting.");
                    return;
                }

                var ok = client.DeleteTransaction(id);
                Toast(ok ? "Promo deleted." : "Delete failed.");
                if (ok) ClearForm();

                gvPromoCode.DataBind();
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