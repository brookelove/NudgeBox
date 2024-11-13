-- Drop the database if it exists
DROP DATABASE IF EXISTS nudgebox;

-- Create the new database
CREATE DATABASE nudgebox;

-- Connect to the database
USE nudgebox

-- Create category table first as it's referenced by other tables
CREATE TABLE category (
    id CHAR(36) PRIMARY KEY,
    name VARCHAR(30) NOT NULL
);

-- Create tags table (references category)
CREATE TABLE tags (
    id CHAR(36) PRIMARY KEY,
    category_id VARCHAR(36) NOT NULL,
    name VARCHAR(30) NOT NULL,
    color VARCHAR(20) NOT NULL,
    CONSTRAINT fk_tags_category FOREIGN KEY (category_id) REFERENCES category(id)
);

-- Create users table (no issues here)
CREATE TABLE users (
    id CHAR(36) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    preferences JSON NOT NULL,
    location VARCHAR(50),
    age INT
);

-- Create item table (references category and tags)
CREATE TABLE item (
    id CHAR(36) PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    description VARCHAR(50) NOT NULL,
    category_id VARCHAR(36) NOT NULL,
    tags_id VARCHAR(36) NOT NULL,
    CONSTRAINT fk_item_category FOREIGN KEY (category_id) REFERENCES category(id),
    CONSTRAINT fk_item_tags FOREIGN KEY (tags_id) REFERENCES tags(id)
);

-- Create rating table (references users and items)
CREATE TABLE rating (
    id CHAR(36) PRIMARY KEY,
    user_id VARCHAR(36) NOT NULL,
    item_id VARCHAR(36) NOT NULL,
    rating_value DECIMAL(3, 2) NOT NULL,
    review VARCHAR(50) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_rating_user FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_rating_items FOREIGN KEY (item_id) REFERENCES item(id)
);

-- Create activities table (references category and tags)
CREATE TABLE activities (
    id CHAR(36) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(50) NOT NULL,
    category_id VARCHAR(36) NOT NULL,
    tags_id VARCHAR(36) NOT NULL,
    location VARCHAR(50),
    date DATE ,
    CONSTRAINT fk_activities_category FOREIGN KEY (category_id) REFERENCES category(id),
    CONSTRAINT fk_activities_tags FOREIGN KEY (tags_id) REFERENCES tags(id)
);

-- Create recommendations table (references category and tags)
CREATE TABLE recommendations (
    id CHAR(36) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(50) NOT NULL,
    category_id VARCHAR(36) NOT NULL,
    tags_id VARCHAR(36) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    recommendation_type VARCHAR(50),
    location VARCHAR(50),
    date DATE,
    CONSTRAINT fk_recommendations_category FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE CASCADE,
    CONSTRAINT fk_recommendations_tags FOREIGN KEY (tags_id) REFERENCES tags(id) ON DELETE CASCADE
);

-- Create activity_log table (references users, items, and ratings)
CREATE TABLE activity_log (
    id CHAR(36) PRIMARY KEY,
    user_id VARCHAR(36) NOT NULL,
    item_id VARCHAR(36) NOT NULL,
    interaction_type VARCHAR(50) NOT NULL,
    rating_id VARCHAR(36) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_activity_log_user FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_activity_log_item FOREIGN KEY (item_id) REFERENCES item(id),
    CONSTRAINT fk_activity_log_rating FOREIGN KEY (rating_id) REFERENCES rating(id)
);
