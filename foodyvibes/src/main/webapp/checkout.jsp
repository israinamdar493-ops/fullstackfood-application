<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.Cart" %>
<%@ page import="com.tap.model.CartItem" %>
<%@ page import="com.tap.model.User" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - FoodyVibes</title>
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
        .back-link { display: flex; align-items: center; gap: 8px; color: var(--text-dark); font-size: 15px; font-weight: 600; text-decoration: none; transition: color 0.3s; }
        .back-link:hover { color: var(--primary); }

        /* Layout */
        .container { padding: 40px 8%; display: flex; gap: 30px; align-items: flex-start; max-width: 1300px; margin: 0 auto; width: 100%; flex: 1; }
        .left-col { flex: 2; display: flex; flex-direction: column; gap: 25px; }
        .right-col { flex: 1; position: sticky; top: 100px; }

        /* Card Elements */
        .card { background: var(--white); border-radius: 16px; box-shadow: 0 4px 15px rgba(0,0,0,0.03); overflow: hidden; border: 1px solid #f0f0f0; }
        .card-header { padding: 20px 25px; border-bottom: 1px solid #f0f0f0; display: flex; align-items: center; gap: 15px; background: #fffaf7; }
        .card-header h3 { font-size: 18px; font-weight: 700; color: var(--text-dark); margin: 0; }
        .section-icon { width: 40px; height: 40px; border-radius: 12px; background: var(--primary); color: var(--white); display: flex; align-items: center; justify-content: center; font-size: 16px; box-shadow: 0 4px 10px rgba(255,107,53,0.3); }
        .card-body { padding: 30px 25px; }

        /* Form Styles */
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-size: 13px; font-weight: 600; color: var(--text-muted); margin-bottom: 8px; }
        .form-group input, .form-group textarea {
            width: 100%; padding: 14px 16px; border: 1.5px solid #e9e9eb; border-radius: 10px; font-size: 15px; background: #fafafa; transition: all 0.3s; outline: none; font-family: 'Poppins', sans-serif;
        }
        .form-group input:focus, .form-group textarea:focus { border-color: var(--primary); background: var(--white); box-shadow: 0 0 0 4px rgba(255,107,53,0.1); }
        .form-group textarea { resize: vertical; min-height: 100px; }
        .form-row { display: flex; gap: 20px; }
        .form-row .form-group { flex: 1; }

        /* Payment Options */
        .payment-options { display: flex; flex-direction: column; gap: 15px; }
        .payment-option {
            display: flex; align-items: center; gap: 15px; padding: 16px 20px; border: 1.5px solid #e9e9eb; border-radius: 12px; cursor: pointer; transition: all 0.3s;
        }
        .payment-option:hover { border-color: var(--primary); background: var(--bg-color); }
        .payment-option.selected { border-color: var(--primary); background: var(--bg-color); box-shadow: 0 4px 10px rgba(255,107,53,0.1); }
        .payment-option input[type="radio"] { display: none; }
        .payment-radio { width: 22px; height: 22px; border: 2px solid #d4d5d9; border-radius: 50%; display: flex; align-items: center; justify-content: center; flex-shrink: 0; transition: all 0.3s; background: var(--white); }
        .payment-option.selected .payment-radio { border-color: var(--primary); }
        .payment-radio-dot { width: 10px; height: 10px; border-radius: 50%; background: var(--primary); display: none; }
        .payment-option.selected .payment-radio-dot { display: block; }
        .payment-info { flex: 1; }
        .payment-label { font-size: 16px; font-weight: 600; color: var(--text-dark); }
        .payment-sub { font-size: 13px; color: var(--text-muted); margin-top: 2px; }
        .payment-icon { font-size: 24px; color: #a0a0a0; transition: color 0.3s; }
        .payment-option.selected .payment-icon { color: var(--primary); }

        /* Order Summary (Right Col) */
        .summary-header { padding: 20px 25px; border-bottom: 1px solid #f0f0f0; }
        .summary-header h3 { font-size: 18px; font-weight: 700; color: var(--text-dark); }
        .summary-body { padding: 10px 25px; max-height: 300px; overflow-y: auto; }
        .summary-item { display: flex; justify-content: space-between; align-items: center; padding: 15px 0; border-bottom: 1px dashed #f0f0f0; gap: 15px; }
        .summary-item:last-child { border-bottom: none; }
        .summary-item-name { font-size: 15px; color: var(--text-dark); font-weight: 500; line-height: 1.3; margin-bottom: 4px; }
        .summary-item-qty { font-size: 13px; color: var(--text-muted); font-weight: 500; }
        .summary-item-price { font-size: 15px; font-weight: 600; color: var(--text-dark); white-space: nowrap; }

        /* Bill */
        .bill-section { padding: 20px 25px; background: #fafafa; border-top: 1px solid #f0f0f0; }
        .bill-row { display: flex; justify-content: space-between; font-size: 14px; color: var(--text-muted); margin-bottom: 12px; }
        .bill-total { display: flex; justify-content: space-between; font-size: 18px; font-weight: 700; color: var(--text-dark); margin-top: 15px; padding-top: 15px; border-top: 1px dashed #d4d5d9; }

        /* Place Order Button */
        .btn-place-order {
            display: block; width: 100%; background: var(--primary); color: var(--white);
            text-align: center; padding: 20px; font-size: 16px; font-weight: 700;
            border: none; cursor: pointer; text-transform: uppercase; letter-spacing: 1px;
            transition: all 0.3s;
        }
        .btn-place-order:hover { background: #e45a24; }

        .safety-note { display: flex; align-items: center; justify-content: center; gap: 8px; padding: 15px; background: #f0fdf4; font-size: 13px; color: #24963f; font-weight: 600; text-align: center; border-bottom: 1px solid #d1fae5; }

        @media (max-width: 992px) {
            .container { flex-direction: column; }
            .left-col, .right-col { width: 100%; }
            .right-col { position: static; }
            .form-row { flex-direction: column; gap: 0; }
        }
    </style>
</head>
<body>

<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    Cart cart = (Cart) session.getAttribute("cart");

    if (cart == null || cart.getItems().isEmpty()) {
        response.sendRedirect("cart.jsp");
        return;
    }

    double grandTotal = 0;
    double deliveryFee = 40;
    double platformFee = 5;
    for (CartItem item : cart.getItems().values()) {
        grandTotal += item.getTotalPrice();
    }
    double finalAmount = grandTotal + deliveryFee + platformFee;
    session.setAttribute("finalAmount", finalAmount);
%>

    <nav class="navbar">
        <a href="restaurants" class="logo"><i class="fa-solid fa-fire-burner"></i> FoodyVibes</a>
        <a href="cart.jsp" class="back-link"><i class="fa-solid fa-arrow-left-long"></i> Back to Cart</a>
    </nav>

    <div class="container">
        
        <!-- Left: Forms -->
        <div class="left-col">
            <form action="checkoutServlet" method="post" id="checkout-form">
            
            <!-- Delivery Details -->
            <div class="card" style="margin-bottom: 25px;">
                <div class="card-header">
                    <div class="section-icon"><i class="fa-solid fa-location-dot"></i></div>
                    <h3>Delivery Details</h3>
                </div>
                <div class="card-body">
                    <div class="form-row">
                        <div class="form-group">
                            <label>Full Name</label>
                            <input type="text" name="fullName" value="<%= loggedInUser != null ? loggedInUser.getUsername() : "" %>" placeholder="Enter your full name" required>
                        </div>
                        <div class="form-group">
                            <label>Mobile Number</label>
                            <input type="tel" name="mobileNumber" placeholder="10-digit mobile number" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Delivery Address</label>
                        <textarea name="deliveryAddress" placeholder="House no., Building, Street, Area..." required><%= loggedInUser != null && loggedInUser.getAddress() != null ? loggedInUser.getAddress() : "" %></textarea>
                    </div>
                    <div class="form-group" style="margin-bottom:0;">
                        <label>Landmark (Optional)</label>
                        <input type="text" name="landmark" placeholder="E.g. Near Apollo Hospital">
                    </div>
                </div>
            </div>

            <!-- Payment Method -->
            <div class="card">
                <div class="card-header">
                    <div class="section-icon"><i class="fa-solid fa-wallet"></i></div>
                    <h3>Payment Method</h3>
                </div>
                <div class="card-body">
                    <div class="payment-options">

                        <label class="payment-option selected">
                            <input type="radio" name="paymentMode" value="Cash on Delivery" checked>
                            <div class="payment-radio"><div class="payment-radio-dot"></div></div>
                            <div class="payment-info">
                                <div class="payment-label">Cash on Delivery</div>
                                <div class="payment-sub">Pay in cash when order arrives</div>
                            </div>
                            <i class="fa-solid fa-money-bill-wave payment-icon"></i>
                        </label>

                        <label class="payment-option">
                            <input type="radio" name="paymentMode" value="UPI">
                            <div class="payment-radio"><div class="payment-radio-dot"></div></div>
                            <div class="payment-info">
                                <div class="payment-label">UPI Options</div>
                                <div class="payment-sub">GPay, PhonePe, Paytm</div>
                            </div>
                            <i class="fa-solid fa-mobile-screen-button payment-icon"></i>
                        </label>

                        <label class="payment-option">
                            <input type="radio" name="paymentMode" value="Credit/Debit Card">
                            <div class="payment-radio"><div class="payment-radio-dot"></div></div>
                            <div class="payment-info">
                                <div class="payment-label">Credit / Debit Card</div>
                                <div class="payment-sub">Visa, Mastercard, Rupay</div>
                            </div>
                            <i class="fa-solid fa-credit-card payment-icon"></i>
                        </label>

                    </div>
                </div>
            </div>

            </form>
        </div>

        <!-- Right: Summary -->
        <div class="right-col">
            <div class="card">
                <div class="summary-header">
                    <h3>Order Summary</h3>
                </div>
                
                <div class="summary-body">
                    <% for (Map.Entry<Integer, CartItem> entry : cart.getItems().entrySet()) {
                        CartItem item = entry.getValue();
                    %>
                    <div class="summary-item">
                        <div>
                            <div class="summary-item-name"><%= item.getName() %></div>
                            <div class="summary-item-qty">Qty: <%= item.getQuantity() %></div>
                        </div>
                        <div class="summary-item-price">₹<%= String.format("%.0f", item.getTotalPrice()) %></div>
                    </div>
                    <% } %>
                </div>

                <div class="bill-section">
                    <div class="bill-row">
                        <span>Item Total</span>
                        <span style="font-weight:600; color:var(--text-dark);">₹<%= String.format("%.0f", grandTotal) %></span>
                    </div>
                    <div class="bill-row">
                        <span>Delivery Fee</span>
                        <span style="font-weight:600; color:var(--text-dark);">₹<%= String.format("%.0f", deliveryFee) %></span>
                    </div>
                    <div class="bill-row">
                        <span>Platform Fee</span>
                        <span style="font-weight:600; color:var(--text-dark);">₹<%= String.format("%.0f", platformFee) %></span>
                    </div>
                    <div class="bill-total">
                        <span>Total Amount</span>
                        <span style="color:var(--primary);">₹<%= String.format("%.0f", finalAmount) %></span>
                    </div>
                </div>

                <div class="safety-note">
                    <i class="fa-solid fa-shield-halved"></i>
                    100% Secure Checkout
                </div>

                <button type="submit" form="checkout-form" class="btn-place-order">
                    Place Order • ₹<%= String.format("%.0f", finalAmount) %>
                </button>
            </div>
        </div>

    </div>

    <script>
        // Radio button UI logic
        document.querySelectorAll('.payment-option input[type="radio"]').forEach(function(radio) {
            radio.addEventListener('change', function() {
                document.querySelectorAll('.payment-option').forEach(function(opt) {
                    opt.classList.remove('selected');
                });
                this.closest('.payment-option').classList.add('selected');
            });
        });
    </script>
</body>
</html>
