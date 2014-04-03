DROP DATABASE IF EXISTS gruppe3;
CREATE DATABASE gruppe3;
USE gruppe3;
DROP TABLE IF EXISTS fahrer;
DROP TABLE IF EXISTS bus;
DROP TABLE IF EXISTS haltestelle;
DROP TABLE IF EXISTS buslinie;
DROP TABLE IF EXISTS buskurs;
DROP TABLE IF EXISTS intervalle;
DROP TABLE IF EXISTS betriebszeiten;
DROP TABLE IF EXISTS buskurs_buslinie;
DROP TABLE IF EXISTS intervalle_buslinie;
DROP TABLE IF EXISTS buslinie_haltestelle;
CREATE TABLE IF NOT EXISTS fahrer (
  fahrer_id INT NOT NULL AUTO_INCREMENT,
  nachname VARCHAR(45),
  vorname VARCHAR(45),
  PRIMARY KEY (fahrer_id)
) ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS bus (
  bus_id INT NOT NULL AUTO_INCREMENT,
  busname VARCHAR(45),
  PRIMARY KEY (bus_id)
) ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS betriebszeiten (
  betriebszeiten_id INT NOT NULL AUTO_INCREMENT,
  start TIME,
  ende TIME,
  PRIMARY KEY(betriebszeiten_id)
)ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS buslinie (
  buslinie_id INT NOT NULL,
  richtung VARCHAR(1),
  dauer INT,
  rückfahrt INT NULL,
  betriebszeiten_werktags INT,
  betriebszeiten_wochenende INT,
  einsetzfahrt INT,
  aussetzfahrt INT,
  PRIMARY KEY (buslinie_id, richtung),
  INDEX fk_buslinie_betriebszeiten_werktags (betriebszeiten_werktags ASC),
  INDEX fk_buslinie_betriebszeiten_wochenende (betriebszeiten_wochenende ASC),
  CONSTRAINT fk_buslinie_betrienszeiten_werktags
    FOREIGN KEY (betriebszeiten_werktags)
	REFERENCES betriebszeiten (betriebszeiten_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
  CONSTRAINT fk_buslinie_betriebszeiten_wochenende
    FOREIGN KEY (betriebszeiten_wochenende)
	REFERENCES betriebszeiten (betriebszeiten_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
) ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS buskurs (
  buskurs_id INT NOT NULL AUTO_INCREMENT,
  fahrer_id INT NOT NULL,
  bus_id INT,
  PRIMARY KEY (buskurs_id),
  INDEX fk_Buskurs_Bus (bus_id ASC),
  INDEX fk_Buskurs_Fahrer (fahrer_id ASC),
  UNIQUE INDEX buskurs_id_UNIQUE (buskurs_id ASC),
  CONSTRAINT fk_Buskurs_Bus
    FOREIGN KEY (bus_id)
    REFERENCES bus (bus_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_Buskurs_Fahrer
    FOREIGN KEY (fahrer_id)
    REFERENCES fahrer (fahrer_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS haltestelle (
  haltestelle_id INT NOT NULL AUTO_INCREMENT,
  namen VARCHAR(45),
  PRIMARY KEY (haltestelle_id)
) ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS intervalle (
  intervalle_id INT NOT NULL AUTO_INCREMENT,
  intervall INT,
  PRIMARY KEY (intervalle_id)
) ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS buslinie_haltestelle (
  buslinie_id INT,
  haltestelle_id INT,
  bedient_wochenende BOOLEAN,
  haltestellennummer INT,
  fahrzeit INT,
  PRIMARY KEY (buslinie_id, haltestelle_id),
  INDEX fk_buslinie_haltestelle_haltestelle (haltestelle_id ASC),
  INDEX fk_buslinie_haltestelle_buslinie (buslinie_id ASC),
  CONSTRAINT fk_buslinie_haltestelle_haltestelle
    FOREIGN KEY (haltestelle_id)
	REFERENCES haltestelle (haltestelle_id)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
  CONSTRAINT fk_buslinie_haltestelle_buslinie
    FOREIGN KEY (buslinie_id)
	REFERENCES buslinie (buslinie_id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS buskurs_buslinie (
  buskurs_id INT,
  buslinie_id INT,
  PRIMARY KEY (buskurs_id, buslinie_id),
  INDEX fk_buskurs_buslinie_buskurs (buskurs_id ASC),
  INDEX fk_buskurs_buslinie_buslinie (buslinie_id ASC),
  CONSTRAINT fk_buskurs_buslinie_buslinie
    FOREIGN KEY (buslinie_id)
	REFERENCES buslinie (buslinie_id)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
  CONSTRAINT fk_buskurs_buslinie_buskurs
    FOREIGN KEY (buskurs_id)
	REFERENCES buskurs (buskurs_id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS intervalle_buslinie (
  intervalle_id INT,
  buslinie_id INT,
  PRIMARY KEY(intervalle_id, buslinie_id),
  INDEX fk_intervalle_buslinie_buslinie (buslinie_id ASC),
  INDEX fk_intervalle_buslinie_intervalle (intervalle_id ASC),
  CONSTRAINT fk_intervalle_buslinie_buslinie
    FOREIGN KEY (buslinie_id)
	REFERENCES buslinie (buslinie_id)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
  CONSTRAINT fk_intervalle_buslinie_intervalle
    FOREIGN KEY (intervalle_id)
	REFERENCES intervalle (intervalle_id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE = InnoDB;