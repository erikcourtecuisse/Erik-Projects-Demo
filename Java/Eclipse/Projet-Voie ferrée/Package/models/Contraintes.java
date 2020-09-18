package models;

import java.awt.Point;

/**
 * Lieu de déplacement des personnes
 * @author PCPack
 *
 */
public class Contraintes{
	private int id; // Id
	private String name; // Nom de repére
	private Zone zone; // Zone ou se situe le lieu
	private long heureDebut; // Heure ou les personnes partent
	private long heureFin; // Heure ou les personnes s'en vont
	
	private long nombreVisiteur; // Nombre de visiteur

	public Contraintes(int id, String name, Zone zone, long heureDebut, long heureFin, int nombreVisiteur) {
		this.id = id;
		this.name = name;
		this.zone = zone;
		this.heureDebut = heureDebut;
		this.heureFin = heureFin;
		this.nombreVisiteur = nombreVisiteur;
	}
	
	// *************************************
	// GETTER
	// *************************************	
	public Zone getZone() {
		return this.zone;
	}

	public long getHeureDebut() {
		return this.heureDebut;
	}
	
	public long getHeureFin() {
		return this.heureFin;
	}
	
	// *************************************
	// OTHER METHOD
	// *************************************	
	public String toString(){
		return "id:" + this.id + ", name:" + this.name + ", zone:{" + this.zone.toString()  + "}, heureDebut:" + this.heureDebut  + ", heureFin:" + this.heureFin + ", nombreVisiteur:" + this.nombreVisiteur; 
	}

	public long getNombreVisiteur() {
		return this.nombreVisiteur;
	}
}