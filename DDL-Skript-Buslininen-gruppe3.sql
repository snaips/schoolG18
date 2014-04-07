DROP DATABASE IF EXISTS gruppe3;
CREATE DATABASE gruppe3;
USE gruppe3;
DROP TABLE IF EXISTS fahrer;
DROP TABLE IF EXISTS bus;
DROP TABLE IF EXISTS haltestelle;
DROP TABLE IF EXISTS fahrt;
DROP TABLE IF EXISTS buslinie;
DROP TABLE IF EXISTS buskurs;
DROP TABLE IF EXISTS intervalle;
DROP TABLE IF EXISTS betriebszeiten;
DROP TABLE IF EXISTS tage;
DROP TABLE IF EXISTS dienstzeiten;
DROP TABLE IF EXISTS fahrer_dienstzeiten;
DROP TABLE IF EXISTS linienfahrplan;
DROP TABLE IF EXISTS linienfahrplan_haltestelle;
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
  beginn TIME,
  ende TIME,
  PRIMARY KEY(betriebszeiten_id)
)ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS buslinie (
  buslinie_id INT NOT NULL AUTO_INCREMENT,
  buslinienname VARCHAR(45),
  PRIMARY KEY (buslinie_id)
) ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS haltestelle (
  haltestelle_id INT NOT NULL AUTO_INCREMENT,
  namen VARCHAR(45),
  PRIMARY KEY (haltestelle_id)
) ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS intervalle (
  intervalle_id INT NOT NULL AUTO_INCREMENT,
  intervall TIME,
  PRIMARY KEY (intervalle_id)
) ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS tage (
  tage_id INT NOT NULL AUTO_INCREMENT,
  gruppe VARCHAR(5),
  tage VARCHAR(7),
  text VARCHAR(30),
  datum VARCHAR(45),
  PRIMARY KEY (tage_id)
) ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS dienstzeiten (
  dienstzeiten_id INT NOT NULL AUTO_INCREMENT,
  dienstbeginn TIME,
  dienstende TIME,
  PRIMARY KEY (dienstzeiten_id)
) ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS linienfahrplan (
  linienfahrplan_id INT NOT NULL AUTO_INCREMENT,
  rückfahrtzeit TIME,
  buslinie_id INT,
  betriebszeiten INT,
  buslinie_id INT,
  tage_id INT,
  einsetzfahrt TIME,
  aussetzfahrt TIME,
  intervalle_id INTm
  PRIMARY KEY (fahrt_id),
  INDEX fk_linienfahrplan_buslinie (buslinie_id ASC),
  INDEX fk_linienfahrplan_betriebszeiten (betriebszeiten ASC),
  INDEX fk_lininefahrplan_tage (tage_id ASC),
  INDEX fk_linienfahrplan_intervalle (intervalle_id ASC),
  CONSTRAINT fk_linienfahrplan_betrienszeiten
    FOREIGN KEY (betriebszeiten)
	REFERENCES betriebszeiten (betriebszeiten_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
  CONSTRAINT fk_linienfahrplan_buslinie
    FOREIGN KEY (buslinie_id)
	REFERENCES buslinie (buslinie_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
  CONSTRAINT fk_linienfahrplan_tag
    FOREIGN KEY (tage_id)
	REFERENCES tage (tage_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
  CONSTRAINT fk_linienfahrplan_intervalle
    FOREIGN KEY intervalle_id
	  REFERENCES intervalle (intervalle_id)
	  ON DELETE CASCADE
	  ON UPDATE CASCADE
) ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS buskurs (
  buskurs_id INT NOT NULL AUTO_INCREMENT,
  buskursname VARCHAR(30),
  fahrer_id INT NOT NULL,
  bus_id INT,
  PRIMARY KEY (buskurs_id),
  INDEX fk_Buskurs_Bus (bus_id ASC),
  INDEX fk_Buskurs_Fahrer (fahrer_id ASC),
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
CREATE TABLE IF NOT EXISTS fahrer_dienstzeiten (
  fahrer_id INT,
  dienstzeiten_id INT,
  tage_id INT,
  PRIMARY KEY(fahrer_id, dienstzeiten_id),
  INDEX fk_fahrer_dienstzeiten_fahrer (fahrer_id ASC),
  INDEX fk_fahrer_dienstzeiten_dienstzeiten (dienstzeiten_id ASC),
  INDEX fk_fahrer_dienstzeiten_tage (tage_id ASC),
  CONSTRAINT fk_fahrer_dienstzeiten_fahrer
    FOREIGN KEY (fahrer_id)
    REFERENCES fahrer (fahrer_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_fahrer_dienstzeiten_dienstzeiten
    FOREIGN KEY (dienstzeiten_id)
    REFERENCES dienstzeiten (dienstzeiten_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_fahrer_dienstzeiten_tage
    FOREIGN KEY (tage_id)
    REFERENCES tage (tage_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS liniefahrplan_haltestelle (
  linienfahrplan_id INT,
  haltestelle_id INT,
  haltestellennummer INT,
  fahrzeit TIME,
  PRIMARY KEY (lininenfahrplan_id, haltestelle_id),
  INDEX fk_linienfahrplan_haltestelle_haltestelle (haltestelle_id ASC),
  INDEX fk_linienfahrplan_haltestelle_buslinie (linienfahrplan_id ASC),
  CONSTRAINT fk_linienfahrplan_haltestelle_haltestelle
    FOREIGN KEY (haltestelle_id)
	REFERENCES haltestelle (haltestelle_id)
	ON UPDATE CASCADE
	ON DELETE CASCADE, 
  CONSTRAINT fk_linienfahrplan_haltestelle_buslinie
    FOREIGN KEY (linienfahrplan_id)
	REFERENCES linienfahrplan (linienfahrplan_id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS fahrt (
  fahrt_id INT,
  fahrtbeginn TIME,
  fahrtende TIME,
  richtung VARCHAR(45),
  buskurs_id INT,
  linienfahrplan_id INT,
  PRIMARY KEY (fahrt_id),
  INDEX fk_fahrt_buskurs (buskurs_id ASC),
  INDEX fk_fahrt_linienfahrplan (linienfahrplan_id ASC),
  CONSTRAINT fk_fahrt_buskurs
    FOREIGN KEY (buskurs_id)
	REFERENCES buskurs (buskurs_id)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
  CONSTRAINT fk_fahrt_linienfahrplan
    FOREIGN KEY (linienfahrplan_id)
	REFERENCES linienfahrplan (linienfahrplan_id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE = InnoDB;