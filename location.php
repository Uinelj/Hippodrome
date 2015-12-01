<?php
$dbconf = include('config.php');
$dbconn = pg_connect("host=" . $dbconf['host'] . " dbname=" . $dbconf['dbname'] . " user=" . $dbconf['user'] . " password=" . $dbconf['password']) or die('connection failed');
if(isset($_GET['error'])) {
	if($_GET['error'] == '2') {
		echo "<p> Pas de véhicule disponibles</p>";
	}
}

if(isset($_GET['client']) && isset($_GET['modele']) && isset($_GET['day']) && isset($_GET['month']) && isset($_GET['year'])) {
	$modeleExplode = explode("/", $_GET['modele']);

	$availables = pg_query($dbconn, 'SELECT * FROM "Vehicule"
		WHERE nomModele IN (SELECT nomModele FROM "Modele"
			WHERE nomModele = \''.$modeleExplode[2].'\'
			AND marque = \''.$modeleExplode[1].'\')
		AND idAgence = \''.$modeleExplode[0].'\'
		AND immatriculation NOT IN (SELECT immatriculation FROM "Location"
			WHERE dateRestitution IS NULL) LIMIT 1');

	$car = pg_fetch_row($availables);
	$immatriculation = $car[0];
	$agence = $car[4];
	$date = $_GET['year']."-".$_GET['month']."-".$_GET['day'];
	echo "<p>Immatriculation : ".$immatriculation."<br />Agence : ".$agence."</p>";
	/*
	$query = pg_query('INSERT INTO "Location" (immatriculation, idclient, agenceLocation, dateLocation) VALUES (\''.$immatriculation.'\', \''.$_GET['client'].'\', \''.$agence.'\', \''.$date.'\')') or header('Location: index.php?error=2');

	header('Location: index.php');
	*/
	pg_close($dbconn);
}
?>
