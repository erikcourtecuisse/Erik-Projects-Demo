<!--Erik Courtecuisse-->
<?php
	include("../Complements/fonctions.php");

	session_start();

	$link = ConnexMysql();
	CloseCompte();
	SetSessionFalse();
	mysqli_query ($link,'SET NAMES UTF8');

	$Pseudo = $_SESSION['Pseudonyme'];

	if(isset($_POST['SoumettreNotation']))
	{
		if (empty($_POST['RechercheNomArticle']))
		{
			$NomIncomplet = 'Merci de remplir le champ du Nom d\'article';
		}
	}

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
				<h3><strong>Effectuez votre recherche :</strong></h3>
				<?php
					if(isset($NomIncomplet))
					{
						echo "<font color='red'>".$NomIncomplet."<br></font>";
					}
				?>
				<label for="RechercheNomArticle">Nom d'article : </label><br>
			    <input type="Pseudonyme" name="RechercheNomArticle" ><br><br>
				<label for="RechercheCategorieArticle">Categorie : </label><br>
					<SELECT name="RechercheCategorieArticle" size="1">
					<OPTION>Mode
					<OPTION>High-Tech
					<OPTION>Maison
					<OPTION>Collection
					<OPTION>Auto
					<OPTION>Media
					</SELECT><br><br>
				<label for="RechercheEtatArticle">Etat : </label><br>
					<SELECT name="RechercheEtatArticle" size="1">
					<OPTION>Neuf
					<OPTION>Comme Neuf
					<OPTION>Tres Bon Etat
					<OPTION>Bon Etat
					<OPTION>Etat Correct
					</SELECT><br><br>
				<label for="RechercheModeVenteArticle">Mode de vente : </label><br>
					<SELECT name="RechercheModeVenteArticle" size="1">
					<OPTION>Achat Immediat
					<OPTION>Enchere
					</SELECT><br><br>
				<label for="TriPrix">Trier en fonction du prix : </label><br>
					<SELECT name="TriPrix" size="1">
					<OPTION>Croissant
					<OPTION>Decroissant
					</SELECT><br><br>
				<label for="TriDateValidite">Trier en fonction de la date de validité : </label><br>
					<SELECT name="TriDateValidite" size="1">
					<OPTION>Croissant
					<OPTION>Decroissant
					</SELECT><br><br><br>
				<input type="submit" value="Soumettre" name="SoumettreNotation">
			</div></center>
			<?php
				if(isset($_POST['SoumettreNotation']))
				{
					if (!empty($_POST['RechercheNomArticle']))
					{
							$RechercheNomArticle = $_POST["RechercheNomArticle"];
							$RechercheCategorieArticle = $_POST["RechercheCategorieArticle"];
							$RechercheEtatArticle = $_POST["RechercheEtatArticle"];
							$RechercheModeVenteArticle = $_POST["RechercheModeVenteArticle"];
							//$ReqRecherche = mysqli_query($link,"SELECT ID_Article FROM Articles WHERE Categorie ='$RechercheCategorieArticle' AND Etat ='$RechercheEtatArticle' AND ModeVente='$RechercheModeVenteArticle' AND Nom LIKE '%$RechercheNomArticle%' ");
							if(($_POST['TriPrix']) == 'Croissant' AND ($_POST['TriDateValidite']) == 'Croissant')
							{ 
								$ReqRecherche = mysqli_query($link,"SELECT ID_Article FROM Articles WHERE Categorie ='$RechercheCategorieArticle' AND Etat ='$RechercheEtatArticle' AND ModeVente='$RechercheModeVenteArticle' AND Nom LIKE '%$RechercheNomArticle%' ORDER BY Prix ASC, DateMiseEnLigne ASC ");
							}
							elseif(($_POST['TriPrix']) == 'Decroissant' AND ($_POST['TriDateValidite']) == 'Croissant')
							{
								$ReqRecherche = mysqli_query($link,"SELECT ID_Article FROM Articles WHERE Categorie ='$RechercheCategorieArticle' AND Etat ='$RechercheEtatArticle' AND ModeVente='$RechercheModeVenteArticle' AND Nom LIKE '%$RechercheNomArticle%' ORDER BY Prix DESC, DateMiseEnLigne ASC ");
							}
							elseif(($_POST['TriPrix']) == 'Croissant' AND ($_POST['TriDateValidite']) == 'Decroissant')
							{
								$ReqRecherche = mysqli_query($link,"SELECT ID_Article FROM Articles WHERE Categorie ='$RechercheCategorieArticle' AND Etat ='$RechercheEtatArticle' AND ModeVente='$RechercheModeVenteArticle' AND Nom LIKE '%$RechercheNomArticle%' ORDER BY Prix ASC, DateMiseEnLigne DESC ");
							}
							else
							{
								$ReqRecherche = mysqli_query($link,"SELECT ID_Article FROM Articles WHERE Categorie ='$RechercheCategorieArticle' AND Etat ='$RechercheEtatArticle' AND ModeVente='$RechercheModeVenteArticle' AND Nom LIKE '%$RechercheNomArticle%' ORDER BY Prix DESC, DateMiseEnLigne DESC ");
							}

							$num_rows = mysqli_num_rows($ReqRecherche);
							if($num_rows != 0)
							{
								for ($i=1; $i <=$num_rows; ++$i)
								{
									if ($row = mysqli_fetch_array( $ReqRecherche ))
									{
									   $MysqlIDCurrentArticle = $row['ID_Article'];
									}
									$SqlModeVente = mysqli_query($link,"SELECT ModeVente FROM Articles WHERE ID_Article = '$MysqlIDCurrentArticle'");
									if ($row = mysqli_fetch_array( $SqlModeVente ))
									{
									   $SqlModeVente = $row['ModeVente'];
									}
									if ($SqlModeVente == 'Enchere')
									{
										$SqlDateFinEnchere = mysqli_query($link,"SELECT DateFin FROM Encheres WHERE ID_Article = '$MysqlIDCurrentArticle'");
										if ($row = mysqli_fetch_array( $SqlDateFinEnchere ))
										{
										   $DateFinEnchere = $row['DateFin'];
										}
										if(isset($DateFinEnchere) AND $DateFinEnchere>date("Y-m-d H:i:s"))
										{
											$Req = mysqli_query($link,"SELECT ID_Article FROM Articles WHERE ID_Article = $MysqlIDCurrentArticle");
											if ($row = mysqli_fetch_array( $Req ))
											{
											   $MysqlIDCurrent = $row['ID_Article'];
											}

											echo '<a href="PagesArticles/PageArticle='.$MysqlIDCurrentArticle.'.php"><center><div id="Page">';

											$Req = mysqli_query($link,"SELECT NomUpload FROM PhotosArticle WHERE ID_Article = $MysqlIDCurrentArticle");
										    for ($j=0; $j < mysqli_num_rows($Req); ++$j)
										    {
										    	$champs = mysqli_fetch_array($Req);
										    	$Image = $champs['NomUpload'];
										    	echo '<img src="../Images/PhotosArticles/'.$Image.'" width="100" height="100" alt="Mon Image">';
										    }
										    $NomArticle = ChercheBDD($link,'Nom','Articles','ID_Article',$MysqlIDCurrentArticle);
											$ModeVente = ChercheBDD($link,'ModeVente','Articles','ID_Article',$MysqlIDCurrentArticle);
											$DateMiseEnLigne = ChercheBDD($link,'DateMiseEnLigne','Articles','ID_Article',$MysqlIDCurrentArticle);
											echo '<br>';
											echo $NomArticle;
											echo '<br>Mode de vente : ';
											echo $ModeVente;
											echo '<br>Date de mise en ligne : ';
											echo $DateMiseEnLigne;
										    echo '</div></center></a>';
										    echo '<br>';
										}
									}
									else
									{
										$LinkPayement = mysqli_query($link,"SELECT Payement FROM Articles WHERE ID_Article = $MysqlIDCurrentArticle");
										if ($row = mysqli_fetch_array( $LinkPayement ))
										{
										   $PayementArticle = $row['Payement'];
										}
										if($PayementArticle != 1)
										{
											echo '<a href="PagesArticles/PageArticle='.$MysqlIDCurrentArticle.'.php"><center><div id="Page">';

											$Req = mysqli_query($link,"SELECT NomUpload FROM PhotosArticle WHERE ID_Article = $MysqlIDCurrentArticle");
										    for ($j=0; $j < mysqli_num_rows($Req); ++$j)
										    {
										    	$champs = mysqli_fetch_array($Req);
										    	$Image = $champs['NomUpload'];
										    	echo '<img src="../Images/PhotosArticles/'.$Image.'" width="100" height="100" alt="Mon Image">';
										    }
										    $NomArticle = ChercheBDD($link,'Nom','Articles','ID_Article',$MysqlIDCurrentArticle);
											$ModeVente = ChercheBDD($link,'ModeVente','Articles','ID_Article',$MysqlIDCurrentArticle);
											$DateMiseEnLigne = ChercheBDD($link,'DateMiseEnLigne','Articles','ID_Article',$MysqlIDCurrentArticle);
											echo '<br>';
											echo $NomArticle;
											echo '<br>Mode de vente : ';
											echo $ModeVente;
											echo '<br>Date de mise en ligne : ';
											echo $DateMiseEnLigne;
										    echo '</div></center></a>';
										    echo '<br>';
										}
									}
								}
							}
							else
							{
								echo '<center><div id="Page"><font color=\'red\'>Aucun articles ne correspond a votre recherche.</font></div></center>';
							}
					}
				}
			?>
	    </form>
	</body>
</html>