-- Tạo cơ sở dữ liệu
CREATE DATABASE todolist;
USE todolist;

-- Bảng User (Người dùng)
CREATE TABLE User (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Avatar VARCHAR(255), -- Đường dẫn ảnh đại diện
    PhoneNumber VARCHAR(15),
    BirthDate DATE
);

-- Bảng Category (Danh mục)
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Color VARCHAR(20) NOT NULL
);

-- Bảng Priority (Mức độ ưu tiên)
CREATE TABLE Priority (
    PriorityID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL
);

-- Bảng Task (Nhiệm vụ)
CREATE TABLE Task (
    TaskID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Description TEXT,
    CategoryID INT,
    PriorityID INT,
    DueDate DATE NOT NULL,
    FOREIGN KEY (UserID) REFERENCES User(UserID) ON DELETE CASCADE,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID) ON DELETE SET NULL,
    FOREIGN KEY (PriorityID) REFERENCES Priority(PriorityID) ON DELETE SET NULL
);

-- Thêm User
INSERT INTO User (Username, Email, PasswordHash, Avatar, PhoneNumber, BirthDate) VALUES
('john_doe', 'john@example.com', 'hashed_password_1', 'avatars/john.jpg', '0123456789', '1990-05-20'),
('jane_smith', 'jane@example.com', 'hashed_password_2', 'avatars/jane.jpg', '0987654321', '1995-08-15');

-- Thêm Category
INSERT INTO Category (Name, Color) VALUES
('Work', 'Blue'),
('Personal', 'Green'),
('Shopping', 'Red'),
('Health', 'Yellow');

-- Thêm Priority
INSERT INTO Priority (Name) VALUES
('Low'),
('Medium'),
('High'),
('Urgent');

-- Thêm Task
INSERT INTO Task (UserID, Name, Description, CategoryID, PriorityID, DueDate) VALUES
(1, 'Finish project report', 'Complete the final report for the project', 1, 3, '2025-04-10'),
(1, 'Buy groceries', 'Milk, Bread, Eggs, and Fruits', 3, 2, '2025-04-05'),
(2, 'Doctor Appointment', 'Routine health check-up', 4, 4, '2025-04-08'),
(2, 'Meeting with client', 'Discuss the new project requirements', 1, 3, '2025-04-12');


-- Kiểm tra dữ liệu
SELECT * FROM Users;
SELECT * FROM Categories;
SELECT * FROM TaskStatus;
SELECT * FROM Tasks;
