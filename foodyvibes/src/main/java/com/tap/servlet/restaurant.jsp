<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Restaurant" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurants - FoodyVibes</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Inter', sans-serif; }
        body { background-color: #fff; color: #282c3f; }
        
        /* Navbar */
        .navbar { display: flex; justify-content: space-between; align-items: center; padding: 15px 10%; box-shadow: 0 15px 40px -20px rgba(40,44,63,.15); position: sticky; top: 0; background: #fff; z-index: 1000; }
        .logo { font-size: 24px; font-weight: 800; color: #fc8019; text-decoration: none; display: flex; align-items: center; gap: 10px; }
        .logo i { font-size: 28px; }
        .nav-links { display: flex; gap: 40px; list-style: none; align-items: center; }
        .nav-links a { text-decoration: none; color: #3d4152; font-weight: 500; font-size: 16px; display: flex; align-items: center; gap: 8px; transition: color 0.3s; }
        .nav-links a:hover { color: #fc8019; }
        
        /* Main Container */
        .container { padding: 40px 10%; }
        .section-title { font-size: 28px; font-weight: 700; margin-bottom: 30px; color: #282c3f; }
        
        /* Restaurant Grid */
        .restaurant-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 30px; }
        
        /* Restaurant Card */
        .card { padding: 15px; border-radius: 16px; transition: transform 0.2s, box-shadow 0.2s; cursor: pointer; text-decoration: none; color: inherit; display: block; border: 1px solid transparent; }
        .card:hover { transform: scale(0.98); border-color: #e9e9eb; box-shadow: 0 4px 14px rgba(0,0,0,0.05); }
        .card-img-container { position: relative; width: 100%; height: 180px; border-radius: 16px; overflow: hidden; margin-bottom: 12px; }
        .card-img { width: 100%; height: 100%; object-fit: cover; }
        
        /* Card Details */
        .res-name { font-size: 18px; font-weight: 700; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: #282c3f; margin-bottom: 4px; }
        .res-info { display: flex; align-items: center; gap: 8px; font-size: 16px; font-weight: 600; color: #414449; margin-bottom: 6px; }
        .rating-badge { display: flex; align-items: center; gap: 4px; background: #24963f; color: #fff; padding: 2px 6px; border-radius: 6px; font-size: 13px; }
        .res-cuisines { font-size: 14px; color: #686b78; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; margin-bottom: 4px; }
        .res-loc { font-size: 14px; color: #686b78; }
        
        /* Divider */
        .divider { height: 1px; background-color: #e9e9eb; margin: 40px 0; }
    </style>
</head>
<body>

    <!-- Navigation -->
    <nav class="navbar">
        <a href="restaurants" class="logo"><i class="fa-solid fa-burger"></i> FoodyVibes</a>
        <ul class="nav-links">
            <li><a href="#"><i class="fa-solid fa-magnifying-glass"></i> Search</a></li>
            <li><a href="#"><i class="fa-solid fa-badge-percent"></i> Offers</a></li>
            <li><a href="login.html"><i class="fa-regular fa-user"></i> Sign In</a></li>
            <li><a href="cart.html"><i class="fa-solid fa-cart-shopping"></i> Cart</a></li>
        </ul>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h2 class="section-title">Restaurants with online food delivery in Bangalore</h2>
        
        <div class="restaurant-grid">
            
            <% 
                List<Restaurant> restaurantList = (List<Restaurant>) request.getAttribute("restaurantList");
                if (restaurantList != null && !restaurantList.isEmpty()) {
                    for (Restaurant r : restaurantList) {
            %>
            <!-- Dynamic Restaurant Card -->
            <a href="menu.html?id=<%= r.getRestaurantId() %>" class="card">
                <div class="card-img-container">
                    <!-- Default to a placeholder if imagePath is broken -->
                    <img src="<%= r.getImagePath() %>" class="card-img" alt="<%= r.getName() %>" onerror="this.src='https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3'">
                </div>
                <div class="res-name"><%= r.getName() %></div>
                <div class="res-info">
                    <span class="rating-badge" style="<%= r.getRating() >= 4.0 ? "background-color: #24963f;" : "background-color: #db7c38;" %>">
                        <i class="fa-solid fa-star" style="font-size:10px"></i> <%= r.getRating() %>
                    </span>
                    <span>• <%= r.getDeliveryTime() %> mins</span>
                </div>
                <div class="res-cuisines"><%= r.getCuisineType() %></div>
                <div class="res-loc"><%= r.getAddress() %></div>
            </a>
            <% 
                    }
                } else {
            %>
                <p>No restaurants found. Please try again later.</p>
            <% 
                } 
            %>

        </div>
    </div>

</body>
</html>
