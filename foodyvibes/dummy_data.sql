-- 1. Create the Database
CREATE DATABASE IF NOT EXISTS foodyvibes;
USE foodyvibes;

-- 2. Create the Tables

CREATE TABLE IF NOT EXISTS User (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(100) NOT NULL,
    Password VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Address TEXT,
    Role VARCHAR(50),
    CreatedDate DATETIME,
    LastLoginDate DATETIME
);

CREATE TABLE IF NOT EXISTS Restaurant (
    RestaurantID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    CuisineType VARCHAR(255),
    DeliveryTime INT,
    Address TEXT,
    Rating DECIMAL(3, 1),
    IsActive BOOLEAN,
    ImagePath VARCHAR(500)
);

CREATE TABLE IF NOT EXISTS Menu (
    MenuID INT AUTO_INCREMENT PRIMARY KEY,
    RestaurantID INT,
    ItemName VARCHAR(255) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2),
    IsAvailable BOOLEAN,
    ImagePath VARCHAR(500),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID)
);

CREATE TABLE IF NOT EXISTS OrderTable (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    RestaurantID INT,
    OrderDate DATETIME,
    TotalAmount DECIMAL(10, 2),
    Status VARCHAR(50),
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID)
);

CREATE TABLE IF NOT EXISTS OrderItem (
    OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    MenuID INT,
    Quantity INT,
    ItemTotal DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES OrderTable(OrderID),
    FOREIGN KEY (MenuID) REFERENCES Menu(MenuID)
);

-- 3. Insert Dummy Data for Restaurants
INSERT INTO Restaurant (Name, CuisineType, DeliveryTime, Address, Rating, IsActive, ImagePath) VALUES
('Meghana Foods', 'Biryani, Andhra', 35, 'Koramangala, Bangalore', 4.5, true, 'https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/1a8dfa8b2a73ddf7c6193465ab24c898'),
('Truffles', 'American, Burgers', 45, 'Indiranagar, Bangalore', 4.6, true, 'https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/cd832b6167eb9f88aeb1ccdebf38d942'),
('Empire Restaurant', 'North Indian, Mughlai', 40, 'Church Street, Bangalore', 4.1, true, 'https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/un4omn7rcunkmlw6vikr'),
('A2B - Adyar Ananda Bhavan', 'South Indian, Sweets', 25, 'Jayanagar, Bangalore', 4.3, true, 'https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/yyrjmolofvyl4hhtcqwz'),
('KFC', 'American, Fast Food', 30, 'BTM Layout, Bangalore', 4.0, true, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJBKPv09De4gHtgmC2_wCdv-HYwKLO9IIN1BjtOnL8UCgp-vAIBzSW8hU&s=10'),
('Domino''s Pizza', 'Pizzas, Italian', 30, 'HSR Layout, Bangalore', 4.2, true, 'https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/d0450ce1a6ba19ea60cd724471ed34ba');

-- 4. Insert Dummy Data for Menus
INSERT INTO Menu (RestaurantID, ItemName, Description, Price, IsAvailable, ImagePath) VALUES
(1, 'Chicken Boneless Biryani', 'Authentic Andhra style boneless chicken biryani', 350.00, true, 'https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_208,h_208,c_fit/d86895c258ba4a706e236adca1c1ee05'),
(1, 'Paneer Biryani', 'Flavorful biryani made with soft paneer cubes', 280.00, true, 'https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_208,h_208,c_fit/7f3a9e38f5f6d892ba3f721bc68cf0bc'),
(1, 'Chilli Chicken', 'Spicy deep fried chicken starter', 250.00, true, 'https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_208,h_208,c_fit/cc32e854128526ee8ec77cfb918ed93a'),

(2, 'All American Cheese Burger', 'Classic beef/chicken burger with lots of cheese', 220.00, true, 'https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_208,h_208,c_fit/97828062829288e2c0792ce17b2b8e3a'),
(2, 'Ferrero Rocher Shake', 'Thick chocolate shake blended with ferrero rocher', 190.00, true, 'https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_208,h_208,c_fit/9d5a71a067fec4e93fb22ce91fbce3f0'),

(3, 'Grilled Chicken (Half)', 'Signature empire style grilled chicken', 260.00, true, 'https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_208,h_208,c_fit/3697e3fc24ba16a9ddcf30bcfa3c560f'),
(3, 'Coin Parotta', 'Soft and flaky bite-sized parottas', 80.00, true, 'https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_208,h_208,c_fit/d8142340dfce5e0df7e2ed1f4f8cbef3'),

(4, 'Masala Dosa', 'Crispy dosa served with potato curry and chutneys', 120.00, true, 'https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_208,h_208,c_fit/c4ee7945d475cf26f8d095d36e2f5bde'),
(4, 'Mini Meals', 'A perfect quick south indian lunch', 150.00, true, 'https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_208,h_208,c_fit/d867c41ebdd8d40af339c972ea255e5c'),

(5, 'Hot & Crispy Chicken (4 pc)', 'Signature KFC spicy crispy fried chicken', 399.00, true, 'https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_208,h_208,c_fit/2c83ff1c8b746816ec5b3762c937171e'),

(6, 'Farmhouse Pizza', 'Loaded with crisp capsicum, succulent mushrooms and fresh tomatoes', 450.00, true, 'https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_208,h_208,c_fit/bdcd233971b7c81bf77e1fa4471280eb');
