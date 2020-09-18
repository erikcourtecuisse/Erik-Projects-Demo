package com.exerciceGlacierPackage;

public abstract class Dessert {
	protected String description;
	protected double prix;
	protected Parfum parfumGlace;
	protected Commande commande;

	public String getDescription() {
		return description;
	}
	public double getPrix() {
		return prix;
	}
}
