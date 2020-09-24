<!--Erik Courtecuisse-->
<?php
	include("../Complements/fonctions.php");
	session_start();

	$link = ConnexMysql();
	SetSessionFalse();
	mysqli_query ($link,'SET NAMES UTF8');

	$_SESSION['MDPChange'] = False;

	if(isset($_POST['Envoyer']))
	{
		if(empty($_POST['Pseudonyme']))
		{
       		$PseudoManquant="Le champ Pseudonyme est vide.";
    	} 
    	else
    	{
        	if(empty($_POST['Email']))
        	{
            	$EmailManquant="Le champ Email est vide.";
        	}
        	else 
        	{
	            $Pseudo = htmlentities($_POST['Pseudonyme'], ENT_QUOTES, "ISO-8859-1");
	            $Email = htmlentities($_POST['Email'], ENT_QUOTES, "ISO-8859-1");
		        if(!$link)
		        {
		        	echo "Erreur de connexion à la base de données.";
		        } 
	            else 
	            {
	                $Requete = mysqli_query($link,"SELECT * FROM Membres WHERE Pseudonyme = '".$Pseudo."' AND Email = '".$Email."'");
	                if(mysqli_num_rows($Requete) == 0)
	                {
	                    $MauvaiseConcordance="Le pseudonyme et l'Email ne correspondent pas.";
	                }
	                else
	                {
	                	$MDPAleatoire = CreationMDPAleatoire(Longueur);
	                	$LinkMailDestinataire = mysqli_query($link,"SELECT Email FROM Membres WHERE Pseudonyme = '".$Pseudo."' AND Email = '".$Email."'");
						if ($row = mysqli_fetch_array( $LinkMailDestinataire ))
                        {
                        $MysqlEmail = $row['Email'];
                        }
	            		$LinkNomDestinataire = mysqli_query($link,"SELECT Nom FROM Membres WHERE Pseudonyme = '".$Pseudo."' AND Email = '".$Email."'");
	            		if ($row = mysqli_fetch_array( $LinkNomDestinataire ))
                        {
                        $MysqlNom = $row['Nom'];
                        }
	                	$ObjetMail = "MyAuctionSite Nouveau mot de passe aleatoire";
	                	$CorpsMail = "Voici votre nouveau mot de passe généré aleatoirement, pour des raisons de sécurtiés changez le dès que possible : $MDPAleatoire";
	                	EnvoyerMail($MysqlEmail,$MysqlNom,$ObjetMail,$CorpsMail);
	                	$ReqInsert = mysqli_query($link,"UPDATE Membres SET MotDePasse='".md5($MDPAleatoire)."' WHERE Pseudonyme = '".$Pseudo."' AND Email = '".$Email."'");
	                	$_SESSION['MDPChange'] = TRUE;
	                    header('Location: ../Connexion.php');
						exit();
	                }
	            }
	        }
	    }
	}
?>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" charset="utf-8" content="width=device-width, initial-scale=1" />
        <title>MyAuctionSite Connexion</title>
        <link rel="stylesheet" href="../Css/Style.css" />
    </head>
    <body>
		<center><h1><Strong>MyAuctionSite</Strong></h1></center>
		<br><br><br>
		<center><div id="Page">
	        <p> 
	            Vous avez oublié votre mot de passe ? <br>
	            Merci de completer ces informations pour recevoir un mot de passe aléatoire par mail.<br> 
	        </p>
	        <form method="post" action="">
	        	<?php
	            	if(isset($MauvaiseConcordance))
					{
						echo "<font color='red'>$MauvaiseConcordance<br></font>";
					}
					if(isset($EmailManquant))
					{
						echo "<font color='red'>$EmailManquant<br></font>";
					}
					if(isset($PseudoManquant))
					{
						echo "<font color='red'>$PseudoManquant<br></font>";
					}
		        ?>
		        <br>
	        	<label for="Pseudonyme">Pseudonyme : <br>
	            <input type="Pseudonyme" name="Pseudonyme"><br><br>
	            <label for="Email">Email : <br>
		        <input type="Email" name="Email"><br><br>
	            <input type="submit" value="Envoyer" name="Envoyer"/><br><br>
	        </form>
        </div></center>
 	</body>
</html>