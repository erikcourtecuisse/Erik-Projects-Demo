package display;

/** Cette interface d&eacute;crit les objets pouvant s'afficher sur une zone de dessin par une forme color&eacute;e et une chaine de caract&egrave;res
  *  dont on pr&eacute;cise la position absolue (dans le meme syst&ecirc;me de coordonn&eacute;es que la forme). */
public interface Displayable{
	public java.awt.Shape getShape();
	public java.awt.Color getColor();
	public String getString();
	public java.awt.Point getStringPosition();
}
