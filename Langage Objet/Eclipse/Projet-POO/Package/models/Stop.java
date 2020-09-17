package models;

import java.util.ArrayList;
import display.Displayable;

/**
 * Model contenant les détails de chaque stop
 * @author PCPack
 *
 */
public class Stop {
	private int id; // Id
	private String name; // Nom de repére
	private Zone zone; // Endroit ou se trouve l'arret
	private TypeLine type; // Type de ligne auquel il correspond
	private Displayable displayable; // Objet graphique 
	private ArrayList<Trajet> pepoleWithTrajet; // Liste des personne en attente a l'arret
	
	/**
	 * Constructeur unique
	 * @param idT
	 * @param nameT
	 * @param zone
	 * @param type
	 */
	public Stop(int id, String name, Zone zone, TypeLine type) {
		this.id = id;
		this.name = name;
		this.zone = zone;
		this.type = type;
		this.displayable = null; // Il sera ajouté au premier affichage
		this.pepoleWithTrajet = new ArrayList<Trajet>();
	}

	// *************************************
	// GETTER
	// *************************************	
	public Displayable getDisplayable(){
		return this.displayable;
	}
	
	public ArrayList<Trajet> getPeople(){
		return this.pepoleWithTrajet;
	}
	
	public int getId(){
		return this.id;
	}

	public Zone getZone() {
		return this.zone;
	}
	
	public TypeLine getType() {
		return type;
	}
	public String getName() {
		return this.name;
	}
	
	// *************************************
	// SETTER
	// *************************************
	public void setHisDisplayable(Displayable d) {
		this.displayable = d;
	}
	
	public void addPeople(Trajet tj) {
		// Ajoute des personnes a l'arret
		this.pepoleWithTrajet.add(tj);
	}

	// *************************************
	// OTHER METHODS
	// *************************************
	public String toString(){
		return "id:" + this.id + ", name:" + this.name + ", zone:{" + this.zone.toString() + "}, type:{" + this.type.toString() + "}"; 
	}
}
