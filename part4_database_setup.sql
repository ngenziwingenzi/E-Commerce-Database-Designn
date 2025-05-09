-- -----------------------------------------------------
-- Insert sample data for brands
-- -----------------------------------------------------
INSERT INTO brand (brand_name, description) VALUES 
('Nike', 'Global sports apparel and footwear brand'),
('Samsung', 'Electronics manufacturer'),
('IKEA', 'Furniture and home accessories retailer');

-- -----------------------------------------------------
-- Insert sample data for product categories
-- -----------------------------------------------------
INSERT INTO product_category (category_name, description, parent_category_id) VALUES 
('Electronics', 'Electronic devices and accessories', NULL),
('Clothing', 'Apparel and fashion items', NULL),
('Home & Garden', 'Items for home and garden', NULL),
('Smartphones', 'Mobile phones and accessories', 1),
('Laptops', 'Portable computers', 1),
('T-shirts', 'Short-sleeved shirts', 2),
('Shoes', 'Footwear for all occasions', 2);

-- -----------------------------------------------------
-- Insert sample data for colors
-- -----------------------------------------------------
INSERT INTO color (color_name, color_code) VALUES 
('Black', '#000000'),
('White', '#FFFFFF'),
('Red', '#FF0000'),
('Blue', '#0000FF'),
('Green', '#00FF00');

-- -----------------------------------------------------
-- Insert sample data for size categories and options
-- -----------------------------------------------------
INSERT INTO size_category (category_name, description) VALUES 
('Clothing', 'Standard clothing sizes'),
('Shoes', 'Shoe sizes'),
('Electronics', 'Electronics dimensions');

INSERT INTO size_option (size_category_id, size_value, size_description, display_order) VALUES 
(1, 'S', 'Small', 1),
(1, 'M', 'Medium', 2),
(1, 'L', 'Large', 3),
(1, 'XL', 'Extra Large', 4),
(2, '38', 'EU Size 38', 1),
(2, '39', 'EU Size 39', 2),
(2, '40', 'EU Size 40', 3),
(2, '41', 'EU Size 41', 4);

-- -----------------------------------------------------
-- Insert sample data for attribute categories and types
-- -----------------------------------------------------
INSERT INTO attribute_category (category_name, description) VALUES 
('Physical', 'Physical attributes like weight, dimensions'),
('Technical', 'Technical specifications'),
('Material', 'Material composition information');

INSERT INTO attribute_type (type_name, description) VALUES 
('Text', 'Text values'),
('Number', 'Numeric values'),
('Boolean', 'True/False values');

-- -----------------------------------------------------
-- Insert sample products
-- -----------------------------------------------------
INSERT INTO product (product_name, brand_id, category_id, base_price, description, is_featured) VALUES 
('Air Max 270', 1, 7, 149.99, 'Lightweight running shoes with Air cushioning', TRUE),
('Galaxy S21', 2, 4, 799.99, 'Flagship smartphone with high-resolution camera', TRUE),
('KALLAX Shelf Unit', 3, 3, 69.99, 'Versatile shelving unit for any room', FALSE);

-- -----------------------------------------------------
-- Insert sample product images
-- -----------------------------------------------------
INSERT INTO product_image (product_id, image_url, alt_text, is_primary, display_order) VALUES 
(1, 'https://assets.ajio.com/medias/sys_master/root/20230417/AuJY/643d64b0907deb497aeb3374/-473Wx593H-469473003-white-MODEL.jpg', 'Nike Air Max 270 - Side view', TRUE, 1),
(1, 'https://assets.ajio.com/medias/sys_master/root/20230417/LjeX/643d69c2711cf97ba72e4b2b/-473Wx593H-469473003-white-MODEL4.jpg', 'Nike Air Max 270 - Top view', FALSE, 2),
(2, 'https://cdn.i-scmp.com/sites/default/files/styles/1020x680/public/d8/images/methode/2021/01/15/c2cb3e6a-5581-11eb-84b3-e7426e7b8906_image_hires_004222.jpg?itok=7S4ZuTFx&v=1610642562', 'Samsung Galaxy S21 - Front view', TRUE, 1),
(3, 'https://www.ikea.com/us/en/images/products/kallax-shelf-unit-black-brown__0644754_pe702938_s5.jpg?f=u', 'IKEA KALLAX Shelf in room setting', TRUE, 1);

-- -----------------------------------------------------
-- Insert sample product attributes
-- -----------------------------------------------------
INSERT INTO product_attribute (product_id, attribute_category_id, attribute_type_id, attribute_name, attribute_value) VALUES 
(1, 1, 2, 'Weight', '10.5 oz'),
(1, 3, 1, 'Upper Material', 'Engineered mesh'),
(2, 2, 2, 'Screen Size', '6.2 inches'),
(2, 2, 2, 'Battery Capacity', '4000 mAh'),
(3, 1, 2, 'Dimensions', '77 x 77 x 39 cm');

-- -----------------------------------------------------
-- Insert sample product variations
-- -----------------------------------------------------
INSERT INTO product_variation (product_id, color_id, size_id, price_adjustment) VALUES 
(1, 1, 5, 0.00),  -- Black, Size 38
(1, 1, 6, 0.00),  -- Black, Size 39
(1, 2, 5, 0.00),  -- White, Size 38
(1, 4, 5, 10.00), -- Blue, Size 38 (costs $10 more)
(2, 1, NULL, 0.00), -- Black phone
(2, 2, NULL, 0.00), -- White phone
(3, 1, NULL, 0.00), -- Black KALLAX
(3, 2, NULL, 0.00); -- White KALLAX

-- -----------------------------------------------------
-- Insert sample product items (inventory)
-- -----------------------------------------------------
INSERT INTO product_item (product_id, variation_id, sku, stock_quantity, price) VALUES 
(1, 1, 'NKE-AM270-BLK-38', 25, 149.99),
(1, 2, 'NKE-AM270-BLK-39', 30, 149.99),
(1, 3, 'NKE-AM270-WHT-38', 15, 149.99),
(1, 4, 'NKE-AM270-BLU-38', 10, 159.99),
(2, 5, 'SAM-GS21-BLK', 50, 799.99),
(2, 6, 'SAM-GS21-WHT', 45, 799.99),
(3, 7, 'IKEA-KLX-BLK', 100, 69.99),
(3, 8, 'IKEA-KLX-WHT', 120, 69.99);

-- -----------------------------------------------------
-- Sample queries to test the database
-- -----------------------------------------------------

-- Test query 1: List all products with their brand and category
SELECT p.product_name, b.brand_name, pc.category_name, p.base_price
FROM product p
JOIN brand b ON p.brand_id = b.brand_id
JOIN product_category pc ON p.category_id = pc.category_id;

-- Test query 2: List all product variations for a specific product
SELECT p.product_name, c.color_name, so.size_value, pv.price_adjustment
FROM product_variation pv
JOIN product p ON pv.product_id = p.product_id
LEFT JOIN color c ON pv.color_id = c.color_id
LEFT JOIN size_option so ON pv.size_id = so.size_id
WHERE p.product_name = 'Air Max 270';

-- Test query 3: Show inventory levels for all products
SELECT p.product_name, c.color_name, so.size_value, pi.sku, pi.stock_quantity, pi.price
FROM product_item pi
JOIN product p ON pi.product_id = p.product_id
JOIN product_variation pv ON pi.variation_id = pv.variation_id
LEFT JOIN color c ON pv.color_id = c.color_id
LEFT JOIN size_option so ON pv.size_id = so.size_id
ORDER BY p.product_name, c.color_name, so.size_value;

-- -----------------------------------------------------
-- Enable foreign key checks again
-- -----------------------------------------------------
SET FOREIGN_KEY_CHECKS = 1;