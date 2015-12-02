<!DOCTYPE html>
<html>
    <head>
        <title>Requêtes PHP</title>
    </head>
    <body>

        <h1 style="text-align:center;">Requêtes PHP pour le projet de Base de Données</h1>
        <h3 style="text-align:center;">Réalisé par ABADJI Julien et MONOT Vincent</h3>
		<?php
			$dbconf = include('config.php');
			$dbconn = pg_connect("host=" . $dbconf['host'] . " dbname=" . $dbconf['dbname'] . " user=" . $dbconf['user'] . " password=" . $dbconf['password']) or die('connection failed');

			if(isset($_GET['location']) && isset($_GET['agence']) && isset($_GET['day']) && isset($_GET['month']) && isset($_GET['year']) && isset($_GET['kilometrage']) && isset($_GET['etat'])) {

				$idLocation = $_GET['location'];
				$kilometrage = $_GET['kilometrage'];
				$etat = $_GET['etat'];
				$agence = $_GET['agence'];

				$locationDataQuery = pg_query($dbconn, 'SELECT * FROM "Location" WHERE idLocation = '.$idLocation);
				$locationData = pg_fetch_row($locationDataQuery);
				$immatriculation = $locationData[1];

				// Vérification de la durée de la location
				$dateLocation = date_create($locationData[4]);
				$dateRestitution = $_GET['year'].'-'.$_GET['month'].'-'.$_GET['day'];
				$dateFinale = date_create($dateRestitution);
				$duree = date_diff($dateLocation, $dateFinale);
				if($duree->format('%R') == '-') {
					echo '<p style="color:red;">Erreur : date de restitution antérieure à la date de location</p>';
				}
				else {
					$nbJours = $duree->days + 1;

					$getTarif = pg_query($dbconn, 'SELECT * FROM "Modele"
						WHERE nomModele = (SELECT nomModele FROM "Vehicule"
							WHERE immatriculation = (SELECT immatriculation FROM "Location"
								WHERE idLocation = '.$idLocation.'))');

					$row = pg_fetch_row($getTarif);
					$tarif = $row[2]*$nbJours + $row[3]*$kilometrage;

					if(! $etat) {
						echo '<p>Le véhicule est cassé ! La caution est gardée</p>';
						$tarif += $row[4];
					}
					echo '<p>Prix total : '.money_format('%n', $tarif).'</p>';

					$updateQuery = 'UPDATE "Location" SET agenceRestitution = '.$agence.', dateRestitution = \''.$dateRestitution.'\', kilometrage = '.$kilometrage.', etatFinal = '.$etat.', tarif = '.$tarif.' WHERE idLocation = '.$idLocation;
					$update = pg_query($dbconn, $updateQuery);

					if($update != NULL) {
						// Mise à jour des données du véhicule utilisé (kilométrage et agence)
						$vehiculeDataQuery = pg_query($dbconn, 'SELECT * FROM "Vehicule" WHERE immatriculation = \''.$immatriculation.'\'');
						$vehiculeData = pg_fetch_row($vehiculeDataQuery);
						$precKilom = $vehiculeData[2];

						$nouvKilom = $precKilom + $kilometrage;

						pg_query($dbconn, 'UPDATE "Vehicule" SET kilometrage = '.$nouvKilom.', idAgence = '.$agence.' WHERE immatriculation = \''.$immatriculation.'\'');
					}
				}
			}
			else {
				echo '<p style="color:red;">Erreur lors de la restitution</p>';
			}

			pg_close($dbconn);
		?>
		<form method="get" action="index.php" >
            <input type="submit" value="Retourner à la page de location / resitution" />
		</form>
	</body>
</html>
