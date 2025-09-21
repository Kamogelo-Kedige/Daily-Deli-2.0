using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Daily_Deli_E_Commerce.DailyDeliAPI;

namespace Daily_Deli_E_Commerce
{

    
    public partial class Edit_User_Profile : System.Web.UI.Page
    {
        Service_DailyDeliClient client = new Service_DailyDeliClient();

        public UserDTO user = new UserDTO();


        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnAdmin_Page_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }

        protected void btnFindUser_Click(object sender, EventArgs e)
        {


            string Email = txtSearchEmail.Text.Trim();

            if (string.IsNullOrEmpty(Email)) {


                Response.Write("<script>alert('Please enter email to find the User.')</script>");

            }
            else {

              
                string title;
                int diettype;
                string userType;
                

                user = client.getUser(Email);

                if (user != null) {

                     Session["User_Id"] = user.Id;
                   Response.Write($"<script>alert('User has Successfully been found. ID: { Session["User_Id"]}');</script>");


                    txtFullName.Text = user.Name;
                    txtSurname.Text  = user.Surname ;
                    title = user.Title.ToLower().Trim();
                    Session["User_Password"] = user.Password;
                    switch (title) {

                        case "mrs":
                            ddlTitle.SelectedValue = "3";

                            break;

                        case "mr":

                            ddlTitle.SelectedValue = "1";

                            break;

                        case "dr":
                            ddlTitle.SelectedValue = "4";


                            break;

                        case "ms":
                            ddlTitle.SelectedValue = "2";

                            break;


                        case "miss":
                            ddlTitle.SelectedValue = "5";

                            break;
                    }

                    txtEmail.Text = user.Email;
                    txtPhone.Text = user.PhoneNumber;


                    diettype = user.DietType;

                    switch (diettype)
                    {

                        case 3:
                            ddlDiet.SelectedValue = "2";

                            break;

                        case 1:

                            ddlDiet.SelectedValue = "1";

                            break;

                        case 2:
                            ddlDiet.SelectedValue = "4";


                            break;

                        case 5:
                            ddlDiet.SelectedValue = "5";

                            break;
                    }


                    userType = user.UserType.ToLower().Trim();

                    switch (userType)
                    {

                        case "customer":
                            ddlDiet.SelectedValue = "1";

                            break;

                        case "user":

                            ddlDiet.SelectedValue = "1";

                            break;

                        case "admin":
                            ddlDiet.SelectedValue = "2";


                            break;

                        case "manager":
                            ddlDiet.SelectedValue = "3";

                            break;
                    }

                    txtLoyalty.Text = (user?.LoyaltyPoints ?? 0).ToString();

                    txtAddress1.Text = string.IsNullOrWhiteSpace(user?.AddressLine1)
                        ? "null"
                        : user.AddressLine1.Trim();

                    txtCity.Text = string.IsNullOrWhiteSpace(user?.City)
                        ? "null"
                        : user.City.Trim();

                    txtPostal.Text = string.IsNullOrWhiteSpace(user?.PostalCode)
                        ? "null"
                        : user.PostalCode.Trim();

                    txtCity.Text = user.City;
                    txtPostal.Text = user.PostalCode;


                    lblProfileEmail.Text = user.Email.Trim();
                    string Name = user.Name.Trim();
                    string Surname = user.Surname.Trim();
                    string initial = Name.Substring(0, 1) + Surname.Substring(0, 1);
                    lblAvatarInitials.Text = initial;
                    if (user.IsActive) {

                        chkActive.Checked = true;
                    }
                    else {

                        chkActive.Checked = false;
                    }

                }
                else {

                    Response.Write("<script>alert('User can not be found in the Database.')</script>");



                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Write("<script>alert('Cancelled changes successfully.')</script>");

            txtSearchEmail.Text =" ";

            txtFullName.Text = " ";
            txtSurname.Text = " " ;
            ddlTitle.SelectedValue = "0";
            txtEmail.Text = " ";
            txtPhone.Text = " ";
            ddlDiet.SelectedValue = "0";
            ddlDiet.SelectedValue = "0";

            txtLoyalty.Text = " ";
            txtAddress1.Text = " ";
            txtCity.Text = " ";

            txtPostal.Text = " ";
            txtCity.Text = " ";
            txtPostal.Text = " ";


            lblProfileEmail.Text = " ";
            lblAvatarInitials.Text = " ";
                    
            chkActive.Checked = false;
                   
            }




        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string Email = txtSearchEmail.Text.Trim();

            if (string.IsNullOrEmpty(Email))
            {


                Response.Write("<script>alert('Please enter email to find the User.')</script>");

            }
            else
            {


                user = client.getUser(Email);

                if (user != null)
                {
                    Response.Write("<script>alert('User has Successfully Deleted from the Database.')</script>");
                    int userId = user.Id;
                    client.DeleteUser(userId);
                }
                else
                {
                    Response.Write("<script>alert('User can not be found in the Database.')</script>");
                }
            }




        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            user.Id = Convert.ToInt32(Session["User_Id"]);
            user.Password = Session["User_Password"].ToString();
            user.Email =txtSearchEmail.Text;
            
            user.Name = txtFullName.Text;
            user.Surname = txtSurname.Text ;
            switch (ddlTitle.SelectedValue)
            {

                case "3":
                    user.Title = "Mrs";

                    break;

                case "1":

                    user.Title = "Mr";

                    break;

                case "4":
                    user.Title = "Dr";


                    break;

                case "2":
                    user.Title = "Ms";

                    break;


                case "5":
                    user.Title = "Miss";

                    break;
            }
           

            switch (ddlUserType.SelectedValue)
            {

                case "1":
                    user.UserType = "Customer";

                    break;


                case "2":
                    user.UserType = "Admin";


                    break;

                case "3":
                    user.UserType = "Manager";

                    break;
            }




            user.PhoneNumber = txtPhone.Text;
            user.DietType =int.Parse( ddlDiet.SelectedValue );
            
            user.LoyaltyPoints = int.Parse( txtLoyalty.Text);
            user.AddressLine1= txtAddress1.Text;
            user.City = txtCity.Text;

            user.PostalCode = txtPostal.Text;

            user.IsActive = chkActive.Checked;

            if (client.UpdateUserInfo(user))
            {
                Response.Write("<script>alert('Changes has been successfully been updated ')</script>");
            }
            else {
                Response.Write("<script>alert('Changes has not updated ,Please re-try ')</script>");

            }


        }

    }

        
    
}


