CREATE DATABASE CreativeBlog;
USE CreativeBlog;

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(30) UNIQUE NOT NULL,
    bio TEXT,
    avatar_url VARCHAR(255) DEFAULT 'default_avatar.png',
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);


CREATE TABLE Articles (
    article_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    body_content LONGTEXT NOT NULL,
    cover_image VARCHAR(255),
    status ENUM('draft', 'published', 'archived') DEFAULT 'draft',
    author_id INT,
    cat_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES Users(user_id) ON DELETE SET NULL,
    FOREIGN KEY (cat_id) REFERENCES Categories(category_id) ON DELETE CASCADE
);

CREATE TABLE Tags (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    label VARCHAR(30) UNIQUE
);


CREATE TABLE Article_Tags (
    article_id INT,
    tag_id INT,
    PRIMARY KEY (article_id, tag_id),
    FOREIGN KEY (article_id) REFERENCES Articles(article_id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES Tags(tag_id) ON DELETE CASCADE
);


CREATE TABLE Comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    content TEXT NOT NULL,
    is_edited BOOLEAN DEFAULT FALSE,
    author_id INT,
    article_id INT,
    posted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (article_id) REFERENCES Articles(article_id) ON DELETE CASCADE
);


CREATE TABLE Reactions (
    user_id INT,
    article_id INT,
    type ENUM('like', 'love', 'insightful'),
    PRIMARY KEY (user_id, article_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (article_id) REFERENCES Articles(article_id)
);