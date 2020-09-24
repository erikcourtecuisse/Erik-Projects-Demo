<!--Erik Courtecuisse-->
<?php

include("myparam.inc.php");

function ConnexMysql()
{
	if (!$link = mysqli_connect(MYHOST,MYUSER,MYPASS,MYDB))
	{
    echo 'Connexion impossible à mysql';
	}
	else return $link;
}

function CreationMDPAleatoire($Longueur)
{
	$char='ABCDEFGHIJKLMNOPQRSTUWXYZabcdefghijklmnopqrstuvwxyz0123456789';
	$MDP=str_shuffle($char);
	$MDP=substr($MDP,0,$Longueur);
	return $MDP;
}

function EnvoyerMail($MailDestinataire,$NomDestinataire,$ObjetMail,$CorpsMail)
{
	require"../../../../PHPMailer/PHPMailerAutoload.php";
	$mail = new PHPmailer();
	// Paramètres SMTP
	$mail->IsSMTP(); // activation des fonctions SMTP
	$mail->SMTPAuth = true; // on l’informe que ce SMTP nécessite une autentification
	$mail->SMTPSecure = Protocole; // protocole utilisé pour sécuriser les mails 'ssl' ou 'tls'
	$mail->Host = ServeurSMTP; // définition de l’adresse du serveur SMTP : 25 en local, 465 pour ssl et 587 pour tls
	$mail->Port = 465; // définition du port du serveur SMTP
	$mail->Username = MailSMTP; // le nom d’utilisateur SMTP
	$mail->Password = MDPSMTP; // son mot de passe SMTP

	// Paramètres du mail
	$mail->AddAddress($MailDestinataire,$NomDestinataire); // ajout du destinataire
	$mail->From = "adminphp2017@free.fr"; // adresse mail de l’expéditeur
	$mail->FromName = "MyAuctionSite"; // nom de l’expéditeur
	$mail->IsHTML(true); // envoi du mail au format HTML
	$mail->Subject = $ObjetMail; // sujet du mail
	$mail->Body = "<html>$CorpsMail</html>"; // le corps de texte du mail en HTML

	if(!$mail->Send())// envoi du mail
	{
		echo "Mailer Error: " . $mail->ErrorInfo; // affichage des erreurs, s’il y en a
	} 
	$mail->SMTPDebug = 1;
}

function ChercheBDDSession($link,$select,$table,$where)
{
	$Link = mysqli_query($link,"SELECT $select FROM $table WHERE $where = '".$_SESSION[$where]."'");
	if ($row = mysqli_fetch_array( $Link ))
	{
	    $MysqlRecupInfo = $row[$select];
	    return $MysqlRecupInfo;
	}
}

function ChercheBDD($link,$select,$table,$where,$condition)
{
   $Link = mysqli_query($link,"SELECT $select FROM $table WHERE $where = '$condition'");
   if ($row = mysqli_fetch_array( $Link ))
   {
       $MysqlRecupInfo = $row[$select];
       return $MysqlRecupInfo;
   }
}

function creationPanier(){
   if (!isset($_SESSION['panier'])){
      $_SESSION['panier']=array();
      $_SESSION['panier']['libelleProduit'] = array();
      $_SESSION['panier']['prixProduit'] = array();
   }
   return true;
}

function ajouterArticle($libelleProduit,$prixProduit){

   if (creationPanier())
   {
      $positionProduit = array_search($libelleProduit,  $_SESSION['panier']['libelleProduit']);

      if ($positionProduit !== false)
      {
         return false;
      }
      else
      {
         array_push( $_SESSION['panier']['libelleProduit'],$libelleProduit);
         array_push( $_SESSION['panier']['prixProduit'],$prixProduit);
         return true;
      }
   }
   else
   echo "Un problème est survenu veuillez contacter l'administrateur du site.";
}

function supprimerArticle($libelleProduit){
   if (creationPanier())
   {
      $tmp=array();
      $tmp['libelleProduit'] = array();
      $tmp['prixProduit'] = array();

      for($i = 0; $i < count($_SESSION['panier']['libelleProduit']); $i++)
      {
         if ($_SESSION['panier']['libelleProduit'][$i] !== $libelleProduit)
         {
            array_push( $tmp['libelleProduit'],$_SESSION['panier']['libelleProduit'][$i]);
            array_push( $tmp['prixProduit'],$_SESSION['panier']['prixProduit'][$i]);
         }

      }
      $_SESSION['panier'] =  $tmp;
      unset($tmp);
   }
   else
   echo "Un problème est survenu veuillez contacter l'administrateur du site.";
}

function MontantGlobal(){
   $total=0;
   for($i = 0; $i < count($_SESSION['panier']['libelleProduit']); $i++)
   {
      $total += $_SESSION['panier']['prixProduit'][$i];
   }
   return $total;
}

function compterArticles()
{
   if (isset($_SESSION['panier']))
   return count($_SESSION['panier']['libelleProduit']);
   else
   return 0;
}

function supprimePanier(){
   unset($_SESSION['panier']);
}

function CloseCompte(){
   $filename = 'Deconnexion.php';
   if(!isset($_SESSION['Pseudonyme']))
   {
      if (file_exists($filename))
      {
         header('Location: Deconnexion.php');
      }
      else
      {
         header('Location: ../Deconnexion.php');
      }
   }
}

function SetSessionFalse(){
   $_SESSION['CompteMDPModif'] = False;
   $_SESSION['CompteModif'] = False;
   $_SESSION['MDPChange'] = False;
   $_SESSION['Inscrit'] = False;
   $_SESSION['ANote'] = False;
}

?>