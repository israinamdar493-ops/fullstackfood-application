<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Restaurant" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodyVibes - Delicious Food Delivered</title>
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
        .navbar { display: flex; justify-content: space-between; align-items: center; padding: 15px 8%; box-shadow: 0 4px 15px rgba(0,0,0,0.05); position: sticky; top: 0; background: var(--white); z-index: 1000; transition: all 0.3s; }
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

        /* Hero Section */
        .hero { position: relative; height: 500px; display: flex; align-items: center; justify-content: center; text-align: center; color: var(--white); background: url('https://images.unsplash.com/photo-1504674900247-0877df9cc836?q=80&w=2070&auto=format&fit=crop') no-repeat center center/cover; }
        .hero::before { content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.6); }
        .hero-content { position: relative; z-index: 1; max-width: 800px; padding: 0 20px; animation: fadeIn 1s ease; }
        .hero h1 { font-size: 48px; font-weight: 800; margin-bottom: 15px; line-height: 1.2; text-shadow: 2px 2px 4px rgba(0,0,0,0.5); }
        .hero p { font-size: 18px; margin-bottom: 30px; font-weight: 300; }
        .hero-search { display: flex; max-width: 600px; margin: 0 auto 30px; background: var(--white); border-radius: 30px; overflow: hidden; padding: 5px; box-shadow: 0 10px 20px rgba(0,0,0,0.2); }
        .hero-search input { flex: 1; border: none; padding: 12px 20px; font-size: 16px; outline: none; border-radius: 30px 0 0 30px; }
        .hero-search button { background: var(--primary); color: var(--white); border: none; padding: 12px 30px; font-size: 16px; font-weight: 600; cursor: pointer; border-radius: 25px; transition: background 0.3s; }
        .hero-search button:hover { background: #e45a24; }
        .hero-btns { display: flex; gap: 15px; justify-content: center; }
        .btn-outline { background: transparent; border: 2px solid var(--white); color: var(--white); padding: 12px 30px; font-size: 16px; font-weight: 600; border-radius: 30px; cursor: pointer; transition: all 0.3s; text-decoration: none; }
        .btn-outline:hover { background: var(--white); color: var(--text-dark); }
        .btn-primary { background: var(--primary); border: 2px solid var(--primary); color: var(--white); padding: 12px 30px; font-size: 16px; font-weight: 600; border-radius: 30px; cursor: pointer; transition: all 0.3s; text-decoration: none; }
        .btn-primary:hover { background: #e45a24; border-color: #e45a24; }

        /* Categories Section */
        .categories-sec { padding: 60px 8%; background: var(--white); }
        .section-title { font-size: 32px; font-weight: 700; text-align: center; margin-bottom: 40px; position: relative; color: var(--text-dark); }
        .section-title::after { content: ''; position: absolute; bottom: -10px; left: 50%; transform: translateX(-50%); width: 60px; height: 4px; background: var(--primary); border-radius: 2px; }
        
        .cat-grid { display: flex; gap: 20px; justify-content: space-between; overflow-x: auto; padding: 10px 5px 20px; scrollbar-width: none; }
        .cat-card { min-width: 130px; background: var(--white); border-radius: 16px; padding: 20px 10px; text-align: center; cursor: pointer; box-shadow: 0 4px 15px rgba(0,0,0,0.05); transition: transform 0.3s, box-shadow 0.3s; border: 1px solid #f0f0f0; }
        .cat-card:hover { transform: translateY(-8px); box-shadow: 0 10px 25px rgba(255,107,53,0.15); border-color: var(--primary); }
        .cat-card img { width: 80px; height: 80px; border-radius: 50%; object-fit: cover; margin-bottom: 10px; border: 3px solid #FFF8F2; }
        .cat-card h4 { font-size: 16px; font-weight: 600; color: var(--text-dark); }

        /* Main Container - Restaurants */
        .container { padding: 60px 8%; }
        
        /* Restaurant Grid */
        .restaurant-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 35px; }
        
        /* Premium Restaurant Card */
        .card { background: var(--white); border-radius: 20px; overflow: hidden; transition: transform 0.3s, box-shadow 0.3s; cursor: pointer; text-decoration: none; color: inherit; display: flex; flex-direction: column; border: 1px solid #f0f0f0; box-shadow: 0 5px 20px rgba(0,0,0,0.03); }
        .card:hover { transform: translateY(-5px) scale(1.01); box-shadow: 0 15px 35px rgba(0,0,0,0.1); }
        .card-img-container { position: relative; width: 100%; height: 220px; overflow: hidden; }
        .card-img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s; }
        .card:hover .card-img { transform: scale(1.08); }
        .discount-badge { position: absolute; top: 15px; left: -10px; background: var(--accent); color: var(--white); padding: 5px 15px 5px 20px; font-weight: 700; font-size: 13px; border-radius: 0 20px 20px 0; box-shadow: 0 4px 10px rgba(229,57,53,0.3); z-index: 2; }
        .time-badge { position: absolute; bottom: 15px; right: 15px; background: rgba(255,255,255,0.9); padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: 700; color: var(--text-dark); box-shadow: 0 2px 10px rgba(0,0,0,0.1); display: flex; align-items: center; gap: 5px; z-index: 2; backdrop-filter: blur(4px); }
        
        /* Card Details */
        .card-body { padding: 20px; flex-grow: 1; display: flex; flex-direction: column; }
        .res-header-row { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 8px; }
        .res-name { font-size: 20px; font-weight: 700; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: var(--text-dark); max-width: 75%; }
        .rating-badge { display: flex; align-items: center; gap: 4px; color: var(--white); padding: 4px 8px; border-radius: 8px; font-size: 14px; font-weight: 600; box-shadow: 0 2px 6px rgba(0,0,0,0.1); }
        .res-cuisines { font-size: 14px; color: var(--text-muted); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; margin-bottom: 12px; }
        .card-footer-info { display: flex; justify-content: space-between; align-items: center; margin-top: auto; padding-top: 15px; border-top: 1px dashed #e9e9eb; }
        .res-loc { font-size: 14px; color: var(--text-muted); display: flex; align-items: center; gap: 6px; }
        .explore-btn { color: var(--primary); font-weight: 600; font-size: 14px; opacity: 0; transform: translateX(-10px); transition: all 0.3s; }
        .card:hover .explore-btn { opacity: 1; transform: translateX(0); }

        /* Features Section */
        .features { padding: 60px 8%; background: var(--bg-color); display: flex; gap: 30px; justify-content: space-around; flex-wrap: wrap; }
        .feature-box { text-align: center; max-width: 250px; }
        .f-icon { width: 80px; height: 80px; background: var(--white); border-radius: 50%; display: flex; justify-content: center; align-items: center; margin: 0 auto 20px; font-size: 32px; color: var(--primary); box-shadow: 0 10px 25px rgba(255,107,53,0.15); transition: transform 0.3s; }
        .feature-box:hover .f-icon { transform: translateY(-10px); background: var(--primary); color: var(--white); }
        .feature-box h3 { font-size: 18px; font-weight: 700; margin-bottom: 10px; }
        .feature-box p { font-size: 14px; color: var(--text-muted); }

        /* Footer */
        footer { background: #1C1C1C; color: #fff; padding: 60px 8% 30px; }
        .footer-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 40px; margin-bottom: 40px; }
        .footer-col h3 { font-size: 18px; font-weight: 600; margin-bottom: 20px; color: var(--white); position: relative; padding-bottom: 10px; }
        .footer-col h3::after { content: ''; position: absolute; left: 0; bottom: 0; width: 40px; height: 3px; background: var(--primary); border-radius: 2px; }
        .footer-col ul { list-style: none; }
        .footer-col ul li { margin-bottom: 12px; }
        .footer-col ul li a { color: #a0a0a0; text-decoration: none; transition: color 0.3s; font-size: 15px; }
        .footer-col ul li a:hover { color: var(--primary); }
        .social-icons { display: flex; gap: 15px; margin-top: 15px; }
        .social-icons a { width: 40px; height: 40px; border-radius: 50%; background: #333; display: flex; justify-content: center; align-items: center; color: #fff; text-decoration: none; transition: all 0.3s; }
        .social-icons a:hover { background: var(--primary); transform: translateY(-3px); }
        .footer-bottom { text-align: center; padding-top: 30px; border-top: 1px solid #333; color: #a0a0a0; font-size: 14px; }

        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
        
        @media (max-width: 768px) {
            .nav-links { display: none; } /* Add hamburger logic if needed */
            .hero h1 { font-size: 36px; }
            .hero-btns { flex-direction: column; }
        }
    </style>
</head>
<body>

    <!-- Navigation -->
    <nav class="navbar">
        <a href="restaurants" class="logo"><i class="fa-solid fa-fire-burner"></i> FoodyVibes</a>
        <ul class="nav-links">
            <li><a href="restaurants" class="active"><i class="fa-solid fa-house"></i> Home</a></li>
            <li><a href="#"><i class="fa-solid fa-magnifying-glass"></i> Search</a></li>
            <li><a href="cart.jsp"><i class="fa-solid fa-cart-shopping"></i> Cart</a></li>
            <li><a href="login.html" class="nav-btn"><i class="fa-regular fa-user"></i> Sign In</a></li>
        </ul>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-content">
            <h1>Delicious Food Delivered To Your Doorstep</h1>
            <p>Explore top-rated restaurants, fast delivery, and crave-worthy meals anytime, anywhere.</p>
            <div class="hero-search">
                <input type="text" placeholder="Search for restaurant, cuisine, or a dish...">
                <button type="button">Search</button>
            </div>
            <div class="hero-btns">
                <a href="#restaurants-section" class="btn-primary">Order Now</a>
                <a href="#categories-section" class="btn-outline">Explore Menu</a>
            </div>
        </div>
    </section>

    <!-- Featured Categories -->
    <section id="categories-section" class="categories-sec">
        <h2 class="section-title">What's on your mind?</h2>
        <div class="cat-grid">
            <div class="cat-card">
                <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/v1674029856/PC_Creative%20refresh/3D_bau/banners_new/Pizza.png" alt="Pizza">
                <h4>Pizza</h4>
            </div>
            <div class="cat-card">
                <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/v1674029845/PC_Creative%20refresh/3D_bau/banners_new/Burger.png" alt="Burger">
                <h4>Burger</h4>
            </div>
            <div class="cat-card">
                <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/v1675667625/PC_Creative%20refresh/Biryani_2.png" alt="Biryani">
                <h4>Biryani</h4>
            </div>
            <div class="cat-card">
                <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/v1674029848/PC_Creative%20refresh/3D_bau/banners_new/Chinese.png" alt="Chinese">
                <h4>Chinese</h4>
            </div>
            <div class="cat-card">
                <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/v1674029850/PC_Creative%20refresh/3D_bau/banners_new/Dosa.png" alt="South Indian">
                <h4>South Indian</h4>
            </div>
            <div class="cat-card">
                <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/v1674029845/PC_Creative%20refresh/3D_bau/banners_new/Cakes.png" alt="Desserts">
                <h4>Desserts</h4>
            </div>
            <div class="cat-card">
                <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/v1674029846/PC_Creative%20refresh/3D_bau/banners_new/Coffee.png" alt="Beverages">
                <h4>Beverages</h4>
            </div>
        </div>
    </section>

    <!-- Main Content - Restaurants -->
    <div id="restaurants-section" class="container">
        <h2 class="section-title">Top restaurants in your city</h2>
        
        <div class="restaurant-grid">
            
            <% 
                List<Restaurant> restaurantList = (List<Restaurant>) request.getAttribute("restaurantList");
                if (restaurantList != null && !restaurantList.isEmpty()) {
                    for (Restaurant r : restaurantList) {
            %>
            <!-- Premium Restaurant Card -->
            <a href="menu?restaurantId=<%= r.getRestaurantId() %>" class="card">
                <div class="card-img-container">
                    <% if(r.getRating() >= 4.5) { %><div class="discount-badge">Top Rated</div><% } %>
                    <img src="<%= r.getImagePath() %>" class="card-img" alt="<%= r.getName() %>" onerror="this.src='https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3'">
                    <div class="time-badge"><i class="fa-solid fa-motorcycle"></i> <%= r.getDeliveryTime() %> mins</div>
                </div>
                <div class="card-body">
                    <div class="res-header-row">
                        <div class="res-name"><%= r.getName() %></div>
                        <div class="rating-badge" style="<%= r.getRating() >= 4.0 ? "background-color: #24963f;" : "background-color: #FFC107; color:#1C1C1C;" %>">
                            <i class="fa-solid fa-star" style="font-size:12px"></i> <%= r.getRating() %>
                        </div>
                    </div>
                    <div class="res-cuisines"><%= r.getCuisineType() %></div>
                    
                    <div class="card-footer-info">
                        <div class="res-loc"><i class="fa-solid fa-location-dot"></i> <%= r.getAddress() %></div>
                        <div class="explore-btn">View Menu <i class="fa-solid fa-arrow-right-long"></i></div>
                    </div>
                </div>
            </a>
            <% 
                    }
                } else {
            %>
                <div style="grid-column: 1/-1; text-align: center; padding: 40px; background: var(--white); border-radius: 12px; color: var(--text-muted);">
                    <i class="fa-solid fa-shop-slash" style="font-size: 40px; margin-bottom: 15px; color: #ddd;"></i>
                    <h3>No restaurants found</h3>
                    <p>Please try again later or check a different location.</p>
                </div>
            <% 
                } 
            %>

        </div>
    </div>

    <!-- Why Choose Us -->
    <section class="features">
        <div class="feature-box">
            <div class="f-icon"><i class="fa-solid fa-bolt"></i></div>
            <h3>Fast Delivery</h3>
            <p>Hot and fresh food delivered to your door within minutes.</p>
        </div>
        <div class="feature-box">
            <div class="f-icon"><i class="fa-solid fa-leaf"></i></div>
            <h3>Fresh Ingredients</h3>
            <p>Quality ingredients that make your meal absolutely delicious.</p>
        </div>
        <div class="feature-box">
            <div class="f-icon"><i class="fa-solid fa-shield-halved"></i></div>
            <h3>Secure Payment</h3>
            <p>Multiple safe and secure payment options available.</p>
        </div>
        <div class="feature-box">
            <div class="f-icon"><i class="fa-solid fa-headset"></i></div>
            <h3>24/7 Support</h3>
            <p>Our dedicated support team is always ready to help you.</p>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="footer-grid">
            <div class="footer-col">
                <a href="restaurants" class="logo" style="color: var(--primary); margin-bottom: 15px; padding:0; display:inline-flex;"><i class="fa-solid fa-fire-burner"></i> FoodyVibes</a>
                <p style="color: #a0a0a0; font-size: 14px; margin-bottom: 20px; line-height: 1.6;">Bringing the best food from your favorite restaurants right to your doorstep. Taste the vibes!</p>
                <div class="social-icons">
                    <a href="#"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="#"><i class="fa-brands fa-twitter"></i></a>
                    <a href="#"><i class="fa-brands fa-instagram"></i></a>
                </div>
            </div>
            <div class="footer-col">
                <h3>Company</h3>
                <ul>
                    <li><a href="#">About Us</a></li>
                    <li><a href="#">Careers</a></li>
                    <li><a href="#">Team</a></li>
                    <li><a href="#">FoodyVibes Blog</a></li>
                </ul>
            </div>
            <div class="footer-col">
                <h3>Contact</h3>
                <ul>
                    <li><a href="#">Help & Support</a></li>
                    <li><a href="#">Partner with us</a></li>
                    <li><a href="#">Ride with us</a></li>
                </ul>
            </div>
            <div class="footer-col">
                <h3>Legal</h3>
                <ul>
                    <li><a href="#">Terms & Conditions</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Cookie Policy</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            &copy; 2026 FoodyVibes Technologies Pvt. Ltd. All rights reserved.
        </div>
    </footer>

</body>
</html>
