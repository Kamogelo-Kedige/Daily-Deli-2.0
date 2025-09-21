<%@ Page Title="" Language="C#" MasterPageFile="~/Daily Deli Master Page.Master" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs" Inherits="Daily_Deli_E_Commerce.Login" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

        <title>Login</title>
        <script src="https://kit.fontawesome.com/1626dc2da5.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="css/StyleSheet.css" />

    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">




        <div class="main-login">
            <section class="login-card">
                <div class="login-header">
                    <i class="fa fa-user-circle fa-3x"></i>
                    <h2>Login to Daily Deli</h2>
                </div>
                <div id="submitForm">

                    <input type="email" id="email" name="email" placeholder="email" required runat="server" />


                    <input type="password" id="password" name="password" placeholder="Password" required
                        runat="server" />

                     <p id="statusLabel" runat="server"></p>

                    <div class="form-links"
                        style="display:flex; flex-wrap:wrap; justify-content:flex-start; gap:1rem; margin-bottom:1rem; font-size:0.95rem; color:var(--color-muted-foreground);">
                        <a href="ResetPassword.aspx" style="color:var(--color-muted-foreground); text-decoration:underline;">Forgot
                            Password?</a>

                    </div>



                    <asp:Button CssClass="button" ID="btnlogin" runat="server" Text="Login" OnClick="btnlogin_Click" />
                    <p>
                        Have no account? <a href="Register.aspx">register</a>
                    </p>
                   


                    <div class="form-footer" style="text-align:center; margin-top:1rem;">
                        <a href="Home.aspx" style="display:inline-block;">
                            <i class="fas fa-home" style="font-size:1.3rem; color:var(--accent-color);"></i>
                        </a>
                    </div>

                </div>

            </section>
        </div>

    </asp:Content>