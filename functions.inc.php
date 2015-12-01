<?php
	function getClientChoice($dbconn) {
		$result = "";

		$result .= "<label for=\"client\" >Numéro de client</label> : <select name=\"client\" id=\"client\" >\n";
		$query = pg_query($dbconn, 'SELECT * FROM "Client"');

		while($row = pg_fetch_row($query)) {
			$result .= "\t<option value=\"".$row[0]."\">".$row[0]." : ".$row[1]." (".$row[3].")</option>\n";
		}

		$result .= "</select><br/>\n";

		return $result;
	}

	function getModelChoice($dbconn) {
		$result = "";
		$result .= "<label for=\"modele\" >Modèle du véhicule</label> : <select name=\"modele\" id=\"modele\" >\n";
		$query = pg_query($dbconn, 'SELECT idAgence, nomAgence, nomModele, marque FROM "Vehicule" NATURAL JOIN "Modele" NATURAL JOIN "Agence"
			WHERE immatriculation NOT IN (SELECT immatriculation FROM "Location"
				WHERE dateRestitution IS NULL)
			GROUP BY idAgence, nomAgence, marque, nomModele
			ORDER BY idAgence, marque, nomModele');

		$agencePrec = 0;
		$marquePrec = "";
		while($row = pg_fetch_row($query)) {
			$agence = $row[0];
			$modeleVehicule = $row[2];
			$marqueVehicule = $row[3];
			if($agence != $agencePrec) {
				if($agence != 0) {
					$result .= "\t</optgroup>\n";
				}
				$result .= "\t<optgroup label=\"".$agence." : ".$row[1]."\" >\n";
			}
			$result .= "\t\t<option value=\"".$agence."/".$marqueVehicule."/".$modeleVehicule."\">".$row[1]." - ".$marqueVehicule." ".$modeleVehicule."</option>\n";
			$agencePrec = $agence;
		}
		$result .= "\t</optgroup>\n";
		$result .= "</select><br />\n";

		return $result;
	}

	function getDateChoice($dbconn, $restitution) {
		$result = "";

		if($restitution) {
			$result .= "<label>Date de restitution</label> :\n";
		}
		else {
			$result .= "<label>Date de location</label> :\n";
		}
		$result .= "<select name=\"day\" id=\"day\" >\n";
					for($i = 1 ; $i<=31 ; $i++) {
				$result .= "\t<option value=\"".$i."\">".$i."</option>\n";
			}

		$result .= "</select>\n";

		$result .= "<select name=\"month\" id=\"month\" >\n";
		$months = array(1 => 'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Otobre', 'Novembre', 'Décembre');
		foreach ($months as $k => $m) {
			$result .= "\t<option value=\"".$k."\">".$m."</option>\n";
		}
		$result .= "</select>\n";

		$result .= "<select name=\"year\" id=\"year\" >\n";
		for($i = 2010 ; $i<=date("Y") ; $i++) {
			$result .= "\t<option value=\"".$i."\">".$i."</option>\n";
		}
		$result .= "</select><br />\n";

		return $result;
	}

	function getLocationChoice($dbconn) {
		$result = "";

		$query = pg_query($dbconn, 'SELECT idClient, nomClient, type, idLocation, immatriculation, agenceLocation, dateLocation FROM "Client" NATURAL JOIN "Location" WHERE dateRestitution IS NULL ORDER BY idLocation');


		$result .= "<label for=\"location\" >Numéro de location</label> : <select name=\"location\" id=\"location\" >\n";
		while($row = pg_fetch_row($query)) {
			$result .= "\t<option value=\"".$row[3]."\">Location ".$row[3]." : ".$row[0]." - ".$row[1]." (".$row[2].") / Agence ".$row[5]." depuis ".$row[6]."</option>\n";
		}
		$result .= "</select><br />\n";

		return $result;
	}

	function getAgenceChoice($dbconn) {
		$result = "";

		$query = pg_query($dbconn, 'SELECT * FROM "Agence"');


		$result .= "<label for=\"agence\" >Agence de restitution</label> : <select name=\"agence\" id=\"agence\" >\n";
		while($row = pg_fetch_row($query)) {
			$result .= "\t<option value=\"".$row[0]."\">Agence ".$row[0]." : ".$row[1]." - ".$row[2]."</option>\n";
		}
		$result .= "</select><br />\n";

		return $result;
	}

	function getKilometrageChoice($dbconn) {
		$result = "";

		$result .= "<label for=\"kilometrage\">Kilometrage</label> : <input type=\"text\" name=\"kilometrage\" id=\"kilometrage\" ><br />\n";

		return $result;
	}

	function getEtatFinalChoice($dbconn) {
		$result = "";

		$result .= "<label for=\"etat\">Etat final</label> : <select name=\"etat\" id=\"etat\" >\n";
		$result .= "<option value=\"true\">Etat ok</option>\n<option value=\"false\">Véhicule cassé</option>\n";
		$result .= "</select><br />\n";

		return $result;
	}

?>
