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

-- Clients ayant loué un véhicule non-utilitaire
SELECT nomClient, adresseClient FROM "Client" WHERE idClient = (SELECT idClient FROM "Location" WHERE immatriculation = (SELECT immatriculation FROM "Vehicule" WHERE nomModele = (SELECT nomModele FROM "Modele" WHERE nomModele != (SELECT nommodele FROM "Modele" NATURAL JOIN "Utilitaire"))))

-- Clients ayant loué un véhicule utilitaire
SELECT nomClient, adresseClient FROM "Client" WHERE idClient = (SELECT idClient FROM "Location" WHERE immatriculation = (SELECT immatriculation FROM "Vehicule" WHERE nomModele = (SELECT nomModele FROM "Modele" WHERE nomModele = (SELECT nommodele FROM "Modele" NATURAL JOIN "Utilitaire"))))

-- REQUÊTE 1
SELECT nomClient, adresseClient FROM "Client"
	WHERE idClient IN (SELECT idClient FROM "Location"
        WHERE immatriculation IN (SELECT immatriculation FROM "Vehicule"
            WHERE nomModele IN (SELECT nomModele FROM "Modele"
                WHERE nomModele NOT IN (SELECT nomModele FROM "Modele" NATURAL JOIN "Utilitaire"))))
    AND idClient IN (SELECT idClient FROM "Location"
        WHERE immatriculation IN (SELECT immatriculation FROM "Vehicule"
            WHERE nomModele IN (SELECT nomModele FROM "Modele"
        		WHERE nomModele NOT IN (SELECT nomModele FROM "Modele" NATURAL JOIN "Utilitaire"))))

-- REQUÊTE 2
SELECT nomModele, nomMarque FROM "Modele"
	WHERE nomModele != (SELECT nomModele FROM "Vehicule"
		WHERE immatriculation NOT IN (SELECT immatriculation FROM "Location"
			WHERE idClient NOT IN (SELECT idClient FROM "Client"
				WHERE type = 'entreprise')))

-- REQUÊTE 3
SELECT idClient, nomClient FROM "Client"
	WHERE idClient IN (SELECT idClient FROM "Location"
		WHERE agenceLocation != agenceRestitution)

-- REQUÊTE 4


-- REQUÊTE 5


-- REQUÊTE 6
SELECT nomClient, adresseClient FROM "Client"
	WHERE idClient = (SELECT idClient FROM "Location"
		GROUP BY idClient
		ORDER BY count(*) DESC
		LIMIT 1)

-- Nombre de locations de plus de 3 jours
SELECT count(*) FROM "Location"
	WHERE dateRestitution - dateLocation > 3

-- REQUÊTE 7


-- REQUÊTE 8 (pas fini)
SELECT *, SUM(tarif) FROM "Vehicule" NATURAL JOIN "Location"
	WHERE kilometrage < 20000
	AND immatriculation IN (SELECT immatriculation FROM "Location"
	AND idClient IN (SELECT idClient FROM "Client"
		WHERE type = 'entreprise')

-- REQUÊTE 9
-- Liste des modèles disponibles
SELECT * FROM "Modele"
	WHERE nomModele IN (SELECT nomModele FROM "Vehicule"
		WHERE immatriculation NOT IN (SELECT immatriculation FROM "Location"
			WHERE dateRestitution IS NULL))
	GROUP BY marque
	ORDER BY marque ASC

-- REQUÊTE 10
