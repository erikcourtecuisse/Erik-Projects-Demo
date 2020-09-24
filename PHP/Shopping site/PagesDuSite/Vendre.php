<!--Erik Courtecuisse-->
<?php
	include("../Complements/fonctions.php");

	session_start();

	$link = ConnexMysql();
	CloseCompte();
	SetSessionFalse();
	mysqli_query ($link,'SET NAMES UTF8');

	if(isset($_POST['Soumettre']))
	{
		if (!empty($_POST['NomArticle']) AND !empty($_POST['Categorie']) AND !empty($_POST['Prix']) AND !empty($_POST['Description']) AND !empty($_POST['Etat']) AND !empty($_POST['ModeVente']) AND !empty($_FILES['photo1']['tmp_name']) OR !empty($_FILES['photo2']['tmp_name']) OR !empty($_FILES['photo3']['tmp_name']))
		{
			$MysqlPseudo = ChercheBDDSession($link,'ID_Membre','Membres','Pseudonyme');
			$NomArticle = $_POST['NomArticle'];
			$Categorie = $_POST['Categorie'];
			$Prix = $_POST['Prix'];
			$Description = $_POST['Description'];
			$Etat = $_POST['Etat'];
			$ModeVente = $_POST['ModeVente'];

			$Result = mysqli_query($link,"INSERT INTO Articles(Nom,Categorie,Prix,Description,Etat,ID_Membre,ModeVente) VALUES ('$NomArticle','$Categorie','$Prix','$Description','$Etat','$MysqlPseudo','$ModeVente')");

			sleep(1);

			$SqlIdArticle = mysqli_query($link,"SELECT ID_Article FROM Articles WHERE Description = '$Description'");
			if ($row = mysqli_fetch_array( $SqlIdArticle ))
			{
			    $MysqlRecupInfo = $row['ID_Article'];
			}

			$TimeActu=time("Y-m-d H:i:s");
			$NewTimeActu=$TimeActu+DureeEnchere;
			$TimeFinEnchere=date("Y-m-d H:i:s",$NewTimeActu);

			if($ModeVente == 'Enchere')
			{
				$ReqEnchere = mysqli_query($link,"INSERT INTO Encheres(ID_Article,ID_Membre,Valeur,DateFin) VALUES ('$MysqlRecupInfo','$MysqlPseudo','$Prix','$TimeFinEnchere')");
			}

			$dossier = '../Images/PhotosArticles/';
			$fichier1 = basename($_FILES['photo1']['name']);
			$fichier2 = basename($_FILES['photo2']['name']);
			$fichier3 = basename($_FILES['photo3']['name']);
			$taille_maxi = 100000;
			$taille1 = filesize($_FILES['photo1']['tmp_name']);
			$taille2 = filesize($_FILES['photo2']['tmp_name']);
			$taille3 = filesize($_FILES['photo3']['tmp_name']);
			$extensions = array('.png', '.gif', '.jpg', '.jpeg','');
			$extension1 = strrchr($_FILES['photo1']['name'], '.');
			$extension2 = strrchr($_FILES['photo2']['name'], '.');
			$extension3 = strrchr($_FILES['photo3']['name'], '.');
			$Unique = md5(time()); 
			$fichier1 = $Unique.CreationMDPAleatoire(10).$extension1;
			$fichier2 = $Unique.CreationMDPAleatoire(10).$extension2;
			$fichier3 = $Unique.CreationMDPAleatoire(10).$extension3;

			if(in_array($extension1, $extensions) AND in_array($extension2, $extensions) AND in_array($extension3, $extensions))
			{
				if(($taille1<$taille_maxi) OR ($taille2<$taille_maxi) OR ($taille3<$taille_maxi))
				{
					if(move_uploaded_file($_FILES['photo1']['tmp_name'], $dossier . $fichier1))
					{
					   $Result = mysqli_query($link,"INSERT INTO PhotosArticle(ID_Article,NomUpload) VALUES ('$MysqlRecupInfo','$fichier1')");
					}
					if(move_uploaded_file($_FILES['photo2']['tmp_name'], $dossier . $fichier2))
					{
						$Result = mysqli_query($link,"INSERT INTO PhotosArticle(ID_Article,NomUpload) VALUES ('$MysqlRecupInfo','$fichier2')");
					}
					if(move_uploaded_file($_FILES['photo3']['tmp_name'], $dossier . $fichier3))
					{
						$Result = mysqli_query($link,"INSERT INTO PhotosArticle(ID_Article,NomUpload) VALUES ('$MysqlRecupInfo','$fichier3')");
					}
					$succes = 'Votre vente a étée enregistrée !';
				}
				else
				{
					$erreur = 'L\'une des photos est trop volumineuse.';
				}
			}
			else
			{
			    $erreur = 'Vous devez uploader un fichier de type png, gif, jpg ou jpeg.';
			}
		}
		else 
		{
			$erreur = 'Merci de remplir tous les champs et de mettre au moins une photo pour mettre un produit en vente.';
		}
	}
	if(isset($succes))
	{
		$file = 'PagesArticles/PageArticle='.$MysqlRecupInfo.'.php';
		$current = '
<?php
	include("../../Complements/fonctions.php");

	session_start();

	$link = ConnexMysql();
	CloseCompte();
	SetSessionFalse();
	mysqli_query ($link,\'SET NAMES UTF8\');
?>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" charset="utf-8" content="width=device-width, initial-scale=1" />
        <title>MyAuctionSite Vente</title>
        <link rel="stylesheet" href="../../Css/Style.css" />
        <link rel="stylesheet" href="../../Css/MenuH.css" />
        <link rel="stylesheet" href="../../Css/SlideShow.css" />
    </head>
    <body>
    <form method="post" action="" enctype="multipart/form-data">
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
		<body>
			<br>
				<center><div id="Page">
				    <div class="slideshow-container">
					    <?php
					    	$Req = mysqli_query($link,"SELECT NomUpload FROM PhotosArticle WHERE ID_Article = '.$MysqlRecupInfo.'");
					    	for ($i=0; $i < mysqli_num_rows($Req); ++$i)
					    	{
					    		$champs = mysqli_fetch_array($Req);
					    		$Image = $champs[\'NomUpload\'];
					    		echo \'<div class="mySlides fade">
					    		<img src="../../Images/PhotosArticles/\'.$Image.\'" style="width:100%">
					    		</div>\';
					    	}
					    ?>
					</div>
						<?php
					    	$LinkNamePoster = mysqli_query($link,\'SELECT Pseudonyme FROM Membres,Articles WHERE Membres.ID_Membre = Articles.ID_Membre AND ID_Article ='.$MysqlRecupInfo.'\');
							if ($row = mysqli_fetch_array( $LinkNamePoster ))
							{
								$NomVendeur = $row[\'Pseudonyme\'];
							}
					    	$NomArticle = ChercheBDD($link,\'Nom\',\'Articles\',\'ID_Article\','.$MysqlRecupInfo.');
					    	$CategorieArticle = ChercheBDD($link,\'Categorie\',\'Articles\',\'ID_Article\','.$MysqlRecupInfo.');
					    	$PrixArticle = ChercheBDD($link,\'Prix\',\'Articles\',\'ID_Article\','.$MysqlRecupInfo.');
					    	$DescriptionArticle = ChercheBDD($link,\'Description\',\'Articles\',\'ID_Article\','.$MysqlRecupInfo.');
					    	$EtatArticle = ChercheBDD($link,\'Etat\',\'Articles\',\'ID_Article\','.$MysqlRecupInfo.');
							$ModeVente = ChercheBDD($link,\'ModeVente\',\'Articles\',\'ID_Article\','.$MysqlRecupInfo.');
							$DateMiseEnLigne = ChercheBDD($link,\'DateMiseEnLigne\',\'Articles\',\'ID_Article\','.$MysqlRecupInfo.');
							echo \'<br><strong>Article:</strong> \';
							echo $NomArticle;
							echo \'<br><strong>Categorie:</strong> \';
							echo $CategorieArticle;
							echo \'<br><strong>Prix (de départ):</strong> \';
							echo $PrixArticle; echo \' euros\';
							echo \'<br><strong>Description:</strong> \';
							echo $DescriptionArticle;
							echo \'<br><strong>Etat:</strong> \';
							echo $EtatArticle;
							echo \'<br><strong>Mode de vente:</strong> \';
							echo $ModeVente;
							echo \'<br><strong>Mis en ligne:</strong> \';
							echo $DateMiseEnLigne; echo \' <strong>par:</strong> \'; echo \'<u><a href=../InfosComptes/InfosCompte=\'.$NomVendeur.\'.php>\'.$NomVendeur.\'</a></u>\';

							$Pseudo = $_SESSION[\'Pseudonyme\'];

							if($ModeVente == \'Achat Immediat\')
							{
								echo \'<br><br><input type="submit" name="panier" value="Ajouter au panier">\';
							}
							else
							{
								$LinkDateFin = mysqli_query($link,\'SELECT DateFin FROM Articles,Encheres WHERE Articles.ID_Article = Encheres.ID_Article AND Articles.ID_Article = '.$MysqlRecupInfo.'\');
								if ($row = mysqli_fetch_array( $LinkDateFin ))
								{
									$SqlDateFin = $row[\'DateFin\'];
								}
								$LinkValeur = mysqli_query($link,\'SELECT Valeur FROM Articles,Encheres WHERE Articles.ID_Article = Encheres.ID_Article AND Articles.ID_Article = '.$MysqlRecupInfo.'\');
								if ($row = mysqli_fetch_array( $LinkValeur ))
								{
									$SqlValeur = $row[\'Valeur\'];
								}
								$LinkIDEnchere = mysqli_query($link,\'SELECT ID_Enchere FROM Articles,Encheres WHERE Articles.ID_Article = Encheres.ID_Article AND Articles.ID_Article = '.$MysqlRecupInfo.'\');
								if ($row = mysqli_fetch_array( $LinkIDEnchere ))
								{
									$SqlIDEnchere = $row[\'ID_Enchere\'];
								}
								echo "<br><br><strong>Valeur actuelle de l\'enchére : ".$SqlValeur." </strong>";
								echo "<br><input type=\'submit\' name=\'encherir\' value=\'Encherir\'>";
								echo "<br><strong>Fin de l\'enchere : ".$SqlDateFin." </strong><br>";
							}
							if(isset($_POST[\'panier\']))
							{
								$LinkInfoVendeur = mysqli_query($link,\'SELECT ID_Membre FROM Articles WHERE ID_Article = '.$MysqlRecupInfo.'\');
				                if ($row = mysqli_fetch_array( $LinkInfoVendeur ))
								{
								   $MysqlRecupInfoVendeur = $row[\'ID_Membre\'];
								}
								$LinkInfoVendeur2 = mysqli_query($link,"SELECT ID_Membre FROM Membres WHERE Pseudonyme = \'".$Pseudo."\'");
								if ($row = mysqli_fetch_array( $LinkInfoVendeur2 ))
								{
								   $MysqlRecupInfoVendeur2 = $row[\'ID_Membre\'];
								}
				                if($MysqlRecupInfoVendeur !== $MysqlRecupInfoVendeur2)
				                {
				                	creationPanier();
									$ProduitPanier = ajouterArticle($NomArticle,$PrixArticle);
									if($ProduitPanier == false)
									{
										echo "<br><font color=\'red\'>Cette article est déjà dans votre panier<br></font><br>";
									}
									else
									{
										echo "<br><font color=\'green\'>Le produit a été ajouté au panier<br></font><br>";
									}
				                }
				                else
				                {
				                	echo "<br><font color=\'red\'>Vous ne pouvez pas acheter votre propre article.</font>";
				                }
							}
							if(isset($_POST[\'encherir\']))
							{
								echo \'<br><label for="MotDePasse">Indiquez votre mot de passe : <br>
		        					<input type="password" name="MotDePasse">
		        					<br><label for="Enchere">Donnez un montant a enchérir : 
		        					</label><br><input type="Enchere" name="Enchere">
		        					<br><br><input type="submit" name="ValideEnchere" value="Valider">\';
							}
							if(isset($_POST[\'ValideEnchere\']))
							{
		        				$MDP = md5($_POST[\'MotDePasse\']);

		        				$Requete = mysqli_query($link,"SELECT * FROM Membres WHERE Pseudonyme = \'".$Pseudo."\' AND MotDePasse = \'".$MDP."\'");
				                if(mysqli_num_rows($Requete) == 0)
				                {
				                    echo "<br><font color=\'red\'>Le mot de passe est incorrect.</font>";
				                }
				                else
				                {
				                	$LinkInfoVendeur = mysqli_query($link,\'SELECT ID_Membre FROM Encheres WHERE ID_Article = '.$MysqlRecupInfo.'\');
				                	if ($row = mysqli_fetch_array( $LinkInfoVendeur ))
									{
									   $MysqlRecupInfoVendeur = $row[\'ID_Membre\'];
									}
									$LinkInfoVendeur2 = mysqli_query($link,"SELECT ID_Membre FROM Membres WHERE Pseudonyme = \'".$Pseudo."\'");
									if ($row = mysqli_fetch_array( $LinkInfoVendeur2 ))
									{
									   $MysqlRecupInfoVendeur2 = $row[\'ID_Membre\'];
									}
				                	if($MysqlRecupInfoVendeur !== $MysqlRecupInfoVendeur2)
				                	{
				                		$NewValeurEnchere = $_POST[\'Enchere\']+$SqlValeur;
				                		if($NewValeurEnchere>$SqlValeur)
				                		{
											$IDPseudoVainqueur = ChercheBDD($link,\'ID_Membre\',\'Membres\',\'Pseudonyme\',$Pseudo);
				                			$ReqUpdate = mysqli_query($link,"UPDATE Encheres SET Valeur =\'".$NewValeurEnchere."\' WHERE ID_Enchere = \'".$SqlIDEnchere."\'");
				                			$ReqUpdate = mysqli_query($link,"UPDATE Encheres SET ID_Vainqueur =\'".$IDPseudoVainqueur."\' WHERE ID_Enchere = \'".$SqlIDEnchere."\'");
				                			echo "<br><font color=\'green\'>L\'enchére est comptabilisée.</font>";
				                		}
				                		else
				                		{
				                			echo "<br><font color=\'red\'>Il faut enchérir.</font>";
				                		}
				                	}
				                	else
				                	{
				                		echo "<br><font color=\'red\'>Vous ne pouvez pas enchérir sur votre propre article.</font>";
				                	}
				                }
							}
						?>
					    <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
					    <a class="next" onclick="plusSlides(1)">&#10095;</a>
				</div></center>
					<br>

				<script>
				    var slideIndex = 1;
				    showSlides(slideIndex);

				    function plusSlides(n) {
				      showSlides(slideIndex += n);
				    }

				    function currentSlide(n) {
				      showSlides(slideIndex = n);
				    }

				    function showSlides(n) {
				      var i;
				      var slides = document.getElementsByClassName("mySlides");
				      if (n > slides.length) {slideIndex = 1}    
				      if (n < 1) {slideIndex = slides.length}
				      for (i = 0; i < slides.length; i++) {
				          slides[i].style.display = "none";  
				      }
				      slides[slideIndex-1].style.display = "block";  
				    }
				</script>
		</body>
	</form>
</html>';
		file_put_contents($file, $current);
	}
?>

<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" charset="utf-8" content="width=device-width, initial-scale=1" />
        <title>MyAuctionSite Vente</title>
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
				if(isset($erreur))
			            {
							echo "<font color='red'>$erreur<br></font><br>";
			            }
			    if(isset($succes))
			            {
							echo "<font color='green'>$succes<br></font><br>";
			            }
			    ?>
				Merci de remplir les champs ci dessous pour mettre votre article en vente.<br><br>
				<label for="NomArticle">Nom de l'article : </label><br>
			    <input type="NomArticle" name="NomArticle"><br><br>
			    <label for="Categorie">Catégorie : </label><br>
			        <SELECT name="Categorie" size="1">
					<OPTION>Mode
					<OPTION>High-Tech
					<OPTION>Maison
					<OPTION>Collection
					<OPTION>Auto
					<OPTION>Media
					</SELECT><br><br>
				<label for="Prix">Prix minimum pour enchére ou achat immédiat : </label><br>
			    <input type="Prix" name="Prix" value="euros" onfocus="this.value='';" onblur="if(this.value=='')this.value='euros';" /><br><br>
				<label for="Description">Description : </label><br>
			   	<TEXTAREA cols="60" rows="5" name="Description"></TEXTAREA><br><br>
			   	<label for="Etat">Etat du produit : </label><br>
			        <SELECT name="Etat" size="1">
					<OPTION>Neuf
					<OPTION>Comme Neuf
					<OPTION>Tres Bon Etat
					<OPTION>Bon Etat
					<OPTION>Etat Correct
					</SELECT><br><br>
				<label for="ModeVente">Mode de vente : </label><br>
			        <SELECT name="ModeVente" size="1">
					<OPTION>Achat Immediat
					<OPTION>Enchere
					</SELECT><br><br>
				<label for="Photo">Photo de l'article : </label><br>
				    <input type="hidden" name="MAX_FILE_SIZE" value="100000">
     				Photo 1 : <input type="file" name="photo1"><br>
     				Photo 2 : <input type="file" name="photo2"><br>
     				Photo 3 : <input type="file" name="photo3"><br><br>
					<input type="submit" value="Soumettre" name="Soumettre"/><br><br>
			</div></center>
	    </form>
	</body>
</html>