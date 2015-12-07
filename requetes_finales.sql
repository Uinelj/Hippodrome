-- REQUÊTE 1 (Afficher la liste des noms et adresses de tous les clients qui ont effectué au moins une location d’une voiture et d’un véhicule utilitaire)
SELECT nomClient, adresseClient
FROM "Client"
WHERE idClient IN (
	SELECT idClient
	FROM "Location"
    WHERE immatriculation IN (
		SELECT immatriculation
		FROM "Vehicule"
        WHERE nomModele IN (
			SELECT nomModele
			FROM "Modele"
            WHERE nomModele IN (
				SELECT nomModele
				FROM "Modele" NATURAL JOIN "Utilitaire"
			)
		)
	)
)
AND idClient IN (
	SELECT idClient
	FROM "Location"
    WHERE immatriculation IN (
		SELECT immatriculation
		FROM "Vehicule"
        WHERE nomModele IN (
			SELECT nomModele
			FROM "Modele"
    		WHERE nomModele NOT IN (
				SELECT nomModele
				FROM "Modele" NATURAL JOIN "Utilitaire"
			)
		)
	)
)

-- REQUÊTE 2 (Afficher la liste des modèles de véhicules n’ayant fait l’objet d’aucune location de la part des entreprises, vous indiquerez également la marque de chaque véhicule)
SELECT nomModele, marque FROM "Modele"
	WHERE nomModele NOT IN (SELECT nomModele FROM "Vehicule"
		WHERE immatriculation IN (SELECT immatriculation FROM "Location"
			WHERE idClient IN (SELECT idClient FROM "Client"
				WHERE type = 'entreprise')))

-- REQUÊTE 3 (Afficher les numéros et les noms des clients ayant effectué au moins une location pour laquelle l’agence de restitution est différente de l’agence où le véhicule a été loué)
SELECT idClient, nomClient FROM "Client"
	WHERE idClient IN (SELECT idClient FROM "Location"
		WHERE agenceLocation != agenceRestitution)

-- REQUÊTE 4 (Afficher les agences dans lesquelles au moins un véhicule utilitaire de chacune des marques existantes dans l’entreprise est disponible à la location au moment où la requête est exécutée)
SELECT idAgence, nomAgence, adresseAgence
FROM "Agence" NATURAL JOIN "Vehicule" NATURAL JOIN "Modele"
WHERE immatriculation NOT IN (
	SELECT immatriculation
	FROM "Location"
	WHERE dateRestitution IS NULL
)
AND nomModele IN (
	SELECT nomModele
	FROM "Modele" NATURAL JOIN "Utilitaire"
)
GROUP BY idAgence, nomAgence, adresseAgence
HAVING count(DISTINCT marque) = (
	SELECT count(DISTINCT marque)
	FROM "Modele"
)
ORDER BY idAgence
/* BAILS DE TEST POUR LA Q4

CREATE TEMP TABLE "a" AS(SELECT "marque" FROM "Modele" WHERE "nommodele" IN ( SELECT "nommodele" FROM "Utilitaire" ));

FOR i IN
    SELECT * FROM "Agence"
LOOP
    CREATE TEMP TABLE "b" AS(SELECT "marque" FROM "Modele" WHERE "nommodele" IN (SELECT "nommodele" FROM "Vehicule" WHERE ("nommodele" IN (
    SELECT "nommodele" FROM "Modele" NATURAL JOIN "Utilitaire")) AND
    "idagence" = (SELECT "idagence"    FROM "Agence" WHERE "idagence" = i))));

SELECT count (1)
    FROM a
    FULL OUTER JOIN b
        USING ("marque")
    WHERE a.marque IS NULL
        OR b.marque IS NULL ;
END LOOP;

CREATE OR REPLACE FUNCTION raloud() RETURNS TABLE(nomagence) AS
$$
  BEGIN
  isNotSame integer;
  CREATE TEMP TABLE "a" AS(SELECT "marque" FROM "Modele" WHERE "nommodele" IN ( SELECT "nommodele" FROM "Utilitaire" ));
  FOR i IN SELECT "idagence" FROM "Agence" LOOP

    CREATE TEMP TABLE "b" AS(SELECT "marque" FROM "Modele" WHERE "nommodele" IN (SELECT "nommodele" FROM "Vehicule" WHERE ("nommodele" IN (
    SELECT "nommodele" FROM "Modele" NATURAL JOIN "Utilitaire")) AND
    "idagence" = (SELECT "idagence"    FROM "Agence" WHERE "idagence" = i))));

    isNotSame := SELECT count (1)
        FROM a
        FULL OUTER JOIN b
            USING ("marque")
        WHERE a.marque IS NULL
            OR b.marque IS NULL ;
    IF isNotSame = 0 THEN
      RETURN QUERY INSERT INTO
    END IF;
  ENDLOOP;
  END;
$$


CREATE TEMP TABLE "a" AS(SELECT "marque" FROM "Modele" WHERE "nommodele" IN ( SELECT "nommodele" FROM "Utilitaire" ));

CREATE TEMP TABLE "b" AS(SELECT "marque" FROM "Modele" WHERE "nommodele" IN (SELECT "nommodele" FROM "Vehicule" WHERE ("nommodele" IN (
    SELECT "nommodele" FROM "Modele" NATURAL JOIN "Utilitaire")) AND
    "idagence" = (SELECT "idagence"    FROM "Agence" WHERE "idagence" = '1')));

*/


-- REQUÊTE 5 (Afficher les noms des responsables des agences dans lesquelles il est impossible de louer un véhicule de catégorie voiture. Aucune voiture n’est disponible au moment où la requête est exécutée)
SELECT nomEmploye, nomAgence FROM "Employe" NATURAL JOIN "Agence"
	WHERE idEmploye IN (SELECT idEmploye FROM "RespAgence"
		WHERE idAgence IN (SELECT idAgence FROM "Vehicule"
			WHERE nomModele IN (SELECT nomModele FROM "Modele"
				WHERE nomModele NOT IN (SELECT nommodele FROM "Modele" NATURAL JOIN "Utilitaire"))
			AND immatriculation IN (SELECT immatriculation FROM "Location"
				WHERE dateRestitution IS NULL)))


-- REQUÊTE 6 (Trouver le plus grand nombre de locations effectuées par un client et afficher les noms et adresses des clients qui ont effectué ce grand nombre de locations)
SELECT nomClient, adresseClient, count
	FROM (
		SELECT idClient, count(*) FROM "Location"
			GROUP BY idClient
			ORDER BY count DESC
			LIMIT 1
		) AS "LocationNb", "Client"
	WHERE "LocationNb".idClient = "Client".idClient
	ORDER BY "LocationNb".count DESC
	LIMIT 1

-- REQUÊTE 7 (Afficher, agence par agence, le nom de l’agence, le nom de son responsable, ainsi que le nombre de locations de plus de trois jours effectuées en 2015)

SELECT idAgence, nomAgence, nomEmploye, count
FROM (
	SELECT agenceLocation, count(agenceLocation)
	FROM "Location"
	WHERE dateRestitution-dateLocation > 3
	AND extract(year FROM dateLocation) = 2015
	GROUP BY agenceLocation
	ORDER BY agenceLocation ASC
) AS "LocationNb", "Agence" NATURAL JOIN "Employe" NATURAL JOIN "RespAgence"
WHERE "LocationNb".agenceLocation = "Agence".idAgence

-- REQUÊTE 8 (Pour chaque véhicule de moins de 20000km (au moment où la requête est effectuée), donner la somme totale des montants de toutes les locations effectuées par des entreprises dont il a fait l’objet au cours du mois de juillet 2015)
SELECT "Vehicule".immatriculation, nomModele, sum
FROM (
	SELECT immatriculation, sum(tarif)
	FROM "Location"
	WHERE (to_char(dateLocation, 'YYYY-MM') = '2015-07'
		OR to_char(dateRestitution, 'YYYY-MM') = '2015-07'
		OR (SELECT (dateLocation, dateRestitution) OVERLAPS (DATE '2015-07-01', DATE '2015-07-31')))
	AND idClient IN (
		SELECT idClient
		FROM "Client"
		WHERE type = 'entreprise'
	)
	GROUP BY immatriculation
) AS "LocationSomme", "Vehicule"
WHERE "LocationSomme".immatriculation = "Vehicule".immatriculation
AND kilometrage < 20000


-- REQUÊTE 9
-- Liste des modèles disponibles
SELECT idAgence, nomModele, marque FROM "Vehicule" NATURAL JOIN "Modele"
	WHERE immatriculation NOT IN (SELECT immatriculation FROM "Location"
		WHERE dateRestitution IS NULL)
	GROUP BY idAgence, marque, nomModele
	ORDER BY idAgence, marque, nomModele

-- REQUÊTE 10
-- Noms des gens ayant loué mais pas rendu
SELECT idClient, nomClient, type, idLocation, immatriculation, agenceLocation, dateLocation FROM "Client" NATURAL JOIN "Location"
	WHERE dateRestitution IS NULL
	ORDER BY idLocation
