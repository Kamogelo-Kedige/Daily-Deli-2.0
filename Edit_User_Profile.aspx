<%@ Page Title="" Language="C#" MasterPageFile="~/Daily Deli Master Page.Master" AutoEventWireup="true"
    CodeBehind="Edit_User_Profile.aspx.cs" Inherits="Daily_Deli_E_Commerce.Edit_User_Profile" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <title>Edit User Profile - Daily Deli</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width,initial-scale=1" />
        <link href="css/StyleSheet.css" rel="stylesheet" />
        <link href="css/bootstrap.min.css" rel="stylesheet" />

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link href="<%= ResolveUrl(" ~/css/StyleSheet.css") %>?v=1" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="css/StyleSheet.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

        <style>
            :root {
                --bg:#fff !important;
                --card: #ffffff;
                --text: #fff;
                --muted: #6b7280;
                --line: #eef0f5;
                --primary: #0077CC;
                --primary-ghost: #0077CC;
                --danger: #ef4444;
                --success: #22c55e;
                --radius: 14px;
                --shadow: 0 10px 25px rgba(2, 6, 23, 0.06);
                --input: #f8fafc;
            }

            * {
                box-sizing: border-box
            }

            html,
            body {
                height: 100%;

            }

            body {
                margin: 0;
                font-family: Inter, system-ui, -apple-system, Segoe UI, Roboto, "Helvetica Neue", Arial, "Noto Sans", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
                color: var(--text);
                background: var(--bg);
                line-height: 1.35;
            }

            .wrap {
                max-width: 1080px;
                margin: 40px auto 80px;
                padding: 0 20px;
            }

            .card {
                background: var(--card);
                border-radius: var(--radius);
                box-shadow: var(--shadow);
            }

            .profile {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 22px 26px;
                border-bottom: 1px solid var(--line);
            }

            .user-meta {
                display: flex;
                gap: 14px;
                align-items: center;
            }

            .avatar {
                width: 70px;
                height: 70px;
                border-radius: 999px;
                display: grid;
                place-items: center;
                font-weight: 700;
                color: #fff;
                background: #0077CC;
                box-shadow: inset 0 0 0 2px rgba(255, 255, 255, .25);
            }

            .name-block {
                display: flex;
                flex-direction: column
            }

            .name {
                font-weight: 700;
                font-size: 1.05rem;
                letter-spacing: .2px
            }

            .email {
                color: var(--muted);
                font-size: .95rem;
                margin-top: 2px
            }

            .btn {
                appearance: none;
                border: 0;
                cursor: pointer;
                border-radius: 12px;
                padding: 10px 16px;
                font-weight: 600;
                font-size: .95rem;
                transition: transform .04s ease, box-shadow .2s ease, background .2s ease;
            }

            .btn-edit {
                background: var(--primary);
                color: #fff;
                box-shadow: 0 6px 14px rgba(91, 141, 239, .25);
            }

            .btn-edit:active {
                transform: translateY(1px)
            }

            .section {
                padding: 22px 26px;
            }

            .section h4 {
                margin: 0 0 14px;
                font-size: 1rem;
                font-weight: 700;
            }

            .grid {
                display: grid;
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 16px;
            }

            @media (max-width:820px) {
                .grid {
                    grid-template-columns: 1fr
                }
            }

            .field {
                display: flex;
                flex-direction: column;
                gap: 8px;
            }

            .label {
                font-size: .9rem;
                font-weight: 600;
                color: var(--muted);
            }

            .input,
            .select,
            .textarea {
                width: 100%;
                background: var(--input);
                border: 1px solid var(--line);
                border-radius: 12px;
                padding: 12px 14px;
                font-size: .98rem;
                outline: none;
                transition: border .15s ease, background .15s ease;
            }

            .input:focus,
            .select:focus,
            .textarea:focus {
                border-color: var(--primary);
                background: #fff;
                box-shadow: 0 0 0 4px var(--primary-ghost);
            }

            .muted {
                color: var(--muted);
                font-size: .92rem
            }

            .email-list {
                margin-top: 8px;
                border: 1px solid var(--line);
                border-radius: 12px;
                background: #fff;
            }

            .email-item {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 12px 14px;
                border-bottom: 1px solid var(--line);
            }

            .email-item:last-child {
                border-bottom: 0
            }

            .pill {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                padding: 8px 12px;
                border-radius: 999px;
                background: #f1f5f9;
                color: #0f172a;
                font-weight: 600;
                font-size: .9rem;
            }

            .dot {
                width: 8px;
                height: 8px;
                border-radius: 999px;
                background: var(--primary);
            }

            .ghost-link {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                background: transparent;
                border: 0;
                color: var(--primary);
                padding: 10px 0;
                font-weight: 700;
                cursor: pointer;
                text-decoration: none;
            }

            .switch {
                position: relative;
                display: inline-block;
                width: 48px;
                height: 28px;
            }

            .switch input {
                display: none
            }

            .slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: #e5e7eb;
                border-radius: 999px;
                transition: .2s;
            }

            .slider:before {
                content: "";
                position: absolute;
                height: 22px;
                width: 22px;
                left: 3px;
                top: 3px;
                background: #fff;
                border-radius: 999px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, .2);
                transition: .2s;
            }

            .switch input:checked+.slider {
                background: #0077CC
            }

            .switch input:checked+.slider:before {
                transform: translateX(20px)
            }

            .kicker {
                display: flex;
                gap: 12px;
                align-items: center;
                margin-bottom: 16px;
                color: var(--muted)
            }

            .lookup {
                display: grid;
                grid-template-columns: 1.1fr .9fr auto;
                gap: 12px;
                margin-bottom: 18px
            }

            @media (max-width:820px) {
                .lookup {
                    grid-template-columns: 1fr
                }
            }

            .btn-secondary {
                background: #0077CC;
                color: #fff;
                border-radius: 12px;
                padding: 12px 16px;
                font-weight: 700;
                border: 1px solid #dbe6ff
            }

            .two-col {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 16px
            }

            @media (max-width:820px) {
                .two-col {
                    grid-template-columns: 1fr
                }
            }

            .help {
                font-size: .86rem;
                color: var(--muted);
                margin-top: 6px
            }
        </style>



    </asp:Content>


    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


        <div class="wrap">
            <div class="card">
                <div class="profile">
                    <div class="user-meta">
                        <div class="avatar">
                            <asp:Label ID="lblAvatarInitials" runat="server" Text="--"></asp:Label>
                        </div>
                        <div class="name-block">
                            <div class="email">
                                <asp:Label ID="lblProfileEmail" runat="server" Text="-@gmail.com"></asp:Label>
                            </div>
                        </div>
                    </div>
                    <asp:Button ID="btnAdmin_Page" runat="server" CssClass="btn btn-edit" Text="Back to Home"
                        OnClick="btnAdmin_Page_Click" />

                </div>
                <div class="section">
                    <asp:Label ID="lblUserLookup" runat="server" CssClass="kicker" Text="User Lookup"></asp:Label>
                    <div class="lookup">
                        <asp:TextBox ID="txtSearchEmail" runat="server" CssClass="input"
                            placeholder="Search by Email Adress"></asp:TextBox>

                        <asp:Button ID="btnFindUser" runat="server" CssClass="btn-secondary" Text="Find User"
                            OnClick="btnFindUser_Click" />
                    </div>
                    <asp:Label ID="lblProfile" runat="server" CssClass="kicker" Text="Profile"></asp:Label>
                    <div class="grid">
                        <div class="field">
                            <asp:Label ID="lblTitle" runat="server" CssClass="label" AssociatedControlID="ddlTitle"
                                Text="Title"></asp:Label>
                            <asp:DropDownList ID="ddlTitle" runat="server" CssClass="select">
                                <asp:ListItem Value="0">Select title</asp:ListItem>
                                <asp:ListItem Value="1">Mr</asp:ListItem>
                                <asp:ListItem Value="2">Ms</asp:ListItem>
                                <asp:ListItem Value="3">Mrs</asp:ListItem>
                                <asp:ListItem Value="4">Dr</asp:ListItem>
                                <asp:ListItem Value="5">Miss</asp:ListItem>

                            </asp:DropDownList>
                        </div>

                        <div class="field">
                            <asp:Label ID="lblFullName" runat="server" CssClass="label"
                                AssociatedControlID="txtFullName" Text="Full Name"></asp:Label>
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="input" placeholder="Your First Name">
                            </asp:TextBox>
                        </div>
                        <div class="field">
                            <asp:Label ID="lblSurname" runat="server" CssClass="label" AssociatedControlID="txtSurname"
                                Text="Surname"></asp:Label>
                            <asp:TextBox ID="txtSurname" runat="server" CssClass="input" placeholder="Your Surname">
                            </asp:TextBox>
                        </div>

                    </div>
                </div>

                <div class="section" style="border-top: 1px solid var(--line)">
                    <asp:Label ID="lblAccountContact" runat="server" CssClass="kicker" Text="Account &amp; Contact">
                    </asp:Label>
                    <div class="grid">
                        <div class="field">
                            <asp:Label ID="lblPrimaryEmailLabel" runat="server" CssClass="label"
                                AssociatedControlID="txtEmail" Text="Primary Email"></asp:Label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="input" TextMode="Email"
                                placeholder="name@example.com"></asp:TextBox>
                        </div>
                        <div class="field">
                            <asp:Label ID="lblPhone" runat="server" CssClass="label" AssociatedControlID="txtPhone"
                                Text="Phone Number"></asp:Label>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="input" placeholder="+61 400 000 000">
                            </asp:TextBox>
                        </div>
                        <div class="field">
                            <asp:Label ID="lblDiet" runat="server" CssClass="label" AssociatedControlID="ddlDiet"
                                Text="Diet Type"></asp:Label>
                            <asp:DropDownList ID="ddlDiet" runat="server" CssClass="select">
                                <asp:ListItem Value="0">Select diet type</asp:ListItem>
                                <asp:ListItem Value="1">Standard</asp:ListItem>
                                <asp:ListItem Value="2">Vegetarian</asp:ListItem>
                                <asp:ListItem Value="3">Vegan</asp:ListItem>
                                <asp:ListItem Value="4">Hala</asp:ListItem>
                                <asp:ListItem Value="5">Fast Food</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="field">
                            <asp:Label ID="lblUserType" runat="server" CssClass="label"
                                AssociatedControlID="ddlUserType" Text="User Type"></asp:Label>
                            <asp:DropDownList ID="ddlUserType" runat="server" CssClass="select">
                                <asp:ListItem Value="1">Customer</asp:ListItem>
                                <asp:ListItem Value="2">Admin</asp:ListItem>
                                <asp:ListItem Value="3">Manager</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="field">
                            <asp:Label ID="lblLoyalty" runat="server" CssClass="label" AssociatedControlID="txtLoyalty"
                                Text="Loyalty Points"></asp:Label>
                            <asp:TextBox ID="txtLoyalty" runat="server" CssClass="input" TextMode="Number"
                                placeholder="0"></asp:TextBox>
                        </div>
                        <div class="field">
                            <asp:Label ID="lblAddress1" runat="server" CssClass="label"
                                AssociatedControlID="txtAddress1" Text="Address Line 1"></asp:Label>
                            <asp:TextBox ID="txtAddress1" runat="server" CssClass="input" placeholder="Street address">
                            </asp:TextBox>
                        </div>
                        <div class="field">
                            <asp:Label ID="lblCity" runat="server" CssClass="label" AssociatedControlID="txtCity"
                                Text="City"></asp:Label>
                            <asp:TextBox ID="txtCity" runat="server" CssClass="input" placeholder="City"></asp:TextBox>
                        </div>
                        <div class="field">
                            <asp:Label ID="lblPostal" runat="server" CssClass="label" AssociatedControlID="txtPostal"
                                Text="Postal Code"></asp:Label>
                            <asp:TextBox ID="txtPostal" runat="server" CssClass="input" placeholder="Postal code">
                            </asp:TextBox>
                        </div>
                        <div class="field">
                            <asp:Label ID="lblActive" runat="server" CssClass="label" AssociatedControlID="chkActive"
                                Text="Active"></asp:Label>
                            <label class="switch">
                                <asp:CheckBox ID="chkActive" runat="server" />
                                <span class="slider"></span>
                            </label>
                        </div>
                    </div>
                </div>
                <div class="section"
                    style="border-top: 1px solid var(--line); display: flex; gap: 12px; justify-content: flex-end">
                    <asp:Button ID="btnCancel" runat="server" CssClass="btn" Text="Cancel" OnClick="btnCancel_Click" />
                    <asp:Button ID="btnSave" runat="server" CssClass="btn btn-edit" Text="Save Changes"
                        OnClick="btnSave_Click" />
                    <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-edit" Text="Delete Account"
                        OnClick="btnDelete_Click" />
                </div>
            </div>
        </div>
    </asp:Content>