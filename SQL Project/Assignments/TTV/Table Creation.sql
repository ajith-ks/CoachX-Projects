--CREATE DATABASE ttv;
USE ttv;

-- Locations Table
CREATE TABLE Locations (
    LocationID INT PRIMARY KEY,
    City VARCHAR(100),
    Country VARCHAR(100),
    Region VARCHAR(100)
);

-- Categories Table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY, 
    CategoryName VARCHAR(100) NOT NULL,
    Description TEXT NOT NULL
);

-- Reporters Table
CREATE TABLE Reporters (
    ReporterID INT PRIMARY KEY, 
    Name VARCHAR(100) NOT NULL,
    HireDate DATE,
    Email VARCHAR(100),
    LocationID INT,
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

-- Shows Table
CREATE TABLE Shows (
    ShowID INT PRIMARY KEY, 
    ShowTitle VARCHAR(200) NOT NULL,
    ShowDescription TEXT NOT NULL,
    AirDate DATETIME,
    ReporterID INT,
    CategoryID INT,
    Duration INT, -- Duration of the show in minutes
    FOREIGN KEY (ReporterID) REFERENCES Reporters(ReporterID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Viewership Table
CREATE TABLE Viewership (
    ViewershipID INT PRIMARY KEY, 
    ShowID INT,
    ViewCount INT,
    ViewDate DATE,
    FOREIGN KEY (ShowID) REFERENCES Shows(ShowID)
);

-- Locations Table
INSERT INTO Locations (LocationID, City, Country, Region) VALUES
(1, 'Thiruvananthapuram', 'India', 'Kerala'),
(2, 'Kochi', 'India', 'Kerala'),
(3, 'Kozhikode', 'India', 'Kerala'),
(4, 'Malappuram', 'India', 'Kerala'),
(5, 'Kottayam', 'India', 'Kerala');

-- Categories Table
INSERT INTO Categories (CategoryID, CategoryName, Description) VALUES
(1, 'Politics', 'Latest political news and updates.'),
(2, 'Sports', 'Coverage of sports events in Kerala.'),
(3, 'Health', 'Health-related news and wellness tips.'),
(4, 'Education', 'News and updates about education in Kerala.');

-- Reporters Table
INSERT INTO Reporters (ReporterID, Name, HireDate, Email, LocationID) VALUES
(1, 'Rajesh Kumar', '2020-01-15', 'rajesh.kumar@ttv.com', 1),
(2, 'Anita Menon', '2021-06-10', 'anita.menon@ttv.com', 2),
(3, 'Suresh Nair', '2019-03-05', 'suresh.nair@ttv.com', 3),
(4, 'Meera Joseph', '2022-08-20', 'meera.joseph@ttv.com', 4),
(5, 'Vijayakumar P', '2023-02-12', 'vijayakumar.p@ttv.com', 5),
(6, 'Lakshmi Iyer', '2023-11-01', 'lakshmi.iyer@ttv.com', 1);

-- Shows Table
INSERT INTO Shows (ShowID, ShowTitle, ShowDescription, AirDate, ReporterID, CategoryID, Duration) VALUES
(1, 'Kerala Politics Today', 'A deep dive into the latest political developments in Kerala.', '2024-01-01', 1, 1, 30),
(2, 'Inside Kerala Assembly', 'An analysis of the recent assembly sessions and key discussions.', '2024-01-15', 1, 1, 45),
(3, 'Political Talk Show', 'Experts discuss current political scenarios affecting Kerala.', '2024-01-20', 1, 1, 60),
(4, 'Sports Roundup', 'Coverage of the latest sports events and updates in Kerala.', '2023-09-05', 2, 2, 30),
(5, 'Kochi Sports Special', 'Highlighting local sports teams and their achievements.', '2023-10-05', 2, 2, 30),
(6, 'Football Fever', 'Analysis of the football season and the Kerala Blasters.', '2023-10-15', 3, 2, 30),
(7, 'Health Today', 'Discussing health tips and wellness in the monsoon season.', '2023-06-10', 4, 3, 30),
(8, 'Ayurveda and You', 'Exploring the benefits of Ayurveda for a healthy lifestyle.', '2023-06-15', 4, 3, 30),
(9, 'Mental Health Matters', 'Addressing mental health issues and solutions available in Kerala.', '2023-06-25', 4, 3, 30),
(10, 'Educational Insights', 'Discussing reforms in the education sector in Kerala.', '2023-11-01', 5, 4, 30),
(11, 'Scholarships and Opportunities', 'Exploring scholarship options for students in Kerala.', '2023-10-25', 5, 4, 30),
(12, 'Online Learning Trends', 'Analyzing the rise of online education in Kerala.', '2023-10-15', 5, 4, 30);

-- Viewership Table
INSERT INTO Viewership (ViewershipID, ShowID, ViewCount, ViewDate) VALUES
(1, 1, 1500, '2024-01-02'),
(2, 1, 2000, '2024-01-03'),
(3, 2, 1200, '2024-01-16'),
(4, 2, 1800, '2024-01-17'),
(5, 3, 800, '2024-01-21'),
(6, 4, 2300, '2023-09-06'),
(7, 4, 2400, '2023-09-07'),
(8, 5, 1900, '2023-10-06'),
(9, 6, 2500, '2023-10-11'),
(10, 7, 2200, '2023-10-12'),
(11, 8, 1800, '2023-06-11'),
(12, 8, 1900, '2023-06-12'),
(13, 9, 1600, '2023-06-16'),
(14, 10, 1700, '2023-06-26'),
(15, 11, 2000, '2023-11-02'),
(16, 11, 2200, '2023-11-03'),
(17, 12, 1750, '2023-10-26'),
(18, 12, 1500, '2023-10-16');
