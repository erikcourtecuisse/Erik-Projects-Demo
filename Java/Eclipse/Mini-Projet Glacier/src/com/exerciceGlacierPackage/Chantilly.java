package com.exerciceGlacierPackage;

public class Chantilly extends DecorateurTopping{

	public Chantilly(Dessert d){
		dessert = d;
	}
	
	
	public String getDescription() {
		return dessert.getDescription() + " - chantilly";
	}

	
	public double getPrix() {
		return dessert.getPrix()+0.50;
	}

	public String getNomTopping() {
		return dessert.getDescription() + "supplement Chantilly";
	}

}
