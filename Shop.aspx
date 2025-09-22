<%@ Page Title="" Language="C#" MasterPageFile="~/Daily Deli Master Page.Master" AutoEventWireup="true"
  CodeBehind="Shop.aspx.cs" Inherits="Daily_Deli_E_Commerce.Shop" %>
  <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title>DailyDeli - Shopping </title>

    <style>
      /* Cart Button Underline on Hover */
      .cart-btn {
        position: relative;
        background: none;
        border: none;
        color: var(--link-color);
        font-size: 1.1rem;
        cursor: pointer;
        transition: color var(--transition);
        outline: none;
      }

      .cart-btn::after {
        content: "";
        position: absolute;
        left: 0;
        bottom: -2px;
        width: 0;
        height: 2px;
        background: var(--accent-color);
        transition: width 0.3s cubic-bezier(0.68, -0.55, 0.27, 1.55);
      }

      .cart-btn:hover::after,
      .cart-btn:focus::after {
        width: 100%;
      }

      /* Recipe Card Image Styling */
      .recipe-image-container {
        width: 100%;
        height: 180px;
        overflow: hidden;
        border-top-left-radius: var(--radius);
        border-top-right-radius: var(--radius);
        margin-bottom: var(--spacing-4);
      }

      .recipe-image-container img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        display: block;
      }

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
        --card-shadow: rgba(0, 0, 0, 0.3);
        --footer-link-hover: #0077cc;
        --button-hover: rgb(5, 151, 255);
      }

      /* Custom Properties (CSS Variables) */
      :root {
        /* Colors - Fresh Grocery Theme */
        --primary: #0077cc;
        --primary-foreground: hsl(0, 0%, 98%);
        --primary-soft: hsl(158, 45%, 85%);
        --primary-glow: #0972bd;

        --secondary: hsl(45, 85%, 65%);
        --secondary-foreground: hsl(160, 15%, 15%);

        --accent: hsl(25, 85%, 65%);
        --accent-foreground: hsl(0, 0%, 98%);

        --background: #fafafa;
        --foreground: #333;
        --surface: hsl(0, 0%, 100%);
        --surface-alt: hsl(145, 20%, 95%);

        --muted: hsl(145, 15%, 93%);
        --muted-foreground: hsl(160, 8%, 45%);

        --border: hsl(145, 25%, 88%);
        --hover: hsl(145, 20%, 95%);

        --success: hsl(142, 71%, 45%);
        --warning: hsl(38, 92%, 50%);
        --destructive: hsl(0, 84%, 60%);

        /* Gradients */
        --gradient-primary: linear-gradient(135deg,
            var(--primary),
            var(--primary-glow));
        --gradient-fresh: linear-gradient(135deg, var(--primary), var(--secondary));
        --gradient-surface: linear-gradient(180deg,
            var(--surface),
            var(--surface-alt));

        /* Shadows */
        --shadow-sm: 0 1px 2px 0 hsla(160, 15%, 15%, 0.05);
        --shadow: 0 4px 6px -1px hsla(160, 15%, 15%, 0.1);
        --shadow-lg: 0 10px 15px -3px hsla(160, 15%, 15%, 0.1);
        --shadow-glow: 0 0 0 1px hsla(158, 64%, 35%, 0.1),
          0 4px 12px hsla(158, 64%, 35%, 0.15);

        /* Typography */
        --font-family: "Poppins", "Inter", sans-serif;
        --font-size-xs: 0.75rem;
        --font-size-sm: 0.875rem;
        --font-size-base: 1rem;
        --font-size-lg: 1.125rem;
        --font-size-xl: 1.25rem;
        --font-size-2xl: 1.5rem;
        --font-size-3xl: 1.875rem;
        --font-size-4xl: 2.25rem;
        --font-size-5xl: 3rem;

        /* Spacing */
        --spacing-1: 0.25rem;
        --spacing-2: 0.5rem;
        --spacing-3: 0.75rem;
        --spacing-4: 1rem;
        --spacing-5: 1.25rem;
        --spacing-6: 1.5rem;
        --spacing-8: 2rem;
        --spacing-12: 3rem;
        --spacing-16: 4rem;

        /* Border Radius */
        --radius: 0.75rem;
        --radius-sm: 0.375rem;
        --radius-lg: 1rem;
        --radius-full: 9999px;

        /* Transitions */
        --transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
        --transition-slow: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      }

      body {
        font-family: var(--font-family);
        background-color: var(--background);
        color: var(--foreground);
        line-height: 1.6;
        scroll-behavior: smooth;
      }


      .container {
        max-width: 1200px;
        margin: 0 auto;
        --shadow-soft: 0 4px 20px -2px hsla(220, 20%, 12%, 0.28);
        box-sizing: border-box;
        width: 100%;
      }

      /* Utility Classes */
      .visually-hidden {
        position: absolute;
        width: 1px;
        height: 1px;
        padding: 0;
        margin: -1px;
        overflow: hidden;
        clip: rect(0, 0, 0, 0);
        white-space: nowrap;
        border: 0;
      }

      /* Animations */
      @keyframes fadeIn {
        from {
          opacity: 0;
        }

        to {
          opacity: 1;
        }
      }

      @keyframes slideUp {
        from {
          opacity: 0;
          transform: translateY(20px);
        }

        to {
          opacity: 1;
          transform: translateY(0);
        }
      }

      @keyframes bounceSoft {

        0%,
        20%,
        50%,
        80%,
        100% {
          transform: translateY(0);
        }

        40% {
          transform: translateY(-3px);
        }

        60% {
          transform: translateY(-2px);
        }
      }

      @keyframes pulseSoft {

        0%,
        100% {
          opacity: 1;
        }

        50% {
          opacity: 0.8;
        }
      }

      .animate-fade-in {
        animation: fadeIn 0.6s ease-out;
      }

      .animate-slide-up {
        animation: slideUp 0.6s ease-out;
      }

      .animate-bounce-soft {
        animation: bounceSoft 2s infinite;
      }

      .animate-pulse-soft {
        animation: pulseSoft 2s infinite;
      }






      .mobile-menu-btn {
        display: none;
        background: none;
        border: none;
        color: var(--primary-foreground);
        font-size: var(--font-size-lg);
        cursor: pointer;
        padding: var(--spacing-2);
        border-radius: var(--radius-sm);
        transition: var(--transition);
      }

      .mobile-menu-btn:hover {
        background-color: hsla(0, 0%, 100%, 0.1);
      }

      .cart-btn {
        position: relative;
        background: none;
        border: none;
        color: var(--foreground);
        font-size: var(--font-size-lg);
        cursor: pointer;
        padding: var(--spacing-2);
        border-radius: var(--radius-sm);
        transition: var(--transition);
      }

      .cart-btn:hover {
        background-color: hsla(0, 0%, 100%, 0.1);
      }

      .cart-count {
        position: absolute;
        top: -8px;
        right: -8px;
        background: var(--accent);
        color: var(--accent-foreground);
        font-size: var(--font-size-xs);
        font-weight: 700;
        padding: 2px 6px;
        border-radius: var(--radius-full);
        min-width: 20px;
        height: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        animation: bounceSoft 2s infinite;
      }

      .mobile-nav {
        display: none;
        padding: var(--spacing-4);
        border-top: 1px solid hsla(0, 0%, 100%, 0.2);
        animation: slideUp 0.3s ease-out;
      }

      .mobile-nav.active {
        display: block;
      }

      .mobile-nav-link {
        display: block;
        color: hsla(0, 0%, 100%, 0.8);
        text-decoration: none;
        padding: var(--spacing-2) 0;
        transition: var(--transition);
      }

      .mobile-nav-link:hover {
        color: var(--primary-foreground);
      }

      /* Hero Section */
      .hero {
        position: relative;
        height: 60vh;
        overflow: hidden;
      }

      .hero-image {
        width: 100%;
        height: 100%;
        object-fit: cover;
      }

      .hero-overlay {
        position: absolute;
        inset: 0;
        background: linear-gradient(to right, hsla(0, 0%, 0%, 0.6), transparent);
        display: flex;
        align-items: center;
      }

      .hero-content {
        max-width: 600px;
        color: white;
        padding: 0 var(--spacing-4);
        animation: fadeIn 1s ease-out;
      }

      .hero-badge {
        display: inline-flex;
        align-items: center;
        gap: var(--spacing-2);
        background: hsla(25, 85%, 65%, 0.9);
        color: var(--accent-foreground);
        padding: var(--spacing-2) var(--spacing-4);
        border-radius: var(--radius-full);
        font-size: var(--font-size-sm);
        font-weight: 600;
        margin-bottom: var(--spacing-4);
      }

      .hero-title {
        font-size: var(--font-size-5xl);
        font-weight: 700;
        line-height: 1.1;
        margin-bottom: var(--spacing-6);
      }

      .hero-subtitle {
        color: var(--secondary);
      }

      .hero-description {
        font-size: var(--font-size-xl);
        color: hsla(0, 0%, 100%, 0.9);
        margin-bottom: var(--spacing-8);
        line-height: 1.5;
      }

      .hero-btn {
        display: inline-flex;
        align-items: center;
        gap: var(--spacing-2);
        background: var(--gradient-primary);
        color: var(--primary-foreground);
        border: none;
        padding: var(--spacing-4) var(--spacing-8);
        border-radius: var(--radius);
        font-size: var(--font-size-lg);
        font-weight: 600;
        cursor: pointer;
        transition: var(--transition);
      }

      .hero-btn:hover {
        transform: translateY(-2px);
        box-shadow: var(--shadow-lg);
      }

      /* Category Filter */
      .category-filter {
        background: hsla(0, 0%, 100%, 0.8);
        backdrop-filter: blur(12px);
        padding: var(--spacing-4) 0;
        position: sticky;
        top: 76px;
        z-index: 999;
        border-bottom: 1px solid var(--border);
      }

      .category-buttons {
        display: flex;
        gap: var(--spacing-2);
        overflow-x: auto;
        padding-bottom: var(--spacing-2);
        scrollbar-width: none;
      }

      .category-buttons::-webkit-scrollbar {
        display: none;
      }

      .category-btn {
        display: flex;
        align-items: center;
        gap: var(--spacing-2);
        background: var(--surface);
        border: 2px solid var(--border);
        color: var(--foreground);
        padding: var(--spacing-3) var(--spacing-4);
        border-radius: var(--radius-full);
        font-size: var(--font-size-sm);
        font-weight: 500;
        cursor: pointer;
        white-space: nowrap;
        transition: var(--transition);
      }

      .category-btn:hover {
        background: var(--hover);
        transform: scale(1.05);
      }

      .category-btn.active {
        background: var(--gradient-primary);
        color: var(--primary-foreground);
        border-color: var(--primary);
        box-shadow: var(--shadow-glow);
        transform: scale(1.05);
      }

      .category-icon {
        font-size: var(--font-size-base);
      }

      /* Section Styles */
      .section-title {
        font-size: var(--font-size-3xl);
        font-weight: 700;
        text-align: center;
        margin-bottom: var(--spacing-8);
        color: var(--foreground);
      }

      .section-subtitle {
        font-size: var(--font-size-lg);
        color: var(--muted-foreground);
        text-align: center;
        max-width: 600px;
        margin: 0 auto var(--spacing-8);
        line-height: 1.5;
      }

      /* Featured Products */
      .featured-section {
        padding: var(--spacing-12) 0;
      }

      .featured-products {
        display: flex;
        overflow-x: auto;
        gap: var(--spacing-6);
        padding-bottom: var(--spacing-4);
        margin-bottom: var(--spacing-8);
        scrollbar-width: none;
      }

      .featured-products::-webkit-scrollbar {
        display: none;
      }

      /* Product Card Styles */
      .product-card {
        background: var(--surface);
        border-radius: var(--radius);
        border: 1px solid var(--border);
        overflow: hidden;
        transition: var(--transition);
        position: relative;
        min-width: 280px;
        animation: fadeIn 0.6s ease-out;
        box-shadow: var(--shadow-soft);
      }

      .product-card:hover {
        transform: translateY(-3px);
        box-shadow: var(--shadow-glow);
      }

      .product-image-container {
        position: relative;
      }

      .product-image {
        width: 100%;
        height: 200px;
        object-fit: cover;
        transition: var(--transition);
        cursor: pointer;
      }

      .product-card:hover .product-image {
        transform: scale(1.05);
      }

      .product-category {
        position: absolute;
        top: var(--spacing-2);
        right: var(--spacing-2);
        background: rgba(255, 255, 255, 0.65);
        color: var(--primary);
        padding: var(--spacing-1) var(--spacing-3);
        border-radius: 8px;
        font-size: 0.75rem;
        font-weight: 600;
        backdrop-filter: blur(8px);
        text-transform: capitalize;
      }

      .product-content {
        padding: var(--spacing-4);
      }

      .product-name {
        font-size: var(--font-size-lg);
        font-weight: 600;
        margin-bottom: var(--spacing-2);
        color: var(--foreground);
        display: -webkit-box;
        -webkit-line-clamp: 1;
        -webkit-box-orient: vertical;
        overflow: hidden;
      }

      .product-price {
        font-size: var(--font-size-2xl);
        font-weight: 700;
        color: var(--primary);
        margin-bottom: var(--spacing-4);
      }

      .product-unit {
        font-size: var(--font-size-sm);
        color: var(--muted-foreground);
        margin-left: var(--spacing-1);
      }

      .product-actions {
        display: flex;
        gap: var(--spacing-2);
      }

      .btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: var(--spacing-2);
        padding: var(--spacing-3) var(--spacing-4);
        border-radius: var(--radius);
        font-size: var(--font-size-sm);
        font-weight: 500;
        cursor: pointer;
        transition: var(--transition);
        text-decoration: none;
        border: none;
      }

      .btn-primary {
        background: var(--gradient-primary);
        color: var(--primary-foreground);
        flex: 1;
      }

      .btn-primary:hover {
        transform: translateY(-1px);
        box-shadow: var(--shadow-lg);
      }

      .btn-outline {
        background: transparent;
        color: var(--primary);
        border: 2px solid hsla(158, 64%, 35%, 0.2);
      }

      .btn-outline:hover {
        background: hsla(158, 64%, 35%, 0.05);
      }

      .btn-icon {
        padding: var(--spacing-3);
        width: 44px;
        height: 44px;
      }

      .btn-clear {
        color: var(--destructive);
        border-color: hsla(0, 84%, 60%, 0.2);
      }

      .btn-clear:hover {
        background: hsla(0, 84%, 60%, 0.05);
      }

      .btn-checkout {
        font-size: var(--font-size-lg);
        font-weight: 600;
        padding: var(--spacing-3) 0;
      }

      /* Quick Recipes */
      .recipes-section {
        padding: var(--spacing-8) 0;
        background: var(--gradient-surface);
        border-bottom: 1px solid var(--border);
      }

      .recipes-toggle {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: var(--spacing-2);
        width: 100%;
        max-width: 400px;
        margin: 0 auto;
        background: hsla(0, 0%, 100%, 0.8);
        backdrop-filter: blur(12px);
        border: 2px solid hsla(158, 64%, 35%, 0.2);
        color: var(--foreground);
        padding: var(--spacing-3) var(--spacing-6);
        border-radius: var(--radius);
        font-size: var(--font-size-lg);
        font-weight: 600;
        cursor: pointer;
        transition: var(--transition);
      }

      .recipes-toggle:hover {
        background: hsla(158, 64%, 35%, 0.05);
      }

      .recipes-content {
        margin-top: var(--spacing-6);
        max-height: 0;
        overflow: hidden;
        transition: max-height 0.3s ease-out;
      }

      .recipes-content.active {
        max-height: 1000px;
      }

      .recipes-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: var(--spacing-4);
        animation: slideUp 0.6s ease-out;
      }

      .recipe-card {
        background: var(--surface);
        border: 1px solid var(--border);
        border-radius: var(--radius);
        padding: var(--spacing-4);
        transition: var(--transition);
        box-shadow: var(--shadow-soft);
      }

      .recipe-card:hover {
        box-shadow: var(--shadow-glow);
      }

      .recipe-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: var(--spacing-4);
      }

      .recipe-name {
        font-size: var(--font-size-lg);
        font-weight: 600;
        color: var(--foreground);
      }

      .recipe-time {
        display: flex;
        align-items: center;
        gap: var(--spacing-1);
        background: var(--muted);
        color: var(--muted-foreground);
        padding: var(--spacing-1) var(--spacing-3);
        border-radius: var(--radius-full);
        font-size: var(--font-size-xs);
      }

      .recipe-ingredients {
        margin-bottom: var(--spacing-4);
      }

      .recipe-ingredients h4 {
        font-size: var(--font-size-sm);
        color: var(--muted-foreground);
        margin-bottom: var(--spacing-2);
      }

      .ingredients-list {
        list-style: none;
      }

      .ingredients-list li {
        display: flex;
        align-items: center;
        gap: var(--spacing-2);
        font-size: var(--font-size-sm);
        margin-bottom: var(--spacing-1);
      }

      .ingredient-bullet {
        width: 8px;
        height: 8px;
        background: hsla(158, 64%, 35%, 0.6);
        border-radius: var(--radius-full);
      }

      .recipe-difficulty {
        display: inline-flex;
        align-items: center;
        padding: var(--spacing-1) var(--spacing-3);
        border-radius: var(--radius-full);
        font-size: var(--font-size-xs);
        font-weight: 500;
        margin-bottom: var(--spacing-4);
      }

      .difficulty-easy {
        background: hsla(142, 71%, 45%, 0.1);
        color: var(--success);
        border: 1px solid hsla(142, 71%, 45%, 0.2);
      }

      .difficulty-medium {
        background: hsla(38, 92%, 50%, 0.1);
        color: var(--warning);
        border: 1px solid hsla(38, 92%, 50%, 0.2);
      }

      .difficulty-hard {
        background: hsla(0, 84%, 60%, 0.1);
        color: var(--destructive);
        border: 1px solid hsla(0, 84%, 60%, 0.2);
      }

      /* Products Grid */
      .products-section {
        padding: 0;
        margin-left: 1rem;
        box-sizing: border-box;
        width: 100%;
        overflow-x: hidden;
      }

      .products-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
        gap: 1rem;
        width: 100%;
        margin: 0 auto;
        justify-items: stretch;
        box-sizing: border-box;
        overflow-x: hidden;
      }

      .no-products {
        text-align: center;
        padding: 0;
      }

      .no-products p {
        font-size: var(--font-size-lg);
        color: var(--muted-foreground);
      }

      /* Meal Plans */
      .meal-plans-section {
        padding: var(--spacing-12) 0;
        background: var(--gradient-surface);
      }

      .section-header {
        text-align: center;
        margin-bottom: var(--spacing-8);
      }

      .meal-plans-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
        gap: var(--spacing-8);
        margin-bottom: var(--spacing-8);
      }

      .meal-plan-card {
        background: var(--surface);
        border-radius: var(--radius);
        overflow: hidden;
        box-shadow: var(--shadow-soft);
        transition: var(--transition);
      }

      .meal-plan-card:hover {
        box-shadow: var(--shadow-glow);
      }

      .meal-plan-header {
        background: var(--gradient-fresh);
        color: var(--primary-foreground);
        padding: var(--spacing-6);
      }

      .meal-plan-title {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: var(--spacing-2);
      }

      .meal-plan-name {
        font-size: var(--font-size-xl);
        font-weight: 600;
      }

      .meal-plan-badge {
        display: flex;
        align-items: center;
        gap: var(--spacing-1);
        background: hsla(0, 0%, 100%, 0.2);
        padding: var(--spacing-1) var(--spacing-3);
        border-radius: var(--radius-full);
        font-size: var(--font-size-xs);
      }

      .meal-plan-description {
        color: hsla(0, 0%, 100%, 0.8);
      }

      .meal-plan-content {
        padding: var(--spacing-6);
      }

      .meal-plan-days {
        margin-bottom: var(--spacing-6);
      }

      .meal-plan-day {
        background: hsla(0, 0%, 100%, 0.5);
        border: 1px solid var(--border);
        border-radius: var(--radius);
        padding: var(--spacing-4);
        margin-bottom: var(--spacing-4);
      }

      .meal-plan-day:last-child {
        margin-bottom: 0;
      }

      .day-title {
        display: flex;
        align-items: center;
        gap: var(--spacing-2);
        font-weight: 600;
        color: var(--primary);
        margin-bottom: var(--spacing-3);
      }

      .day-bullet {
        width: 8px;
        height: 8px;
        background: var(--primary);
        border-radius: var(--radius-full);
      }

      .meals-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
        gap: var(--spacing-3);
      }

      .meal-item {
        font-size: var(--font-size-sm);
      }

      .meal-label {
        font-weight: 500;
        color: var(--muted-foreground);
        margin-bottom: var(--spacing-1);
      }

      .meal-name {
        color: var(--foreground);
      }

      .meal-plan-footer {
        display: flex;
        flex-direction: column;
        gap: var(--spacing-3);
      }

      .meal-plan-meta {
        display: flex;
        align-items: center;
        gap: var(--spacing-1);
        background: var(--muted);
        color: var(--muted-foreground);
        padding: var(--spacing-1) var(--spacing-3);
        border-radius: var(--radius-full);
        font-size: var(--font-size-xs);
        align-self: flex-start;
      }

      .section-footer {
        text-align: center;
      }

      /* Footer */
      .footer {
        background: var(--primary);
        color: var(--primary-foreground);
        padding: var(--spacing-12) 0 var(--spacing-8);
        margin-top: var(--spacing-16);
      }

      .footer-content {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: var(--spacing-8);
        margin-bottom: var(--spacing-8);
      }

      .footer-title {
        font-size: var(--font-size-xl);
        font-weight: 700;
        margin-bottom: var(--spacing-4);
      }

      .footer-subtitle {
        font-size: var(--font-size-base);
        font-weight: 600;
        margin-bottom: var(--spacing-4);
      }

      .footer-text {
        color: hsla(0, 0%, 100%, 0.8);
        line-height: 1.5;
      }

      .footer-links {
        display: flex;
        flex-direction: column;
        gap: var(--spacing-2);
      }

      .footer-link {
        color: hsla(0, 0%, 100%, 0.8);
        text-decoration: none;
        transition: var(--transition);
      }

      .footer-link:hover {
        color: var(--primary-foreground);
      }

      .footer-contact {
        display: flex;
        flex-direction: column;
        gap: var(--spacing-2);
        color: hsla(0, 0%, 100%, 0.8);
      }

      .footer-bottom {
        border-top: 1px solid hsla(0, 0%, 100%, 0.2);
        padding-top: var(--spacing-8);
        text-align: center;
        color: hsla(0, 0%, 100%, 0.6);
      }

      /* Floating Cart */
      .floating-cart {
        position: fixed;
        bottom: var(--spacing-6);
        right: var(--spacing-6);
        width: 56px;
        height: 56px;
        background: var(--gradient-primary);
        color: var(--primary-foreground);
        border: none;
        border-radius: var(--radius-full);
        font-size: var(--font-size-lg);
        cursor: pointer;
        box-shadow: var(--shadow-glow);
        z-index: 1000;
        transition: var(--transition);
        animation: bounceSoft 2s infinite;
      }

      .floating-cart:hover {
        transform: translateY(-2px);
        box-shadow: var(--shadow-lg);
      }

      .floating-cart-count {
        position: absolute;
        top: -8px;
        right: -8px;
        background: var(--accent);
        color: var(--accent-foreground);
        font-size: var(--font-size-xs);
        font-weight: 700;
        padding: 2px 6px;
        border-radius: var(--radius-full);
        min-width: 24px;
        height: 24px;
        display: flex;
        align-items: center;
        justify-content: center;
        animation: pulseSoft 2s infinite;
      }

      .floating-cart.hidden {
        display: none;
      }

      /* Cart Modal */
      .cart-modal {
        position: fixed;
        inset: 0;
        background: hsla(0, 0%, 0%, 0.2);
        backdrop-filter: blur(12px);
        display: none;
        align-items: end;
        justify-content: center;
        padding: var(--spacing-4);
        z-index: 1001;
        animation: fadeIn 0.3s ease-out;
      }

      .cart-modal.active {
        display: flex;
      }

      .cart-modal-content {
        background: var(--surface);
        border-radius: var(--radius);
        box-shadow: 0 20px 25px -5px hsla(0, 0%, 0%, 0.1);
        width: 100%;
        max-width: 600px;
        max-height: 80vh;
        display: flex;
        flex-direction: column;
        animation: slideUp 0.3s ease-out;
      }

      .cart-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: var(--spacing-4);
        border-bottom: 1px solid var(--border);
      }

      .cart-title {
        display: flex;
        align-items: center;
        gap: var(--spacing-2);
        font-size: var(--font-size-xl);
        font-weight: 600;
        color: var(--foreground);
      }

      .cart-badge {
        background: var(--muted);
        color: var(--muted-foreground);
        padding: var(--spacing-1) var(--spacing-3);
        border-radius: var(--radius-full);
        font-size: var(--font-size-xs);
        margin-left: var(--spacing-2);
      }

      .cart-close {
        background: none;
        border: none;
        color: var(--muted-foreground);
        font-size: var(--font-size-lg);
        cursor: pointer;
        padding: var(--spacing-2);
        border-radius: var(--radius-sm);
        transition: var(--transition);
      }

      .cart-close:hover {
        background: var(--hover);
      }

      .cart-body {
        flex: 1;
        overflow-y: auto;
      }

      .cart-empty {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        padding: var(--spacing-12);
        text-align: center;
      }

      .cart-empty i {
        font-size: 4rem;
        color: var(--muted-foreground);
        opacity: 0.5;
        margin-bottom: var(--spacing-4);
      }

      .cart-empty p {
        font-size: var(--font-size-lg);
        color: var(--muted-foreground);
        margin-bottom: var(--spacing-2);
      }

      .cart-empty small {
        font-size: var(--font-size-sm);
        color: var(--muted-foreground);
      }

      .cart-items {
        padding: var(--spacing-4);
      }

      .cart-item {
        display: flex;
        gap: var(--spacing-4);
        padding: var(--spacing-4);
        background: var(--surface);
        border: 1px solid var(--border);
        border-radius: var(--radius);
        margin-bottom: var(--spacing-4);
      }

      .cart-item:last-child {
        margin-bottom: 0;
      }

      .cart-item-image {
        width: 80px;
        height: 80px;
        object-fit: cover;
        border-radius: var(--radius);
        flex-shrink: 0;
      }

      .cart-item-details {
        flex: 1;
        min-width: 0;
      }

      .cart-item-name {
        font-size: var(--font-size-lg);
        font-weight: 600;
        margin-bottom: var(--spacing-1);
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
      }

      .cart-item-meta {
        font-size: var(--font-size-sm);
        color: var(--muted-foreground);
        margin-bottom: var(--spacing-2);
        text-transform: capitalize;
      }

      .cart-item-price {
        font-size: var(--font-size-base);
        font-weight: 700;
        color: var(--primary);
      }

      .cart-item-actions {
        display: flex;
        flex-direction: column;
        align-items: end;
        gap: var(--spacing-2);
      }

      .cart-item-remove {
        background: none;
        border: none;
        color: var(--destructive);
        font-size: var(--font-size-base);
        cursor: pointer;
        padding: var(--spacing-2);
        border-radius: var(--radius-sm);
        transition: var(--transition);
      }

      .cart-item-remove:hover {
        background: hsla(0, 84%, 60%, 0.1);
      }

      .quantity-controls {
        display: flex;
        align-items: center;
        gap: var(--spacing-1);
        background: var(--muted);
        border-radius: var(--radius);
        padding: var(--spacing-1);
      }

      .quantity-btn {
        background: none;
        border: none;
        color: var(--foreground);
        width: 32px;
        height: 32px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: var(--radius-sm);
        cursor: pointer;
        transition: var(--transition);
      }

      .quantity-btn:hover {
        background: hsla(158, 64%, 35%, 0.1);
      }

      .quantity-display {
        min-width: 32px;
        text-align: center;
        font-weight: 500;
      }

      .cart-footer {
        border-top: 1px solid var(--border);
        padding: var(--spacing-4);
      }

      .cart-total {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: var(--spacing-4);
      }

      .total-label {
        font-size: var(--font-size-lg);
        font-weight: 600;
      }

      .total-price {
        font-size: var(--font-size-2xl);
        font-weight: 700;
        color: var(--primary);
      }

      .cart-actions {
        display: flex;
        gap: var(--spacing-3);
      }

      /* Nutrition Modal */
      .nutrition-modal {
        position: fixed;
        inset: 0;
        background: hsla(0, 0%, 0%, 0.2);
        backdrop-filter: blur(12px);
        display: none;
        align-items: center;
        justify-content: center;
        padding: var(--spacing-4);
        z-index: 1002;
        animation: fadeIn 0.3s ease-out;
      }

      .nutrition-modal.active {
        display: flex;
      }

      .nutrition-modal-content {
        background: var(--surface);
        border-radius: var(--radius);
        box-shadow: 0 20px 25px -5px hsla(0, 0%, 0%, 0.1);
        width: 100%;
        max-width: 400px;
        animation: slideUp 0.3s ease-out;
      }

      .nutrition-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: var(--spacing-4);
        border-bottom: 1px solid var(--border);
      }

      .nutrition-title {
        font-size: var(--font-size-lg);
        font-weight: 600;
        color: var(--foreground);
      }

      .nutrition-close {
        background: none;
        border: none;
        color: var(--muted-foreground);
        font-size: var(--font-size-lg);
        cursor: pointer;
        padding: var(--spacing-2);
        border-radius: var(--radius-sm);
        transition: var(--transition);
      }

      .nutrition-close:hover {
        background: var(--hover);
      }

      .nutrition-body {
        padding: var(--spacing-4);
      }

      .nutrition-info {
        margin-bottom: var(--spacing-4);
      }

      .nutrition-item {
        display: flex;
        justify-content: space-between;
        padding: var(--spacing-3) 0;
        border-bottom: 1px solid var(--border);
      }

      .nutrition-item:last-child {
        border-bottom: none;
      }

      .nutrition-label {
        color: var(--muted-foreground);
      }

      .nutrition-value {
        font-weight: 500;
        color: var(--foreground);
      }

      .nutrition-footer {
        padding: var(--spacing-4);
        border-top: 1px solid var(--border);
        display: flex;
        flex-direction: column;
        gap: var(--spacing-2);
      }

      /* Responsive Design */
      @media (max-width: 768px) {


        .hero-title {
          font-size: var(--font-size-4xl);
        }

        .hero-description {
          font-size: var(--font-size-base);
        }

        .products-grid {
          grid-template-columns: repeat(2, 1fr);
          gap: var(--spacing-4);
        }

        .meal-plans-grid {
          grid-template-columns: 1fr;
        }

        .footer-content {
          grid-template-columns: 1fr;
          gap: var(--spacing-6);
        }

        .cart-modal-content {
          margin: var(--spacing-4);
          max-height: calc(100vh - 2 * var(--spacing-4));
        }

        .meals-grid {
          grid-template-columns: 1fr;
        }
      }

      @media (min-width: 768px) {
        .products-grid {
          grid-template-columns: repeat(3, 1fr);
        }
      }

      @media (min-width: 1024px) {
        .products-grid {
          grid-template-columns: repeat(4, 1fr);
        }
      }

      @media (min-width: 1280px) {
        .products-grid {
          grid-template-columns: repeat(5, 1fr);
        }
      }

      /* Welcome user panel styling */
      .welcome-user {
        max-width: 1100px;
        margin: 1.25rem auto;
        background: linear-gradient(180deg, rgba(255, 255, 255, 0.98), rgba(250, 250, 250, 0.98));
        padding: 1rem 1.25rem;
        border-radius: 0.75rem;
        box-shadow: 0 8px 24px rgba(7, 12, 20, 0.06);
        display: flex;
        flex-direction: column;
        /* stack username and meta rows */
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
        border: 1px solid var(--border);
        opacity: 0;
        transform: translateY(6px);
        animation: fadeInUp 360ms ease-out forwards;
      }

      .welcome-user h3 {
        margin: 0;
        color: var(--muted-foreground);
        font-size: 1.125rem;
        line-height: 1.2;
      }

      .welcome-user p {
        margin: 0;
        color: var(--muted-foreground);
        font-size: 0.95rem;
      }

      /* Layout inside panel */
      .welcome-user .user-meta {
        display: flex;
        flex-direction: column;
        gap: 0.25rem;
        text-align: center;
        align-items: center;
        width: 100%;
      }

      .welcome-user .top-row {
        width: 100%;
      }

      .meta-row-container {
        display: flex;
        width: 100%;
        max-width: 900px;
        gap: 1rem;
        justify-content: space-between;
        /* even spacing */
        align-items: center;
        padding-top: 0.5rem;
      }

      .meta-item {
        flex: 1 1 0;
        display: flex;
        gap: 0.5rem;
        align-items: center;
        justify-content: center;
        min-width: 0;
      }

      .meta-item>div {
        /* label + value wrapper */
        display: flex;
        flex-direction: column;
        align-items: center;
      }

      .welcome-avatar {
        color: var(--primary);
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
        margin-right: 0.5rem;
      }

      .meta-row {
        display: flex;
        gap: 0.5rem;
        align-items: center;
        justify-content: center;
      }

      .meta-row i {
        color: var(--muted-foreground);
        width: 18px;
        text-align: center;
      }

      /* Badge-style labels */
      #lblDietType,
      #lblUserType {
        display: inline-block;
        padding: 0.25rem 0.5rem;
        border-radius: 999px;
        font-weight: 600;
        font-size: 0.85rem;
      }

      #lblDietType {
        background: var(--muted);
        color: var(--foreground);
      }

      #lblUserType {
        background: var(--primary);
        color: var(--primary-foreground);
      }

      /* Responsive: stack on small screens */
      @media (max-width: 768px) {
        .welcome-user {
          flex-direction: column;
          align-items: center;
        }

        .welcome-avatar {
          margin-right: 0;
        }
      }

      /* fade-in up animation */
      @keyframes fadeInUp {
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }
    </style>



  </asp:Content>
  <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!DOCTYPE html>
    <html lang="en">




    <!-- Page-specific scripts -->
    <script>
      document.addEventListener('DOMContentLoaded', function () {
        var mobileMenuBtn = document.getElementById('mobile-menu-btn');
        if (mobileMenuBtn) {
          mobileMenuBtn.addEventListener('click', function () {
            var mobileNav = document.getElementById('mobile-nav');
            if (mobileNav) {
              mobileNav.classList.toggle('active');
            }
          });
        }
        var productsGrid = document.getElementById('products-grid');
        if (productsGrid && typeof renderProducts === 'function') {
          renderProducts();
        }
        // Add similar guards for other features as needed
      });
    </script>

    <main>


      <!-- Cart Button 
      <button id="cart-btn" class="cart-btn" type="button">
        <i class="fas fa-shopping-cart"></i>
        <span id="cart-count" class="cart-count">0</span>
      </button>
      <button id="mobile-menu-btn" class="mobile-menu-btn" aria-label="Toggle menu" type="button">
        <i class="fas fa-bars" id="menu-icon"></i>
      </button>
      -->
      <!-- Hero Section -->
      <section class="hero">
        <img
          src="https://images.unsplash.com/photo-1698694454652-d1d24033f2e1?q=80&w=1102&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
          alt="Fresh Grocery Store" class="hero-image">
        <div class="hero-overlay">
          <div class="hero-content">
            <div class="hero-badge">
              <i class="fas fa-sparkles"></i>
              Fresh & Premium Quality
            </div>
            <h1 class="hero-title">
              Fresh Groceries
              <br>
              <span class="hero-subtitle">Delivered Daily</span>
            </h1>
            <p class="hero-description">
              Discover premium quality groceries, quick recipes, and meal plans designed to make your life delicious
              and convenient.
            </p>

          </div>
        </div>
      </section>

      <!-- Category Filter -->
      <section class="category-filter">
        <div class="container">
          <div class="category-buttons" id="category-buttons">
            <button class="category-btn active" data-category="all" type="button">

              All Items
            </button>
            <button class="category-btn" data-category="Vegetables" type="button">

              Vegetables
            </button>
            <button class="category-btn" data-category="Fruits" type="button">

              Fruits
            </button>
            <button class="category-btn" data-category="Bakery" type="button">

              Bakery
            </button>
            <button class="category-btn" data-category="Dairy" type="button">

              Dairy
            </button>
            <button class="category-btn" data-category="Snacks" type="button">

              Snacks
            </button>
            <button class="category-btn" data-category="Beverages" type="button">

              Beverages
            </button>
          </div>
        </div>
      </section>

      <!-- Welcome User Info Section -->
      <asp:Panel ID="pnlUserInfo" runat="server" CssClass="welcome-user" Visible="false">

        <div class="user-meta">
          <h3>
            <span data-i18n="welcome">Welcome</span>

          </h3>

          <div class="meta-row-container" style="display: flex; justify-content: space-around;">
            <p class="meta-row">
              <i class="fa-solid fa-user" aria-hidden="true"></i>
              <span class="meta-label" data-i18n="email"></span>:
              <asp:Label ID="lblUserName" runat="server" CssClass="user-name" />
            </p>
            <p class="meta-row">
              <i class="fas fa-envelope" aria-hidden="true"></i>
              <span class="meta-label" data-i18n="email"></span>:
              <asp:Label ID="lblUserEmail" runat="server" CssClass="meta-value" />
            </p>

            <p class="meta-row">
              <i class="fas fa-utensils" aria-hidden="true"></i>
              <span class="meta-label" data-i18n="diet"></span>:
              <asp:Label ID="lblDietType" runat="server" CssClass="meta-badge" />
            </p>

            <p class="meta-row">
              <i class="fas fa-user-shield" aria-hidden="true"></i>
              <span class="meta-label" data-i18n="usertype"></span>:
              <asp:Label ID="lblUserType" runat="server" CssClass="meta-badge role-badge" />
            </p>
          </div>

        </div>
      </asp:Panel>

      <!-- Featured Products -->
      <section id="featured" class="featured-section">
        <div class="container">
          <h2 class="section-title">Quick Meals</h2>
          <div class="featured-products" id="featured-products">
            <!-- Products will be inserted here by JavaScript -->
          </div>
        </div>
      </section>

      <!-- Quick Recipes -->
      <section id="recipes" class="recipes-section">
        <div class="container">
          <button class="recipes-toggle" id="recipes-toggle" type="button">
            <i class="fas fa-utensils"></i>
            Quick Recipes
            <i class="fas fa-chevron-down" id="recipes-chevron"></i>
          </button>

          <div class="recipes-content" id="recipes-content">
            <div class="recipes-grid" id="recipes-grid">
              <!-- Recipes will be inserted here by JavaScript -->
            </div>
          </div>
        </div>
      </section>

      <!-- All Products Grid -->
      <section class="products-section">
        <div class="container">
          <h2 class="section-title" id="products-title">All Products</h2>
          <div class="products-grid" id="products-grid">
            <!-- Products will be inserted here by JavaScript -->
          </div>
          <div class="no-products" id="no-products" style="display: none;">
            <p>No products found in this category.</p>
          </div>
        </div>
      </section>

      <!-- Weekly Meal Plans -->
      <section id="meal-plans" class="meal-plans-section">
        <div class="container">
          <div class="section-header">
            <h2 class="section-title">
              <i class="fas fa-calendar-alt"></i>
              Meal Plans
            </h2>
            <p class="section-subtitle">
              Take the guesswork out of meal planning with our curated weekly plans designed for every lifestyle
            </p>
          </div>

          <div class="meal-plans-grid" id="meal-plans-grid">
            <!-- Meal plans will be inserted here by JavaScript -->
          </div>


        </div>
      </section>
    </main>

    <!-- Floating Cart -->
    <button id="floating-cart" class="floating-cart" type="button">
      <i class="fas fa-shopping-cart"></i>
      <span id="floating-cart-count" class="floating-cart-count">0</span>
    </button>

    <!-- Cart Modal -->
    <div id="cart-modal" class="cart-modal">
      <div class="cart-modal-content">
        <div class="cart-header">
          <h3 class="cart-title">
            <i class="fas fa-shopping-bag"></i>
            Your Cart
            <span class="cart-badge" id="cart-items-count">0 items</span>
          </h3>
          <button class="cart-close" id="cart-close" type="button">
            <i class="fas fa-times"></i>
          </button>
        </div>

        <div class="cart-body" id="cart-body">
          <div class="cart-empty" id="cart-empty">
            <i class="fas fa-shopping-bag"></i>
            <p>Your cart is empty</p>
            <small>Add some delicious items to get started! 🛒</small>
          </div>

          <div class="cart-items" id="cart-items">
            <!-- Cart items will be inserted here by JavaScript -->
          </div>
        </div>

        <div class="cart-footer" id="cart-footer">
          <div class="cart-total">
            <span class="total-label">Total:</span>
            <span class="total-price" id="total-price">R0.00</span>
          </div>

          <div class="cart-actions">
            <button class="btn btn-outline btn-clear" id="clear-cart" type="button">Clear Cart</button>
            <button class="btn btn-primary btn-checkout" id="Checkout" type="button">Checkout</button>
          </div>
        </div>
      </div>
    </div>


    <!-- Nutrition Modal -->
    <div id="nutrition-modal" class="nutrition-modal">
      <div class="nutrition-modal-content">
        <div class="nutrition-header">
          <h3 class="nutrition-title">Nutritional Information</h3>
          <button class="nutrition-close" id="nutrition-close" type="button">
            <i class="fas fa-times"></i>
          </button>
        </div>

        <div class="nutrition-body" id="nutrition-body">
          <!-- Nutrition info will be inserted here by JavaScript -->
        </div>

        <div class="nutrition-footer">
          <button class="btn btn-primary" id="add-to-cart-nutrition" type="button">
            <i class="fas fa-plus"></i>
            Add to Cart
          </button>
          <button class="btn btn-outline" id="back-to-product" type="button">Back to Product</button>
        </div>
      </div>
    </div>

    <!-- Recipe Instructions Modal (matches nutrition modal style) -->
    <div id="recipe-instructions-modal" class="nutrition-modal">
      <div class="nutrition-modal-content">
        <div class="nutrition-header">
          <h3 class="nutrition-title" id="recipe-instructions-title">Recipe Instructions</h3>
          <button class="nutrition-close" id="recipe-instructions-close" type="button">
            <i class="fas fa-times"></i>
          </button>
        </div>
        <div class="nutrition-body" id="recipe-instructions-body">
          <!-- Recipe instructions will be inserted here by JavaScript -->
        </div>
      </div>
    </div>

    <!-- JavaScript -->
    <script src="js/shoppingScript.js"></script>
    </body>

    </html>
  </asp:Content>