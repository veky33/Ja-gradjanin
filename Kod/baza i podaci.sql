CREATE DATABASE  IF NOT EXISTS `civitas` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `civitas`;
-- MySQL dump 10.13  Distrib 8.0.15, for Win64 (x86_64)
--
-- Host: localhost    Database: civitas
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `izvjestaj`
--

DROP TABLE IF EXISTS `izvjestaj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `izvjestaj` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `File` longblob NOT NULL,
  `FK_Projekat_ProjekatID` int(11) NOT NULL,
  `DatumKreiranja` date NOT NULL,
  `IZVJESTAJ_TIP_ID` int(11) DEFAULT NULL,
  `FK_Korisnik_ID` int(11) NOT NULL,
  `FileName` varchar(255) DEFAULT NULL,
  `FileSize` bigint(100) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_Izvjestaj_Projekat_ProjekatID_idx` (`FK_Projekat_ProjekatID`),
  KEY `fk_IZVJESTAJ_IZVJESTAJ_TIP1_idx` (`IZVJESTAJ_TIP_ID`),
  KEY `FK_Korisnik_ID_idx` (`FK_Korisnik_ID`),
  CONSTRAINT `FK_Izvjestaj_Projekat_ProjekatID` FOREIGN KEY (`FK_Projekat_ProjekatID`) REFERENCES `projekat` (`ID`),
  CONSTRAINT `FK_Korisnik_ID` FOREIGN KEY (`FK_Korisnik_ID`) REFERENCES `korisnik` (`ID`),
  CONSTRAINT `fk_IZVJESTAJ_IZVJESTAJ_TIP1` FOREIGN KEY (`IZVJESTAJ_TIP_ID`) REFERENCES `izvjestaj_tip` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `izvjestaj_tip`
--

DROP TABLE IF EXISTS `izvjestaj_tip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `izvjestaj_tip` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `izvjestaj_tip_prevod`
--

DROP TABLE IF EXISTS `izvjestaj_tip_prevod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `izvjestaj_tip_prevod` (
  `Naziv` varchar(255) NOT NULL,
  `Napomena` varchar(255) DEFAULT NULL,
  `JEZIK_ID` int(11) NOT NULL,
  `IZVJESTAJ_TIP_ID` int(11) NOT NULL,
  PRIMARY KEY (`JEZIK_ID`,`IZVJESTAJ_TIP_ID`),
  KEY `fk_IZVJESTAJ_TIP_PREVOD_JEZIK1_idx` (`JEZIK_ID`),
  KEY `fk_IZVJESTAJ_TIP_PREVOD_IZVJESTAJ_TIP1_idx` (`IZVJESTAJ_TIP_ID`),
  CONSTRAINT `fk_IZVJESTAJ_TIP_PREVOD_IZVJESTAJ_TIP1` FOREIGN KEY (`IZVJESTAJ_TIP_ID`) REFERENCES `izvjestaj_tip` (`ID`) ON DELETE RESTRICT,
  CONSTRAINT `fk_IZVJESTAJ_TIP_PREVOD_JEZIK1` FOREIGN KEY (`JEZIK_ID`) REFERENCES `jezik` (`ID`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jezik`
--

DROP TABLE IF EXISTS `jezik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `jezik` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Naziv` varchar(255) NOT NULL,
  `Sifra` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `korisnik`
--

DROP TABLE IF EXISTS `korisnik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `korisnik` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Ime` varchar(255) NOT NULL,
  `Prezime` varchar(255) NOT NULL,
  `KorisnickoIme` varchar(45) NOT NULL,
  `LozinkaHash` varchar(128) NOT NULL,
  `Status` tinyint(1) NOT NULL DEFAULT '1',
  `IzabraniJezik` int(11) DEFAULT NULL,
  `FK_TeritorijalnaJedinica_TeritorijalnaJedinicaID` int(11) NOT NULL,
  `FK_VrstaKorisnika_VrstaKorisnikaID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `KorisnickoIme_UNIQUE` (`KorisnickoIme`),
  KEY `FK_Korisnik_VrstaKorisnika_VrstaKorisnikaID_idx` (`FK_VrstaKorisnika_VrstaKorisnikaID`),
  KEY `FK_Korisnik_TeritorijalnaJedinica_TeritorijalnaJedinicaID_idx` (`FK_TeritorijalnaJedinica_TeritorijalnaJedinicaID`),
  KEY `FK_Jezik_ID_idx` (`IzabraniJezik`),
  CONSTRAINT `FK_Jezik_ID` FOREIGN KEY (`IzabraniJezik`) REFERENCES `jezik` (`ID`) ON DELETE RESTRICT,
  CONSTRAINT `FK_Korisnik_TeritorijalnaJedinica_TeritorijalnaJedinicaID` FOREIGN KEY (`FK_TeritorijalnaJedinica_TeritorijalnaJedinicaID`) REFERENCES `teritorijalna_jedinica` (`ID`) ON DELETE RESTRICT,
  CONSTRAINT `FK_Korisnik_VrstaKorisnika_VrstaKorisnikaID` FOREIGN KEY (`FK_VrstaKorisnika_VrstaKorisnikaID`) REFERENCES `korisnik_vrsta` (`ID`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `korisnik_vrsta`
--

DROP TABLE IF EXISTS `korisnik_vrsta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `korisnik_vrsta` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Naziv` varchar(255) NOT NULL,
  `Opis` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `korisnik_vrsta_prevod`
--

DROP TABLE IF EXISTS `korisnik_vrsta_prevod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `korisnik_vrsta_prevod` (
  `Opis` varchar(255) DEFAULT NULL,
  `KORISNIK_VRSTA_ID` int(11) NOT NULL,
  `JEZIK_ID` int(11) NOT NULL,
  PRIMARY KEY (`JEZIK_ID`,`KORISNIK_VRSTA_ID`),
  KEY `fk_KORISNIK_VRSTA_PREVOD_KORISNIK_VRSTA1_idx` (`KORISNIK_VRSTA_ID`),
  KEY `fk_KORISNIK_VRSTA_PREVOD_JEZIK1_idx` (`JEZIK_ID`),
  CONSTRAINT `fk_KORISNIK_VRSTA_PREVOD_JEZIK1` FOREIGN KEY (`JEZIK_ID`) REFERENCES `jezik` (`ID`) ON DELETE RESTRICT,
  CONSTRAINT `fk_KORISNIK_VRSTA_PREVOD_KORISNIK_VRSTA1` FOREIGN KEY (`KORISNIK_VRSTA_ID`) REFERENCES `korisnik_vrsta` (`ID`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prihod`
--

DROP TABLE IF EXISTS `prihod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `prihod` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Opis` varchar(255) NOT NULL,
  `NovcaniIznos` decimal(10,2) NOT NULL,
  `FinansiranOd` varchar(255) NOT NULL,
  `Datum` date NOT NULL,
  `PROJEKAT_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_PRIHOD_PROJEKAT1_idx` (`PROJEKAT_ID`),
  CONSTRAINT `fk_PRIHOD_PROJEKAT1` FOREIGN KEY (`PROJEKAT_ID`) REFERENCES `projekat` (`ID`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projekat`
--

DROP TABLE IF EXISTS `projekat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `projekat` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Naziv` varchar(255) NOT NULL,
  `Opis` varchar(10000) NOT NULL,
  `OpisDokument` longblob,
  `DatumPocetka` date NOT NULL,
  `DatumZavrsetka` date NOT NULL,
  `Budzet` decimal(10,2) DEFAULT NULL,
  `ProcenatZavrsenosti` decimal(10,2) NOT NULL DEFAULT '0.00',
  `FK_ProjekatStatusID` int(11) NOT NULL,
  `FK_TeritorijalnaJedinica_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_Projekat_ProjekatStatus_ProjekatStatusID_idx` (`FK_ProjekatStatusID`),
  KEY `FK_TeritorijalnaJedinica_ID_idx` (`FK_TeritorijalnaJedinica_ID`),
  CONSTRAINT `FK_Projekat_ProjekatStatus_ProjekatStatusID` FOREIGN KEY (`FK_ProjekatStatusID`) REFERENCES `projekat_status` (`ID`) ON DELETE RESTRICT,
  CONSTRAINT `FK_TeritorijalnaJedinica_ID` FOREIGN KEY (`FK_TeritorijalnaJedinica_ID`) REFERENCES `teritorijalna_jedinica` (`ID`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projekat_koordinator`
--

DROP TABLE IF EXISTS `projekat_koordinator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `projekat_koordinator` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DatumOd` date DEFAULT NULL,
  `DatumDo` date DEFAULT NULL,
  `FK_Korisnik_KorisnikID` int(11) NOT NULL,
  `FK_Projekat_ProjekatID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_ProjekatKoordinator_Korisnik_KorisnikID_idx` (`FK_Korisnik_KorisnikID`),
  KEY `FK_ProjekatKoordinator_Projekat_ProjekatID_idx` (`FK_Projekat_ProjekatID`),
  CONSTRAINT `FK_ProjekatKoordinator_Korisnik_KorisnikID` FOREIGN KEY (`FK_Korisnik_KorisnikID`) REFERENCES `korisnik` (`ID`) ON DELETE RESTRICT,
  CONSTRAINT `FK_ProjekatKoordinator_Projekat_ProjekatID` FOREIGN KEY (`FK_Projekat_ProjekatID`) REFERENCES `projekat` (`ID`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projekat_mentor`
--

DROP TABLE IF EXISTS `projekat_mentor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `projekat_mentor` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DatumOd` date DEFAULT NULL,
  `DatumDo` date DEFAULT NULL,
  `FK_ProjekatID` int(11) NOT NULL,
  `FK_UcesnikProjektaID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_ProjekatMentor_Projekat_ProjekatID_idx` (`FK_ProjekatID`),
  KEY `FK_ProjekatMentor_UcesnikProjekta_UcesnikProjektaID_idx` (`FK_UcesnikProjektaID`),
  CONSTRAINT `FK_ProjekatMentor_Projekat_ProjekatID` FOREIGN KEY (`FK_ProjekatID`) REFERENCES `projekat` (`ID`) ON DELETE RESTRICT,
  CONSTRAINT `FK_ProjekatMentor_UcesnikProjekta_UcesnikProjektaID` FOREIGN KEY (`FK_UcesnikProjektaID`) REFERENCES `projekat_ucesnik` (`ID`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projekat_nastavnik`
--

DROP TABLE IF EXISTS `projekat_nastavnik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `projekat_nastavnik` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DatumOd` date DEFAULT NULL,
  `DatumDo` date DEFAULT NULL,
  `FK_UcesnikProjektaID` int(11) NOT NULL,
  `FK_ProjekatID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_ProjekatNastavnik_Projekat_ProjekatID_idx` (`FK_ProjekatID`),
  KEY `FK_ProjekatNastavnik_UcesnikProjekta_UcesnikProjektaID_idx` (`FK_UcesnikProjektaID`),
  CONSTRAINT `FK_ProjekatNastavnik_Projekat_ProjekatID` FOREIGN KEY (`FK_ProjekatID`) REFERENCES `projekat` (`ID`) ON DELETE RESTRICT,
  CONSTRAINT `FK_ProjekatNastavnik_UcesnikProjekta_UcesnikProjektaID` FOREIGN KEY (`FK_UcesnikProjektaID`) REFERENCES `projekat_ucesnik` (`ID`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projekat_pobjednicki`
--

DROP TABLE IF EXISTS `projekat_pobjednicki`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `projekat_pobjednicki` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FK_Projekat_ProjekatID` int(11) NOT NULL,
  `FK_TeritorijalnaJedinica_TeritorijalnaJedinicaID` int(11) NOT NULL,
  `Godina` year(4) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_PobjednickiProjekat_Projekat_ProjekatID_idx` (`FK_Projekat_ProjekatID`),
  KEY `FK_PobjednickiProjekat_TeritorijalnaJedinica_TeritorijalnaJ_idx` (`FK_TeritorijalnaJedinica_TeritorijalnaJedinicaID`),
  CONSTRAINT `FK_PobjednickiProjekat_Projekat_ProjekatID` FOREIGN KEY (`FK_Projekat_ProjekatID`) REFERENCES `projekat` (`ID`) ON DELETE RESTRICT,
  CONSTRAINT `FK_PobjednickiProjekat_TeritorijalnaJedinicaID` FOREIGN KEY (`FK_TeritorijalnaJedinica_TeritorijalnaJedinicaID`) REFERENCES `teritorijalna_jedinica` (`ID`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projekat_status`
--

DROP TABLE IF EXISTS `projekat_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `projekat_status` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projekat_status_prevod`
--

DROP TABLE IF EXISTS `projekat_status_prevod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `projekat_status_prevod` (
  `Naziv` varchar(255) NOT NULL,
  `Opis` varchar(255) NOT NULL,
  `JEZIK_ID` int(11) NOT NULL,
  `PROJEKAT_STATUS_ID` int(11) NOT NULL,
  PRIMARY KEY (`JEZIK_ID`,`PROJEKAT_STATUS_ID`),
  KEY `fk_PROJEKAT_STATUS_PREVOD_JEZIK1_idx` (`JEZIK_ID`),
  KEY `fk_PROJEKAT_STATUS_PREVOD_PROJEKAT_STATUS1_idx` (`PROJEKAT_STATUS_ID`),
  CONSTRAINT `fk_PROJEKAT_STATUS_PREVOD_JEZIK1` FOREIGN KEY (`JEZIK_ID`) REFERENCES `jezik` (`ID`) ON DELETE RESTRICT,
  CONSTRAINT `fk_PROJEKAT_STATUS_PREVOD_PROJEKAT_STATUS1` FOREIGN KEY (`PROJEKAT_STATUS_ID`) REFERENCES `projekat_status` (`ID`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projekat_ucenik`
--

DROP TABLE IF EXISTS `projekat_ucenik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `projekat_ucenik` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FK_ProjekatID` int(11) NOT NULL,
  `FK_UcesnikProjektaID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_ProjekatUcenik_Projekat_ProjekatID_idx` (`FK_ProjekatID`),
  KEY `FK_ProjekatUcenik_UcesnikProjekta_UcesnikProjektaID_idx` (`FK_UcesnikProjektaID`),
  CONSTRAINT `FK_ProjekatUcenik_Projekat_ProjekatID` FOREIGN KEY (`FK_ProjekatID`) REFERENCES `projekat` (`ID`) ON DELETE RESTRICT,
  CONSTRAINT `FK_ProjekatUcenik_UcesnikProjekta_UcesnikProjektaID` FOREIGN KEY (`FK_UcesnikProjektaID`) REFERENCES `projekat_ucesnik` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projekat_ucesnik`
--

DROP TABLE IF EXISTS `projekat_ucesnik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `projekat_ucesnik` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Ime` varchar(255) NOT NULL,
  `Prezime` varchar(255) NOT NULL,
  `FK_UcesnikProjektaUlogaID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_UcesnikProjekta_UcesnikProjektaUloga_UcesnikProjektaUlog_idx` (`FK_UcesnikProjektaUlogaID`),
  CONSTRAINT `FK_UcesnikProjekta_UcesnikProjektaUloga_UcesnikProjektaUlogaID` FOREIGN KEY (`FK_UcesnikProjektaUlogaID`) REFERENCES `projekat_ucesnik_uloga` (`ID`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projekat_ucesnik_uloga`
--

DROP TABLE IF EXISTS `projekat_ucesnik_uloga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `projekat_ucesnik_uloga` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projekat_ucesnik_uloga_prevod`
--

DROP TABLE IF EXISTS `projekat_ucesnik_uloga_prevod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `projekat_ucesnik_uloga_prevod` (
  `Naziv` varchar(255) NOT NULL,
  `Opis` varchar(255) DEFAULT NULL,
  `JEZIK_ID` int(11) NOT NULL,
  `PROJEKAT_UCESNIK_ULOGA_ID` int(11) NOT NULL,
  PRIMARY KEY (`JEZIK_ID`,`PROJEKAT_UCESNIK_ULOGA_ID`),
  KEY `fk_PROJEKAT_UCESNIK_ULOGA_PREVOD_JEZIK1_idx` (`JEZIK_ID`),
  KEY `fk_PROJEKAT_UCESNIK_ULOGA_PREVOD_PROJEKAT_UCESNIK_ULOGA1_idx` (`PROJEKAT_UCESNIK_ULOGA_ID`),
  CONSTRAINT `fk_PROJEKAT_UCESNIK_ULOGA_PREVOD_JEZIK1` FOREIGN KEY (`JEZIK_ID`) REFERENCES `jezik` (`ID`) ON DELETE RESTRICT,
  CONSTRAINT `fk_PROJEKAT_UCESNIK_ULOGA_PREVOD_PROJEKAT_UCESNIK_ULOGA1` FOREIGN KEY (`PROJEKAT_UCESNIK_ULOGA_ID`) REFERENCES `projekat_ucesnik_uloga` (`ID`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projekat_vodja`
--

DROP TABLE IF EXISTS `projekat_vodja`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `projekat_vodja` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DatumOd` date DEFAULT NULL,
  `DatumDo` date DEFAULT NULL,
  `FK_ProjekatID` int(11) NOT NULL,
  `FK_UcesnikProjektaID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_ProjekatVodja_Projekat_ProjekatID_idx` (`FK_ProjekatID`),
  KEY `FK_ProjekatVodja_UcesnikProjekta_UcesnikProjektaID_idx` (`FK_UcesnikProjektaID`),
  CONSTRAINT `FK_ProjekatVodja_Projekat_ProjekatID` FOREIGN KEY (`FK_ProjekatID`) REFERENCES `projekat` (`ID`) ON DELETE RESTRICT,
  CONSTRAINT `FK_ProjekatVodja_UcesnikProjekta_UcesnikProjektaID` FOREIGN KEY (`FK_UcesnikProjektaID`) REFERENCES `projekat_ucesnik` (`ID`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rashod`
--

DROP TABLE IF EXISTS `rashod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `rashod` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Opis` varchar(255) NOT NULL,
  `NovcaniIznos` decimal(10,2) NOT NULL,
  `Datum` date NOT NULL,
  `PROJEKAT_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_RASHOD_PROJEKAT1_idx` (`PROJEKAT_ID`),
  CONSTRAINT `fk_RASHOD_PROJEKAT1` FOREIGN KEY (`PROJEKAT_ID`) REFERENCES `projekat` (`ID`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `teritorijalna_jedinica`
--

DROP TABLE IF EXISTS `teritorijalna_jedinica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `teritorijalna_jedinica` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Naziv` varchar(255) NOT NULL,
  `FK_VrstaTeritorijalneJedinice_VrstaTeritorijalneJediniceID` int(11) NOT NULL,
  `FK_NadTeritorijalnaJedinica` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_VrstaTeritorijalneJedinice_VrstaTeritorijalneJediniceID_idx` (`FK_VrstaTeritorijalneJedinice_VrstaTeritorijalneJediniceID`),
  KEY `FK_NadTeritorijalnaJedinica_idx` (`FK_NadTeritorijalnaJedinica`),
  CONSTRAINT `FK_NadTeritorijalnaJedinica` FOREIGN KEY (`FK_NadTeritorijalnaJedinica`) REFERENCES `teritorijalna_jedinica` (`ID`) ON DELETE RESTRICT,
  CONSTRAINT `FK_VrstaTeritorijalneJedinice_VrstaTeritorijalneJediniceID` FOREIGN KEY (`FK_VrstaTeritorijalneJedinice_VrstaTeritorijalneJediniceID`) REFERENCES `teritorijalna_jedinica_vrsta` (`ID`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `teritorijalna_jedinica_vrsta`
--

DROP TABLE IF EXISTS `teritorijalna_jedinica_vrsta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `teritorijalna_jedinica_vrsta` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Dubina` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `teritorijalna_jedinica_vrsta_prevod`
--

DROP TABLE IF EXISTS `teritorijalna_jedinica_vrsta_prevod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `teritorijalna_jedinica_vrsta_prevod` (
  `Naziv` varchar(255) NOT NULL,
  `Napomena` varchar(255) DEFAULT NULL,
  `TERITORIJALNA_JEDINICA_VRSTA_ID` int(11) NOT NULL,
  `JEZIK_ID` int(11) NOT NULL,
  PRIMARY KEY (`TERITORIJALNA_JEDINICA_VRSTA_ID`,`JEZIK_ID`),
  KEY `fk_TERITORIJALNA_JEDINICA_VRSTA_PREVOD_JEZIK1_idx` (`JEZIK_ID`),
  CONSTRAINT `fk_TERITORIJALNA_JEDINICA_VRSTA_PREVOD_JEZIK1` FOREIGN KEY (`JEZIK_ID`) REFERENCES `jezik` (`ID`) ON DELETE RESTRICT,
  CONSTRAINT `fk_TERITORIJALNA_JEDINICA_VRSTA_PREVOD_TERITORIJALNA_JEDINICA1` FOREIGN KEY (`TERITORIJALNA_JEDINICA_VRSTA_ID`) REFERENCES `teritorijalna_jedinica_vrsta` (`ID`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'civitas'
--

--
-- Dumping routines for database 'civitas'
--
/*!50003 DROP PROCEDURE IF EXISTS `getUkupanBrojKorisnika` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUkupanBrojKorisnika`(out brojKorisnika int)
begin
	select count(ID)
    into brojKorisnika
    from korisnik;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getZbirPrihoda` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getZbirPrihoda`(out zbirPrihoda decimal(10.2))
begin
	select format(sum(NovcaniIznos), 2)
    into zbirPrihoda
    from prihod
    inner join projekat
    where prihod.PROJEKAT_ID=projekat.ID;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getZbirRashoda` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getZbirRashoda`(out zbirRashoda decimal(10.2))
begin
	select format(sum(NovcaniIznos), 2)
    into zbirRashoda
    from rashod
    inner join projekat
    where rashod.PROJEKAT_ID=projekat.ID;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-01 12:31:10
