<%@ Page Title="" Language="C#" MasterPageFile="~/Daily Deli Master Page.Master" AutoEventWireup="true"
    CodeBehind="Add_Products.aspx.cs" Inherits="Daily_Deli_E_Commerce.Add_Products" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <title>Add Product - Daily Deli</title>
        <style>
            .admin-wrap {
                background: #e0e0e0;
                /* light grey background */
                padding: 32px 0;
                display: flex;
                justify-content: center;
                /* center horizontally */
            }

            .admin-wrap .container {
                /* <-- let the container be wider */
                max-width: 1280px;
                /* set your desired cap */
                width: 100%;
            }

            .admin-wrap .row {
                /* optional: keep content centered */
                justify-content: center;
            }


            .card {
                background: rgba(255, 255, 255, .95);
                backdrop-filter: blur(6px);
                border: 1px solid rgba(0, 0, 0, .08);
                border-radius: 16px;
                padding: 24px;
                color: #000;
                width: 100%;
                /* <-- fill available space */
                max-width: 800px;
                /* <-- your target width */
                margin: 0 auto;
                /* center within container */
            }

            .card h3 {
                font-weight: 700;
                margin-bottom: 18px;
            }

            .form-label {
                color: #333;
                margin-bottom: 6px;
                display: block;
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
                background: #0077cc;
                color: #fff;
            }

            .btn-edit {
                background: #0077cc;
                color: #fff;
                box-shadow: 0 6px 14px rgba(91, 141, 239, .25);
            }


            .form-control {
                width: 100%;
                background: #fff;
                border: 1px solid #ccc;
                color: #000;
                border-radius: 12px;
                padding: 12px 14px;
            }

            .form-control:focus {
                outline: none;
                border-color: #ff4b4b;
            }

            .site-btn {
                background: #0077cc;
                border: none;
                color: #fff;
                border-radius: 12px;
                padding: 12px 22px;
                cursor: pointer;
            }

            .site-btn.secondary {
                background: #0077cc;
            }

            .grid-2 {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 16px;
            }

            .mt-3 {
                margin-top: 16px;
            }

            .mt-4 {
                margin-top: 24px;
            }

            .msg {
                margin-top: 14px;
            }

            .preview {
                margin-top: 10px;
                border-radius: 12px;
                max-height: 180px;
            }

            .text-white {
                color: #000 !important;
            }
        </style>
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <section class="admin-wrap">

            <div class="container">
                <div class="row">

                    <div class="card">
                        <h1 class="text-white text-center">Add Product</h1>
                        <br />
                        <br />
                        <label class="form-label">Product Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>

                        <div class="grid-2 mt-3">
                            <div>
                                <label class="form-label">Price (R)</label>
                                <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>

                        </br>

                        <label class="form-label">Category</label>
                        <asp:DropDownList ID="CategoryList" runat="server" CssClass="form-control">
                            <asp:ListItem Text="-- Select Category --" Value="" />
                            <asp:ListItem Text="Vegetables" Value="1" />
                            <asp:ListItem Text="Fruits" Value="2" />
                            <asp:ListItem Text="Bakery" Value="3" />
                            <asp:ListItem Text="Dairy" Value="4" />
                            <asp:ListItem Text="Snacks" Value="5" />
                            <asp:ListItem Text="Beverages" Value="6" />
                            <asp:ListItem Text="Quick" Value="7" />
                        </asp:DropDownList>

                        <div class="grid-2 mt-3">
                            <div>
                                <label class="form-label">Stock Quantity</label>
                                <asp:TextBox ID="txtStock" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div>
                                <label class="form-label">Active</label>
                                <asp:CheckBox ID="chkActive" runat="server" Checked="true" />
                            </div>
                            <div>
                                <label class="form-label">Is it common</label>
                                <asp:CheckBox ID="ChkCommon" runat="server" Checked="true" />
                            </div>
                        </div>

                        <label class="form-label mt-3">Short Description</label>
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine"
                            Rows="3"></asp:TextBox>

                        <label class="form-label mt-3">Link of an Image(Optional)</label>
                        <asp:TextBox ID="Imageurl" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3">
                        </asp:TextBox>

                        <label class="form-label mt-3">Image(Optional)</label>
                        <asp:FileUpload ID="fuImage" runat="server" CssClass="form-control" />
                        <asp:Image ID="imgPreview" runat="server" Visible="false" CssClass="preview" />

                        <div class="mt-4">
                            <asp:Button ID="btnSave" runat="server" Text="Save Product" CssClass="site-btn"
                                OnClick="btnSave_Click" />

                            <!-- Add to Cart for quick testing: merges this product into the current user's cart -->
                            <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" CssClass="site-btn"
                                OnClick="btnAddToCart_Click" />

                            <asp:Button ID="btnAdminPage" runat="server" CssClass="btn btn-edit" Text="Back to home"
                                OnClick="btnAdmin_Page" />

                        </div>
                    </div>
                </div>
            </div>

        </section>



    </asp:Content>