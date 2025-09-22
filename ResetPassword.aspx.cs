using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Daily_Deli_E_Commerce.DailyDeliAPI;
using System.Net.Mail;
using System.Net;
using System.Security.Cryptography;
using System.Text;

namespace Daily_Deli_E_Commerce
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        Service_DailyDeliClient client = new Service_DailyDeliClient();
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRequestOTP_Click(object sender, EventArgs e)
        {
            try
            {
                string email = txtEmail.Value.Trim();
                if (string.IsNullOrEmpty(email))
                {
                    statusLabel.Style["color"] = "red";
                    statusLabel.InnerHtml = "Please enter your email.";
                    return;
                }

                // Generate OTP
                string otp = GenerateOTP();

                // Store OTP and email in Session
                Session["ResetOTP"] = otp;
                Session["ResetEmail"] = email;

                // Send OTP email
                bool emailSent = SendOTPEmail(email, otp);
                if (!emailSent)
                {
                    statusLabel.Style["color"] = "red";
                    statusLabel.InnerHtml = "Failed to send OTP. Please try again.";
                    return;
                }

                // Hide email panel, show OTP panel
                pnlEmail.Visible = false;
                pnlOTP.Visible = true;

                statusLabel.Style["color"] = "green";
                statusLabel.InnerHtml = "OTP sent to your email. Please enter it below.";
            }
            catch (Exception ex)
            {
                statusLabel.Style["color"] = "red";
                statusLabel.InnerHtml = "Something went wrong. Please try again later.";
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }

        protected void btnVerifyOTP_Click(object sender, EventArgs e)
        {
            try
            {
                string enteredOTP = txtOTP.Value.Trim();
                string storedOTP = Session["ResetOTP"] as string;

                if (string.IsNullOrEmpty(enteredOTP))
                {
                    statusLabel.Style["color"] = "red";
                    statusLabel.InnerHtml = "Please enter the OTP.";
                    return;
                }

                if (enteredOTP != storedOTP)
                {
                    statusLabel.Style["color"] = "red";
                    statusLabel.InnerHtml = "Invalid OTP. Please try again.";
                    return;
                }

                // OTP verified, hide OTP panel, show password panel
                pnlOTP.Visible = false;
                pnlPassword.Visible = true;

                statusLabel.Style["color"] = "green";
                statusLabel.InnerHtml = "OTP verified! Enter your new password.";
            }
            catch (Exception ex)
            {
                statusLabel.Style["color"] = "red";
                statusLabel.InnerHtml = "Something went wrong. Please try again later.";
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            try
            {
                string newPassword = txtPassword.Value.Trim();
                string confirmPassword = txtPasswordConfirm.Value.Trim();
                string email = Session["ResetEmail"] as string;

                if (string.IsNullOrEmpty(newPassword) || string.IsNullOrEmpty(confirmPassword))
                {
                    statusLabel.Style["color"] = "red";
                    statusLabel.InnerHtml = "Please enter and confirm the new password.";
                    return;
                }

                if (newPassword != confirmPassword)
                {
                    statusLabel.Style["color"] = "red";
                    statusLabel.InnerHtml = "Passwords must match.";
                    return;
                }

                // Build UserDTO (only email and hashed password needed)
                UserDTO user = new UserDTO
                {
                    Email = email,
                    Password = Secrecy.HashPassword(newPassword)
                };

                // Reset password via service
                bool isReset = client.ResetPasswordByEmail(user.Email, user.Password);
                if (isReset)
                {
                    // Clear session and fields
                    Session.Remove("ResetOTP");
                    Session.Remove("ResetEmail");
                    txtPassword.Value = txtPasswordConfirm.Value = string.Empty;

                    statusLabel.Style["color"] = "green";
                    statusLabel.InnerHtml = "Password reset successfully! Redirecting to login...";
                    Response.AddHeader("REFRESH", "3;URL=Login.aspx"); // Redirect after 3 seconds
                }
                else
                {
                    statusLabel.Style["color"] = "red";
                    statusLabel.InnerHtml = "Failed to reset password. Please try again.";
                }
            }
            catch (Exception ex)
            {
                statusLabel.Style["color"] = "red";
                statusLabel.InnerHtml = "Something went wrong. Please try again later.";
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }

        private string GenerateOTP()
        {
            // Generate a 6-digit OTP
            using (RandomNumberGenerator rng = RandomNumberGenerator.Create())
            {
                byte[] randomBytes = new byte[3]; // For 6 digits
                rng.GetBytes(randomBytes);
                int otpValue = (randomBytes[0] << 16) | (randomBytes[1] << 8) | randomBytes[2];
                return (otpValue % 1000000).ToString("D6"); // Ensure 6 digits
            }
        }

        private bool SendOTPEmail(string email, string otp)
        {
            try
            {
                // SMTP configuration
                string fromEmail = "delidaily186@gmail.com";
                string smtpServer = "smtp.gmail.com";
                int smtpPort = 587;
                string smtpUsername = "delidaily186@gmail.com";
                string smtpPassword = "rkgp dugf euck lpzd";

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
                        .otp-box {{
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
                            .otp-box {{
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
                            <h2>Password Reset OTP</h2>
                            <p>Dear Customer,</p>
                            <p>You have requested to reset your password. Please use the following One-Time Password (OTP) to proceed:</p>
                            <div class='otp-box'>{otp}</div>
                            <p>This OTP is valid for 10 minutes. If you did not request a password reset, please ignore this email or contact our support team at <a href='mailto:info@dailydeli.com'>info@dailydeli.com</a>.</p>
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
                mail.Subject = "Daily Deli OTP for Password Reset";
                mail.Body = emailBody;
                mail.IsBodyHtml = true; // Enable HTML content

                SmtpClient smtp = new SmtpClient(smtpServer, smtpPort);
                smtp.Credentials = new NetworkCredential(smtpUsername, smtpPassword);
                smtp.EnableSsl = true;
                smtp.Send(mail);

                System.Diagnostics.Debug.WriteLine($"OTP email sent to {email}");
                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Email sending failed: {ex.Message}");
                return false;
            }
        }
    }
}