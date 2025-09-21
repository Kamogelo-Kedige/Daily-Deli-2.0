using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Daily_Deli_E_Commerce.DailyDeliAPI;

namespace Daily_Deli_E_Commerce
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        Service_DailyDeliClient client = new Service_DailyDeliClient();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            try
            {

                //  verify user 
                // If not verified yet (no ViewState flag), do verification and show password fields
                if (ViewState["VerifiedUser"] == null)
                {
                    bool exists = client.CheckUser(txtName.Value, txtSurname.Value, txtEmail.Value, int.Parse(dietType.Value));
                    if (!exists)
                    {
                        statusLabel.Style["color"] = "red";
                        statusLabel.InnerHtml = "No such user found";
                        return;
                    }

                    // Mark user as verified and show the hidden password fields
                    ViewState["VerifiedUser"] = txtEmail.Value; 
                    hiddenFields.Visible = true;
                    statusLabel.Style["color"] = "green";
                    statusLabel.InnerHtml = "User found! Enter new password and confirm.";
                    return; //stop here so user can fill passwords on the next postback
                }


                //  passwords submitted, do reset 
                // Make sure the password fields contain values
                if (string.IsNullOrWhiteSpace(txtPassword.Value) || string.IsNullOrWhiteSpace(txtPasswordConfirm.Value))
                {
                    statusLabel.Style["color"] = "red";
                    statusLabel.InnerHtml = "Please enter and confirm the new password.";
                    return;
                }

                // Compare the values (NOT the control references)
                if (txtPassword.Value != txtPasswordConfirm.Value)
                {
                    statusLabel.Style["color"] = "red";
                    statusLabel.InnerHtml = "Passwords must match.";
                    return;
                }

                // Build DTO & call service to save the new password
                UserDTO user = new UserDTO
                {
                    Name = txtName.Value,
                    Surname = txtSurname.Value,
                    Email = txtEmail.Value,
                    Password = Secrecy.HashPassword(txtPassword.Value)
                   
                };

                // reset the password
             
                  bool isReset = client.ResetPassword(user);
                if (isReset == true)
                {
                    // Clear sensitive fields and ViewState, then redirect
                    txtPassword.Value = txtPasswordConfirm.Value = string.Empty;
                    ViewState.Remove("VerifiedUser");


                    Response.Redirect("Login.aspx");
                }
                else
                {
                    statusLabel.Style["color"] = "red";
                    statusLabel.InnerHtml = "Something went wrong while changing password";

                    return;
                }

                

            }
            catch (Exception ex)
            {
                statusLabel.Style["color"] = "red";
                statusLabel.InnerHtml = "Something went wrong try again later";
                Console.WriteLine(ex.Message);
            }
        }
    }
}