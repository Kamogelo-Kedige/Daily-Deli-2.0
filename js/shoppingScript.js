// Global State
let cart = [];

// Persistent Cart: AJAX sync to save cart to database
function syncCartToServer() {
  fetch("SyncCart.aspx", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ action: "update", cart: cart }),
  })
    .then((response) => response.json())
    .then((data) => {
      if (data.success) {
        console.log("Cart synced to server");
      } else {
        console.error("Sync failed:", data.error);
      }
    })
    .catch((error) => console.error("Error syncing cart:", error));
}

// Wrap existing functions to sync after changes
if (typeof addToCart === "function") {
  const originalAddToCart = addToCart;
  addToCart = function (product) {
    originalAddToCart(product);
    syncCartToServer();
  };
}
if (typeof removeFromCart === "function") {
  const originalRemoveFromCart = removeFromCart;
  removeFromCart = function (productId) {
    originalRemoveFromCart(productId);
    syncCartToServer();
  };
}
if (typeof updateQuantity === "function") {
  const originalUpdateQuantity = updateQuantity;
  updateQuantity = function (productId, newQuantity) {
    originalUpdateQuantity(productId, newQuantity);
    syncCartToServer();
  };
}
if (typeof clearCart === "function") {
  const originalClearCart = clearCart;
  clearCart = function () {
    originalClearCart();
    syncCartToServer();
  };
}

// Extra DOMContentLoaded block for persistent cart UI update
document.addEventListener("DOMContentLoaded", function () {
  console.log("Cart after load:", cart); // Log to confirm injection
  updateCartUI(); // Re-update UI with loaded cart
  if (typeof initializeApp === "function") {
    initializeApp();
  }
});
let selectedCategory = "all";
let currentProduct = null;

// DOM Elements
const mobileMenuBtn = document.getElementById("mobile-menu-btn");
const mobileNav = document.getElementById("mobile-nav");
const menuIcon = document.getElementById("menu-icon");
const categoryButtons = document.getElementById("category-buttons");
const featuredProducts = document.getElementById("featured-products");
const productsGrid = document.getElementById("products-grid");
const productsTitle = document.getElementById("products-title");
const noProducts = document.getElementById("no-products");
const recipesToggle = document.getElementById("recipes-toggle");
const recipesContent = document.getElementById("recipes-content");
const recipesGrid = document.getElementById("recipes-grid");
const recipesChevron = document.getElementById("recipes-chevron");
const mealPlansGrid = document.getElementById("meal-plans-grid");
const cartBtn = document.getElementById("cart-btn");
const cartCount = document.getElementById("cart-count");
const floatingCart = document.getElementById("floating-cart");
const floatingCartCount = document.getElementById("floating-cart-count");
const cartModal = document.getElementById("cart-modal");
const cartClose = document.getElementById("cart-close");
const cartItemsCount = document.getElementById("cart-items-count");
const cartEmpty = document.getElementById("cart-empty");
const cartItems = document.getElementById("cart-items");
const cartFooter = document.getElementById("cart-footer");
const totalPrice = document.getElementById("total-price");
const clearCartBtn = document.getElementById("clear-cart");
const CheckOutPage = document.getElementById("Checkout");
const nutritionModal = document.getElementById("nutrition-modal");
const nutritionClose = document.getElementById("nutrition-close");
const nutritionBody = document.getElementById("nutrition-body");
const addToCartNutrition = document.getElementById("add-to-cart-nutrition");
const backToProduct = document.getElementById("back-to-product");

// Initialize the app
document.addEventListener("DOMContentLoaded", function () {
  initializeApp();
});

function initializeApp() {
  setupEventListeners();
  renderFeaturedProducts();
  renderProducts();
  renderRecipes();
  renderMealPlans();
  updateCartUI();
}

function setupEventListeners() {
  // Mobile menu toggle
  mobileMenuBtn.addEventListener("click", toggleMobileMenu);

  // Category filter
  categoryButtons.addEventListener("click", handleCategoryChange);

  // Recipes toggle
  recipesToggle.addEventListener("click", toggleRecipes);

  // Cart modal
  cartBtn.addEventListener("click", openCartModal);
  floatingCart.addEventListener("click", openCartModal);
  cartClose.addEventListener("click", closeCartModal);
  cartModal.addEventListener("click", handleCartModalClick);
  clearCartBtn.addEventListener("click", clearCart);
  CheckOutPage.addEventListener("click", checkout);

  // Nutrition modal
  nutritionClose.addEventListener("click", closeNutritionModal);
  nutritionModal.addEventListener("click", handleNutritionModalClick);
  addToCartNutrition.addEventListener("click", addCurrentProductToCart);
  backToProduct.addEventListener("click", closeNutritionModal);

  // Cart items event delegation
  cartItems.addEventListener("click", handleCartItemAction);

  // Navigation links
  document.querySelectorAll('a[href^="#"]').forEach((link) => {
    link.addEventListener("click", handleSmoothScroll);
  });
}

function toggleMobileMenu() {
  const isActive = mobileNav.classList.contains("active");

  if (isActive) {
    mobileNav.classList.remove("active");
    menuIcon.className = "fas fa-bars";
  } else {
    mobileNav.classList.add("active");
    menuIcon.className = "fas fa-times";
  }
}

function handleCategoryChange(e) {
  if (e.target.classList.contains("category-btn")) {
    const category = e.target.dataset.category;

    // Update active button
    document.querySelectorAll(".category-btn").forEach((btn) => {
      btn.classList.remove("active");
    });
    e.target.classList.add("active");

    // Update selected category
    selectedCategory = category;

    // Re-render products
    renderProducts();
  }
}

function toggleRecipes() {
  const isActive = recipesContent.classList.contains("active");

  if (isActive) {
    recipesContent.classList.remove("active");
    recipesChevron.style.transform = "rotate(0deg)";
  } else {
    recipesContent.classList.add("active");
    recipesChevron.style.transform = "rotate(180deg)";
  }
}

function renderFeaturedProducts() {
  const featuredItems = products.filter(
    (product) =>
      product.CategoryName && product.CategoryName.toLowerCase() === "quick"
  );

  featuredProducts.innerHTML = featuredItems
    .map((product) => createProductCard(product, true))
    .join("");

  // Add event listeners to featured products
  featuredProducts.addEventListener("click", handleProductAction);
}

function renderProducts() {
  let filteredProducts;
  if (selectedCategory === "all") {
    // Show all products from API response (already diet-filtered)
    filteredProducts = products;
  } else {
    // Filter by category only
    filteredProducts = products.filter(
      (product) => product.CategoryName === selectedCategory
    );
  }

  // Update title
  productsTitle.textContent =
    selectedCategory === "all"
      ? "All Products"
      : selectedCategory.charAt(0).toUpperCase() + selectedCategory.slice(1);

  if (filteredProducts.length === 0) {
    productsGrid.style.display = "none";
    noProducts.style.display = "block";
  } else {
    productsGrid.style.display = "grid";
    noProducts.style.display = "none";

    productsGrid.innerHTML = filteredProducts
      .map((product) => createProductCard(product, false))
      .join("");

    // Add event listeners to products
    productsGrid.addEventListener("click", handleProductAction);
  }
}

function createProductCard(product, isFeatured = false) {
  return `
        <div class="product-card ${
          isFeatured ? "featured" : ""
        }" data-product-id="${product.Id}">
            <div class="product-image-container">
                <img 
                    src="${product.ImageURL}" 
                    alt="${product.Name}" 
                    class="product-image"
                    onclick="window.location.href='AboutProduct.aspx?id=${
                      product.Id
                    }'"
                >
                <div class="product-category">${product.CategoryName}</div>
            </div>
            
            <div class="product-content">
                <h3 class="product-name">${product.Name}</h3>
                <p class="product-price">
                    R${product.Price.toFixed(2)}
                    ${
                      product.Unit
                        ? `<span class="product-unit">${product.Unit}</span>`
                        : ""
                    }
                </p>
                
                <div class="product-actions">
                    <button class="btn btn-primary" data-action="add-to-cart">
                        <i class="fas fa-shopping-cart"></i>
                        Add to Cart
                    </button>
                    ${
                      product.Calories !== undefined ||
                      product.Fat !== undefined ||
                      product.Protein !== undefined ||
                      product.Carbs !== undefined
                        ? `
                        <button class="btn btn-outline btn-icon" data-action="show-nutrition">
                            <i class="fas fa-info"></i>
                        </button>
                    `
                        : ""
                    }
                </div>
            </div>
        </div>
    `;
}

function handleProductAction(e) {
  e.preventDefault();

  const action =
    e.target.dataset.action ||
    e.target.closest("[data-action]")?.dataset.action;
  const productCard = e.target.closest(".product-card");

  if (!productCard || !action) return;

  const productId = productCard.dataset.productId;
  // Use p.Id for database-fetched products, compare as strings for safety
  let product = products.find((p) => String(p.Id) === String(productId));

  if (!product) return;

  switch (action) {
    case "add-to-cart":
      addToCart(product);
      break;
    case "show-nutrition":
      if (
        product.Calories !== undefined ||
        product.Fat !== undefined ||
        product.Protein !== undefined ||
        product.Carbs !== undefined
      ) {
        showNutritionModal(product);
      }
      break;
  }
}

function renderRecipes() {
  // Recipe images
  const recipeImages = {
    "Fresh Garden Salad":
      "https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=600&q=80",
    "Fruit Smoothie Bowl":
      "https://images.unsplash.com/photo-1627308595228-9d0497edbe74?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE4fHx8ZW58MHx8fHx8",
    "Cheese & Herb Toast":
      "https://images.unsplash.com/photo-1639150362147-00e4cee6b3f5?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGNoZWVzZSUyMGFuZCUyMGhlcmIlMjB0b2FzdHxlbnwwfHwwfHx8MA%3D%3D",
  };

  recipesGrid.innerHTML = quickRecipes
    .map(
      (recipe) => `
        <div class="recipe-card">
          <div class="recipe-image-container" style="width:100%;height:180px;overflow:hidden;border-top-left-radius:1rem;border-top-right-radius:1rem;">
            <img src="${recipe.ImageURL}" alt="${
        recipe.Name
      }" style="width:100%;height:100%;object-fit:cover;display:block;">
          </div>
          <div class="recipe-header">
            <h3 class="recipe-name">${recipe.Name}</h3>
            <div class="recipe-time">
              <i class="fas fa-clock"></i>
              ${recipe.CookTime}
            </div>
          </div>
          <div class="recipe-ingredients">
            <h4>Ingredients:</h4>
            <ul class="ingredients-list">
              ${recipe.Ingredients.map(
                (ingredient) => `
                  <li>
                    <div class="ingredient-bullet"></div>
                    ${ingredient}
                  </li>
                `
              ).join("")}
            </ul>
          </div>
          <div class="recipe-difficulty difficulty-${recipe.Difficulty.toLowerCase()}">
            ${recipe.Difficulty}
          </div>
          <div class="recipe-actions">
            <button class="btn btn-primary" onclick="addRecipeToCart('${
              recipe.Id
            }')">
              <i class="fas fa-plus"></i>
              Add All to Cart
            </button>
            <button class="btn btn-outline btn-icon recipe-info-btn" data-recipe-id="${
              recipe.Id
            }">
              <i class="fas fa-info"></i>
            </button>
          </div>
        </div>
      `
    )
    .join("");

  // --- Recipe Instructions Modal JS ---
  // Only add event listeners once DOM is ready and grid exists
  if (typeof recipeInstructionsModal === "undefined") {
    window.recipeInstructionsModal = document.getElementById(
      "recipe-instructions-modal"
    );
    window.recipeInstructionsClose = document.getElementById(
      "recipe-instructions-close"
    );
    window.recipeInstructionsTitle = document.getElementById(
      "recipe-instructions-title"
    );
    window.recipeInstructionsBody = document.getElementById(
      "recipe-instructions-body"
    );
  }
  if (recipesGrid) {
    recipesGrid.addEventListener("click", function (e) {
      const infoBtn = e.target.closest(".recipe-info-btn");
      if (infoBtn) {
        e.preventDefault(); // Prevent page reload
        const recipeId = infoBtn.dataset.recipeId;
        const recipe = quickRecipes.find(
          (r) => String(r.Id) === String(recipeId)
        );
        if (recipe) {
          recipeInstructionsTitle.textContent = recipe.Name;
          // No heading, just the instructions
          recipeInstructionsBody.innerHTML = `
            <div class="nutrition-info">
              <div class="nutrition-item">
                <div class="nutrition-value" style="margin-left:0;">${recipe.Instructions.replace(
                  /\n/g,
                  "<br>"
                )}</div>
              </div>
            </div>
          `;
          recipeInstructionsModal.classList.add("active");
          recipeInstructionsModal.style.display = "flex";
          document.body.style.overflow = "hidden";
        }
      }
    });
  }
  if (recipeInstructionsClose) {
    recipeInstructionsClose.addEventListener("click", function () {
      recipeInstructionsModal.classList.remove("active");
      recipeInstructionsModal.style.display = "none";
      document.body.style.overflow = "";
    });
  }
  if (recipeInstructionsModal) {
    recipeInstructionsModal.addEventListener("click", function (e) {
      if (e.target === recipeInstructionsModal) {
        recipeInstructionsModal.classList.remove("active");
        recipeInstructionsModal.style.display = "none";
        document.body.style.overflow = "";
      }
    });
  }
}

function addRecipeToCart(recipeId) {
  const recipe = quickRecipes.find((r) => String(r.Id) === String(recipeId));
  if (!recipe) {
    console.error("Recipe not found:", recipeId);
    return;
  }

  if (recipe.IngredientIds && Array.isArray(recipe.IngredientIds)) {
    recipe.IngredientIds.forEach((ingredientId) => {
      const product = products.find(
        (p) => String(p.Id) === String(ingredientId)
      );
      if (product) {
        addToCart(product);
      }
    });
    //
  } else {
    alert("No ingredients found for this recipe.");
  }
}

function renderMealPlans() {
  mealPlansGrid.innerHTML = mealPlans
    .map(
      (plan) => `
        <div class="meal-plan-card">
            <div class="meal-plan-header">
                <div class="meal-plan-title">
                    <h3 class="meal-plan-name">${plan.name}</h3>
                    <div class="meal-plan-badge">
                        <i class="fas fa-users"></i>
                        Family
                    </div>
                </div>
                <p class="meal-plan-description">${plan.description}</p>
            </div>
            
            <div class="meal-plan-content">
                <div class="meal-plan-days">
                    ${plan.days
                      .map(
                        (day) => `
                        <div class="meal-plan-day">
                            <h4 class="day-title">
                                <div class="day-bullet"></div>
                                ${day.day}
                            </h4>
                            
                            <div class="meals-grid">
                                ${
                                  day.meals.breakfast
                                    ? `
                                    <div class="meal-item">
                                        <div class="meal-label">Breakfast</div>
                                        <div class="meal-name">${day.meals.breakfast}</div>
                                    </div>
                                `
                                    : ""
                                }
                                
                                ${
                                  day.meals.lunch
                                    ? `
                                    <div class="meal-item">
                                        <div class="meal-label">Lunch</div>
                                        <div class="meal-name">${day.meals.lunch}</div>
                                    </div>
                                `
                                    : ""
                                }
                                
                                ${
                                  day.meals.dinner
                                    ? `
                                    <div class="meal-item">
                                        <div class="meal-label">Dinner</div>
                                        <div class="meal-name">${day.meals.dinner}</div>
                                    </div>
                                `
                                    : ""
                                }
                            </div>
                        </div>
                    `
                      )
                      .join("")}
                </div>
                
                <div class="meal-plan-footer">
                    <div class="meal-plan-meta">
                        <i class="fas fa-clock"></i>
                        7 Days
                    </div>
                    <button class="btn btn-primary">
                        Get Shopping List
                    </button>
                </div>
            </div>
        </div>
    `
    )
    .join("");
}

function addToCart(product) {
  const existingItem = cart.find((item) => item.Id === product.Id);

  if (existingItem) {
    existingItem.quantity += 1;
  } else {
    cart.push({
      ...product,
      quantity: 1,
    });
  }

  updateCartUI();

  // Show success feedback
  showAddToCartFeedback();
}

function addCurrentProductToCart(event) {
  if (currentProduct) {
    addToCart(currentProduct);
    // Show feedback on the button inside the modal
    if (event && event.target) {
      const btn = event.target.closest(".btn");
      if (btn) {
        const originalText = btn.innerHTML;
        btn.innerHTML = '<i class="fas fa-check"></i> Added!';
        btn.disabled = true;
        setTimeout(() => {
          btn.innerHTML = originalText;
          btn.disabled = false;
        }, 1200);
        return;
      }
    }
    // Fallback: close modal if no button found
    closeNutritionModal();
  }
}

function removeFromCart(productId) {
  cart = cart.filter((item) => item.Id !== productId);
  updateCartUI();
}

function updateQuantity(productId, newQuantity) {
  if (newQuantity <= 0) {
    removeFromCart(productId);
    return;
  }

  const item = cart.find((item) => item.Id === productId);
  if (item) {
    item.quantity = newQuantity;
    updateCartUI();
  }
}

function clearCart() {
  cart = [];
  updateCartUI();
}

function checkout() {
  window.location.href = "ChechOut.aspx";
}

function updateCartUI() {
  const totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);
  const total = cart.reduce((sum, item) => sum + item.Price * item.quantity, 0);

  // Update cart count
  cartCount.textContent = totalItems;
  floatingCartCount.textContent = totalItems;
  cartItemsCount.textContent = `${totalItems} ${
    totalItems === 1 ? "item" : "items"
  }`;

  // Show/hide floating cart
  if (totalItems > 0) {
    floatingCart.classList.remove("hidden");
  } else {
    floatingCart.classList.add("hidden");
  }

  // Update total price
  totalPrice.textContent = `R${total.toFixed(2)}`;

  // Show/hide cart sections
  if (cart.length === 0) {
    cartEmpty.style.display = "flex";
    cartItems.style.display = "none";
    cartFooter.style.display = "none";
  } else {
    cartEmpty.style.display = "none";
    cartItems.style.display = "block";
    cartFooter.style.display = "block";
  }

  // Render cart items
  renderCartItems();
}

function renderCartItems() {
  cartItems.innerHTML = cart
    .map(
      (item) => `
        <div class="cart-item">
            <img src="${item.ImageURL}" alt="${
        item.Name
      }" class="cart-item-image">
            
            <div class="cart-item-details">
                <h4 class="cart-item-name">${item.Name}</h4>
                <p class="cart-item-meta">
                    ${item.CategoryName} ${item.Unit ? `• ${item.Unit}` : ""}
                </p>
                <p class="cart-item-price">R${(
                  item.Price * item.quantity
                ).toFixed(2)}</p>
            </div>
            
            <div class="cart-item-actions">
                <button class="cart-item-remove" data-action="remove" data-product-id="${
                  item.Id
                }">
                    <i class="fas fa-trash"></i>
                </button>
                
                <div class="quantity-controls">
                    <button class="quantity-btn" data-action="decrease" data-product-id="${
                      item.Id
                    }">
                        <i class="fas fa-minus"></i>
                    </button>
                    
                    <span class="quantity-display">${item.quantity}</span>
                    
                    <button class="quantity-btn" data-action="increase" data-product-id="${
                      item.Id
                    }">
                        <i class="fas fa-plus"></i>
                    </button>
                </div>
            </div>
        </div>
    `
    )
    .join("");
}

function handleCartItemAction(e) {
  const action =
    e.target.dataset.action ||
    e.target.closest("[data-action]")?.dataset.action;
  const productId =
    e.target.dataset.productId ||
    e.target.closest("[data-product-id]")?.dataset.productId;

  if (!action || !productId) return;

  const item = cart.find((item) => String(item.Id) === String(productId));
  if (!item) return;

  switch (action) {
    case "remove":
      removeFromCart(item.Id);
      break;
    case "increase":
      updateQuantity(item.Id, item.quantity + 1);
      break;
    case "decrease":
      updateQuantity(item.Id, item.quantity - 1);
      break;
  }
}

function openCartModal() {
  cartModal.classList.add("active");
  document.body.style.overflow = "hidden";
}

function closeCartModal() {
  cartModal.classList.remove("active");
  document.body.style.overflow = "";
}

function handleCartModalClick(e) {
  if (e.target === cartModal) {
    closeCartModal();
  }
}

function showNutritionModal(product) {
  currentProduct = product;

  nutritionBody.innerHTML = `
    <div class="nutrition-info">
      <div class="nutrition-item">
        <span class="nutrition-label">Calories</span>
        <span class="nutrition-value">${product.Calories ?? "-"} kcal</span>
      </div>
      <div class="nutrition-item">
        <span class="nutrition-label">Fat</span>
        <span class="nutrition-value">${product.Fat ?? "-"} g</span>
      </div>
      <div class="nutrition-item">
        <span class="nutrition-label">Protein</span>
        <span class="nutrition-value">${product.Protein ?? "-"} g</span>
      </div>
      <div class="nutrition-item">
        <span class="nutrition-label">Carbs</span>
        <span class="nutrition-value">${product.Carbs ?? "-"} g</span>
      </div>
    </div>
  `;

  nutritionModal.classList.add("active");
  document.body.style.overflow = "hidden";
}

function closeNutritionModal() {
  nutritionModal.classList.remove("active");
  document.body.style.overflow = "";
  currentProduct = null;
}

function handleNutritionModalClick(e) {
  if (e.target === nutritionModal) {
    closeNutritionModal();
  }
}

function showAddToCartFeedback() {
  // Simple feedback - you could enhance this with a toast notification
  const btn = event.target.closest(".btn-primary");
  if (btn) {
    const originalText = btn.innerHTML;
    btn.innerHTML = '<i class="fas fa-check"></i> Added!';
    btn.disabled = true;

    setTimeout(() => {
      btn.innerHTML = originalText;
      btn.disabled = false;
    }, 1500);
  }
}

function handleSmoothScroll(e) {
  e.preventDefault();
  const targetId = e.target.getAttribute("href");
  const targetElement = document.querySelector(targetId);

  if (targetElement) {
    targetElement.scrollIntoView({
      behavior: "smooth",
      block: "start",
    });

    // Close mobile menu if open
    if (mobileNav.classList.contains("active")) {
      toggleMobileMenu();
    }
  }
}

// Utility function for debouncing
function debounce(func, wait) {
  let timeout;
  return function executedFunction(...args) {
    const later = () => {
      clearTimeout(timeout);
      func(...args);
    };
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
  };
}

// Handle window resize
window.addEventListener(
  "resize",
  debounce(() => {
    // Close mobile menu on desktop
    if (window.innerWidth >= 768 && mobileNav.classList.contains("active")) {
      toggleMobileMenu();
    }
  }, 250)
);

// Handle escape key
document.addEventListener("keydown", (e) => {
  if (e.key === "Escape") {
    if (cartModal.classList.contains("active")) {
      closeCartModal();
    }
    if (nutritionModal.classList.contains("active")) {
      closeNutritionModal();
    }
    if (mobileNav.classList.contains("active")) {
      toggleMobileMenu();
    }
  }
});

// Script for AboutProduct.aspx dynamic population
if (window.location.pathname.endsWith("AboutProduct.aspx")) {
  document.addEventListener("DOMContentLoaded", function () {
    const params = new URLSearchParams(window.location.search);
    const productId = params.get("id");
    const product = products.find((p) => p.id === productId);
    if (product) {
      const img = document.getElementById("MainImage");
      if (img) img.src = product.image;
      const name = document.getElementById("p-name");
      if (name) name.textContent = product.name;
      const price = document.getElementById("p-price");
      if (price) price.textContent = "R " + product.price.toFixed(2);
      const desc = document.getElementById("p-description");
      if (desc) desc.textContent = product.description;
      // Optionally fill nutrition, etc.
    }
  });
}
