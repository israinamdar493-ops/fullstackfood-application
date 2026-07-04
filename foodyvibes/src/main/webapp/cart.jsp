<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.Cart" %>
<%@ page import="com.tap.model.CartItem" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart - FoodyVibes</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #FF6B35;
            --secondary: #FFC107;
            --bg-color: #FFF8F2;
            --text-dark: #1C1C1C;
            --text-muted: #6B6B6B;
            --white: #FFFFFF;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
        body { background-color: #f4f4f5; color: var(--text-dark); min-height: 100vh; display: flex; flex-direction: column; }

        /* Navbar */
        .navbar { display: flex; justify-content: space-between; align-items: center; padding: 15px 8%; box-shadow: 0 4px 15px rgba(0,0,0,0.05); position: sticky; top: 0; background: var(--white); z-index: 1000; }
        .logo { font-size: 26px; font-weight: 800; color: var(--primary); text-decoration: none; display: flex; align-items: center; gap: 12px; }
        .nav-links { display: flex; gap: 30px; list-style: none; align-items: center; }
        .nav-links a { text-decoration: none; color: var(--text-dark); font-weight: 500; font-size: 16px; display: flex; align-items: center; gap: 8px; transition: color 0.3s; }
        .nav-links a:hover, .nav-links a.active { color: var(--primary); }
        .nav-btn { background: var(--primary); color: var(--white) !important; padding: 8px 20px; border-radius: 25px; transition: background 0.3s, transform 0.2s; }
        .nav-btn:hover { background: #e45a24; transform: translateY(-2px); }

        /* Layout */
        .container { padding: 40px 8%; display: flex; gap: 30px; align-items: flex-start; max-width: 1300px; margin: 0 auto; width: 100%; flex: 1; }
        .left-col { flex: 2; display: flex; flex-direction: column; gap: 20px; }
        .right-col { flex: 1; position: sticky; top: 100px; }

        /* Empty Cart */
        .empty-cart { background: var(--white); border-radius: 20px; padding: 60px 20px; text-align: center; box-shadow: 0 4px 15px rgba(0,0,0,0.03); }
        .empty-cart img { width: 250px; margin-bottom: 20px; }
        .empty-cart h2 { font-size: 24px; font-weight: 700; margin-bottom: 10px; color: var(--text-dark); }
        .empty-cart p { color: var(--text-muted); margin-bottom: 30px; }
        .btn-home { background: var(--primary); color: var(--white); padding: 12px 30px; text-decoration: none; border-radius: 30px; font-weight: 600; display: inline-block; transition: background 0.3s; }
        .btn-home:hover { background: #e45a24; }

        /* Cart Cards */
        .cart-header { background: var(--white); padding: 25px 30px; border-radius: 16px; box-shadow: 0 4px 15px rgba(0,0,0,0.03); display: flex; align-items: center; gap: 15px; }
        .cart-header h2 { font-size: 22px; font-weight: 700; color: var(--text-dark); margin: 0; }
        .cart-header .badge { background: var(--bg-color); color: var(--primary); padding: 5px 12px; border-radius: 20px; font-size: 14px; font-weight: 600; }

        .cart-items { background: var(--white); border-radius: 16px; box-shadow: 0 4px 15px rgba(0,0,0,0.03); overflow: hidden; }
        .cart-item { display: flex; align-items: center; padding: 25px 30px; border-bottom: 1px solid #f0f0f0; gap: 20px; transition: background 0.2s; }
        .cart-item:last-child { border-bottom: none; }
        .cart-item:hover { background: #fafafa; }
        
        .item-img { width: 80px; height: 80px; border-radius: 12px; object-fit: cover; border: 1px solid #f0f0f0; }
        
        .item-details { flex: 1; }
        .item-details h4 { font-size: 16px; font-weight: 600; color: var(--text-dark); margin-bottom: 5px; }
        .item-price { font-size: 15px; font-weight: 700; color: var(--text-dark); }
        
        .qty-controls { display: flex; align-items: center; border: 1px solid #e9e9eb; border-radius: 8px; overflow: hidden; background: var(--white); height: 36px; }
        .qty-btn { background: none; border: none; width: 32px; height: 100%; color: var(--primary); font-size: 14px; cursor: pointer; transition: background 0.2s; }
        .qty-btn:hover { background: var(--bg-color); }
        .qty-val { width: 32px; text-align: center; font-size: 14px; font-weight: 600; border-left: 1px solid #e9e9eb; border-right: 1px solid #e9e9eb; line-height: 36px; color: var(--text-dark); }
        
        .item-total { font-size: 18px; font-weight: 700; color: var(--text-dark); width: 80px; text-align: right; }

        /* Bill Summary */
        .bill-card { background: var(--white); border-radius: 16px; box-shadow: 0 4px 15px rgba(0,0,0,0.03); overflow: hidden; }
        .bill-header { padding: 20px 25px; border-bottom: 1px solid #f0f0f0; }
        .bill-header h3 { font-size: 18px; font-weight: 700; color: var(--text-dark); }
        
        .bill-body { padding: 25px; }
        .bill-row { display: flex; justify-content: space-between; margin-bottom: 15px; font-size: 14px; color: var(--text-muted); }
        .bill-row:last-child { margin-bottom: 0; }
        .bill-val { font-weight: 500; color: var(--text-dark); }
        
        .bill-total { display: flex; justify-content: space-between; padding: 20px 25px; background: #fafafa; border-top: 1px dashed #e9e9eb; font-size: 18px; font-weight: 700; color: var(--text-dark); }
        
        .btn-checkout { display: block; width: 100%; background: var(--primary); color: var(--white); text-align: center; padding: 18px; font-size: 16px; font-weight: 700; text-transform: uppercase; border: none; cursor: pointer; transition: background 0.3s; text-decoration: none; }
        .btn-checkout:hover { background: #e45a24; }

        @media (max-width: 992px) {
            .container { flex-direction: column; }
            .left-col, .right-col { width: 100%; }
            .right-col { position: static; }
        }
        @media (max-width: 576px) {
            .cart-item { flex-direction: column; align-items: flex-start; }
            .qty-controls { margin-top: 10px; }
            .item-total { text-align: left; margin-top: 10px; }
        }
    </style>
</head>
<body>

    <!-- Navigation -->
    <nav class="navbar">
        <a href="restaurants" class="logo"><i class="fa-solid fa-fire-burner"></i> FoodyVibes</a>
        <ul class="nav-links">
            <li><a href="restaurants"><i class="fa-solid fa-house"></i> Home</a></li>
            <li><a href="cart.jsp" class="active"><i class="fa-solid fa-cart-shopping"></i> Cart</a></li>
            <li><a href="login.html" class="nav-btn"><i class="fa-regular fa-user"></i> Sign In</a></li>
        </ul>
    </nav>

    <div class="container">
        <% 
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null || cart.getItems().isEmpty()) {
        %>
            <!-- Empty Cart -->
            <div class="empty-cart" style="width:100%;">
                <img src="https://cdni.iconscout.com/illustration/premium/thumb/empty-cart-2130356-1800917.png" alt="Empty Cart">
                <h2>Your cart is empty</h2>
                <p>Looks like you haven't added anything to your cart yet.</p>
                <a href="restaurants" class="btn-home">Explore Restaurants</a>
            </div>
        <%
            } else {
                Map<Integer, CartItem> items = cart.getItems();
                double itemTotal = 0;
                double deliveryFee = 40.0;
                double platformFee = 5.0;
        %>
            <!-- Left Column: Cart Items -->
            <div class="left-col">
                <div class="cart-header">
                    <h2><i class="fa-solid fa-basket-shopping"></i> Order Details</h2>
                    <span class="badge"><%= items.size() %> items</span>
                </div>
                
                <div class="cart-items">
                    <% for (Map.Entry<Integer, CartItem> entry : items.entrySet()) {
                        CartItem item = entry.getValue();
                        itemTotal += item.getTotalPrice();
                    %>
                    <div class="cart-item">
                        <img src="https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=150&auto=format&fit=crop" class="item-img" alt="Food">
                        
                        <div class="item-details">
                            <h4><%= item.getName() %></h4>
                            <div class="item-price">₹<%= item.getPrice() %></div>
                        </div>
                        
                        <div class="qty-controls">
                            <!-- Minus Button -->
                            <form action="cart" method="GET" style="margin: 0; height: 100%;">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="menuId" value="<%= item.getItemId() %>">
                                <input type="hidden" name="quantity" value="<%= item.getQuantity() - 1 %>">
                                <button type="submit" class="qty-btn"><i class="fa-solid fa-minus"></i></button>
                            </form>
                            
                            <!-- Current Qty -->
                            <div class="qty-val"><%= item.getQuantity() %></div>
                            
                            <!-- Plus Button -->
                            <form action="cart" method="GET" style="margin: 0; height: 100%;">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="menuId" value="<%= item.getItemId() %>">
                                <input type="hidden" name="quantity" value="<%= item.getQuantity() + 1 %>">
                                <button type="submit" class="qty-btn"><i class="fa-solid fa-plus"></i></button>
                            </form>
                        </div>
                        
                        <div class="item-total">
                            ₹<%= item.getTotalPrice() %>
                        </div>
                        
                        <!-- Remove Item -->
                        <form action="cart" method="GET" style="margin: 0;">
                            <input type="hidden" name="action" value="remove">
                            <input type="hidden" name="menuId" value="<%= item.getItemId() %>">
                            <button type="submit" style="background:none; border:none; color:var(--text-muted); cursor:pointer; font-size:18px; padding:10px;"><i class="fa-solid fa-trash-can"></i></button>
                        </form>
                    </div>
                    <% } %>
                </div>
            </div>
            
            <!-- Right Column: Bill Summary -->
            <div class="right-col">
                <div class="bill-card">
                    <div class="bill-header">
                        <h3>Bill Details</h3>
                    </div>
                    <div class="bill-body">
                        <div class="bill-row">
                            <span>Item Total</span>
                            <span class="bill-val">₹<%= String.format("%.2f", itemTotal) %></span>
                        </div>
                        <div class="bill-row">
                            <span>Delivery Fee</span>
                            <span class="bill-val">₹<%= String.format("%.2f", deliveryFee) %></span>
                        </div>
                        <div class="bill-row">
                            <span>Platform Fee</span>
                            <span class="bill-val">₹<%= String.format("%.2f", platformFee) %></span>
                        </div>
                    </div>
                    <div class="bill-total">
                        <span>TO PAY</span>
                        <span>₹<%= String.format("%.2f", itemTotal + deliveryFee + platformFee) %></span>
                    </div>
                    <%
                        // Set the finalAmount in session so CheckoutServlet doesn't have to recalculate (consistent with current logic)
                        session.setAttribute("finalAmount", itemTotal + deliveryFee + platformFee);
                    %>
                    <a href="checkout.jsp" class="btn-checkout">Proceed to Checkout</a>
                </div>
            </div>
        <% } %>
    </div>

</body>
</html>
