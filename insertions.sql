INSERT INTO "Agence" VALUES (1, 'Agence1', '1 rue de l''agence');
INSERT INTO "Agence" VALUES (2, 'Agence2', '2 rue de l''agence');
INSERT INTO "Agence" VALUES (3, 'Agence3', '3 rue de l''agence');

INSERT INTO "Employe" VALUES (1, 'Bob', '1 rue des mecaniciens', '2009-01-01', 'mecanicien', 1);
INSERT INTO "Employe" VALUES (2, 'Robert', '2 rue des mecaniciens', '2009-02-01', 'mecanicien', 1);
INSERT INTO "Employe" VALUES (3, 'Bertrand', '3 rue des mecaniciens', '2009-01-01', 'mecanicien', 1);
INSERT INTO "Employe" VALUES (4, 'Bernard', '1 rue des commerciaux', '2009-01-01', 'commercial', 1);
INSERT INTO "Employe" VALUES (5, 'Martin', '2 rue des commerciaux', '2009-03-01', 'commercial', 1);
INSERT INTO "Employe" VALUES (6, 'Gertrude', '1 rue des responsables', '2009-01-01', 'responsable', 1);
INSERT INTO "Employe" VALUES (7, 'Benoit', '4 rue des mecaniciens', '2010-01-01', 'mecanicien', 2);
INSERT INTO "Employe" VALUES (8, 'Stephane', '5 rue des mecaniciens', '2010-01-01', 'mecanicien', 2);
INSERT INTO "Employe" VALUES (9, 'Jean', '6 rue des mecaniciens', '2010-02-01', 'mecanicien', 2);
INSERT INTO "Employe" VALUES (10, 'Philippe', '3 rue des commerciaux', '2010-01-01', 'commercial', 2);
INSERT INTO "Employe" VALUES (11, 'Samy', '4 rue des commerciaux', '2010-02-01', 'commercial', 2);
INSERT INTO "Employe" VALUES (12, 'Samuel', '2 rue des responsables', '2010-01-01', 'responsable', 2);
INSERT INTO "Employe" VALUES (13, 'Bobby', '7 rue des mecaniciens', '2011-01-01', 'mecanicien', 3);
INSERT INTO "Employe" VALUES (14, 'Patrick', '8 rue des mecaniciens', '2011-01-01', 'mecanicien', 3);
INSERT INTO "Employe" VALUES (15, 'Victor', '9 rue des mecaniciens', '2011-02-01', 'mecanicien', 3);
INSERT INTO "Employe" VALUES (16, 'Stephanie', '5 rue des commerciaux', '2011-01-01', 'commercial', 3);
INSERT INTO "Employe" VALUES (17, 'Coralie', '6 rue des commerciaux', '2011-02-01', 'commercial', 3);
INSERT INTO "Employe" VALUES (18, 'Luc', '3 rue des responsables', '2011-01-01', 'responsable', 3);

INSERT INTO "RespAgence" VALUES (6, 1);
INSERT INTO "RespAgence" VALUES (12, 2);
INSERT INTO "RespAgence" VALUES (18, 3);

INSERT INTO "Modele" VALUES ('Captur', 'Renault', '50,00 €', '2,50 €', '15 000,00 €');
INSERT INTO "Modele" VALUES ('Kangoo Express', 'Renault', '75,00 €', '3,50 €', '16 000,00 €');
INSERT INTO "Modele" VALUES ('Partner', 'Peugeot', '70,00 €', '3,00 €', '15 000,00 €');

INSERT INTO "Utilitaire" VALUES ('Kangoo Express', 3.0, 800);
INSERT INTO "Utilitaire" VALUES ('Partner', 3.0, 800);

INSERT INTO "Vehicule" VALUES ('AA111AC', '2011-06-01', 0, 'Captur', 3);
INSERT INTO "Vehicule" VALUES ('AB111AA', '2011-07-01', 0, 'Kangoo Express', 1);
INSERT INTO "Vehicule" VALUES ('AB111AC', '2011-07-01', 0, 'Kangoo Express', 3);
INSERT INTO "Vehicule" VALUES ('ZZ111ZZ', '2011-09-01', 150, 'Partner', 3);
INSERT INTO "Vehicule" VALUES ('AB111AB', '2011-06-01', 120, 'Kangoo Express', 2);
INSERT INTO "Vehicule" VALUES ('AA111AD', '2011-07-01', 350, 'Captur', 1);
INSERT INTO "Vehicule" VALUES ('ZZ112ZZ', '2011-09-01', 654, 'Partner', 1);
INSERT INTO "Vehicule" VALUES ('AA111AA', '2011-06-01', 20210, 'Captur', 1);
INSERT INTO "Vehicule" VALUES ('AA111AB', '2011-06-01', 456, 'Captur', 2);
INSERT INTO "Vehicule" VALUES ('ZZ113ZZ', '2011-09-02', 4567, 'Partner', 1);

INSERT INTO "Client" VALUES (1, 'Harry', '1 rue des particuliers', 'particulier');
INSERT INTO "Client" VALUES (2, 'Hermione', '2 rue des particuliers', 'particulier');
INSERT INTO "Client" VALUES (3, 'Ron', '3 rue des particuliers', 'particulier');
INSERT INTO "Client" VALUES (4, 'DHL', '1 rue des entreprises', 'entreprise');
INSERT INTO "Client" VALUES (5, 'FedEx', '2 rue des entreprises', 'entreprise');

INSERT INTO "Location" VALUES (1, 'AA111AA', 1, 1, '2010-01-01', 1, '2010-01-15', 650, true, '2 050,00 €');
INSERT INTO "Location" VALUES (2, 'ZZ111ZZ', 1, 2, '2010-01-01', 3, '2010-01-01', 150, true, '520,00 €');
INSERT INTO "Location" VALUES (3, 'AB111AB', 2, 2, '2010-01-01', 2, '2010-01-16', 120, true, '1 560,00 €');
INSERT INTO "Location" VALUES (4, 'AA111AD', 4, 1, '2010-01-01', 1, '2015-06-17', 350, false, '100 400,00 €');
INSERT INTO "Location" VALUES (6, 'ZZ112ZZ', 4, 3, '2015-06-05', 1, '2015-07-16', 654, true, '4 902,00 €');
INSERT INTO "Location" VALUES (5, 'AA111AA', 5, 1, '2010-01-03', 1, '2015-12-30', 19560, true, '148 520,00 €');
INSERT INTO "Location" VALUES (7, 'AA111AB', 5, 2, '2015-04-01', 2, '2015-08-17', 456, true, '7 862,00 €');
INSERT INTO "Location" VALUES (8, 'ZZ113ZZ', 1, 2, '2015-01-01', 1, '2015-11-01', 4567, true, '35 051,00 €');
INSERT INTO "Location" VALUES (9, 'AA111AB', 4, 2, '2015-06-01', NULL, NULL, NULL, NULL, NULL);
