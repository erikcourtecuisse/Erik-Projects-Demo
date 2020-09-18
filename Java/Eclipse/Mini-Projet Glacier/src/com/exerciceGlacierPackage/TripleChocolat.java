package com.exerciceGlacierPackage;

public class TripleChocolat extends CoupeGlace{
	private static TripleChocolat instance;
	
	
	public TripleChocolat(String description, double prix, Parfum parfumGlace){
		this.description = description;
		this.prix = prix;
		this.parfumGlace = parfumGlace;
	}
	
	public static synchronized TripleChocolat getInstance(){
		if (instance == null)
			instance = new TripleChocolat("Tres bon",7.0,Parfum.CASSIS);
		return instance;
	}
	
	public void setPrix(float prix){
		 this.prix = prix;
	}
	
	public String getDescription() {
		return description;
	}
	public double getPrix() {
		return prix;
	}
	

}
