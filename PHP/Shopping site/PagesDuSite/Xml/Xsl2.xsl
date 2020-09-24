<?xml version='1.0' encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"/>

<xsl:template match="/">

 <html>
   <head>
     <title>Historique de transactions</title>
     <style type="text/css">
       th {background-color:silver;}
       td {border-style:solid; border-width:1px;}
     </style>
   </head>
   <body>

         <H2>Transactions</H2>
         <table>
        <tr>
            <th>Intitule</th>
            <th>ID Vendeur</th>
            <th>Prix</th>
            <th>ID Acheteur</th>
            <th>Mode de vente</th>
            <th>Date de mise en ligne</th>
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
        </table>
    </body>
    </html>

</xsl:template>
</xsl:stylesheet>