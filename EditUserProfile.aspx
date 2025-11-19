<%@ Page Title="" Language="C#" MasterPageFile="~/Daily Deli Master Page.Master" AutoEventWireup="true" CodeBehind="EditUserProfile.aspx.cs" Inherits="Daily_Deli_E_Commerce.EditUserProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Edit Profile - Daily Deli</title>
    <script src="https://kit.fontawesome.com/1626dc2da5.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/StyleSheet.css" />
    <style>
        .full-screen-profile {
            min-height: 100vh;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            box-sizing: border-box;
            background-color: var(--background-color, #f5f5f5);
        }
        .full-screen-profile .login-card {
            width: 100%;
            max-width: 500px;
            min-height: 80vh;
            display: flex;
            flex-direction: column;
            padding: 2rem;
        }
        .full-screen-profile #editForm {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .full-screen-profile label {
            margin-top: 1rem;
            font-weight: bold;
        }
        .full-screen-profile input {
            width: 100%;
            padding: 0.75rem;
            margin-top: 0.5rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="full-screen-profile">
        <section class="login-card">
            <div class="login-header">
                <i class="fa fa-user-edit fa-3x"></i>
                <h2>Profile</h2>
            </div>
            <div id="editForm">
                <p id="statusLabel" runat="server"></p>

                <label for="title">Title:</label>
                <input type="text" id="title" name="title" placeholder="Title (e.g., Mr/Ms)" runat="server" />

                <label for="name">Name:</label>
                <input type="text" id="name" name="name" placeholder="Name" required runat="server" />

                <label for="surname">Surname:</label>
                <input type="text" id="surname" name="surname" placeholder="Surname" required runat="server" />

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" placeholder="Email" required runat="server" />

                <label for="phoneNumber">Phone Number:</label>
                <input type="tel" id="phoneNumber" name="phoneNumber" placeholder="Phone Number" runat="server" />

                <label for="addressLine">Address Line 1:</label>
                <input type="text" id="addressLine1" name="addressLine1" placeholder="Address Line 1" runat="server" />

                <label for="city">City:</label>
                <input type="text" id="city" name="city" placeholder="City" runat="server" />

                <label for="postalCode">Postal Code:</label>
                <input type="text" id="postalCode" name="postalCode" placeholder="Postal Code" runat="server" />

                <asp:Button CssClass="button" ID="btnUpdate" runat="server" Text="Update Profile" OnClick="btnUpdate_Click" />

                <div class="form-footer" style="text-align: center; margin-top: 1rem;">
                    <a href="Shop.aspx" style="display: inline-block;">
                        <i class="fas fa-arrow-left" style="font-size: 1.3rem; color: var(--accent-color);"></i> Back to Shop
                    </a>
                </div>
            </div>
        </section>
    </div>
</asp:Content>