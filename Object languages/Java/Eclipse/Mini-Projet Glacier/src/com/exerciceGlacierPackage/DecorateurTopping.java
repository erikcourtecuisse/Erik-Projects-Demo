package com.exerciceGlacierPackage;

public abstract class DecorateurTopping extends Dessert{
	protected Dessert dessert;
	public abstract String getDescription();
	public abstract double getPrix();
	public abstract String getNomTopping();
}
