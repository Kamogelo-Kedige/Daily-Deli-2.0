<%@ Page Title="" Language="C#" MasterPageFile="~/Daily Deli Master Page.Master" AutoEventWireup="true"
    CodeBehind="Home.aspx.cs" Inherits="Daily_Deli_E_Commerce.Home" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

        <title>Home - DailyDeli </title>

        <script src="https://kit.fontawesome.com/1626dc2da5.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="css/StyleSheet.css" />


    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


        <!-- Hero Section -->
        <section class="hero">
            <div class="hero-bg">
                <img src="https://images.unsplash.com/photo-1596776572010-93e181f9fc07?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                    alt="Premium kitchen with fresh diverse foods">
            </div>
            <div class="hero-overlay"></div>

            <div class="hero-content">
                <h1 class="hero-title">
                    Fresh. Diverse.
                    <span class="gradient-accent-text">Daily.</span>
                </h1>

                <p class="hero-subtitle">
                    Premium meals for every lifestyle. Whether you're Halal, Vegan, or a foodie -
                    unlock exclusive recipes, meal plans, and join our vibrant community.
                </p>

                <div class="hero-buttons">
                    <a href="Login.aspx" class="btn btn-accent btn-lg">Start Your Journey</a>
                    <a href="#menu" class="btn btn-glass btn-lg">Get a Glimpse</a>
                </div>

                <div class="hero-features">
                    <div class="hero-feature">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4Z" />
                            <line x1="3" x2="21" y1="6" y2="6" />
                            <path d="M16 10a4 4 0 0 1-8 0" />
                        </svg>
                        <span>Diet-Specific</span>
                    </div>
                    <div class="hero-feature">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2" />
                            <circle cx="9" cy="7" r="4" />
                            <path d="M22 21v-2a4 4 0 0 0-3-3.87" />
                            <path d="M16 3.13a4 4 0 0 1 0 7.75" />
                        </svg>
                        <span>Community Driven</span>
                    </div>
                    <div class="hero-feature">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="12" cy="12" r="10" />
                            <polyline points="12,6 12,12 16,14" />
                        </svg>
                        <span>Fresh Daily</span>
                    </div>
                </div>
            </div>

            <div class="scroll-indicator"></div>
        </section>

        <!-- Diet Categories Section -->
        <section class="section diet-categories" id="menu">
            <div class="container">
                <h2 class="section-title">
                    Choose Your
                    <span class="gradient-text">Culinary Journey</span>
                </h2>
                <p class="section-subtitle">
                    Every diet has a story. Join our community to unlock personalized meal plans,
                    exclusive recipes, and connect with like-minded food enthusiasts.
                </p>

                <div class="grid grid-cols-3 fade-in">
                    <!-- Vegan Category -->
                    <div class="category-card hover-lift">
                        <div class="category-image">
                            <img src="https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8dmVnZXRhcmlhbnxlbnwwfHwwfHx8MA%3D%3D"
                                alt="Plant-Based Paradise - Vegan meals">
                            <div class="category-overlay vegan"></div>
                            <svg class="category-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                stroke-width="2">
                                <path
                                    d="M11.5 2.5c0 .5.5.5.5 0a8 8 0 1 1-8 8c0-.5 0-1 .5-.5s1.5.5 2-.5-1-1.5-.5-2 .5-.5 0-.5a8 8 0 0 1 5.5-4.5Z" />
                            </svg>
                        </div>
                        <div class="category-content">
                            <h3 class="category-title">Plant-Based Paradise</h3>
                            <p class="category-subtitle">Vegan & Vegetarian</p>
                            <p class="category-description">
                                Discover vibrant plant-based meals and raw ingredients that don't compromise on taste.
                                From protein-rich
                                bowls to decadent desserts.
                            </p>
                            <div class="category-features">
                                <div class="category-feature">Premium Ingredients</div>
                                <div class="category-feature">100% Plant-Based</div>
                                <div class="category-feature">High Protein Options</div>

                            </div>

                        </div>
                    </div>

                    <!-- Halal Category -->
                    <div class="category-card hover-lift">
                        <div class="category-image">
                            <img src="https://plus.unsplash.com/premium_photo-1663853052156-fc5d54e694c8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8aGFsYWwlMjBmb29kfGVufDB8fDB8fHww"
                                alt="Halal Excellence - Certified halal cuisine">
                            <div class="category-overlay halal"></div>
                            <svg class="category-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                stroke-width="2">
                                <polygon
                                    points="12,2 15.09,8.26 22,9.27 17,14.14 18.18,21.02 12,17.77 5.82,21.02 7,14.14 2,9.27 8.91,8.26" />
                            </svg>
                        </div>
                        <div class="category-content">
                            <h3 class="category-title">Halal Excellence</h3>
                            <p class="category-subtitle">Certified & Pure</p>
                            <p class="category-description">
                                Authentic halal cuisine from around the world with fresh ingredients. Traditional
                                flavors
                                meet modern
                                presentation.
                            </p>
                            <div class="category-features">
                                <div class="category-feature">Premium Ingridients</div>
                                <div class="category-feature">Certified Halal</div>
                                <div class="category-feature">Global Cuisines</div>

                            </div>
                        </div>
                    </div>

                    <!-- Gourmet Category -->
                    <div class="category-card hover-lift">
                        <div class="category-image">
                            <img src="https://images.unsplash.com/photo-1666819604716-7b60a604bb76?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fGRlbGklMjBmb29kfGVufDB8fDB8fHww"
                                alt="Gourmet Selection - Premium dishes for food lovers">
                            <div class="category-overlay gourmet"></div>
                            <svg class="category-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                stroke-width="2">
                                <circle cx="12" cy="12" r="10" />
                                <line x1="2" y1="12" x2="22" y2="12" />
                                <path
                                    d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z" />
                            </svg>
                        </div>
                        <div class="category-content">
                            <h3 class="category-title">Gourmet Selection</h3>
                            <p class="category-subtitle">For Food Lovers</p>
                            <p class="category-description">
                                Premium dishes that celebrate diverse culinary traditions. Something special for
                                every palate.
                            </p>
                            <div class="category-features">
                                <div class="category-feature">Premium Ingredients</div>
                                <div class="category-feature">Local Flavors</div>
                                <div class="category-feature">Chef Specials</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="text-center" style="margin-top: 3rem;">
                    <p class="text-muted" style="margin-bottom: 1rem;">
                        Ready to create your diet-specific perfect meal?
                    </p>
                    <a href="Register.aspx" class="btn btn-hero btn-lg">Register Now</a>
                </div>
            </div>
        </section>

        <!-- Featured Dishes Section -->
        <section class="section featured-dishes" id="recipes">
            <div class="container">
                <h2 class="section-title">
                    Today's
                    <span class="gradient-accent-text">Featured Products</span>
                </h2>
                <p class="section-subtitle">
                    Get a taste of what awaits you. Offering fresh and locally sourced ingredients, and goodies. Members
                    get a chance to view products based on a diet they chose!
                </p>

                <div class="grid grid-cols-4 fade-in">
                    <!-- Lettuce -->
                    <div class="dish-card hover-lift">
                        <div class="dish-image">
                            <img src="https://images.unsplash.com/photo-1640958904159-51ae08bd3412?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8bGV0dHVjZXxlbnwwfHwwfHx8MA%3D%3D"
                                alt="Fresh Lettuce">
                            <div class="dish-category">Vegetables</div>
                        </div>
                        <div class="dish-content">
                            <h3 class="dish-title">Fresh Lettuce</h3>
                            <p class="dish-description">
                                Crisp and vibrant lettuce, perfect for salads, wraps, and garnishes. Locally sourced
                                for maximum freshness.
                            <div class="dish-meta">
                                <div class="dish-meta-item">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">

                                    </svg>

                                </div>
                                <div class="dish-meta-item">


                                </div>
                            </div>
                            <a href="Login.aspx" class="btn btn-outline btn-sm" style="width: 100%;">Shop Now</a>
                        </div>
                    </div>

                    <!-- Potatoes-->
                    <div class="dish-card hover-lift">
                        <div class="dish-image">
                            <img src="https://plus.unsplash.com/premium_photo-1725001313906-44c96c8be4bc?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTE3fHxwb3RhdG9lc3xlbnwwfHwwfHx8MA%3D%3D"
                                alt="Fresh Potatoes">
                            <div class="dish-category">Vegetables</div>
                        </div>
                        <div class="dish-content">
                            <h3 class="dish-title">Potatoes</h3>
                            <p class="dish-description">
                                Freshly harvested potatoes, ideal for roasting, mashing, or frying. A versatile staple
                                for any kitchen.
                            </p>
                            <div class="dish-meta">
                                <div class="dish-meta-item">

                                </div>
                                <div class="dish-meta-item">

                                </div>
                            </div>
                            <a href="Login.aspx" class="btn btn-outline btn-sm" style="width: 100%;">Shop Now</a>
                        </div>
                    </div>

                    <!-- Bananas -->
                    <div class="dish-card hover-lift">
                        <div class="dish-image">
                            <img src="https://images.unsplash.com/photo-1587334206596-c0f9f7dccbe6?q=80&w=881&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                                alt="Bananas">
                            <div class="dish-category">Fruits</div>
                        </div>
                        <div class="dish-content">
                            <h3 class="dish-title">Bananas</h3>
                            <p class="dish-description">
                                Sweet and nutritious bananas, perfect for snacking, smoothies, or baking. A great source
                                of energy.
                            </p>
                            <div class="dish-meta">
                                <div class="dish-meta-item">

                                </div>
                                <div class="dish-meta-item">

                                </div>
                            </div>
                            <a href="Login.aspx" class="btn btn-outline btn-sm" style="width: 100%;">Shop Now</a>
                        </div>
                    </div>

                    <!-- Apples -->
                    <div class="dish-card hover-lift">
                        <div class="dish-image">
                            <img src="https://images.unsplash.com/photo-1583260142313-2c9c2c5fec8f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTExfHxBcHBsZXN8ZW58MHx8MHx8fDA%3D"
                                alt="Apples">
                            <div class="dish-category">Fruits</div>
                        </div>
                        <div class="dish-content">
                            <h3 class="dish-title">Apples</h3>
                            <p class="dish-description">
                                Crisp and juicy apples, perfect for snacking or baking. A classic fruit that never goes
                                out of style.
                            </p>
                            <div class="dish-meta">
                                <div class="dish-meta-item">


                                </div>
                                <div class="dish-meta-item">

                                </div>
                            </div>
                            <a href="Login.aspx" class="btn btn-outline btn-sm" style="width: 100%;">Shop Now</a>
                        </div>
                    </div>

                    <!-- White Bread -->
                    <div class="dish-card hover-lift">
                        <div class="dish-image">
                            <img src="https://images.unsplash.com/photo-1600102186542-82cbd5e7bdb4?q=80&w=1450&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                                alt="White Bread">
                            <div class="dish-category">Bakery</div>
                        </div>
                        <div class="dish-content">
                            <h3 class="dish-title"> White Bread</h3>
                            <p class="dish-description">
                                Soft and fluffy white bread, perfect for sandwiches, toast, or enjoying with butter.
                                Freshly baked daily.
                            </p>
                            <div class="dish-meta">
                                <div class="dish-meta-item">

                                </div>
                                <div class="dish-meta-item">

                                </div>
                            </div>
                            <a href="Login.aspx" class="btn btn-outline btn-sm" style="width: 100%;">Shop Now</a>
                        </div>
                    </div>

                    <!-- Whole Wheat Bread -->
                    <div class="dish-card hover-lift">
                        <div class="dish-image">
                            <img src="https://images.pexels.com/photos/30668340/pexels-photo-30668340.jpeg"
                                alt="Whole Wheat Bread">
                            <div class="dish-category">Bakery</div>
                        </div>
                        <div class="dish-content">
                            <h3 class="dish-title"> Whole Wheat Bread</h3>
                            <p class="dish-description">
                                Nutritious whole wheat bread, packed with fiber and flavor. Perfect for healthy
                                sandwiches or toast.
                            </p>
                            <div class="dish-meta">
                                <div class="dish-meta-item">

                                </div>
                                <div class="dish-meta-item">

                                </div>
                            </div>
                            <a href="Login.aspx" class="btn btn-outline btn-sm" style="width: 100%;">Shop Now</a>
                        </div>
                    </div>

                    <!-- Curry -->
                    <div class="dish-card hover-lift">
                        <div class="dish-image">
                            <img src="https://images.unsplash.com/photo-1587486913049-53fc88980cfc?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                                alt="Eggs">
                            <div class="dish-category">Dairy</div>
                        </div>
                        <div class="dish-content">
                            <h3 class="dish-title">Eggs</h3>
                            <p class="dish-description">
                                Farm-fresh eggs, perfect for breakfast, baking, or adding protein to any meal. A
                                versatile kitchen staple.
                            </p>
                            <div class="dish-meta">
                                <div class="dish-meta-item">

                                </div>
                                <div class="dish-meta-item">

                                </div>
                            </div>
                            <a href="Login.aspx" class="btn btn-outline btn-sm" style="width: 100%;">Shop Now</a>
                        </div>
                    </div>

                    <!-- Dessert -->
                    <div class="dish-card hover-lift">
                        <div class="dish-image">
                            <img src="https://plus.unsplash.com/premium_photo-1664647903543-2ef213d1e754?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTd8fG1pbGt8ZW58MHx8MHx8fDA%3D"
                                alt="Milk">
                            <div class="dish-category">Dairy</div>
                        </div>
                        <div class="dish-content">
                            <h3 class="dish-title">Milk</h3>
                            <p class="dish-description">
                                Fresh and creamy milk, perfect for drinking, cooking, or baking. A rich source of
                                calcium and vitamins.
                            </p>
                            <div class="dish-meta">
                                <div class="dish-meta-item">

                                </div>
                                <div class="dish-meta-item">

                                </div>
                            </div>
                            <a href="Login.aspx" class="btn btn-outline btn-sm" style="width: 100%;">Shop Now</a>
                        </div>
                    </div>
                </div>

                <div class="text-center" style="margin-top: 3rem;">
                    <div class="glass-card" style="display: inline-block; padding: 2rem; border-radius: 16px;">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                            style="width: 48px; height: 48px; color: hsl(var(--color-primary)); margin: 0 auto 1rem; display: block;">
                            <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2" />
                            <circle cx="9" cy="7" r="4" />
                            <path d="M22 21v-2a4 4 0 0 0-3-3.87" />
                            <path d="M16 3.13a4 4 0 0 1 0 7.75" />
                        </svg>
                        <h3 style="font-size: 1.25rem; font-weight: 700; margin-bottom: 0.5rem;">Unlock your full
                            shopping experience</h3>
                        </h3>
                        <p class="text-muted" style="margin-bottom: 1rem; max-width: 400px;">
                            Join our community to access exclusive products, personalized ingredients, recipes and
                            special offerings tailored just for you.
                        </p>
                        <a href="Register.aspx" class="btn btn-accent">Register Now</a>
                    </div>
                </div>
            </div>
        </section>


        <!-- Featured Dishes Section  the recipes NOW-->
        <!-- Featured Dishes Section  the recipes NOW-->
        <!-- Simple Garden Salad (Vegan, Common)

Ingredients: Lettuce, tomato, cucumber, olive oil, lemon, salt, pepper
Steps: Chop veggies, toss with olive oil, lemon, salt, and pepper.
Fresh Fruit Salad (Vegan, Common)

Ingredients: Apple, banana, orange, lemon juice, mint (optional)
Steps: Dice fruit, mix, drizzle with lemon juice, garnish with mint.
Quick Halal Chicken Wrap (Halal, Common)

Ingredients: Cooked chicken breast, lettuce, tomato, cucumber, olive oil, salt, pepper, tortilla/wrap
Steps: Slice chicken and veggies, fill wrap, drizzle with olive oil, season, roll up.
Wild Card: Caprese Skewers (Food Lovers, Common)

Ingredients: Cherry tomatoes, mozzarella balls, fresh basil, olive oil, salt, pepper
Steps: Skewer tomato, mozzarella, basil; drizzle with olive oil, season-->
        <section class="section featured-dishes" id="recipes">
            <div class="container">
                <h2 class="section-title">
                    Today's
                    <span class="gradient-accent-text">Featured Creations</span>
                </h2>
                <p class="section-subtitle">
                    Get a taste of what awaits you. Our chefs craft new specials daily,
                    and members get access to complete recipes and insights from our community.
                </p>

                <div class="grid grid-cols-4 fade-in">
                    <!-- Salad -->
                    <div class="dish-card hover-lift">
                        <div class="dish-image">
                            <img src="https://images.unsplash.com/photo-1723985021773-d1f4c4ebfdd1?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHNpbXBsZSUyMGdhcmRlbiUyMHNhbGFkfGVufDB8fDB8fHww"
                                alt="Garden salad">
                            <div class="dish-category">Vegetarian</div>
                        </div>
                        <div class="dish-content">
                            <h3 class="dish-title">Simple Garden Salad</h3>
                            <p class="dish-description">
                                Crisp greens, cherry tomatoes, cucumbers, and a light vinaigrette dressing and olive
                                oil.
                                Perfect for a refreshing side or light meal.
                            </p>
                            <div class="dish-meta">
                                <div class="dish-meta-item">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <circle cx="12" cy="12" r="10" />
                                        <polyline points="12,6 12,12 16,14" />
                                    </svg>
                                    <span>8 mins</span>
                                </div>
                                <div class="dish-meta-item">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4Z" />
                                        <line x1="3" x2="21" y1="6" y2="6" />
                                        <path d="M16 10a4 4 0 0 1-8 0" />
                                    </svg>
                                    <span>Easy</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Chicken Wrap -->
                    <div class="dish-card hover-lift">
                        <div class="dish-image">
                            <img src="https://images.unsplash.com/photo-1626700051175-6818013e1d4f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Q2hpY2tlbiUyMHdyYXB8ZW58MHx8MHx8fDA%3D"
                                alt="Chicken Wrap">
                            <div class="dish-category">Halal</div>
                        </div>
                        <div class="dish-content">
                            <h3 class="dish-title">Halal Chicken Wrap</h3>
                            <p class="dish-description">
                                Tender grilled chicken, fresh veggies, and a zesty sauce wrapped in a soft tortilla.
                                Perfect for a quick lunch or dinner.
                            </p>
                            <div class="dish-meta">
                                <div class="dish-meta-item">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <circle cx="12" cy="12" r="10" />
                                        <polyline points="12,6 12,12 16,14" />
                                    </svg>
                                    <span>15 min</span>
                                </div>
                                <div class="dish-meta-item">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4Z" />
                                        <line x1="3" x2="21" y1="6" y2="6" />
                                        <path d="M16 10a4 4 0 0 1-8 0" />
                                    </svg>
                                    <span>Intermediate</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Fruit Salad -->
                    <div class="dish-card hover-lift">
                        <div class="dish-image">
                            <img src="https://images.unsplash.com/photo-1631718051263-c567dca19362?q=80&w=891&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                                alt="Fresh fruit salad">
                            <div class="dish-category">Food Lovers</div>
                        </div>
                        <div class="dish-content">
                            <h3 class="dish-title">Fresh Fruit Salad</h3>
                            <p class="dish-description">
                                A vibrant mix of seasonal fruits, drizzled with lemon juice and a hint of mint. Perfect
                                for
                                breakfast or a light dessert.
                            </p>
                            <div class="dish-meta">
                                <div class="dish-meta-item">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <circle cx="12" cy="12" r="10" />
                                        <polyline points="12,6 12,12 16,14" />
                                    </svg>
                                    <span>45 min</span>
                                </div>
                                <div class="dish-meta-item">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4Z" />
                                        <line x1="3" x2="21" y1="6" y2="6" />
                                        <path d="M16 10a4 4 0 0 1-8 0" />
                                    </svg>
                                    <span>Easy</span>
                                </div>
                            </div>

                        </div>
                    </div>

                    <!--Sandwhich -->
                    <div class="dish-card hover-lift">
                        <div class="dish-image">
                            <img src="https://images.unsplash.com/photo-1639150362147-00e4cee6b3f5?q=80&w=1473&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                                alt="Cheesy Garlic Bread">
                            <div class="dish-category">Food Lovers</div>
                        </div>
                        <div class="dish-content">
                            <h3 class="dish-title">Cheezy Garlic Toast</h3>
                            <p class="dish-description">
                                Crispy garlic bread topped with melted cheese, perfect as a side or snack. A
                                comforting classic that never disappoints.
                            </p>
                            <div class="dish-meta">
                                <div class="dish-meta-item">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <circle cx="12" cy="12" r="10" />
                                        <polyline points="12,6 12,12 16,14" />
                                    </svg>
                                    <span>30 min</span>
                                </div>
                                <div class="dish-meta-item">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4Z" />
                                        <line x1="3" x2="21" y1="6" y2="6" />
                                        <path d="M16 10a4 4 0 0 1-8 0" />
                                    </svg>
                                    <span>Intermediate</span>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Community Blog Section -->
        <section class="section community-blog" id="community">
            <div class="container">
                <h2 class="section-title">
                    Community
                    <span class="gradient-text">Stories & Tips</span>
                </h2>
                <p class="section-subtitle">
                    Real stories, tested recipes, and proven tips from our vibrant community.
                    Join the conversation and share your culinary journey.
                </p>

                <div class="blog-grid fade-in" style="grid-template-columns: 2fr 1fr; gap: 2rem; margin-bottom: 3rem;">
                    <!-- Featured Post -->
                    <div class="blog-card blog-featured hover-lift">
                        <div class="blog-featured-content">
                            <div style="display: flex; align-items: center; gap: 0.5rem; margin-bottom: 1rem;">
                                <span class="blog-featured-badge">Featured Story</span>
                                <span style="color: rgba(255, 255, 255, 0.8); font-size: 0.875rem;">Vegan
                                    Tips</span>
                            </div>
                            <h3 class="blog-featured-title">5 Easy Vegan Swaps That Changed My Life</h3>
                            <p class="blog-featured-excerpt">
                                Discover simple ingredient swaps that make plant-based cooking effortless and
                                delicious.
                            </p>
                            <div class="blog-meta">
                                <div class="blog-meta-left">
                                    <div class="blog-meta-item">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                            <rect x="3" y="4" width="18" height="18" rx="2" ry="2" />
                                            <line x1="16" y1="2" x2="16" y2="6" />
                                            <line x1="8" y1="2" x2="8" y2="6" />
                                            <line x1="3" y1="10" x2="21" y2="10" />
                                        </svg>
                                        <span>2 days ago</span>
                                    </div>
                                    <span>4 min read</span>
                                </div>
                                <div class="blog-meta-right">
                                    <div class="blog-meta-item like-btn">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                            <path
                                                d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" />
                                        </svg>
                                        <span class="like-count">124</span>
                                    </div>
                                    <div class="blog-meta-item">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                            <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" />
                                        </svg>
                                        <span>18</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div
                            style="padding: 1.5rem; display: flex; justify-content: space-between; align-items: center;">
                            <span style="font-weight: 600; color: hsl(var(--color-primary));">by Sarah M.</span>
                            <a href="#" class="btn btn-primary btn-sm">Read Full Story</a>
                        </div>
                    </div>

                    <!-- Regular Posts -->
                    <div style="display: flex; flex-direction: column; gap: 1.5rem;">
                        <div class="blog-card blog-regular hover-lift">
                            <div class="blog-header">
                                <span class="blog-category">Halal Cuisine</span>
                                <div class="blog-engagement">
                                    <div class="blog-meta-item like-btn">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                            <path
                                                d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" />
                                        </svg>
                                        <span class="like-count">89</span>
                                    </div>
                                    <div class="blog-meta-item">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                            <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" />
                                        </svg>
                                        <span>23</span>
                                    </div>
                                </div>
                            </div>
                            <h4 class="blog-title">Traditional Halal Spice Blends: A Global Journey</h4>
                            <p class="blog-excerpt">
                                Explore authentic spice combinations from Morocco to Malaysia and how to use them in
                                modern cooking.
                            </p>
                            <div class="blog-footer">
                                <div>
                                    <span style="font-weight: 600;">by Ahmed K.</span>
                                    <span style="margin: 0 0.5rem;">•</span>
                                    <span>1 week ago</span>
                                    <span style="margin: 0 0.5rem;">•</span>
                                    <span>6 min read</span>
                                </div>
                                <button class="btn" style="background: none; padding: 0.25rem;">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                        style="width: 16px; height: 16px;">
                                        <path d="M4 12v8a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-8" />
                                        <polyline points="16,6 12,2 8,6" />
                                        <line x1="12" y1="2" x2="12" y2="15" />
                                    </svg>
                                </button>
                            </div>
                        </div>

                        <div class="blog-card blog-regular hover-lift">
                            <div class="blog-header">
                                <span class="blog-category">Meal Prep</span>
                                <div class="blog-engagement">
                                    <div class="blog-meta-item like-btn">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                            <path
                                                d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" />
                                        </svg>
                                        <span class="like-count">156</span>
                                    </div>
                                    <div class="blog-meta-item">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                            <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" />
                                        </svg>
                                        <span>31</span>
                                    </div>
                                </div>
                            </div>
                            <h4 class="blog-title">Meal Prep Sunday: Week of Mediterranean Flavors</h4>
                            <p class="blog-excerpt">
                                Complete meal prep guide with shopping lists, prep steps, and storage tips for a
                                week of Mediterranean meals.
                            </p>
                            <div class="blog-footer">
                                <div>
                                    <span style="font-weight: 600;">by Maria L.</span>
                                    <span style="margin: 0 0.5rem;">•</span>
                                    <span>1 week ago</span>
                                    <span style="margin: 0 0.5rem;">•</span>
                                    <span>8 min read</span>
                                </div>
                                <button class="btn" style="background: none; padding: 0.25rem;">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                        style="width: 16px; height: 16px;">
                                        <path d="M4 12v8a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-8" />
                                        <polyline points="16,6 12,2 8,6" />
                                        <line x1="12" y1="2" x2="12" y2="15" />
                                    </svg>
                                </button>
                            </div>
                        </div>

                        <div class="blog-card blog-regular hover-lift">
                            <div class="blog-header">
                                <span class="blog-category">Nutrition</span>
                                <div class="blog-engagement">
                                    <div class="blog-meta-item like-btn">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                            <path
                                                d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" />
                                        </svg>
                                        <span class="like-count">78</span>
                                    </div>
                                    <div class="blog-meta-item">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                            <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" />
                                        </svg>
                                        <span>12</span>
                                    </div>
                                </div>
                            </div>
                            <h4 class="blog-title">The Science Behind Fermented Foods</h4>
                            <p class="blog-excerpt">
                                Understanding the health benefits and culinary applications of fermentation in
                                different cultural contexts.
                            </p>
                            <div class="blog-footer">
                                <div>
                                    <span style="font-weight: 600;">by Dr. James P.</span>
                                    <span style="margin: 0 0.5rem;">•</span>
                                    <span>2 weeks ago</span>
                                    <span style="margin: 0 0.5rem;">•</span>
                                    <span>5 min read</span>
                                </div>
                                <button class="btn" style="background: none; padding: 0.25rem;">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                        style="width: 16px; height: 16px;">
                                        <path d="M4 12v8a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-8" />
                                        <polyline points="16,6 12,2 8,6" />
                                        <line x1="12" y1="2" x2="12" y2="15" />
                                    </svg>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="text-center">
                    <div class="glass-card"
                        style="display: inline-block; padding: 2rem; border-radius: 16px; max-width: 400px;">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                            style="width: 48px; height: 48px; color: hsl(var(--color-primary)); margin: 0 auto 1rem; display: block;">
                            <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" />
                        </svg>
                        <h3 style="font-size: 1.25rem; font-weight: 700; margin-bottom: 0.5rem;">Join the
                            Conversation</h3>
                        <p class="text-muted" style="margin-bottom: 1.5rem;">
                            Share your recipes, get cooking tips, and connect with food lovers worldwide.
                        </p>
                        <a href="Register.aspx" class="btn btn-hero" style="width: 100%;">Become a Member</a>
                    </div>
                </div>
            </div>
        </section>


        <script src="js/script.js"></script>






    </asp:Content>