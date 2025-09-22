<%@ Page Title="" Language="C#" MasterPageFile="~/Daily Deli Master Page.Master" AutoEventWireup="true"
    CodeBehind="Register.aspx.cs" Inherits="Daily_Deli_E_Commerce.Register" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <title>Register - Daily Deli</title>
        <script src="https://kit.fontawesome.com/1626dc2da5.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="css/StyleSheet.css" />
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



        <div class="register-main">
            <div class="register-card">
                <div class="register-header">
                    <i class="fa fa-user-circle fa-3x"></i>
                    <h2>User Registration</h2>
                </div>
                <div id="register-form" class="register-form">
                    <div class="register-row">
                        <div class="register-group">
                            <label for="title" class="register-label">Title</label>
                            <input type="text" id="title" name="title" class="register-input" placeholder="e.g. Mr/Ms"
                                required runat="server" />
                        </div>
                        <div class="register-group">
                            <label for="name" class="register-label">Name</label>
                            <input type="text" id="name" name="name" class="register-input" placeholder="Name" required
                                runat="server" />
                        </div>
                    </div>
                    <div class="register-row">
                        <div class="register-group">
                            <label for="surname" class="register-label">Surname</label>
                            <input type="text" id="surname" name="surname" class="register-input" placeholder="Surname"
                                required runat="server" />
                        </div>
                        <div class="register-group">
                            <label for="email" class="register-label">Email</label>
                            <input type="email" id="email" name="email" class="register-input" placeholder="Email"
                                required runat="server" />
                        </div>
                    </div>
                    <div class="register-row">
                        <div class="register-group">
                            <label for="dietType" class="register-label">Diet Type</label>
                            <select id="dietType" name="dietType" runat="server" class="register-select">
                                <option value="" disabled selected hidden>Select Diet Type</option>
                                <option value="1">None</option>
                                <option value="2">Halal</option>
                                <option value="3">Vegetarian</option>
                            </select>
                        </div>
                    </div>
                    <div class="register-row">
                        <div class="register-group">
                            <label for="password" class="register-label">Password</label>
                            <input type="password" id="password" name="password" class="register-input"
                                placeholder="Password" required runat="server" />
                        </div>
                        <div class="register-group">
                            <label for="confirmPassword" class="register-label">Confirm Password</label>
                            <input type="password" id="confirmPassword" name="confirm-password" class="register-input"
                                placeholder="Confirm Password" required runat="server" />
                        </div>
                    </div>

                    <p id="statusLabel" runat="server"></p>
                    <asp:Button ID="btnSubmit" runat="server" Text="Register" CssClass="register-button"
                        OnClick="btnSubmit_Click" />
                    <p class="register-login-link">
                        Have an account? <a href="Login.aspx">Login</a>
                    </p>

                    <div class="form-footer" style="text-align: center; margin-top: 1rem;">
                        <a href="Home.aspx" style="display: inline-block;">
                            <i class="fas fa-home" style="font-size: 1.3rem; color: var(--accent-color);"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>



    </asp:Content>