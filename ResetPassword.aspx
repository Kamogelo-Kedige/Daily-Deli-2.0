<%@ Page Title="" Language="C#" MasterPageFile="~/Daily Deli Master Page.Master" AutoEventWireup="true"
    CodeBehind="ResetPassword.aspx.cs" Inherits="Daily_Deli_E_Commerce.ResetPassword" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



        <div class="main-login">
            <section class="login-card">
                <div class="login-header">
                    <i class="fa fa-user-circle fa-3x"></i>
                    <h2>Reset Your Password</h2>
                </div>
                <div id="submitForm">
                    <input type="text" id="txtName" name="name" placeholder="name" required runat="server" />
                    <input type="text" id="txtSurname" name="email" placeholder="surname" required runat="server" />
                    <input type="email" id="txtEmail" name="email" placeholder="email" required runat="server" />
                    <div class="register-row">
                        <div class="register-group">
                            <select id="dietType" name="dietType" runat="server" class="register-select">
                                <option value="" disabled selected hidden style="color:#888;">chosen
                                    diet type</option>
                                <option value=" 1">None</option>
                                <option value="2">Halal</option>
                                <option value="3">Vegetarian</option>
                            </select>
                        </div>
                    </div>
                    <div id="hiddenFields" runat="server" visible="false">
                        <input type="password" id="txtPassword" name="password" placeholder="new password" required
                            runat="server" />
                        <input type="password" id="txtPasswordConfirm" name="password"
                            placeholder="confirm new password" required runat="server" />
                    </div>
                    <p id="statusLabel" runat="server"></p>
                    <asp:Button CssClass="button" ID="btnResetPassword" runat="server" Text="Reset Password"
                        OnClick="btnResetPassword_Click" />
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