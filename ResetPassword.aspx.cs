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
                // SMTP configuration (replace with your actual SMTP settings)
                string fromEmail = "delidaily186@gmail.com"; // Sender email
                string smtpServer = "smtp.gmail.com"; // e.g., smtp.gmail.com
                int smtpPort = 587; // e.g., 587 for TLS
                string smtpUsername = "delidaily186@gmail.com"; // SMTP username
                string smtpPassword = "rkgp dugf euck lpzd"; // SMTP password or app password

                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(fromEmail);
                mail.To.Add(email);
                mail.Subject = "Daily Deli OTP for Password Reset";
                mail.Body = $"Your OTP for password reset is: {otp}. It is valid for 10 minutes.";
                mail.IsBodyHtml = false;

                SmtpClient smtp = new SmtpClient(smtpServer, smtpPort);
                smtp.Credentials = new NetworkCredential(smtpUsername, smtpPassword);
                smtp.EnableSsl = true; // Use SSL/TLS
                smtp.Send(mail);

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