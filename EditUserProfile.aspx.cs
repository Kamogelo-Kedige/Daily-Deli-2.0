using System;
using System.Web.UI;
using Daily_Deli_E_Commerce.DailyDeliAPI;

namespace Daily_Deli_E_Commerce
{
    public partial class EditUserProfile : System.Web.UI.Page
    {
        Service_DailyDeliClient client = new Service_DailyDeliClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadUserProfile();
            }
        }

        private void LoadUserProfile()
        {
            try
            {
                int userId = (int)Session["UserId"];
                var user = client.GetUserDetails(userId); // Using Wonder's method for basic details

                if (user == null)
                {
                    statusLabel.Style["color"] = "red";
                    statusLabel.InnerText = "User not found.";
                    return;
                }

                // Fetch additional fields via getUser for Title
                var fullUser = client.getUser(user.Email);

                title.Value = fullUser?.Title;
                name.Value = user.Name;
                surname.Value = user.Surname;
                email.Value = user.Email;
                phoneNumber.Value = user.PhoneNumber;
                addressLine1.Value = user.AddressLine1;
                city.Value = user.City;
                postalCode.Value = user.PostalCode;
            }
            catch (Exception ex)
            {
                statusLabel.Style["color"] = "red";
                statusLabel.InnerText = "Error loading profile: " + ex.Message;
            }
            finally
            {
                client.Close();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                int userId = (int)Session["UserId"];

                // Fetch current user to preserve non-editable fields
                var currentUser = client.getUser(email.Value);

                if (currentUser == null || currentUser.Id != userId)
                {
                    statusLabel.Style["color"] = "red";
                    statusLabel.InnerText = "Invalid user or session mismatch.";
                    return;
                }

                // Create DTO for update
                var updatedUser = new UserDTO
                {
                    Id = userId,
                    Title = title.Value?.Trim(),
                    Name = name.Value?.Trim(),
                    Surname = surname.Value?.Trim(),
                    Email = email.Value?.Trim(),
                    PhoneNumber = phoneNumber.Value?.Trim(),
                    AddressLine1 = addressLine1.Value?.Trim(),
                    City = city.Value?.Trim(),
                    PostalCode = postalCode.Value?.Trim(),
                    DietType = currentUser.DietType, // Preserve original
                    UserType = currentUser.UserType, // Preserve
                    LoyaltyPoints = currentUser.LoyaltyPoints, // Preserve
                    IsActive = currentUser.IsActive, // Preserve
                    Password = currentUser.Password // Preserve original
                };

                bool success = client.UpdateUserInfo(updatedUser);

                if (success)
                {
                    Session["Email"] = updatedUser.Email; // Update session if email changed
                    statusLabel.Style["color"] = "green";
                    statusLabel.InnerText = "Profile updated successfully.";
                }
                else
                {
                    statusLabel.Style["color"] = "red";
                    statusLabel.InnerText = "Failed to update profile.";
                }
            }
            catch (Exception ex)
            {
                statusLabel.Style["color"] = "red";
                statusLabel.InnerText = "Error updating profile: " + ex.Message;
            }
            finally
            {
                client.Close();
            }
        }
    }
}