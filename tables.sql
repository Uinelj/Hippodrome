CREATE TABLE "Agence" (
    idAgence SERIAL PRIMARY KEY,
    nomAgence varchar(80) NOT NULL,
    adresseAgence varchar(80) NOT NULL
);

CREATE TYPE TypeEmploye AS ENUM ('commercial', 'mecanicien', 'responsable');
CREATE TABLE "Employe" (
    idEmploye SERIAL PRIMARY KEY,
    nomEmploye varchar(80) NOT NULL,
    adresseEmploye varchar(80) NOT NULL,
    dateEmbauche date NOT NULL,
    type TypeEmploye NOT NULL,
    idAgence integer NOT NULL REFERENCES "Agence" (idAgence)
);

CREATE TABLE "RespAgence" (
    idEmploye integer UNIQUE REFERENCES "Employe" (idEmploye),
    idAgence integer UNIQUE REFERENCES "Agence" (idAgence),
    PRIMARY KEY (idEmploye, idAgence)
);

CREATE TABLE "Modele" (
    nomModele varchar(20) PRIMARY KEY,
    marque varchar(20) NOT NULL,
    tarifJournee money NOT NULL,
    tarifKilometre money NOT NULL,
    caution money NOT NULL
);

CREATE TABLE "Utilitaire" (
    nomModele varchar(20) PRIMARY KEY REFERENCES "Modele" (nomModele),
    capacite numeric(2,1),
    chargeMax integer
);

CREATE TABLE "Vehicule" (
    immatriculation varchar(8) PRIMARY KEY,
    dateAchat date,
    kilometrage integer,
    nomModele varchar(20) REFERENCES "Modele" (nomModele),
    idAgence integer REFERENCES "Agence" (idAgence)
);

CREATE TYPE TypeClient AS ENUM ('entreprise', 'particulier');
CREATE TABLE "Client" (
    idClient SERIAL PRIMARY KEY,
    nomClient varchar(80) NOT NULL,
    adresseClient varchar(80) NOT NULL,
    type TypeClient NOT NULL
);

CREATE TABLE "Location" (
    idLocation SERIAL PRIMARY KEY,
    immatriculation varchar(8) NOT NULL REFERENCES "Vehicule" (immatriculation),
    idClient integer NOT NULL REFERENCES "Client" (idClient),
    dateLocation date NOT NULL,
    dateRestitution date,
    kilometrage integer,
    etatFinal boolean,
    tarif money
);
