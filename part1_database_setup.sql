
-- =========================================================================
-- E-Commerce Database Schema - PART 1: Database Setup and Core Structure
-- 
-- Author: Power Learn Project Group 214 Cohort 7 - Team Member 1
-- Description: Database setup and core product tables
-- =========================================================================

-- -----------------------------------------------------
-- Enable strict SQL mode for better error handling
-- -----------------------------------------------------
SET SQL_MODE = "STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION";
SET FOREIGN_KEY_CHECKS = 0;

-- -----------------------------------------------------
-- Create database
-- -----------------------------------------------------
DROP DATABASE IF EXISTS ecommerce_db;
CREATE DATABASE ecommerce_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ecommerce_db;

-- -----------------------------------------------------
-- Table `brand`
-- Stores information about product manufacturers
-- -----------------------------------------------------
CREATE TABLE brand (
    brand_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL,
    description TEXT,
    logo_url VARCHAR(255),
    website_url VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_brand_name (brand_name)
) ENGINE=InnoDB COMMENT='Stores brand information for products';

-- -----------------------------------------------------
-- Table `product_category`
-- Hierarchical category structure for products
-- -----------------------------------------------------
CREATE TABLE product_category (
    category_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description TEXT,
    parent_category_id INT UNSIGNED,
    is_active BOOLEAN DEFAULT TRUE,
    display_order INT UNSIGNED DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_category_name (category_name),
    FOREIGN KEY (parent_category_id) REFERENCES product_category(category_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB COMMENT='Hierarchical product categories';

-- -----------------------------------------------------
-- Table `product`
-- Central product information
-- -----------------------------------------------------
CREATE TABLE product (
    product_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT UNSIGNED NOT NULL,
    category_id INT UNSIGNED NOT NULL,
    base_price DECIMAL(10,2) NOT NULL,
    description TEXT,
    is_featured BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_product_name_brand (product_name, brand_id),
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (category_id) REFERENCES product_category(category_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB COMMENT='Core product information';

-- -----------------------------------------------------
-- Table `product_image`
-- Images associated with products
-- -----------------------------------------------------
CREATE TABLE product_image (
    image_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id INT UNSIGNED NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    alt_text VARCHAR(255),
    is_primary BOOLEAN DEFAULT FALSE,
    display_order INT UNSIGNED DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB COMMENT='Stores product image URLs or file references';

-- -----------------------------------------------------
-- Create view for product listing with primary image
-- -----------------------------------------------------
CREATE VIEW vw_product_listing AS
SELECT 
    p.product_id,
    p.product_name,
    b.brand_name,
    pc.category_name,
    p.base_price,
    p.is_featured,
    p.is_active,
    pi.image_url AS primary_image_url
FROM 
    product p
JOIN 
    brand b ON p.brand_id = b.brand_id
JOIN 
    product_category pc ON p.category_id = pc.category_id
LEFT JOIN 
    product_image pi ON p.product_id = pi.product_id AND pi.is_primary = TRUE
WHERE 
    p.is_active = TRUE;
