<!--Erik Courtecuisse-->
<?php
	include("../Complements/fonctions.php");

	session_start();

	$link = ConnexMysql();
	CloseCompte();
	SetSessionFalse();
	mysqli_query ($link,'SET NAMES UTF8');

	$Pseudo = $_SESSION['Pseudonyme'];

?>
	<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" charset="utf-8" content="width=device-width, initial-scale=1" />
        <title>MyAuctionSite Accueil</title>
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
				Bienvenu sur MyAuctionSite, un projet de licence 2 Informatique.<br>
				Ce projet a pour but la conception d'un site comercial,<br>
				Il a été réalisé par Erik Courtecuisse et Ugo Divalentin.<br>
				Bonne visite !!
			</div></center>
	    </form>
	</body>
</html>