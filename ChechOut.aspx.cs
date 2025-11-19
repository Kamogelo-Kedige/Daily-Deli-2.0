using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Daily_Deli_E_Commerce.DailyDeliAPI;
using System.Net.Mail;
using System.Net;

namespace Daily_Deli_E_Commerce
{
    public partial class ChechOut : System.Web.UI.Page
    {
        Service_DailyDeliClient client = new Service_DailyDeliClient();
        private const decimal TaxRate = 0.15m;
        private const decimal PromoDiscountRate = 0.20m;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Home.aspx");
                return;
            }

            int UserId = (int)Session["UserId"];
            System.Diagnostics.Debug.WriteLine($"Page_Load started for UserId: {UserId}");

            if (!IsPostBack)
            {
                UserDTO user = client.GetUserDetails(UserId);
                if (user != null)
                {
                    txtEmail.Text = user.Email;
                    txtFirstName.Text = user.Name;
                    txtLastName.Text = user.Surname;
                    txtPhoneNumber.Text = user.PhoneNumber ?? Request.QueryString["phone"] ?? "";
                    txtAddress.Text = user.AddressLine1 ?? Request.QueryString["address"] ?? "";
                    txtCity.Text = user.City ?? Request.QueryString["city"] ?? "";
                    txtPostalCode.Text = user.PostalCode ?? Request.QueryString["postal"] ?? "";
                    System.Diagnostics.Debug.WriteLine($"User details loaded: {user.Email}");
                }

                // Check for promo code success message from query string
                if (Request.QueryString["promoApplied"] == "true")
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "successAlert", "alert('Promo code applied successfully!');", true);
                }
            }

            string cartJson = client.GetUserCart(UserId) ?? "[]";
            System.Diagnostics.Debug.WriteLine($"Cart JSON fetched: {cartJson}");
            var serializer = new JavaScriptSerializer();
            var cart = serializer.Deserialize<List<CartItem>>(cartJson) ?? new List<CartItem>();
            System.Diagnostics.Debug.WriteLine($"Cart items count: {cart.Count}");

            List<PromoCodeDTO> activePromos = client.GetActivePromoCodes(UserId)?.ToList() ?? new List<PromoCodeDTO>();
            System.Diagnostics.Debug.WriteLine($"Active promo codes: {activePromos.Count}");

            var groupedCart = cart.GroupBy(item => item.Name)
                                 .Select(g => new
                                 {
                                     Id = g.First().Id,
                                     Name = g.Key,
                                     Quantity = g.Sum(item => item.Quantity),
                                     FinalPrice = g.First().Price,
                                     ImageURL = g.First().ImageURL,
                                     OriginalPrice = g.First().Price / (1 + TaxRate),
                                     TaxPerItem = g.First().Price - (g.First().Price / (1 + TaxRate))
                                 }).ToList();

            decimal total = groupedCart.Sum(item => item.FinalPrice * item.Quantity);
            decimal totalTax = groupedCart.Sum(item => item.TaxPerItem * item.Quantity);
            int totalItems = groupedCart.Sum(item => item.Quantity);
            decimal shipping = CalculateShipping(totalItems, total);
            decimal discount = Session["AppliedDiscount"] as decimal? ?? 0m;
            decimal grandTotal = total + shipping - discount;

            string totalFormatted = $"R{total:F2}";
            string totalTaxFormatted = $"R{totalTax:F2}";
            string shippingFormatted = $"R{shipping:F2}";
            string discountFormatted = $"R{discount:F2}";
            string grandFormatted = $"R{grandTotal:F2}";
            string totalItemsFormatted = $"{totalItems} Item{(totalItems != 1 ? "s" : "")}";

            string script = @"
                document.addEventListener('DOMContentLoaded', function () {
                    var cartItemsDiv = document.getElementById('dynamic-cart-items');
                    var totalsDiv = document.querySelector('.totals');
                    var promosDiv = document.getElementById('active-promos');
                    cartItemsDiv.innerHTML = '';

                    " + (activePromos.Count > 0 ? "promosDiv.innerHTML = '<h3 style=\"font-size: 16px; margin-bottom: 10px;\">Your Active Promo Codes:</h3>';" : "promosDiv.innerHTML = '';") + @"
                    " + string.Join("", activePromos.Select(promo => $@"var promoCard = document.createElement('div');
                        promoCard.className = 'promo-card';
                        promoCard.innerHTML = `<span>{promo.Code}</span><button type=""button"" onclick=""copyCode('{promo.Code}')"" >Copy</button>`;
                        promosDiv.appendChild(promoCard);")) + @"

                    var totalItemsSpan = document.createElement('div');
                    totalItemsSpan.id = 'total-items';
                    totalItemsSpan.innerHTML = '<span style=""font-size: 18px; font-weight: bold; color: #0077cc;"">" + totalItemsFormatted + @"</span>';
                    cartItemsDiv.parentNode.insertBefore(totalItemsSpan, cartItemsDiv);

                    " + (cart.Count > 0 ? string.Join("", groupedCart.Select(item => $@"var itemLink = document.createElement('a');
                        itemLink.href = 'AboutProductCommentPage.aspx?productId={item.Id}';
                        itemLink.style.textDecoration = 'none';
                        itemLink.style.color = 'inherit';
                        itemLink.style.cursor = 'pointer';
                        var itemDiv = document.createElement('div');
                        itemDiv.className = 'cart-item';
                        itemDiv.innerHTML = `<img src='{item.ImageURL}' alt='{item.Name}' style='width: 110px; margin-right: 15px; border-radius: 8px;' onerror='this.onerror=null;this.src=""img/Hero.webp""' /><div style='flex-grow: 1;'><p style='font-size: 16px; font-weight: bold; margin: 0;'>{item.Name} <span style='color: #0077cc;'>x{item.Quantity}</span></p><p style='color: #555; margin: 2px 0;'>R{item.OriginalPrice:F2} each (excl. VAT)</p><p style='color: #555; margin: 2px 0;'>VAT (15%): R{item.TaxPerItem:F2}</p></div><span class='price' style='font-weight: bold; color: #000;'>R{(item.FinalPrice * item.Quantity):F2}</span>`;
                        itemLink.appendChild(itemDiv);
                        cartItemsDiv.appendChild(itemLink);")) : "cartItemsDiv.innerHTML = '<p style=\"text-align: center; color: #555;\">Your cart is empty.</p>';") + @"

                    totalsDiv.innerHTML = '';

                    var totalTaxP = document.createElement('p');
                    totalTaxP.innerHTML = `<span class='total-label'>VAT (15%)</span><span class='total-amount'>" + totalTaxFormatted + @"</span>`;
                    totalsDiv.appendChild(totalTaxP);

                    var subtotalP = document.createElement('p');
                    subtotalP.innerHTML = `<span class='total-label'>Subtotal</span><span class='total-amount'>" + totalFormatted + @"</span>`;
                    totalsDiv.appendChild(subtotalP);

                    var shippingP = document.createElement('p');
                    shippingP.innerHTML = `<span class='total-label'>Shipping Fee</span><span class='total-amount'>" + shippingFormatted + @"</span>`;
                    totalsDiv.appendChild(shippingP);

                    if (" + discount + @" > 0) {
                        var discountP = document.createElement('p');
                        discountP.innerHTML = `<span class='total-label'>Discount (20%)</span><span class='total-amount'>- " + discountFormatted + @"</span>`;
                        totalsDiv.appendChild(discountP);
                    }

                    var grandTotalP = document.createElement('p');
                    grandTotalP.className = 'grand-total';
                    grandTotalP.innerHTML = `<span class='total-label'>Grand Total</span><span class='total-amount'>" + grandFormatted + @"</span>`;
                    totalsDiv.appendChild(grandTotalP);

                    var btnContinue = document.getElementById('" + btnContinue.ClientID + @"');
                    var paymentPanel = document.getElementById('paymentPanel');
                    var paymentOverlay = document.getElementById('paymentOverlay');
                    var phoneNumber = document.getElementById('" + txtPhoneNumber.ClientID + @"');
                    var address = document.getElementById('" + txtAddress.ClientID + @"');
                    var city = document.getElementById('" + txtCity.ClientID + @"');
                    var postalCode = document.getElementById('" + txtPostalCode.ClientID + @"');

                    btnContinue.onclick = function(event) {
                        event.preventDefault();
                        if (phoneNumber.value.trim() && address.value.trim() && city.value.trim() && postalCode.value.trim()) {
                            paymentOverlay.classList.add('active');
                            paymentPanel.classList.add('active');
                        } else {
                            alert('Please fill in all shipping address fields.');
                        }
                    };

                    document.querySelector('.close-btn').onclick = function() {
                        paymentOverlay.classList.remove('active');
                        paymentPanel.classList.remove('active');
                    };

                    paymentOverlay.onclick = function() {
                        paymentOverlay.classList.remove('active');
                        paymentPanel.classList.remove('active');
                    };
                });
            ";
            ClientScript.RegisterStartupScript(this.GetType(), "renderCart", script, true);
            System.Diagnostics.Debug.WriteLine("Cart rendering script injected");
        }

        private decimal CalculateShipping(int totalItems, decimal orderTotal)
        {
            if (orderTotal >= 1000m) return 0m;

            decimal baseFee = 50m;
            decimal perAdditionalItem = 10m;
            decimal additional = totalItems > 1 ? perAdditionalItem * (totalItems - 1) : 0m;
            decimal shipping = baseFee + additional;

            return Math.Min(shipping, 200m);
        }

        private string GenerateInvoiceHtml(int userId, List<CartItem> cart)
        {
            UserDTO user = client.GetUserDetails(userId);
            decimal total = cart.Sum(item => item.Price * item.Quantity);
            decimal totalTax = cart.Sum(item => (item.Price - (item.Price / (1 + TaxRate))) * item.Quantity);
            int totalItems = cart.Sum(item => item.Quantity);
            decimal shipping = CalculateShipping(totalItems, total);
            decimal discount = Session["AppliedDiscount"] as decimal? ?? 0m;
            decimal grandTotal = total + shipping - discount;
            string invoiceNumber = DateTime.Now.ToString("yyyyMMddHHmmss");

            string html = $@"
                <div style='font-family: Arial, Helvetica, sans-serif; width: 100%; max-width: 800px; margin: 0 auto; background: #ffffff; padding: 20px; border: 1px solid #4a6cf7; border-radius: 8px; max-height: 80vh; overflow-y: auto;'>
                    <div style='text-align: center; margin-bottom: 40px;'>
                        <h1 style='color: #4a6cf7; font-size: 36px; margin: 0; font-weight: bold;'>Daily Deli</h1>
                        <img style='width:150px; height:80px' src='https://tse4.mm.bing.net/th/id/OIP.PZnyvI-K89cg0MGEXycttgHaEv?r=0&rs=1&pid=ImgDetMain&o=7&rm=3' alt='Daily Deli Logo' style='margin-top: 10px;'>
                        <p style='color: #718096; font-size: 16px; margin: 5px 0;'>Freshness Delivered to Your Doorstep</p>
                        <p style='color: #718096; font-size: 14px;'>123 Tasteful Lane, Johannesburg, South Africa | VAT: ZA123456789</p>
                        <p style='color: #718096; font-size: 14px;'>Phone: +27 11 555 0123 | Email: info@dailydeli.com | www.dailydeli.com</p>
                    </div>
                    <div style='background: #f8faff; padding: 25px; border-radius: 8px; margin-bottom: 40px; border: 1px solid #e0e5f3;'>
                        <h2 style='color: #4a6cf7; font-size: 24px; margin: 0 0 15px; font-weight: 600;'>Invoice Details</h2>
                        <div style='display: flex; justify-content: space-between; font-size: 16px; color: #2d3748;'>
                            <div>
                                <p><strong>Invoice #:</strong> {invoiceNumber}</p>
                                <p><strong>Date Issued:</strong> {DateTime.Now.ToString("MMMM dd, yyyy")}</p>
                            </div>
                            <div>
                                <p><strong>Payment Method:</strong> Credit Card</p>
                                <p><strong>Status:</strong> <span style='color: #2ecc71;'>Paid</span></p>
                            </div>
                        </div>
                    </div>
                    <div style='margin-bottom: 40px;'>
                        <h2 style='color: #4a6cf7; font-size: 24px; margin: 0 0 15px; font-weight: 600;'>Bill To</h2>
                        <div style='background: #f8faff; padding: 25px; border-radius: 8px; border: 1px solid #e0e5f3;'>
                            <p style='margin: 5px 0; color: #2d3748;'><strong>Customer:</strong> {user.Name} {user.Surname}</p>
                            <p style='margin: 5px 0; color: #2d3748;'><strong>Email:</strong> {user.Email}</p>
                            <p style='margin: 5px 0; color: #2d3748;'><strong>Phone:</strong> {user.PhoneNumber}</p>
                            <p style='margin: 5px 0; color: #2d3748;'><strong>Address:</strong> {user.AddressLine1}, {user.City}, {user.PostalCode}</p>
                        </div>
                    </div>
                    <div style='margin-bottom: 40px;'>
                        <h2 style='color: #4a6cf7; font-size: 24px; margin: 0 0 15px; font-weight: 600;'>Items Purchased</h2>
                        <table style='width: 100%; border-collapse: collapse; background: #f8faff; border-radius: 8px; overflow: hidden;'>
                            <thead>
                                <tr style='background: #4a6cf7; color: #ffffff;'>
                                    <th style='padding: 12px; text-align: left; border-bottom: 2px solid #e0e5f3;'>Product</th>
                                    <th style='padding: 12px; text-align: center; border-bottom: 2px solid #e0e5f3;'>Quantity</th>
                                    <th style='padding: 12px; text-align: right; border-bottom: 2px solid #e0e5f3;'>Price (excl. VAT)</th>
                                    <th style='padding: 12px; text-align: right; border-bottom: 2px solid #e0e5f3;'>VAT (15%)</th>
                                    <th style='padding: 12px; text-align: right; border-bottom: 2px solid #e0e5f3;'>Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                {string.Join("", cart.Select(item => $@"<tr style='border-bottom: 1px solid #e0e5f3;'>
                                    <td style='padding: 12px; color: #2d3748;'>{item.Name}</td>
                                    <td style='padding: 12px; text-align: center; color: #2d3748;'>{item.Quantity}</td>
                                    <td style='padding: 12px; text-align: right; color: #2d3748;'>R{(item.Price / (1 + TaxRate)):F2}</td>
                                    <td style='padding: 12px; text-align: right; color: #2d3748;'>R{(item.Price - (item.Price / (1 + TaxRate))):F2}</td>
                                    <td style='padding: 12px; text-align: right; color: #2d3748;'>R{(item.Price * item.Quantity):F2}</td>
                                </tr>"))}
                                <tr style='background: #f8faff; font-weight: bold;'>
                                    <td colspan='3' style='padding: 12px; text-align: right; color: #2d3748;'>Total VAT (15%)</td>
                                    <td style='padding: 12px; text-align: right; color: #2d3748;'>R{totalTax:F2}</td>
                                    <td></td>
                                </tr>
                                <tr style='background: #f8faff; font-weight: bold;'>
                                    <td colspan='4' style='padding: 12px; text-align: right; color: #2d3748;'>Subtotal</td>
                                    <td style='padding: 12px; text-align: right; color: #2d3748;'>R{total:F2}</td>
                                </tr>
                                <tr style='background: #f8faff; font-weight: bold;'>
                                    <td colspan='4' style='padding: 12px; text-align: right; color: #2d3748;'>Shipping Fee</td>
                                    <td style='padding: 12px; text-align: right; color: #2d3748;'>R{shipping:F2}</td>
                                </tr>
                                <tr style='background: #f8faff; font-weight: bold;'>
                                    <td colspan='4' style='padding: 12px; text-align: right; color: #2d3748;'>Discount (20%)</td>
                                    <td style='padding: 12px; text-align: right; color: #2d3748;'>- R{discount:F2}</td>
                                </tr>
                                <tr style='background: #f8faff; font-weight: bold;'>
                                    <td colspan='4' style='padding: 12px; text-align: right; color: #e74c3c; background: rgba(74, 108, 247, 0.05);'>Grand Total</td>
                                    <td style='padding: 12px; text-align: right; color: #e74c3c; background: rgba(74, 108, 247, 0.05);'>R{grandTotal:F2}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div style='margin-bottom: 40px;'>
                        <h2 style='color: #4a6cf7; font-size: 24px; margin: 0 0 15px; font-weight: 600;'>About Daily Deli</h2>
                        <div style='background: #f8faff; padding: 25px; border-radius: 8px; border: 1px solid #e0e5f3;'>
                            <p style='margin: 5px 0; color: #2d3748;'>Daily Deli is your trusted partner in delivering fresh, high-quality deli products straight to your table. Established in 2015, we pride ourselves on sourcing the finest ingredients from local South African farmers.</p>
                            <p style='margin: 5px 0; color: #2d3748;'>Our mission is to bring convenience and flavor to every household, with a commitment to sustainability and customer satisfaction.</p>
                        </div>
                    </div>
                    <div style='margin-bottom: 40px;'>
                        <h2 style='color: #4a6cf7; font-size: 24px; margin: 0 0 15px; font-weight: 600;'>Terms & Conditions</h2>
                        <div style='background: #f8faff; padding: 25px; border-radius: 8px; border: 1px solid #e0e5f3;'>
                            <p style='margin: 5px 0; color: #2d3748;'>- Payment is due within 30 days from the invoice date.</p>
                            <p style='margin: 5px 0; color: #2d3748;'>- All prices are inclusive of VAT.</p>
                            <p style='margin: 5px 0; color: #2d3748;'>- Returns accepted within 7 days with original packaging.</p>
                            <p style='margin: 5px 0; color: #2d3748;'>- Please quote the invoice number in all correspondence.</p>
                        </div>
                    </div>
                    <div style='text-align: center; border-top: 1px solid #e0e5f3; padding-top: 20px; color: #718096; font-size: 14px;'>
                        <p>Thank you for choosing Daily Deli! For inquiries, contact us at <a href='mailto:info@dailydeli.com' style='color: #4a6cf7; text-decoration: none;'>info@dailydeli.com</a> or +27 11 555 0123.</p>
                        <p>&copy; 2025 Daily Deli. All rights reserved.</p>
                    </div>
                </div>
            ";
            return html;
        }

        private bool SendInvoiceEmail(int userId, List<CartItem> cart, string invoiceNumber)
        {
            try
            {
                UserDTO user = client.GetUserDetails(userId);
                if (user == null || string.IsNullOrEmpty(user.Email))
                {
                    System.Diagnostics.Debug.WriteLine("User or email not found for UserId: " + userId);
                    return false;
                }

                decimal total = cart.Sum(item => item.Price * item.Quantity);
                decimal totalTax = cart.Sum(item => (item.Price - (item.Price / (1 + TaxRate))) * item.Quantity);
                int totalItems = cart.Sum(item => item.Quantity);
                decimal shipping = CalculateShipping(totalItems, total);
                decimal discount = Session["AppliedDiscount"] as decimal? ?? 0m;
                decimal grandTotal = total + shipping - discount;

                string fromEmail = "delidaily186@gmail.com";
                string smtpServer = "smtp.gmail.com";
                int smtpPort = 587;
                string smtpUsername = "delidaily186@gmail.com";
                string smtpPassword = "rkgp dugf euck lpzd";

                string emailBody = $@"
                    <!DOCTYPE html>
                    <html lang='en'>
                    <head>
                        <meta charset='UTF-8'>
                        <meta name='viewport' content='width=device-width, initial-scale=1.0'>
                        <title>Daily Deli Purchase Confirmation</title>
                        <style>
                            body {{ font-family: 'Arial', 'Helvetica', sans-serif; background-color: #f8faff; margin: 0; padding: 20px; }}
                            .container {{ max-width: 600px; margin: 0 auto; background: #ffffff; border-radius: 8px; border: 1px solid #4a6cf7; padding: 20px; box-shadow: 0 5px 15px rgba(74, 108, 247, 0.1); }}
                            .header {{ text-align: center; margin-bottom: 30px; }}
                            .header img {{ width: 150px; height: 80px; margin-top: 10px; }}
                            .header h1 {{ color: #4a6cf7; font-size: 28px; margin: 0; font-weight: bold; }}
                            .header p {{ color: #718096; font-size: 14px; margin: 5px 0; }}
                            .section {{ margin-bottom: 30px; background: #f8faff; padding: 20px; border-radius: 8px; border: 1px solid #e0e5f3; }}
                            .section h2 {{ color: #4a6cf7; font-size: 20px; margin: 0 0 15px; font-weight: 600; }}
                            .details {{ display: flex; justify-content: space-between; font-size: 14px; color: #2d3748; }}
                            .details p {{ margin: 5px 0; }}
                            .table {{ width: 100%; border-collapse: collapse; margin-top: 10px; }}
                            .table th, .table td {{ padding: 10px; text-align: left; border-bottom: 1px solid #e0e5f3; }}
                            .table th {{ background: #4a6cf7; color: #ffffff; font-weight: 600; }}
                            .table td {{ color: #2d3748; }}
                            .table .total {{ font-weight: bold; }}
                            .table .grand-total {{ color: #e74c3c; background: rgba(74, 108, 247, 0.05); }}
                            .footer {{ text-align: center; border-top: 1px solid #e0e5f3; padding-top: 20px; color: #718096; font-size: 12px; }}
                            .footer a {{ color: #4a6cf7; text-decoration: none; }}
                            .button {{ display: inline-block; padding: 10px 20px; background: linear-gradient(135deg, #4a6cf7, #6b8cff); color: #ffffff; text-decoration: none; border-radius: 5px; margin-top: 20px; font-weight: 600; }}
                            @media (max-width: 600px) {{ .container {{ padding: 15px; }} .details {{ flex-direction: column; }} .table th, .table td {{ font-size: 12px; padding: 8px; }} }}
                        </style>
                    </head>
                    <body>
                        <div class='container'>
                            <div class='header'>
                                <h1>Daily Deli</h1>
                                <img src='https://tse4.mm.bing.net/th/id/OIP.PZnyvI-K89cg0MGEXycttgHaEv?r=0&rs=1&pid=ImgDetMain&o=7&rm=3' alt='Daily Deli Logo'>
                                <p>Freshness Delivered to Your Doorstep</p>
                                <p>123 Tasteful Lane, Johannesburg, South Africa | VAT: ZA123456789</p>
                                <p>Phone: +27 11 555 0123 | Email: <a href='mailto:info@dailydeli.com'>info@dailydeli.com</a> | www.dailydeli.com</p>
                            </div>
                            <div class='section'>
                                <h2>Thank You for Your Purchase!</h2>
                                <p style='color: #2d3748;'>Dear {user.Name} {user.Surname},</p>
                                <p style='color: #2d3748;'>Thank you for shopping with Daily Deli! Your order has been successfully processed. Please find your invoice details below</p>
                            </div>
                            <div class='section'>
                                <h2>Invoice Details</h2>
                                <div class='details'>
                                    <div>
                                        <p><strong>Invoice #:</strong> {invoiceNumber}</p>
                                        <p><strong>Date Issued:</strong> {DateTime.Now.ToString("MMMM dd, yyyy")}</p>
                                    </div>
                                    <div>
                                        <p><strong>Payment Method:</strong> Credit Card</p>
                                        <p><strong>Status:</strong> <span style='color: #2ecc71;'>Paid</span></p>
                                    </div>
                                </div>
                            </div>
                            <div class='section'>
                                <h2>Bill To</h2>
                                <p><strong>Customer:</strong> {user.Name} {user.Surname}</p>
                                <p><strong>Email:</strong> {user.Email}</p>
                                <p><strong>Phone:</strong> {user.PhoneNumber ?? "Not provided"}</p>
                                <p><strong>Address:</strong> {user.AddressLine1 ?? "Not provided"}, {user.City ?? "Not provided"}, {user.PostalCode ?? "Not provided"}</p>
                            </div>
                            <div class='section'>
                                <h2>Items Purchased</h2>
                                <table class='table'>
                                    <thead>
                                        <tr>
                                            <th>Product</th>
                                            <th style='text-align: center;'>Quantity</th>
                                            <th style='text-align: right;'>Price (excl. VAT)</th>
                                            <th style='text-align: right;'>VAT (15%)</th>
                                            <th style='text-align: right;'>Total</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {string.Join("", cart.Select(item => $@"<tr>
                                            <td>{item.Name}</td>
                                            <td style='text-align: center;'>{item.Quantity}</td>
                                            <td style='text-align: right;'>R{(item.Price / (1 + TaxRate)):F2}</td>
                                            <td style='text-align: right;'>R{(item.Price - (item.Price / (1 + TaxRate))):F2}</td>
                                            <td style='text-align: right;'>R{(item.Price * item.Quantity):F2}</td>
                                        </tr>"))}
                                        <tr class='total'>
                                            <td colspan='3' style='text-align: right;'>Total VAT (15%)</td>
                                            <td style='text-align: right;'>R{totalTax:F2}</td>
                                            <td></td>
                                        </tr>
                                        <tr class='total'>
                                            <td colspan='4' style='text-align: right;'>Subtotal</td>
                                            <td style='text-align: right;'>R{total:F2}</td>
                                        </tr>
                                        <tr class='total'>
                                            <td colspan='4' style='text-align: right;'>Shipping Fee</td>
                                            <td style='text-align: right;'>R{shipping:F2}</td>
                                        </tr>
                                        <tr class='total'>
                                            <td colspan='4' style='text-align: right;'>Discount (20%)</td>
                                            <td style='text-align: right;'>- R{discount:F2}</td>
                                        </tr>
                                        <tr class='grand-total'>
                                            <td colspan='4' style='text-align: right;'>Grand Total</td>
                                            <td style='text-align: right;'>R{grandTotal:F2}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class='footer'>
                                <p>Thank you for choosing Daily Deli! For inquiries, contact us at <a href='mailto:info@dailydeli.com'>info@dailydeli.com</a> or +27 11 555 0123.</p>
                                <p>&copy; 2025 Daily Deli. All rights reserved.</p>
                            </div>
                        </div>
                    </body>
                    </html>
                ";

                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(fromEmail, "Daily Deli");
                mail.To.Add(user.Email);
                mail.Subject = $"Daily Deli Purchase Confirmation - Invoice #{invoiceNumber}";
                mail.Body = emailBody;
                mail.IsBodyHtml = true;

                SmtpClient smtp = new SmtpClient(smtpServer, smtpPort);
                smtp.Credentials = new NetworkCredential(smtpUsername, smtpPassword);
                smtp.EnableSsl = true;
                smtp.Send(mail);

                System.Diagnostics.Debug.WriteLine($"Email sent to {user.Email} for invoice {invoiceNumber}");
                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Email sending failed: {ex.Message}");
                return false;
            }
        }

        protected void btnPayNow_Click1(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Home.aspx");
                return;
            }

            int UserId = (int)Session["UserId"];
            System.Diagnostics.Debug.WriteLine($"btnPayNow_Click1 started for UserId: {UserId}");

            if (!string.IsNullOrEmpty(txtPhoneNumber.Text.Trim()) ||
                !string.IsNullOrEmpty(txtAddress.Text.Trim()) ||
                !string.IsNullOrEmpty(txtCity.Text.Trim()) ||
                !string.IsNullOrEmpty(txtPostalCode.Text.Trim()))
            {
                client.UpdateUserAddress(UserId, txtPhoneNumber.Text, txtAddress.Text, txtCity.Text, txtPostalCode.Text);
                System.Diagnostics.Debug.WriteLine("Address updated");
            }

            string cartJson = client.GetUserCart(UserId) ?? "[]";
            System.Diagnostics.Debug.WriteLine($"Fetched cart JSON: {cartJson}");
            var serializer = new JavaScriptSerializer();
            var cart = serializer.Deserialize<List<CartItem>>(cartJson) ?? new List<CartItem>();
            System.Diagnostics.Debug.WriteLine($"Cart items count: {cart.Count}");

            if (cart.Count == 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "errorAlert", "alert('Your cart is empty. Please add items to proceed.');", true);
                return;
            }

            decimal total = cart.Sum(item => item.Price * item.Quantity);
            decimal totalTax = cart.Sum(item => (item.Price - (item.Price / (1 + TaxRate))) * item.Quantity);
            int totalItems = cart.Sum(item => item.Quantity);
            decimal shipping = CalculateShipping(totalItems, total);
            decimal discount = Session["AppliedDiscount"] as decimal? ?? 0m;
            decimal grandTotal = total + shipping - discount;
            string invoiceNumber = DateTime.Now.ToString("yyyyMMddHHmmss");
            string paymentMethod = "Credit Card";
            string status = "Completed";

            bool stockUpdated = true;
            foreach (var item in cart)
            {
                if (item.Id > 0)
                {
                    ProductDTO product = client.GetProduct(item.Id);
                    if (product != null)
                    {
                        if (product.StockQuantity >= item.Quantity)
                        {
                            product.StockQuantity -= item.Quantity;
                            bool updateSuccess = client.UpdateProduct(product);
                            if (!updateSuccess)
                            {
                                stockUpdated = false;
                                System.Diagnostics.Debug.WriteLine($"Failed to update stock for ProductId: {item.Id}");
                                break;
                            }
                            System.Diagnostics.Debug.WriteLine($"Updated stock for ProductId: {item.Id} to {product.StockQuantity}");
                        }
                        else
                        {
                            stockUpdated = false;
                            System.Diagnostics.Debug.WriteLine($"Insufficient stock for ProductId: {item.Id}. Available: {product.StockQuantity}, Requested: {item.Quantity}");
                            break;
                        }
                    }
                    else
                    {
                        stockUpdated = false;
                        System.Diagnostics.Debug.WriteLine($"Product not found for ProductId: {item.Id}");
                        break;
                    }
                }
                else
                {
                    stockUpdated = false;
                    System.Diagnostics.Debug.WriteLine("Invalid Product Id in cart item.");
                    break;
                }
            }

            if (!stockUpdated)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "errorAlert", "alert('Unable to process order due to stock issues. Please review your cart.');", true);
                return;
            }

            bool transactionSaved = client.SaveTransaction(UserId, grandTotal, cartJson, status, paymentMethod, shipping, totalTax, invoiceNumber);
            System.Diagnostics.Debug.WriteLine($"Transaction saved: {transactionSaved}");

            bool emailSent = SendInvoiceEmail(UserId, cart, invoiceNumber);
            string emailStatus = emailSent ? "Purchase confirmation email sent to your email address." : "Failed to send purchase confirmation email. Please contact support.";

            string invoiceHtml = GenerateInvoiceHtml(UserId, cart);

            string script = $@"
                document.addEventListener('DOMContentLoaded', function () {{
                    console.log('Injecting invoice content');
                    var invoiceContent = document.getElementById('invoice-content');
                    invoiceContent.innerHTML = `{invoiceHtml.Replace("`", "\\`")}<p style='color: {(emailSent ? "#2ecc71" : "#e74c3c")}; margin-top: 20px; text-align: center;'>{emailStatus}</p>`;
                    console.log('Invoice content set, showing panel');
                    showInvoicePanel();
                }});
            ";
            ClientScript.RegisterStartupScript(this.GetType(), "showInvoice", script, true);
            System.Diagnostics.Debug.WriteLine("Invoice panel script injected");

            client.SaveUserCart(UserId, "[]");
            System.Diagnostics.Debug.WriteLine("Cart cleared");

            Session.Remove("AppliedDiscount");

        }

        protected void btnContinue_Click(object sender, EventArgs e)
        {
        }

        protected void btnApplyDiscount_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null) return;

            int UserId = (int)Session["UserId"];
            string code = txtDiscountCode.Text.Trim();

            if (string.IsNullOrEmpty(code))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "errorAlert", "alert('Please enter a promo code.');", true);
                return;
            }

            bool applied = client.ApplyPromoCode(UserId, code);

            if (applied)
            {
                string cartJson = client.GetUserCart(UserId) ?? "[]";
                var serializer = new JavaScriptSerializer();
                var cart = serializer.Deserialize<List<CartItem>>(cartJson) ?? new List<CartItem>();

                decimal total = cart.Sum(item => item.Price * item.Quantity);
                int totalItems = cart.Sum(item => item.Quantity);
                decimal shipping = CalculateShipping(totalItems, total);
                decimal grandBeforeDiscount = total + shipping;
                decimal discount = PromoDiscountRate * grandBeforeDiscount;

                Session["AppliedDiscount"] = discount;

                // Clear the discount code input
                txtDiscountCode.Text = "";

                // Redirect to refresh the page with form data preserved
                string redirectUrl = $"ChechOut.aspx?promoApplied=true" +
                                    $"&phone={HttpUtility.UrlEncode(txtPhoneNumber.Text.Trim())}" +
                                    $"&address={HttpUtility.UrlEncode(txtAddress.Text.Trim())}" +
                                    $"&city={HttpUtility.UrlEncode(txtCity.Text.Trim())}" +
                                    $"&postal={HttpUtility.UrlEncode(txtPostalCode.Text.Trim())}";
                Response.Redirect(redirectUrl, false);
                Context.ApplicationInstance.CompleteRequest();
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "errorAlert", "alert('Invalid or already used promo code.');", true);
            }
        }
    }
}