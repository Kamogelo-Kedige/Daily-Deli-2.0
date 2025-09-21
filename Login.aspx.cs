using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Daily_Deli_E_Commerce.DailyDeliAPI;

namespace Daily_Deli_E_Commerce
{
    public partial class Login : System.Web.UI.Page
    {
        Service_DailyDeliClient client = new Service_DailyDeliClient();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnlogin_Click(object sender, EventArgs e)
        {
            try
            {
                int Login = client.Login(email.Value, Secrecy.HashPassword(password.Value));

                    if (Login != -1)
                    {
                        // Get the user type from the service
                        string userType = client.GetUsertype(Login);

                        // Store the logged in session, will later enable nav manipulation
                        Session["UserId"] = Login;
                        Session["UserType"] = userType;
                        Session["Email"] = email.Value;

                      
                     
                       Response.Redirect("Shop.aspx");
                       
                    }
                    else
                    {
                        statusLabel.Style["color"] = "red";
                        statusLabel.InnerText = "Password or Email invalid";
                    }

                client.Close();
            }
            catch (Exception ex)
            {
                client.Close();
                statusLabel.Style["color"] = "red";
                statusLabel.InnerText = "Something went wrong, try again later";
                 
          }

        }
    }
}
    