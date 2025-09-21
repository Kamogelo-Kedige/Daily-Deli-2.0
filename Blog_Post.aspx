<%@ Page Title="" Language="C#" MasterPageFile="~/Daily Deli Master Page.Master" AutoEventWireup="true"
    CodeBehind="Blog_Post.aspx.cs" Inherits="Daily_Deli_E_Commerce.Blog_Post" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link href="<%= ResolveUrl(" ~/css/StyleSheet.css") %>?v=1" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="css/StyleSheet.css" />
        <title>Blog Post</title>
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <section id="Introducion_Review">
            <div class="container-fluid p-0">
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
                        <asp:Button ID="ButtonAdd" runat="server" ClientIDMode="Static"
                            CssClass="btn btn-outline-light btn-lg px-4" Text="WRITE A REVIEW" UseSubmitBehavior="false"
                            type="button" />
                    </div>

                </div>
            </div>
        </section>



        <section id="Review_User">
            <br>
            <br>
            <div class="container-fluid p-0">
                <div class="row g-0">

                    <div class="col-md-4 d-flex justify-content-center border-end">
                        <div class="d-flex flex-column w-100 p-2" style="height: 80vh;">
                            <h1 class="fw-bold mb-3 display-6 text-center">POST SOMETHING</h1>
                            <div id="chatArea"
                                class="flex-grow-1 overflow-auto rounded-3 p-2 card-washed-navy border border-1">
                            </div>

                            <div class="d-flex align-items-center mt-2">

                                <asp:TextBox ID="txtComment" runat="server" CssClass="form-control form-control-lg me-2"
                                    placeholder="Type a comment..." MaxLength="300"></asp:TextBox>

                                <asp:Button ID="btnSend" runat="server" CssClass="btn btn-primary btn-lg" Text="Send" />
                            </div>
                        </div>
                    </div>


                    <div class="col-md-8 d-flex justify-content-center ">
                        <div class="row g-2  justify-content-center ">
                            <div class="col-md-9 justify-content-center ">
                                <div class="card card-washed-navy rounded-5 overflow-hidden shadow-sm p-3 mb-4">
                                    <div class="card-body ">
                                        <div class="d-flex align-items-start gap-3 mb-2">
                                            <div class="avatar-soft">HM</div>
                                            <div class="flex-grow-1">
                                                <div class="fw-semibold text-navy">Hlengi M</div>
                                                <small class="text-body-secondary">1 review · Active since Aug
                                                    2025</small>
                                            </div>
                                            <div class="ms-auto text-end">
                                                <div class="small">
                                                    <span class="ms-2 text-body-secondary">13 Aug 2025 · 19:45</span>
                                                </div>
                                            </div>
                                        </div>
                                        <h6 class="mb-2">Deli food</h6>
                                        <p class="mb-3 small">
                                            Today on the 13th of August 2025, I went to Checkers at Ballito Junction
                                            Mall to buy fish (Hake) for my 11 month year old, only to find that the fish
                                            was rotten...
                                        </p>
                                        <hr class="my-2 hr-soft">
                                        <div class="d-flex align-items-center justify-content-between pt-1">
                                            <a href="#"
                                                class="d-inline-flex align-items-center gap-2 link-offset-1 text-navy">
                                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                                                    <path d="M4 20l2-8 8-2 6-6-4 10-12 6z" stroke="currentColor"
                                                        stroke-width="1.5" stroke-linecap="round" />
                                                </svg>
                                                <span>Report</span>
                                            </a>
                                            <button type="button" class="btn btn-sm btn-navy-soft px-3">See
                                                more</button>
                                        </div>
                                    </div>
                                </div>

                                <div class="card card-washed-navy rounded-5 overflow-hidden shadow-sm p-3 mb-4">
                                    <div class="card-body">
                                        <div class="d-flex align-items-start gap-3 mb-2">
                                            <div class="avatar-soft">NH</div>
                                            <div class="flex-grow-1">
                                                <div class="fw-semibold text-navy">Nonkululeko H</div>
                                                <small class="text-body-secondary">2 reviews · Active since Aug
                                                    2023</small>
                                            </div>
                                            <div class="ms-auto text-end">
                                                <div class="small">
                                                    <span class="ms-2 text-body-secondary">13 Aug 2025 · 16:15</span>
                                                </div>
                                            </div>
                                        </div>
                                        <h6 class="mb-2">Poor customer service.</h6>
                                        <p class="mb-3 small">…short excerpt of the review text goes here…</p>
                                        <hr class="my-2 hr-soft">
                                        <div class="d-flex align-items-center justify-content-between pt-1">
                                            <a href="#"
                                                class="d-inline-flex align-items-center gap-2 link-offset-1 text-navy">
                                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                                                    <path d="M4 20l2-8 8-2 6-6-4 10-12 6z" stroke="currentColor"
                                                        stroke-width="1.5" stroke-linecap="round" />
                                                </svg>
                                                <span>Report</span>
                                            </a>
                                            <button type="button" class="btn btn-sm btn-navy-soft px-3">See
                                                more</button>
                                        </div>
                                    </div>
                                </div>

                                <div class="card card-washed-navy rounded-5 overflow-hidden shadow-sm p-3 mb-4">
                                    <div class="card-body">
                                        <div class="d-flex align-items-start gap-3 mb-2">
                                            <div class="avatar-soft">AB</div>
                                            <div class="flex-grow-1">
                                                <div class="fw-semibold text-navy">Alex B</div>
                                                <small class="text-body-secondary">3 reviews · Active since May
                                                    2024</small>
                                            </div>
                                            <div class="ms-auto text-end">
                                                <div class="small">
                                                    <span class="ms-2 text-body-secondary">12 Aug 2025 · 10:05</span>
                                                </div>
                                            </div>
                                        </div>
                                        <h6 class="mb-2">Checkout experience</h6>
                                        <p class="mb-3 small">…short excerpt…</p>
                                        <hr class="my-2 hr-soft">
                                        <div class="d-flex align-items-center justify-content-between pt-1">
                                            <a href="#"
                                                class="d-inline-flex align-items-center gap-2 link-offset-1 text-navy">
                                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                                                    <path d="M4 20l2-8 8-2 6-6-4 10-12 6z" stroke="currentColor"
                                                        stroke-width="1.5" stroke-linecap="round" />
                                                </svg>
                                                <span>Report</span>
                                            </a>
                                            <button type="button" class="btn btn-sm btn-navy-soft px-3">See
                                                more</button>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                </div>
            </div>
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
                var minVH = 40;
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