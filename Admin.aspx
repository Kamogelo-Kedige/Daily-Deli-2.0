<%@ Page Title="" Language="C#" MasterPageFile="~/Daily Deli Master Page.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="Daily_Deli_E_Commerce.Admin" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <link href="css/StyleSheet.css" rel="stylesheet" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <style>
        :root {
  --header-bg: #f5f5f5;
  --link-color: #333;
  --link-hover: #0077cc;
  --brand-bg: #f5f5f5;
  --brand-color: #333;
  --accent-color: #0077cc;
  --body-background: #fafafa;
  --form-bg: #ffffff;
  --input-border: #ccc;
  --input-focus: var(--accent-color);
  --transition: 0.3s ease;
  --card-bg: #fff;
  --card-shadow: rgba(0, 0, 0, 0.05);
  --footer-bg: #222;
  --footer-text: #ddd;
  --footer-link: #fff;
  --footer-link-hover: #0077cc;
  --button-hover: rgb(5, 151, 255);
}

body {
  margin: 0;
  padding: 0;
  font-family: "Poppins", "Inter", sans-serif !important;
  background: #fafafa;
  color: var(--brand-color);
  width: 100%;
  scroll-behavior: smooth;
}

*,
*::before,
*::after {
  box-sizing: border-box;
}

header {
  display: flex;
  height: 10%;
  align-items: center;
  justify-content: space-between;
  background: var(--header-bg);
  padding: 1rem 2rem;
  position: sticky;
  top: 0;
  z-index: 50;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.35);
}

.logo h1 {
  margin: 0;
  font-size: 1.5rem !important;
  font-weight: 700 !important;
}

.logo a {
  color: var(--link-color);
  text-decoration: none;
  transition: color var(--transition);
}

.logo a:hover,
.logo a:focus {
  color: var(--link-hover);
  transition: color var(--transition);
}

.nav ul {
  list-style: none;
  margin: 0;
  padding: 0;
  display: flex;
  align-items: center;
  gap: 1rem;
  flex-wrap: wrap;
}

.nav-link {
  color: var(--link-color);
  text-decoration: none;
  font-size: 1rem;
  padding: 0.5rem;
  transition: color var(--transition), background var(--transition);
  font-weight: 700 !important;
  position: relative;
  background: none !important;
  text-decoration: none !important;
  transition: color 0.2s;
}

.nav-link::after {
  content: "";
  position: absolute;
  left: 0;
  bottom: -2px;
  width: 0;
  height: 2px;
  background: var(--accent-color);
  transition: width 0.3s cubic-bezier(0.68, -0.55, 0.27, 1.55);
}

.nav-link:hover::after,
.nav-link:focus::after {
  width: 100%;
}

.nav-link:hover,
.nav-link:focus {
  color: var(--accent-color);
  background: rgba(0, 119, 204, 0.1);
  border-radius: 0.25rem;
  text-decoration: underline;
}

/* Modern nav button styles for header */
.nav-btn {
  display: inline-block;
  background: var(--accent-color);
  color: #fff !important;
  border: none;
  border-radius: 2rem;
  padding: 0.5rem 1.5rem;
  font-size: 1rem;
  font-weight: 600;
  box-shadow: 0 2px 8px rgba(0, 119, 204, 0.08);
  transition: background 0.2s, transform 0.2s, box-shadow 0.2s;
  cursor: pointer;
  outline: none;
  text-align: center;
  margin-left: 0.5rem;
  position: relative;
  overflow: hidden;
  z-index: 1;
}

.nav-btn::before {
  content: "";
  position: absolute;
  left: 0;
  top: 0;
  width: 0;
  height: 100%;
  background: var(--button-hover);
  z-index: -1;
  transition: width 0.3s cubic-bezier(0.68, -0.55, 0.27, 1.55);
  border-radius: 2rem;
}

.nav-btn:hover::before,
.nav-btn:focus::before {
  width: 100%;
}

.nav-btn:hover,
.nav-btn:focus {
  color: #fff !important;
  background: var(--button-hover);
}

.nav-btn-outline {
  background: transparent !important;
  color: var(--accent-color) !important;
  border: 2px solid var(--accent-color) !important;
  box-shadow: none !important;
  position: relative;
  overflow: hidden;
  z-index: 1;
}

.nav-btn-outline::before {
  content: "";
  position: absolute;
  left: 0;
  top: 0;
  width: 0;
  height: 100%;
  background: var(--button-hover);
  z-index: -1;
  transition: width 0.5s cubic-bezier(0.68, -0.55, 0.27, 1.55);
  border-radius: 2rem;
}

.nav-btn-outline:hover::before,
.nav-btn-outline:focus::before {
  width: 100%;
}

.nav-btn-outline:hover,
.nav-btn-outline:focus {
  color: #fff !important;
  border: none !important;
  background: transparent !important;
  outline: none !important;
  box-shadow: none !important;
}

.nav-btn-outline:active {
  border: none !important;
  outline: none !important;
  box-shadow: none !important;
}

@media (max-width: 700px) {
  .nav-btn {
    width: 100%;
    margin: 0.5rem 0;
    font-size: 1.1rem;
    padding: 0.7rem 1.2rem;
    border-radius: 1.5rem;
  }
}
        /* Hover effect for all feature cards */
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0,0,0,0.15);
            transition: all 0.25s ease;
        }

        /* Smooth transition back */
        .card {
            transition: all 0.25s ease;
        }

        body {
            background: #d9d9d9; /* light dull black */
            font-family: "Segoe UI", sans-serif;
        }

        /* Grid structure like product cards */
        .cards-grid {

            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1rem;
            padding : 1rem;
        }

        .glass-card {
            background: rgba(255,255,255,0.08);
            border: 1px solid rgba(255,255,255,0.12);
            border-radius: 16px;
            padding: 1.5rem;
            text-align: center;
            transition: transform .2s ease, box-shadow .2s ease;
        }

            .glass-card:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 30px rgba(0,0,0,0.35);
            }

        .icon-top {
            width: 70px;
            height: 70px;
            border-radius: 16px;
            display: grid;
            place-items: center;
            margin: 0 auto 10px auto;
            background: rgba(255,255,255,.12);
        }

            .icon-top i {
                font-size: 2rem;
                color: #fff;
            }

        .card-title {
            color: #f1f1f1;
            font-size: 1.05rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .btn-orange {
            background: linear-gradient(180deg, #ffb463, #ff8a00);
            border: none;
            color: #1a1a1d;
            font-weight: 600;
            padding: 6px 0;
            border-radius: 8px;
            transition: all .2s ease;
        }

            .btn-orange:hover {
                filter: brightness(.95);
                box-shadow: 0 6px 16px rgba(255,138,0,0.5);
            }

        /* Admin info card on left */
        .admin-card {
            background: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.15);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            color: #fff;
        }

        .admin-avatar {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            background: rgba(0,0,0,0.2); /* darker background */
            display: grid;
            place-items: center;
            font-size: 2rem;
            margin-bottom: 1rem;
            color: #000; /* icon stays black */
        }


        .admin-features {
            list-style-type: disc; /* bullet points */
            padding-left: 20px; /* space before bullets */
            margin-top: 10px;
            color: #000; /* text color black */
            font-size: 0.95rem;
        }

            .admin-features li {
                margin-bottom: 8px;
                line-height: 1.4;
            }

            .admin-features span {
                color: #555; /* slightly lighter grey for details */
                font-size: 0.9rem;
            }


        .admin-name {
            font-size: 1.2rem;
            font-weight: 700;
            margin-bottom: 5px;
            color: #000;
        }

        .admin-role {
            font-size: 0.9rem;
            color: #bbb;
            margin-bottom: 1.5rem;
        }



        .admin-card {
            background: rgba(255,255,255,0.07);
            border: 1px solid rgba(255,255,255,0.3);
            border-radius: 20px;
            padding: 2.5rem;
            min-height: 690px;
        }

        .admin-avatar {
            width: 120px;
            height: 120px;
            font-size: 3rem;
            margin: 0 auto 1rem auto;
        }

        .big-icon {
            font-size: 4rem;
        }


        :root {
            /* theme */
            --bg: #f6f7fb;
            --card: #fff;
            --text: #0f172a;
            --muted: #64748b;
            --line: #eef0f5;
            --primary: #FF8A00;
            --primary-ghost: #FFE5C2;
            --radius: 14px;
            --shadow: 0 10px 25px rgba(2,6,23,.06);
        }

        /* layout */
        .dash-wrap {
            max-width: 1080px;
            margin: 24px auto;
            padding: 0 20px
        }

        .dash-head {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin: 0px 0 5px
        }

        .dash-title {
            font-weight: 800;
            font-size: 2rem;
            letter-spacing: .2px
        }

        .dash-actions {
            display: flex;
            gap: 10px
        }

        /* buttons */
        .btn {
            appearance: none;
            border: 0;
            cursor: pointer;
            border-radius: 12px;
            padding: 10px 16px;
            font-weight: 700;
            font-size: .95rem;
            transition: transform .04s, box-shadow .2s, background .2s
        }

            .btn:active {
                transform: translateY(1px)
            }

        .btn-primary {
            background: var(--primary);
            color: #fff;
            box-shadow: 0 6px 14px rgba(255,138,0,.45)
        }

        .btn-ghost {
            background: #fff;
            border: 1px solid var(--line);
            color: var(--text)
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(6, minmax(220px, 320px));
            gap: 16px;
            justify-content: center; /* keep centered inside a wider container */
        }


        @media (max-width:500px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
        }

        /* cards */
        .stat-card {
            position: relative;
            background: var(--card);
            border: 1px solid var(--line);
            border-radius: var(--radius);
            padding: 18px;
            box-shadow: var(--shadow);
            overflow: hidden;
            transition: transform .18s ease, box-shadow .18s ease, border-color .18s ease;
            --accent: #9aa0a6;
            --accent-bg: #f5f7fb;
            background: var(--accent-bg);
            border-color: color-mix(in srgb, var(--accent) 20%, #ffffff);
        }

            .stat-card:hover {
                transform: translateY(-3px);
                box-shadow: 0 18px 36px rgba(2,6,23,.10);
                border-color: color-mix(in srgb, var(--accent) 35%, #ffffff);
            }

        /* bigger card heading */
        .stat-kicker {
            color: var(--muted);
            font-size: 1.08rem; /* was .9rem */
            font-weight: 800;
            margin-bottom: 10px;
            display: flex;
            gap: 8px;
            align-items: center
        }

        .dot {
            width: 8px;
            height: 8px;
            border-radius: 999px;
            background: var(--accent)
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 800;
            letter-spacing: .3px
        }

        .stat-sub {
            color: var(--muted);
            margin-top: 6px;
            font-size: .9rem
        }

        /* hover panel */
        .hover-panel {
            position: absolute;
            inset: auto 12px 12px 12px;
            background: #fff;
            border: 1px solid var(--line);
            padding: 14px;
            border-radius: 12px;
            box-shadow: 0 10px 24px rgba(2,6,23,.10);
            transform: translateY(8px);
            opacity: 0;
            pointer-events: none;
            transition: opacity .15s, transform .15s;
        }

        .stat-card:hover .hover-panel {
            opacity: 1;
            transform: translateY(0);
            pointer-events: auto
        }

        .panel-row {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            margin-bottom: 8px;
            color: var(--muted)
        }

            .panel-row b {
                color: var(--text)
            }

        .panel-actions {
            display: flex;
            gap: 8px;
            justify-content: flex-end;
            margin-top: 6px
        }

        .badge {
            background: var(--primary-ghost);
            color: #7a4b00;
            font-weight: 700;
            border-radius: 999px;
            padding: 4px 8px;
            font-size: .8rem
        }

        /* subtle accent palettes (apply one class per card) */
        .accent-blue {
            --accent: #3b82f6;
            --accent-bg: #e8f1ff;
        }

        .accent-green {
            --accent: #22c55e;
            --accent-bg: #e9f7ef;
        }

        .accent-amber {
            --accent: #f59e0b;
            --accent-bg: #fff5e6;
        }

        .accent-purple {
            --accent: #8b5cf6;
            --accent-bg: #f1eaff;
        }

        .accent-teal {
            --accent: #14b8a6;
            --accent-bg: #e6fffb;
        }

        .accent-rose {
            --accent: #f43f5e;
            --accent-bg: #ffe9ee;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-xxl">


        <div class="dash-wrap">
            <div class="dash-head">
                <div class="dash-title">Dashboard Summary</div>
                <div class="dash-actions">
                    <asp:Button ID="btnRefresh" runat="server" CssClass="btn btn-ghost" Text="Refresh" />
                  
                </div>
            </div>

            <div class="stats-grid">

                <!-- Active Users -->
                <div class="stat-card accent-green">
                    <div class="stat-kicker"><span class="dot"></span>Active Users</div>
                    <div class="stat-value">
                        <asp:Label ID="lblActiveUsers" runat="server" Text="0" />
                    </div>
                    <div class="stat-sub">Accounts that have the potential to make purchase and transactions</div>
                  
                </div>

                <!-- Inactive Users -->
                <div class="stat-card accent-rose">
                    <div class="stat-kicker"><span class="dot"></span>Inactive Users</div>
                    <div class="stat-value">
                        <asp:Label ID="lblInactiveUsers" runat="server" Text="0" />
                    </div>
                    <div class="stat-sub">Disabled or never activated</div>
                   
                </div>

                <!-- Transactions -->
                <div class="stat-card accent-blue">
                    <div class="stat-kicker"><span class="dot"></span>Transactions</div>
                    <div class="stat-value">
                        <asp:Label ID="lblTransactions" runat="server" Text="0" />
                    </div>
                    <div class="stat-sub">All-time processed</div>
                   
                </div>

                <!-- Total Revenue -->
                <div class="stat-card accent-amber">
                    <div class="stat-kicker"><span class="dot"></span>Total Revenue</div>
                    <div class="stat-value">
                        R
                        <asp:Label ID="lblRevenue" runat="server" Text="0" />
                    </div>
                    <div class="stat-sub">Gross sales (all time)</div>
                   
                </div>

                <!-- Products In Catalog -->
                <div class="stat-card accent-purple">
                    <div class="stat-kicker"><span class="dot"></span>Total Products</div>
                    <div class="stat-value">
                        <asp:Label ID="lblProducts" runat="server" Text="0" />
                    </div>
                    <div class="stat-sub">The total number of products in the database not yet sold</div>
                    
                </div>

                <!-- Out of Stock -->
                <div class="stat-card accent-teal">
                    <div class="stat-kicker"><span class="dot"></span>Out of Stock</div>
                    <div class="stat-value">
                        <asp:Label ID="lblOOS" runat="server" Text="0" />
                    </div>
                    <div class="stat-sub">Number of products that are out of stock</div>
                   
                </div>

            </div>
        </div>

        <div class="row">

            <div class="col-12 col-md-3">
                <div class="admin-card text-center">
                    <div class="admin-avatar"><i class="bi bi-person-gear"></i></div>
                    <div class="admin-name">Administrator</div>

                    <div class="admin-role">Name : </div>

                    <div class="admin-role">Surname : </div>

                    <div class="admin-role">Gender : </div>

                    <div class="admin-name">Roles</div>
                    <ul class="admin-features">
                        <li>Dashboard &amp; Sales Tracking</li>
                        <li>Product &amp; Catalog Management </li>
                        <li>Order &amp; Fulfilment Management </li>
                        <li>User Profile &amp; Roles Management </li>
                        <li>Recipes &amp; Meal Plans </li>
                    </ul>
                    <br>
                    <br>
                    <asp:Button ID="Button2" runat="server" Text="View Profile"
                        CssClass="btn btn-lg w-100"
                        Style="background: linear-gradient(90deg, #ff9966, #ff5e62); border: none; color: #fff; font-weight: 600; border-radius: 25px;" OnClick="Button2_Click" />
                </div>
            </div>


            <div class="col-8 col-md-9">
                <div class="cards-grid">

                    <div class="col">
                        <div class="card h-100 border-0 shadow-sm text-center p-4"
                            style="border-radius: 16px; max-width: 500px; margin: 0 auto;">

                            <div class="mb-3">
                                <i class="bi bi-box-seam text-success big-icon"></i>
                            </div>

                            <h5 class="fw-bold text-dark mb-2">Edit Product & Catalog Management</h5>

                            <!-- Description -->
                            <p class="text-muted mb-4">
                                Manage products, nutrition, allergens, dietary tags, categories, and stock.
                            </p>

                            <asp:Button ID="Button1" runat="server" Text="Open"
                                CssClass="btn btn-lg w-50"
                                Style="background: linear-gradient(90deg, #ff9966, #ff5e62); border: none; color: #fff; font-weight: 600; border-radius: 25px;" OnClick="Button1_Click" />

                        </div>
                    </div>

                    <!-- Products & Catalog Card -->
                    <div class="col">
                        <div class="card h-100 border-0 shadow-sm text-center p-4"
                            style="border-radius: 16px; max-width: 500px; margin: 0 auto;">

                            <!-- Icon -->
                            <div class="mb-3">
                                <i class="bi bi-box-seam text-success" style="font-size: 4rem;"></i>
                            </div>

                            <!-- Title -->
                            <h5 class="fw-bold text-dark mb-2">Add Products & Catalog</h5>

                            <!-- Description -->
                            <p class="text-muted mb-4">
                                Browse and maintain your product listings, categories, and pricing.
                            </p>

                            </br>
                            <asp:Button ID="btnProducts" runat="server" Text="Open"
                                CssClass="btn btn-lg w-50"
                                Style="background: linear-gradient(90deg, #ff9966, #ff5e62); border: none; color: #fff; font-weight: 600; border-radius: 25px;"
                                OnClick="btnProducts_Click" />

                        </div>
                    </div>

                    <!-- Orders & Fulfilment Card -->
                    <div class="col">
                        <div class="card h-100 border-0 shadow-sm text-center p-4"
                            style="border-radius: 16px; max-width: 500px; margin: 0 auto;">

                            <!-- Icon -->
                            <div class="mb-3">
                                <i class="bi bi-truck text-primary" style="font-size: 4rem;"></i>
                            </div>

                            <!-- Title -->
                            <h5 class="fw-bold text-dark mb-2">Orders & Fulfilment</h5>

                            <!-- Description -->
                            <p class="text-muted mb-4">
                                Manage customer orders, track fulfilment, and process returns.
                            </p>
                            </br>

                            <!-- ASP Button -->
                            <asp:Button ID="btnOrders" runat="server" Text="Open"
                                CssClass="btn btn-lg w-50"
                                Style="background: linear-gradient(90deg, #ff9966, #ff5e62); border: none; color: #fff; font-weight: 600; border-radius: 25px;" />

                        </div>
                    </div>

                    <div class="col">
                        <div class="card h-100 border-0 shadow-sm text-center p-4"
                            style="border-radius: 16px; max-width: 500px; margin: 0 auto;">

                            <!-- Icon -->
                            <div class="mb-3">
                                <i class="bi bi-people text-info" style="font-size: 4rem;"></i>
                            </div>

                            <!-- Title -->
                            <h5 class="fw-bold text-dark mb-2">User Profiles & Roles</h5>

                            <!-- Description -->
                            <p class="text-muted mb-4">
                                Manage user accounts, roles, dietary preferences, and loyalty balances.
                            </p>

                            <!-- ASP Button -->
                            <asp:Button ID="btnUsers" runat="server" Text="Open"
                                CssClass="btn btn-lg w-50"
                                Style="background: linear-gradient(90deg, #ff9966, #ff5e62); border: none; color: #fff; font-weight: 600; border-radius: 25px;"
                                OnClick="btnUser_Profile" />

                        </div>
                    </div>

                    <!-- Recipes & Meal Plans -->
                    <div class="col">
                        <div class="card h-100 border-0 shadow-sm text-center p-4"
                            style="border-radius: 16px; max-width: 500px; margin: 0 auto;">

                            <!-- Icon -->
                            <div class="mb-3">
                                <i class="bi bi-journal-text text-danger" style="font-size: 4rem;"></i>
                            </div>

                            <!-- Title -->
                            <h5 class="fw-bold text-dark mb-2">Recipes & Meal Plans</h5>

                            <!-- Description -->
                            <p class="text-muted mb-4">
                                Create quick recipes, organize weekly meal plans, and link ingredients.
                            </p>


                            <asp:Button ID="btnRecipes" runat="server" Text="Open"
                                CssClass="btn btn-lg w-50"
                                Style="background: linear-gradient(90deg, #ff9966, #ff5e62); border: none; color: #fff; font-weight: 600; border-radius: 25px;" />

                        </div>
                    </div>
                    <!-- Discounts & Loyalty -->
                    <div class="col">
                        <div class="card h-100 border-0 shadow-sm text-center p-4"
                            style="border-radius: 16px; max-width: 500px; margin: 0 auto;">

                            <div class="mb-3">
                                <i class="bi bi-gift text-secondary" style="font-size: 4rem;"></i>
                            </div>

                            <h5 class="fw-bold text-dark mb-2">Discounts & Loyalty</h5>

                            <p class="text-muted mb-4">
                                Configure discount codes, promotions, and customer loyalty rewards.
                            </p>
                            
                            <asp:Button ID="btnDiscounts" runat="server" Text="Open"
                                CssClass="btn btn-lg w-50"
                                Style="background: linear-gradient(90deg, #ff9966, #ff5e62); border: none; color: #fff; font-weight: 600; border-radius: 25px;" />

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


</asp:Content>
