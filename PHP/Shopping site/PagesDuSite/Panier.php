<!--Erik Courtecuisse-->
<?php
	include("../Complements/fonctions.php");

	session_start();

	$link = ConnexMysql();
	CloseCompte();
	SetSessionFalse();
	mysqli_query ($link,'SET NAMES UTF8');

	$EnchereFinie = false;
	$erreur = false;
	$IDAcheteur = ChercheBDDSession($link,'ID_Membre','Membres','Pseudonyme');

	$action = (isset($_POST['action'])? $_POST['action']:  (isset($_GET['action'])? $_GET['action']:null )) ;
	if($action !== null)
	{
	   if(!in_array($action,array('ajout', 'suppression', 'refresh')))
	   $erreur=true;

	   $l = (isset($_POST['l'])? $_POST['l']:  (isset($_GET['l'])? $_GET['l']:null )) ;
	   $p = (isset($_POST['p'])? $_POST['p']:  (isset($_GET['p'])? $_GET['p']:null )) ;

	   $l = preg_replace('#\v#', '',$l);
	   $p = floatval($p);
	}

	if (!$erreur){
	   switch($action){
	      Case "ajout":
	         ajouterArticle($l,$p);
	         break;

	      Case "suppression":
	         supprimerArticle($l);
	         break;

	      Default:
	         break;
	   }
	}

?>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" charset="utf-8" content="width=device-width, initial-scale=1" />
        <title>MyAuctionSite Panier</title>
        <link rel="stylesheet" href="../Css/Style.css" />
        <link rel="stylesheet" href="../Css/MenuH.css" />
    </head>
    <body>
    	<form method="post" action="" enctype="multipart/form-data">
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
					<?php
					echo "<U><strong>Panier d'enchéres</strong></U><br><br>";
						$NombreEncheresEnCours = 0;
						$Pseudo = $_SESSION['Pseudonyme'];
						$Req = mysqli_query($link,"SELECT * FROM Encheres");
						$NbEncheres = mysqli_num_rows($Req);
						for ($i=1; $i <=$NbEncheres; ++$i)
						{
							$LinkNamePoster = mysqli_query($link,'SELECT Pseudonyme FROM Membres,Encheres WHERE Membres.ID_Membre = Encheres.ID_Membre AND ID_Enchere ='.$i.'');
							if ($row = mysqli_fetch_array( $LinkNamePoster ))
							{
								$NomVendeur = $row['Pseudonyme'];
							}

							$LinkIDVainqueur = mysqli_query($link,"SELECT ID_Vainqueur FROM Encheres WHERE ID_Enchere = '$i'");
							if ($row = mysqli_fetch_array( $LinkIDVainqueur ))
							{
							    $SqlIDVainqueur = $row['ID_Vainqueur'];
							}
							$LinkPayement = mysqli_query($link,'SELECT Payement FROM Encheres WHERE ID_Enchere ='.$i.'');
							if ($row = mysqli_fetch_array( $LinkPayement ))
							{
								$Payement = $row['Payement'];
							}
							$IDPseudo = ChercheBDDSession($link,'ID_Membre','Membres','Pseudonyme');
							if($SqlIDVainqueur == $IDPseudo AND $Payement != 1)
							{
								$NombreEncheresEnCours++; 
								$SqlDateFinEnchere = mysqli_query($link,"SELECT DateFin FROM Encheres WHERE ID_Enchere = '$i'");
								if ($row = mysqli_fetch_array( $SqlDateFinEnchere ))
								{
								   $DateFinEnchere = $row['DateFin'];
								}
								$LinkArticleEnchere = mysqli_query($link,"SELECT Nom FROM Articles,Encheres WHERE Articles.ID_Article = Encheres.ID_Article AND Encheres.DateFin = '".$DateFinEnchere."'");
								if ($row = mysqli_fetch_array( $LinkArticleEnchere ))
								{
										$ArticleEnchere = $row['Nom'];
								}
								$LinkPrixArticleEnchere = mysqli_query($link,"SELECT Valeur FROM Encheres WHERE DateFin = '".$DateFinEnchere."'");
								if ($row = mysqli_fetch_array( $LinkPrixArticleEnchere ))
								{
									   $PrixArticleFinEnchere = $row['Valeur'];
								}
								if($DateFinEnchere<date("Y-m-d H:i:s"))
								{
									$EnchereFinie = True;
									echo 'Vous remportez l\'enchére de : <strong>'.$ArticleEnchere.'</strong> au prix de : <strong>'.$PrixArticleFinEnchere.'</strong> euros.<br>
									Merci de proceder au payement de '.$NomVendeur.'<br><br>';

								}
								else
								{
									$EnchereFinie = false;
									echo 'Vous avez une enchére : <strong>'.$ArticleEnchere.'</strong> au prix de <strong>'.$PrixArticleFinEnchere.'</strong> euros qui se termine pour : <strong>'.$DateFinEnchere.'</strong> <br><br>';
								}
								if (isset($_POST['PayerEnchere']) )
								{
									$LinkIDArticle = mysqli_query($link,'SELECT ID_Article FROM Encheres WHERE ID_Enchere ='.$i.'');
									if ($row = mysqli_fetch_array( $LinkIDArticle ))
									{
										$IDArticle = $row['ID_Article'];
									}
									$LinkIDVendeur = mysqli_query($link,'SELECT ID_Membre FROM Encheres WHERE ID_Enchere = '.$i.'');
									if ($row = mysqli_fetch_array( $LinkIDVendeur ))
									{
									    $IDVendeur = $row['ID_Membre'];
									}
									$Result = mysqli_query($link,"INSERT INTO Transactions(ID_Acheteur,ID_Vendeur,ID_Article) VALUES ('$SqlIDVainqueur','$IDVendeur','$IDArticle')");

									$ReqUpdate = mysqli_query($link,"UPDATE Encheres SET Payement='1' WHERE ID_Enchere = '$i'");
									$LinkIDArticleForEnchere = mysqli_query($link,'SELECT ID_Article FROM Encheres WHERE ID_Enchere = '.$i.'');
									if ($row = mysqli_fetch_array( $LinkIDArticleForEnchere ))
									{
									    $IDArticleforEnchere = $row['ID_Article'];
									}
									$ReqUpdate = mysqli_query($link,"UPDATE Articles SET Payement= 1 WHERE ID_Article ='$IDArticleforEnchere'");
								}
								if (isset($_POST['PayerEnchere']) )
									{
										if($i == $NbEncheres)
										{
											header("Location: https://www.paypal.com/fr/webapps/mpp/send-money-online");
										}
									}
							}
						}

						if($NombreEncheresEnCours == 0)
						{
							echo 'Votre panier d\'enchéres est vide ou vous ne possédez plus l\'enchére.<br>';
						}
						
						if($EnchereFinie == true AND $NombreEncheresEnCours != 0)
						{
							echo '<input type="submit" value="Payer" name="PayerEnchere"><br><br>';
						}
					?>
					</div>
					<br><br>
					<div id="Page">
					<?php
					echo "<U><strong>Panier d'achats immédiats</strong></U><br><br>";
						if (creationPanier())
						{
							$nbArticles=count($_SESSION['panier']['libelleProduit']);
							if ($nbArticles <= 0)
							{
								echo "<tr><td>Votre panier d'achats immédiats est vide </ td></tr>";
							}
							else
							{
								for ($i=0 ;$i < $nbArticles ; $i++)
								{
									$NomProduit = ($_SESSION['panier']['libelleProduit'][$i]);
									echo $NomProduit.' ';
									echo ($_SESSION['panier']['prixProduit'][$i]).' euros';
									echo "<input type='button' value='Supprimer' onclick='self.location.href=\"".htmlspecialchars("Panier.php?action=suppression&l=".rawurlencode($_SESSION['panier']['libelleProduit'][$i]))."\"' onclick><br><br>";
									if (isset($_POST['PayerArticle']) )
									{
										$LinkIDArticle = mysqli_query($link,"SELECT ID_Article FROM Articles WHERE Nom ='$NomProduit'");
										if ($row = mysqli_fetch_array( $LinkIDArticle ))
										{
											$IDArticle = $row['ID_Article'];
										}
										$LinkIDVendeur = mysqli_query($link,"SELECT ID_Membre FROM Articles WHERE Nom ='$NomProduit'");
										if ($row = mysqli_fetch_array( $LinkIDVendeur ))
										{
										    $IDVendeur = $row['ID_Membre'];
										}
										$Result = mysqli_query($link,"INSERT INTO Transactions(ID_Acheteur,ID_Vendeur,ID_Article) VALUES ('$IDAcheteur','$IDVendeur','$IDArticle')");

										$ReqUpdate = mysqli_query($link,"UPDATE Articles SET Payement= 1 WHERE Nom ='$NomProduit'");

									}
									if (isset($_POST['PayerArticle']) )
									{
										if($i == $nbArticles-1)
										{
											supprimePanier();
											creationPanier();

											header("Location: https://www.paypal.com/fr/webapps/mpp/send-money-online");
										}
									}
								
								}
								echo "<strong>Montant total du panier: </strong>".MontantGlobal()." euros. <br><br>";

								echo '<input type="submit" value="Payer" name="PayerArticle"><br><br>';
							}
						}
					?>
			</div></center>
	    </form>
	</body>
</html>