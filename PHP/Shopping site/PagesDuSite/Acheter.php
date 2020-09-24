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
        <title>MyAuctionSite Achat</title>
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
			<?php
				$Req = mysqli_query($link,"SELECT * FROM Articles");
				$NbArticles = mysqli_num_rows($Req);
				for ($i=$NbArticles; $i >= 1; $i--)
				{
					$SqlModeVente = mysqli_query($link,"SELECT ModeVente FROM Articles WHERE ID_Article = '$i'");
					if ($row = mysqli_fetch_array( $SqlModeVente ))
					{
					   $SqlModeVente = $row['ModeVente'];
					}
					if ($SqlModeVente == 'Enchere')
					{
						$SqlDateFinEnchere = mysqli_query($link,"SELECT DateFin FROM Encheres WHERE ID_Article = '$i'");
						if ($row = mysqli_fetch_array( $SqlDateFinEnchere ))
						{
						   $DateFinEnchere = $row['DateFin'];
						}
						if(isset($DateFinEnchere) AND $DateFinEnchere>date("Y-m-d H:i:s"))
						{
							$Req = mysqli_query($link,"SELECT ID_Article FROM Articles WHERE ID_Article = $i");
							if ($row = mysqli_fetch_array( $Req ))
							{
							   $MysqlIDCurrent = $row['ID_Article'];
							}

							echo '<a href="PagesArticles/PageArticle='.$MysqlIDCurrent.'.php"><center><div id="Page">';

							$Req = mysqli_query($link,"SELECT NomUpload FROM PhotosArticle WHERE ID_Article = $MysqlIDCurrent");
						    for ($j=0; $j < mysqli_num_rows($Req); ++$j)
						    {
						    	$champs = mysqli_fetch_array($Req);
						    	$Image = $champs['NomUpload'];
						    	echo '<img src="../Images/PhotosArticles/'.$Image.'" width="100" height="100" alt="Mon Image">';
						    }
						    $NomArticle = ChercheBDD($link,'Nom','Articles','ID_Article',$MysqlIDCurrent);
							$ModeVente = ChercheBDD($link,'ModeVente','Articles','ID_Article',$MysqlIDCurrent);
							$DateMiseEnLigne = ChercheBDD($link,'DateMiseEnLigne','Articles','ID_Article',$MysqlIDCurrent);
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
						$LinkIDArticle = mysqli_query($link,"SELECT ID_Article FROM Articles WHERE ID_Article = $i");
						if ($row = mysqli_fetch_array( $LinkIDArticle ))
						{
						   $MysqlIDCurrent = $row['ID_Article'];
						}
						$LinkPayement = mysqli_query($link,"SELECT Payement FROM Articles WHERE ID_Article = $i");
						if ($row = mysqli_fetch_array( $LinkPayement ))
						{
						   $PayementArticle = $row['Payement'];
						}
						if($PayementArticle != 1)
						{
							echo '<a href="PagesArticles/PageArticle='.$MysqlIDCurrent.'.php"><center><div id="Page">';

							$Req = mysqli_query($link,"SELECT NomUpload FROM PhotosArticle WHERE ID_Article = $MysqlIDCurrent");
						    for ($j=0; $j < mysqli_num_rows($Req); ++$j)
						    {
						    	$champs = mysqli_fetch_array($Req);
						    	$Image = $champs['NomUpload'];
						    	echo '<img src="../Images/PhotosArticles/'.$Image.'" width="100" height="100" alt="Mon Image">';
						    }
						    $NomArticle = ChercheBDD($link,'Nom','Articles','ID_Article',$MysqlIDCurrent);
							$ModeVente = ChercheBDD($link,'ModeVente','Articles','ID_Article',$MysqlIDCurrent);
							$DateMiseEnLigne = ChercheBDD($link,'DateMiseEnLigne','Articles','ID_Article',$MysqlIDCurrent);
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
			?>
	    </form>
	</body>
</html>