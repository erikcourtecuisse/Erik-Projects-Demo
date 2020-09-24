<?xml version='1.0' encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html>
	<head>
		<title>Historique de transactions</title>
	</head>
	<body>
	<center><font color='red'><u><H2>Transactions</H2></u></font>
	<table border="1" cellspacing="0" cellpadding="3">
		<tr bgcolor="#115599">
			<td>Intitule</td>
			<td>ID Vendeur</td>
			<td>Prix</td>
			<td>ID Acheteur</td>
			<td>Mode de vente</td>
			<td>Date de mise en ligne</td>
		</tr>
		<xsl:for-each select="Historique/Article">
		<tr>
			<td><xsl:value-of select="Intitule"/></td>
			<td><xsl:value-of select="Vendeur"/></td>
			<td><xsl:value-of select="Prix"/></td>
			<td><xsl:value-of select="Acheteur"/></td>
			<td><xsl:value-of select="ModeVente"/></td>
			<td><xsl:value-of select="DateMiseEnLigne"/></td>
		</tr>
	</xsl:for-each>
	</table></center>
	</body>
</html>
</xsl:template>
</xsl:stylesheet>