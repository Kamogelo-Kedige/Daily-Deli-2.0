<%@ Page Title="" Language="C#" MasterPageFile="~/Daily Deli Master Page.Master" AutoEventWireup="true" CodeBehind="Edit_Products.aspx.cs" Inherits="Daily_Deli_E_Commerce.Edit_Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Bootstrap JS for tooltips -->
    <!-- Bootstrap JS (for tooltips) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" defer></script>

    <style>
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
            box-shadow: 0 6px 14px rgba(91,141,239,.25);
        }
    </style>
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="container py-4">
            <div class="d-flex align-items-center justify-content-between mb-3 flex-wrap gap-2">
                <h3 class="m-0">Products</h3>
                <asp:Panel runat="server" CssClass="d-flex gap-2 w-100 w-sm-auto" DefaultButton="btnSearch">
                    <asp:TextBox ID="txtSearch" runat="server" ClientIDMode="Static"
                        CssClass="form-control" placeholder="Search products" />
                    <asp:Button ID="btnSearch" runat="server" Text="Search"
                        CssClass="btn btn-outline-secondary"
                        OnClientClick="__doPostBack('<%= txtSearch.UniqueID %>','');" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnAdmin" runat="server" ClientIDMode="Static"
                        CssClass="btn btn-edit" Text="Back to Home"
                         OnClick="btnAdmin_Click" />
                </asp:Panel>
            </div>


            <div class="row g-4">
                <!-- LEFT: keep card and layout, swap dummy table for GridView -->
                <div class="col-lg-7">
                    <div class="card shadow-sm h-100">
                        <div class="card-body d-flex flex-column">

                            <asp:SqlDataSource ID="dsProducts" runat="server"
                                ConnectionString="<%$ ConnectionStrings:DailyDeliDatabaseConnectionString %>"
                                CancelSelectOnNullParameter="False"
                                SelectCommand="
    SELECT Id, name, description, price, stockQuantity, unit, categoryId, imageURL, isActive, isCommon, createdAt
    FROM dbo.[Product]
    WHERE ISNULL(@q,'') = ''
       OR (Id = TRY_CAST(@q AS INT))
       OR (name LIKE '%' + @q + '%')">
                                <selectparameters>
                                    <asp:ControlParameter ControlID="txtSearch"
                                        Name="q"
                                        PropertyName="Text"
                                        Type="String"
                                        DefaultValue=""
                                        ConvertEmptyStringToNull="false" />
                                </selectparameters>
                            </asp:SqlDataSource>


                            <div class="table-responsive">
                                <!-- Your GridView (styled like before) -->
                                <asp:GridView ID="gvProducts" runat="server" DataSourceID="dsProducts"
                                    AutoGenerateColumns="False" AllowPaging="True" PageSize="20" AllowSorting="True"
                                    CssClass="table table-striped align-middle" DataKeyNames="Id">
                                    <columns>
                                        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="true" SortExpression="Id" InsertVisible="False" />
                                        <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
                                        <asp:BoundField DataField="price" HeaderText="price" SortExpression="price" ItemStyle-HorizontalAlign="Right" />
                                        <asp:BoundField DataField="stockQuantity" HeaderText="stockQuantity" SortExpression="stockQuantity" />
                                        <asp:BoundField DataField="unit" HeaderText="unit" SortExpression="unit" />
                                       
                                        <asp:CheckBoxField DataField="isActive" HeaderText="isActive" SortExpression="isActive" />
                                        <asp:CheckBoxField DataField="isCommon" HeaderText="isCommon" SortExpression="isCommon" />
                                   
                                    </columns>
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
                                <asp:Label runat="server" AssociatedControlID="pname" CssClass="form-label">Name</asp:Label>
                                <asp:TextBox ID="pname" runat="server" ClientIDMode="Static"
                                    CssClass="form-control" />
                                <div class="invalid-feedback">Name is required.</div>
                            </div>

                            <div class="mb-2">
                                <asp:Label runat="server" AssociatedControlID="pdesc" CssClass="form-label">Description</asp:Label>
                                <asp:TextBox ID="pdesc" runat="server" ClientIDMode="Static"
                                    CssClass="form-control" TextMode="MultiLine" Rows="3"  />
                                <div class="invalid-feedback">Description is required.</div>
                            </div>

                            <div class="row g-2 mb-2">
                                <div class="col-6">
                                    <asp:Label runat="server" AssociatedControlID="pprice" CssClass="form-label">Price</asp:Label>
                                    <asp:TextBox ID="pprice" runat="server" ClientIDMode="Static"
                                        CssClass="form-control" TextMode="Number"
                                        step="0.01" min="0"  />
                                    <div class="invalid-feedback">Price must be a valid number ≥ 0.</div>
                                </div>
                                <div class="col-6">
                                    <asp:Label runat="server" AssociatedControlID="pstock" CssClass="form-label">Stock Quantity</asp:Label>
                                    <asp:TextBox ID="pstock" runat="server" ClientIDMode="Static"
                                        CssClass="form-control" TextMode="Number"
                                        step="1" min="0"  />
                                    <div class="invalid-feedback">Stock must be a whole number ≥ 0.</div>
                                </div>
                            </div>

                            <div class="row g-2 mb-2">
                                <div class="col-6">
                                    <asp:Label runat="server" AssociatedControlID="punit" CssClass="form-label">Unit</asp:Label>
                                    <asp:TextBox ID="punit" runat="server" ClientIDMode="Static"
                                        CssClass="form-control"  />
                                    <div class="invalid-feedback">Unit is required.</div>
                                </div>
                                <div class="col-6">
                                    <asp:Label runat="server" AssociatedControlID="pcat" CssClass="form-label">Category</asp:Label>
                                    <asp:DropDownList ID="pcat" runat="server" ClientIDMode="Static"
                                        CssClass="form-select" >
                                        <asp:ListItem Text="-- Select Category --" Value="" />
                                        <asp:ListItem Text="Vegetables" Value="1" />
                                        <asp:ListItem Text="Fruits" Value="2" />
                                        <asp:ListItem Text="Bakery" Value="3" />
                                        <asp:ListItem Text="Dairy" Value="4" />
                                        <asp:ListItem Text="Snacks" Value="5" />
                                        <asp:ListItem Text="Beverages" Value="6" />
                                        <asp:ListItem Text="Quick" Value="7" />
                                    </asp:DropDownList>
                                    <div class="invalid-feedback">Category is required.</div>
                                </div>
                            </div>

                            <div class="mb-2">
                                <asp:Label runat="server" AssociatedControlID="pimage" CssClass="form-label">Image URL/File</asp:Label>
                                <asp:TextBox ID="pimage" runat="server" ClientIDMode="Static"
                                    CssClass="form-control" />
                            </div>

                            <div class="mb-3">
                                <asp:Label runat="server"  CssClass="form-label">Upload Image</asp:Label> <br>
                                <asp:FileUpload runat="server"></asp:FileUpload>
                            </div>


                            <div class="row g-2 mb-3 align-items-center">
                                <div class="col-6 form-check">
                                    <asp:CheckBox ID="pactive" runat="server" ClientIDMode="Static" CssClass="form-check-input" />
                                    <asp:Label runat="server" CssClass="form-check-label">Is Active</asp:Label>
                                </div>
                                <div class="col-6 form-check">
                                    <asp:CheckBox ID="pcommon" runat="server" ClientIDMode="Static" CssClass="form-check-input" />
                                    <asp:Label runat="server" CssClass="form-check-label">Is Common</asp:Label>
                                </div>
                            </div>

                       
                            <div class="d-flex gap-2 mb-3">
                                <asp:Button ID="btnSave" runat="server" ClientIDMode="Static"
                                    CssClass="btn btn-success" Text="Save"
                                    OnClientClick="return false;" />
                                <asp:Button ID="btnReset" runat="server" ClientIDMode="Static"
                                    CssClass="btn btn-outline-secondary" Text="Reset"
                                    OnClientClick="return false;" />
                            </div>

                            <div class="d-flex align-items-center gap-3">
                                <asp:Image ID="imgPreview" runat="server" ClientIDMode="Static"
                                    CssClass="rounded border d-none"
                                    Style="width: 72px; height: 72px; object-fit: cover"
                                    AlternateText="" />
                                <span id="imgHint" class="text-muted small">Add an image URL to preview.</span>
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

                .gv-enhanced.table { /* keep stripes, add hover */
                    --bs-table-striped-bg: rgba(0,0,0,.025);
                }

                .gv-enhanced.table-hover tbody tr:hover {
                    background-color: rgba(0,0,0,.035);
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
            .gv-enhanced.table-sm > :not(caption) > * > * {
                padding: .45rem .6rem;
            }

            .gv-enhanced th, .gv-enhanced td {
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
            .gv-pager a, .gv-pager span {
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
    </script >



</asp:Content>
