using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Daily_Deli_E_Commerce
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear and abandon the session on logout
            Session.Clear();
            Session.Abandon();
            // Redirect to the login page after logout
            Response.Redirect("Login.aspx");
        }
    }
}