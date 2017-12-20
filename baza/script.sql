CREATE DATABASE `pmfdb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DEFINER=`root`@`localhost` PROCEDURE `KreirajKurs`(in NazivKursa VARCHAR(45), in odsjek varchar(45), in semestar varchar(45), in ciklus varchar(45), in sifrakursa varchar(45))
begin
insert into Kurs(NazivKursa, Odsjek, Semestar, Ciklus, SifraKursa) VALUES (NazivKursa, odsjek,semestar,ciklus,sifrakursa);
end
CREATE DEFINER=`root`@`localhost` PROCEDURE `VratiIdKorisnika`(IN username Varchar(45))
begin
select KorisnikId from Korisnik where Korisnik.Username = username;
end
CREATE DEFINER=`root`@`localhost` PROCEDURE `VratiIdKursa`(IN SifraKursa VARCHAR(45))
begin
select KursId from Kurs where Kurs.SifraKursa = SifraKursa;
end
CREATE DEFINER=`root`@`localhost` PROCEDURE `VratiKurseveZaKorisnika`(IN KorisnikId INT)
begin
select NazivKursa from Kurs, Korisnik_Kurs where Korisnik_Kurs.Korisnik_KorisnikId = KorisnikId;
end
CREATE DEFINER=`root`@`localhost` PROCEDURE `VratiProfesoreZaKurs`(IN KursID INT)
begin
select ime from KorisnickiDetalji, TipKorisnika, Korisnik, Korisnik_Kurs, Kurs where KorisnickiDetalji.TipKorisnika_TipKorisnikaId = 2 and TipKorisnika.TipKorisnikaId = Korisnik.TipKorisnika_TipKorisnikaId and Korisnik_Kurs.Korisnik_TipKorisnika_TipKorisnikaId = 2  and Korisnik.KorisnikId = Korisnik_Kurs.Korisnik_KorisnikId and Korisnik_Kurs.Kurs_KursId = Kurs.KursId and Kurs.KursId = KursID;
end
CREATE DEFINER=`root`@`localhost` PROCEDURE `VratiStudenteSaKursa`(IN KursId INT)
begin
select ime,prezime from KorisnickiDetalji, TipKorisnika, Korisnik,Korisnik_Kurs, Kurs where KorisnickiDetalji.TipKorisnika_TipKorisnikaId = 1 and KorisnickiDetalji.TipKorisnika_TipKorisnikaId = TipKorisnika.TipKorisnikaId and TipKorisnika.TipKorisnikaId = Korisnik.TipKorisnika_TipKorisnikaId and Korisnik.TipKorisnika_TipKorisnikaId = Korisnik_Kurs.Korisnik_TipKorisnika_TipKorisnikaId and Korisnik_Kurs.Kurs_KursId = Kurs.KursId and Kurs.KursId = KursId;
end
CREATE DEFINER=`root`@`localhost` PROCEDURE `VratiTipKorisnika`(IN Username Varchar(45))
begin
select TipKorisnika_TipKorisnikaId from Korisnik where Korisnik.Username = Username;
end
 CREATE  TABLE  `pmfdb`.`ispit` (  `IspitId` int( 11  )  NOT  NULL  AUTO_INCREMENT ,
 `DatumIspita` datetime NOT  NULL ,
 `BrojParcijale` int( 11  )  DEFAULT NULL ,
 `NazivKabineta` varchar( 45  )  NOT  NULL ,
 `Kurs_KursId` int( 11  )  NOT  NULL ,
 PRIMARY  KEY (  `IspitId` ,  `Kurs_KursId`  ) ,
 KEY  `fk_Ispit_Kurs1_idx` (  `Kurs_KursId`  )  ) ENGINE  = InnoDB  DEFAULT CHARSET  = utf8 AUTO_INCREMENT  =1;
ALTER  TABLE  `pmfdb`.`ispit`  ADD  CONSTRAINT    FOREIGN  KEY (  `Kurs_KursId`  )  REFERENCES  `kurs` (  `KursId`  )  ON  DELETE NO ACTION  ON  UPDATE NO ACTION ;



INSERT INTO `pmfdb`.`ispit` SELECT * FROM `pmfbaza`.`ispit`;
 CREATE  TABLE  `pmfdb`.`korisnickidetalji` (  `KorisnickiDetaljiId` int( 11  )  NOT  NULL  AUTO_INCREMENT ,
 `Ime` varchar( 45  )  NOT  NULL ,
 `Prezime` varchar( 45  )  NOT  NULL ,
 `BrojIndexa` varchar( 45  )  DEFAULT NULL ,
 `DatumRodjenja` date NOT  NULL ,
 `Email` varchar( 45  )  NOT  NULL ,
 `TipKorisnika_TipKorisnikaId` int( 11  )  NOT  NULL ,
 PRIMARY  KEY (  `KorisnickiDetaljiId` ,  `TipKorisnika_TipKorisnikaId`  ) ,
 UNIQUE  KEY  `StudentId_UNIQUE` (  `KorisnickiDetaljiId`  ) ,
 UNIQUE  KEY  `Email_UNIQUE` (  `Email`  ) ,
 UNIQUE  KEY  `BrojIndexa_UNIQUE` (  `BrojIndexa`  ) ,
 KEY  `fk_KorisnickiDetalji_TipKorisnika1_idx` (  `TipKorisnika_TipKorisnikaId`  )  ) ENGINE  = InnoDB  DEFAULT CHARSET  = utf8 AUTO_INCREMENT  =3;
ALTER  TABLE  `pmfdb`.`korisnickidetalji`  ADD  CONSTRAINT    FOREIGN  KEY (  `TipKorisnika_TipKorisnikaId`  )  REFERENCES  `tipkorisnika` (  `TipKorisnikaId`  )  ON  DELETE NO ACTION  ON  UPDATE NO ACTION ;



INSERT INTO `pmfdb`.`korisnickidetalji` SELECT * FROM `pmfbaza`.`korisnickidetalji`;
 CREATE  TABLE  `pmfdb`.`korisnik` (  `KorisnikId` int( 11  )  NOT  NULL  AUTO_INCREMENT ,
 `TipKorisnika_TipKorisnikaId` int( 11  )  NOT  NULL ,
 `Username` varchar( 45  )  NOT  NULL ,
 `Password` varchar( 45  )  NOT  NULL ,
 `Aktivan` bit( 1  )  DEFAULT NULL ,
 `DatumKreiranjaAccounta` date  DEFAULT NULL ,
 `DatumVazenjaAccounta` date  DEFAULT NULL ,
 PRIMARY  KEY (  `KorisnikId` ,  `TipKorisnika_TipKorisnikaId`  ) ,
 UNIQUE  KEY  `KorisnikId_UNIQUE` (  `KorisnikId`  ) ,
 UNIQUE  KEY  `Username_UNIQUE` (  `Username`  ) ,
 KEY  `fk_Korisnik_TipKorisnika1_idx` (  `TipKorisnika_TipKorisnikaId`  )  ) ENGINE  = InnoDB  DEFAULT CHARSET  = utf8 AUTO_INCREMENT  =3;
ALTER  TABLE  `pmfdb`.`korisnik`  ADD  CONSTRAINT    FOREIGN  KEY (  `TipKorisnika_TipKorisnikaId`  )  REFERENCES  `tipkorisnika` (  `TipKorisnikaId`  )  ON  DELETE NO ACTION  ON  UPDATE NO ACTION ;



INSERT INTO `pmfdb`.`korisnik` SELECT * FROM `pmfbaza`.`korisnik`;
 CREATE  TABLE  `pmfdb`.`korisnik_kurs` (  `Korisnik_KorisnikId` int( 11  )  NOT  NULL ,
 `Korisnik_TipKorisnika_TipKorisnikaId` int( 11  )  NOT  NULL ,
 `Kurs_KursId` int( 11  )  NOT  NULL ,
 PRIMARY  KEY (  `Korisnik_KorisnikId` ,  `Korisnik_TipKorisnika_TipKorisnikaId` ,  `Kurs_KursId`  ) ,
 KEY  `fk_Korisnik_has_Kurs_Kurs1_idx` (  `Kurs_KursId`  ) ,
 KEY  `fk_Korisnik_has_Kurs_Korisnik1_idx` (  `Korisnik_KorisnikId` ,  `Korisnik_TipKorisnika_TipKorisnikaId`  )  ) ENGINE  = InnoDB  DEFAULT CHARSET  = utf8;
ALTER  TABLE  `pmfdb`.`korisnik_kurs`  ADD  CONSTRAINT    FOREIGN  KEY (  `Korisnik_KorisnikId` ,  `Korisnik_TipKorisnika_TipKorisnikaId`  )  REFERENCES  `korisnik` (  `KorisnikId` ,  `TipKorisnika_TipKorisnikaId`  )  ON  DELETE NO ACTION  ON  UPDATE NO ACTION ,
 ADD  CONSTRAINT    FOREIGN  KEY (  `Kurs_KursId`  )  REFERENCES  `kurs` (  `KursId`  )  ON  DELETE NO ACTION  ON  UPDATE NO ACTION ;



INSERT INTO `pmfdb`.`korisnik_kurs` SELECT * FROM `pmfbaza`.`korisnik_kurs`;
 CREATE  TABLE  `pmfdb`.`kurs` (  `KursId` int( 11  )  NOT  NULL  AUTO_INCREMENT ,
 `NazivKursa` varchar( 45  )  NOT  NULL ,
 `Odsjek` varchar( 45  )  DEFAULT NULL ,
 `Semestar` varchar( 45  )  DEFAULT NULL ,
 `Ciklus` varchar( 45  )  CHARACTER  SET utf8 COLLATE utf8_bin  DEFAULT NULL ,
 `SifraKursa` varchar( 45  )  DEFAULT NULL ,
 PRIMARY  KEY (  `KursId`  ) ,
 UNIQUE  KEY  `SifraKursa_UNIQUE` (  `SifraKursa`  )  ) ENGINE  = InnoDB  DEFAULT CHARSET  = utf8 AUTO_INCREMENT  =2;

INSERT INTO `pmfdb`.`kurs` SELECT * FROM `pmfbaza`.`kurs`;
 CREATE  TABLE  `pmfdb`.`odsjek` (  `OdsjekId` int( 11  )  NOT  NULL  AUTO_INCREMENT ,
 `KorisnickiDetalji_KorisnickiDetaljiId` int( 11  )  NOT  NULL ,
 `Naziv` varchar( 45  )  DEFAULT NULL ,
 `Smjer` varchar( 45  )  DEFAULT NULL ,
 `Fakultet` varchar( 45  )  DEFAULT NULL ,
 PRIMARY  KEY (  `OdsjekId` ,  `KorisnickiDetalji_KorisnickiDetaljiId`  ) ,
 KEY  `fk_Smjer_KorisnickiDetalji1_idx` (  `KorisnickiDetalji_KorisnickiDetaljiId`  )  ) ENGINE  = InnoDB  DEFAULT CHARSET  = utf8 AUTO_INCREMENT  =1;
ALTER  TABLE  `pmfdb`.`odsjek`  ADD  CONSTRAINT    FOREIGN  KEY (  `KorisnickiDetalji_KorisnickiDetaljiId`  )  REFERENCES  `korisnickidetalji` (  `KorisnickiDetaljiId`  )  ON  DELETE NO ACTION  ON  UPDATE NO ACTION ;



INSERT INTO `pmfdb`.`odsjek` SELECT * FROM `pmfbaza`.`odsjek`;
 CREATE  TABLE  `pmfdb`.`rezultatizadatka` (  `RezultatId` int( 11  )  NOT  NULL  AUTO_INCREMENT ,
 `OsvojeniBrojBodova` int( 11  )  DEFAULT NULL ,
 PRIMARY  KEY (  `RezultatId`  ) ,
 UNIQUE  KEY  `OsvojeniBrojBodova_UNIQUE` (  `OsvojeniBrojBodova`  )  ) ENGINE  = InnoDB  DEFAULT CHARSET  = utf8 AUTO_INCREMENT  =1;

INSERT INTO `pmfdb`.`rezultatizadatka` SELECT * FROM `pmfbaza`.`rezultatizadatka`;
 CREATE  TABLE  `pmfdb`.`tipkorisnika` (  `TipKorisnikaId` int( 11  )  NOT  NULL  AUTO_INCREMENT ,
 `Tip` varchar( 45  )  NOT  NULL ,
 PRIMARY  KEY (  `TipKorisnikaId`  ) ,
 UNIQUE  KEY  `TipKorisnikaId_UNIQUE` (  `TipKorisnikaId`  )  ) ENGINE  = InnoDB  DEFAULT CHARSET  = utf8 AUTO_INCREMENT  =3;

INSERT INTO `pmfdb`.`tipkorisnika` SELECT * FROM `pmfbaza`.`tipkorisnika`;
 CREATE  TABLE  `pmfdb`.`zadatak` (  `ZadatakId` int( 11  )  NOT  NULL  AUTO_INCREMENT ,
 `RedniBrojZadatka` int( 11  )  NOT  NULL ,
 `MaxBrojBodova` int( 11  )  NOT  NULL ,
 `Komentar` varchar( 45  )  DEFAULT NULL ,
 `Ispit_IspitId` int( 11  )  NOT  NULL ,
 `Ispit_Kurs_KursId` int( 11  )  NOT  NULL ,
 `RezultatiZadatka_RezultatId` int( 11  )  NOT  NULL ,
 PRIMARY  KEY (  `ZadatakId` ,  `Ispit_IspitId` ,  `Ispit_Kurs_KursId` ,  `RezultatiZadatka_RezultatId`  ) ,
 KEY  `fk_Zadatak_Ispit1_idx` (  `Ispit_IspitId` ,  `Ispit_Kurs_KursId`  ) ,
 KEY  `fk_Zadatak_RezultatiZadatka1_idx` (  `RezultatiZadatka_RezultatId`  )  ) ENGINE  = InnoDB  DEFAULT CHARSET  = utf8 AUTO_INCREMENT  =1;
ALTER  TABLE  `pmfdb`.`zadatak`  ADD  CONSTRAINT    FOREIGN  KEY (  `Ispit_IspitId` ,  `Ispit_Kurs_KursId`  )  REFERENCES  `ispit` (  `IspitId` ,  `Kurs_KursId`  )  ON  DELETE NO ACTION  ON  UPDATE NO ACTION ,
 ADD  CONSTRAINT    FOREIGN  KEY (  `RezultatiZadatka_RezultatId`  )  REFERENCES  `rezultatizadatka` (  `RezultatId`  )  ON  DELETE NO ACTION  ON  UPDATE NO ACTION ;



INSERT INTO `pmfdb`.`zadatak` SELECT * FROM `pmfbaza`.`zadatak`;

ALTER TABLE `ispit`
  ADD CONSTRAINT fk_Ispit_Kurs1 FOREIGN KEY (Kurs_KursId) REFERENCES kurs (KursId) ON DELETE NO ACTION ON UPDATE NO ACTION;


ALTER TABLE `korisnickidetalji`
  ADD CONSTRAINT fk_KorisnickiDetalji_TipKorisnika1 FOREIGN KEY (TipKorisnika_TipKorisnikaId) REFERENCES tipkorisnika (TipKorisnikaId) ON DELETE NO ACTION ON UPDATE NO ACTION;


ALTER TABLE `korisnik`
  ADD CONSTRAINT fk_Korisnik_TipKorisnika1 FOREIGN KEY (TipKorisnika_TipKorisnikaId) REFERENCES tipkorisnika (TipKorisnikaId) ON DELETE NO ACTION ON UPDATE NO ACTION;


ALTER TABLE `korisnik_kurs`
  ADD CONSTRAINT fk_Korisnik_has_Kurs_Korisnik1 FOREIGN KEY (Korisnik_KorisnikId, Korisnik_TipKorisnika_TipKorisnikaId) REFERENCES korisnik (KorisnikId, TipKorisnika_TipKorisnikaId) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_Korisnik_has_Kurs_Kurs1 FOREIGN KEY (Kurs_KursId) REFERENCES kurs (KursId) ON DELETE NO ACTION ON UPDATE NO ACTION;


ALTER TABLE `odsjek`
  ADD CONSTRAINT fk_Smjer_KorisnickiDetalji1 FOREIGN KEY (KorisnickiDetalji_KorisnickiDetaljiId) REFERENCES korisnickidetalji (KorisnickiDetaljiId) ON DELETE NO ACTION ON UPDATE NO ACTION;


ALTER TABLE `zadatak`
  ADD CONSTRAINT fk_Zadatak_Ispit1 FOREIGN KEY (Ispit_IspitId, Ispit_Kurs_KursId) REFERENCES ispit (IspitId, Kurs_KursId) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_Zadatak_RezultatiZadatka1 FOREIGN KEY (RezultatiZadatka_RezultatId) REFERENCES rezultatizadatka (RezultatId) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER  TABLE  `pmfdb`.`ispit`  ADD  CONSTRAINT    FOREIGN  KEY (  `Kurs_KursId`  )  REFERENCES  `kurs` (  `KursId`  )  ON  DELETE NO ACTION  ON  UPDATE NO ACTION ;


ALTER  TABLE  `pmfdb`.`korisnickidetalji`  ADD  CONSTRAINT    FOREIGN  KEY (  `TipKorisnika_TipKorisnikaId`  )  REFERENCES  `tipkorisnika` (  `TipKorisnikaId`  )  ON  DELETE NO ACTION  ON  UPDATE NO ACTION ;


ALTER  TABLE  `pmfdb`.`korisnik`  ADD  CONSTRAINT    FOREIGN  KEY (  `TipKorisnika_TipKorisnikaId`  )  REFERENCES  `tipkorisnika` (  `TipKorisnikaId`  )  ON  DELETE NO ACTION  ON  UPDATE NO ACTION ;


ALTER  TABLE  `pmfdb`.`korisnik_kurs`  ADD  CONSTRAINT    FOREIGN  KEY (  `Korisnik_KorisnikId` ,  `Korisnik_TipKorisnika_TipKorisnikaId`  )  REFERENCES  `korisnik` (  `KorisnikId` ,  `TipKorisnika_TipKorisnikaId`  )  ON  DELETE NO ACTION  ON  UPDATE NO ACTION ,
 ADD  CONSTRAINT    FOREIGN  KEY (  `Kurs_KursId`  )  REFERENCES  `kurs` (  `KursId`  )  ON  DELETE NO ACTION  ON  UPDATE NO ACTION ;


ALTER  TABLE  `pmfdb`.`odsjek`  ADD  CONSTRAINT    FOREIGN  KEY (  `KorisnickiDetalji_KorisnickiDetaljiId`  )  REFERENCES  `korisnickidetalji` (  `KorisnickiDetaljiId`  )  ON  DELETE NO ACTION  ON  UPDATE NO ACTION ;


ALTER  TABLE  `pmfdb`.`zadatak`  ADD  CONSTRAINT    FOREIGN  KEY (  `Ispit_IspitId` ,  `Ispit_Kurs_KursId`  )  REFERENCES  `ispit` (  `IspitId` ,  `Kurs_KursId`  )  ON  DELETE NO ACTION  ON  UPDATE NO ACTION ,
 ADD  CONSTRAINT    FOREIGN  KEY (  `RezultatiZadatka_RezultatId`  )  REFERENCES  `rezultatizadatka` (  `RezultatId`  )  ON  DELETE NO ACTION  ON  UPDATE NO ACTION ;

