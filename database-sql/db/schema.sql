-- Drop and recreate the database (optional)
DROP DATABASE IF EXISTS nudgebox;
CREATE DATABASE nudgebox;
USE nudgebox;

-- Create tables in dependency order
CREATE TABLE category (
    id CHAR(36) PRIMARY KEY,
    name VARCHAR(30) NOT NULL
);

CREATE TABLE users (
    id CHAR(36) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    preferences JSON NOT NULL,
    location VARCHAR(50),
    age INT CHECK (age >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE tags (
    id CHAR(36) PRIMARY KEY,
    category_id CHAR(36) NOT NULL,
    name VARCHAR(30) NOT NULL,
    color VARCHAR(20) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE CASCADE
);

CREATE TABLE item (
    id CHAR(36) PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    description VARCHAR(50) NOT NULL,
    category_id CHAR(36) NOT NULL,
    tags_id CHAR(36) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE CASCADE,
    FOREIGN KEY (tags_id) REFERENCES tags(id) ON DELETE CASCADE
);

CREATE TABLE rating (
    id CHAR(36) PRIMARY KEY,
    user_id CHAR(36) NOT NULL,
    item_id CHAR(36) NOT NULL,
    rating_value DECIMAL(3, 2) NOT NULL CHECK (rating_value BETWEEN 0 AND 5),
    review VARCHAR(50) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (item_id) REFERENCES item(id)
);

CREATE TABLE activities (
    id CHAR(36) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(50) NOT NULL,
    category_id CHAR(36) NOT NULL,
    tags_id CHAR(36) NOT NULL,
    location VARCHAR(50),
    date DATE,
    FOREIGN KEY (category_id) REFERENCES category(id),
    FOREIGN KEY (tags_id) REFERENCES tags(id)
);

CREATE TABLE recommendations (
    id CHAR(36) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(50) NOT NULL,
    category_id CHAR(36) NOT NULL,
    tags_id CHAR(36) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    recommendation_type VARCHAR(50),
    location VARCHAR(50),
    date DATE,
    FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE CASCADE,
    FOREIGN KEY (tags_id) REFERENCES tags(id) ON DELETE CASCADE
);

CREATE TABLE activity_log (
    id CHAR(36) PRIMARY KEY,
    user_id CHAR(36) NOT NULL,
    item_id CHAR(36) NOT NULL,
    interaction_type VARCHAR(50) NOT NULL,
    rating_id CHAR(36) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (item_id) REFERENCES item(id),
    FOREIGN KEY (rating_id) REFERENCES rating(id)
);

