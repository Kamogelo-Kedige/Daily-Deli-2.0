using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Daily_Deli_E_Commerce.DailyDeliAPI;
using System.Net.Mail;
using System.Net;

namespace Daily_Deli_E_Commerce
{
    public partial class Register : System.Web.UI.Page
    {
        Service_DailyDeliClient client = new Service_DailyDeliClient();

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                // Check if passwords match
                if (password.Value != confirmPassword.Value)
                {
                    statusLabel.Style["color"] = "red";
                    statusLabel.InnerText = "Passwords do not match!";
                    return;
                }

                // Validate diet type selection
                if (string.IsNullOrEmpty(dietType.Value))
                {
                    statusLabel.Style["color"] = "red";
                    statusLabel.InnerText = "Please select a diet type.";
                    return;
                }

                int selectedDietType = int.Parse(dietType.Value);

                // Create the user
                var newUser = new User
                {
                    title = title.Value,
                    name = name.Value,
                    surname = surname.Value,
                    email = email.Value,
                    dietType = selectedDietType,
                    password = Secrecy.HashPassword(password.Value)
                };

                // Try to register the user
                bool registered = client.Register(newUser);

                if (registered)
                {
                    // Send welcome email
                    bool emailSent = SendWelcomeEmail(newUser.email, newUser.name);
                    if (!emailSent)
                    {
                        System.Diagnostics.Debug.WriteLine("Welcome email failed to send, but registration succeeded.");
                        // Continue to redirect even if email fails
                    }

                    statusLabel.Style["color"] = "green";
                    statusLabel.InnerText = "Registration successful! Redirecting to login...";
                    Response.AddHeader("REFRESH", "3;URL=Login.aspx");
                }
                else
                {
                    statusLabel.Style["color"] = "red";
                    statusLabel.InnerText = "Could not register, try again.";
                }
            }
            catch (Exception ex)
            {
                statusLabel.Style["color"] = "red";
                statusLabel.InnerText = "Something went wrong.";
                System.Diagnostics.Debug.WriteLine($"Registration error: {ex.Message}");
            }
            finally
            {
                client.Close();
            }
        }

        private bool SendWelcomeEmail(string email, string name)
        {
            try
            {
                // SMTP configuration (same as ResetPassword.aspx.cs)
                string fromEmail = "delidaily186@gmail.com";
                string smtpServer = "smtp.gmail.com";
                int smtpPort = 587;
                string smtpUsername = "delidaily186@gmail.com";
                string smtpPassword = "rkgp dugf euck lpzd";

                // Static coupon code (replace with dynamic generation if needed)
                string couponCode = "FIRST20";

                // HTML email body
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
                        .coupon-box {{
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
                            .coupon-box {{
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
                            <h2>Welcome to Daily Deli, {HttpUtility.HtmlEncode(name)}!</h2>
                            <p>Dear {HttpUtility.HtmlEncode(name)},</p>
                            <p>Congratulations on joining the Daily Deli family! We're thrilled to have you on board. Explore our wide range of fresh, diet-friendly products tailored just for you.</p>
                            <p>Want to make your first purchase even sweeter? Subscribe to our newsletter to receive a <strong>20% off coupon</strong> for your first order!</p>
                            <div class='coupon-box'>{couponCode}</div>
                            <p>Click <a href='http://www.dailydeli.com/subscribe'>here to subscribe</a> and use the coupon code above at checkout. If you have any questions, contact our support team at <a href='mailto:info@dailydeli.com'>info@dailydeli.com</a>.</p>
                            <p>Thank you for choosing Daily Deli!</p>
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
                mail.Subject = "Welcome to Daily Deli!";
                mail.Body = emailBody;
                mail.IsBodyHtml = true;

                SmtpClient smtp = new SmtpClient(smtpServer, smtpPort);
                smtp.Credentials = new NetworkCredential(smtpUsername, smtpPassword);
                smtp.EnableSsl = true;
                smtp.Send(mail);

                System.Diagnostics.Debug.WriteLine($"Welcome email sent to {email}");
                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Welcome email sending failed: {ex.Message}");
                return false;
            }
        }
    }
}