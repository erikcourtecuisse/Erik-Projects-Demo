package models;

import java.util.ArrayList;
import display.Displayable;

/**
 * Model représentant les transports et leurs informations
 * @author PCPack
 *
 */
public class Transport{
	private int positionX; // Position x
	private int positionY; // position Y
	private Stop[] stop; // Liste des stop ou se rend le transport ten question
	private int vitesse; // Sa vitesse
	private String name; // Son nom
	private int goTo; // Le prochain id ou le bus se rend
	private String nameLine; // Nom de la ligne
	private Displayable displayable; // Sont affichage
	private ArrayList<Trajet> trajetPeople; // Les personnes qui sont dans le bus
	private int capaciteMax;
	
	/**
	 * Constructeur unique
	 * @param i
	 * @param j
	 * @param name
	 * @param k
	 * @param stops
	 * @param nameLine
	 * @param capaciteMax 
	 */
	public Transport(int i, int j, String name, int k, Stop[] stops, String nameLine, int capaciteMax) {
		this.positionX = i;
		this.positionY = j;
		this.name = name;
		this.vitesse = k;
		this.stop = stops;	
		this.goTo = 0;
		this.displayable = null;
		this.nameLine = nameLine;
		this.trajetPeople = new ArrayList<Trajet>();
		this.capaciteMax = capaciteMax;
	}
	
	// *************************************
	// GETTER
	// *************************************		
	public String getNameLine(){
		return this.nameLine;
	}
	
	public int getCapaciteMax(){
		return this.capaciteMax;
	}
	
	public Displayable getDisplayable(){
		return this.displayable;
	}
	
	public Stop[] getStop(){
		return this.stop;
	}
	
	public int getGoTo(){
		return this.goTo;
	}
	
	public int getX(){
		return this.positionX;
	}
	
	public int getY(){
		return this.positionY;
	}

	public int getVitesse() {
		return this.vitesse;
	}
	
	public String getName(){
		return this.name;
	}
	
	public void goToNextStop(){
		this.goTo+=1;
	}

	public void updateX(int toX) {
		this.positionX = toX;
	}
	
	public void updateY(int toY) {
		this.positionY = toY;
	}

	public void setHisDisplayable(Displayable d) {
		this.displayable = d;
	}

	public ArrayList<Trajet> getTrajetPeople() {
		return this.trajetPeople;
	}
}
