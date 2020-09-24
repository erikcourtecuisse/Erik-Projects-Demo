<!--Erik Courtecuisse-->
<?php
	include("../Complements/fonctions.php");

	session_start();

	$link = ConnexMysql();
	CloseCompte();
	SetSessionFalse();
	mysqli_query ($link,'SET NAMES UTF8');

	$MysqlNom = ChercheBDDSession($link,'Nom','Membres','Pseudonyme');
	$MysqlEmail = ChercheBDDSession($link,'Email','Membres','Pseudonyme');
	$MysqlMDP = ChercheBDDSession($link,'MotDePasse','Membres','Pseudonyme');

	if(isset($_POST['Soumettre']))
	{
		if(!empty($_POST['MDPActuel']) AND md5($_POST['MDPActuel']) == $MysqlMDP)
		{
			if(!empty($_POST['Civilite']))
			{
				$ReqUpdate = mysqli_query($link,"UPDATE Membres SET Civilite='".$_POST['Civilite']."' WHERE Pseudonyme = '".$_SESSION['Pseudonyme']."'");
	    	}
	    	if(!empty($_POST['Nom']))
			{
				$ReqUpdate = mysqli_query($link,"UPDATE Membres SET Nom='".$_POST['Nom']."' WHERE Pseudonyme = '".$_SESSION['Pseudonyme']."'");
	    	}
	    	if(!empty($_POST['Prenom']))
			{
				$ReqUpdate = mysqli_query($link,"UPDATE Membres SET Prenom='".$_POST['Prenom']."' WHERE Pseudonyme = '".$_SESSION['Pseudonyme']."'");
	    	}
	    	if(!empty($_POST['Region']))
			{
				$ReqUpdate = mysqli_query($link,"UPDATE Membres SET Region='".$_POST['Region']."' WHERE Pseudonyme = '".$_SESSION['Pseudonyme']."'");
	    	}
	    	if(!empty($_POST['Departement']))
			{
				$ReqUpdate = mysqli_query($link,"UPDATE Membres SET Departement='".$_POST['Departement']."' WHERE Pseudonyme = '".$_SESSION['Pseudonyme']."'");
	    	}
	    	if(!empty($_POST['Adresse']))
			{
				$ReqUpdate = mysqli_query($link,"UPDATE Membres SET Adresse='".$_POST['Adresse']."' WHERE Pseudonyme = '".$_SESSION['Pseudonyme']."'");
	    	}
	    	if(!empty($_POST['CodePostal']))
			{
				$ReqUpdate = mysqli_query($link,"UPDATE Membres SET CodePostal='".$_POST['CodePostal']."' WHERE Pseudonyme = '".$_SESSION['Pseudonyme']."'");
	    	}
	    	if(!empty($_POST['Ville']))
			{
				$ReqUpdate = mysqli_query($link,"UPDATE Membres SET Ville='".$_POST['Ville']."' WHERE Pseudonyme = '".$_SESSION['Pseudonyme']."'");
	    	}
	    	if(!empty($_POST['Telephone']))
			{
				$ReqUpdate = mysqli_query($link,"UPDATE Membres SET Telephone='".$_POST['Telephone']."' WHERE Pseudonyme = '".$_SESSION['Pseudonyme']."'");
	    	}
	    	if(!empty($_POST['DateNaissance']))
			{
				$ReqUpdate = mysqli_query($link,"UPDATE Membres SET DateNaissance='".$_POST['DateNaissance']."' WHERE Pseudonyme = '".$_SESSION['Pseudonyme']."'");
	    	}
	    	if(!empty($_POST['Email']))
			{
				$ReqUpdate = mysqli_query($link,"UPDATE Membres SET Email='".$_POST['Email']."' WHERE Pseudonyme = '".$_SESSION['Pseudonyme']."'");
	    	}
			if(!empty($_POST['MotDePasse']))
			{
				if(!empty($_POST['ConfirmeMotDePasse']) AND $_POST['ConfirmeMotDePasse']==$_POST['MotDePasse'])
				{
		            $ObjetMail = "MyAuctionSite Changement de mot de passe";
		            $CorpsMail = "Bonjour, votre demande de changement de mot de passe a bien étée prise en compte. Votre nouveau mot de passe est utilisable dés maintenant.";
		            EnvoyerMail($MysqlEmail,$MysqlNom,$ObjetMail,$CorpsMail);
					$ReqUpdate = mysqli_query($link,"UPDATE Membres SET MotDePasse='".md5($_POST['MotDePasse'])."' WHERE Pseudonyme = '".$_SESSION['Pseudonyme']."'");
					$_SESSION['CompteMDPModif'] = TRUE;
				}
				else
				{
					$MDPEchec = "Le mot de passe a changer n'est pas identique.";
				}
	    	}
	    	if(!isset($MDPEchec))
	    	{
		    	$_SESSION['CompteModif'] = TRUE;
		    	header('Location: MonCompte.php');
				exit();
			}
    	}
    	else 
    	{
    		$IndiquezMDPActuel = "Merci d'indiquez votre mot de passe actuel correctement.";
    	}
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
				<?php if(isset($IndiquezMDPActuel)){echo "<font color='red'>$IndiquezMDPActuel</font> <br><br>";} ?>
				<?php if(isset($MDPEchec)){echo "<font color='red'>$MDPEchec</font> <br><br>";} ?>
				<?php if(isset($MDPChange)){echo "$MDPChange<br><br>";} ?>
				<?php
					if(isset($_SESSION['CompteModif']))
					{
						if($_SESSION['CompteModif'] == TRUE)
						{
							echo "<font color='green'>Les changements ont étés éfféctués<br><br></font>";
						}
					}
					if(isset($_SESSION['CompteMDPModif']))
					{
						if($_SESSION['CompteMDPModif'] == TRUE)
						{
							echo "<font color='green'>Vous avez changé votre mot de passe un mail vous a été envoyé.<br><br></font>";
						}
					}
				?>
				Vous souhaitez modifier une information ? <br><br>
					<label for="Civilite">Civilité : </label><br>
			        <SELECT name="Civilite" size="1">
					<OPTION>Mr
					<OPTION>Mme
					<OPTION>Melle
					</SELECT><br><br>
			        <label for="Nom">Nom : </label><br>
			        <input type="Nom" name="Nom"><br><br>
			        <label for="Prenom">Prenom : </label><br>
			        <input type="Prenom" name="Prenom"><br><br>
			        <label for="Region">Region : </label><br>
			        <SELECT name="Region" size="1">
					<OPTION>Auvergne-Rhone-Alpes
					<OPTION>Bourgogne-Franche-Comté
					<OPTION>Bretagne
					<OPTION>Centre-Val de Loire
					<OPTION>Corse
					<OPTION>Grand Est
					<OPTION>Hauts-de-France
					<OPTION>Ile-de-France
					<OPTION>Normandie
					<OPTION>Nouvelle-Aquitaine
					<OPTION>Occitanie
					<OPTION>Pays de la Loire
					<OPTION>Provence-Alpes-Côte d'Azur
					</SELECT><br><br>
			        <label for="Departement">Departement : </label><br>
			        <input type="Departement" name="Departement"><br><br>
			        <label for="Adresse">Adresse : </label><br>
			        <input type="Adresse" name="Adresse" ><br><br>
			        <label for="CodePostal">Code Postal : </label><br>
			        <input type="CodePostal" name="CodePostal"><br><br>
			        <label for="Ville">Ville : </label><br>
			        <input type="Ville" name="Ville"><br><br>
			        <label for="Telephone">Telephone : </label><br>
			        <input type="Telephone" name="Telephone"><br><br>
			        <label for="DateNaissance">Date  Naissance (AAAA-MM-JJ) : </label><br>
			        <input type="DateNaissance" name="DateNaissance"><br><br>
			        <label for="Email">Email : </label><br>
			        <input type="Email" name="Email"><br><br>
			        <label for="MotDePasse">Mot De Passe : </label><br>
			        <input type="password" name="MotDePasse"><br><br>
			        <label for="ConfirmeMotDePasse">Confirmez le mot de passe : </label><br>
			        <input type="password" name="ConfirmeMotDePasse"><br><br>
			        <label for="MDPActuel"><font color='red'>Securité: donnez mot de passe actuel : </font></label><br>
			        <input type="password" name="MDPActuel"><br><br>
			        <input type="submit" value="Soumettre" name="Soumettre"/>
			</div>
		</center>
	    </form>
	</body>
</html>