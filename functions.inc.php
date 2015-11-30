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
					$result .= "\t</optgroup>\n";
				}
				$result .= "\t<optgroup label=\"".$marqueVehicule."\" >\n";
			}
			$result .= "\t\t<option value=\"".$marqueVehicule."/".$modeleVehicule."\">".$row[1]." ".$row[0]."</option>\n";
			$marquePrec = $marqueVehicule;
		}
		$result .= "\t</optgroup>\n";
		$result .= "</select><br />\n";

		return $result;
	}

	function getDateChoice($dbconn) {
		$result = "";

		$result .= "<label>Date de location</label> :\n";
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

?>
