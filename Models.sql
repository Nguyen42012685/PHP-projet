CREATE DATABASE WildQuizz;
USE WildQuizz;

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Games (
    game_id INT AUTO_INCREMENT PRIMARY KEY,
    host_user_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('waiting', 'in_progress', 'completed') DEFAULT 'waiting',
    FOREIGN KEY (host_user_id) REFERENCES Users(user_id)
);

CREATE TABLE Rounds (
    round_id INT AUTO_INCREMENT PRIMARY KEY,
    game_id INT,
    question_id INT,
    round_number INT NOT NULL,
    started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ended_at TIMESTAMP NULL,
    FOREIGN KEY (game_id) REFERENCES Games(game_id),
    FOREIGN KEY (question_id) REFERENCES Questions(question_id)
);

CREATE TABLE Questions (
    question_id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(50) NOT NULL,
    question_text TEXT NOT NULL,
    correct_answer VARCHAR(255) NOT NULL
);

CREATE TABLE Guesses (
    guess_id INT AUTO_INCREMENT PRIMARY KEY,
    round_id INT,
    user_id INT,
    guess_text VARCHAR(255) NOT NULL,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_correct BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (round_id) REFERENCES Rounds(round_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE AnimalCategories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Animals (
    animal_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    category_id INT,
    description TEXT NOT NULL,
    difficulty ENUM('easy', 'medium', 'hard') DEFAULT 'easy',
    image_url VARCHAR(255) DEFAULT NULL,
    FOREIGN KEY (category_id) REFERENCES AnimalCategories(category_id)
);

CREATE TABLE AnimalHints (
    hint_id INT AUTO_INCREMENT PRIMARY KEY,
    animal_id INT,
    hint_text TEXT NOT NULL,
    hint_order INT NOT NULL,
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id)
);

