package models;

public class Trajet {
	private Population p;
	private int start;
	private int end;
	private long heureDebut;
	private long heureFin;
	private int sens;
	private String nameLine;
	
	public Trajet(Population p, int stopStart, int stopEnd, long heureDebut, long heureFin, String nameLine) {
		this.p = p;
		this.start = stopStart;
		this.end = stopEnd;
		this.heureDebut = heureDebut;
		this.heureFin = heureFin;
		this.nameLine = nameLine;
	}
	
	public String getNameLine(){
		return this.nameLine;
	}
	
	public int getStartStop(){
		return this.start;
	}
	
	public int getEndStop(){
		return this.end;
	}
	
	public Population getPersonn(){
		return this.p;
	}
	
	public long getHeureDebut(){
		return this.heureDebut;
	}
	
	public long getHeureFin(){
		return this.heureFin;
	}

	public void setAller() {
		this.sens = 0;
	}
	
	public void setRetour() {
		this.sens = 1;
	}
}

