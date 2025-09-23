<%@ Page Title="" Language="C#" MasterPageFile="~/Daily Deli Master Page.Master" AutoEventWireup="true"
    CodeBehind="Blog_Post.aspx.cs" Inherits="Daily_Deli_E_Commerce.Blog_Post" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link href="<%= ResolveUrl(" ~/css/StyleSheet.css") %>?v=1" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="css/StyleSheet.css" />
        <title>Blog Post - Daily Deli</title>


         <style>
        :root {
            --mint: #0077cc;
            --mint-dark: #cfeee4;
            --card: #fff;
            --text: #0f172a;
            --muted: #64748b;
            --line: #e6eef2;
            --accent: #21a179
        }

        body {
            background: #fafafa;
            color: var(--text)
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
            box-shadow: 0 10px 25px rgba(2,6,23,.06);
            position: relative;
            z-index: 1
        }

        .c-card {
            background: var(--card);
            border: 1px solid var(--line);
            border-radius: 18px;
            padding: 22px;
            box-shadow: 0 10px 25px rgba(2,6,23,.06)
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
            background: #0077cc;
            border: 1px solid #d6ebe3;
            border-radius: 12px;
            font-weight: 700;
            color:white;
        }

            .btn-ghost:hover {
                background:#0077cc;
                 color:white;
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
            background: rgba(255,255,255,.55);
            backdrop-filter: blur(3px);
            border: 1px solid rgba(255,255,255,.6)
        }

            .leafbar::before {
                pointer-events: none; /* <-- let clicks pass through */
                z-index: 0;
                content: "";
                position: absolute;
                inset: -40px -20px;
                background: radial-gradient(140px 70px at 10% 20%, rgba(33,161,121,.08), transparent 60%), radial-gradient(160px 80px at 80% 0%, rgba(33,161,121,.08), transparent 60%), radial-gradient(180px 90px at 60% 90%, rgba(33,161,121,.08), transparent 60%)
            }

        .liked {
            filter: saturate(1.4)
        }
    </style>

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
        <div class="wrap">
            <div class="leafbar mb-4">
                <div class="comment-input d-flex align-items-center gap-3">
                    <asp:TextBox
                        ID="TextBox1"
                        runat="server"
                        CssClass="form-control border-0"
                        TextMode="SingleLine"
                        placeholder="Leave a constructive comment..."></asp:TextBox>

                    <asp:Button ID="BtnPost" runat="server" Text="Post" CssClass="btn btn-success px-4" />
                </div>
            </div>

            <small class="text-muted d-block mb-2">Hold Ctrl (Cmd on Mac) to select multiple</small>
<asp:ListBox ID="lstProducts" runat="server" CssClass="form-select listbox" SelectionMode="Multiple">
    <%-- sample items — replace with databound items later --%>
    <asp:ListItem>Red Apples</asp:ListItem>
    <asp:ListItem>Tofu</asp:ListItem>
    <asp:ListItem>Meaty Burger</asp:ListItem>
    <asp:ListItem>Spinach</asp:ListItem>
    <asp:ListItem>Salted Butter</asp:ListItem>
    <asp:ListItem>Bell Peppers</asp:ListItem>
    <asp:ListItem>Greek Yoghurt</asp:ListItem>
    <asp:ListItem>White Bread</asp:ListItem>
    <asp:ListItem>Still Water</asp:ListItem>
    <asp:ListItem>Dates</asp:ListItem>
</asp:ListBox>


                <!-- CATEGORIES -->
                <div class="col-12 col-lg-6">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title mb-2">Categories</h5>
                            <small class="text-muted d-block mb-2">Hold Ctrl (Cmd on Mac) to select multiple</small>
                            <asp:ListBox ID="lstCategories" runat="server" CssClass="form-select listbox" SelectionMode="Multiple">
                                <asp:ListItem>Vegetables</asp:ListItem>
                                <asp:ListItem>Fruits</asp:ListItem>
                                <asp:ListItem>Bakery</asp:ListItem>
                                <asp:ListItem>Dairy</asp:ListItem>
                                <asp:ListItem>Snacks</asp:ListItem>
                                <asp:ListItem>Beverages</asp:ListItem>
                                <asp:ListItem>Quick</asp:ListItem>
                            </asp:ListBox>
                        </div>
                    </div>
                </div>
            </div>

            <!-- OUTPUT + ACTIONS -->
            <div class="card shadow-sm mt-4">
                <div class="card-body">
                    <h5 class="card-title mb-3">Your Selection</h5>
                    <asp:TextBox ID="txtSelection" runat="server" CssClass="form-control mb-3" TextMode="MultiLine" Rows="3"
                        placeholder="Selected products & categories will appear here..."></asp:TextBox>
                    <div class="d-flex gap-2">
                        <!-- client-side only; prevents postback -->
                        <asp:Button ID="btnCopy" runat="server" Text="Copy selection to textbox"
                            CssClass="btn btn-success"
                            UseSubmitBehavior="false"
                            OnClientClick="return copySelection();" />
                        <asp:Button ID="btnClear" runat="server" Text="Clear"
                            CssClass="btn btn-outline-secondary"
                            UseSubmitBehavior="false"
                            OnClientClick="document.getElementById('<%= txtSelection.ClientID %>').value='';return false;" />
                    </div>
                    <div id="chips" class="mt-3"></div>
                </div>
            </div>

            <script>
                function getSelectedTexts(selectEl) {
                    const out = [];
                    for (let i = 0; i < selectEl.options.length; i++) {
                        if (selectEl.options[i].selected) out.push(selectEl.options[i].text);
                    }
                    return out;
                }

                function copySelection() {
                    const products = getSelectedTexts(document.getElementById('<%= lstProducts.ClientID %>'));
                    const cats = getSelectedTexts(document.getElementById('<%= lstCategories.ClientID %>'));

                    const text = 'Products: ' + (products.join(', ') || '—') +
                        '  |  Categories: ' + (cats.join(', ') || '—');

                    document.getElementById('<%= txtSelection.ClientID %>').value = text;

                    // optional: show little pills under the textbox
                    const chips = document.getElementById('chips');
                    chips.innerHTML = '';
                    products.forEach(p => chips.insertAdjacentHTML('beforeend', `<span class="pill">${p}</span>`));
                    cats.forEach(c => chips.insertAdjacentHTML('beforeend', `<span class="pill">${c}</span>`));

                    return false; // stop postback
                }
            </script>



            <div class="c-card mb-4">
                <div class="d-flex align-items-start gap-3">
                    <asp:Image ID="Img1" runat="server" CssClass="avatar" ImageUrl="https://i.pravatar.cc/96?img=47" />
                    <div class="flex-grow-1">
                        <div class="d-flex align-items-center justify-content-between flex-wrap gap-2">
                            <div>
                                <div class="name">@naseema</div>
                                <div class="time">5 days ago</div>
                            </div>
                            <div class="d-flex align-items-center gap-2">
                                <div class="like-pill">
                                    <asp:Button ID="LikeBtn1" runat="server" Text="" CssClass="btn p-0 border-0" OnClientClick="return like(this,'likeCount1');" />
                                    <svg class="heart" viewBox="0 0 24 24" fill="none">
                                        <path id="h1" d="M12.1 20.3C7.14 16.24 4 13.39 4 9.9 4 7.2 6.2 5 8.9 5c1.54 0 3.04.72 4 1.87C13.86 5.72 15.36 5 16.9 5 19.6 5 21.8 7.2 21.8 9.9c0 3.49-3.14 6.34-8.1 10.4l-.8.63-.8-.63z" stroke="#21a179" stroke-width="1.5" />
                                    </svg>
                                    <span id="likeCount1" class="fw-semibold">35</span>
                                </div>
                            </div>
                        </div>
                        <p class="mt-3 mb-0">
                            Awesome job with this entry! I felt like I was on the edge of my seat the whole time. The way that you introduced new characters made a lot of sense, except for maybe Theodore? He felt like he came out of nowhere haha. But besides that, excellent work.
                        </p>
                        <div class="mt-3 d-flex gap-2">
                            <asp:Button ID="ReplyToggle1" runat="server" Text="Reply" CssClass="btn btn-ghost px-3" OnClientClick="toggleReply('reply1'); return false;" />
                            <asp:Button ID="Share1" runat="server" Text="Share" CssClass="btn btn-ghost px-3" OnClientClick="alert('Hook to your share flow'); return false;" />
                        </div>
                        <div id="reply1" class="mt-3 d-none">
                            <textarea class="form-control reply-box p-3" rows="3" placeholder="Write a reply..."></textarea>
                            <div class="mt-2 d-flex gap-2">
                                <asp:Button ID="SendReply1" runat="server" Text="Send" CssClass="btn btn-success px-4" OnClientClick="alert('Send reply to backend'); return false;" />
                                <asp:Button ID="CancelReply1" runat="server" Text="Cancel" CssClass="btn btn-outline-secondary px-3" OnClientClick="toggleReply('reply1'); return false;" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="c-card mb-4">
                <div class="d-flex align-items-start gap-3">
                    <asp:Image ID="Img2" runat="server" CssClass="avatar" ImageUrl="https://i.pravatar.cc/96?img=12" />
                    <div class="flex-grow-1">
                        <div class="d-flex align-items-center justify-content-between flex-wrap gap-2">
                            <div>
                                <div class="name">@mike</div>
                                <div class="time">4 hours ago</div>
                            </div>
                            <div class="d-flex align-items-center gap-2">
                                <div class="like-pill">
                                    <asp:Button ID="LikeBtn2" runat="server" Text="" CssClass="btn p-0 border-0" OnClientClick="return like(this,'likeCount2');" />
                                    <svg class="heart" viewBox="0 0 24 24" fill="none">
                                        <path d="M12.1 20.3C7.14 16.24 4 13.39 4 9.9 4 7.2 6.2 5 8.9 5c1.54 0 3.04.72 4 1.87C13.86 5.72 15.36 5 16.9 5 19.6 5 21.8 7.2 21.8 9.9c0 3.49-3.14 6.34-8.1 10.4l-.8.63-.8-.63z" stroke="#21a179" stroke-width="1.5" />
                                    </svg>
                                    <span id="likeCount2" class="fw-semibold">34</span>
                                </div>
                            </div>
                        </div>
                        <p class="mt-3 mb-0">
                            Wow, you nailed this one. The way that you described the forest at dusk really made me feel like I was there, I could almost feel the fog! Definitely didn’t expect so much to happen this chapter. Excited to see where our characters go from here.
                        </p>
                        <div class="mt-3 d-flex gap-2">
                            <asp:Button ID="ReplyToggle2" runat="server" Text="Reply" CssClass="btn btn-ghost px-3" OnClientClick="toggleReply('reply2'); return false;" />
                            <asp:Button ID="Share2" runat="server" Text="Share" CssClass="btn btn-ghost px-3" OnClientClick="alert('Hook to your share flow'); return false;" />
                        </div>
                        <div id="reply2" class="mt-3 d-none">
                            <textarea class="form-control reply-box p-3" rows="3" placeholder="Write a reply..."></textarea>
                            <div class="mt-2 d-flex gap-2">
                                <asp:Button ID="SendReply2" runat="server" Text="Send" CssClass="btn btn-success px-4" OnClientClick="alert('Send reply to backend'); return false;" />
                                <asp:Button ID="CancelReply2" runat="server" Text="Cancel" CssClass="btn btn-outline-secondary px-3" OnClientClick="toggleReply('reply2'); return false;" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

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