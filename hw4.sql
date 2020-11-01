/*----------------------------------------------------------------------
 * Name: Gharin Pautz
 * File: hw4.sql
 * Date: 10/21/2020
 * Class: CPSC 321, Fall 2020
 * Description: This file implements the tables from homework 3.
 ----------------------------------------------------------------------*/
USE gpautz_DB;
-- required in MariaDB to enforce constraints
SET sql_mode = STRICT_ALL_TABLES;

DROP TABLE IF EXISTS Influences;
DROP TABLE IF EXISTS Written;
DROP TABLE IF EXISTS Associated;
DROP TABLE IF EXISTS Member_Of;
DROP TABLE IF EXISTS Music_Group;
DROP TABLE IF EXISTS Track;
DROP TABLE IF EXISTS Album;
DROP TABLE IF EXISTS Record_Label;
DROP TABLE IF EXISTS Music_Group_Genre;
DROP TABLE IF EXISTS Genre;
DROP TABLE IF EXISTS Artist;
DROP TABLE IF EXISTS Song;

-- Song(song_title, year_written)
CREATE TABLE Song(
    song_title VARCHAR(30) NOT NULL,
    year_written YEAR NOT NULL,
    PRIMARY KEY (song_title)
);

-- Artist(artist_name, birth_year)
CREATE TABLE Artist(
    artist_name VARCHAR(30) NOT NULL,
    birth_year YEAR NOT NULL,
    PRIMARY KEY (artist_name)
);

-- Genre(genre_name)
CREATE TABLE Genre(
    genre_name VARCHAR(30) NOT NULL,
    PRIMARY KEY (genre_name)
);

-- Music_Group_Genre(group_name, genre_name)
CREATE TABLE Music_Group_Genre(
	group_name VARCHAR(30),
    genre_name VARCHAR(30),
    PRIMARY KEY (group_name, genre_name),
    FOREIGN KEY (genre_name) REFERENCES Genre (genre_name)
);

-- Record_Label(label_name, label_type, year_founded)
CREATE TABLE Record_Label(
	label_name VARCHAR(30) NOT NULL,
	label_type VARCHAR(30) NOT NULL,
    year_founded YEAR NOT NULL,
    PRIMARY KEY (label_name)
);

-- Album(album_title, group_name, year_recorded, label_name)
CREATE TABLE Album(
    album_title VARCHAR(30) NOT NULL,
    group_name VARCHAR(30) NOT NULL,
    year_recorded YEAR NOT NULL,
    label_name VARCHAR(30) NOT NULL,
    PRIMARY KEY (album_title, group_name),
    FOREIGN KEY (label_name) REFERENCES Record_Label (label_name)
);

-- Track(track_name, year_recorded, song_title, album_title)
CREATE TABLE Track(
    track_name VARCHAR(30) NOT NULL,
    year_recorded YEAR NOT NULL,
    song_title VARCHAR(30) NOT NULL,
    album_title VARCHAR(30),
    PRIMARY KEY (track_name, year_recorded, song_title),
    FOREIGN KEY (song_title) REFERENCES Song (song_title),
    FOREIGN KEY (album_title) REFERENCES Album (album_title)
);

-- Music_Group(group_name, genre_name, year_formed)
CREATE TABLE Music_Group(
    group_name VARCHAR(30) NOT NULL,
    genre_name VARCHAR(30) NOT NULL,
    year_formed VARCHAR(30) NOT NULL,
    PRIMARY KEY (group_name, genre_name),
    FOREIGN KEY (genre_name) REFERENCES Genre (genre_name)
);

-- Member_Of(artist_name, group_name, start_year, finish_year)
CREATE TABLE Member_Of(
    artist_name VARCHAR(30) NOT NULL,
    group_name VARCHAR(30) NOT NULL,
    start_year YEAR NOT NULL,
    finish_year YEAR,
    PRIMARY KEY (artist_name, group_name, start_year),
    FOREIGN KEY (artist_name) REFERENCES Artist (artist_name),
    FOREIGN KEY (group_name) REFERENCES Music_Group (group_name)
);

-- Associated(track_name, artist_name)
CREATE TABLE Associated(
    track_name VARCHAR(30) NOT NULL,
    artist_name VARCHAR(30) NOT NULL,
    PRIMARY KEY (track_name, artist_name),
    FOREIGN KEY (track_name) REFERENCES Track (track_name),
    FOREIGN KEY (artist_name) REFERENCES Artist (artist_name)
);

-- Written(song_title, artist_name)
CREATE TABLE Written(
    song_title VARCHAR(30) NOT NULL,
    artist_name VARCHAR(30) NOT NULL,
    PRIMARY KEY (song_title, artist_name),
    FOREIGN KEY (song_title) REFERENCES Song (song_title),
    FOREIGN KEY (artist_name) REFERENCES Artist (artist_name)
);

-- Influences(influencing_group, influenced_group)
CREATE TABLE Influences(
    influencing_group VARCHAR(30) NOT NULL,
    influenced_group VARCHAR(30) NOT NULL,
    PRIMARY KEY (influencing_group, influenced_group),
    FOREIGN KEY (influencing_group) REFERENCES Music_Group (group_name),
    FOREIGN KEY (influenced_group) REFERENCES Music_Group (group_name)
);

-- Song(song_title, year_written)
INSERT INTO Song VALUES
('Sorry', 2015),
('She Will Be Loved', 2007),
('Baby', 2015),
('I\'ll Show You', 2015),
('We Are The Champions', 1975),
('Dirt Road Anthem', 2015),
('Not Ready to Make Nice', 2006),
('In A Dream', 2020),
('Paparazzi', 2009),
('Just Dance', 2009),
('Telephone', 2009);

-- Artist(artist_name, birth_year)
INSERT INTO Artist VALUES
('Adam Levine', 1979),
('Justin Bieber', 1994),
('Freddie Mercury', 1946),
('Troye Sivan', 1997),
('PJ Morton', 1980),
('Mickey Madden', 1975),
('Matt Flynn', 1979),
('Lady Gaga', 1980);

-- Genre(genre_name, group_name)
INSERT INTO Genre VALUES
('Pop'),
('Country'),
('R&B'),
('Rock'),
('KPOP'),
('Rap');

-- Music_Group_Genre(group_name, genre_name)
INSERT INTO Music_Group_Genre VALUES
('Maroon 5', 'Pop'),
('Maroon 5', 'Country'),
('Maroon 5', 'R&B'),
('Queen', 'Rock'),
('BTS', 'KPOP'),
('BTS', 'Pop'),
('BTS', 'Rock'),
('Rascal Flatts', 'Country'),
('Rascal Flatts', 'Rock'),
('Rascal Flatts', 'Pop');

-- Record_Label(label_name, label_type, year_founded)
INSERT INTO Record_Label VALUES
('Def Jam Recordings', 'Major',	2005),
('Universal Records', 'Major', 1950),
('Australia Universal', 'Indie', 1989),
('Sony Music', 'Major', 1960),
('Hollywood Music', 'Major', 1950),
('New York Hits', 'Major', 1950),
('South African Records', 'Indie', 1983),
('Washington Times', 'Indie', 1985);

-- Album(album_title, group_name, year_recorded, label_name)
INSERT INTO Album Values 
('Stone Cold Classics', 'Queen', 1977, 'Universal Records'),
('Purpose', 'Justin Bieber', 2015, 'Def Jam Recordings'),
('Purpose',	'Maroon 5',  2007, 'Universal Records'),
('In a Dream', 'Troye Sivan', 2020,  'Australia Universal'),
('Greatest Hits', 'Elton John',	1980, 'Universal Records'),
('Greatest Country', 'Maroon 5', 2015, 'Universal Records'),
('Taking The Long Way', 'Dixie Chicks', 2006, 'Sony Music'),
('Fame Monster', 'Lady Gaga', 2009, 'Universal Records'),
('John Wayne', 'Lady Gaga', 2015, 'Universal Records'),
('Red Pill Blues', 'Maroon 5', 2018, 'Def Jam Recordings'),
('V', 'Maroon 5', 2015, 'Sony Music');

-- Track(track_name, year_recorded, song_title, album_title)
INSERT INTO Track VALUES
('We Are The Champions', 1977, 'We Are The Champions', 'Stone Cold Classics'),
('Sorry', 2015, 'Sorry', 'Purpose'),
('I\'ll Show You', 2015, 'I\'ll Show You', 'Purpose'),
('She Will Be Loved', 2007, 'She Will Be Loved', 'Purpose'),
('We Are The Champions (Revised)', 1980, 'We Are The Champions', 'Greatest Hits'),
('In A Dream', 2020, 'In A Dream', 'In A Dream'),
('Telephone', 2009, 'Telephone', 'Fame Monster'),
('Paparazzi', 2009, 'Paparazzi', 'Fame Monster'),
('We Are The Champions', 2020, 'We Are The Champions', 'In A Dream');

-- Music_Group(group_name, genre_name, year_formed)
INSERT INTO Music_Group VALUES
('Maroon 5', 'Pop', 2004),
('Maroon 5', 'Rock', 2004),
('Maroon 5', 'R&B', 2004),
('Queen', 'Rock', 1970),
('Dixie Chicks', 'Country', 1995),
('BTS', 'KPOP', 2012),
('BTS', 'Pop', 2012),
('BTS', 'Rock', 2012),
('Rascal Flatts', 'Country', 2004),
('Rascal Flatts', 'Rock', 2004),
('Rascal Flatts', 'Rap', 2004),
('Lady Gaga', 'Pop', 2008);

-- Member_Of(artist_name, group_name, start_year, finish_year)
INSERT INTO Member_Of VALUES
('Adam Levine', 'Maroon 5', 2004, 2010),
('Adam Levine',	'Dixie Chicks',	2010, 2012),
('Adam Levine',	'Maroon 5',	2013, NULL),
('Freddie Mercury', 'Queen', 1970, 1980),
('Freddie Mercury', 'Queen', 1985, 1990),
('Mickey Madden', 'Maroon 5', 2004, NULL),
('PJ Morton', 'Maroon 5', 2004, 2012),
('Matt Flynn', 'Maroon 5', 2004, NULL),
('Troye Sivan', 'Dixie Chicks', 2010, NULL),
('Troye Sivan', 'Maroon 5', 2010, 2015);

-- Associated(track_name, artist_name)
INSERT INTO Associated VALUES
('Sorry', 'Justin Bieber'),
('She Will Be Loved', 'Adam Levine'),
('In A Dream', 'Troye Sivan'),
('Telephone', 'Lady Gaga'),
('Paparazzi', 'Lady Gaga');

-- Written(song_title, artist_name)
INSERT INTO Written VALUES
('Sorry', 'Justin Bieber'),
('She Will Be Loved', 'PJ Morton'),
('She Will Be Loved', 'Adam Levine'),
('Telephone', 'Lady Gaga'),
('Paparazzi', 'Lady Gaga');

-- Influences(influencing_group, influenced_group)
INSERT INTO Influences VALUES
('Queen', 'Maroon 5'),
('Dixie Chicks', 'Maroon 5'),
('Dixie Chicks', 'Rascal Flatts'),
('Dixie Chicks', 'BTS');

SELECT * FROM Influences;
SELECT * FROM Written;
SELECT * FROM Associated;
SELECT * FROM Member_Of;
SELECT * FROM Music_Group;
SELECT * FROM Record_Label;
SELECT * FROM Album;
SELECT * FROM Track;
SELECT * FROM Music_Group_Genre;
SELECT * FROM Genre;
SELECT * FROM Artist;
SELECT * FROM Song;