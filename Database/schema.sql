SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `rock` DEFAULT CHARACTER SET utf8 ;
USE `rock` ;

-- -----------------------------------------------------
-- Table `rock`.`m_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rock`.`m_types` ;

CREATE  TABLE IF NOT EXISTS `rock`.`m_types` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `type` VARCHAR(60) NOT NULL ,
  `extension` VARCHAR(10) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rock`.`rocks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rock`.`rocks` ;

CREATE  TABLE IF NOT EXISTS `rock`.`rocks` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `system_path` VARCHAR(4096) NULL ,
  `remote_path` VARCHAR(2048) NULL ,
  `m_type_id` INT NOT NULL ,
  `created` DATETIME NOT NULL ,
  `modified` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  INDEX `fk_rocks_mime_types1` (`m_type_id` ASC) ,
  CONSTRAINT `fk_rocks_mime_types1`
    FOREIGN KEY (`m_type_id` )
    REFERENCES `rock`.`m_types` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rock`.`arts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rock`.`arts` ;

CREATE  TABLE IF NOT EXISTS `rock`.`arts` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `rock_id` INT NOT NULL ,
  `created` DATETIME NOT NULL ,
  `modified` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  INDEX `fk_Art_Path1` (`rock_id` ASC) ,
  CONSTRAINT `fk_Art_Path1`
    FOREIGN KEY (`rock_id` )
    REFERENCES `rock`.`rocks` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rock`.`artists`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rock`.`artists` ;

CREATE  TABLE IF NOT EXISTS `rock`.`artists` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `art_id` INT NULL ,
  `created` DATETIME NOT NULL ,
  `modified` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  INDEX `fk_Artist_Art1` (`art_id` ASC) ,
  CONSTRAINT `fk_Artist_Art1`
    FOREIGN KEY (`art_id` )
    REFERENCES `rock`.`arts` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rock`.`albums`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rock`.`albums` ;

CREATE  TABLE IF NOT EXISTS `rock`.`albums` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(60) NOT NULL ,
  `art_id` INT NULL ,
  `artist_id` INT NOT NULL ,
  `created` DATETIME NOT NULL ,
  `modified` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  INDEX `fk_Album_Art1` (`art_id` ASC) ,
  INDEX `fk_Album_Artist1` (`artist_id` ASC) ,
  CONSTRAINT `fk_Album_Art1`
    FOREIGN KEY (`art_id` )
    REFERENCES `rock`.`arts` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Album_Artist1`
    FOREIGN KEY (`artist_id` )
    REFERENCES `rock`.`artists` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rock`.`genres`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rock`.`genres` ;

CREATE  TABLE IF NOT EXISTS `rock`.`genres` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(60) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rock`.`songs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rock`.`songs` ;

CREATE  TABLE IF NOT EXISTS `rock`.`songs` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(60) NULL ,
  `track_nr` INT NULL ,
  `disk_nr` INT NULL ,
  `album_id` INT NULL ,
  `genre_id` INT NULL ,
  `artist_id` INT NULL ,
  `rock_id` INT NOT NULL ,
  `length_sec` INT NOT NULL ,
  `created` DATETIME NOT NULL ,
  `modified` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  INDEX `fk_Song_Album` (`album_id` ASC) ,
  INDEX `fk_Song_Genre1` (`genre_id` ASC) ,
  INDEX `fk_Song_Artist1` (`artist_id` ASC) ,
  INDEX `fk_Song_Path1` (`rock_id` ASC) ,
  CONSTRAINT `fk_Song_Album`
    FOREIGN KEY (`album_id` )
    REFERENCES `rock`.`albums` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Song_Genre1`
    FOREIGN KEY (`genre_id` )
    REFERENCES `rock`.`genres` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Song_Artist1`
    FOREIGN KEY (`artist_id` )
    REFERENCES `rock`.`artists` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Song_Path1`
    FOREIGN KEY (`rock_id` )
    REFERENCES `rock`.`rocks` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rock`.`roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rock`.`roles` ;

CREATE  TABLE IF NOT EXISTS `rock`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(62) NOT NULL ,
  `level` INT NOT NULL ,
  `created` DATETIME NOT NULL ,
  `modified` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rock`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rock`.`users` ;

CREATE  TABLE IF NOT EXISTS `rock`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(62) NOT NULL ,
  `email` VARCHAR(256) NOT NULL ,
  `password_hs` VARCHAR(128) NOT NULL ,
  `password_sl` VARCHAR(128) NOT NULL ,
  `role_id` INT NOT NULL ,
  `created` DATETIME NOT NULL ,
  `modified` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  INDEX `fk_User_Role1` (`role_id` ASC) ,
  CONSTRAINT `fk_User_Role1`
    FOREIGN KEY (`role_id` )
    REFERENCES `rock`.`roles` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rock`.`playlists`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rock`.`playlists` ;

CREATE  TABLE IF NOT EXISTS `rock`.`playlists` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(60) NOT NULL ,
  `created` DATETIME NOT NULL ,
  `modified` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rock`.`playlist_elements`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rock`.`playlist_elements` ;

CREATE  TABLE IF NOT EXISTS `rock`.`playlist_elements` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `playlist_id` INT NOT NULL ,
  `song_id` INT NOT NULL ,
  `order_nr` INT NOT NULL ,
  `created` DATETIME NOT NULL ,
  `modified` DATETIME NOT NULL ,
  INDEX `fk_Playlist_has_Song_Song1` (`song_id` ASC) ,
  INDEX `fk_Playlist_has_Song_Playlist1` (`playlist_id` ASC) ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  CONSTRAINT `fk_Playlist_has_Song_Playlist1`
    FOREIGN KEY (`playlist_id` )
    REFERENCES `rock`.`playlists` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Playlist_has_Song_Song1`
    FOREIGN KEY (`song_id` )
    REFERENCES `rock`.`songs` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `rock`.`m_types`
-- -----------------------------------------------------
START TRANSACTION;
USE `rock`;
INSERT INTO `rock`.`m_types` (`id`, `type`, `extension`) VALUES (1, 'audio/aiff', 'aif');
INSERT INTO `rock`.`m_types` (`id`, `type`, `extension`) VALUES (2, 'audio/aiff', 'aifc');
INSERT INTO `rock`.`m_types` (`id`, `type`, `extension`) VALUES (3, 'audio/aiff', 'aiff');
INSERT INTO `rock`.`m_types` (`id`, `type`, `extension`) VALUES (4, 'audio/mpeg', 'mp3');
INSERT INTO `rock`.`m_types` (`id`, `type`, `extension`) VALUES (5, 'audio/ogg', 'ogg');
INSERT INTO `rock`.`m_types` (`id`, `type`, `extension`) VALUES (6, 'audio/wav', 'wav');
INSERT INTO `rock`.`m_types` (`id`, `type`, `extension`) VALUES (7, 'audio/x-flac', 'flac');
INSERT INTO `rock`.`m_types` (`id`, `type`, `extension`) VALUES (8, 'audio/aac', 'm4a');
INSERT INTO `rock`.`m_types` (`id`, `type`, `extension`) VALUES (9, 'audio/aac', 'aac');
INSERT INTO `rock`.`m_types` (`id`, `type`, `extension`) VALUES (10, 'audio/aac', '3gp');
INSERT INTO `rock`.`m_types` (`id`, `type`, `extension`) VALUES (11, 'audio/basic', 'au');
INSERT INTO `rock`.`m_types` (`id`, `type`, `extension`) VALUES (12, 'audio/x-ms-wma', 'wma');
INSERT INTO `rock`.`m_types` (`id`, `type`, `extension`) VALUES (13, 'audio/x-monkeys-audio', 'ape');
INSERT INTO `rock`.`m_types` (`id`, `type`, `extension`) VALUES (14, 'image/jpeg', 'jpg');
INSERT INTO `rock`.`m_types` (`id`, `type`, `extension`) VALUES (15, 'image/jpeg', 'jpeg');
INSERT INTO `rock`.`m_types` (`id`, `type`, `extension`) VALUES (16, 'image/png', 'png');

COMMIT;

-- -----------------------------------------------------
-- Data for table `rock`.`genres`
-- -----------------------------------------------------
START TRANSACTION;
USE `rock`;
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (1, 'Blues');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (2, 'Classic Rock');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (3, 'Country');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (4, 'Dance');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (5, 'Disco');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (6, 'Funk');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (7, 'Grunge');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (8, 'Hip-Hop');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (9, 'Jazz');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (10, 'Metal');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (11, 'New Age');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (12, 'Oldies');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (13, 'Other');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (14, 'Pop');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (15, 'R&B');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (16, 'Rap');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (17, 'Reggae');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (18, 'Rock');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (19, 'Techno');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (20, 'Industrial');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (21, 'Alternative');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (22, 'Ska');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (23, 'Death Metal');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (24, 'Pranks');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (25, 'Soundtrack');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (26, 'Euro-Techno');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (27, 'Ambient');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (28, 'Trip-Hop');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (29, 'Vocal');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (30, 'Jazz+Funk');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (31, 'Fusion');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (32, 'Trance');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (33, 'Classical');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (34, 'Instrumental');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (35, 'Acid');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (36, 'House');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (37, 'Game');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (38, 'Sound Clip');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (39, 'Gospel');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (40, 'Noise');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (41, 'AlternRock');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (42, 'Bass');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (43, 'Soul');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (44, 'Punk');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (45, 'Space');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (46, 'Meditative');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (47, 'Instrumental Pop');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (48, 'Instrumental Rock');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (49, 'Ethnic');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (50, 'Gothic');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (51, 'Darkwave');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (52, 'Techno-Industrial');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (53, 'Electronic');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (54, 'Pop-Folk');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (55, 'Eurodance');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (56, 'Dream');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (57, 'Southern Rock');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (58, 'Comedy');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (59, 'Cult');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (60, 'Gangsta');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (61, 'Top 40');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (62, 'Christian Rap');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (63, 'Pop/Funk');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (64, 'Jungle');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (65, 'Native American');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (66, 'Cabaret');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (67, 'New Wave');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (68, 'Psychadelic');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (69, 'Rave');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (70, 'Showtunes');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (71, 'Trailer');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (72, 'Lo-Fi');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (73, 'Tribal');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (74, 'Acid Punk');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (75, 'Acid Jazz');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (76, 'Polka');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (77, 'Retro');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (78, 'Musical');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (79, 'Rock & Roll');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (80, 'Hard Rock');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (81, 'Folk');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (82, 'Folk-Rock');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (83, 'National Folk');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (84, 'Swing');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (85, 'Fast Fusion');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (86, 'Bebob');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (87, 'Latin');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (88, 'Revival');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (89, 'Celtic');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (90, 'Bluegrass');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (91, 'Avantgarde');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (92, 'Gothic Rock');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (93, 'Progressive Rock');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (94, 'Psychedelic Rock');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (95, 'Symphonic Rock');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (96, 'Slow Rock');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (97, 'Big Band');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (98, 'Chorus');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (99, 'Easy Listening');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (100, 'Acoustic');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (101, 'Humour');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (102, 'Speech');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (103, 'Chanson');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (104, 'Opera');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (105, 'Chamber Music');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (106, 'Sonata');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (107, 'Symphony');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (108, 'Booty Bass');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (109, 'Primus');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (110, 'Porn Groove');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (111, 'Satire');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (112, 'Slow Jam');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (113, 'Club');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (114, 'Tango');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (115, 'Samba');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (116, 'Folklore');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (117, 'Ballad');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (118, 'Power Ballad');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (119, 'Rhythmic Soul');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (120, 'Freestyle');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (121, 'Duet');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (122, 'Punk Rock');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (123, 'Drum Solo');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (124, 'A capella');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (125, 'Euro-House');
INSERT INTO `rock`.`genres` (`id`, `name`) VALUES (126, 'Dance Hall');

COMMIT;
