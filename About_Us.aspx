<%@ Page Title="" Language="C#" MasterPageFile="~/Daily Deli Master Page.Master" AutoEventWireup="true"
    CodeBehind="About_Us.aspx.cs" Inherits="Daily_Deli_E_Commerce.AboutUs" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <title>About Us - Daily Deli</title>
        <style>
            body {
                margin: 0;
                padding: 0;
                font-family: "Poppins", "Inter", sans-serif !important;
                background: #fafafa;
                color: var(--brand-color);
                width: 100%;
                scroll-behavior: smooth;
            }

            /* Glassmorphism variables and helpers */
            :root {
                --glass-bg: rgba(255, 255, 255, 0.55);
                --glass-border: rgba(255, 255, 255, 0.6);
                --glass-shadow: 0 8px 32px rgba(31, 38, 135, 0.08);
                --brand-accent: #0077cc;
            }

            .glass-card {
                background: linear-gradient(180deg, rgba(255, 255, 255, 0.65), rgba(255, 255, 255, 0.32));
                border: 1px solid var(--glass-border);
                box-shadow: var(--glass-shadow);
                border-radius: 14px;
                padding: 1.25rem;
                backdrop-filter: blur(8px) saturate(120%);
                -webkit-backdrop-filter: blur(8px) saturate(120%);
                transition: transform .18s ease, box-shadow .18s ease;
            }

            .glass-card:hover {
                transform: translateY(-6px);
                box-shadow: 0 18px 46px rgba(31, 38, 135, 0.12);
            }

            .glass-hero-panel {
                background: linear-gradient(180deg, rgba(0, 0, 0, 0.48), rgba(0, 0, 0, 0.28));
                border-radius: 12px;
                padding: 2rem;
                display: inline-block;
                color: #fff;
                backdrop-filter: blur(6px) brightness(90%);
            }

            .hero-cta {
                display: inline-block;
                margin-top: 1rem;
                background: linear-gradient(90deg, var(--brand-accent), #005fa3);
                color: #fff;
                padding: .6rem 1rem;
                border-radius: 10px;
                text-decoration: none;
                font-weight: 600;
                box-shadow: 0 8px 20px rgba(0, 119, 204, 0.18);
            }

            /* About Us specific styles */
            .about-hero {
                background: linear-gradient(135deg, rgba(0, 0, 0, 0.7) 0%, rgba(0, 0, 0, 0.4) 100%), url('https://images.unsplash.com/photo-1698694454652-d1d24033f2e1?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDMzfHx8ZW58MHx8fHx8') center/cover no-repeat;
                padding: 120px 0 80px;
                text-align: center;
                color: white;
                position: relative;
            }


            .about-hero h2 {
                font-size: 3rem;
                margin-bottom: 1.5rem;
                font-weight: 800;
                text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
            }

            .about-hero p {
                font-size: 1.25rem;
                max-width: 800px;
                margin: 0 auto;
                line-height: 1.6;
                opacity: 0.9;
            }

            .team-section,
            .mission-section,
            .contact-section {
                padding: 80px 0;
            }

            .section-title {
                text-align: center;
                margin-bottom: 3rem;
                font-size: 2.5rem;
                font-weight: 800;
            }

            .gradient-text {
                background: linear-gradient(135deg, var(--color-primary) 0%, var(--color-secondary) 100%);
                -webkit-background-clip: content-box;
                -webkit-text-fill-color: #0077cc;
                background-clip: initial;
            }

            /* Force team members into one row */
            .team-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 2rem;
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 1rem;
            }

            .team-member {
                background: var(--color-background);
                border-radius: 16px;
                overflow: hidden;
                box-shadow: var(--shadow-lg);
                transition: all 0.3s ease;
                border: 1px solid var(--color-border);
            }

            .team-member:hover {
                transform: translateY(-8px);
                box-shadow: var(--shadow-xl);
            }

            .team-member img {
                width: 100%;
                height: 300px;
                object-fit: cover;
            }

            .member-info {
                padding: 1.5rem;
                text-align: center;
            }

            .member-info h4 {
                margin: 0 0 0.5rem;
                font-size: 1.25rem;
                font-weight: 700;
                color: var(--color-foreground);
            }

            .member-info p {
                color: var(--color-muted);
                margin: 0;
                font-size: 0.9rem;
            }

            .mission-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 1rem;
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 3rem;
                align-items: start;
            }

            .mission-text h3,
            .values-text h3 {
                font-size: 1.75rem;
                margin-bottom: 1.5rem;
                color: var(--color-foreground);
                font-weight: 700;
            }

            .mission-text p,
            .values-text p {
                line-height: 1.7;
                color: var(--color-muted);
                margin-bottom: 1.5rem;
                font-size: 1.1rem;
            }

            .values-list {
                list-style: none;
                padding: 0;
            }

            .values-list li {
                margin-bottom: 1rem;
                display: flex;
                align-items: flex-start;
                padding: 1rem;
                background: #f5f5f5;
                /* Light background for readability */
                border-radius: 8px;
                border-left: 4px solid var(--color-primary);
                color: #000;
                /* Ensure text is visible */
            }

            .values-list i {
                color: var(--color-primary);
                margin-right: 1rem;
                font-size: 1.2rem;
                margin-top: 0.2rem;
                flex-shrink: 0;
            }

            .values-list strong {
                color: #000;
                display: block;
                margin-bottom: 0.25rem;
            }

            /*.contact-grid {
            display: flex;
            grid-template-columns: 1fr;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
            justify-content: center;
            text-align: center;
        }*/

            .contact-info h3 {
                font-size: 1.5rem;
                margin-bottom: 1.5rem;
                color: var(--color-foreground);
                font-weight: 700;
            }

            .contact-details {
                margin-bottom: 2rem;
            }

            .contact-details p {
                margin-bottom: 1rem;
                display: flex;
                align-items: center;
                color: var(--color-muted);
            }

            .contact-details i {
                color: var(--color-primary);
                margin-right: 1rem;
                width: 20px;
                text-align: center;
            }

            .social-links {
                display: flex;
                gap: 1rem;
                margin-top: 2rem;
                justify-content: center;
            }

            .social-links a {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 50px;
                height: 50px;
                background: var(--color-primary);
                color: white;
                border-radius: 50%;
                text-decoration: none;
                transition: all 0.3s ease;
                font-size: 1.2rem;
            }

            .social-links a:hover {
                background: var(--color-primary-dark);
                transform: translateY(-3px);
            }

            @media (max-width: 768px) {
                .mission-container {
                    grid-template-columns: 1fr;
                }

                .team-grid {
                    grid-template-columns: 1fr;
                }

                .about-hero {
                    padding: 80px 0 60px;
                }

                .about-hero h2 {
                    font-size: 2.5rem;
                }

                .section-title {
                    font-size: 2rem;
                }

                /*.contact-section {
                background: linear-gradient(135deg, #f9f9f9, #ffffff);
                padding: 80px 0;
            }*/

                .contact-grid {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    text-align: center;
                    flex-direction: column;
                    /* stack neatly */
                    max-width: 700px;
                    margin: 0 auto;
                    background: #fff;
                    padding: 3rem 2rem;
                    border-radius: 16px;
                    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
                }

                /*.contact-info h3 {
                color: #333;
                margin-bottom: 1rem;
            }

            .contact-details p {
                justify-content: center;/ / center icons + text */
                /*font-size: 1rem;
            }*/


            }
        </style>


    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


        <!-- Hero Section -->
        <section class="about-hero">
            <div class="container">
                <div class="glass-hero-panel">
                    <h2>About Daily Deli</h2>
                    <p>Daily Deli is redefining the way communities access fresh groceries and ready-to-eat meals. Our
                        platform combines convenience, nutrition, and sustainability by delivering locally sourced
                        produce,
                        artisanal foods, and curated meal kits directly to your doorstep. We cater to every lifestyle,
                        offering options for vegan, vegetarian, halal, and other dietary preferences, while integrating
                        nutritional information and allergen alerts to make informed choices effortless.</p>
                    <a href="Shop.aspx" class="hero-cta">Browse Fresh Picks</a>
                </div>
            </div>
        </section>



        <!-- Mission & Values Section -->
        <section class="mission-section">
            <div class="container">
                <h2 class="section-title">Our Mission & <span class="gradient-text">Values</span></h2>
                <div class="mission-container">
                    <div class="mission-text glass-card">
                        <h3>Our Mission</h3>
                        <p>At Daily Deli, our mission is to make healthy, convenient, and sustainably sourced food
                            accessible to everyone. We aim to empower customers with tools like personalized dietary
                            filters, dynamic meal planning, and quick recipe suggestions, while supporting local farmers
                            and producers who share our commitment to quality and sustainability.</p>
                        <p>Since our inception, we have grown from a niche startup to a trusted platform serving
                            thousands of customers, providing not just groceries, but inspiration and guidance for
                            healthier, more convenient living.</p>
                    </div>

                    <div class="values-text glass-card">
                        <h3>Our Values</h3>
                        <ul class="values-list">
                            <li><i class="fas fa-check-circle"></i>
                                <div><strong>Quality First:</strong> Every product is carefully selected, with detailed
                                    nutritional info and allergen guidance, ensuring our customers receive the best for
                                    their health and taste.</div>
                            </li>
                            <li><i class="fas fa-check-circle"></i>
                                <div><strong>Community & Inclusion:</strong> We foster a community through diet-specific
                                    blogs, tips, and interactive meal planning, creating a space where every lifestyle
                                    and dietary choice is respected and supported.</div>
                            </li>
                            <li><i class="fas fa-check-circle"></i>
                                <div><strong>Sustainability:</strong> From local sourcing to eco-friendly packaging and
                                    delivery methods, we minimize environmental impact while promoting responsible
                                    consumption.</div>
                            </li>
                            <li><i class="fas fa-check-circle"></i>
                                <div><strong>Innovation:</strong> By linking products directly to recipes, suggesting
                                    weekly meal plans, and integrating loyalty rewards, we continuously enhance the
                                    shopping experience and drive meaningful engagement.</div>
                            </li>
                            <li><i class="fas fa-check-circle"></i>
                                <div><strong>Customer-Centric Convenience:</strong> Our platform simplifies grocery
                                    shopping with tailored recommendations, quick-add recipes, and meal planning to save
                                    time and enrich daily nutrition.</div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </section>

        <!-- Team Section -->
        <section class="team-section">
            <h2 class="section-title">Meet Our <span class="gradient-text">Team</span></h2>
            <div class="team-grid">
                <!-- Team Member 1 -->
                <div class="team-member hover-lift">
                    <img src="img/Kamo.jpeg" alt="Kamo Picture">
                    <div class="member-info">
                        <h4>Kamogelo Kedige</h4>
                        <p>Group Leader</p>
                    </div>
                </div>

                <!-- Team Member 2 -->
                <div class="team-member hover-lift">
                    <img src="img/Albert.jfif" alt="Albert Picture" />
                    <div class="member-info">
                        <h4>Albert Tembe</h4>
                        <p>Teammate</p>
                    </div>
                </div>

                <!-- Team Member 3 -->
                <div class="team-member hover-lift">
                    <img src="img/Frank.jfif" alt="Frank Picture" />
                    <div class="member-info">
                        <h4>Frank Ntakirutimana</h4>
                        <p>Teammate</p>
                    </div>
                </div>

                <!-- Team Member 4 -->
                <div class="team-member hover-lift">
                    <img src="img/Wonderful.jfif" alt="Wonder Picture" />
                    <div class="member-info">
                        <h4>Wonderful S. Ngwenya</h4>
                        <p>Teammate</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Contact Section -->
        <section class="contact-section" style="display: flex; align-items: center;">
            <div class="container">
                <h2 class="section-title">Get In <span class="gradient-text">Touch</span></h2>
                <div class="contact-grid glass-card">
                    <div class="contact-info">
                        <h3>Contact Information</h3>
                        <div class="contact-details">
                            <p><i class="fas fa-map-marker-alt"></i> 123 Market Street, Auckland Park, ST 12345</p>
                            <p><i class="fas fa-phone"></i> (+27) 67-131- 4480</p>
                            <p><i class="fas fa-envelope"></i> info@dailydeli.com</p>
                            <p><i class="fas fa-clock"></i> Monday-Friday: 9am-6pm</p>
                            <p><i class="fas fa-clock"></i> Saturday: 10am-4pm</p>

                        </div>

                    </div>
                </div>
            </div>
        </section>

    </asp:Content>