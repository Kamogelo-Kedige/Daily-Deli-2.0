document.addEventListener("DOMContentLoaded", function () {
  // Smooth scrolling for anchor links
  document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
    anchor.addEventListener("click", function (e) {
      e.preventDefault();
      const target = document.querySelector(this.getAttribute("href"));
      if (target) {
        const headerOffset = 80;
        const elementPosition = target.offsetTop;
        const offsetPosition = elementPosition - headerOffset;

        window.scrollTo({
          top: offsetPosition,
          behavior: "smooth",
        });
      }
    });
  });

  // Intersection Observer for fade-in animations
  const observerOptions = {
    threshold: 0.1,
    rootMargin: "0px 0px -50px 0px",
  };

  const observer = new IntersectionObserver(function (entries) {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add("visible");
      }
    });
  }, observerOptions);

  // Observe all elements that should fade in
  const fadeElements = document.querySelectorAll(".fade-in");
  fadeElements.forEach((element) => {
    observer.observe(element);
  });

  // Card hover effects with dynamic shadows
  const cards = document.querySelectorAll(".hover-lift");
  cards.forEach((card) => {
    card.addEventListener("mouseenter", function () {
      this.style.transform = "translateY(-12px) scale(1.02)";
    });

    card.addEventListener("mouseleave", function () {
      this.style.transform = "translateY(0) scale(1)";
    });
  });

  // Dynamic button interactions
  const buttons = document.querySelectorAll(".btn");
  buttons.forEach((button) => {
    button.addEventListener("mouseenter", function () {
      this.style.transform = "scale(1.08)";
      this.style.boxShadow = "0 12px 40px -8px hsla(var(--color-primary), 0.4)";
    });

    button.addEventListener("mouseleave", function () {
      this.style.transform = "scale(1)";
      this.style.boxShadow = "var(--shadow-soft)";
    });

    button.addEventListener("click", function (e) {
      // Create ripple effect
      const ripple = document.createElement("span");
      const rect = this.getBoundingClientRect();
      const size = Math.max(rect.width, rect.height);
      const x = e.clientX - rect.left - size / 2;
      const y = e.clientY - rect.top - size / 2;

      ripple.style.cssText = `
                position: absolute;
                width: ${size}px;
                height: ${size}px;
                left: ${x}px;
                top: ${y}px;
                background: rgba(255, 255, 255, 0.3);
                border-radius: 50%;
                transform: scale(0);
                animation: ripple 0.6s linear;
                pointer-events: none;
            `;

      this.style.position = "relative";
      this.style.overflow = "hidden";
      this.appendChild(ripple);

      setTimeout(() => {
        ripple.remove();
      }, 600);
    });
  });

  // Add ripple animation to CSS
  const style = document.createElement("style");
  style.textContent = `
        @keyframes ripple {
            to {
                transform: scale(4);
                opacity: 0;
            }
        }
    `;
  document.head.appendChild(style);

  // Stagger animations for grid items
  const gridItems = document.querySelectorAll(".grid > *");
  gridItems.forEach((item, index) => {
    item.style.animationDelay = `${index * 0.1}s`;
  });

  // Blog engagement interactions
  const likeButtons = document.querySelectorAll(".like-btn");
  likeButtons.forEach((button) => {
    button.addEventListener("click", function () {
      const count = this.querySelector(".like-count");
      const currentLikes = parseInt(count.textContent);

      if (this.classList.contains("liked")) {
        count.textContent = currentLikes - 1;
        this.classList.remove("liked");
        this.style.color = "";
      } else {
        count.textContent = currentLikes + 1;
        this.classList.add("liked");
        this.style.color = "hsl(var(--color-accent))";
      }
    });
  });

  // Preload critical images
  const criticalImages = [
    "src/assets/hero-kitchen.jpg",
    "src/assets/vegan-meals.jpg",
    "src/assets/halal-cuisine.jpg",
    "src/assets/gourmet-spread.jpg",
  ];

  criticalImages.forEach((src) => {
    const img = new Image();
    img.src = src;
  });

  console.log("🥘 Daily Deli website loaded successfully!");
});

///SHOPPING PAGE JS
///SHOPPING PAGE JS
///SHOPPING PAGE JS
/*
const products = [
  // Fruits
  {
    id: "1",
    name: "Red Apples",
    price: 29.99,
    category: "fruits",
    image: "src/assets/products/apples.jpg",
    unit: "per kg",
    nutrition: { calories: 52, fat: 0.2, protein: 0.3, carbs: 14 },
  },
  {
    id: "2",
    name: "Green Apples",
    price: 35.76,
    category: "fruits",
    image: "src/assets/products/apples.jpg",
    unit: "per kg",
    nutrition: { calories: 52, fat: 0.2, protein: 0.3, carbs: 14 },
  },
  {
    id: "3",
    name: "Bananas",
    price: 22.05,
    category: "fruits",
    image: "src/assets/products/apples.jpg",
    unit: "per kg",
    nutrition: { calories: 89, fat: 0.3, protein: 1.1, carbs: 23 },
  },
  {
    id: "4",
    name: "Strawberries",
    price: 31.99,
    category: "fruits",
    image: "src/assets/products/apples.jpg",
    unit: "per kg",
    nutrition: { calories: 32, fat: 0.3, protein: 0.7, carbs: 8 },
  },

  // Vegetables
  {
    id: "5",
    name: "Broccoli",
    price: 28.99,
    category: "vegetables",
    image: "src/assets/products/broccoli.jpg",
    unit: "per kg",
    nutrition: { calories: 34, fat: 0.4, protein: 2.8, carbs: 7 },
  },
  {
    id: "6",
    name: "Tomatoes",
    price: 28.39,
    category: "vegetables",
    image: "src/assets/products/broccoli.jpg",
    unit: "per kg",
    nutrition: { calories: 18, fat: 0.2, protein: 0.9, carbs: 4 },
  },
  {
    id: "7",
    name: "Lettuce",
    price: 17.99,
    category: "vegetables",
    image: "src/assets/products/broccoli.jpg",
    unit: "each",
    nutrition: { calories: 15, fat: 0.1, protein: 1.4, carbs: 3 },
  },
  {
    id: "8",
    name: "Potatoes",
    price: 27.99,
    category: "vegetables",
    image: "src/assets/products/broccoli.jpg",
    unit: "per 2kg",
    nutrition: { calories: 77, fat: 0.1, protein: 2, carbs: 17 },
  },

  // Bakery
  {
    id: "9",
    name: "Whole Wheat Bread",
    price: 24.99,
    category: "bakery",
    image: "src/assets/products/bread.jpg",
    unit: "per loaf",
    nutrition: { calories: 247, fat: 4.2, protein: 13, carbs: 41 },
  },
  {
    id: "10",
    name: "Croissants",
    price: 52.99,
    category: "bakery",
    image: "src/assets/products/bread.jpg",
    unit: "6 pack",
    nutrition: { calories: 231, fat: 12, protein: 5, carbs: 26 },
  },
  {
    id: "11",
    name: "Muffins",
    price: 34.99,
    category: "bakery",
    image: "src/assets/products/bread.jpg",
    unit: "5 pack",
    nutrition: { calories: 377, fat: 18, protein: 6, carbs: 48 },
  },

  // Dairy
  {
    id: "12",
    name: "Milk",
    price: 22.99,
    category: "dairy",
    image: "src/assets/products/dairy.jpg",
    unit: "1L",
    nutrition: { calories: 42, fat: 1, protein: 3.4, carbs: 5 },
  },
  {
    id: "13",
    name: "Greek Yogurt",
    price: 79.99,
    category: "dairy",
    image: "src/assets/products/dairy.jpg",
    unit: "500g",
    nutrition: { calories: 59, fat: 0.4, protein: 10, carbs: 3.6 },
  },
  {
    id: "14",
    name: "Cheddar Cheese",
    price: 69.99,
    category: "dairy",
    image: "src/assets/products/dairy.jpg",
    unit: "400g",
    nutrition: { calories: 402, fat: 33, protein: 25, carbs: 1.3 },
  },

  // Beverages
  {
    id: "15",
    name: "Orange Juice",
    price: 23.99,
    category: "beverages",
    image: "src/assets/products/dairy.jpg",
    unit: "1L",
    nutrition: { calories: 45, fat: 0.2, protein: 0.7, carbs: 10.4 },
  },
  {
    id: "16",
    name: "Water",
    price: 13.99,
    category: "beverages",
    image: "src/assets/products/dairy.jpg",
    unit: "1.5L",
    nutrition: { calories: 0, fat: 0, protein: 0, carbs: 0 },
  },

  // Snacks
  {
    id: "17",
    name: "Mixed Nuts",
    price: 76.99,
    category: "snacks",
    image: "src/assets/products/bread.jpg",
    unit: "250g",
    nutrition: { calories: 607, fat: 54, protein: 20, carbs: 16 },
  },
  {
    id: "18",
    name: "Granola Bars",
    price: 45.99,
    category: "snacks",
    image: "src/assets/products/bread.jpg",
    unit: "6 pack",
    nutrition: { calories: 471, fat: 20, protein: 10, carbs: 64 },
  },
];

// Recipe Data
const quickRecipes = [
  {
    id: "r1",
    name: "Fresh Garden Salad",
    ingredients: ["Lettuce", "Tomatoes", "Broccoli"],
    cookTime: "10 mins",
    difficulty: "Easy",
  },
  {
    id: "r2",
    name: "Fruit Smoothie Bowl",
    ingredients: ["Strawberries", "Bananas", "Greek Yogurt"],
    cookTime: "5 mins",
    difficulty: "Easy",
  },
  {
    id: "r3",
    name: "Cheese & Herb Toast",
    ingredients: ["Whole Wheat Bread", "Cheddar Cheese"],
    cookTime: "8 mins",
    difficulty: "Easy",
  },
];

// Meal Plan Data
const mealPlans = [
  {
    id: "mp1",
    name: "Healthy Week",
    description:
      "A balanced meal plan focused on fresh ingredients and nutrition",
    days: [
      {
        day: "Monday",
        meals: {
          breakfast: "Fruit Smoothie Bowl",
          lunch: "Fresh Garden Salad",
          dinner: "Grilled vegetables with cheese",
        },
      },
      {
        day: "Tuesday",
        meals: {
          breakfast: "Cheese & Herb Toast",
          lunch: "Greek yogurt with nuts",
          dinner: "Fresh salad with bread",
        },
      },
      {
        day: "Wednesday",
        meals: {
          breakfast: "Fresh fruit mix",
          lunch: "Vegetable wrap",
          dinner: "Cheese platter with bread",
        },
      },
    ],
  },
  {
    id: "mp2",
    name: "Quick & Easy",
    description: "Simple meals for busy lifestyles",
    days: [
      {
        day: "Monday",
        meals: {
          breakfast: "Granola bars with milk",
          lunch: "Cheese toast",
          dinner: "Quick salad",
        },
      },
      {
        day: "Tuesday",
        meals: {
          breakfast: "Yogurt with nuts",
          lunch: "Fresh fruit",
          dinner: "Vegetable stir-fry",
        },
      },
    ],
  },
];

// Global State
let cart = [];
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
  const featuredItems = products.slice(0, 8);

  featuredProducts.innerHTML = featuredItems
    .map((product) => createProductCard(product, true))
    .join("");

  // Add event listeners to featured products
  featuredProducts.addEventListener("click", handleProductAction);
}

function renderProducts() {
  const filteredProducts =
    selectedCategory === "all"
      ? products
      : products.filter((product) => product.category === selectedCategory);

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
        }" data-product-id="${product.id}">
            <div class="product-image-container">
                <img 
                    src="${product.image}" 
                    alt="${product.name}" 
                    class="product-image"
                    data-action="show-nutrition"
                >
                <div class="product-category">${product.category}</div>
            </div>
            
            <div class="product-content">
                <h3 class="product-name">${product.name}</h3>
                <p class="product-price">
                    R${product.price.toFixed(2)}
                    ${
                      product.unit
                        ? `<span class="product-unit">${product.unit}</span>`
                        : ""
                    }
                </p>
                
                <div class="product-actions">
                    <button class="btn btn-primary" data-action="add-to-cart">
                        <i class="fas fa-shopping-cart"></i>
                        Add to Cart
                    </button>
                    
                    ${
                      product.nutrition
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
  const product = products.find((p) => p.id === productId);

  if (!product) return;

  switch (action) {
    case "add-to-cart":
      addToCart(product);
      break;
    case "show-nutrition":
      if (product.nutrition) {
        showNutritionModal(product);
      }
      break;
  }
}

function renderRecipes() {
  recipesGrid.innerHTML = quickRecipes
    .map(
      (recipe) => `
        <div class="recipe-card">
            <div class="recipe-header">
                <h3 class="recipe-name">${recipe.name}</h3>
                <div class="recipe-time">
                    <i class="fas fa-clock"></i>
                    ${recipe.cookTime}
                </div>
            </div>
            
            <div class="recipe-ingredients">
                <h4>Ingredients:</h4>
                <ul class="ingredients-list">
                    ${recipe.ingredients
                      .map(
                        (ingredient) => `
                        <li>
                            <div class="ingredient-bullet"></div>
                            ${ingredient}
                        </li>
                    `
                      )
                      .join("")}
                </ul>
            </div>
            
            <div class="recipe-difficulty difficulty-${recipe.difficulty.toLowerCase()}">
                ${recipe.difficulty}
            </div>
            
            <button class="btn btn-primary" onclick="addRecipeToCart('${
              recipe.id
            }')">
                <i class="fas fa-plus"></i>
                Add All to Cart
            </button>
        </div>
    `
    )
    .join("");
}

function addRecipeToCart(recipeId) {
  const recipe = quickRecipes.find((r) => r.id === recipeId);
  if (!recipe) return;

  recipe.ingredients.forEach((ingredientName) => {
    const product = products.find((p) =>
      p.name.toLowerCase().includes(ingredientName.toLowerCase())
    );
    if (product) {
      addToCart(product);
    }
  });
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
  const existingItem = cart.find((item) => item.id === product.id);

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

function addCurrentProductToCart() {
  if (currentProduct) {
    addToCart(currentProduct);
    closeNutritionModal();
  }
}

function removeFromCart(productId) {
  cart = cart.filter((item) => item.id !== productId);
  updateCartUI();
}

function updateQuantity(productId, newQuantity) {
  if (newQuantity <= 0) {
    removeFromCart(productId);
    return;
  }

  const item = cart.find((item) => item.id === productId);
  if (item) {
    item.quantity = newQuantity;
    updateCartUI();
  }
}

function clearCart() {
  cart = [];
  updateCartUI();
}

function updateCartUI() {
  const totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);
  const total = cart.reduce((sum, item) => sum + item.price * item.quantity, 0);

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
            <img src="${item.image}" alt="${item.name}" class="cart-item-image">
            
            <div class="cart-item-details">
                <h4 class="cart-item-name">${item.name}</h4>
                <p class="cart-item-meta">
                    ${item.category} ${item.unit ? `• ${item.unit}` : ""}
                </p>
                <p class="cart-item-price">R${(
                  item.price * item.quantity
                ).toFixed(2)}</p>
            </div>
            
            <div class="cart-item-actions">
                <button class="cart-item-remove" data-action="remove" data-product-id="${
                  item.id
                }">
                    <i class="fas fa-trash"></i>
                </button>
                
                <div class="quantity-controls">
                    <button class="quantity-btn" data-action="decrease" data-product-id="${
                      item.id
                    }">
                        <i class="fas fa-minus"></i>
                    </button>
                    
                    <span class="quantity-display">${item.quantity}</span>
                    
                    <button class="quantity-btn" data-action="increase" data-product-id="${
                      item.id
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

  const item = cart.find((item) => item.id === productId);
  if (!item) return;

  switch (action) {
    case "remove":
      removeFromCart(productId);
      break;
    case "increase":
      updateQuantity(productId, item.quantity + 1);
      break;
    case "decrease":
      updateQuantity(productId, item.quantity - 1);
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
            ${Object.entries(product.nutrition)
              .map(
                ([key, value]) => `
                <div class="nutrition-item">
                    <span class="nutrition-label">${
                      key.charAt(0).toUpperCase() + key.slice(1)
                    }</span>
                    <span class="nutrition-value">${value}${
                  key === "calories" ? " kcal" : "g"
                }</span>
                </div>
            `
              )
              .join("")}
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
});*/
