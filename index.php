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
            <form method="get" action="index.php">
                <?php
                /* ID DU CLIENT */
                echo getClientChoice($dbconn);

                /* CHOIX DU MODELE */
                echo getModelChoice($dbconn);

                /* DATE DE LOCATION */
                echo getDateChoice($dbconn); ?>

            </form>

        <h2>Requête 10</h2>

        <?php pg_close($dbconn); ?>
    </body>
</html>
