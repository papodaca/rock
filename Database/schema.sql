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
  `created` DATETIME NOT NULL ,
  `modified` DATETIME NOT NULL ,
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
