<%@ Page Title="" Language="C#" MasterPageFile="~/Daily Deli Master Page.Master" AutoEventWireup="true"
    CodeBehind="ResetPassword.aspx.cs" Inherits="Daily_Deli_E_Commerce.ResetPassword" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



        <div class="main-login">
            <section class="login-card">
                <div class="login-header">
                    <i class="fa fa-user-circle fa-3x"></i>
                    <h2>Reset Your Password</h2>
                </div>
                <div id="submitForm">
                    <asp:Panel ID="pnlEmail" runat="server" Visible="true">
                        <input type="email" id="txtEmail" name="email" placeholder="email" required runat="server" />
                        <asp:Button CssClass="button" ID="btnRequestOTP" runat="server" Text="Request OTP"
                            OnClick="btnRequestOTP_Click" />
                    </asp:Panel>

                    <asp:Panel ID="pnlOTP" runat="server" Visible="false">
                        <input type="text" id="txtOTP" name="otp" placeholder="Enter OTP" required runat="server" maxlength="6" />
                        <asp:Button CssClass="button" ID="btnVerifyOTP" runat="server" Text="Verify OTP"
                            OnClick="btnVerifyOTP_Click" />
                    </asp:Panel>

                    <asp:Panel ID="pnlPassword" runat="server" Visible="false">
                        <input type="password" id="txtPassword" name="password" placeholder="new password" required
                            runat="server" />
                        <input type="password" id="txtPasswordConfirm" name="password"
                            placeholder="confirm new password" required runat="server" />
                        <asp:Button CssClass="button" ID="btnResetPassword" runat="server" Text="Reset Password"
                            OnClick="btnResetPassword_Click" />
                    </asp:Panel>

                    <p id="statusLabel" runat="server"></p>

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