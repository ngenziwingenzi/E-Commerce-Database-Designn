# E-Commerce Database Design Project

## Overview
This repository contains a comprehensive database schema for an e-commerce platform developed by Power Learn Project Group 214 Cohort 7. The schema includes support for product variants, inventory management, and product attributes.

## Entity-Relationship Diagram (ERD)
![E-Commerce Database ERD](https://github.com/alphac137/E-commerce-Database-Design/raw/main/doc/ERD.png)

## Database Features
- **Product Management**: Core product information, categorization, and images
- **Brand Management**: Store and organize product manufacturers
- **Category Hierarchy**: Multi-level categorization for products
- **Product Variations**: Support for different colors and sizes
- **Inventory Management**: SKU-level stock tracking
- **Attribute System**: Flexible product specifications and features
- **Built-in Views**: Pre-configured views for common operations

## Schema Structure

### Core Tables
1. **brand**: Stores information about product manufacturers
2. **product_category**: Hierarchical category structure for products
3. **product**: Central product information
4. **product_image**: Images associated with products

### Variation & Inventory Tables
1. **color**: Available color options for products
2. **size_category**: Groups sizes into categories (clothing, shoes, etc.)
3. **size_option**: Specific sizes within categories
4. **product_variation**: Links products to their variations (color/size)
5. **product_item**: Actual inventory items with SKUs and stock levels

### Attribute Tables
1. **attribute_category**: Groups product attributes into categories
2. **attribute_type**: Defines data types for attributes
3. **product_attribute**: Custom attributes for products

### Views
1. **vw_product_listing**: Product listing with primary image
2. **vw_product_inventory**: Product inventory with detailed information

## Installation and Setup

### Prerequisites
- MySQL 5.7 or higher
- MySQL client or compatible database management tool

### Installation Instructions

1. Clone this repository:
   ```
   git clone https://github.com/alphac137/E-commerce-Database-Design.git
   cd E-commerce-Database-Design
   ```

2. Execute the SQL files in the following order:
   ```
   mysql -u alphac137 -p < part1_database_setup.sql
   mysql -u alphac137 -p < part2_database_setup.sql
   mysql -u alphac137 -p < part3_database_setup.sql
   mysql -u alphac137 -p < part4_database_setup.sql
   ```

   Alternatively, you can use the combined script:
   ```
   mysql -u alphac137 -p < ecommerce_complete.sql
   ```

3. Verify the installation:
   ```
   mysql -u alphac137 -p -e "USE E-commerce-Database-Design; SHOW TABLES;"
   ```

## Project Structure

```
E-commerce-Database-Design/
├── part1_database_setup.sql      # Database setup and core product structure
├── part2_database_setup.sql  # Product attributes system
├── part3_database_setup.sql  # Product variations and inventory
├── part4_database_setup.sql         # Sample data and testing
├── ecommerce_complete.sql     # Complete SQL script (combined)
├── doc/
│   └── ERD.png      # Entity-Relationship Diagram image
└── README.md                  # This file
```

## Contributions

### 1st Part
- Database creation and initial setup
- Brand table
- Product_category table
- Product table
- Product_image table
- Product listing view

### 2nd Part
- Color table
- Size_category table
- Size_option table
- Product_variation table
- Product_item table
- Inventory view

### 3rd part
- Attribute_category table
- Attribute_type table
- Product_attribute table

### 4th part
- Sample data for all tables
- Testing queries
- Documentation

## Usage Examples

### Basic Product Listing
```sql
SELECT * FROM vw_product_listing;
```

### Inventory Report
```sql
SELECT * FROM vw_product_inventory;
```

### Finding Products by Category
```sql
SELECT p.product_name, b.brand_name, p.base_price
FROM product p
JOIN brand b ON p.brand_id = b.brand_id
WHERE p.category_id = (SELECT category_id FROM product_category WHERE category_name = 'Shoes');
```

### Getting Product Variations
```sql
SELECT c.color_name, so.size_value, pi.sku, pi.stock_quantity, pi.price
FROM product_item pi
JOIN product_variation pv ON pi.variation_id = pv.variation_id
LEFT JOIN color c ON pv.color_id = c.color_id
LEFT JOIN size_option so ON pv.size_id = so.size_id
WHERE pi.product_id = 1;
```


## Acknowledgments
- All team members of Group 214 Cohort 7 for their contributions
