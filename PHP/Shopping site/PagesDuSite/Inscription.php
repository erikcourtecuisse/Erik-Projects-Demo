<!--Erik Courtecuisse -->
<?php
	include("../Complements/fonctions.php");

	session_start();

	$link = ConnexMysql();
	mysqli_query ($link,'SET NAMES UTF8');

	$_SESSION['Inscrit'] = False;
	/////////////////////////////////////////////////////////////////////////////////////
	if(!isset($_COOKIE['Nom']))
	{
	    if(!empty($_POST['Nom']))
	    {
	        setcookie('Nom', $_POST['Nom'], time() + JoursExpirationCookie*24*3600);
	    }
	}
	//---------------------------------------------------------------------------
	if(!isset($_COOKIE['Prenom']))
	{
	    if(!empty($_POST['Prenom']))
	    {
	        setcookie('Prenom', $_POST['Prenom'], time() + JoursExpirationCookie*24*3600);
	    }
	}
	//---------------------------------------------------------------------------
	if(!isset($_COOKIE['Pseudonyme']))
	{
	    if(!empty($_POST['Pseudonyme']))
	    {
	        setcookie('Pseudonyme', $_POST['Pseudonyme'], time() + JoursExpirationCookie*24*3600);
	    }
	}
	//---------------------------------------------------------------------------
	if(!isset($_COOKIE['Departement']))
	{
	    if(!empty($_POST['Departement']))
	    {
	        setcookie('Departement', $_POST['Departement'], time() + JoursExpirationCookie*24*3600);
	    }
	}
	//---------------------------------------------------------------------------
	if(!isset($_COOKIE['Adresse']))
	{
	    if(!empty($_POST['Adresse']))
	    {
	        setcookie('Adresse', $_POST['Adresse'], time() + JoursExpirationCookie*24*3600);
	    }
	}
	//---------------------------------------------------------------------------
	if(!isset($_COOKIE['CodePostal']))
	{
	    if(!empty($_POST['CodePostal']))
	    {
	        setcookie('CodePostal', $_POST['CodePostal'], time() + JoursExpirationCookie*24*3600);
	    }
	}
	//---------------------------------------------------------------------------
	if(!isset($_COOKIE['Ville']))
	{
	    if(!empty($_POST['Ville']))
	    {
	        setcookie('Ville', $_POST['Ville'], time() + JoursExpirationCookie*24*3600);
	    }
	}
	//---------------------------------------------------------------------------
	if(!isset($_COOKIE['Telephone']))
	{
	    if(!empty($_POST['Telephone']))
	    {
	        setcookie('Telephone', $_POST['Telephone'], time() + JoursExpirationCookie*24*3600);
	    }
	}
	//---------------------------------------------------------------------------
	if(!isset($_COOKIE['DateNaissance']))
	{
	    if(!empty($_POST['DateNaissance']))
	    {
	        setcookie('DateNaissance', $_POST['DateNaissance'], time() + JoursExpirationCookie*24*3600);
	    }
	}
	//---------------------------------------------------------------------------
	if(!isset($_COOKIE['Email']))
	{
	    if(!empty($_POST['Email']))
	    {
	        setcookie('Email', $_POST['Email'], time() + JoursExpirationCookie*24*3600);
	    }
	}
	/////////////////////////////////////////////////////////////////////////////////////
	if (!empty($_POST['Civilite']) AND !empty($_POST['Pseudonyme']) AND !empty($_POST['Region']) AND !empty($_POST['Departement']) AND !empty($_POST['Adresse']) AND !empty($_POST['CodePostal']) AND !empty($_POST['Ville']) AND !empty($_POST['Email'])AND !empty($_POST['MotDePasse']) AND !empty($_POST['ConfirmeMotDePasse']) AND $_POST['ConfirmeMotDePasse']==$_POST['MotDePasse'])
	{
		$Result = mysqli_query($link,"SELECT * FROM Membres WHERE Email = '".$_POST['Email']."'");
	    if(mysqli_num_rows($Result) == 1)
	    {
	    	$EmailDejaExistant = "Cette adresse Email est déjà attribuée a un autre compte.";
	    }
	    $Result = mysqli_query($link,"SELECT * FROM Membres WHERE Pseudonyme = '".$_POST['Pseudonyme']."'");
	    if (mysqli_num_rows($Result) == 1)
	    {
	    	$PseudoDejaExistant = "Ce pseudo est déjà attribuée a un autre compte.";
	    }
	    else
	    {
			$Civilite = $_POST['Civilite'];
			$Nom = $_POST['Nom'];
			$Prenom = $_POST['Prenom'];
			$Pseudonyme = $_POST['Pseudonyme'];
			$Region = $_POST['Region'];
			$Departement = $_POST['Departement'];
			$Adresse = $_POST['Adresse'];
			$CodePostal = $_POST['CodePostal'];
			$Ville = $_POST['Ville'];
			$Telephone = $_POST['Telephone'];
			$DateNaissance = $_POST['DateNaissance'];
			$Email = $_POST['Email'];
			$MotDePasse = md5($_POST['MotDePasse']);

			$Result = mysqli_query($link,"INSERT INTO Membres(Civilite,Nom,Prenom,Pseudonyme,Region,Departement,Adresse,CodePostal,Ville,Telephone,DateNaissance,Email,MotDePasse) VALUES ('$Civilite','$Nom','$Prenom','$Pseudonyme','$Region','$Departement','$Adresse','$CodePostal','$Ville','$Telephone','$DateNaissance','$Email','$MotDePasse')");

			if (!$Result) 
			{
			    echo "Erreur DB, impossible d'effectuer une requête\n";
			    echo 'Erreur MySQL : ' . mysqli_error();
				exit;
			}

			$_SESSION['Inscrit'] = TRUE;

			$file = 'InfosComptes/InfosCompte='.$Pseudonyme.'.php';
			$current = '
<?php
	include("../../Complements/fonctions.php");

	session_start();

	$link = ConnexMysql();
	CloseCompte();
	mysqli_query ($link,\'SET NAMES UTF8\');

	$MysqlCivilite = ChercheBDD($link,\'Civilite\',\'Membres\',\'Pseudonyme\',\''.$Pseudonyme.'\');
	$MysqlNom = ChercheBDD($link,\'Nom\',\'Membres\',\'Pseudonyme\',\''.$Pseudonyme.'\');
	$MysqlPrenom = ChercheBDD($link,\'Prenom\',\'Membres\',\'Pseudonyme\',\''.$Pseudonyme.'\');
	$MysqlPseudo = ChercheBDD($link,\'Pseudonyme\',\'Membres\',\'Pseudonyme\',\''.$Pseudonyme.'\');
	$MysqlRegion = ChercheBDD($link,\'Region\',\'Membres\',\'Pseudonyme\',\''.$Pseudonyme.'\');
	$MysqlDepartement = ChercheBDD($link,\'Departement\',\'Membres\',\'Pseudonyme\',\''.$Pseudonyme.'\');
	$MysqlAdresse = ChercheBDD($link,\'Adresse\',\'Membres\',\'Pseudonyme\',\''.$Pseudonyme.'\');
	$MysqlCodePostal = ChercheBDD($link,\'CodePostal\',\'Membres\',\'Pseudonyme\',\''.$Pseudonyme.'\');
	$MysqlVille = ChercheBDD($link,\'Ville\',\'Membres\',\'Pseudonyme\',\''.$Pseudonyme.'\');
	$MysqlTelephone = ChercheBDD($link,\'Telephone\',\'Membres\',\'Pseudonyme\',\''.$Pseudonyme.'\');
	$MysqlDateNaissance = ChercheBDD($link,\'DateNaissance\',\'Membres\',\'Pseudonyme\',\''.$Pseudonyme.'\');
	$MysqlEmail = ChercheBDD($link,\'Email\',\'Membres\',\'Pseudonyme\',\''.$Pseudonyme.'\');

	$LinkPseudocompte = mysqli_query($link,"SELECT ID_Membre FROM Membres WHERE Pseudonyme = \'$MysqlPseudo\'");
	if ($row = mysqli_fetch_array( $LinkPseudocompte ))
	{
	   $PseudoCompte = $row[\'ID_Membre\'];
	}

?>
		<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" charset="utf-8" content="width=device-width, initial-scale=1" />
        <title>MyAuctionSite Compte</title>
        <link rel="stylesheet" href="../../Css/Style.css" />
        <link rel="stylesheet" href="../../Css/MenuH.css" />
    </head>
    <body>
    	<form method="post" action="">
    		<center><h1><Strong>MyAuctionSite</Strong></h1></center>
    		<ul id="Menuh">
    		<li><a href="../PageAccueil.php">Accueil</a>
			</li>
			<li><a href="../Acheter.php">Acheter</a>
				<ul>
						<li><a href="../Recherche.php">Recherche</a></li>
				</ul>
			</li>
			<li><a href="../Vendre.php">Vendre</a>
			</li>
			<li><a href="../MonCompteInfos.php">Mon Compte</a>
				<ul>
					<li><a href="../MesTransactions.php">Mes Transactions</a></li>
				</ul>
			</li>
			<li><a href="../Deconnexion.php">Deconnexion</a>
			</li>
			</ul>
			<div id="Panier"><a href="../Panier.php"><img src="../../Images/panier.png"></a></div>
			<center><div id="Page">
				<?php
					if(isset($_SESSION[\'ANote\']) AND $_SESSION[\'ANote\'] == True)
					{
						echo \'<font color="green">Merci pour votre retour.</font><br><br>\';
					}
					$LinkPseudocompte = mysqli_query($link,"SELECT ID_Membre FROM Membres WHERE Pseudonyme = \'$MysqlPseudo\'");
					if ($row = mysqli_fetch_array( $LinkPseudocompte ))
					{
					   $IDPseudoCompte = $row[\'ID_Membre\'];
					}
					$NombreNotation = 0;
					$NotationMoyenne = 0;
					$Req = mysqli_query($link,"SELECT * FROM Notations");
					$NbNotations = mysqli_num_rows($Req);
					for ($i=1; $i <=$NbNotations; ++$i)
					{
						$LinkCompareCurrentMembre = mysqli_query($link,"SELECT ID_Membre FROM Notations WHERE ID_Notation = \'$i\'");
						if ($row = mysqli_fetch_array( $LinkCompareCurrentMembre ))
						{
						   $CompareMembre = $row[\'ID_Membre\'];
						}
						if($CompareMembre == $IDPseudoCompte)
						{
							$LinkNotationCurrentMembre = mysqli_query($link,"SELECT Notation FROM Notations WHERE ID_Notation = \'$i\'");
							if ($row = mysqli_fetch_array( $LinkNotationCurrentMembre ))
							{
							   $NotationMembre = $row[\'Notation\'];
							}
							$NotationMoyenne = $NotationMoyenne + $NotationMembre;
							$NombreNotation++;
						}
					}
					if($NombreNotation != 0)
					{
						$NotationMoyenne = $NotationMoyenne/$NombreNotation;
						$ReqUpdate = mysqli_query($link,"UPDATE Membres SET NotationG = ".$NotationMoyenne." WHERE ID_Membre = \'".$IDPseudoCompte."\'");
					}
				?>
				<Strong><h3>Informations sur <?php echo $MysqlPseudo; ?> : <br></h3><br></strong>
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
 				<br><br>
 				
 				Notation : <?php 
 							if($NotationMoyenne>0)
 							{
	 							if($NotationMoyenne<2.5)
	 							{echo "<font color=\'red\'>".$NotationMoyenne."</font>";}
	 							else
	 							{echo "<font color=\'green\'>".$NotationMoyenne."</font>";} 
	 						}
	 						else
	 						{
	 							echo \'-\';
	 						}?>/5

 				<br><br>

 				<Strong><h3>Les transactions terminées de <?php echo $MysqlPseudo; ?> : <br></h3></strong>
 				<?php
						$Req = mysqli_query($link,"SELECT * FROM Transactions");
						$NbTransactions = mysqli_num_rows($Req);
						for ($i=1; $i <=$NbTransactions; ++$i)
						{
							$LinkAcheteur = mysqli_query($link,"SELECT ID_Acheteur FROM Transactions WHERE ID_Transaction = ".$i."");
							if ($row = mysqli_fetch_array( $LinkAcheteur ))
							{
							   $IDTransactionAcheteur = $row[\'ID_Acheteur\'];
							}
							$LinkVendeur = mysqli_query($link,"SELECT ID_Vendeur FROM Transactions WHERE ID_Transaction = ".$i."");
							if ($row = mysqli_fetch_array( $LinkVendeur ))
							{
							   $IDTransactionVendeur = $row[\'ID_Vendeur\'];
							}

							if($PseudoCompte == $IDTransactionAcheteur )
							{
								$LinkArticle = mysqli_query($link,"SELECT Nom FROM Articles WHERE ID_Article = ".$i."");
								if ($row = mysqli_fetch_array( $LinkArticle ))
								{
								   $NomArticle = $row[\'Nom\'];
								}
								$LinkVendeur2 = mysqli_query($link,"SELECT Pseudonyme FROM Membres WHERE ID_Membre = ".$IDTransactionVendeur."");
								if ($row = mysqli_fetch_array( $LinkVendeur2 ))
								{
								   $NomVendeur = $row[\'Pseudonyme\'];
								}
								echo \'\'.$MysqlPseudo.\' a acheté : <strong>\'.$NomArticle.\'</strong> a <strong><u><a href=InfosCompte=\'.$NomVendeur.\'.php>\'.$NomVendeur.\'</a></u></strong><br>\';
								echo \'<br>\';
							}
							if($PseudoCompte == $IDTransactionVendeur)
							{
								$LinkArticle2 = mysqli_query($link,"SELECT Nom FROM Articles WHERE ID_Article = ".$i."");
								if ($row = mysqli_fetch_array( $LinkArticle2 ))
								{
								   $NomArticle2 = $row[\'Nom\'];
								}
								$LinkAcheteur2 = mysqli_query($link,"SELECT Pseudonyme FROM Membres WHERE ID_Membre = ".$IDTransactionAcheteur."");
								if ($row = mysqli_fetch_array( $LinkAcheteur2 ))
								{
								   $NomAcheteur = $row[\'Pseudonyme\'];
								}
								echo \'\'.$MysqlPseudo.\' a vendu : <strong>\'.$NomArticle2.\'</strong> a <strong><u><a href=InfosCompte=\'.$NomAcheteur.\'.php>\'.$NomAcheteur.\'</a></u></strong><br><br>\';
							}
						}
					
					echo \'<Strong><h3>Ses ventes en cours :</Strong></h3>\';
					$LinkVente = mysqli_query($link,"SELECT Payement,Nom,Prix FROM Articles WHERE ID_Membre = ".$PseudoCompte."");
					while ($row = mysqli_fetch_array($LinkVente))
					{
						$PossibleVente = $row[\'Payement\'];
					   	$NomArticle = $row[\'Nom\'];
					  	$PrixArticle = $row[\'Prix\'];
					   	if(isset($PossibleVente) AND $PossibleVente == 0)
						{
					  		echo \'- \'.$MysqlPseudo.\' vend : \'.$NomArticle.\' pour \'.$PrixArticle.\' euros.<br><br>\';
						}
					}
 				?>
			</div>
			</center>
	    </form>
	</body>
</html>';
			file_put_contents($file, $current);

			header('Location: ../Connexion.php');
		}
	}
?>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" charset="utf-8" content="width=device-width, initial-scale=1" />
        <title>MyAuctionSite Inscription</title>
        <link rel="stylesheet" href="../Css/Style.css" />
    </head>
    <body>
		<center><h1><Strong>MyAuctionSite</Strong></h1></center>
		<br><br><br>
		<center><div id="Page">
			<?php
		            if(isset($EmailDejaExistant))
		            {
						echo "<font color='red'>$EmailDejaExistant</font>";
		            }
		            if(isset($PseudoDejaExistant))
		            {
						echo "<font color='red'>$PseudoDejaExistant</font>";
		            }
        	?>
			<br>
			<p> 
			    Veuillez entrez les coordonnées correspondantes pour l'inscription<font color='red'>(les '*' doivent être renseignés)</font> 
	        </p>
			        <form method="post" action="">
				    <label for="Civilite">Civilité : <font color='red'>*</font></label><br>
			        <SELECT name="Civilite" size="1">
					<OPTION>Mr
					<OPTION>Mme
					<OPTION>Melle
					</SELECT><br><br>
			        <label for="Nom">Nom : </label><br>
			        <input type="Nom" name="Nom" value='<?php if(isset($_COOKIE['Nom'])) { echo $_COOKIE['Nom'];} ?>'><br><br>
			        <label for="Prenom">Prenom : </label><br>
			        <input type="Prenom" name="Prenom" value='<?php if(isset($_COOKIE['Prenom'])) { echo $_COOKIE['Prenom'];} ?>'><br><br>
			        <?php
			            if(isset($_POST['Pseudonyme']))
			            {
			            	if (empty($_POST['Pseudonyme']))
							{
								echo "<font color='red'>Il manque le Pseudonyme<br></font>";
							}
			            }
	        		?>
			        <label for="Pseudonyme">Pseudonyme : <font color='red'>*</font></label><br>
			        <input type="Pseudonyme" name="Pseudonyme" value='<?php if(isset($_COOKIE['Pseudonyme'])) { echo $_COOKIE['Pseudonyme'];} ?>'><br><br>
	        		<?php
			            if(isset($_POST['Region']))
			            {
			            	if (empty($_POST['Region']))
							{
								echo "<font color='red'>Il manque la region<br></font>";
							}
			            }
	        		?>
			        <label for="Region">Region : <font color='red'>*</font></label><br>
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
	        		<?php
			            if(isset($_POST['Departement']))
			            {
			            	if (empty($_POST['Departement']))
							{
								echo "<font color='red'>Il manque le departement<br></font>";
							}
			            }
	        		?>
			        <label for="Departement">Departement : <font color='red'>*</font></label><br>
			        <input type="Departement" name="Departement" value='<?php if(isset($_COOKIE['Departement'])) { echo $_COOKIE['Departement'];} ?>'><br><br>
	        		<?php
			            if(isset($_POST['Adresse']))
			            {
			            	if (empty($_POST['Adresse']))
							{
								echo "<font color='red'>Il manque l'adresse'<br></font>";
							}
			            }
	        		?>
			        <label for="Adresse">Adresse : <font color='red'>*</font></label><br>
			        <input type="Adresse" name="Adresse" value='<?php if(isset($_COOKIE['Adresse'])) { echo $_COOKIE['Adresse'];} ?>'><br><br>
			    	<?php
			            if(isset($_POST['CodePostal']))
			            {
			            	if (empty($_POST['CodePostal']))
							{
								echo "<font color='red'>Il manque le code postal<br></font>";
							}
			            }
	        		?>
			        <label for="CodePostal">Code Postal : <font color='red'>*</font></label><br>
			        <input type="CodePostal" name="CodePostal" value='<?php if(isset($_COOKIE['CodePostal'])) { echo $_COOKIE['CodePostal'];} ?>'><br><br>
	        		<?php
			            if(isset($_POST['Ville']))
			            {
			            	if (empty($_POST['Ville']))
							{
								echo "<font color='red'>Il manque la ville<br></font>";
							}
			            }
	        		?>
			        <label for="Ville">Ville : <font color='red'>*</font></label><br>
			        <input type="Ville" name="Ville" value='<?php if(isset($_COOKIE['Ville'])) { echo $_COOKIE['Ville'];} ?>'><br><br>
			        <label for="Telephone">Telephone : </label><br>
			        <input type="Telephone" name="Telephone" value='<?php if(isset($_COOKIE['Telephone'])) { echo $_COOKIE['Telephone'];} ?>'><br><br>
			        <label for="DateNaissance">Date Naissance (AAAA-MM-JJ) : </label><br>
			        <input type="DateNaissance" name="DateNaissance" value='<?php if(isset($_COOKIE['DateNaissance'])) { echo $_COOKIE['DateNaissance'];} ?>'><br><br>
			        <?php
			            if(isset($_POST['Email']))
			            {
			            	if (empty($_POST['Email']))
							{
								echo "<font color='red'>Il manque l'Email<br></font>";
							}
			            }
	        		?>
			        <label for="Email">Email : <font color='red'>*</font></label><br>
			        <input type="Email" name="Email" value='<?php if(isset($_COOKIE['Email'])) { echo $_COOKIE['Email'];} ?>'><br><br>
	        		<?php
			            if(isset($_POST['MotDePasse']))
			            {
			            	if (empty($_POST['MotDePasse']))
							{
								echo "<font color='red'>Il manque le mot de passe<br></font>";
							}
			            }
	        		?>
			        <label for="MotDePasse">Mot De Passe : <font color='red'>*</font></label><br>
			        <input type="password" name="MotDePasse"><br><br>
	        		<?php
			            if(isset($_POST['ConfirmeMotDePasse']))
			            {
			            	if ($_POST['ConfirmeMotDePasse'] != $_POST['MotDePasse'])
							{
								echo "<font color='red'>Le mot de passe n'est pas identique<br></font>";
							}
			            }
	        		?>
			        <label for="ConfirmeMotDePasse">Confirmez le mot de passe : <font color='red'>*</font></label><br>
			        <input type="password" name="ConfirmeMotDePasse"><br><br>
					<input type="submit" value="Soumettre" name="formconnexion"/>
			</form>
        </div></center>
 	</body>
</html>