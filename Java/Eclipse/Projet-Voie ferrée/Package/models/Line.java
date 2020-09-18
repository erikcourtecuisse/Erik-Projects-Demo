package models;

import java.awt.Color;
import java.util.ArrayList;

/**
 * Model contenant chaque ligne avec ses informations
 * @author PCPack
 *
 */
public class Line{
	private int id; // Identifiant unique de la ligne
	private String name; // Nom de la ligne pour repére
	private TypeLine type; // Type de ligne (Metro, Train, etc...)
	private Stop[] stop; // Liste de ses arrets
	private long frequence; // Fréquence de passage
	private Color color; // Couleur d'affichage
	
	/**
	 * Constructeur unique
	 * @param id
	 * @param name
	 * @param type
	 * @param stop
	 * @param frequence
	 * @param color
	 */
	public Line(int id, String name, TypeLine type, Stop[] stop, long frequence, Color color){
		this.name = name;
		this.id = id;
		this.type = type;
		this.stop = stop;
		this.frequence = frequence;
		this.color = color;
	}
	
	// ****************************************
	// GETTER
	// ****************************************
	public Color getColor(){
		return this.color;
	}
	public long getFrequence(){
		return this.frequence;
	}
	public Stop[] getStops() {
		return this.stop;
	}
	public TypeLine getType(){
		return this.type;
	}
	public String getName() {
		return this.name;
	}
	
	// ****************************************
	// OTHER METHODS
	// ****************************************
	public String toString(){
		return "id:" + this.id + ", name:" + this.name + ", type:{" + this.type.toString() + "}"; 
	}
}
