<!DOCTYPE html>
<html>
    <head>
        <title>Requêtes PHP</title>
        <?php include_once('functions.inc.php'); ?>
    </head>
    <body>
        <?php $dbconn = pg_connect("host=localhost dbname=mydb user=vincent password=98mKg45Z") or die('connection failed'); ?>

        <h1 style="text-align:center;">Requêtes PHP pour le projet de Base de Données</h1>
        <h3 style="text-align:center;">Réalisé par ABADJI Julien et MONOT Vincent</h3>

        <h2>Requête 9</h2>
            <?php
                /*
                if(isset($_GET['error'])) {
                    if($_GET['error'] == '2') {
                        echo "<p> Pas de véhicule disponibles</p>";
                    }
                }

                if(isset($_GET['client']) && isset($_GET['modele']) && isset($_GET['day']) && isset($_GET['month']) && isset($_GET['year'])) {
                    $modeleExplode = explode("/", $_GET['modele']);

                    $availables = pg_query($dbconn, 'SELECT * FROM "Vehicule"
                    	WHERE nomModele IN (SELECT nomModele FROM "Modele"
                    		WHERE nomModele = \''.$modeleExplode[1].'\'
                    		AND marque = \''.$modeleExplode[0].'\')
                    	AND immatriculation NOT IN (SELECT immatriculation FROM "Location"
                    		WHERE dateRestitution IS NULL) LIMIT 1');

                    $car = pg_fetch_row($availables);
                    $immatriculation = $car[0];
                    $agence = $car[4];
                    $date = $_GET['year']."-".$_GET['month']."-".$_GET['day'];
                    echo "<p>Immatriculation : ".$immatriculation."<br />Agence : ".$agence."</p>";

                    $query = pg_query('INSERT INTO "Location" (immatriculation, idclient, agenceLocation, dateLocation) VALUES (\''.$immatriculation.'\', \''.$_GET['client'].'\', \''.$agence.'\', \''.$date.'\')') or header('Location: index.php?error=2');

                    header('Location: index.php');
                }
                */
            ?>
            <form method="get" action="location.php">
                <?php
                /* ID DU CLIENT */
                echo getClientChoice($dbconn);

                /* CHOIX DU MODELE */
                echo getModelChoice($dbconn);

                /* DATE DE LOCATION */
                echo getDateChoice($dbconn, false); ?>

                <input type="submit" value="Ajouter" />
            </form>

        <h2>Requête 10</h2>
            <form method="get" action="restitution.php">
                <?php
                echo getLocationChoice($dbconn);
                echo getAgenceChoice($dbconn);
                echo getDateChoice($dbconn, true);
                echo getKilometrageChoice($dbconn);
                echo getEtatFinalChoice($dbconn);
                ?>

                <input type="submit" value="Ajouter" />
            </form>
        <?php pg_close($dbconn); ?>
    </body>
</html>
