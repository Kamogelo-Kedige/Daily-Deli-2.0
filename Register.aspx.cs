using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Daily_Deli_E_Commerce.DailyDeliAPI;
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

            try { 
               //Check if passwords match
                if (password.Value != confirmPassword.Value)
                {
                    statusLabel.Style["color"] = "red";
                    statusLabel.InnerText = "Passwords do not Match!";

                    return;
                }

            // Read the selected diet type safely
            // Validate diet type selection
            if (string.IsNullOrEmpty(dietType.Value))
            {
                statusLabel.Style["color"] = "red";
                statusLabel.InnerText = "Please select a diet type.";
                return;
            }

            int SelectedDietType = int.Parse(dietType.Value);

            // Create the actual User
            var newUser = new User
            {
                title = title.Value,
                name = name.Value,
                surname = surname.Value,
                email = email.Value,
                dietType = SelectedDietType,
                password = Secrecy.HashPassword(password.Value)
            };

            //Try register the user
            bool registered = client.Register(newUser);

                if (registered == true)
                {
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    statusLabel.Style["color"] = "red";
                    statusLabel.InnerText = "Could not register, try again";

                }

                client.Close();


             }
            catch(Exception ex)
            {
                client.Close();
                statusLabel.Style["color"] = "red";
                statusLabel.InnerText = "Something went wrong";
                Console.WriteLine(ex.Message);
            }
           
        }
    }
}