CREATE DATABASE IF NOT EXISTS SparkifyXDWH;
CREATE DATABASE IF NOT EXISTS SparkifyXDWHStaging;

USE SparkifyXDWH;

DROP TABLE IF EXISTS dimTime;
DROP TABLE IF EXISTS dimUsers;
DROP TABLE IF EXISTS dimArtists;
DROP TABLE IF EXISTS dimSongs;
DROP TABLE IF EXISTS factSongPlays;



CREATE TABLE dimTime(
    time_key                        INTEGER AUTO_INCREMENT,
    start_time                      TIMESTAMP NOT NULL,
    year                            SMALLINT NOT NULL,
    quarter                         SMALLINT NOT NULL,
    month                           SMALLINT NOT NULL,
    week                            SMALLINT NOT NULL,
    day                             SMALLINT NOT NULL,
    hour                            SMALLINT NOT NULL,
    is_weekend                      BOOLEAN,

    PRIMARY KEY (time_key)
);


CREATE TABLE IF NOT EXISTS dimUsers(
    user_key                        INTEGER AUTO_INCREMENT,
    user_id                         INTEGER,
    first_name                      VARCHAR(50),
    last_name                       VARCHAR(50),
    gender                          VARCHAR(1),
    level                           VARCHAR(10),

    -- scd of type 2 for user level
    level_start_date                DATETIME,
    level_end_date                  DATETIME,

    PRIMARY KEY (user_key),
    CHECK (level IN ('paid', 'free'))
);


CREATE TABLE IF NOT EXISTS dimArtists(
    artist_key                      INTEGER AUTO_INCREMENT,
    artist_id                       VARCHAR(50),
    name                            VARCHAR(100),
    location                        VARCHAR(100),
    latitude                        FLOAT(5),
    longitude                       FLOAT(5),

    PRIMARY KEY (artist_key)
);


CREATE TABLE IF NOT EXISTS dimSongs (
    song_key                        INTEGER AUTO_INCREMENT,
    song_id                         VARCHAR(20),
    title                           VARCHAR(100),
    artist_id                       VARCHAR(50),
    year                            INTEGER,
    duration                        FLOAT(5),

    PRIMARY KEY (song_key),
    FOREIGN KEY (artist_id) REFERENCES artists(artist_key)
);


CREATE TABLE IF NOT EXISTS factSongPlays (
    songplay_key                    INTEGER AUTO_INCREMENT,
    user_key                        INTEGER,
    song_key                        INTEGER,
    artist_key                      INTEGER,
    time_key                        INTEGER,

    level                           VARCHAR(10),
    session_id                      INTEGER,
    location                        VARCHAR(50),
    user_agent                      VARCHAR(150),

    -- "time_stamp" for using it with "user_key", "song_key, artist_key" as an identifer
    -- because source data doesn't have an identifer
    time_stamp                      TIMESTAMP, 

    PRIMARY KEY (songplay_key),
    FOREIGN KEY (time_key)   REFERENCES dimTime(time_key)
    FOREIGN KEY (user_key)   REFERENCES dimUsers(user_key),
    FOREIGN KEY (song_key)   REFERENCES dimSongs(song_key),
    FOREIGN KEY (artist_key) REFERENCES dimArtists(artist_key)
);










-- -------------------------------------------------------------------------------------

USE SparkifyXDWHStaging;

DROP TABLE IF EXISTS song_data;
DROP TABLE IF EXISTS log_data;



CREATE TABLE IF NOT EXISTS song_data (
    song_data_key                   INTEGER AUTO_INCREMENT,
    song_id                         VARCHAR(20),
    title                           VARCHAR(100),
    artist_id                       VARCHAR(50),
    year                            INTEGER,
    duration                        FLOAT(5),


    artist_key                      INTEGER AUTO_INCREMENT,
    artist_id                       VARCHAR(50),
    name                            VARCHAR(100),
    location                        VARCHAR(100),
    latitude                        FLOAT(5),
    longitude                       FLOAT(5),

    
    PRIMARY KEY (song_data_key),
);


CREATE TABLE IF NOT EXISTS log_data(
    log_data_key                    INTEGER AUTO_INCREMENT,
    user_id                         INTEGER,
    first_name                      VARCHAR(50),
    last_name                       VARCHAR(50),
    gender                          VARCHAR(1),
    level                           VARCHAR(10),


    session_id                      INTEGER,
    location                        VARCHAR(50),
    user_agent                      VARCHAR(150),
    time_stamp                      TIMESTAMP, 


    PRIMARY KEY (log_data_key),
);