<%@ Page Title="" Language="C#" MasterPageFile="~/Daily Deli Master Page.Master" AutoEventWireup="true"
    CodeBehind="ChechOut.aspx.cs" Inherits="Daily_Deli_E_Commerce.ChechOut" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
        <title>Checkout - Daily Deli</title>

        <style>
            /* Add spacing to form labels and inputs */


            .logo h1 {
                margin: 0;
                font-size: 1.5rem !important;
                text-transform: none;
                font-weight: 700 !important;
            }

            :root {
                --primary: #0077cc;
                --secondary: #0077ccs;
                --accent: #0077cc;
                --light: #ffffff;
                --light-bg: #f8faff;
                --border: #e0e5f3;
                --text: #2d3748;
                --text-light: #718096;
                --success: #2ecc71;
                --glow: 0 5px 15px rgba(74, 108, 247, 0.1);
                --transition: 0.3s ease;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: "Poppins", "Inter", sans-serif;
            }

            body {
                background: var(--light-bg);
                color: var(--text);
                font-size: 14px;
            }

            .custom-continue-btn {
                padding: 0.5rem 1rem;
                border: none;
                border-radius: 0.25rem;
                background: var(--accent-color);
                color: #fff;
                cursor: pointer;
                transition: background var(--transition);
            }

            /* PROGRESS BAR */
            .progress {
                --dot: 28px;
                --line: 3px;
                display: flex;
                justify-content: center;
                align-items: flex-start;
                gap: 180px;
                position: relative;
                margin: 40px auto;
                width: 100%;
                height: 150px;
            }

            .progress::before {
                content: "";
                position: absolute;
                left: calc(var(--dot) / 2);
                right: calc(var(--dot) / 2);
                top: calc(var(--dot) / 2 - var(--line) / 2);
                height: var(--line);
                background: linear-gradient(to right, var(--primary), var(--accent));
                z-index: 0;
            }

            .progress div {
                display: flex;
                flex-direction: column;
                align-items: center;
                position: relative;
                z-index: 1;
            }

            .progress span.circle {
                width: var(--dot);
                height: var(--dot);
                border-radius: 50%;
                border: 2px solid var(--primary);
                display: inline-block;
                margin-bottom: 12px;
                background: var(--light);
                transition: all 0.5s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                color: var(--primary);
                font-size: 12px;
            }

            .progress .active span.circle {
                background: var(--primary);
                border-color: var(--primary);
                color: white;
                box-shadow: 0 0 15px rgba(74, 108, 247, 0.3);
            }

            .progress div span.label {
                color: var(--text);
                font-weight: 500;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            /* MAIN LAYOUT */
            .checkout-container {
                display: flex;
                justify-content: space-between;
                max-width: 1200px;
                margin: 30px auto;
                gap: 40px;
                padding: 0 20px;
            }

            /* LEFT FORM */
            .checkout-form {
                flex: 2;
                background: var(--light);
                border-radius: 15px;
                padding: 25px;
                box-shadow: var(--glow);
                border: 1px solid var(--border);
            }

            .checkout-form h2 {
                font-size: 18px;
                font-weight: 600;
                margin: 20px 0 15px;
                color: var(--primary);
                text-transform: uppercase;
                letter-spacing: 1px;
                border-bottom: 1px solid var(--border);
                padding-bottom: 8px;
            }

            .checkout-form input,
            .checkout-form select {
                width: 100%;
                padding: 14px;
                margin-bottom: 18px;
                border: 1px solid var(--border);
                border-radius: 8px;
                font-size: 15px;
                background: var(--light);
                color: var(--text);
                transition: all 0.3s ease;
            }

            .checkout-form input:focus,
            .checkout-form select:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 10px rgba(74, 108, 247, 0.1);
            }

            .checkout-form .two-col {
                display: flex;
                gap: 15px;
            }

            .checkout-form button {
                background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
                color: var(--light);
                border: none;
                padding: 15px 35px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                margin-top: 15px;
                border-radius: 8px;
                transition: all 0.3s ease;
                letter-spacing: 1px;
                text-transform: uppercase;
                box-shadow: 0 5px 15px rgba(74, 108, 247, 0.2);
            }

            .checkout-form button:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 20px rgba(74, 108, 247, 0.3);
            }

            /* RIGHT CART */
            .checkout-cart {
                flex: 1.7;
                background: var(--light);
                border-radius: 15px;
                padding: 25px;
                box-shadow: var(--glow);
                border: 1px solid var(--border);
            }

            h1 {
                color: var(--primary);
                font-weight: 700;
                letter-spacing: 1px;
                text-transform: uppercase;
                margin-bottom: 20px;
            }

            .cart-item {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
                padding: 15px;
                background: var(--light-bg);
                border-radius: 10px;
                border: 1px solid var(--border);
                transition: all 0.3s ease;
            }

            .cart-item:hover {
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            }

            .cart-item img {
                width: 110px;
                margin-right: 15px;
                border-radius: 8px;
                border: 2px solid var(--border);
            }

            .cart-item p {
                margin: 0;
                font-size: 16px;
                font-weight: 600;
                color: var(--text);
            }

            .cart-item .price {
                margin-left: auto;
                font-weight: bold;
                color: var(--primary);
                font-size: 16px;
            }

            .discount {
                display: flex;
                gap: 10px;
                margin: 20px 0;
            }

            .discount input {
                flex: 1;
                padding: 12px;
                border: 1px solid var(--border);
                border-radius: 8px;
                background: var(--light);
                color: var(--text);
            }

            .discount button {
                background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
                color: var(--light);
                padding: 12px 20px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .discount button:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(74, 108, 247, 0.2);
            }

            .totals {
                border-top: 1px solid var(--border);
                padding-top: 15px;
            }

            .totals p {
                display: flex;
                justify-content: space-between;
                margin: 12px 0;
                font-size: 16px;
            }

            .totals .total {
                font-weight: bold;
                font-size: 20px;
                color: var(--primary);
            }

            #total-items {
                text-align: center;
                margin-bottom: 15px;
                padding: 12px;
                background: rgba(74, 108, 247, 0.1);
                border-radius: 8px;
                border: 1px solid var(--primary);
                color: var(--text);
            }

            /* PAYMENT PANEL STYLES - LIGHT VERSION */
            .payment-panel {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%) scale(0.9);
                width: 450px;
                background: var(--light);
                padding: 30px;
                border-radius: 20px;
                box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15), 0 0 0 100vmax rgba(255, 255, 255, 0.9);
                z-index: 1000;
                animation: panelAppear 0.5s forwards;
                border: 1px solid var(--border);
                overflow: hidden;
            }

            .payment-panel::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: linear-gradient(45deg, transparent, rgba(74, 108, 247, 0.05), transparent);
                transform: rotate(45deg);
                animation: shine 3s infinite;
                z-index: -1;
            }

            @keyframes panelAppear {
                0% {
                    opacity: 0;
                    transform: translate(-50%, -50%) scale(0.8);
                }

                100% {
                    opacity: 1;
                    transform: translate(-50%, -50%) scale(1);
                }
            }

            @keyframes shine {
                0% {
                    left: -50%;
                }

                100% {
                    left: 150%;
                }
            }

            .payment-panel.active {
                display: block;
            }

            .payment-panel h2 {
                font-size: 24px;
                color: var(--primary);
                margin-bottom: 25px;
                text-align: center;
                text-transform: uppercase;
                letter-spacing: 1px;
                font-weight: 700;
            }

            .payment-input-container {
                position: relative;
                margin-bottom: 20px;
            }

            .payment-panel input {
                width: 100%;
                padding: 15px 15px 15px 45px;
                border: 1px solid var(--border);
                border-radius: 10px;
                font-size: 16px;
                background: var(--light);
                color: var(--text);
                transition: all 0.3s ease;
            }

            .payment-panel input:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 15px rgba(74, 108, 247, 0.1);
            }

            .payment-input-container i {
                position: absolute;
                left: 15px;
                top: 50%;
                transform: translateY(-50%);
                color: var(--primary);
                font-size: 18px;
            }

            .payment-row {
                display: flex;
                gap: 15px;
            }

            .payment-panel button {
                width: 100%;
                padding: 16px;
                background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
                color: var(--light);
                border: none;
                border-radius: 10px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                letter-spacing: 1px;
                text-transform: uppercase;
                margin-top: 10px;
                box-shadow: 0 5px 15px rgba(74, 108, 247, 0.2);
            }

            .payment-panel button:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 20px rgba(74, 108, 247, 0.3);
            }

            .payment-panel .close-btn {
                position: absolute;
                top: 15px;
                right: 15px;
                font-size: 24px;
                color: var(--text-light);
                cursor: pointer;
                transition: all 0.3s ease;
                width: 30px;
                height: 30px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
            }

            .payment-panel .close-btn:hover {
                color: var(--primary);
                background: var(--light-bg);
                transform: rotate(90deg);
            }

            .payment-methods {
                display: flex;
                justify-content: center;
                gap: 15px;
                margin: 20px 0;
            }

            .payment-method {
                width: 60px;
                height: 40px;
                border: 1px solid var(--border);
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                transition: all 0.3s ease;
                background: var(--light);
            }

            .payment-method:hover {
                border-color: var(--primary);
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(74, 108, 247, 0.1);
            }

            .payment-method.active {
                border-color: var(--primary);
                background: rgba(74, 108, 247, 0.1);
                box-shadow: 0 0 15px rgba(74, 108, 247, 0.1);
            }

            .secure-notice {
                text-align: center;
                margin-top: 15px;
                font-size: 14px;
                color: var(--text-light);
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 5px;
            }

            /* Card flip animation */
            .card-container {
                perspective: 1000px;
                width: 100%;
                height: 180px;
                margin-bottom: 25px;
                cursor: pointer;
            }

            .card-inner {
                position: relative;
                width: 100%;
                height: 100%;
                transition: transform 0.8s;
                transform-style: preserve-3d;
            }

            .card-container.flipped .card-inner {
                transform: rotateY(180deg);
            }

            .card-front,
            .card-back {
                position: absolute;
                width: 100%;
                height: 100%;
                backface-visibility: hidden;
                border-radius: 15px;
                padding: 20px;
                background: linear-gradient(45deg, #f7f9ff 0%, #eef2ff 100%);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05);
                border: 1px solid var(--border);
            }

            .card-back {
                transform: rotateY(180deg);
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            .card-strip {
                height: 40px;
                background: var(--text-light);
                margin: 20px -20px;
                opacity: 0.7;
            }

            .card-cvv {
                background: var(--light);
                color: var(--text);
                padding: 5px 10px;
                border-radius: 4px;
                align-self: flex-end;
                width: 60px;
                text-align: right;
                border: 1px solid var(--border);
            }

            .card-chip {
                width: 50px;
                height: 40px;
                background: linear-gradient(45deg, #e5e7eb 0%, #d1d5db 100%);
                border-radius: 8px;
                margin-bottom: 20px;
            }

            .card-number {
                font-size: 18px;
                letter-spacing: 2px;
                margin-bottom: 20px;
                color: var(--text);
                font-weight: 500;
            }

            .card-details {
                display: flex;
                justify-content: space-between;
            }

            .card-label {
                font-size: 10px;
                color: var(--text-light);
                margin-bottom: 5px;
            }

            .card-name,
            .card-expiry {
                font-size: 14px;
                color: var(--text);
                font-weight: 500;
            }

            /* Overlay for the panel */
            .overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(255, 255, 255, 0.9);
                backdrop-filter: blur(5px);
                z-index: 999;
            }

            .overlay.active {
                display: block;
                animation: fadeIn 0.3s forwards;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                }

                to {
                    opacity: 1;
                }
            }

            /* Responsive adjustments */
            @media (max-width: 992px) {
                .checkout-container {
                    flex-direction: column;
                }

                .progress {
                    gap: 100px;
                }
            }

            @media (max-width: 576px) {
                .payment-panel {
                    width: 90%;
                    padding: 20px;
                }

                .progress {
                    gap: 60px;
                }

                .progress span.circle {
                    width: 22px;
                    height: 22px;
                }

                .checkout-form .two-col {
                    flex-direction: column;
                    gap: 0;
                }

                .totals p {
                    font-size: 14px;
                    margin: 10px 10px;
                }

                .totals .grand-total {
                    font-size: 16px;
                    margin: 10px 10px;
                }
            }

            /* Loading Overlay */
            .loading-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(255, 255, 255, 0.8);
                backdrop-filter: blur(5px);
                z-index: 2000;
                align-items: center;
                justify-content: center;
            }

            .loading-overlay.active {
                display: flex;
            }

            .loading-spinner {
                border: 4px solid #f3f3f3;
                border-top: 4px solid var(--primary);
                border-radius: 50%;
                width: 40px;
                height: 40px;
                animation: spin 1s linear infinite;
            }

            .loading-text {
                margin-top: 10px;
                color: var(--text);
                font-size: 16px;
                font-weight: 500;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0deg);
                }

                100% {
                    transform: rotate(360deg);
                }
            }

            /* Invoice styling */
            .invoice-panel {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                width: 600px;
                background: var(--light);
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
                z-index: 1000;
                animation: slideIn 0.3s ease-out;
            }

            .invoice-panel.active {
                display: block;
            }

            #invoice-content {
                background: white;
                padding: 20px;
                border: 1px solid var(--border);
                border-radius: 8px;
                font-size: 14px;
                line-height: 1.5;
            }

            #invoice-content h3 {
                font-size: 18px;
                color: var(--primary);
                margin-bottom: 10px;
            }

            #invoice-content table {
                width: 100%;
                border-collapse: collapse;
            }

            #invoice-content th,
            #invoice-content td {
                border: 1px solid var(--border);
                padding: 12px;
                text-align: left;
            }

            #invoice-content th {
                background: var(--light-bg);
                font-weight: 600;
                color: var(--primary);
            }

            #invoice-content td {
                color: var(--text);
            }

            #invoice-content .total {
                font-weight: bold;
                color: var(--primary);
            }

            #invoice-content .grand-total {
                font-weight: 700;
                color: #e74c3c;
                background: rgba(74, 108, 247, 0.05);
            }

            .overlay.active+.invoice-panel {
                animation: slideIn 0.3s ease-out;
            }

            /* Button pay now styling */
            .pay-now-btn {
                background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
                color: var(--light);
                border: none;
                padding: 15px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                margin-top: 10px;
                border-radius: 8px;
                transition: all 0.3s ease;
                width: 100%;
                box-shadow: 0 5px 15px rgba(74, 108, 247, 0.2);
            }

            .pay-now-btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 20px rgba(74, 108, 247, 0.3);
            }
        </style>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="progress">
            <div class="active"><span class="circle"><i class="fas fa-user"></i></span><span class="label">CUSTOMER
                    INFO</span></div>
            <div class="active"><span class="circle"><i class="fas fa-truck"></i></span><span class="label">SHIPPING
                    METHOD</span></div>
            <div><span class="circle"><i class="fas fa-credit-card"></i></span><span class="label">PAYMENT INFO</span>
            </div>
        </div>

        <div class="checkout-container">
            <!-- LEFT FORM -->
            <div class="checkout-form">
                <h2>CUSTOMER INFO</h2>
                <asp:Label ID="Label1" runat="server" Text="Email:" AssociatedControlID="txtEmail"></asp:Label><br />
                <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" ReadOnly="true"></asp:TextBox>

                <div class="two-col">
                    <div>
                        <asp:Label ID="lblFirstName" runat="server" Text="First Name:"
                            AssociatedControlID="txtFirstName"></asp:Label><br />
                        <asp:TextBox ID="txtFirstName" runat="server" placeholder="First Name" ReadOnly="true">
                        </asp:TextBox>
                    </div>
                    <div>
                        <asp:Label ID="lblLastName" runat="server" Text="Last Name:" AssociatedControlID="txtLastName">
                        </asp:Label><br />
                        <asp:TextBox ID="txtLastName" runat="server" placeholder="Last Name" ReadOnly="true">
                        </asp:TextBox>
                    </div>
                </div>

                <h2>SHIPPING ADDRESS</h2>

                <asp:Label ID="lblPhoneNumber" runat="server" Text="Phone Number:" AssociatedControlID="txtPhoneNumber">
                </asp:Label><br />
                <asp:TextBox ID="txtPhoneNumber" runat="server" placeholder="Phone Number" required></asp:TextBox><br />

                <asp:Label ID="lblAddress" runat="server" Text="Address:" AssociatedControlID="txtAddress"></asp:Label>
                <br />
                <asp:TextBox ID="txtAddress" runat="server" placeholder="Address" required></asp:TextBox><br />

                <asp:Label ID="lblCity" runat="server" Text="City:" AssociatedControlID="txtCity"></asp:Label><br />
                <asp:TextBox ID="txtCity" runat="server" placeholder="City" required></asp:TextBox><br />

                <asp:Label ID="lblPostalCode" runat="server" Text="Postal Code:" AssociatedControlID="txtPostalCode">
                </asp:Label><br />
                <asp:TextBox ID="txtPostalCode" runat="server" placeholder="Postal Code" required></asp:TextBox><br />

                <br />
                <asp:Button ID="btnContinue" runat="server" Text="Continue to Payment"
                    OnClientClick="showPaymentPanel(); return false;" OnClick="btnContinue_Click"
                    CssClass="custom-continue-btn"
                    Style="padding:0.5rem 1rem; border:none; border-radius:0.25rem; background:linear-gradient(135deg, var(--primary, #0077cc) 0%, var(--accent, #0077cc) 100%); color:#fff; cursor:pointer; transition:background 0.3s ease;" />

            </div>

            <!-- RIGHT CART -->
            <div class="checkout-cart">
                <h1>Your Order</h1>
                <hr />
                <!-- Placeholder for dynamic cart items -->
                <div id="dynamic-cart-items">
                    <div class="cart-item">
                        <img src="https://via.placeholder.com/110x110/f8faff/4a6cf7?text=Product" alt="Product"
                            onerror="this.onerror=null;this.src='img/Hero.webp'" />
                        <div style="flex-grow: 1;">
                            <p style="font-size: 16px; font-weight: bold; margin: 0;">Premium Product <span
                                    style="color: #0077cc;">x1</span></p>
                            <p style="color: #555; margin: 2px 0;">R112.16 each (excl. VAT)</p>
                            <p style="color: #555; margin: 2px 0;">VAT (15%): R17.83</p>
                        </div>
                        <span class="price" style="font-weight: bold; color: #000;">R129.99</span>
                    </div>
                    <div class="cart-item">
                        <img src="https://via.placeholder.com/110x110/f8faff/4a6cf7?text=Product" alt="Product"
                            onerror="this.onerror=null;this.src='img/Hero.webp'" />
                        <div style="flex-grow: 1;">
                            <p style="font-size: 16px; font-weight: bold; margin: 0;">Special Item <span
                                    style="color: #0077cc;">x1</span></p>
                            <p style="color: #555; margin: 2px 0;">R78.25 each (excl. VAT)</p>
                            <p style="color: #555; margin: 2px 0;">VAT (15%): R11.74</p>
                        </div>
                        <span class="price" style="font-weight: bold; color: #000;">R89.99</span>
                    </div>
                </div>
                <div class="discount">
                    <input type="text" placeholder="Discount Code" />
                    <button>Apply</button>
                </div>
                <div class="totals">
                    <p><span class="total-label">VAT (15%)</span><span class="total-amount">R29.57</span></p>
                    <p><span class="total-label">Subtotal</span><span class="total-amount">R219.98</span></p>
                    <p><span class="total-label">Shipping Fee</span><span class="total-amount">R60.00</span></p>
                    <p class="grand-total"><span class="total-label">Grand Total</span><span
                            class="total-amount">R279.98</span></p>
                </div>
            </div>
        </div>

        <!-- PAYMENT PANEL -->
        <div class="overlay" id="paymentOverlay"></div>
        <div class="payment-panel" id="paymentPanel">
            <span class="close-btn" onclick="closePaymentPanel()">&times;</span>
            <h2>Secure Payment Gateway</h2>

            <div class="card-container" id="cardContainer">
                <div class="card-inner">
                    <div class="card-front">
                        <div class="card-chip"></div>
                        <div class="card-number" id="cardNumberDisplay">**** **** **** ****</div>
                        <div class="card-details">
                            <div>
                                <div class="card-label">CARD HOLDER</div>
                                <div class="card-name" id="cardNameDisplay">YOUR NAME</div>
                            </div>
                            <div>
                                <div class="card-label">EXPIRES</div>
                                <div class="card-expiry" id="cardExpiryDisplay">MM/YY</div>
                            </div>
                        </div>
                    </div>
                    <div class="card-back">
                        <div class="card-strip"></div>
                        <div class="card-cvv" id="cardCvvDisplay">***</div>
                    </div>
                </div>
            </div>

            <div class="payment-methods">
                <div class="payment-method active"><i class="fab fa-cc-visa"></i></div>
                <div class="payment-method"><i class="fab fa-cc-mastercard"></i></div>
                <div class="payment-method"><i class="fab fa-cc-amex"></i></div>
                <div class="payment-method"><i class="fab fa-cc-paypal"></i></div>
            </div>

            <div class="payment-input-container">
                <i class="fas fa-credit-card"></i>
                <input type="text" placeholder="Card Number" maxlength="19" id="cardNumber"
                    oninput="formatCardNumber(this)" />
            </div>

            <div class="payment-input-container">
                <i class="fas fa-user"></i>
                <input type="text" placeholder="Name on Card" id="cardName"
                    oninput="document.getElementById('cardNameDisplay').textContent = this.value || 'YOUR NAME'" />
            </div>

            <div class="payment-row">
                <div class="payment-input-container" style="flex: 1;">
                    <i class="fas fa-calendar-alt"></i>
                    <input type="text" placeholder="MM/YY" maxlength="5" id="cardExpiry" oninput="formatExpiry(this)"
                        onfocus="flipCard(true)" onblur="flipCard(false)" />
                </div>
                <div class="payment-input-container" style="flex: 1;">
                    <i class="fas fa-lock"></i>
                    <input type="text" placeholder="CVV" maxlength="3" id="cardCvv"
                        oninput="document.getElementById('cardCvvDisplay').textContent = this.value || '***'"
                        onfocus="flipCard(true)" onblur="flipCard(false)" />
                </div>
            </div>

            <asp:Button ID="btnPayNow" runat="server" Text="Pay Now" OnClick="btnPayNow_Click1"
                CssClass="pay-now-btn" />
            <div class="secure-notice">
                <i class="fas fa-shield-alt"></i>Your payment is secured with 256-bit SSL encryption
            </div>
        </div>

        <!-- LOADING OVERLAY FOR PDF GENERATION -->
        <div class="loading-overlay" id="loadingOverlay">
            <div>
                <div class="loading-spinner"></div>
                <div class="loading-text">Generating PDF...</div>
            </div>
        </div>

        <!-- INVOICE PANEL -->
        <div class="overlay" id="invoiceOverlay"></div>
        <div class="invoice-panel" id="invoicePanel">
            <span class="close-btn" onclick="closeInvoicePanel()">&times;</span>
            <h2>Transaction Invoice</h2>
            <div id="invoice-content"></div>
            <button type="button" onclick="downloadInvoice()" class="pay-now-btn"><i class="fas fa-download"></i>
                Download as PDF</button>
        </div>

        <!-- html2pdf bundle included earlier in the head (v0.10.1) -->

        <script>
            // Payment panel functions
            function showPaymentPanel() {
                console.log('Showing payment panel');
                document.getElementById('paymentOverlay').classList.add('active');
                document.getElementById('paymentPanel').classList.add('active');
            }

            function closePaymentPanel() {
                console.log('Closing payment panel');
                document.getElementById('paymentOverlay').classList.remove('active');
                document.getElementById('paymentPanel').classList.remove('active');
            }

            // Card formatting functions
            function formatCardNumber(input) {
                let value = input.value.replace(/\D/g, '');
                let formattedValue = '';
                for (let i = 0; i < value.length; i++) {
                    if (i > 0 && i % 4 === 0) formattedValue += ' ';
                    formattedValue += value[i];
                }
                input.value = formattedValue;
                document.getElementById('cardNumberDisplay').textContent = formattedValue || '**** **** **** ****';
                if (value.length > 16) input.value = input.value.substring(0, 19);
            }

            function formatExpiry(input) {
                let value = input.value.replace(/\D/g, '');
                if (value.length > 2) value = value.substring(0, 2) + '/' + value.substring(2, 4);
                input.value = value;
                document.getElementById('cardExpiryDisplay').textContent = value || 'MM/YY';
                if (value.length > 5) input.value = input.value.substring(0, 5);
            }

            function flipCard(isFlipped) {
                console.log('Flipping card:', isFlipped);
                const cardContainer = document.getElementById('cardContainer');
                if (isFlipped) cardContainer.classList.add('flipped');
                else cardContainer.classList.remove('flipped');
            }

            // Invoice panel functions
            function showInvoicePanel() {
                console.log('Showing invoice panel');
                document.getElementById('invoiceOverlay').classList.add('active');
                document.getElementById('invoicePanel').classList.add('active');
            }

            function closeInvoicePanel() {
                console.log('Closing invoice panel');
                document.getElementById('invoiceOverlay').classList.remove('active');
                document.getElementById('invoicePanel').classList.remove('active');
            }

            function downloadInvoice() {
                const invoiceContent = document.getElementById("invoice-content");
                if (!invoiceContent || !invoiceContent.innerHTML.trim()) {
                    console.error('Invoice content is empty or not available');
                    alert('Error: Invoice content not available for download.');
                    return;
                }

                console.log('Starting PDF generation');

                const rootDiv = invoiceContent.firstElementChild;
                const invoicePanel = document.getElementById('invoicePanel');

                const loadingOverlay = document.getElementById('loadingOverlay');
                loadingOverlay.classList.add('active');

                const originalStyles = {
                    rootMaxHeight: rootDiv.style.maxHeight,
                    rootOverflowY: rootDiv.style.overflowY,
                    contentMaxHeight: invoiceContent.style.maxHeight,
                    contentOverflowY: invoiceContent.style.overflowY,
                    panelWidth: invoicePanel.style.width,
                    panelMaxHeight: invoicePanel.style.maxHeight,
                    panelOverflow: invoicePanel.style.overflow,
                    panelTransform: invoicePanel.style.transform,
                    panelLeft: invoicePanel.style.left,
                    panelTop: invoicePanel.style.top
                };

                rootDiv.style.maxHeight = 'none';
                rootDiv.style.overflowY = 'visible';
                invoiceContent.style.maxHeight = 'none';
                invoiceContent.style.overflowY = 'visible';
                invoicePanel.style.width = '800px';
                invoicePanel.style.maxHeight = 'none';
                invoicePanel.style.overflow = 'visible';
                invoicePanel.style.transform = 'none';
                invoicePanel.style.left = '0';
                invoicePanel.style.top = '0';

                setTimeout(() => {
                    const fullWidth = rootDiv.scrollWidth || 800;
                    const fullHeight = rootDiv.scrollHeight;

                    console.log(`Capturing with width: ${fullWidth}px, height: ${fullHeight}px`);

                    const opt = {
                        margin: [0.5, 0.5, 0.5, 0.5],
                        filename: 'invoice.pdf',
                        image: { type: 'jpeg', quality: 0.98 },
                        html2canvas: {
                            scale: 2,
                            useCORS: true,
                            scrollX: 0,
                            scrollY: 0,
                            windowWidth: fullWidth,
                            windowHeight: fullHeight,
                            x: 0,
                            y: 0
                        },
                        jsPDF: { unit: 'in', format: 'a4', orientation: 'portrait' }
                    };

                    console.log('Generating PDF with html2pdf');
                    html2pdf().set(opt).from(invoiceContent).save().then(() => {
                        console.log('PDF generated successfully');
                        rootDiv.style.maxHeight = originalStyles.rootMaxHeight;
                        rootDiv.style.overflowY = originalStyles.rootOverflowY;
                        invoiceContent.style.maxHeight = originalStyles.contentMaxHeight;
                        invoiceContent.style.overflowY = originalStyles.contentOverflowY;
                        invoicePanel.style.width = originalStyles.panelWidth;
                        invoicePanel.style.maxHeight = originalStyles.panelMaxHeight;
                        invoicePanel.style.overflow = originalStyles.panelOverflow;
                        invoicePanel.style.transform = originalStyles.panelTransform;
                        invoicePanel.style.left = originalStyles.panelLeft;
                        invoicePanel.style.top = originalStyles.panelTop;
                        loadingOverlay.classList.remove('active');
                    }).catch(error => {
                        console.error('PDF generation failed:', error);
                        alert('Failed to generate PDF. Please try again.');
                        rootDiv.style.maxHeight = originalStyles.rootMaxHeight;
                        rootDiv.style.overflowY = originalStyles.rootOverflowY;
                        invoiceContent.style.maxHeight = originalStyles.contentMaxHeight;
                        invoiceContent.style.overflowY = originalStyles.contentOverflowY;
                        invoicePanel.style.width = originalStyles.panelWidth;
                        invoicePanel.style.maxHeight = originalStyles.panelMaxHeight;
                        invoicePanel.style.overflow = originalStyles.panelOverflow;
                        invoicePanel.style.transform = originalStyles.panelTransform;
                        invoicePanel.style.left = originalStyles.panelLeft;
                        invoicePanel.style.top = originalStyles.panelTop;
                        loadingOverlay.classList.remove('active');
                    });
                }, 100);
            }

            document.getElementById('paymentOverlay').addEventListener('click', closePaymentPanel);
            document.getElementById('paymentPanel').addEventListener('click', function (e) { e.stopPropagation(); });
            document.getElementById('invoiceOverlay').addEventListener('click', closeInvoicePanel);
            document.getElementById('invoicePanel').addEventListener('click', function (e) { e.stopPropagation(); });

            document.querySelectorAll('.payment-method').forEach(method => {
                method.addEventListener('click', function () {
                    console.log('Payment method selected');
                    document.querySelectorAll('.payment-method').forEach(m => m.classList.remove('active'));
                    this.classList.add('active');
                });
            });
        </script>
    </asp:Content>