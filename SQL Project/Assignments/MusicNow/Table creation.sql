-- Create the database
-- CREATE DATABASE MusicNow;

-- Use the newly created database
USE MusicNow;

-- Creating the Artists Table
CREATE TABLE Artists (
    ArtistID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Genre VARCHAR(50) NOT NULL,
    Country VARCHAR(50),
    BirthDate DATE
);

-- Creating the Albums Table
CREATE TABLE Albums (
    AlbumID INT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    ReleaseDate DATE NOT NULL
);

-- Creating the Tracks Table
CREATE TABLE Tracks (
    TrackID INT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Duration TIME NOT NULL,
    AlbumID INT,
    ArtistID INT,
    FOREIGN KEY (AlbumID) REFERENCES Albums(AlbumID),
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID)
);

-- Creating the Listeners Table
CREATE TABLE Listeners (
    ListenerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    SignupDate DATE
);

-- Creating the Playlists Table
CREATE TABLE Playlists (
    PlaylistID INT PRIMARY KEY,
    PlaylistName VARCHAR(100) NOT NULL,
    CreationDate DATE NOT NULL
);
-- Creating the PlaylistTracks Table
CREATE TABLE PlaylistTracks (
    PlaylistTrackID INT PRIMARY KEY,
    PlaylistID INT,
    TrackID INT,
    ListenerID INT,  -- Adding ListenerID here for association
    FOREIGN KEY (PlaylistID) REFERENCES Playlists(PlaylistID),
    FOREIGN KEY (TrackID) REFERENCES Tracks(TrackID),
    FOREIGN KEY (ListenerID) REFERENCES Listeners(ListenerID)  -- Linking to Listeners
);
-- Inserting Data into Artists Table
INSERT INTO Artists (ArtistID, Name, Genre, Country, BirthDate) VALUES
(1, 'K. J. Yesudas', 'Playback Singer', 'India', '1940-01-10'),
(2, 'A. R. Rahman', 'Music Director', 'India', '1967-01-06'),
(3, 'Shreya Ghoshal', 'Playback Singer', 'India', '1984-03-12'),
(4, 'Vijay Yesudas', 'Playback Singer', 'India', '1980-03-25'),
(5, 'Anirudh Ravichander', 'Music Director', 'India', '1990-10-16'),
(6, 'K. S. Chithra', 'Playback Singer', 'India', '1963-07-27'),
(7, 'Dhanush', 'Playback Singer', 'India', '1983-07-28'),
(8, 'Vineeth Sreenivasan', 'Playback Singer', 'India', '1985-10-01'),
(9, 'Benny Dayal', 'Playback Singer', 'India', '1984-05-13'),
(10, 'Haricharan', 'Playback Singer', 'India', '1989-04-20');

-- Inserting Data into Albums Table
INSERT INTO Albums (AlbumID, Title, ReleaseDate) VALUES
(1, 'Avesham', '2024-06-01'),
(2, 'Leo', '2024-07-15'),
(3, 'Jailer', '2024-08-10'),
(4, 'Goat Life', '2024-09-05'),
(5, 'Romancham', '2024-10-20');

-- Inserting Data into Tracks Table
INSERT INTO Tracks (TrackID, Title, Duration, AlbumID, ArtistID) VALUES
(1, 'Vannam Konda Vennilave', '00:04:30', 1, 1),
(2, 'Naan Yaar', '00:03:55', 1, 3),
(3, 'Kannaana Kanney', '00:04:50', 2, 4),
(4, 'Vaathi Coming', '00:03:30', 2, 5),
(5, 'Chilla Chilla', '00:03:45', 3, 6),
(6, 'Halamathi Habibo', '00:04:20', 3, 2),
(7, 'Riders', '00:04:15', 4, 9),
(8, 'Jeevitham Pookum', '00:04:10', 4, 10),
(9, 'Romancham Theme', '00:04:00', 5, 1),
(10, 'Vennilave Vennilave', '00:05:10', 5, 7),
(11, 'Sundariye', '00:03:50', 1, 8),
(12, 'Ethu Kaadhal Kaadi', '00:04:30', 2, 4),
(13, 'Nenjukkul Peidhidum', '00:04:05', 3, 1),
(14, 'Kalyaana Vayasu', '00:04:25', 4, 6),
(15, 'Mannavan Vanthanadi', '00:03:55', 5, 3);

-- Inserting Data into Listeners Table
INSERT INTO Listeners (ListenerID, Name, Email, SignupDate) VALUES
(1, 'Mohanlal', 'mohanlal@gmail.com', '2024-01-01'),
(2, 'Mammootty', 'mammootty@gmail.com', '2024-01-02'),
(3, 'Nivin Pauly', 'nivinpauly@gmail.com', '2024-01-03'),
(4, 'Trisha Krishnan', 'trisha@gmail.com', '2024-01-04'),
(5, 'Nazriya Nazim', 'nazriya@gmail.com', '2024-01-05');

-- Inserting Data into Playlists Table
INSERT INTO Playlists (PlaylistID, PlaylistName, CreationDate) VALUES
(1, '2024 Hits', '2024-01-01'),
(2, 'Malayalam Hits 2024', '2024-01-02'),
(3, 'Top Tamil Tracks 2024', '2024-01-03'),
(4, 'Best of South India 2024', '2024-01-04'),
(5, 'All-Time Malayalam Classics', '2024-01-05');

-- Inserting Data into PlaylistTracks Table
INSERT INTO PlaylistTracks (PlaylistTrackID, PlaylistID, TrackID, ListenerID) VALUES
(1, 1, 1, 1),  
(2, 1, 2, 1),  
(3, 1, 3, 2),  
(4, 1, 4, 2),  
(5, 2, 5, 3),  
(6, 2, 6, 3), 
(7, 2, 7, 4),  
(8, 2, 8, 4),  
(9, 3, 9, 5),  
(10, 3, 10, 5), 
(11, 3, 11, 1), 
(12, 3, 12, 2), 
(13, 4, 13, 1), 
(14, 4, 14, 2), 
(15, 4, 15, 3), 
(16, 5, 1, 4),  
(17, 5, 2, 4), 
(18, 5, 3, 5),  
(19, 5, 4, 5),  
(20, 5, 5, 1);  

