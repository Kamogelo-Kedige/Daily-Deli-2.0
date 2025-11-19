using System;
using System.Net.Mail;
using System.Net;
using System.Web.UI;
using System.Web.UI.WebControls;
using Daily_Deli_E_Commerce.DailyDeliAPI;

namespace Daily_Deli_E_Commerce
{
    public partial class Daily_Deli_Master_Page : System.Web.UI.MasterPage
    {
        Service_DailyDeliClient client = new Service_DailyDeliClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["UserType"] != null)
                {
                    var ut = Session["UserType"].ToString();
                    if (!string.IsNullOrEmpty(ut) && ut.Equals("Admin", StringComparison.OrdinalIgnoreCase))
                    {
                        shopAdminLink.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Shop admin visibility check failed: {ex.Message}");
            }
        }

        protected void btnSubscribe_Click(object sender, EventArgs e)
        {
            try
            {
                string email = txtNewsletterEmail.Text.Trim();
                if (string.IsNullOrEmpty(email))
                {
                    newsletterStatus.Style["color"] = "red";
                    newsletterStatus.InnerHtml = "Please enter your email address.";
                    return;
                }

                // Validate email format
                if (!IsValidEmail(email))
                {
                    newsletterStatus.Style["color"] = "red";
                    newsletterStatus.InnerHtml = "Please enter a valid email address.";
                    return;
                }

                // Check if user is logged in
                if (Session["UserId"] == null)
                {
                    newsletterStatus.Style["color"] = "red";
                    newsletterStatus.InnerHtml = "Please <a href='login.aspx' style='color: #0077cc; text-decoration: underline;'>log in</a> to subscribe and receive a 20% off promo code.";
                    return;
                }

                int userId = (int)Session["UserId"];
                UserDTO user = client.GetUserByEmail(email);

                if (user != null && user.Id == userId)
                {
                    // Email matches logged-in user, add promo code
                    bool promoAdded = client.AddPromoCode(userId, "SUBSCRIBE", "Percentage", 20m, "Active");
                    if (promoAdded)
                    {
                        // Send subscription confirmation email
                        bool emailSent = SendSubscriptionEmail(email, "SUBSCRIBE", 20m, "Percentage");
                        if (emailSent)
                        {
                            newsletterStatus.Style["color"] = "green";
                            newsletterStatus.InnerHtml = "Congratulations! You've subscribed and received a 20% off promo code. Check your email!";
                        }
                        else
                        {
                            newsletterStatus.Style["color"] = "red";
                            newsletterStatus.InnerHtml = "Failed to send subscription email. Please try again.";
                        }
                    }
                    else
                    {
                        newsletterStatus.Style["color"] = "red";
                        newsletterStatus.InnerHtml = "Failed to generate promo code. You may already have an active subscription code.";
                    }
                }
                else
                {
                    // Email not found or doesn't match logged-in user
                    newsletterStatus.Style["color"] = "red";
                    newsletterStatus.InnerHtml = "Email does not match your account or is not registered. Please <a href='Register.aspx' style='color: #0077cc; text-decoration: underline;'>register</a> with this email to subscribe.";
                }
            }
            catch (Exception ex)
            {
                newsletterStatus.Style["color"] = "red";
                newsletterStatus.InnerHtml = "Something went wrong. Please try again later.";
                System.Diagnostics.Debug.WriteLine($"Subscription error: {ex.Message}");
            }
        }

        private bool IsValidEmail(string email)
        {
            try
            {
                var mailAddress = new MailAddress(email);
                return mailAddress.Address == email;
            }
            catch
            {
                return false;
            }
        }

        private bool SendSubscriptionEmail(string email, string promoCode, decimal promoValue, string promoType)
        {
            try
            {
                // SMTP configuration
                string fromEmail = "delidaily186@gmail.com";
                string smtpServer = "smtp.gmail.com";
                int smtpPort = 587;
                string smtpUsername = "delidaily186@gmail.com";
                string smtpPassword = "rkgp dugf euck lpzd"; // TODO: Move to web.config

                // Updated HTML email body to include promo code details
                string emailBody = $@"
                <!DOCTYPE html>
                <html lang='en'>
                <head>
                    <meta charset='UTF-8'>
                    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
                    <style>
                        body {{
                            margin: 0;
                            padding: 0;
                            font-family: 'Poppins', Arial, sans-serif;
                            background-color: #f8faff;
                            color: #2d3748;
                        }}
                        .container {{
                            max-width: 600px;
                            margin: 20px auto;
                            background: #ffffff;
                            border-radius: 15px;
                            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                            overflow: hidden;
                            border: 1px solid #e0e5f3;
                        }}
                        .header {{
                            background: linear-gradient(135deg, #0077cc 0%, #4a6cf7 100%);
                            padding: 30px;
                            text-align: center;
                            color: #ffffff;
                        }}
                        .header img {{
                            width: 150px;
                            height: auto;
                            margin-bottom: 10px;
                        }}
                        .header h1 {{
                            margin: 0;
                            font-size: 28px;
                            font-weight: 600;
                        }}
                        .header p {{
                            margin: 5px 0;
                            font-size: 16px;
                            opacity: 0.9;
                        }}
                        .content {{
                            padding: 30px;
                            text-align: center;
                        }}
                        .promo-box {{
                            display: inline-block;
                            background: #f8faff;
                            padding: 15px 30px;
                            border-radius: 10px;
                            border: 2px solid #0077cc;
                            margin: 20px 0;
                            font-size: 24px;
                            font-weight: 600;
                            letter-spacing: 5px;
                            color: #0077cc;
                        }}
                        .content p {{
                            font-size: 16px;
                            line-height: 1.5;
                            margin: 10px 0;
                            color: #2d3748;
                        }}
                        .content a {{
                            color: #0077cc;
                            text-decoration: none;
                            font-weight: 500;
                        }}
                        .content a:hover {{
                            text-decoration: underline;
                        }}
                        .footer {{
                            background: #f8faff;
                            padding: 20px;
                            text-align: center;
                            border-top: 1px solid #e0e5f3;
                            font-size: 14px;
                            color: #718096;
                        }}
                        .footer a {{
                            color: #0077cc;
                            text-decoration: none;
                        }}
                        .footer a:hover {{
                            text-decoration: underline;
                        }}
                        @media (max-width: 600px) {{
                            .container {{
                                margin: 10px;
                                border-radius: 10px;
                            }}
                            .header {{
                                padding: 20px;
                            }}
                            .header h1 {{
                                font-size: 24px;
                            }}
                            .content {{
                                padding: 20px;
                            }}
                            .promo-box {{
                                font-size: 20px;
                                padding: 10px 20px;
                            }}
                        }}
                    </style>
                </head>
                <body>
                    <div class='container'>
                        <div class='header'>
                            <img src='https://tse4.mm.bing.net/th/id/OIP.PZnyvI-K89cg0MGEXycttgHaEv?r=0&rs=1&pid=ImgDetMain&o=7&rm=3' alt='Daily Deli Logo'>
                            <h1>Daily Deli</h1>
                            <p>Freshness Delivered to Your Doorstep</p>
                        </div>
                        <div class='content'>
                            <h2>Welcome to the Daily Deli Newsletter!</h2>
                            <p>Dear Customer,</p>
                            <p>Congratulations on subscribing to our newsletter! As a thank you, enjoy <strong>{promoValue}% off</strong> your next purchase with the promo code below:</p>
                            <div class='promo-box'>{promoCode}</div>
                            <p>Use this code at checkout to apply your discount. Stay tuned for exclusive offers, new products, and more!</p>
                            <p>If you have any questions, contact our support team at <a href='mailto:info@dailydeli.com'>info@dailydeli.com</a>.</p>
                            <p>Thank you for joining the Daily Deli community!</p>
                        </div>
                        <div class='footer'>
                            <p>123 Tasteful Lane, Johannesburg, South Africa</p>
                            <p>Phone: +27 11 555 0123 | Email: <a href='mailto:info@dailydeli.com'>info@dailydeli.com</a> | <a href='http://www.dailydeli.com'>www.dailydeli.com</a></p>
                            <p>&copy; 2025 Daily Deli. All rights reserved.</p>
                        </div>
                    </div>
                </body>
                </html>";

                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(fromEmail, "Daily Deli");
                mail.To.Add(email);
                mail.Subject = "Daily Deli Newsletter Subscription - 20% Off Promo Code";
                mail.Body = emailBody;
                mail.IsBodyHtml = true;

                SmtpClient smtp = new SmtpClient(smtpServer, smtpPort);
                smtp.Credentials = new NetworkCredential(smtpUsername, smtpPassword);
                smtp.EnableSsl = true;
                smtp.Send(mail);

                System.Diagnostics.Debug.WriteLine($"Subscription email with promo code {promoCode} sent to {email}");
                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Subscription email sending failed for {email}: {ex.Message}");
                return false;
            }
        }
    }
}