-- =========================================================================
-- E-Commerce Database Schema - Main Assembly Script
-- 
-- Author: Power Learn Project Group 214 Cohort 7
-- Description: Main script to run all components in the correct order
-- =========================================================================

SOURCE part1_database_setup.sql;

-- Then, run Part 3: Product attributes system

SOURCE part3_product_attributes.sql;

-- Next, run Part 2: Product variations and inventory
SOURCE part2_product_variations.sql;

-- Finally, run Part 4: Sample data and testing
SOURCE part4_sample_data.sql;

-- Print success message
SELECT 'E-commerce database setup complete!' AS 'Status';
