🍔 FoodyVibes
FoodyVibes is a full-stack food ordering web application built with Java Servlets, JSP, and MySQL, featuring a premium, Zomato/Swiggy-style UI — from browsing restaurants and menus, to cart management, checkout, and order confirmation.


✨ Features
🏠 Browse restaurants with ratings, cuisines, and delivery time
🍽️ View restaurant menus with search, sort, and availability filters
🛒 Add to cart, update quantities, and remove items
💳 Checkout with delivery details and multiple payment options (COD / UPI / Card)
✅ Animated order confirmation with live order tracking UI
🔐 User registration & login
📱 Fully responsive, mobile-friendly design


🛠️ Tech Stack
Layer
Technology
Frontend
JSP, HTML5, CSS3, JavaScript (vanilla)
Backend
Java Servlets (Jakarta EE)
Database
MySQL
Server
Apache Tomcat 10.1
IDE
Eclipse (Dynamic Web Project)
Fonts/Icons
Google Fonts (Poppins), Font Awesome



📂 Project Structure
foodyvibes/

├── src/main/java/com/tap/

│   ├── controller/        # Servlets (RestaurantServlet, MenuServlet, CartServlet, CheckoutServlet, LoginServlet, RegisterServlet, HomeServlet)

│   ├── model/              # POJOs (Restaurant, Menu, Cart, CartItem, User)

│   └── util/                # DBConnection.java

├── src/main/webapp/

│   ├── assets/css/style.css   # Shared design system (colors, fonts, components)

│   ├── restaurant.jsp         # Home / restaurant listing page

│   ├── menu.jsp                # Restaurant menu page

│   ├── cart.jsp                 # Shopping cart

│   ├── checkout.jsp             # Delivery + payment

│   ├── order-confirmation.jsp   # Order success page

│   ├── login.html

│   ├── register.html

│   └── index.jsp                # Redirects to /home

├── dummy_data.sql             # Sample seed data

├── add_more_data.sql          # Additional seed data

└── README.md


🚏 Servlet Routes
Route
Servlet
Purpose
/home
HomeServlet
Landing redirect
/restaurants
RestaurantServlet
List all restaurants
/menu
MenuServlet
Show menu for a restaurant (restaurantId)
/cart
CartServlet
Add / update / remove cart items (menuId, restaurantId, quantity, action)
/checkoutServlet
CheckoutServlet
Place order (paymentMode, fullName, mobileNumber, deliveryAddress)
/loginServlet
LoginServlet
User login (username, password)
/registerServlet
RegisterServlet
User registration (username, email, password, address)



🚀 Getting Started (Eclipse + Tomcat)
Prerequisites
Java JDK 21
Eclipse IDE for Enterprise Java Developers
Apache Tomcat 10.1 (configured as a server in Eclipse)
MySQL Server
1. Clone the repo
git clone https://github.com/israinamdar493-ops/foodyvibes.git
2. Import into Eclipse
File → Import → Existing Projects into Workspace → select the cloned folder.
3. Set up the database
Create a MySQL database named foodyvibes
Run dummy_data.sql (and optionally add_more_data.sql) to seed sample data
4. Configure DB credentials
Edit src/main/java/com/tap/util/DBConnection.java with your local MySQL username/password:

private static final String URL = "jdbc:mysql://localhost:3306/foodyvibes";

private static final String USER = "root";

private static final String PASSWORD = "your_password";
5. Run on Tomcat
Right-click the project → Run As → Run on Server → select your configured Tomcat 10.1 server.
6. Open in browser
http://localhost:8080/foodyvibes/home


🎨 Design System
Font: Poppins
Primary: #FF6B35 · Secondary: #FFC107 · Accent: #E53935
Background: #FFF8F2 · Cards: #FFFFFF
Shared tokens and reusable components live in assets/css/style.css


📌 Notes
index.jsp simply redirects to /home and is intentionally left unchanged.
All backend contracts (form field names, request parameters, servlet routes) are preserved as-is across the redesign.


