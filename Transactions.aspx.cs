using Daily_Deli_E_Commerce.DailyDeliAPI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Daily_Deli_E_Commerce
{
    public partial class Transactions : System.Web.UI.Page
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

        private void FillForm(TransactionDTO t)
        {
            pid.Value = t.Id.ToString();
            userid.Text = t.UserId.ToString();
            amount.Text = t.TaxAmount.ToString();
            date.Text = t.TransactionDate.ToString();
            method.Text = t.PaymentMethod;
            s_fee.Text = t.ShippingFee.ToString();
            t_amount.Text = t.TaxAmount.ToString();
        }

        private TransactionDTO ReadFormToDto()
        {
            var dto = new TransactionDTO();

            // id from hidden field or session
            int id = 0;
            int.TryParse(pid.Value, out id);
            if (id == 0 && Session["Transaction_Id"] != null)
                int.TryParse(Session["Transaction_Id"].ToString(), out id);
            dto.Id = id;

            dto.UserId = Convert.ToInt32((userid.Text ?? "").Trim());
            dto.TotalAmount = Convert.ToDecimal((amount.Text ?? "").Trim());

            //decimal price = 0m; decimal.TryParse(pprice.Text, out price);
            dto.TransactionDate = DateTime.Parse(date.Text);

            dto.PaymentMethod = method.Text;

            dto.ShippingFee = string.IsNullOrWhiteSpace(s_fee.Text) ? 0 : Convert.ToDecimal(s_fee.Text.Trim());

            dto.TaxAmount = string.IsNullOrWhiteSpace(t_amount.Text) ? 0 : Convert.ToDecimal(t_amount.Text.Trim());

            // dto.CreatedAt left untouched
            return dto;
        }

        private void ClearForm()
        {
            pid.Value = "";
            userid.Text = amount.Text = date.Text = method.Text = s_fee.Text = t_amount.Text = "";
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
                int transaction_id;
                if (!int.TryParse(txtSearch.Text, out transaction_id) || transaction_id <= 0)
                {
                    Toast("Please enter a valid numeric Traansaction ID.");
                    return;
                }

                //var prod = client.GetProduct(transaction_id);
                var trans = client.GetTransaction(transaction_id);
                if (trans == null)
                {
                    Toast("Couldn't find that Product ID.");
                    return;
                }

                Session["Transaction_ID"] = transaction_id;
                pid.Value = transaction_id.ToString();

                FillForm(trans);
                Toast("Transaction loaded.");
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
                    Toast("Search and load a transaction first before saving.");
                    return;
                }

                if (string.IsNullOrWhiteSpace(dto.Status) ||
                    string.IsNullOrWhiteSpace(dto.PaymentMethod) ||
                    dto.ShippingFee < 0 || dto.UserId < 0 ||
                    dto.TaxAmount < 0)
                {
                    Toast("Please complete required fields (Name, Description, valid Price/Stock, Category).");
                    return;
                }

                var ok = client.UpdateTransaction(dto);
                Toast(ok ? "Transaction updated successfully." : "Update failed.");
                if (ok)
                {
                    var refreshed = client.GetTransaction(dto.Id);
                    if (refreshed != null) FillForm(refreshed);
                }

                gvTransactions.DataBind();
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
                if (id == 0 && Session["Transaction_ID"] != null)
                    int.TryParse(Session["Transaction_ID"].ToString(), out id);

                if (id <= 0)
                {
                    Toast("Search and load a transaction first before deleting.");
                    return;
                }

                var ok = client.DeleteTransaction(id);
                Toast(ok ? "Transaction deleted." : "Delete failed.");
                if (ok) ClearForm();

                gvTransactions.DataBind();
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