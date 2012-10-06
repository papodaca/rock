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

INSERT INTO `rock`.`m_types` (`id`, `type`, `extension`) VALUES
(1, 'audio/aiff', 'aif'),
(2, 'audio/aiff', 'aifc'),
(3, 'audio/aiff', 'aiff'),
(4, 'audio/mpeg', 'mp3'),
(5, 'audio/ogg', 'ogg'),
(6, 'audio/wav', 'wav'),
(7, 'audio/x-flac', 'flac'),
(8, 'audio/aac', 'm4a'),
(9, 'audio/aac', 'aac'),
(10, 'audio/aac', '3gp'),
(11, 'audio/basic', 'au'),
(12, 'audio/x-ms-wma', 'wma'),
(13, 'audio/x-monkeys-audio', 'ape'),
(14, 'image/jpeg', 'jpg'),
(15, 'image/jpeg', 'jpeg'),
(16, 'image/png', 'png');

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

INSERT INTO `rock`.`genres` (`id`, `name`) VALUES
(1, 'Blues'),
(2, 'Classic Rock'),
(3, 'Country'),
(4, 'Dance'),
(5, 'Disco'),
(6, 'Funk'),
(7, 'Grunge'),
(8, 'Hip-Hop'),
(9, 'Jazz'),
(10, 'Metal'),
(11, 'New Age'),
(12, 'Oldies'),
(13, 'Other'),
(14, 'Pop'),
(15, 'R&B'),
(16, 'Rap'),
(17, 'Reggae'),
(18, 'Rock'),
(19, 'Techno'),
(20, 'Industrial'),
(21, 'Alternative'),
(22, 'Ska'),
(23, 'Death Metal'),
(24, 'Pranks'),
(25, 'Soundtrack'),
(26, 'Euro-Techno'),
(27, 'Ambient'),
(28, 'Trip-Hop'),
(29, 'Vocal'),
(30, 'Jazz+Funk'),
(31, 'Fusion'),
(32, 'Trance'),
(33, 'Classical'),
(34, 'Instrumental'),
(35, 'Acid'),
(36, 'House'),
(37, 'Game'),
(38, 'Sound Clip'),
(39, 'Gospel'),
(40, 'Noise'),
(41, 'AlternRock'),
(42, 'Bass'),
(43, 'Soul'),
(44, 'Punk'),
(45, 'Space'),
(46, 'Meditative'),
(47, 'Instrumental Pop'),
(48, 'Instrumental Rock'),
(49, 'Ethnic'),
(50, 'Gothic'),
(51, 'Darkwave'),
(52, 'Techno-Industrial'),
(53, 'Electronic'),
(54, 'Pop-Folk'),
(55, 'Eurodance'),
(56, 'Dream'),
(57, 'Southern Rock'),
(58, 'Comedy'),
(59, 'Cult'),
(60, 'Gangsta'),
(61, 'Top 40'),
(62, 'Christian Rap'),
(63, 'Pop/Funk'),
(64, 'Jungle'),
(65, 'Native American'),
(66, 'Cabaret'),
(67, 'New Wave'),
(68, 'Psychadelic'),
(69, 'Rave'),
(70, 'Showtunes'),
(71, 'Trailer'),
(72, 'Lo-Fi'),
(73, 'Tribal'),
(74, 'Acid Punk'),
(75, 'Acid Jazz'),
(76, 'Polka'),
(77, 'Retro'),
(78, 'Musical'),
(79, 'Rock & Roll'),
(80, 'Hard Rock'),
(81, 'Folk'),
(82, 'Folk-Rock'),
(83, 'National Folk'),
(84, 'Swing'),
(85, 'Fast Fusion'),
(86, 'Bebob'),
(87, 'Latin'),
(88, 'Revival'),
(89, 'Celtic'),
(90, 'Bluegrass'),
(91, 'Avantgarde'),
(92, 'Gothic Rock'),
(93, 'Progressive Rock'),
(94, 'Psychedelic Rock'),
(95, 'Symphonic Rock'),
(96, 'Slow Rock'),
(97, 'Big Band'),
(98, 'Chorus'),
(99, 'Easy Listening'),
(100, 'Acoustic'),
(101, 'Humour'),
(102, 'Speech'),
(103, 'Chanson'),
(104, 'Opera'),
(105, 'Chamber Music'),
(106, 'Sonata'),
(107, 'Symphony'),
(108, 'Booty Bass'),
(109, 'Primus'),
(110, 'Porn Groove'),
(111, 'Satire'),
(112, 'Slow Jam'),
(113, 'Club'),
(114, 'Tango'),
(115, 'Samba'),
(116, 'Folklore'),
(117, 'Ballad'),
(118, 'Power Ballad'),
(119, 'Rhythmic Soul'),
(120, 'Freestyle'),
(121, 'Duet'),
(122, 'Punk Rock'),
(123, 'Drum Solo'),
(124, 'A capella'),
(125, 'Euro-House'),
(126, 'Dance Hall');

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
