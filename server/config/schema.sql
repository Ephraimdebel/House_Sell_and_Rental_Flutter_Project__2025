-- Categories Table
CREATE TABLE Categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Types Table
CREATE TABLE Types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Users Table
CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    profileImagePath VARCHAR(255) DEFAULT 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
    phone_number VARCHAR(20) DEFAULT '',
    role ENUM('admin', 'host', 'guest') DEFAULT 'guest',
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Listings Table
CREATE TABLE Listings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    creator_id INT NOT NULL,   -- Foreign key to Users table
    category_id INT NOT NULL,  -- Foreign key to Categories table
    type_id INT NOT NULL,      -- Foreign key to Types table
    streetAddress VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    province VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    guestCount INT NOT NULL,
    bedroomCount INT NOT NULL,
    area INT NOT NULL,
    bathroomCount INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    listingPhotoPaths json DEFAULT NULL,
    facilities JSON DEFAULT NULL
    price DECIMAL(10, 2) NOT NULL,
    isFeatured BOOLEAN DEFAULT FALSE,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (creator_id) REFERENCES Users(id),
    FOREIGN KEY (category_id) REFERENCES Categories(id),
    FOREIGN KEY (type_id) REFERENCES Types(id)
);

-- Favorites Table
CREATE TABLE Favorites (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,      -- Foreign key to Users table
    listing_id INT NOT NULL,   -- Foreign key to Listings table
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (listing_id) REFERENCES Listings(id)
);

-- Insert sample data into Categories table
INSERT INTO Categories (id, name) VALUES
(1, 'House'),
(2, 'Apartment'),
(3, 'Condo'),
(4, 'Villa');

-- Insert sample data into Types table
INSERT INTO Types (id, name) VALUES
(1, 'Sale'),
(2, 'Rent');