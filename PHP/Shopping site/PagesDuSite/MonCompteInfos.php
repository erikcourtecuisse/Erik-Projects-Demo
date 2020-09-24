<!--Erik Courtecuisse-->
<?php
	include("../Complements/fonctions.php");

	session_start();

	$link = ConnexMysql();
	CloseCompte();
	SetSessionFalse();
	mysqli_query ($link,'SET NAMES UTF8');

	$MysqlCivilite = ChercheBDDSession($link,'Civilite','Membres','Pseudonyme');
	$MysqlNom = ChercheBDDSession($link,'Nom','Membres','Pseudonyme');
	$MysqlPrenom = ChercheBDDSession($link,'Prenom','Membres','Pseudonyme');
	$MysqlPseudo = ChercheBDDSession($link,'Pseudonyme','Membres','Pseudonyme');
	$MysqlRegion = ChercheBDDSession($link,'Region','Membres','Pseudonyme');
	$MysqlDepartement = ChercheBDDSession($link,'Departement','Membres','Pseudonyme');
	$MysqlAdresse = ChercheBDDSession($link,'Adresse','Membres','Pseudonyme');
	$MysqlCodePostal = ChercheBDDSession($link,'CodePostal','Membres','Pseudonyme');
	$MysqlVille = ChercheBDDSession($link,'Ville','Membres','Pseudonyme');
	$MysqlTelephone = ChercheBDDSession($link,'Telephone','Membres','Pseudonyme');
	$MysqlDateNaissance = ChercheBDDSession($link,'DateNaissance','Membres','Pseudonyme');
	$MysqlEmail = ChercheBDDSession($link,'Email','Membres','Pseudonyme');
	$MysqlMDP = ChercheBDDSession($link,'MotDePasse','Membres','Pseudonyme');
?>
		<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" charset="utf-8" content="width=device-width, initial-scale=1" />
        <title>MyAuctionSite Compte</title>
        <link rel="stylesheet" href="../Css/Style.css" />
        <link rel="stylesheet" href="../Css/MenuH.css" />
    </head>
    <body>
    	<form method="post" action="">
    		<center><h1><Strong>MyAuctionSite</Strong></h1></center>
		    <ul id="Menuh">
			<li><a href="PageAccueil.php">Accueil</a>
			</li>
			<li><a href="Acheter.php">Acheter</a>
				<ul>
						<li><a href="Recherche.php">Recherche</a></li>
				</ul>
			</li>
			<li><a href="Vendre.php">Vendre</a>
			</li>
			<li><a href="MonCompteInfos.php">Mon Compte</a>
				<ul>
					<li><a href="MesTransactions.php">Mes Transactions</a></li>
				</ul>
			</li>
			<li><a href="Deconnexion.php">Deconnexion</a>
			</li>
			</ul>
			<div id="Panier"><a href="Panier.php"><img src="../Images/panier.png"></a></div>
			<center><div id="Page">
				Civilité : <?php echo $MysqlCivilite; ?><br>
				Nom : <?php echo $MysqlNom; ?><br> 
				Prenom : <?php echo $MysqlPrenom; ?><br> 
				Pseudonyme : <?php echo $MysqlPseudo; ?><br> 
				Region : <?php echo $MysqlRegion; ?><br> 
				Departement : <?php echo $MysqlDepartement; ?><br>
				Adresse : <?php echo $MysqlAdresse; ?><br> 
				CodePostal : <?php echo $MysqlCodePostal; ?><br> 
				Ville : <?php echo $MysqlVille; ?><br> 
				Téléphone : <?php echo $MysqlTelephone; ?><br> 
				Date de Naissance : <?php echo $MysqlDateNaissance; ?><br> 
 				Email : <?php echo $MysqlEmail; ?><br><br>
 				<input type="button" name="lien1" value="Modifier une information" onclick="self.location.href='ModifierCompteInfos.php'" onclick> 
			</div>
			</center>
	    </form>
	</body>
</html>