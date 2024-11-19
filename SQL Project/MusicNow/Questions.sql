/*
write down atleast 5 search queries (complex)
Write down atleast 2 update statement
write down atleast 2 delete statement
Your search criteria should be satisfied by either clusterd or non clusterd index
Alter 2 tables by adding new column
Alter 2 tables by deleting existing columns
create a view with join defenition 
Write 1 sub query
Write a cte query
Write a stored procedure accepting atleast 2 parameters
*/
use MusicNow;
-- find album name of tracks
select t.Title as TrackTitle, a.Title AS AlbumTitle from Tracks t 
join Albums a on t.AlbumID = a.AlbumID;  

-- find artist name with track name
select a.name as ArtistName, t.Title as TrackName from Artists a
join Tracks t on t.ArtistID = a.ArtistID

-- sort artist name with most songs
select a.name as ArtistName, count(t.Title) as TotalTracks from Artists a
join Tracks t on t.ArtistID = a.ArtistID
group by a.name
order by count(t.Title) desc

-- find track name from playlists
select t.Title, p.PlaylistName from Tracks t
join PlaylistTracks pt on pt.TrackID = t.TrackID
join Playlists p on p.PlaylistID = pt.PlaylistID

-- find listners using playlist 1
select distinct l.Name from Listeners l
join PlaylistTracks pt on l.ListenerID = pt.ListenerID
where pt.PlaylistID =1



-- Update Statements

-- Change the email of a listener
update Listeners set Email = 'mohanlal_updated@gmail.com' where ListenerID = 1;

-- Update 2: Change the release date of an album
update Albums set ReleaseDate = '2024-06-15' where AlbumID = 1; 

-- Delete Statements
insert into Tracks values (20, 'Mukkala Mukabala', '00:04:30', 5, 2)
-- Remove a specific track
delete from Tracks where TrackID = 20;  

-- Remove a listener from the database
insert into Listeners values (20, 'Naslen', 'Naslen@gmail.com', '2024-01-01')
delete from Listeners where ListenerID = 20;  

-- Alter Table Statements (Add Columns)

-- Add a column for the biography of the artist
alter table Artists add Biography Varchar(50);

--Add a column for the release year of the album
alter table Albums add ReleaseYear INT;

-- Alter Table Statements (Delete Columns)

-- Remove the Biography column from Artists table
alter table Artists drop column Biography;  

-- Remove the ReleaseYear column from Albums table
alter table Albums drop column ReleaseYear;  

-- Create a View with Join Definition
create view vw_ArtistAlbumTracks as
select a.Name as ArtistName, al.Title as AlbumTitle, t.Title as TrackTitle
FROM Artists a
join Tracks t on a.ArtistID = t.ArtistID
join Albums al on t.AlbumID = al.AlbumID;

select * from vw_ArtistAlbumTracks;

