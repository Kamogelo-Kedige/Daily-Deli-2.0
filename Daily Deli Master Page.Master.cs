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
            // Ensure admin link visibility for Admin users on this page (fallback if master logic fails)
            try
            {
                if (Session["UserType"] != null)
                {
                    var ut = Session["UserType"].ToString();
                    if (!string.IsNullOrEmpty(ut) && ut.Equals("Admin", StringComparison.OrdinalIgnoreCase))
                    {

                        shopAdminLink.Visible = true;
                    
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Shop admin visibility check failed: {ex.Message}");
            }
        }
    }
}