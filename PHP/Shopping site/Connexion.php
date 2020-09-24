<!--Erik Courtecuisse-->
<?php
	include("Complements/fonctions.php");
	
	session_start();

	$link = ConnexMysql();
	mysqli_query ($link,'SET NAMES UTF8');

	if(isset($_POST['SeSouvenirMoi']))
	{
		if(!isset($_COOKIE['Pseudonyme']))
		{
		    if(!empty($_POST['Pseudonyme']))
		    {
		        setcookie('Pseudonyme', $_POST['Pseudonyme'], time() + JoursExpirationCookie*24*3600);
		    }
		}
	}

	if(isset($_POST['connexion']))
	{
		if(empty($_POST['Pseudonyme']))
		{
       		$PseudoManquant="Le champ Pseudonyme est vide.";
    	} 
    	else
    	{
        	if(empty($_POST['MotDePasse']))
        	{
            	$MDPManquant="Le champ Mot de passe est vide.";
        	}
        	else 
        	{
	            $Pseudo = htmlentities($_POST['Pseudonyme'], ENT_QUOTES, "ISO-8859-1");
	            $MDP = htmlentities(md5($_POST['MotDePasse']), ENT_QUOTES, "ISO-8859-1");
		        if(!$link)
		        {
		        	echo "Erreur de connexion à la base de données.";
		        } 
	            else 
	            {
	                $Requete = mysqli_query($link,"SELECT * FROM Membres WHERE Pseudonyme = '".$Pseudo."' AND MotDePasse = '".$MDP."'");
	                if(mysqli_num_rows($Requete) == 0)
	                {
	                    $MauvaisMDP="Le pseudonyme ou le mot de passe est incorrect.";
	                }
	                else
	                {
	                    $_SESSION['Pseudonyme'] = $Pseudo;
	                    header('Location: PagesDuSite/PageAccueil.php');
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
        <link rel="stylesheet" href="Css/Style.css" />
    </head>
    <body>
		<center><h1><Strong>MyAuctionSite</Strong></h1></center>
		<br><br><br>
		<center><div id="Page">
			<?php
				if(isset($_SESSION['Inscrit']))
				{
					if($_SESSION['Inscrit'] == TRUE)
					{
						echo "<font color='green'>Felicitation vous êtes inscrit<br></font>";
					}
				}
				if(isset($_SESSION['MDPChange']))
				{
					if($_SESSION['MDPChange'] == TRUE)
					{
						echo "<font color='green'>Votre mot de passe a bien été changé<br></font>";
					}
				}
			?>
	        <p> 
	                Bienvenue sur MyAuctionSite, ici cherchez, vendez, encherissez et faites vous plaisir ! 
	        </p>
	        <form method="post" action="">
	            <label for="Pseudonyme">Pseudonyme : <br>
	            <input type="Pseudonyme" name="Pseudonyme" value='<?php if(isset($_COOKIE['Pseudonyme'])) { echo $_COOKIE['Pseudonyme'];} ?>'><br><br>
	            <label for="MotDePasse">Mot De Passe : <br>
		        <input type="password" name="MotDePasse"><br><br>
	            <input type="submit" value="Connexion" name="connexion"/><br>
	            <?php
	            	if(isset($MauvaisMDP))
					{
						echo "<font color='red'>$MauvaisMDP<br></font>";
					}
					if(isset($MDPManquant))
					{
						echo "<font color='red'>$MDPManquant<br></font>";
					}
					if(isset($PseudoManquant))
					{
						echo "<font color='red'>$PseudoManquant<br></font>";
					}
	            ?>
	            <br>
	            <label class="checkbox">
	            	<input type="checkbox" checked="checked" name="SeSouvenirMoi">  Se souvenir de moi <br><br>
	       		</label>
	            <input type="button" value="Mot de passe oublié" onclick="self.location.href='PagesDuSite/MotDePasseOublier.php'" onclick><br><br>
	            <label for="Inscrit">Toujours pas inscrit ? </label>
	            <input type="button" value="S'enregistrer" onclick="self.location.href='PagesDuSite/Inscription.php'" onclick>
	        </form><br>
        </div></center>
 	</body>
</html>