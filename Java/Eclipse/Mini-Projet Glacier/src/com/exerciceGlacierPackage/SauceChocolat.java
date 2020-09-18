package com.exerciceGlacierPackage;

public class SauceChocolat extends DecorateurTopping{
	
	public SauceChocolat(Dessert d){
		dessert = d;
	}
	
	public String getDescription() {
		return dessert.getDescription() + " - Sauce Chocolat";
	}


	public double getPrix() {
		return dessert.getPrix()+0.70;
	}

	public String getNomTopping() {
		return dessert.getDescription() + " et sa délicieuse sauce chocolat";
	}

}
