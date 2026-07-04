<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Menu" %>
<%@ page import="com.tap.model.Restaurant" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu - FoodyVibes</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #FF6B35;
            --secondary: #FFC107;
            --accent: #E53935;
            --bg-color: #FFF8F2;
            --text-dark: #1C1C1C;
            --text-muted: #6B6B6B;
            --white: #FFFFFF;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
        body { background-color: var(--bg-color); color: var(--text-dark); }
        
        /* Navbar */
        .navbar { display: flex; justify-content: space-between; align-items: center; padding: 15px 8%; box-shadow: 0 4px 15px rgba(0,0,0,0.05); position: sticky; top: 0; background: var(--white); z-index: 1000; }
        .logo { font-size: 26px; font-weight: 800; color: var(--primary); text-decoration: none; display: flex; align-items: center; gap: 12px; transition: transform 0.3s; }
        .logo:hover { transform: scale(1.02); }
        .logo i { font-size: 30px; }
        .nav-links { display: flex; gap: 30px; list-style: none; align-items: center; }
        .nav-links a { text-decoration: none; color: var(--text-dark); font-weight: 500; font-size: 16px; display: flex; align-items: center; gap: 8px; transition: color 0.3s; position: relative; }
        .nav-links a:hover, .nav-links a.active { color: var(--primary); }
        .nav-links a::after { content: ''; position: absolute; width: 0; height: 2px; bottom: -4px; left: 0; background-color: var(--primary); transition: width 0.3s; }
        .nav-links a:hover::after { width: 100%; }
        
        .nav-btn { background: var(--primary); color: var(--white) !important; padding: 8px 20px; border-radius: 25px; transition: background 0.3s, transform 0.2s; }
        .nav-btn:hover { background: #e45a24; color: var(--white) !important; transform: translateY(-2px); }
        .nav-btn::after { display: none; }

        /* Restaurant Hero */
        .res-hero { background: var(--text-dark); color: var(--white); padding: 50px 8%; display: flex; gap: 40px; align-items: center; position: relative; overflow: hidden; }
        .res-hero::before { content: ''; position: absolute; right: -100px; top: -100px; width: 400px; height: 400px; background: rgba(255,255,255,0.05); border-radius: 50%; }
        .res-hero-img { width: 250px; height: 180px; object-fit: cover; border-radius: 16px; box-shadow: 0 15px 35px rgba(0,0,0,0.3); border: 4px solid rgba(255,255,255,0.1); }
        .res-hero-details h1 { font-size: 40px; font-weight: 700; margin-bottom: 10px; }
        .res-hero-details p { font-size: 16px; color: #ccc; margin-bottom: 20px; }
        .res-stats { display: flex; gap: 20px; }
        .stat-box { display: flex; align-items: center; gap: 10px; background: rgba(255,255,255,0.1); padding: 10px 20px; border-radius: 12px; backdrop-filter: blur(5px); }
        .stat-box i { font-size: 20px; color: var(--secondary); }
        .stat-box.rating i { color: #24963f; }
        
        /* Container Layout */
        .container { padding: 40px 8%; display: flex; gap: 40px; }
        
        /* Sidebar Filters */
        .sidebar { width: 250px; flex-shrink: 0; position: sticky; top: 100px; height: max-content; }
        .filter-title { font-size: 20px; font-weight: 700; margin-bottom: 20px; color: var(--text-dark); border-bottom: 2px solid #f0f0f0; padding-bottom: 10px; }
        
        .search-box { display: flex; align-items: center; background: var(--white); border-radius: 8px; padding: 10px 15px; margin-bottom: 25px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); border: 1px solid #f0f0f0; }
        .search-box input { border: none; outline: none; flex-grow: 1; font-size: 14px; padding-left: 10px; }
        .search-box i { color: var(--text-muted); }
        
        .cat-list { list-style: none; }
        .cat-list li { padding: 12px 15px; border-radius: 8px; cursor: pointer; transition: all 0.2s; font-weight: 500; font-size: 15px; color: var(--text-muted); display: flex; justify-content: space-between; align-items: center; margin-bottom: 5px; }
        .cat-list li:hover { background: #fdf5f2; color: var(--primary); }
        .cat-list li.active { background: var(--primary); color: var(--white); box-shadow: 0 4px 10px rgba(255,107,53,0.3); }
        
        /* Menu Content */
        .menu-content { flex-grow: 1; }
        .menu-title { font-size: 28px; font-weight: 700; margin-bottom: 30px; color: var(--text-dark); position: relative; display: inline-block; }
        .menu-title::after { content: ''; position: absolute; bottom: 5px; left: 0; width: 100%; height: 10px; background: rgba(255,193,7,0.3); z-index: -1; border-radius: 5px; }
        
        /* Menu Grid */
        .menu-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 25px; }
        
        /* Menu Card */
        .menu-card { background: var(--white); border-radius: 16px; padding: 20px; display: flex; flex-direction: column; gap: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.03); transition: transform 0.3s, box-shadow 0.3s; border: 1px solid #f0f0f0; }
        .menu-card:hover { transform: translateY(-5px); box-shadow: 0 12px 25px rgba(0,0,0,0.08); border-color: #ffd8b4; }
        
        .card-top { display: flex; justify-content: space-between; align-items: flex-start; gap: 15px; }
        
        .item-info { flex-grow: 1; }
        .veg-badge { width: 16px; height: 16px; border: 1.5px solid #24963f; border-radius: 4px; display: flex; align-items: center; justify-content: center; margin-bottom: 8px; }
        .veg-badge i { font-size: 8px; color: #24963f; }
        .non-veg-badge { border-color: #E53935; }
        .non-veg-badge i { color: #E53935; }
        
        .item-name { font-size: 18px; font-weight: 600; color: var(--text-dark); margin-bottom: 5px; line-height: 1.3; }
        .item-price { font-size: 16px; font-weight: 700; color: var(--text-dark); margin-bottom: 10px; display: flex; align-items: center; gap: 5px; }
        .item-desc { font-size: 13px; color: var(--text-muted); line-height: 1.5; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
        
        .card-img-wrap { position: relative; width: 120px; height: 120px; flex-shrink: 0; }
        .card-img-wrap img { width: 100%; height: 100%; object-fit: cover; border-radius: 12px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        
        .card-bottom { margin-top: auto; border-top: 1px dashed #e9e9eb; padding-top: 15px; display: flex; justify-content: space-between; align-items: center; }
        .item-cat { font-size: 12px; background: var(--bg-color); padding: 4px 10px; border-radius: 20px; color: var(--text-muted); font-weight: 500; }
        
        .add-btn { background: var(--white); color: var(--primary); border: 1.5px solid var(--primary); padding: 8px 25px; font-size: 14px; font-weight: 700; border-radius: 25px; cursor: pointer; transition: all 0.2s; display: inline-flex; align-items: center; gap: 5px; }
        .add-btn:hover { background: var(--primary); color: var(--white); transform: scale(1.05); }

        /* Footer */
        footer { background: #1C1C1C; color: #fff; padding: 60px 8% 30px; margin-top: 60px; }
        .footer-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 40px; margin-bottom: 40px; }
        .footer-col h3 { font-size: 18px; font-weight: 600; margin-bottom: 20px; color: var(--white); }
        .footer-col ul { list-style: none; }
        .footer-col ul li { margin-bottom: 12px; }
        .footer-col ul li a { color: #a0a0a0; text-decoration: none; transition: color 0.3s; }
        .footer-col ul li a:hover { color: var(--primary); }
        .social-icons { display: flex; gap: 15px; margin-top: 15px; }
        .social-icons a { width: 40px; height: 40px; border-radius: 50%; background: #333; display: flex; justify-content: center; align-items: center; color: #fff; text-decoration: none; transition: all 0.3s; }
        .social-icons a:hover { background: var(--primary); }
        .footer-bottom { text-align: center; padding-top: 30px; border-top: 1px solid #333; color: #a0a0a0; font-size: 14px; }

        @media (max-width: 992px) {
            .container { flex-direction: column; }
            .sidebar { width: 100%; position: static; }
            .cat-list { display: flex; overflow-x: auto; gap: 10px; }
            .cat-list li { white-space: nowrap; }
            .res-hero { flex-direction: column; text-align: center; padding: 30px 5%; }
            .res-stats { justify-content: center; }
        }
    </style>
</head>
<body>

    <!-- Navigation -->
    <nav class="navbar">
        <a href="restaurants" class="logo"><i class="fa-solid fa-fire-burner"></i> FoodyVibes</a>
        <ul class="nav-links">
            <li><a href="restaurants"><i class="fa-solid fa-house"></i> Home</a></li>
            <li><a href="#"><i class="fa-solid fa-magnifying-glass"></i> Search</a></li>
            <li><a href="cart.jsp"><i class="fa-solid fa-cart-shopping"></i> Cart</a></li>
            <li><a href="login.html" class="nav-btn"><i class="fa-regular fa-user"></i> Sign In</a></li>
        </ul>
    </nav>

    <% 
        Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
        if (restaurant != null) {
    %>
    <!-- Restaurant Hero -->
    <section class="res-hero">
        <!-- Assuming we use the restaurant image or a placeholder -->
        <img src="<%= restaurant.getImagePath() %>" alt="<%= restaurant.getName() %>" class="res-hero-img" onerror="this.src='https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800&auto=format&fit=crop'">
        <div class="res-hero-details">
            <h1><%= restaurant.getName() %></h1>
            <p><i class="fa-solid fa-utensils"></i> <%= restaurant.getCuisineType() %> &nbsp;•&nbsp; <i class="fa-solid fa-location-dot"></i> <%= restaurant.getAddress() %></p>
            <div class="res-stats">
                <div class="stat-box rating" style="<%= restaurant.getRating() >= 4.0 ? "color: #24963f;" : "color: #FFC107;" %>">
                    <i class="fa-solid fa-star"></i>
                    <strong><%= restaurant.getRating() %> Rating</strong>
                </div>
                <div class="stat-box">
                    <i class="fa-solid fa-clock"></i>
                    <strong><%= restaurant.getDeliveryTime() %> mins</strong>
                </div>
            </div>
        </div>
    </section>
    <% } %>

    <div class="container">
        
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="search-box">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" id="menuSearch" placeholder="Search in menu...">
            </div>
            
            <h3 class="filter-title">Categories</h3>
            <ul class="cat-list">
                <li class="active" onclick="filterMenu('All', this)">All Items</li>
                <li onclick="filterMenu('Recommended', this)">Recommended <i class="fa-solid fa-fire" style="color:var(--primary); font-size:12px;"></i></li>
                <li onclick="filterMenu('Starters', this)">Starters</li>
                <li onclick="filterMenu('Main Course', this)">Main Course</li>
                <li onclick="filterMenu('Desserts', this)">Desserts</li>
                <li onclick="filterMenu('Beverages', this)">Beverages</li>
            </ul>
        </aside>

        <!-- Menu Content -->
        <main class="menu-content">
            <h2 class="menu-title" id="currentCategory">Recommended</h2>
            
            <div class="menu-grid" id="menuGrid">
                <% 
                    List<Menu> menuList = (List<Menu>) request.getAttribute("menuList");
                    if (menuList != null && !menuList.isEmpty()) {
                        for (Menu m : menuList) {
                            String itemNameLower = m.getItemName().toLowerCase();
                            String category = "Starters";
                            String fallbackImg = "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=500";

                            if(itemNameLower.contains("biryani")) {
                                category = "Main Course";
                                fallbackImg = "https://images.pexels.com/photos/1624487/pexels-photo-1624487.jpeg?auto=compress&cs=tinysrgb&w=500";
                            } else if(itemNameLower.contains("pizza")) {
                                category = "Fast Food";
                                fallbackImg = "https://images.pexels.com/photos/1566837/pexels-photo-1566837.jpeg?auto=compress&cs=tinysrgb&w=500";
                            } else if(itemNameLower.contains("burger")) {
                                category = "Fast Food";
                                fallbackImg = "https://images.pexels.com/photos/1639557/pexels-photo-1639557.jpeg?auto=compress&cs=tinysrgb&w=500";
                            } else if(itemNameLower.contains("chicken")) {
                                category = "Main Course";
                                fallbackImg = "https://images.pexels.com/photos/60614/meat-barbecue-grilled-chicken-food-60614.jpeg?auto=compress&cs=tinysrgb&w=500";
                            } else if(itemNameLower.contains("paneer")) {
                                category = "Main Course";
                                fallbackImg = "https://images.pexels.com/photos/2411409/pexels-photo-2411409.jpeg?auto=compress&cs=tinysrgb&w=500";
                            } else if(itemNameLower.contains("noodle") || itemNameLower.contains("fried rice")) {
                                category = "Fast Food";
                                fallbackImg = "https://images.pexels.com/photos/2347311/pexels-photo-2347311.jpeg?auto=compress&cs=tinysrgb&w=500";
                            } else if(itemNameLower.contains("cake") || itemNameLower.contains("dessert") || itemNameLower.contains("shake")) {
                                category = "Desserts";
                                fallbackImg = "https://images.pexels.com/photos/2144112/pexels-photo-2144112.jpeg?auto=compress&cs=tinysrgb&w=500";
                            } else if(itemNameLower.contains("coffee") || itemNameLower.contains("drink")) {
                                category = "Beverages";
                                fallbackImg = "https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg?auto=compress&cs=tinysrgb&w=500";
                            } else if(itemNameLower.contains("dosa") || itemNameLower.contains("idli")) {
                                category = "South Indian";
                                fallbackImg = "https://images.pexels.com/photos/541216/pexels-photo-541216.jpeg?auto=compress&cs=tinysrgb&w=500";
                            }
                %>
                <!-- Menu Card -->
                <div class="menu-card" data-name="<%= m.getItemName().toLowerCase() %>">
                    <div class="card-top">
                        <div class="item-info">
                            <div class="veg-badge <%= m.isAvailable() ? "" : "non-veg-badge" %>">
                                <i class="fa-solid fa-circle"></i>
                            </div>
                            <h3 class="item-name"><%= m.getItemName() %></h3>
                            <div class="item-price">₹<%= m.getPrice() %></div>
                            <p class="item-desc"><%= m.getDescription() %></p>
                        </div>
                        <div class="card-img-wrap">
                            <img src="<%= m.getImagePath() %>" alt="<%= m.getItemName() %>" onerror="this.onerror=null; this.src='<%= fallbackImg %>';">
                        </div>
                    </div>
                    
                    <div class="card-bottom">
                        <span class="item-cat"><%= category %></span>
                        <form action="cart" style="margin:0;">
                            <input type="hidden" name="menuId" value="<%= m.getMenuId() %>">
                            <input type="hidden" name="restaurantId" value="<%= m.getRestaurantId() %>">
                            <input type="hidden" name="quantity" value="1">
                            <input type="hidden" name="action" value="add">
                            <button type="submit" class="add-btn"><i class="fa-solid fa-plus"></i> Add</button>
                        </form>
                    </div>
                </div>
                <% 
                        }
                    } else {
                %>
                    <div style="grid-column: 1/-1; text-align: center; padding: 40px; background: var(--white); border-radius: 12px; color: var(--text-muted);">
                        <i class="fa-solid fa-utensils" style="font-size: 40px; margin-bottom: 15px; color: #ddd;"></i>
                        <h3>No items available</h3>
                        <p>This restaurant's menu is currently empty.</p>
                    </div>
                <% } %>
            </div>
        </main>
        
    </div>

    <!-- Footer -->
    <footer>
        <div class="footer-grid">
            <div class="footer-col">
                <h3 style="color:var(--primary); font-size:20px;"><i class="fa-solid fa-fire-burner"></i> FoodyVibes</h3>
                <p style="color: #a0a0a0; font-size: 14px; margin-bottom: 20px;">Delivering happiness to your doorstep.</p>
                <div class="social-icons">
                    <a href="#"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="#"><i class="fa-brands fa-twitter"></i></a>
                    <a href="#"><i class="fa-brands fa-instagram"></i></a>
                </div>
            </div>
            <div class="footer-col">
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="#">About Us</a></li>
                    <li><a href="#">Offers</a></li>
                    <li><a href="#">Help & Support</a></li>
                </ul>
            </div>
            <div class="footer-col">
                <h3>Legal</h3>
                <ul>
                    <li><a href="#">Terms of Use</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            &copy; 2026 FoodyVibes Technologies. All rights reserved.
        </div>
    </footer>

    <!-- Simple JS for Search Filter (Frontend only) -->
    <script>
        document.getElementById('menuSearch').addEventListener('keyup', function(e) {
            const term = e.target.value.toLowerCase();
            const cards = document.querySelectorAll('.menu-card');
            cards.forEach(card => {
                if (card.dataset.name.includes(term)) {
                    card.style.display = 'flex';
                } else {
                    card.style.display = 'none';
                }
            });
        });
        
        function filterMenu(category, element) {
            // Update active state in sidebar
            document.querySelectorAll('.cat-list li').forEach(li => li.classList.remove('active'));
            element.classList.add('active');
            
            // Update Title
            document.getElementById('currentCategory').innerText = category;
            
            // Filter the cards
            const cards = document.querySelectorAll('.menu-card');
            let visibleCount = 0;
            
            cards.forEach(card => {
                // Get category from the span inside the card
                const cardCat = card.querySelector('.item-cat').innerText;
                
                if (category === 'All') {
                    card.style.display = 'flex';
                    visibleCount++;
                } else if (category === 'Recommended') {
                    // Just show all for recommended as a demo, or could filter by rating
                    card.style.display = 'flex';
                    visibleCount++;
                } else {
                    if (cardCat.includes(category)) {
                        card.style.display = 'flex';
                        visibleCount++;
                    } else {
                        card.style.display = 'none';
                    }
                }
            });
            
            // Show empty state if nothing matches
            let emptyState = document.getElementById('empty-state');
            if(visibleCount === 0) {
                if(!emptyState) {
                    emptyState = document.createElement('div');
                    emptyState.id = 'empty-state';
                    emptyState.style.cssText = 'grid-column: 1/-1; text-align: center; padding: 40px; background: var(--white); border-radius: 12px; color: var(--text-muted);';
                    emptyState.innerHTML = '<i class="fa-solid fa-utensils" style="font-size: 40px; margin-bottom: 15px; color: #ddd;"></i><h3>No items in this category</h3><p>Try selecting a different category.</p>';
                    document.getElementById('menuGrid').appendChild(emptyState);
                }
                emptyState.style.display = 'block';
            } else if (emptyState) {
                emptyState.style.display = 'none';
            }
        }
    </script>
</body>
</html>
