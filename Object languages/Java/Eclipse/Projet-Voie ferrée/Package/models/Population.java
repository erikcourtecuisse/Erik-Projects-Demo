package models;

/**
 * Model caractairisant une personne
 * @author PCPack
 */
public class Population{
	private Zone zone; // Zone ou se trouve la personne
	private Contraintes occupation; // L'endroit ou la personne se déplace en général
	private Boolean haveCar; // Si la personne a une voiture ou non
	
	/**
	 * Constructeur d'une personne
	 * @param zone
	 * @param occupation
	 * @param haveCar
	 */
	public Population(Zone zone, Contraintes occupation, Boolean haveCar){
		this.zone = zone;
		this.occupation = occupation;
		this.haveCar = haveCar;
	}

	// ********************************************
	// GETTER
	// ********************************************
	public Contraintes getOccupation() {
		return this.occupation;
	}
	public boolean getHaveCar() {
		return this.haveCar;
	}
	public Zone getZone() {
		return this.zone;
	}

	// ********************************************
	// SETTER
	// ********************************************
	public void setOccupation(Contraintes occupation){
		this.occupation = occupation;
	}
	public void setHaveCar(boolean haveCar){
		this.haveCar = haveCar;
	}
	public void setZone(Zone zone){
		this.zone=zone;
	}
}