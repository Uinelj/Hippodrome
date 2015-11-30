<!DOCTYPE html>
<html>
    <head>
        <title>Requêtes PHP</title>
    </head>
    <body>
        <?php $dbconn = pg_connect("host=localhost dbname=mydb user=vincent password=98mKg45Z") or die('connection failed'); ?>

        <h1 style="text-align:center;">Requêtes PHP pour le projet de Base de Données</h1>
        <h3 style="text-align:center;">Réalisé par ABADJI Julien et MONOT Vincent</h3>

        <h2>Requête 9</h2>
            <form method="get" action="index.php">
                <!-- ID DU CLIENT -->
                <label for="client" >Numéro de client</label> : <select name="client" id="client" >
                <?php
                    $query = pg_query($dbconn, 'SELECT * FROM "Client"');

                    while($row = pg_fetch_row($query)) {
                        echo '<option value="'.$idClient.'">'.$row[0].' : '.$row[1].' ('.$row[3].')</option>';
                    }
                ?>
                </select><br/>

                <!-- CHOIX DU MODELE -->
                <label for="modele" >Modèle du véhicule</label> : <select name="modele" id="modele" >
                <?php
                    $query = pg_query($dbconn, 'SELECT * FROM "Modele"
                        WHERE nomModele IN (SELECT nomModele FROM "Vehicule"
                            WHERE immatriculation NOT IN (SELECT immatriculation FROM "Location"
                                WHERE dateRestitution IS NULL))');

                    $marquePrec = "";
                    while($row = pg_fetch_row($query)) {
                        $modeleVehicule = $row[0];
                        $marqueVehicule = $row[1];
                        if($marqueVehicule != $marquePrec) {
                            if($marquePrec != "") {
                                echo '</optgroup>';
                            }
                            echo '<optgroup label="'.$marqueVehicule.'" >';
                        }
                        echo '<option value="$marqueVehicule/$modeleVehicule">'.$row[1].' '.$row[0].'</option>';
                        $marquePrec = $marqueVehicule;
                    }
                    echo '</optgroup>';
                ?>
                </select><br />

                <!-- DATE DE LOCATION -->
                <label>Date de location</label> :
                <select name="day" id="day" >
                <?php
                    for($i = 1 ; $i<=31 ; $i++) {
                        echo '<option value='.$i.'>'.$i.'</option>';
                    }
                ?>
                </select>
                <select name="month" id="month" >
                <?php
                    $months = array('Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Otobre', 'Novembre', 'Décembre', );
                    foreach ($months as $k => $m) {
                        echo '<option value='.$k.'>'.$m.'</option>';
                    }
                ?>
                </select>
                <select name="year" id="year" >
                <?php
                    for($i = 2010 ; $i<=date(Y) ; $i++) {
                        echo '<option value='.$i.'>'.$i.'</option>';
                    }
                ?>
                </select><br />

            </form>

        <h2>Requête 10</h2>

        <?php pg_close($dbconn); ?>
    </body>
</html>
