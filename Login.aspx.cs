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
                //Try t login the user
                int Login = client.Login(email.Value, Secrecy.HashPassword(password.Value));



                string UserType = Session["UserTYpe"] as string;

          





                if (Login != -1)
                {
                    string Type = client.GetUsertype(Login);

                    //Store the logged in session, will later enable nav manipulation
                    Session["UserId"] = Login;
                    Session["UserTYpe"] = UserType;

                    



                    if (Type.Equals("Admin"))
                    {
                        Response.Redirect("Admin.aspx"); ; // link for admin
                    }
                    else if (Type.Equals("Customer"))
                    {
                        Response.Redirect("Shop.aspx");
                   
                    }


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
                Console.WriteLine(ex.Message);
            }
        }
    }
}