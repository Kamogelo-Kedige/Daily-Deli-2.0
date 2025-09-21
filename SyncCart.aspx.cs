using Daily_Deli_E_Commerce.DailyDeliAPI;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Daily_Deli_E_Commerce
{
    public partial class SyncCart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.HttpMethod == "POST" && Session["UserId"] != null)
            {
                try
                {
                    using (var reader = new StreamReader(Request.InputStream))
                    {
                        string json = reader.ReadToEnd();
                        System.Diagnostics.Debug.WriteLine($"SyncCart request: {json}");
                        var serializer = new JavaScriptSerializer();
                        dynamic data = serializer.Deserialize<dynamic>(json);

                        if (data["action"] == "update")
                        {
                            var incomingCartJson = serializer.Serialize(data["cart"]);
                            System.Diagnostics.Debug.WriteLine($"Incoming CartJson: {incomingCartJson}");
                            var client = new Service_DailyDeliClient();
                            client.SaveUserCart((int)Session["UserId"], incomingCartJson);
                            System.Diagnostics.Debug.WriteLine("SaveUserCart called");

                            Response.ContentType = "application/json";
                            Response.Write(serializer.Serialize(new { success = true }));
                        }
                        else
                        {
                            Response.StatusCode = 400;
                            Response.Write(serializer.Serialize(new { success = false, error = "Invalid action" }));
                        }
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"SyncCart error: {ex.Message}");
                    Response.StatusCode = 500;
                    Response.Write(new JavaScriptSerializer().Serialize(new { success = false, error = ex.Message }));
                }
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("Invalid request: Not POST or no UserId");
                Response.StatusCode = 401;
                Response.End();
            }
        }
    }
}