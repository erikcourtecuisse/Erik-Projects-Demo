<!--Erik Courtecuisse-->
<?php
	include("../Complements/fonctions.php");

	session_start();

	$link = ConnexMysql();
	CloseCompte();
	SetSessionFalse();
	mysqli_query ($link,'SET NAMES UTF8');

	if (!empty($_POST['Notation']) AND !empty($_POST['Commentaire']))
	{
		$Notation = $_POST['Notation'];
		$Commentaire = $_POST['Commentaire'];

		$Result = mysqli_query($link,"INSERT INTO Notations(Notation,Commentaire) VALUES ('$Notation','$Commentaire')");
	}

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
    		<center><h1><Strong>MyAuctionSite</Strong></h1></center><br><br>
			<center><div id="Page">
				Merci de noter la préstation du vendeur sur 5 et de laisser un commentaire :<br><br>

				<label for="Notation">Note : </label><br>
			    <SELECT name="Notation" size="1">
				<OPTION>1
				<OPTION>2
				<OPTION>3
				<OPTION>4
				<OPTION>5
				</SELECT><br><br>

				<label for="Commentaire">Commentaire : </label><br>
				<TEXTAREA cols="60" rows="5" name="Commentaire"></TEXTAREA><br><br>

				<input type="submit" value="Soumettre" name="Soumettre"/><br><br>
			</div>
			</center>
	    </form>
	</body>
</html>