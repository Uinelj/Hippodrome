<!DOCTYPE html>
<html style="width:800px; margin: 0 auto;">
    <head>
        <title>Requêtes PHP</title>
        <?php include_once('functions.inc.php'); ?>
    </head>
    <body>
        <?php
          $dbconf = include('config.php');
          $dbconn = pg_connect("host=" . $dbconf['host'] . " dbname=" . $dbconf['dbname'] . " user=" . $dbconf['user'] . " password=" . $dbconf['password']) or die('connection failed');
        ?>

        <h1 style="text-align:center;">Requêtes PHP pour le projet de Base de Données</h1>
        <h3 style="text-align:center;">Réalisé par ABADJI Julien et MONOT Vincent</h3>

        <h2>Requête 9 : Location d'un véhicule</h2>
            <?php
                if(isset($_GET['imm'])) {
                    echo '<p>Le véhicule loué a pour immatriculation '.$_GET['imm'].'</p>';
                }
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

        <h2>Requête 10 : Restitution d'un véhicule</h2>
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
