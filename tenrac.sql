-- Partie Jaune

PROMPT "Création des tables de la partie jaune du MCD"

CREATE TABLE Organisme(
   refOrganisme NUMBER(5, 0),
   nomOrganisme VARCHAR2(50) NOT NULL,
   typeOrganisme VARCHAR2(50) NOT NULL,
   raisonSociale VARCHAR2(50) NOT NULL,
   numeroSIRET VARCHAR2(14),
    CONSTRAINT ck_numeroSiret
    CHECK (LENGTH(numeroSIRET) = 14),
   PRIMARY KEY(refOrganisme)
);

CREATE TABLE Rang(
   rang VARCHAR2(50) CHECK (rang IN ('Novice', 'Compagnon')),
   PRIMARY KEY(rang)
);

CREATE TABLE Titre(
   titre VARCHAR2(50) CHECK (titre IN ('Philanthrope', 'Protecteur', 'Honorable')),
   PRIMARY KEY(titre)
);

CREATE TABLE Dignite(
   dignite VARCHAR2(50) CHECK (dignite IN ('Maitre', 'Grand Chancelier', 'Grand Maitre')),
   PRIMARY KEY(dignite)
);

CREATE TABLE Grade(
   nomGrade VARCHAR2(50) CHECK (nomGrade IN ('Affilie', 'Sympathisant', 'Adherent','Chevalier', 'Dame', 'Grand Chevalier', 'Haute Dame', 'Commandeur', 'Grand''Croix')),
   PRIMARY KEY(nomGrade)
);

CREATE TABLE Organisation(
   numero NUMBER(5, 0),
   adresse VARCHAR2(50) NOT NULL,
   PRIMARY KEY(numero)
);

CREATE TABLE Ordre(
   numero NUMBER(5, 0),
   nomOrdre VARCHAR2(50) NOT NULL,
   PRIMARY KEY(numero),
   FOREIGN KEY(numero) REFERENCES Organisation(numero)
);

CREATE TABLE Club(
   numero NUMBER(5, 0),
   nomClub VARCHAR2(50) NOT NULL,
   numeroOrdre NUMBER(5, 0),
   PRIMARY KEY(numero),
   FOREIGN KEY(numero) REFERENCES Organisation(numero),
   FOREIGN KEY(numeroOrdre) REFERENCES Ordre(numero)
);

CREATE TABLE Tenrac(
   numero NUMBER(5, 0),
   refOrganisme NUMBER(5, 0),
   codeMembre NUMBER(5, 0),
   nom VARCHAR2(50) NOT NULL,
   prenom VARCHAR2(50) NOT NULL,
   courriel VARCHAR2(50) NOT NULL,
   numeroTel VARCHAR2(14) NOT NULL,
    CONSTRAINT ck_tenrac_tel
    CHECK (REGEXP_LIKE(numeroTel, '[0-9][0-9]-[0-9][0-9]-[0-9][0-9]-[0-9][0-9]-[0-9][0-9]')),
   adressePostale VARCHAR2(7) NOT NULL,
    CONSTRAINT ck_tenrac_adresse
    CHECK (REGEXP_LIKE(adressePostale, '[0-9][0-9][0-9][0-9][0-9]')),
   nomGrade VARCHAR2(50) NOT NULL,
   dignite VARCHAR2(50),
   titre VARCHAR2(50),
   rang VARCHAR2(50),
   PRIMARY KEY(numero, refOrganisme, codeMembre),
   FOREIGN KEY(numero) REFERENCES Organisation(numero),
   FOREIGN KEY(refOrganisme) REFERENCES Organisme(refOrganisme),
   FOREIGN KEY(nomGrade) REFERENCES Grade(nomGrade),
   FOREIGN KEY(dignite) REFERENCES Dignite(dignite),
   FOREIGN KEY(titre) REFERENCES Titre(titre),
   FOREIGN KEY(rang) REFERENCES Rang(rang)
);

CREATE TABLE GradeSuperieur(
   numero NUMBER(5, 0),
   refOrganisme NUMBER(5, 0),
   codeMembre NUMBER(5, 0),
   PRIMARY KEY(numero, refOrganisme, codeMembre),
   FOREIGN KEY(numero, refOrganisme, codeMembre) REFERENCES Tenrac(numero, refOrganisme, codeMembre)
);

-- Partie Verte

PROMPT "Création des tables de la partie verte du MCD"

CREATE TABLE Groupe(
   idGroupe NUMBER(5, 0),
   numero NUMBER(5, 0) NOT NULL,
   refOrganisme NUMBER(5, 0) NOT NULL,
   codeMembre NUMBER(5, 0) NOT NULL,
   PRIMARY KEY(idGroupe),
   FOREIGN KEY(numero, refOrganisme, codeMembre) REFERENCES GradeSuperieur(numero, refOrganisme, codeMembre)
);

CREATE TABLE Partenaire(
   adresse VARCHAR2(70),
   numero NUMBER(5, 0) NOT NULL,
   PRIMARY KEY(adresse),
   FOREIGN KEY(numero) REFERENCES Ordre(numero)
);

CREATE TABLE Date_(
   date_ DATE, 
   PRIMARY KEY(date_)
);

 CREATE TABLE Repas(
   idRepas NUMBER(5, 0),
   nomRepas VARCHAR2(50) NOT NULL,
   PRIMARY KEY(idRepas)
);

-- Partie Orange

PROMPT "Création des tables de la partie orange du MCD"

CREATE TABLE Plat(
   idPlat NUMBER(5, 0),
   nomPlat VARCHAR2(50) NOT NULL,
   PRIMARY KEY(idPlat)
);

CREATE TABLE Aliment(
   nomAliment VARCHAR2(50),
   PRIMARY KEY(nomAliment)
);

CREATE TABLE Legume(
   nomAliment VARCHAR2(50),
   PRIMARY KEY(nomAliment),
   FOREIGN KEY(nomAliment) REFERENCES Aliment(nomAliment)
);

CREATE TABLE Sauce(
   idSauce NUMBER(5, 0),
   nomSauce VARCHAR2(50) NOT NULL,
   PRIMARY KEY(idSauce)
);

CREATE TABLE Ingredient(
   idIngredient NUMBER(5, 0),
   nomIngredient VARCHAR2(50) NOT NULL,
   PRIMARY KEY(idIngredient)
);

CREATE TABLE Intolerance(
   idIntolerance NUMBER(5, 0),
   PRIMARY KEY(idIntolerance)
);

CREATE TABLE Allergie(
   idIntolerance NUMBER(5, 0),
   nomAllergie VARCHAR2(50) NOT NULL,
   PRIMARY KEY(idIntolerance),
   FOREIGN KEY(idIntolerance) REFERENCES Intolerance(idIntolerance)
);

CREATE TABLE Croyance(
   idIntolerance NUMBER(5, 0),
   nomCroyance VARCHAR2(50) NOT NULL,
   PRIMARY KEY(idIntolerance),
   FOREIGN KEY(idIntolerance) REFERENCES Intolerance(idIntolerance)
);

CREATE TABLE Conviction(
   idIntolerance NUMBER(5, 0),
   nomConviction VARCHAR2(50) NOT NULL,
   PRIMARY KEY(idIntolerance),
   FOREIGN KEY(idIntolerance) REFERENCES Intolerance(idIntolerance)
);

-- Partie Violette

PROMPT "Création des tables de la partie violette du MCD"

CREATE TABLE Modele(
   idModele NUMBER(5, 0),
   nomModele VARCHAR2(50) NOT NULL,
   PRIMARY KEY(idModele)
);

CREATE TABLE Machine(
   idMachine NUMBER(5, 0),
   nomMachine VARCHAR2(50) NOT NULL,
   idModele NUMBER(5, 0) NOT NULL,
   PRIMARY KEY(idMachine),
   FOREIGN KEY(idModele) REFERENCES Modele(idModele)
);

CREATE TABLE Type(
   nomType VARCHAR2(50),
   PRIMARY KEY(nomType)
);

CREATE TABLE Entretient(
   typeEntretient VARCHAR2(50),
   PRIMARY KEY(typeEntretient)
);

CREATE TABLE DateDeb(
   DateDeb DATE,
   PRIMARY KEY(DateDeb)
);

CREATE TABLE Certificat(
   idCertificat NUMBER(5, 0),
   numero NUMBER(5, 0) NOT NULL,
   refOrganisme NUMBER(5, 0) NOT NULL,
   codeMembre NUMBER(5, 0) NOT NULL,
   PRIMARY KEY(idCertificat),
   FOREIGN KEY(numero, refOrganisme, codeMembre) REFERENCES Tenrac(numero, refOrganisme, codeMembre)
);

-- Partie Association

PROMPT "Création des tables de la partie association du MCD"

CREATE TABLE Rejoint(
   numero NUMBER(5, 0),
   refOrganisme NUMBER(5, 0),
   codeMembre NUMBER(5, 0),
   idGroupe NUMBER(5, 0),
   PRIMARY KEY(numero, refOrganisme, codeMembre, idGroupe),
   FOREIGN KEY(numero, refOrganisme, codeMembre) REFERENCES Tenrac(numero, refOrganisme, codeMembre),
   FOREIGN KEY(idGroupe) REFERENCES Groupe(idGroupe)
);

CREATE TABLE Deguste(
   adresse VARCHAR2(50),
   date_ DATE,
   idGroupe NUMBER(5, 0),
   idRepas NUMBER(5, 0),
   PRIMARY KEY(adresse, date_, idGroupe, idRepas),
   FOREIGN KEY(adresse) REFERENCES Partenaire(adresse),
   FOREIGN KEY(date_) REFERENCES Date_(date_),
   FOREIGN KEY(idGroupe) REFERENCES Groupe(idGroupe),
   FOREIGN KEY(idRepas) REFERENCES Repas(idRepas)
);

CREATE TABLE Compose(
   idRepas NUMBER(5, 0),
   idPlat NUMBER(5, 0),
   PRIMARY KEY(idRepas, idPlat),
   FOREIGN KEY(idRepas) REFERENCES Repas(idRepas),
   FOREIGN KEY(idPlat) REFERENCES Plat(idPlat)
);

CREATE TABLE Accompagne(
   idPlat NUMBER(5, 0),
   idSauce NUMBER(5, 0),
   PRIMARY KEY(idPlat, idSauce),
   FOREIGN KEY(idPlat) REFERENCES Plat(idPlat),
   FOREIGN KEY(idSauce) REFERENCES Sauce(idSauce)
);

CREATE TABLE Forme(
   idSauce NUMBER(5, 0),
   idIngredient NUMBER(5, 0),
   PRIMARY KEY(idSauce, idIngredient),
   FOREIGN KEY(idSauce) REFERENCES Sauce(idSauce),
   FOREIGN KEY(idIngredient) REFERENCES Ingredient(idIngredient)
);

CREATE TABLE Elabore(
   nomAliment VARCHAR2(50),
   idIngredient NUMBER(5, 0),
   PRIMARY KEY(nomAliment, idIngredient),
   FOREIGN KEY(nomAliment) REFERENCES Aliment(nomAliment),
   FOREIGN KEY(idIngredient) REFERENCES Ingredient(idIngredient)
);

CREATE TABLE Constitue(
   idPlat NUMBER(5, 0),
   nomAliment VARCHAR2(50),
   PRIMARY KEY(idPlat, nomAliment),
   FOREIGN KEY(idPlat) REFERENCES Plat(idPlat),
   FOREIGN KEY(nomAliment) REFERENCES Aliment(nomAliment)
);

CREATE TABLE Provoque(
   numero NUMBER(5, 0),
   refOrganisme NUMBER(5, 0),
   codeMembre NUMBER(5, 0),
   nomAliment VARCHAR2(50),
   idIntolerance NUMBER(5, 0),
   PRIMARY KEY(numero, refOrganisme, codeMembre, nomAliment, idIntolerance),
   FOREIGN KEY(numero, refOrganisme, codeMembre) REFERENCES Tenrac(numero, refOrganisme, codeMembre),
   FOREIGN KEY(nomAliment) REFERENCES Legume(nomAliment),
   FOREIGN KEY(idIntolerance) REFERENCES Intolerance(idIntolerance)
);

CREATE TABLE UtilisationOfficielle(
   idRepas NUMBER(5, 0),
   idMachine NUMBER(5, 0),
   PRIMARY KEY(idRepas, idMachine),
   FOREIGN KEY(idRepas) REFERENCES Repas(idRepas),
   FOREIGN KEY(idMachine) REFERENCES Machine(idMachine)
);

CREATE TABLE Possede(
   idMachine NUMBER(5, 0),
   idCertificat NUMBER(5, 0),
   PRIMARY KEY(idMachine, idCertificat),
   FOREIGN KEY(idMachine) REFERENCES Machine(idMachine),
   FOREIGN KEY(idCertificat) REFERENCES Certificat(idCertificat)
);

CREATE TABLE Correspond(
   idModele NUMBER(5, 0),
   nomType VARCHAR2(50),
   PRIMARY KEY(idModele, nomType),
   FOREIGN KEY(idModele) REFERENCES Modele(idModele),
   FOREIGN KEY(nomType) REFERENCES type(nomType)
);

CREATE TABLE Definit(
   nomType VARCHAR2(50),
   typeEntretient VARCHAR2(50),
   PRIMARY KEY(nomType, typeEntretient),
   FOREIGN KEY(nomType) REFERENCES type(nomType),
   FOREIGN KEY(typeEntretient) REFERENCES Entretient(typeEntretient)
);

CREATE TABLE Repare(
   idMachine NUMBER(5, 0),
   typeEntretient VARCHAR2(50),
   DateDeb DATE,
   PRIMARY KEY(idMachine, typeEntretient, DateDeb),
   FOREIGN KEY(idMachine) REFERENCES Machine(idMachine),
   FOREIGN KEY(typeEntretient) REFERENCES Entretient(typeEntretient),
   FOREIGN KEY(DateDeb) REFERENCES DateDeb(DateDeb)
);

CREATE TABLE Enregistre1(
   numero NUMBER(5, 0),
   idCertificat NUMBER(5, 0),
   PRIMARY KEY(numero, idCertificat),
   FOREIGN KEY(numero) REFERENCES Club(numero),
   FOREIGN KEY(idCertificat) REFERENCES Certificat(idCertificat)
);

CREATE TABLE Enregistre2(
   numero NUMBER(5, 0),
   idCertificat NUMBER(5, 0),
   PRIMARY KEY(numero, idCertificat),
   FOREIGN KEY(numero) REFERENCES Ordre(numero),
   FOREIGN KEY(idCertificat) REFERENCES Certificat(idCertificat)
);

-- Partie Trigger

CREATE OR REPLACE TRIGGER trg_insert_gradesup
BEFORE INSERT OR UPDATE ON GradeSuperieur
FOR EACH ROW
DECLARE
  v_grade_tenrac Tenrac.nomGrade%TYPE;
BEGIN
  -- 1. On récupère le grade du membre depuis la table Tenrac
  BEGIN
    SELECT nomGrade 
    INTO v_grade_tenrac
    FROM Tenrac
    WHERE numero = :NEW.numero 
      AND refOrganisme = :NEW.refOrganisme 
      AND codeMembre = :NEW.codeMembre;
  
  -- 2. On vérifie si le membre existe dans Tenrac
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20001, 'Impossible d''ajouter : Ce membre n''existe pas dans Tenrac.');
  END;

  -- 3. On vérifie si ce grade récupéré est suffisant
  IF TRIM(v_grade_tenrac) NOT IN ('Chevalier', 'Dame', 'Grand Chevalier', 'Haute Dame', 'Commandeur', 'Grand''Croix') THEN
    RAISE_APPLICATION_ERROR(-20002, 'Le grade actuel du membre (' || v_grade_tenrac || ') est insuffisant pour présider une réunion.');
  END IF;
END;
/

INSERT INTO Organisation VALUES (1, 'adzhaosdll');
INSERT INTO Organisme VALUES (1, 'AMU', 'sqdmqlsd', 'sqdkhsqdhk', 10101010101010);
INSERT INTO Grade VALUES ('Chevalier');
INSERT INTO Grade VALUES ('Adherent');
INSERT INTO Dignite VALUES ('Maitre');
INSERT INTO Rang VALUES ('Novice');
INSERT INTO Titre VALUES ('Philanthrope');
INSERT INTO Tenrac VALUES (1,1,1, 'Bartal', 'Manal', 'asdbhqsjkdcvqsui', '00-00-00-00-00', '00000', 'Adherent', 'Maitre', 'Philanthrope', 'Novice');
INSERT INTO GradeSuperieur VALUES (1,1,1);

INSERT INTO Organisation VALUES (2, 'adzhaosdll');
INSERT INTO Organisme VALUES (2, 'AMU', 'sqdmqlsd', 'sqdkhsqdhk', 10101010101010);
INSERT INTO Tenrac VALUES (2,2,2, 'Bartal', 'Manal', 'asdbhqsjkdcvqsui', '00-00-00-00-00', '00000', 'Chevalier', 'Maitre', 'Philanthrope', 'Novice');
INSERT INTO GradeSuperieur VALUES (2,2,2);

Select * from Tenrac;
select * from GradeSuperieur;