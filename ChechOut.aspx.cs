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
        private const decimal TaxRate = 0.15m; // 15% VAT

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] != null)
                {
                    int UserId = (int)Session["UserId"];

                    // Fetch user details
                    UserDTO user = client.GetUserDetails(UserId);
                    if (user != null)
                    {
                        txtEmail.Text = user.Email;
                        txtFirstName.Text = user.Name;
                        txtLastName.Text = user.Surname;
                        txtPhoneNumber.Text = user.PhoneNumber ?? "";
                        txtAddress.Text = user.AddressLine1 ?? "";
                        txtCity.Text = user.City ?? "";
                        txtPostalCode.Text = user.PostalCode ?? "";
                    }

                    // Fetch cart from database
                    string cartJson = client.GetUserCart(UserId) ?? "[]";
                    var serializer = new JavaScriptSerializer();
                    var cart = serializer.Deserialize<List<CartItem>>(cartJson) ?? new List<CartItem>();

                    // Group items and calculate totals
                    var groupedCart = cart.GroupBy(item => item.Name)
                                          .Select(g => new
                                          {
                                              Name = g.Key,
                                              Quantity = g.Sum(item => item.Quantity),
                                              FinalPrice = g.First().Price, // Price including tax
                                              ImageURL = g.First().ImageURL,
                                              OriginalPrice = g.First().Price / (1 + TaxRate), // Price before tax
                                              TaxPerItem = g.First().Price - (g.First().Price / (1 + TaxRate)) // Tax amount per item
                                          }).ToList();

                    decimal total = groupedCart.Sum(item => item.FinalPrice * item.Quantity);
                    decimal totalTax = groupedCart.Sum(item => item.TaxPerItem * item.Quantity);
                    int totalItems = groupedCart.Sum(item => item.Quantity);
                    decimal shipping = CalculateShipping(totalItems, total);
                    decimal grandTotal = total + shipping;

                    string totalFormatted = $"R{total:F2}";
                    string totalTaxFormatted = $"R{totalTax:F2}";
                    string shippingFormatted = $"R{shipping:F2}";
                    string grandFormatted = $"R{grandTotal:F2}";
                    string totalItemsFormatted = $"{totalItems} Item{(totalItems != 1 ? "s" : "")}";

                    // Inject JavaScript for cart rendering and payment panel
                    string script = $@"
                        document.addEventListener('DOMContentLoaded', function () {{
                            var cartItemsDiv = document.getElementById('dynamic-cart-items');
                            var totalsDiv = document.querySelector('.totals');
                            cartItemsDiv.innerHTML = '';

                            // Add total items display
                            var totalItemsSpan = document.createElement('div');
                            totalItemsSpan.id = 'total-items';
                            totalItemsSpan.innerHTML = '<span style=""font-size: 18px; font-weight: bold; color: #0077cc;"">{totalItemsFormatted}</span>';
                            cartItemsDiv.parentNode.insertBefore(totalItemsSpan, cartItemsDiv);

                            {string.Join("", groupedCart.Select(item => $@"
                                var itemDiv = document.createElement('div');
                                itemDiv.className = 'cart-item';
                                itemDiv.innerHTML = `<img src='{item.ImageURL}' alt='{item.Name}' style='width: 110px; margin-right: 15px; border-radius: 8px;' onerror='this.onerror=null;this.src=""img/Hero.webp""' /><div style='flex-grow: 1;'><p style='font-size: 16px; font-weight: bold; margin: 0;'>{item.Name} <span style='color: #0077cc;'>x{item.Quantity}</span></p><p style='color: #555; margin: 2px 0;'>R{item.OriginalPrice:F2} each (excl. VAT)</p><p style='color: #555; margin: 2px 0;'>VAT (15%): R{item.TaxPerItem:F2}</p></div><span class='price' style='font-weight: bold; color: #000;'>R{(item.FinalPrice * item.Quantity):F2}</span>`;
                                cartItemsDiv.appendChild(itemDiv);
                            "))}

                            // Clear existing totals to avoid duplication
                            totalsDiv.innerHTML = '';

                            // Add VAT line
                            var totalTaxP = document.createElement('p');
                            totalTaxP.innerHTML = `<span class='total-label'>VAT (15%)</span><span class='total-amount'>{totalTaxFormatted}</span>`;
                            totalsDiv.appendChild(totalTaxP);

                            // Add subtotal line
                            var subtotalP = document.createElement('p');
                            subtotalP.innerHTML = `<span class='total-label'>Subtotal</span><span class='total-amount'>{totalFormatted}</span>`;
                            totalsDiv.appendChild(subtotalP);

                            // Add shipping fee line
                            var shippingP = document.createElement('p');
                            shippingP.innerHTML = `<span class='total-label'>Shipping Fee</span><span class='total-amount'>{shippingFormatted}</span>`;
                            totalsDiv.appendChild(shippingP);

                            // Add grand total line
                            var grandTotalP = document.createElement('p');
                            grandTotalP.className = 'grand-total';
                            grandTotalP.innerHTML = `<span class='total-label'>Grand Total</span><span class='total-amount'>{grandFormatted}</span>`;
                            totalsDiv.appendChild(grandTotalP);

                            // Payment panel functionality
                            var btnContinue = document.getElementById('{btnContinue.ClientID}');
                            var paymentPanel = document.getElementById('paymentPanel');
                            var paymentOverlay = document.getElementById('paymentOverlay');
                            var phoneNumber = document.getElementById('{txtPhoneNumber.ClientID}');
                            var address = document.getElementById('{txtAddress.ClientID}');
                            var city = document.getElementById('{txtCity.ClientID}');
                            var postalCode = document.getElementById('{txtPostalCode.ClientID}');

                            btnContinue.onclick = function(event) {{
                                event.preventDefault();
                                if (phoneNumber.value.trim() && address.value.trim() && city.value.trim() && postalCode.value.trim()) {{
                                    paymentOverlay.classList.add('active');
                                    paymentPanel.classList.add('active');
                                }} else {{
                                    alert('Please fill in all shipping address fields.');
                                }}
                            }};

                            document.querySelector('.close-btn').onclick = function() {{
                                paymentOverlay.classList.remove('active');
                                paymentPanel.classList.remove('active');
                            }};

                            paymentOverlay.onclick = function() {{
                                paymentOverlay.classList.remove('active');
                                paymentPanel.classList.remove('active');
                            }};
                        }});
                    ";
                    ClientScript.RegisterStartupScript(this.GetType(), "renderCart", script, true);
                }
                else
                {
                    Response.Redirect("Home.aspx");
                }
            }
        }

        private decimal CalculateShipping(int totalItems, decimal orderTotal)
        {
            if (orderTotal >= 1000m) return 0m; // Free shipping over R1000

            decimal baseFee = 50m; // Base fee for the first item
            decimal perAdditionalItem = 10m; // Fee per additional item
            decimal additional = totalItems > 1 ? perAdditionalItem * (totalItems - 1) : 0m;
            decimal shipping = baseFee + additional;

            return Math.Min(shipping, 200m); // Cap at R200 maximum
        }

        private string GenerateInvoiceHtml(int userId, List<CartItem> cart)
        {
            // Fetch user details for invoice
            UserDTO user = client.GetUserDetails(userId);

            // Calculate totals
            decimal total = cart.Sum(item => item.Price * item.Quantity);
            decimal totalTax = cart.Sum(item => (item.Price - (item.Price / (1 + TaxRate))) * item.Quantity);
            int totalItems = cart.Sum(item => item.Quantity);
            decimal shipping = CalculateShipping(totalItems, total);
            decimal grandTotal = total + shipping;
            string invoiceNumber = DateTime.Now.ToString("yyyyMMddHHmmss");

            // Build HTML string with enhanced design
            string html = $@"
                <div style='font-family: Arial, Helvetica, sans-serif; width: 100%; max-width: 800px; margin: 0 auto; background: #ffffff; padding: 20px; border: 1px solid #4a6cf7; border-radius: 8px; max-height: 80vh; overflow-y: auto;'>
                    <!-- Header Section -->
                    <div style='text-align: center; margin-bottom: 40px;'>
                        <h1 style='color: #4a6cf7; font-size: 36px; margin: 0; font-weight: bold;'>Daily Deli</h1>
                        <img style='width:150px; height:80px' src='https://tse4.mm.bing.net/th/id/OIP.PZnyvI-K89cg0MGEXycttgHaEv?r=0&rs=1&pid=ImgDetMain&o=7&rm=3' alt='Daily Deli Logo' style='margin-top: 10px;'>
                        <p style='color: #718096; font-size: 16px; margin: 5px 0;'>Freshness Delivered to Your Doorstep</p>
                        <p style='color: #718096; font-size: 14px;'>123 Tasteful Lane, Johannesburg, South Africa | VAT: ZA123456789</p>
                        <p style='color: #718096; font-size: 14px;'>Phone: +27 11 555 0123 | Email: info@dailydeli.com | www.dailydeli.com</p>
                    </div>

                    <!-- Invoice Details Section -->
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

                    <!-- Customer Information -->
                    <div style='margin-bottom: 40px;'>
                        <h2 style='color: #4a6cf7; font-size: 24px; margin: 0 0 15px; font-weight: 600;'>Bill To</h2>
                        <div style='background: #f8faff; padding: 25px; border-radius: 8px; border: 1px solid #e0e5f3;'>
                            <p style='margin: 5px 0; color: #2d3748;'><strong>Customer:</strong> {user.Name} {user.Surname}</p>
                            <p style='margin: 5px 0; color: #2d3748;'><strong>Email:</strong> {user.Email}</p>
                            <p style='margin: 5px 0; color: #2d3748;'><strong>Phone:</strong> {user.PhoneNumber}</p>
                            <p style='margin: 5px 0; color: #2d3748;'><strong>Address:</strong> {user.AddressLine1}, {user.City}, {user.PostalCode}</p>
                        </div>
                    </div>

                    <!-- Items Purchased -->
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
                                    <td colspan='4' style='padding: 12px; text-align: right; color: #e74c3c; background: rgba(74, 108, 247, 0.05);'>Grand Total</td>
                                    <td style='padding: 12px; text-align: right; color: #e74c3c; background: rgba(74, 108, 247, 0.05);'>R{grandTotal:F2}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <!-- Additional Information -->
                    <div style='margin-bottom: 40px;'>
                        <h2 style='color: #4a6cf7; font-size: 24px; margin: 0 0 15px; font-weight: 600;'>About Daily Deli</h2>
                        <div style='background: #f8faff; padding: 25px; border-radius: 8px; border: 1px solid #e0e5f3;'>
                            <p style='margin: 5px 0; color: #2d3748;'>Daily Deli is your trusted partner in delivering fresh, high-quality deli products straight to your table. Established in 2015, we pride ourselves on sourcing the finest ingredients from local South African farmers.</p>
                            <p style='margin: 5px 0; color: #2d3748;'>Our mission is to bring convenience and flavor to every household, with a commitment to sustainability and customer satisfaction.</p>
                        </div>
                    </div>

                    <!-- Terms and Conditions -->
                    <div style='margin-bottom: 40px;'>
                        <h2 style='color: #4a6cf7; font-size: 24px; margin: 0 0 15px; font-weight: 600;'>Terms & Conditions</h2>
                        <div style='background: #f8faff; padding: 25px; border-radius: 8px; border: 1px solid #e0e5f3;'>
                            <p style='margin: 5px 0; color: #2d3748;'>- Payment is due within 30 days from the invoice date.</p>
                            <p style='margin: 5px 0; color: #2d3748;'>- All prices are inclusive of VAT.</p>
                            <p style='margin: 5px 0; color: #2d3748;'>- Returns accepted within 7 days with original packaging.</p>
                            <p style='margin: 5px 0; color: #2d3748;'>- Please quote the invoice number in all correspondence.</p>
                        </div>
                    </div>

                    <!-- Footer -->
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
                // Fetch user details
                UserDTO user = client.GetUserDetails(userId);
                if (user == null || string.IsNullOrEmpty(user.Email))
                {
                    System.Diagnostics.Debug.WriteLine("User or email not found for UserId: " + userId);
                    return false;
                }

                // Calculate totals
                decimal total = cart.Sum(item => item.Price * item.Quantity);
                decimal totalTax = cart.Sum(item => (item.Price - (item.Price / (1 + TaxRate))) * item.Quantity);
                int totalItems = cart.Sum(item => item.Quantity);
                decimal shipping = CalculateShipping(totalItems, total);
                decimal grandTotal = total + shipping;

                // SMTP configuration
                string fromEmail = "delidaily186@gmail.com";
                string smtpServer = "smtp.gmail.com";
                int smtpPort = 587;
                string smtpUsername = "delidaily186@gmail.com";
                string smtpPassword = "rkgp dugf euck lpzd";

                // Build HTML email body
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
                            <!-- Header -->
                            <div class='header'>
                                <h1>Daily Deli</h1>
                                <img src='https://tse4.mm.bing.net/th/id/OIP.PZnyvI-K89cg0MGEXycttgHaEv?r=0&rs=1&pid=ImgDetMain&o=7&rm=3' alt='Daily Deli Logo'>
                                <p>Freshness Delivered to Your Doorstep</p>
                                <p>123 Tasteful Lane, Johannesburg, South Africa | VAT: ZA123456789</p>
                                <p>Phone: +27 11 555 0123 | Email: <a href='mailto:info@dailydeli.com'>info@dailydeli.com</a> | www.dailydeli.com</p>
                            </div>

                            <!-- Greeting -->
                            <div class='section'>
                                <h2>Thank You for Your Purchase!</h2>
                                <p style='color: #2d3748;'>Dear {user.Name} {user.Surname},</p>
                                <p style='color: #2d3748;'>Thank you for shopping with Daily Deli! Your order has been successfully processed. Please find your invoice details below</p>
                            </div>

                            <!-- Invoice Details -->
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

                            <!-- Customer Information -->
                            <div class='section'>
                                <h2>Bill To</h2>
                                <p><strong>Customer:</strong> {user.Name} {user.Surname}</p>
                                <p><strong>Email:</strong> {user.Email}</p>
                                <p><strong>Phone:</strong> {user.PhoneNumber ?? "Not provided"}</p>
                                <p><strong>Address:</strong> {user.AddressLine1 ?? "Not provided"}, {user.City ?? "Not provided"}, {user.PostalCode ?? "Not provided"}</p>
                            </div>

                            <!-- Items Purchased -->
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
                                        <tr class='grand-total'>
                                            <td colspan='4' style='text-align: right;'>Grand Total</td>
                                            <td style='text-align: right;'>R{grandTotal:F2}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Footer -->
                            <div class='footer'>
                                <p>Thank you for choosing Daily Deli! For inquiries, contact us at <a href='mailto:info@dailydeli.com'>info@dailydeli.com</a> or +27 11 555 0123.</p>
                                <p>&copy; 2025 Daily Deli. All rights reserved.</p>
                            </div>
                        </div>
                    </body>
                    </html>
                ";

                // Create and send email
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(fromEmail, "Daily Deli");
                mail.To.Add(user.Email);
                mail.Subject = $"Daily Deli Purchase Confirmation - Invoice #{invoiceNumber}";
                mail.Body = emailBody;
                mail.IsBodyHtml = true; // Set to true for HTML email

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

            // 1. Save address if fields are provided
            if (!string.IsNullOrEmpty(txtPhoneNumber.Text.Trim()) ||
                !string.IsNullOrEmpty(txtAddress.Text.Trim()) ||
                !string.IsNullOrEmpty(txtCity.Text.Trim()) ||
                !string.IsNullOrEmpty(txtPostalCode.Text.Trim()))
            {
                client.UpdateUserAddress(UserId, txtPhoneNumber.Text, txtAddress.Text, txtCity.Text, txtPostalCode.Text);
                System.Diagnostics.Debug.WriteLine("Address updated");
            }

            // 2. Fetch cart for invoice and transaction
            string cartJson = client.GetUserCart(UserId) ?? "[]";
            System.Diagnostics.Debug.WriteLine($"Fetched cart JSON: {cartJson}");
            var serializer = new JavaScriptSerializer();
            var cart = serializer.Deserialize<List<CartItem>>(cartJson) ?? new List<CartItem>();
            System.Diagnostics.Debug.WriteLine($"Cart items count: {cart.Count}");

            // 3. Check for empty cart
            if (cart.Count == 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "errorAlert", "alert('Your cart is empty. Please add items to proceed.');", true);
                return;
            }

            // 4. Calculate totals for transaction
            decimal total = cart.Sum(item => item.Price * item.Quantity);
            decimal totalTax = cart.Sum(item => (item.Price - (item.Price / (1 + TaxRate))) * item.Quantity);
            int totalItems = cart.Sum(item => item.Quantity);
            decimal shipping = CalculateShipping(totalItems, total);
            decimal grandTotal = total + shipping;
            string invoiceNumber = DateTime.Now.ToString("yyyyMMddHHmmss");
            string paymentMethod = "Credit Card"; // Hardcoded as per invoice; can be dynamic if needed
            string status = "Completed"; // Assume successful payment

            // 5. Save transaction via WCF service
            bool transactionSaved = client.SaveTransaction(UserId, grandTotal, cartJson, status, paymentMethod, shipping, totalTax, invoiceNumber);
            System.Diagnostics.Debug.WriteLine($"Transaction saved: {transactionSaved}");

            // 6. Send purchase confirmation email
            bool emailSent = SendInvoiceEmail(UserId, cart, invoiceNumber);
            string emailStatus = emailSent ? "Purchase confirmation email sent to your email address." : "Failed to send purchase confirmation email. Please contact support.";

            // 7. Generate HTML invoice content
            string invoiceHtml = GenerateInvoiceHtml(UserId, cart);

            // 8. Inject JS to show invoice panel with email status
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

            // 9. Clear cart
            client.SaveUserCart(UserId, "[]");
            System.Diagnostics.Debug.WriteLine("Cart cleared");
        }

        protected void btnContinue_Click(object sender, EventArgs e)
        {
            // Empty, as OnClientClick handles client-side validation
        }
    }
}