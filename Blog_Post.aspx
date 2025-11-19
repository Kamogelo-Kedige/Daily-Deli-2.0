<%@ Page Title="" Language="C#" MasterPageFile="~/Daily Deli Master Page.Master" AutoEventWireup="true"
    CodeBehind="Blog_Post.aspx.cs" Inherits="Daily_Deli_E_Commerce.Blog_Post" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link href="<%= ResolveUrl(" ~/css/StyleSheet.css") %>?v=1" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="css/StyleSheet.css" />
        <title>Blog Post</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <style>
            :root {
                --mint: #e9f7f1;
                --mint-dark: #cfeee4;
                --card: #fff;
                --text: #0077CC;
                --muted: #64748b;
                --line: #e6eef2;
                --accent: #21a179 --header-bg: #f5f5f5;
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
                background: #fff !important;
                color: var(--text)
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

            .wrap {
                max-width: 1080px;
                margin: 24px auto;
                padding: 0 20px
            }

            .comment-input {
                background: var(--card);
                border: 1px solid var(--line);
                border-radius: 18px;
                padding: 18px 22px;
                box-shadow: 0 10px 25px rgba(2, 6, 23, .06);
                position: relative;
                z-index: 1
            }

            .c-card {
                background: var(--card);
                border: 1px solid var(--line);
                border-radius: 18px;
                padding: 22px;
                box-shadow: 0 10px 25px rgba(2, 6, 23, .06)
            }

            .avatar {
                width: 48px;
                height: 48px;
                border-radius: 50%;
                object-fit: cover
            }

            .name {
                font-weight: 800
            }

            .time {
                font-size: .9rem;
                color: var(--muted)
            }

            /* outline by default */
            .like-pill .heart path {
                fill: none;
                stroke: currentColor;
                stroke-width: 1.5;
            }

            /* filled after like */
            .like-pill.liked .heart path {
                fill: currentColor;
                stroke: currentColor;
            }

            .like-pill {
                display: flex;
                align-items: center;
                gap: 8px;
                border: 1px solid #d6ebe3;
                background: #f6fffb;
                border-radius: 999px;
                padding: 8px 14px
            }

            .heart {
                width: 22px;
                height: 22px
            }

            .btn-ghost {
                background: #0077CC;
                border: 1px solid #d6ebe3;
                border-radius: 12px;
                font-weight: 700
            }

            .btn-ghost:hover {
                background: #0077CC
            }

            .reply-box {
                border: 1px solid var(--line);
                border-radius: 12px
            }

            .leafbar {
                position: relative;
                overflow: hidden;
                border-radius: 22px;
                padding: 24px;
                background: rgba(255, 255, 255, .55);
                backdrop-filter: blur(3px);
                border: 1px solid rgba(255, 255, 255, .6)
            }

            .leafbar::before {
                pointer-events: none;
                /* <-- let clicks pass through */
                z-index: 0;
                content: "";
                position: absolute;
                inset: -40px -20px;
                background: radial-gradient(140px 70px at 10% 20%, rgba(33, 161, 121, .08), transparent 60%), radial-gradient(160px 80px at 80% 0%, rgba(33, 161, 121, .08), transparent 60%), radial-gradient(180px 90px at 60% 90%, rgba(33, 161, 121, .08), transparent 60%)
            }

            .liked {
                filter: saturate(1.4)
            }
        </style>

        <style>
            .like-pill .heart {
                fill: none;
                stroke: currentColor;
                transition: fill .15s, stroke .15s;
            }

            .like-pill.liked .heart {
                fill: #dc3545;
                stroke: #dc3545;
            }

            /* Bootstrap danger red */

            .card {
                border: 0;
                border-radius: 16px;
                box-shadow: 0 10px 28px rgba(2, 6, 23, .08)
            }

            .form-select.product-dd {
                border-radius: 12px;
                height: auto;
                padding: .65rem .9rem
            }
        </style>
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <section id="Introducion_Review">
            <div class="container-fluid p-0 ">
                <div id="heroFrame" class="position-relative overflow-hidden" style="height: var(--heroH, 90vh);">

                    <div id="bgCarousel"
                        class="carousel slide carousel-fade position-absolute top-0 start-0 w-100 h-100"
                        data-bs-ride="carousel" data-bs-interval="3000" data-bs-pause="false" data-bs-touch="false"
                        style="z-index: 1;">

                        <div class="carousel-inner w-100 h-100">
                            <div class="carousel-item active w-100 h-100">
                                <img src="img/Frank_Blog_Img6.jpg" class="d-block w-100 h-100"
                                    style="object-fit: cover; filter: blur(6px) brightness(0.6);" alt="Background 6" />
                            </div>
                            <div class="carousel-item w-100 h-100">
                                <img src="img/Frank_Blog_Img5.jpg" class="d-block w-100 h-100"
                                    style="object-fit: cover; filter: blur(6px) brightness(0.6);" alt="Background 5" />
                            </div>
                            <div class="carousel-item w-100 h-100">
                                <img src="img/Frank_Blog_Img3.jpeg" class="d-block w-100 h-100"
                                    style="object-fit: cover; filter: blur(6px) brightness(0.6);" alt="Background 3" />
                            </div>
                            <div class="carousel-item w-100 h-100">
                                <img src="img/Frank_Blog_Img2.jpg" class="d-block w-100 h-100"
                                    style="object-fit: cover; filter: blur(6px) brightness(0.6);" alt="Background 2" />
                            </div>
                        </div>
                    </div>

                    <div class="position-absolute top-0 start-0 w-100 h-100 d-flex flex-column align-items-center justify-content-center text-white text-center"
                        style="z-index: 2;">
                        <h1 class="fw-bold mb-3 display-6">CUSTOMER REVIEWS</h1>
                        <p class="fs-5 mb-4"><b>100% would recommend this product to a friend?</b></p>
                        <asp:LinkButton ID="ButtonAdd" runat="server" ClientIDMode="Static"
                            CssClass="btn btn-outline-light btn-lg px-4" Text="WRITE A REVIEW"
                            PostBackUrl="#Review_User" />

                    </div>

                </div>
            </div>
        </section>


        <section id="Review_User">
            <br>
            <br>
            <div class="wrap">
                <h2><b>Add a Comment/Review </b></h2>

                <div class="leafbar mb-4">
                    <div class="comment-input d-flex align-items-center gap-3">
                        <asp:TextBox ID="txtComment" runat="server" CssClass="form-control border-0"
                            TextMode="SingleLine" placeholder="Leave a constructive comment..."></asp:TextBox>

                        <asp:Button ID="BtnPost" runat="server" Text="Post" CssClass="btn btn-success px-4"
                            OnClick="BtnPost_Click" />
                    </div>
                </div>

                <div class="wrap">
                    <div class="card p-4">
                        <label for="ddlProducts" class="form-label fw-bold">Select a product</label>

                        <!-- DROPDOWN (manual items) -->
                        <asp:DropDownList ID="ddlProducts" runat="server" CssClass="form-select product-dd">
                            <asp:ListItem Text="-- Choose a product --" Value="0" />
                            <asp:ListItem Text="Tofu" Value="2" />
                            <asp:ListItem Text="Meaty Burger" Value="3" />
                            <asp:ListItem Text="Greens Sandwich" Value="4" />
                            <asp:ListItem Text="Spinach" Value="5" />
                            <asp:ListItem Text="Salted Butter" Value="6" />
                            <asp:ListItem Text="Bell Peppers" Value="7" />
                            <asp:ListItem Text="Pita Bread" Value="8" />
                            <asp:ListItem Text="Hummus" Value="9" />
                            <asp:ListItem Text="Carrots" Value="10" />
                            <asp:ListItem Text="Cucumber" Value="11" />
                            <asp:ListItem Text="Halloumi Cheese" Value="12" />
                            <asp:ListItem Text="Lemons" Value="13" />
                            <asp:ListItem Text="Bananas" Value="15" />
                            <asp:ListItem Text="Avocados" Value="16" />
                            <asp:ListItem Text="Still Water" Value="17" />
                            <asp:ListItem Text="Greek Salad" Value="18" />
                            <asp:ListItem Text="Vegetable Curry" Value="19" />
                            <asp:ListItem Text="Fruit Salad" Value="20" />
                            <asp:ListItem Text="Cheese&amp;ham Panini" Value="21" />
                            <asp:ListItem Text="Almonds" Value="22" />
                            <asp:ListItem Text="Greek Yoghurt" Value="23" />
                            <asp:ListItem Text="Beef Biltong" Value="24" />
                            <asp:ListItem Text="Cheddar Cheese" Value="25" />
                            <asp:ListItem Text="White Bread" Value="26" />
                            <asp:ListItem Text="Whole Wheat Bread" Value="27" />
                            <asp:ListItem Text="Bacon Sandwich" Value="28" />
                            <asp:ListItem Text="Zesty Halal Chicken" Value="29" />
                            <asp:ListItem Text="Halal Lamb &amp; Mint Pie" Value="30" />
                            <asp:ListItem Text="Dates" Value="31" />
                        </asp:DropDownList>

                        <div class="text-muted mt-2 small">
                            Select a food product to comment on...
                        </div>
                    </div>
                </div>
                <br>
                <br>

                <h2><b>Customer Comments</b> </h2>
                <asp:PlaceHolder ID="phProducts" runat="server"></asp:PlaceHolder>



            </div>



            <script>
                function like(btn, countId) {
                    var n = document.getElementById(countId);
                    n.textContent = (parseInt(n.textContent, 10) || 0) + 1;
                    btn.classList.add('liked');
                    btn.setAttribute('aria-pressed', 'true');
                    return false;
                }
                function toggleReply(id) {
                    var el = document.getElementById(id);
                    el.classList.toggle('d-none');
                    return false;
                }
            </script>
        </section>



        <!-- JAVA SCRIPT  -->



        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var el = document.getElementById('bgCarousel');
                if (el && window.bootstrap && bootstrap.Carousel) {
                    new bootstrap.Carousel(el, { interval: 3000, ride: 'carousel', pause: false, touch: false });
                }
            });

            const sendBtn = document.getElementById('sendBtn');
            const chatInput = document.getElementById('chatInput');
            const chatArea = document.getElementById('chatArea');


            //this code allows for the hieght reduction

            (function () {
                var hero = document.getElementById('heroFrame');
                var maxVH = 90;
                var min

                VH = 40;
                var rangePx = 800;
                var ticking = false;
                function clamp(v, a, b) { return Math.max(a, Math.min(b, v)); }
                function update() {
                    var y = window.scrollY || window.pageYOffset || 0;
                    var t = clamp(y / rangePx, 0, 1);
                    var h = maxVH - (maxVH - minVH) * t;
                    hero.style.setProperty('--heroH', h + 'vh');
                    ticking = false;
                }
                function onScroll() {
                    if (ticking) return;
                    ticking = true;
                    requestAnimationFrame(update);
                }
                window.addEventListener('scroll', onScroll, { passive: true });
                update();
            })();
        </script>

    </asp:Content>