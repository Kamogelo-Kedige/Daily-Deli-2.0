using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Daily_Deli_E_Commerce.DailyDeliAPI;
namespace Daily_Deli_E_Commerce
{
    public partial class Admin : System.Web.UI.Page
    {

        Service_DailyDeliClient client = new Service_DailyDeliClient();
        protected void Page_Load(object sender, EventArgs e)
        {

            // Bind with your real numbers from DB/service
            lblActiveUsers.Text = client.getActiveUsers().ToString();
            lblInactiveUsers.Text = client.getInActiveUsers().ToString();
            lblTransactions.Text = "--";
            lblRevenue.Text = "--";
            lblProducts.Text = client.getTotalNumProducts().ToString();
            lblOOS.Text = client.getOutofStock().ToString();
            
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin_Profile.aspx");
        }

        protected void btnProducts_Click(object sender, EventArgs e)
        {
            Response.Redirect("Add_Products.aspx");
        }

       

        protected void btnUser_Profile(object sender, EventArgs e)
        {
            Response.Redirect("Edit_User_Profile.aspx");

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("Edit_Products.aspx");

        }
    }
}