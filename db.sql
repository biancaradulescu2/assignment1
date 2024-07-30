-- Create the database schema
CREATE DATABASE IF NOT EXISTS myapp_db;
USE myapp_db;

-- Create the names table
CREATE TABLE IF NOT EXISTS names (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Insert sample data
INSERT INTO names (name) VALUES ('Alexia');
INSERT INTO names (name) VALUES ('Bianca');
INSERT INTO names (name) VALUES ('Stefan');
INSERT INTO names (name) VALUES ('Grigo');