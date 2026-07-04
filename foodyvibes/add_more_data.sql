USE foodyvibes;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE OrderItem;
TRUNCATE TABLE OrderTable;
TRUNCATE TABLE Menu;
TRUNCATE TABLE Restaurant;
SET FOREIGN_KEY_CHECKS = 1;

-- Insert Restaurants
INSERT INTO Restaurant (Name, CuisineType, DeliveryTime, Address, Rating, IsActive, ImagePath) VALUES
('Meghana Foods', 'Biryani, Andhra', 35, 'Koramangala, Bangalore', 4.8, true, 'https://images.unsplash.com/photo-1631515243349-e0cb75fb8d3a?w=800&auto=format&fit=crop'),
('Truffles', 'American, Burgers', 45, 'Indiranagar, Bangalore', 4.6, true, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800&auto=format&fit=crop'),
('Empire Restaurant', 'North Indian, Mughlai', 40, 'Church Street, Bangalore', 4.2, true, 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800&auto=format&fit=crop'),
('A2B - Adyar Ananda Bhavan', 'South Indian, Sweets', 25, 'Jayanagar, Bangalore', 4.3, true, 'https://images.unsplash.com/photo-1610192244261-3f33de3f55e4?w=800&auto=format&fit=crop'),
('KFC', 'American, Fast Food', 30, 'BTM Layout, Bangalore', 4.0, true, 'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?w=800&auto=format&fit=crop'),
('Domino''s Pizza', 'Pizzas, Italian', 30, 'HSR Layout, Bangalore', 4.2, true, 'https://images.unsplash.com/photo-1513104890d38-7c7f4ae6e040?w=800&auto=format&fit=crop'),
('McDonald''s', 'Burgers, Fast Food', 20, 'MG Road, Bangalore', 4.1, true, 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=800&auto=format&fit=crop'),
('Subway', 'Healthy Food, Salads, Sandwiches', 25, 'Koramangala, Bangalore', 4.3, true, 'https://images.unsplash.com/photo-1549931319-a545dcf3bc73?w=800&auto=format&fit=crop');

-- Insert Menu Items
-- Meghana Foods (ID: 1)
INSERT INTO Menu (RestaurantID, ItemName, Description, Price, IsAvailable, ImagePath) VALUES
(1, 'Chicken Boneless Biryani', 'Authentic Andhra style boneless chicken biryani', 350.00, true, 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=800&auto=format&fit=crop'),
(1, 'Paneer Biryani', 'Flavorful biryani made with soft paneer cubes', 280.00, true, 'https://images.unsplash.com/photo-1631515242808-4d5162a8cb92?w=800&auto=format&fit=crop'),
(1, 'Chilli Chicken', 'Spicy deep fried chicken starter', 250.00, true, 'https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?w=800&auto=format&fit=crop'),
(1, 'Mutton Biryani', 'Classic slow-cooked mutton biryani with aromatic spices', 450.00, true, 'https://images.unsplash.com/photo-1589302168068-964664d93cb0?w=800&auto=format&fit=crop');

-- Truffles (ID: 2)
INSERT INTO Menu (RestaurantID, ItemName, Description, Price, IsAvailable, ImagePath) VALUES
(2, 'All American Cheese Burger', 'Classic beef/chicken burger with lots of cheese', 220.00, true, 'https://images.unsplash.com/photo-1586190848861-99aa4a171e90?w=800&auto=format&fit=crop'),
(2, 'Ferrero Rocher Shake', 'Thick chocolate shake blended with ferrero rocher', 190.00, true, 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=800&auto=format&fit=crop'),
(2, 'Peri Peri Fries', 'Crispy fries tossed in spicy peri peri mix', 140.00, true, 'https://images.unsplash.com/photo-1576107232684-1279f390859f?w=800&auto=format&fit=crop'),
(2, 'Veggie Burger', 'A wholesome veggie patty burger', 180.00, true, 'https://images.unsplash.com/photo-1520072959219-c595dc870360?w=800&auto=format&fit=crop');

-- Empire Restaurant (ID: 3)
INSERT INTO Menu (RestaurantID, ItemName, Description, Price, IsAvailable, ImagePath) VALUES
(3, 'Grilled Chicken (Half)', 'Signature empire style grilled chicken', 260.00, true, 'https://images.unsplash.com/photo-1598514982205-f36b96d1e8d4?w=800&auto=format&fit=crop'),
(3, 'Coin Parotta', 'Soft and flaky bite-sized parottas', 80.00, true, 'https://images.unsplash.com/photo-1606491956689-2ea866880c84?w=800&auto=format&fit=crop'),
(3, 'Chicken Shawarma', 'Classic Lebanese style chicken shawarma', 120.00, true, 'https://images.unsplash.com/photo-1662116766155-2d93e17bc565?w=800&auto=format&fit=crop');

-- A2B (ID: 4)
INSERT INTO Menu (RestaurantID, ItemName, Description, Price, IsAvailable, ImagePath) VALUES
(4, 'Masala Dosa', 'Crispy dosa served with potato curry and chutneys', 120.00, true, 'https://images.unsplash.com/photo-1589301760014-d929f39ce9b1?w=800&auto=format&fit=crop'),
(4, 'South Indian Thali', 'A perfect quick south indian lunch', 150.00, true, 'https://images.unsplash.com/photo-1626776876729-abdf8b2c4e97?w=800&auto=format&fit=crop'),
(4, 'Idli Vada Combo', 'Soft idlis paired with a crispy medu vada', 90.00, true, 'https://images.unsplash.com/photo-1610192244261-3f33de3f55e4?w=800&auto=format&fit=crop');

-- KFC (ID: 5)
INSERT INTO Menu (RestaurantID, ItemName, Description, Price, IsAvailable, ImagePath) VALUES
(5, 'Hot & Crispy Chicken (4 pc)', 'Signature KFC spicy crispy fried chicken', 399.00, true, 'https://images.unsplash.com/photo-1626082896492-766af4eb65ed?w=800&auto=format&fit=crop'),
(5, 'Zinger Burger', 'The classic crispy chicken zinger burger', 189.00, true, 'https://images.unsplash.com/photo-1615719413546-198b25453f85?w=800&auto=format&fit=crop'),
(5, 'Popcorn Chicken', 'Bite-sized crispy chicken pieces', 139.00, true, 'https://images.unsplash.com/photo-1562967914-01efa7e87832?w=800&auto=format&fit=crop');

-- Domino's Pizza (ID: 6)
INSERT INTO Menu (RestaurantID, ItemName, Description, Price, IsAvailable, ImagePath) VALUES
(6, 'Farmhouse Pizza', 'Loaded with crisp capsicum, succulent mushrooms and fresh tomatoes', 450.00, true, 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800&auto=format&fit=crop'),
(6, 'Peppy Paneer Pizza', 'Chunky paneer with crisp capsicum and spicy red pepper', 420.00, true, 'https://images.unsplash.com/photo-1513104890d38-7c7f4ae6e040?w=800&auto=format&fit=crop'),
(6, 'Garlic Breadsticks', 'The signature freshly baked garlic bread', 110.00, true, 'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?w=800&auto=format&fit=crop');

-- McDonald's (ID: 7)
INSERT INTO Menu (RestaurantID, ItemName, Description, Price, IsAvailable, ImagePath) VALUES
(7, 'McAloo Tikki Burger', 'The classic Indian potato patty burger', 65.00, true, 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=800&auto=format&fit=crop'),
(7, 'McSpicy Chicken Burger', 'Spicy and crispy chicken patty burger', 189.00, true, 'https://images.unsplash.com/photo-1603064752734-4c48eff53d05?w=800&auto=format&fit=crop'),
(7, 'French Fries (Large)', 'World famous crispy french fries', 120.00, true, 'https://images.unsplash.com/photo-1576107232684-1279f390859f?w=800&auto=format&fit=crop');

-- Subway (ID: 8)
INSERT INTO Menu (RestaurantID, ItemName, Description, Price, IsAvailable, ImagePath) VALUES
(8, 'Roasted Chicken Sub', 'Healthy 6-inch sub with roasted chicken and veggies', 230.00, true, 'https://images.unsplash.com/photo-1619096252214-ef06c45683e3?w=800&auto=format&fit=crop'),
(8, 'Paneer Tikka Sub', 'Classic paneer tikka combined with fresh veggies', 210.00, true, 'https://images.unsplash.com/photo-1549931319-a545dcf3bc73?w=800&auto=format&fit=crop'),
(8, 'Chocolate Chip Cookie', 'Freshly baked soft chocolate chip cookie', 50.00, true, 'https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=800&auto=format&fit=crop');
