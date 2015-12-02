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

			if(isset($_GET['client']) && isset($_GET['modele']) && isset($_GET['day']) && isset($_GET['month']) && isset($_GET['year'])) {
				$modeleExplode = explode("/", $_GET['modele']);

				$availables = pg_query($dbconn, 'SELECT * FROM "Vehicule"
					WHERE nomModele IN (SELECT nomModele FROM "Modele"
						WHERE nomModele = \''.$modeleExplode[2].'\'
						AND marque = \''.$modeleExplode[1].'\')
					AND idAgence = '.$modeleExplode[0].'
					AND immatriculation NOT IN (SELECT immatriculation FROM "Location"
						WHERE dateRestitution IS NULL) LIMIT 1');

				$car = pg_fetch_row($availables);
				$immatriculation = $car[0];
				$agence = $car[4];
				$date = $_GET['year']."-".$_GET['month']."-".$_GET['day'];

				$query = pg_query('INSERT INTO "Location" (immatriculation, idclient, agenceLocation, dateLocation) VALUES (\''.$immatriculation.'\', \''.$_GET['client'].'\', \''.$agence.'\', \''.$date.'\')');


				$agenceDesc = pg_fetch_row(pg_query($dbconn, 'SELECT * FROM "Agence" WHERE idAgence = '.$agence));
				$modeleDesc = pg_fetch_row(pg_query($dbconn, 'SELECT * FROM "Modele" WHERE nomModele = \''.$modeleExplode[2].'\''));

				echo '<p>VEHICULE LOUE :';
				echo '<br />Immatriculation : '.$immatriculation;
				echo '<br />Nom : '.$modeleExplode[1].' '.$modeleExplode[2];
				echo '<br />Agence n°'.$agence.' : '.$agenceDesc[1].' au '.$agenceDesc[2];
				echo '<br />Caution : '.$modeleDesc[4];

			}
			else {
				echo '<p>Erreur lors de la location</p>';
			}

			pg_close($dbconn);
		?>
		<form method="get" action="index.php" >
            <input type="submit" value="Retourner à la page de location / resitution" />
		</form>
	</body>
</html>
