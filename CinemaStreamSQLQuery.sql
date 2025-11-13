CREATE DATABASE MovieStreamDB;
USE MovieStreamDB;

-- Users Table
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100),
    City VARCHAR(50),
    JoinDate DATE
);

-- Subscription Plans Table
CREATE TABLE Subscriptions (
    PlanID INT PRIMARY KEY IDENTITY(1,1),
    PlanName VARCHAR(50),
    Price DECIMAL(10,2),
    DurationMonths INT
);

-- Movies Table
CREATE TABLE Movies (
    MovieID INT PRIMARY KEY IDENTITY(1,1),
    Title VARCHAR(100),
    Genre VARCHAR(50),
    ReleaseYear INT,
    Rating DECIMAL(2,1)
);

-- WatchHistory Table
CREATE TABLE WatchHistory (
    WatchID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    MovieID INT,
    WatchDate DATETIME,
    WatchTimeMinutes INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
);
INSERT INTO Users (Name, City, JoinDate) VALUES
('Ravi Kumar', 'Hyderabad', '2024-02-15'),
('Sneha Reddy', 'Bangalore', '2024-03-10'),
('Aman Verma', 'Delhi', '2024-04-05'),
('Megha Singh', 'Mumbai', '2024-05-01'),
('Karan Gupta', 'Pune', '2024-06-02'),
('Divya Sharma', 'Kolkata', '2024-06-10'),
('Priya Nair', 'Chennai', '2024-07-12'),
('Vikram Das', 'Lucknow', '2024-08-03');


INSERT INTO Subscriptions (PlanName, Price, DurationMonths) VALUES
('Basic', 199.00, 1),
('Standard', 499.00, 3),
('Premium', 999.00, 6);

INSERT INTO Movies (Title, Genre, ReleaseYear, Rating) VALUES
('Inception', 'Sci-Fi', 2010, 8.8),
('KGF Chapter 2', 'Action', 2022, 8.5),
('Interstellar', 'Sci-Fi', 2014, 8.6),
('3 Idiots', 'Comedy', 2009, 8.4),
('Pushpa', 'Action', 2021, 7.9),
('Avengers: Endgame', 'Action', 2019, 8.5),
('Drishyam 2', 'Thriller', 2022, 8.2),
('Jailer', 'Action', 2023, 7.8),
('Barbie', 'Comedy', 2023, 7.0),
('Oppenheimer', 'Drama', 2023, 8.7);


INSERT INTO WatchHistory (UserID, MovieID, WatchDate, WatchTimeMinutes) VALUES
(1, 1, '2024-06-10 20:00', 140),
(2, 2, '2024-06-11 21:15', 155),
(3, 3, '2024-06-12 19:45', 170),
(4, 4, '2024-06-13 22:00', 120),
(5, 5, '2024-06-14 19:30', 160),
(6, 6, '2024-06-15 20:45', 180),
(7, 7, '2024-06-16 18:10', 150),
(8, 8, '2024-06-17 21:00', 130),
(1, 9, '2024-06-18 19:45', 115),
(2, 10, '2024-06-19 22:10', 180),
(3, 2, '2024-06-20 21:30', 150),
(4, 3, '2024-06-21 20:50', 160),
(5, 4, '2024-06-22 19:20', 140),
(6, 5, '2024-06-23 21:15', 130),
(7, 6, '2024-06-24 20:40', 145),
(8, 7, '2024-06-25 22:00', 155);

SELECT * FROM WatchHistory;


SELECT u.Name, m.Title, m.Genre, w.WatchTimeMinutes
FROM WatchHistory w
JOIN Users u ON w.UserID = u.UserID
JOIN Movies m ON w.MovieID = m.MovieID;

SELECT Title, Genre, Rating
FROM Movies
WHERE Rating > 8.0
ORDER BY Rating DESC;


SELECT m.Genre, COUNT(w.WatchID) AS TotalViews
FROM WatchHistory w
JOIN Movies m ON w.MovieID = m.MovieID
GROUP BY m.Genre
ORDER BY TotalViews DESC;


SELECT 
    u.City,
    SUM(w.WatchTimeMinutes) AS TotalWatchTime,
    RANK() OVER (ORDER BY SUM(w.WatchTimeMinutes) DESC) AS WatchRank
FROM WatchHistory w
JOIN Users u ON w.UserID = u.UserID
GROUP BY u.City;
