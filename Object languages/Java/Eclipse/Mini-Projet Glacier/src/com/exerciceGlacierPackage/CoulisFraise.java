package com.exerciceGlacierPackage;

public class CoulisFraise extends DecorateurTopping{
	
	public CoulisFraise(Dessert d){
		dessert = d;
	}

	public String getDescription() {
		return dessert.getDescription() + " - Coulis Fraise";
	}

	public double getPrix() {
		return dessert.getPrix()+1.00;
	}

	public String getNomTopping() {
		return dessert.getDescription() + " au coulis de fraises fraîches";
	}

}
