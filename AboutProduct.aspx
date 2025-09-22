<%@ Page Title="" Language="C#" MasterPageFile="~/Daily Deli Master Page.Master" AutoEventWireup="true"
    CodeBehind="AboutProduct.aspx.cs" Inherits="Daily_Deli_E_Commerce.AboutProduct" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <link href="css/bootstrap.min.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="css/StyleSheet.css" />

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <title>About Product - Daily Deli</title>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="container py-5 d-flex justify-content-center align-items-center min-vh-100">
            <div class="row g-4 justify-content-center align-items-center" style="max-width:1100px;width:100%;">
                <div class="col-md-6">
                    <div class="card shadow-lg rounded-4 p-0 h-100 d-flex align-items-center justify-content-center"
                        style="background:var(--card-bg);height:600px;width:100%;position:relative;">
                        <div class="product-image-container w-100 h-100"
                            style="height:560px;width:100%;overflow:hidden;border-radius:1.5rem;" id="ProductImage"
                            runat="server">

                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card shadow rounded-4 p-4 h-100 d-flex flex-column justify-content-center"
                        style="background:var(--card-bg);">

                        <div id="ProductDescription" runat="server">

                        </div>
                        <div class="d-flex flex-column gap-3 mt-3">
                            <asp:Button ID="AddToCartBtn" runat="server" ClientIDMode="Static"
                                CssClass="btn btn-primary w-100" Text="Add to Cart" UseSubmitBehavior="false" />
                            <asp:Button ID="BackBtn" runat="server" ClientIDMode="Static"
                                CssClass="btn btn-outline-primary w-100" Text="← Back" UseSubmitBehavior="false"
                                OnClientClick="window.location.href='Shop.aspx'; return false;" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <style>
            :root {
                --card-bg: #fff;
                --brand-color: #333;
                --accent-color: #0077cc;
            }

            .card {
                background: var(--card-bg);
                box-shadow: 0 4px 16px rgba(0, 0, 0, 0.18);
                border-radius: 1.5rem;
            }

            .btn-primary {
                background: var(--accent-color);
                border: none;
                color: #fff;
                font-weight: 600;
                border-radius: 0.75rem;
                transition: background 0.2s;
            }

            .btn-primary:hover {
                background: #005fa3;
            }

            .btn-outline-primary {
                border: 2px solid var(--accent-color);
                color: var(--accent-color);
                background: none;
                font-weight: 600;
                border-radius: 0.75rem;
                transition: background 0.2s, color 0.2s;
            }

            .btn-outline-primary:hover {
                background: var(--accent-color);
                color: #fff;
            }

            .product-image-container img {
                object-fit: cover;
                border-radius: 1.5rem;
                max-height: 560px;
                max-width: 100%;
            }

            .product-category {
                position: absolute;
                top: 16px;
                right: 16px;
                background: rgba(255, 255, 255, 0.65);
                color: var(--accent-color);
                padding: 4px 16px;
                border-radius: 8px;
                font-size: 0.9rem;
                font-weight: 600;
                backdrop-filter: blur(8px);
                text-transform: capitalize;
            }

            .product-name {
                color: var(--brand-color);
            }

            .product-price {
                color: var(--accent-color);
            }

            .product-unit {
                font-size: 1rem;
                color: #888;
                margin-left: 8px;
            }

            .product-description {
                color: var(--brand-color);
                font-size: 1.05rem;
            }

            @media (max-width: 1100px) {
                .row.g-4 {
                    flex-direction: column;
                    max-width: 98vw;
                }

                .product-image-container {
                    height: 320px;
                }

                .product-image-container img {
                    max-height: 320px;
                }
            }
        </style>
    </asp:Content>