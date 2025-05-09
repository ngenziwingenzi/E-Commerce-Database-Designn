-- E-Commerce Database Schema - PART 2: Product Variations and Inventory
-- 
-- Author: Power Learn Project Group 214 Cohort 7 - Team Member 2
-- Description: Product variations, sizes, colors, and inventory management
-- =========================================================================

-- -----------------------------------------------------
-- Table color
-- Available color options for products
-- -----------------------------------------------------
CREATE TABLE color (
    color_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    color_name VARCHAR(50) NOT NULL,
    color_code VARCHAR(20) NOT NULL COMMENT 'HEX or RGB code',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_color_name (color_name)
) ENGINE=InnoDB COMMENT='Color options for product variations';

-- -----------------------------------------------------
-- Table size_category
-- Groups sizes into categories (clothing, shoes, etc.)
-- -----------------------------------------------------
CREATE TABLE size_category (
    size_category_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_size_category_name (category_name)
) ENGINE=InnoDB COMMENT='Categories for different size systems';

-- -----------------------------------------------------
-- Table size_option
-- Specific sizes within categories
-- -----------------------------------------------------
CREATE TABLE size_option (
    size_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    size_category_id INT UNSIGNED NOT NULL,
    size_value VARCHAR(20) NOT NULL,
    size_description VARCHAR(100),
    display_order INT UNSIGNED DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_size_value_category (size_value, size_category_id),
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB COMMENT='Specific size options within each size category';

-- -----------------------------------------------------
-- Table product_variation
-- Links products to their variations (color/size)
-- -----------------------------------------------------
CREATE TABLE product_variation (
    variation_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id INT UNSIGNED NOT NULL,
    color_id INT UNSIGNED,
    size_id INT UNSIGNED,
    price_adjustment DECIMAL(10,2) DEFAULT 0.00,
    is_active BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_product_variation (product_id, color_id, size_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (color_id) REFERENCES color(color_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (size_id) REFERENCES size_option(size_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB COMMENT='Product variations based on color and size combinations';

-- -----------------------------------------------------
-- Table product_item
-- Actual inventory items with SKUs and stock levels
-- -----------------------------------------------------
CREATE TABLE product_item (
    item_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id INT UNSIGNED NOT NULL,
    variation_id INT UNSIGNED NOT NULL,
    sku VARCHAR(50) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    price DECIMAL(10,2) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_sku (sku),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (variation_id) REFERENCES product_variation(variation_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB COMMENT='Specific purchasable items with inventory tracking';

-- -----------------------------------------------------
-- Create view for product inventory
-- -----------------------------------------------------
CREATE VIEW vw_product_inventory AS
SELECT 
    pi.item_id,
    p.product_id,
    p.product_name,
    b.brand_name,
    c.color_name,
    so.size_value,
    pi.sku,
    pi.stock_quantity,
    pi.price,
    pi.is_active
FROM 
    product_item pi
JOIN 
    product p ON pi.product_id = p.product_id
JOIN 
    brand b ON p.brand_id = b.brand_id
JOIN 
    product_variation pv ON pi.variation_id = pv.variation_id
LEFT JOIN 
    color c ON pv.color_id = c.color_id
LEFT JOIN 
    size_option so ON pv.size_id = so.size_id;
