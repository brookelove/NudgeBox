-- Users Table
INSERT INTO Users (id, name, email, created_at, updated_at) VALUES
(1, 'Alice', 'alice@example.com', NOW(), NOW()),
(2, 'Bob', 'bob@example.com', NOW(), NOW()),
(3, 'Charlie', 'charlie@example.com', NOW(), NOW());

-- Recommendations Table
INSERT INTO Recommendations (id, recommendation_type, created_at, updated_at) VALUES
(1, 'Movie Night', NOW(), NOW()),
(2, 'Outdoor Activity', NOW(), NOW()),
(3, 'Music Playlist', NOW(), NOW());

-- Ratings Table (one-to-one relationship with Recommendations)
INSERT INTO Rating (recommendation_id, rating_value, created_at, updated_at) VALUES
(1, 4.5, NOW(), NOW()),
(2, 3.7, NOW(), NOW()),
(3, 4.9, NOW(), NOW());

-- Activities Table
INSERT INTO Activities (id, activity_name, created_at, updated_at) VALUES
(1, 'Movie Night', NOW(), NOW()),
(2, 'Hiking', NOW(), NOW()),
(3, 'Concert', NOW(), NOW());

-- Tags Table
INSERT INTO Tags (id, tag_name, created_at, updated_at) VALUES
(1, 'Outdoor', NOW(), NOW()),
(2, 'Entertainment', NOW(), NOW()),
(3, 'Music', NOW(), NOW());

-- Items Table (e.g., products, movies, music)
INSERT INTO Items (id, item_name, item_type, created_at, updated_at) VALUES
(1, 'Inception', 'Movie', NOW(), NOW()),
(2, 'Mountain Hiking Boots', 'Product', NOW(), NOW()),
(3, 'Rock Music Playlist', 'Music', NOW(), NOW());

-- UserRecommendations Join Table (Many-to-Many relationship between Users and Recommendations)
INSERT INTO UserRecommendations (user_id, recommendation_id) VALUES
(1, 1),  -- Alice gets Movie Night recommendation
(2, 2),  -- Bob gets Outdoor Activity recommendation
(3, 3);  -- Charlie gets Music Playlist recommendation

-- UserActivities Join Table (Many-to-Many relationship between Users and Activities)
INSERT INTO UserActivities (user_id, activity_id) VALUES
(1, 1),  -- Alice engages in Movie Night
(2, 2),  -- Bob engages in Hiking
(3, 3);  -- Charlie engages in Concert

-- ActivityTags Join Table (Many-to-Many relationship between Activities and Tags)
INSERT INTO ActivityTags (activity_id, tag_id) VALUES
(1, 2),  -- Movie Night tagged as Entertainment
(2, 1),  -- Hiking tagged as Outdoor
(3, 3);  -- Concert tagged as Music

-- ActivityItems Join Table (Many-to-Many relationship between Activities and Items)
INSERT INTO ActivityItems (activity_id, item_id) VALUES
(1, 1),  -- Movie Night involves the Inception movie
(2, 2),  -- Hiking involves Mountain Hiking Boots
(3, 3);  -- Concert involves Rock Music Playlist
