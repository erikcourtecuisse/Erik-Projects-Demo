package com.exerciceGlacierPackage;

public class FruitsRouges extends CoupeGlace{
	public int numFruitsRouges;
	private static FruitsRouges instance;


	public FruitsRouges(String description, double prix, Parfum parfumGlace){
		this.description = description;
		this.prix = prix;
		this.parfumGlace = parfumGlace;	
	}
	
	
	public static synchronized FruitsRouges getInstance(){
		if (instance == null)
			instance = new FruitsRouges("rouges",6.0,Parfum.CHOCOLAIT);
		return instance;
	}
	

	public String getDescription() {
		return description;
	}
	public double getPrix() {
		return prix;
	}
}
