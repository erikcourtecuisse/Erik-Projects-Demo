package display;

import java.awt.Color;
import java.awt.Point;
import java.awt.Shape;

/***
 * Objet qui permet d'afficher
 * @author PCPack
 *
 */
public class Objet implements Displayable{
	private Shape s;
	private Color c;
	private String text;
	private Point p;
	
	/**
	 * Constructeur 1 pour afficher uniquement une forme sans texte
	 * @param shape
	 * @param color
	 */
	public Objet(Shape s, Color c){
		this.s = s;
		this.c = c;
		this.text = "";
		this.p = new Point();
	}
	
	/**
	 * Contructeur 2 pour afficher une forme et un texte
	 * @param shape
	 * @param color
	 * @param text
	 * @param point
	 */
	public Objet(Shape s, Color c, String text, Point p){
		this.s = s;
		this.c = c;
		this.text = text;
		this.p = p;
	}
	
	@Override
	public Shape getShape() {
		return this.s;
	}
	
	@Override
	public Color getColor() {
		return this.c;
	}

	@Override
	public String getString() {
		return this.text;
	}

	@Override
	public Point getStringPosition() {
		return this.p;
	}

}
