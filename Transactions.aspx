<%@ Page Title="" Language="C#" MasterPageFile="~/Daily Deli Master Page.Master" AutoEventWireup="true"
    CodeBehind="Transactions.aspx.cs" Inherits="Daily_Deli_E_Commerce.Transactions" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Products</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

        <!-- Bootstrap JS for tooltips -->
        <!-- Bootstrap JS (for tooltips) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" defer></script>

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

            .btn {
                appearance: none;
                border: 0;
                cursor: pointer;
                border-radius: 12px;
                padding: 10px 16px;
                font-weight: 600;
                font-size: .95rem;
                transition: transform .04s ease, box-shadow .2s ease, background .2s ease;
            }

            .btn-edit {
                background: #FF8A00;
                color: #fff;
                box-shadow: 0 6px 14px rgba(91, 141, 239, .25);
            }
        </style>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <div class="container py-4">
            <div class="d-flex align-items-center justify-content-between mb-3 flex-wrap gap-2">
                <h3 class="m-0">Transactions</h3>
                <asp:Panel runat="server" CssClass="d-flex gap-2 w-100 w-sm-auto" DefaultButton="btnSearch">
                    <asp:TextBox ID="txtSearch" runat="server" ClientIDMode="Static" CssClass="form-control"
                        placeholder="Search Transaction by ID" />
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-outline-secondary"
                        OnClientClick="__doPostBack('<%= txtSearch.UniqueID %>','');" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnAdmin" runat="server" ClientIDMode="Static" CssClass="btn btn-edit"
                        Text="Back to Home" OnClick="btnAdmin_Click" />
                </asp:Panel>
            </div>


            <div class="row g-4">
                <!-- LEFT: keep card and layout, swap dummy table for GridView -->
                <div class="col-lg-7">
                    <div class="card shadow-sm h-100">
                        <div class="card-body d-flex flex-column">

                            <asp:SqlDataSource ID="dsTransactions" runat="server"
                                ConnectionString="<%$ ConnectionStrings:DailyDeliDb %>"
                                CancelSelectOnNullParameter="False" SelectCommand="SELECT * FROM [Transaction]">
                            </asp:SqlDataSource>


                            <div class="table-responsive">
                                <asp:GridView ID="gvTransactions" runat="server" DataSourceID="dsTransactions"
                                    AutoGenerateColumns="False" AllowPaging="True" PageSize="20" AllowSorting="True"
                                    CssClass="table table-striped align-middle" DataKeyNames="Id">
                                    <Columns>
                                        <asp:BoundField DataField="Id" HeaderText="ID" SortExpression="Id" />
                                        <asp:BoundField DataField="UserId" HeaderText="User ID"
                                            SortExpression="UserId" />
                                        <asp:BoundField DataField="TransactionDate" HeaderText="Transaction Date"
                                            SortExpression="TransactionDate" />
                                        <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount"
                                            SortExpression="TotalAmount" DataFormatString="R {0:N2}" />
                                        <asp:BoundField DataField="PaymentMethod" HeaderText="Payment Method"
                                            SortExpression="PaymentMethod" />
                                        <asp:BoundField DataField="ShippingFee" HeaderText="Shipping Fee"
                                            SortExpression="ShippingFee" DataFormatString="R {0:N2}" />
                                        <asp:BoundField DataField="TaxAmount" HeaderText="Tax Amount"
                                            SortExpression="TaxAmount" DataFormatString="R {0:N2}" />
                                        <asp:BoundField DataField="InvoiceNumber" HeaderText="Invoice Number"
                                            SortExpression="InvoiceNumber" />
                                    </Columns>

                                </asp:GridView>

                            </div>

                            <!-- (Optional) count text kept for layout parity; now static since JS removed -->
                            <div class="mt-2 small text-muted" id="tblCount"></div>
                        </div>
                    </div>
                </div>

                <!-- RIGHT: untouched editor card (no backend/JS wired) -->
                <div class="col-lg-5">
                    <div class="card shadow-sm h-100">
                        <div class="card-body">
                            <h5 class="mb-3">Edit Product</h5>

                            <asp:HiddenField ID="pid" runat="server" ClientIDMode="Static" />

                            <div class="mb-2">
                                <asp:Label runat="server" AssociatedControlID="userid" CssClass="form-label">User ID
                                </asp:Label>
                                <asp:TextBox ID="userid" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                <div class="invalid-feedback">Name is required.</div>
                            </div>

                            <div class="mb-2">
                                <asp:Label runat="server" AssociatedControlID="date" CssClass="form-label">Transaction
                                    Date</asp:Label>
                                <asp:TextBox ID="date" runat="server" ClientIDMode="Static" CssClass="form-control"
                                    TextMode="MultiLine" Rows="3" />
                                <div class="invalid-feedback">Description is required.</div>
                            </div>

                            <div class="row g-2 mb-2">
                                <div class="col-6">
                                    <asp:Label runat="server" AssociatedControlID="amount" CssClass="form-label">Paid
                                        Amount</asp:Label>
                                    <asp:TextBox ID="amount" runat="server" ClientIDMode="Static"
                                        CssClass="form-control" />
                                    <div class="invalid-feedback">Price must be a valid number ≥ 0.</div>
                                </div>
                                <div class="col-6">
                                    <asp:Label runat="server" AssociatedControlID="method" CssClass="form-label">Payment
                                        Method</asp:Label>
                                    <asp:TextBox ID="method" runat="server" ClientIDMode="Static"
                                        CssClass="form-control" />
                                    <div class="invalid-feedback">Stock must be a whole number ≥ 0.</div>
                                </div>
                            </div>

                            <div class="row g-2 mb-2">
                                <div class="col-6">
                                    <asp:Label runat="server" AssociatedControlID="s_fee" CssClass="form-label">Shipping
                                        Fee</asp:Label>
                                    <asp:TextBox ID="s_fee" runat="server" ClientIDMode="Static"
                                        CssClass="form-control" />
                                    <div class="invalid-feedback">Unit is required.</div>
                                </div>
                                <div class="col-6">
                                    <asp:Label runat="server" AssociatedControlID="t_amount" CssClass="form-label">Tax
                                        Amount</asp:Label>
                                    <asp:TextBox ID="t_amount" runat="server" ClientIDMode="Static"
                                        CssClass="form-control" />
                                    <div class="invalid-feedback">Tax Amount is required.</div>
                                </div>
                            </div>

                            <div class="d-flex gap-2 mb-3">
                                <asp:Button ID="btnSave" runat="server" ClientIDMode="Static" CssClass="btn btn-success"
                                    Text="Save" OnClientClick="return false;" OnClick="btnSave_Click" />
                                <asp:Button ID="btnDelete" runat="server" ClientIDMode="Static"
                                    CssClass="btn btn-success" Text="Delete" OnClick="btnDelete_Click" />
                                <asp:Button ID="btnReset" runat="server" ClientIDMode="Static"
                                    CssClass="btn btn-outline-secondary" Text="Reset" OnClick="btnReset_Click" />
                            </div>

                            <div class="d-flex align-items-center gap-3">
                                <asp:Image ID="imgPreview" runat="server" ClientIDMode="Static"
                                    CssClass="rounded border d-none"
                                    Style="width: 72px; height: 72px; object-fit: cover" AlternateText="" />
                            </div>

                        </div>
                    </div>
                </div>

            </div>
        </div>

        <style>
            /* Compact, clean table look */
            .gv-enhanced {
                font-size: .92rem;
            }

            .gv-enhanced.table {
                /* keep stripes, add hover */
                --bs-table-striped-bg: rgba(0, 0, 0, .025);
            }

            .gv-enhanced.table-hover tbody tr:hover {
                background-color: rgba(0, 0, 0, .035);
            }

            /* Sticky header for large lists */
            .gv-wrap {
                max-height: 68vh;
                overflow: auto;
            }

            .gv-wrap thead th {
                position: sticky;
                top: 0;
                z-index: 2;
                background: var(--bs-body-bg);
                box-shadow: inset 0 -1px 0 var(--bs-border-color);
            }

            /* Make table a bit denser */
            .gv-enhanced.table-sm> :not(caption)>*>* {
                padding: .45rem .6rem;
            }

            .gv-enhanced th,
            .gv-enhanced td {
                vertical-align: middle;
            }

            /* Truncate long text cells gracefully */
            .gv-truncate {
                max-width: 240px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            /* Price prefix (3rd data column) */
            .gv-enhanced td.gv-price::before {
                content: 'R ';
                opacity: .7;
                margin-right: 2px;
            }

            /* Pager polish (works with most GridView pagers) */
            .gv-pager a,
            .gv-pager span {
                display: inline-block;
                padding: .25rem .55rem;
                margin: 0 .15rem;
                border: 1px solid var(--bs-border-color);
                border-radius: .5rem;
                text-decoration: none;
            }

            .gv-pager span {
                background: var(--bs-primary-bg-subtle);
                border-color: var(--bs-primary-border-subtle);
            }

            /* Checkbox badges */
            .bool-badge {
                display: inline-block;
                padding: .25rem .45rem;
                border-radius: .5rem;
                font-size: .8rem;
            }

            .bool-yes {
                background: var(--bs-success-bg-subtle);
                color: var(--bs-success-text);
                border: 1px solid var(--bs-success-border-subtle);
            }

            .bool-no {
                background: var(--bs-secondary-bg);
                color: var(--bs-secondary-color);
                border: 1px solid var(--bs-border-color);
            }
        </style>

        <script defer>
            document.addEventListener('DOMContentLoaded', () => {
                // Find your GridView even with WebForms-generated IDs
                const gv = document.querySelector('table[id$="gvProducts"]');
                if (!gv) return;

                // Ensure it's wrapped for sticky header scrolling
                let wrap = gv.closest('.table-responsive') || gv.parentElement;
                if (wrap) wrap.classList.add('gv-wrap');

                // Enhance table classes
                gv.classList.add('gv-enhanced', 'table-sm', 'table-hover');

                // Add truncate class to likely long columns by header name
                const headerMap = {};
                gv.querySelectorAll('thead th').forEach((th, i) => {
                    const key = th.textContent.trim().toLowerCase();
                    headerMap[key] = i;
                });

                const idxName = headerMap['name'];
                const idxDesc = headerMap['description'];
                const idxImg = headerMap['image url'];
                const idxPrice = headerMap['price'];
                const idxActive = headerMap['active'];
                const idxCommon = headerMap['common'];

                // Loop rows to apply per-cell cosmetics
                gv.querySelectorAll('tbody tr').forEach(tr => {
                    const tds = tr.children;

                    // Truncate long text cells with tooltip
                    [idxName, idxDesc, idxImg].forEach(idx => {
                        if (idx == null || !tds[idx]) return;
                        const td = tds[idx];
                        td.classList.add('gv-truncate');
                        const text = td.textContent.trim();
                        if (text.length > 0) {
                            td.setAttribute('title', text);
                            td.setAttribute('data-bs-toggle', 'tooltip');
                            td.setAttribute('data-bs-placement', 'top');
                        }
                    });

                    // Currency prefix on price
                    if (idxPrice != null && tds[idxPrice]) {
                        tds[idxPrice].classList.add('gv-price', 'text-end');
                    }

                    // Right-align numeric stock if present
                    const idxStock = headerMap['stock'];
                    if (idxStock != null && tds[idxStock]) {
                        tds[idxStock].classList.add('text-end');
                    }

                    // Replace checkbox cells with badges (Active/Common)
                    [idxActive, idxCommon].forEach(idx => {
                        if (idx == null || !tds[idx]) return;
                        const td = tds[idx];
                        const cb = td.querySelector('input[type="checkbox"]');
                        if (!cb) return;
                        const yes = cb.checked;
                        // Hide the raw checkbox to avoid layout jump
                        cb.style.display = 'none';
                        // Insert a badge
                        const span = document.createElement('span');
                        span.className = 'bool-badge ' + (yes ? 'bool-yes' : 'bool-no');
                        span.textContent = yes ? 'Yes' : 'No';
                        td.appendChild(span);
                        td.classList.add('text-center');
                    });
                });

                // Initialize all tooltips inside the grid
                const tooltipTriggerList = [].slice.call(gv.querySelectorAll('[data-bs-toggle="tooltip"]'));
                tooltipTriggerList.forEach(el => new bootstrap.Tooltip(el));

                // Try to style pager row if present
                const pagerRow = gv.querySelector('tr td table, tfoot') || gv.parentElement.querySelector('.pagination');
                if (pagerRow) {
                    // Add a class you can style
                    (pagerRow.closest('table') || pagerRow).classList.add('gv-pager');
                }
            });
        </script>

    </asp:Content>