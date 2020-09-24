<!--Erik Courtecuisse-->
<?php
	session_start();
	session_destroy();
	setcookie('MotDePasse','', time()-3600);
	header('Location: ../Connexion.php');
?>