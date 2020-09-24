<!--Erik Courtecuisse-->
<?php
	include("../Complements/fonctions.php");

	session_start();

	$link = ConnexMysql();
	CloseCompte();
	SetSessionFalse();
	mysqli_query ($link,'SET NAMES UTF8');


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
				<u><strong><h3>Voici l'intégralité de vos transactions : </h3></strong></u><br>
				<?php
					$IDUtilisateur = ChercheBDDSession($link,'ID_Membre','Membres','Pseudonyme');
					$Req = mysqli_query($link,"SELECT * FROM Transactions");
					$NbTransactions = mysqli_num_rows($Req);
					for ($i=1; $i <=$NbTransactions; ++$i)
					{
						$LinkAcheteur = mysqli_query($link,"SELECT ID_Acheteur FROM Transactions WHERE ID_Transaction = ".$i."");
						if ($row = mysqli_fetch_array( $LinkAcheteur ))
						{
						   $IDTransactionAcheteur = $row['ID_Acheteur'];
						}
						$LinkVendeur = mysqli_query($link,"SELECT ID_Vendeur FROM Transactions WHERE ID_Transaction = ".$i."");
						if ($row = mysqli_fetch_array( $LinkVendeur ))
						{
						   $IDTransactionVendeur = $row['ID_Vendeur'];
						}


						if($IDUtilisateur == $IDTransactionAcheteur )
						{
							$LinkArticle = mysqli_query($link,"SELECT Nom FROM Articles WHERE ID_Article = ".$i."");
							if ($row = mysqli_fetch_array( $LinkArticle ))
							{
							   $NomArticle = $row['Nom'];
							}
							$LinkVendeur2 = mysqli_query($link,"SELECT Pseudonyme FROM Membres WHERE ID_Membre = ".$IDTransactionVendeur."");
							if ($row = mysqli_fetch_array( $LinkVendeur2 ))
							{
							   $NomVendeur = $row['Pseudonyme'];
							}
							echo 'Vous avez acheté : <strong>'.$NomArticle.'</strong> a <strong><u><a href=InfosComptes/InfosCompte='.$NomVendeur.'.php>'.$NomVendeur.'</a></u></strong><br>';
							$LinkNotationAchat = mysqli_query($link,"SELECT Notation FROM Articles WHERE ID_Article = ".$i."");
							if ($row = mysqli_fetch_array( $LinkNotationAchat ))
							{
							   $EstNote = $row['Notation'];
							}
							if($EstNote == 0)
							{
								echo '<font color=\'red\'>Vous n\'avez pas noté cette vente, noter le vendeur :</font> <input type="submit" value="Noter" name="Notation'.$i.'">';
							}

							if(isset($_POST['Notation'.$i.'']))
							{
								echo '<br><label for="Notation">Note : </label><br>
									    <SELECT name="Notation" size="1">
										<OPTION>1
										<OPTION>2
										<OPTION>3
										<OPTION>4
										<OPTION>5
										</SELECT><br>
									<input type="submit" value="Soumettre" name="SoumettreNotation'.$i.'"><br><br>';
							}
							echo '<br>';
							if(isset($_POST['SoumettreNotation'.$i.'']))
							{
								$_SESSION['ANote'] = True;
								$LinkIDMembreVendeur = mysqli_query($link,"SELECT ID_Membre FROM Articles WHERE ID_Article = ".$i."");
								if ($row = mysqli_fetch_array( $LinkIDMembreVendeur ))
								{
								   $IDMembreVendeur = $row['ID_Membre'];
								}
								$ReqUpdate = mysqli_query($link,"UPDATE Articles SET Notation= 1 WHERE ID_Article = '".$i."'");
								$InsertNotation = mysqli_query($link,"INSERT INTO Notations(ID_Membre,ID_Article,Notation) VALUES ('$IDMembreVendeur','$i',".$_POST['Notation'].")");
								header("Location: InfosComptes/InfosCompte=".$NomVendeur.".php");
							}
						}
						if($IDUtilisateur == $IDTransactionVendeur)
						{
							$LinkArticle2 = mysqli_query($link,"SELECT Nom FROM Articles WHERE ID_Article = ".$i."");
							if ($row = mysqli_fetch_array( $LinkArticle2 ))
							{
							   $NomArticle2 = $row['Nom'];
							}
							$LinkAcheteur2 = mysqli_query($link,"SELECT Pseudonyme FROM Membres WHERE ID_Membre = ".$IDTransactionAcheteur."");
							if ($row = mysqli_fetch_array( $LinkAcheteur2 ))
							{
							   $NomAcheteur = $row['Pseudonyme'];
							}
							echo 'Vous avez vendu : <strong>'.$NomArticle2.'</strong> a <strong><u><a href=InfosComptes/InfosCompte='.$NomAcheteur.'.php>'.$NomAcheteur.'</a></u></strong><br><br>';
						}
						if(isset($_POST['ExportXml']))
						{
							if($IDUtilisateur == $IDTransactionVendeur OR $IDUtilisateur == $IDTransactionAcheteur )
							{

								if(isset($_POST['StyleXsl']) AND $_POST['StyleXsl'] == 'Style 1' )
								{
									$style = '"Xsl1.xsl"';
								}
								elseif(isset($_POST['StyleXsl']) AND $_POST['StyleXsl'] == 'Style 2' )
								{
									$style = '"Xsl2.xsl"';
								}

								$LinkArticleForXml = mysqli_query($link,'SELECT Articles.Nom,Articles.ID_Membre,Articles.Prix,Articles.ModeVente,Articles.DateMiseEnLigne,Transactions.ID_Acheteur FROM Articles,Transactions WHERE Articles.ID_Article = Transactions.ID_Article');

								$xml = '<?xml version="1.0" encoding="ISO-8859-1"?>'.'
								<?xml-stylesheet href='.$style.' type="text/xsl"?>'.'<Historique>';
								while ($row = mysqli_fetch_array($LinkArticleForXml)) {
									$xml .= '<Article>';
									$xml .= '<Intitule>'.$row['Nom'].'</Intitule>';
									$xml .= '<Vendeur>'.$row['ID_Membre'].'</Vendeur>';
									$xml .= '<Prix>'.$row['Prix'].'</Prix>';
									$xml .= '<Acheteur>'.$row['ID_Acheteur'].'</Acheteur>';
									$xml .= '<ModeVente>'.$row['ModeVente'].'</ModeVente>';
									$xml .= '<DateMiseEnLigne>'.$row['DateMiseEnLigne'].'</DateMiseEnLigne>';
									$xml .= '</Article>';
								}
								$xml .= '</Historique>';
							}
						}
					}
					echo '<br><input type="submit" value="Exporter mon historique" Name="ExportXml">';
					echo '
					<SELECT name="StyleXsl" size="1">
					<OPTION>Style 1
					<OPTION>Style 2
					</SELECT><br><br>';

					if(isset($_POST['ExportXml']))
					{
						$fp = fopen("Xml/HistoriqueTransactions.xml", 'w+');
						fputs($fp, $xml);
						fclose($fp);

						echo 'Export XML effectue !<br><U><a href="Xml/HistoriqueTransactions.xml">Voir le fichier</a></u>';
					}
				?>
			</div>
			</center>
	    </form>
	</body>
</html>