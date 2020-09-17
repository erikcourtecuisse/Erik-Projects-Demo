package models;

import java.awt.Point;

/**
 * Zone dans la ville
 * @author PCPack
 *
 */
public class Zone {
	private int id; // Id unique pour repere
	private String name; // Nom pour repére
	private Point position; // La position XY sur la map
	
	/**
	 * Consturcteur unique
	 * @param id
	 * @param name
	 * @param position
	 */
	public Zone(int id, String name, Point position){
		this.id = id;
		this.name = name;
		this.position = position;
	}
	
	// *************************************
	// GETTER
	// *************************************	
	public Point getPosition(){
		return this.position;
	}
	
	public int getId(){
		return this.id;
	}
	
	// *************************************
	// OTHER METHOD
	// *************************************	
	public String toString(){
		return "id:" + this.id + " name:" + this.name + " position:" + this.position.getX() + "/" + this.position.getY(); 
	}
}
