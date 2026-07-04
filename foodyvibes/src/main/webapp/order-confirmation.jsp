<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed - FoodyVibes</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #FF6B35;
            --success: #1ba672;
            --success-dark: #128056;
            --bg-color: #FFF8F2;
            --text-dark: #1C1C1C;
            --text-muted: #6B6B6B;
            --white: #FFFFFF;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
        body { background: var(--bg-color); color: var(--text-dark); min-height: 100vh; display: flex; flex-direction: column; }

        /* Navbar */
        .navbar { display: flex; justify-content: space-between; align-items: center; padding: 15px 8%; box-shadow: 0 4px 15px rgba(0,0,0,0.05); background: var(--white); }
        .logo { font-size: 26px; font-weight: 800; color: var(--primary); text-decoration: none; display: flex; align-items: center; gap: 12px; }

        /* Main Content */
        .main { flex: 1; display: flex; align-items: center; justify-content: center; padding: 50px 20px; }

        .confirm-card {
            background: var(--white); border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.08);
            max-width: 580px; width: 100%; overflow: hidden;
            animation: slideUp 0.6s cubic-bezier(0.16, 1, 0.3, 1);
            border: 1px solid rgba(0,0,0,0.05);
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(40px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        /* Success Banner */
        .success-banner {
            background: linear-gradient(135deg, var(--success), var(--success-dark));
            padding: 50px 30px; text-align: center; color: var(--white); position: relative; overflow: hidden;
        }
        
        .success-banner::after {
            content: ''; position: absolute; width: 300px; height: 300px;
            background: rgba(255,255,255,0.05); border-radius: 50%;
            top: -150px; right: -100px; pointer-events: none;
        }

        .check-circle {
            width: 90px; height: 90px; border-radius: 50%; background: rgba(255,255,255,0.2);
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 25px; font-size: 40px;
            animation: pop 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275) 0.3s both;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1); backdrop-filter: blur(5px);
        }
        @keyframes pop {
            from { transform: scale(0); opacity: 0; }
            to   { transform: scale(1); opacity: 1; }
        }
        
        .success-banner h1 { font-size: 32px; font-weight: 700; margin-bottom: 10px; }
        .success-banner p { font-size: 16px; opacity: 0.9; font-weight: 300; }

        /* Order Details */
        .order-details { padding: 40px 35px 30px; }
        .detail-row { display: flex; justify-content: space-between; align-items: center; padding: 16px 0; border-bottom: 1px dashed #e9e9eb; }
        .detail-row:last-child { border-bottom: none; }
        
        .detail-label { font-size: 14px; color: var(--text-muted); font-weight: 500; display: flex; align-items: center; gap: 10px; }
        .detail-label i { color: var(--primary); width: 16px; text-align: center; font-size: 16px; }
        
        .detail-value { font-size: 15px; font-weight: 600; color: var(--text-dark); }
        .order-id-badge { background: #fff4ed; color: var(--primary); border-radius: 8px; padding: 6px 15px; font-size: 15px; font-weight: 700; letter-spacing: 0.5px; }

        /* Status pill */
        .status-pending { background: #fff8e1; color: #f57f17; border-radius: 20px; padding: 5px 15px; font-size: 13px; font-weight: 600; display: inline-flex; align-items: center; gap: 8px; }

        /* Tracking */
        .tracking-section { background: #fafafa; padding: 30px 35px; border-top: 1px solid #f0f0f0; border-bottom: 1px solid #f0f0f0; }
        .tracking-title { font-size: 15px; font-weight: 700; color: var(--text-dark); margin-bottom: 25px; }
        
        .track-steps { display: flex; justify-content: space-between; position: relative; }
        .track-steps::before {
            content: ''; position: absolute; top: 16px; left: 10%; right: 10%;
            height: 3px; background: #e9e9eb; z-index: 0; border-radius: 2px;
        }
        
        .track-step { display: flex; flex-direction: column; align-items: center; gap: 10px; flex: 1; position: relative; z-index: 1; }
        .track-dot { width: 34px; height: 34px; border-radius: 50%; border: 3px solid #e9e9eb; background: var(--white); display: flex; align-items: center; justify-content: center; font-size: 14px; transition: all 0.3s; color: #ccc; }
        .track-dot.active { border-color: var(--primary); color: var(--primary); box-shadow: 0 0 0 4px rgba(255,107,53,0.1); }
        .track-dot.done { border-color: var(--success); background: var(--success); color: var(--white); }
        
        .track-label { font-size: 12px; color: var(--text-muted); text-align: center; font-weight: 500; }
        .track-label.active { color: var(--primary); font-weight: 700; }
        .track-label.done { color: var(--success); font-weight: 700; }

        /* Actions */
        .actions { padding: 30px 35px; display: flex; gap: 15px; }
        .btn { flex: 1; padding: 16px; border-radius: 12px; font-size: 15px; font-weight: 600; cursor: pointer; text-decoration: none; text-align: center; transition: all 0.3s; display: flex; align-items: center; justify-content: center; gap: 8px; }
        .btn-primary { background: var(--primary); color: var(--white); border: none; box-shadow: 0 4px 15px rgba(255,107,53,0.2); }
        .btn-primary:hover { background: #e45a24; transform: translateY(-2px); box-shadow: 0 6px 20px rgba(255,107,53,0.3); }
        .btn-outline { background: var(--white); color: var(--text-dark); border: 2px solid #e9e9eb; }
        .btn-outline:hover { border-color: var(--primary); color: var(--primary); transform: translateY(-2px); }

    </style>
</head>
<body>

<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    Integer orderId = (Integer) request.getAttribute("orderId");
    Double finalAmount = (Double) request.getAttribute("finalAmount");
    String paymentMode = (String) request.getAttribute("paymentMode");

    if (orderId == null) orderId = 0;
    if (finalAmount == null) finalAmount = 0.0;
    if (paymentMode == null) paymentMode = "N/A";
%>

    <nav class="navbar">
        <a href="restaurants" class="logo"><i class="fa-solid fa-fire-burner"></i> FoodyVibes</a>
    </nav>

    <div class="main">
        <div class="confirm-card">

            <!-- Success Banner -->
            <div class="success-banner">
                <div class="check-circle">
                    <i class="fa-solid fa-check"></i>
                </div>
                <h1>Order Placed!</h1>
                <p>Your food is being prepared and will be with you shortly.</p>
            </div>

            <!-- Order Details -->
            <div class="order-details">
                <div class="detail-row">
                    <span class="detail-label"><i class="fa-solid fa-hashtag"></i> Order ID</span>
                    <span class="order-id-badge">#FV<%= String.format("%05d", orderId) %></span>
                </div>
                <% if (loggedInUser != null) { %>
                <div class="detail-row">
                    <span class="detail-label"><i class="fa-regular fa-user"></i> Customer</span>
                    <span class="detail-value"><%= loggedInUser.getUsername() %></span>
                </div>
                <% } %>
                <div class="detail-row">
                    <span class="detail-label"><i class="fa-solid fa-indian-rupee-sign"></i> Amount Paid</span>
                    <span class="detail-value">₹<%= String.format("%.0f", finalAmount) %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label"><i class="fa-solid fa-wallet"></i> Payment Mode</span>
                    <span class="detail-value"><%= paymentMode %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label"><i class="fa-solid fa-circle-info"></i> Status</span>
                    <span class="status-pending"><i class="fa-solid fa-clock-rotate-left"></i> Preparing</span>
                </div>
            </div>

            <!-- Live Tracking Indicator -->
            <div class="tracking-section">
                <div class="tracking-title">Track your order</div>
                <div class="track-steps">
                    <div class="track-step">
                        <div class="track-dot done"><i class="fa-solid fa-check"></i></div>
                        <div class="track-label done">Confirmed</div>
                    </div>
                    <div class="track-step">
                        <div class="track-dot active"><i class="fa-solid fa-fire-burner"></i></div>
                        <div class="track-label active">Preparing</div>
                    </div>
                    <div class="track-step">
                        <div class="track-dot"><i class="fa-solid fa-motorcycle"></i></div>
                        <div class="track-label">On the way</div>
                    </div>
                    <div class="track-step">
                        <div class="track-dot"><i class="fa-solid fa-house-chimney"></i></div>
                        <div class="track-label">Delivered</div>
                    </div>
                </div>
            </div>

            <!-- Actions -->
            <div class="actions">
                <a href="restaurants" class="btn btn-outline"><i class="fa-solid fa-arrow-left"></i> Go Home</a>
                <a href="restaurants" class="btn btn-primary"><i class="fa-solid fa-plus"></i> Order More</a>
            </div>

        </div>
    </div>

</body>
</html>
