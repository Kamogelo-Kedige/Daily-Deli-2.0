using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Daily_Deli_E_Commerce
{
    public partial class Daily_Deli_Master_Page : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Default: hide admin nav
            try
            {
                if (Session["UserType"] != null)
                {
                    var userType = Session["UserType"].ToString();
                    if (!string.IsNullOrEmpty(userType) && userType.Equals("Admin", StringComparison.OrdinalIgnoreCase))
                    {
                        navAdmin.Visible = true;
                        
                      
                    }
                }
            }
            catch
            {
                // Don't throw from master page load for session issues
            }
        }
    }
}