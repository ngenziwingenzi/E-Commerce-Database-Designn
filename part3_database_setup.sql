-- =========================================================================
-- E-Commerce Database Schema - PART 3: Product Attributes System
-- 
-- Author: Power Learn Project Group 214 Cohort 7 - Team Member 3
-- Description: Product attribute categories, types, and specifications
-- =========================================================================

-- -----------------------------------------------------
-- Table attribute_category
-- Groups product attributes into categories
-- -----------------------------------------------------
CREATE TABLE attribute_category (
    attribute_category_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_attribute_category_name (category_name)
) ENGINE=InnoDB COMMENT='Categories for product attributes (technical, physical, etc.)';

-- -----------------------------------------------------
-- Table attribute_type
-- Defines data types for attributes
-- -----------------------------------------------------
CREATE TABLE attribute_type (
    attribute_type_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL,
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_attribute_type_name (type_name)
) ENGINE=InnoDB COMMENT='Data types for product attributes (text, number, boolean, etc.)';

-- -----------------------------------------------------
-- Table product_attribute
-- Custom attributes for products
-- -----------------------------------------------------
CREATE TABLE product_attribute (
    attribute_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id INT UNSIGNED NOT NULL,
    attribute_category_id INT UNSIGNED NOT NULL,
    attribute_type_id INT UNSIGNED NOT NULL,
    attribute_name VARCHAR(100) NOT NULL,
    attribute_value TEXT NOT NULL,
    display_order INT UNSIGNED DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_product_attribute (product_id, attribute_name),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(attribute_category_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(attribute_type_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB COMMENT='Stores custom product specifications and attributes';
