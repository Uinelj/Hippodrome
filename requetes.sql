-- Modèles de véhicules non-utilitaires
SELECT * FROM "Modele" WHERE nomModele != (SELECT nommodele FROM "Modele" NATURAL JOIN "Utilitaire")

-- Modèles de véhicules utilitaires
SELECT * FROM "Modele" WHERE nomModele = (SELECT nommodele FROM "Modele" NATURAL JOIN "Utilitaire")

-- Véhicules non-utilitaires
SELECT * FROM "Vehicule" WHERE nomModele = (SELECT nomModele FROM "Modele" WHERE nomModele != (SELECT nommodele FROM "Modele" NATURAL JOIN "Utilitaire"))

-- Véhicules utilitaires
SELECT * FROM "Vehicule" WHERE nomModele = (SELECT nomModele FROM "Modele" WHERE nomModele = (SELECT nommodele FROM "Modele" NATURAL JOIN "Utilitaire"))

-- Locations de véhicules non-utilitaires
SELECT * FROM "Location" WHERE immatriculation = (SELECT immatriculation FROM "Vehicule" WHERE nomModele = (SELECT nomModele FROM "Modele" WHERE nomModele != (SELECT nommodele FROM "Modele" NATURAL JOIN "Utilitaire")))

-- Locations de véhicules utilitaires
SELECT * FROM "Location" WHERE immatriculation = (SELECT immatriculation FROM "Vehicule" WHERE nomModele = (SELECT nomModele FROM "Modele" WHERE nomModele = (SELECT nommodele FROM "Modele" NATURAL JOIN "Utilitaire")))

-- Client ayant loué un véhicule non-utilitaire
SELECT nomClient, adresseClient FROM "Client" WHERE idClient = (SELECT idClient FROM "Location" WHERE immatriculation = (SELECT immatriculation FROM "Vehicule" WHERE nomModele = (SELECT nomModele FROM "Modele" WHERE nomModele != (SELECT nommodele FROM "Modele" NATURAL JOIN "Utilitaire"))))

-- Client ayant loué un véhicule utilitaire
SELECT nomClient, adresseClient FROM "Client" WHERE idClient = (SELECT idClient FROM "Location" WHERE immatriculation = (SELECT immatriculation FROM "Vehicule" WHERE nomModele = (SELECT nomModele FROM "Modele" WHERE nomModele = (SELECT nommodele FROM "Modele" NATURAL JOIN "Utilitaire"))))

-- REQUÊTE 1
SELECT nomClient, adresseClient FROM "Client"
	WHERE idClient = (SELECT idClient FROM "Location"
        WHERE immatriculation = (SELECT immatriculation FROM "Vehicule"
            WHERE nomModele = (SELECT nomModele FROM "Modele"
                WHERE nomModele != (SELECT nomModele FROM "Modele" NATURAL JOIN "Utilitaire"))))
    AND idClient = (SELECT idClient FROM "Location"
        WHERE immatriculation = (SELECT immatriculation FROM "Vehicule"
            WHERE nomModele = (SELECT nomModele FROM "Modele"
        		WHERE nomModele = (SELECT nomModele FROM "Modele" NATURAL JOIN "Utilitaire"))))
