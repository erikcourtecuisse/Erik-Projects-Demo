package models;

import java.awt.Point;

/**
 * Model contenant les types de lignes
 * @author PCPack
 *
 */
public class TypeLine {
	private int id;
	private String name;
	private int nombrePersonneMaxParTransport;
	
	/**
	 * Consturcteur unique
	 * @param id
	 * @param name
	 * @param nombrePersonneMaxParTransport 
	 */
	public TypeLine(int id, String name, int nombrePersonneMaxParTransport){
		this.id = id;
		this.name = name;
		this.nombrePersonneMaxParTransport = nombrePersonneMaxParTransport;
	}
	
	// *************************************
	// GETTER
	// *************************************	
	public int getId() {
		return this.id;
	}
	
	public int getNombrePersonneMaxParTransport(){
		return this.nombrePersonneMaxParTransport;
	}
	
	// *************************************
	// OTHER METHOD
	// *************************************	
	public String toString(){
		return "id:" + this.id + " name:" + this.name; 
	}
}
