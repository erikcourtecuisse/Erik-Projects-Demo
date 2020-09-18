package com.exerciceGlacierPackage;

import java.util.ArrayList;

public class Commande {
	public int numCommande;
	public ArrayList<Dessert> listCommande;
	public Clavier clavier;
	
	public Commande(){
		listCommande = new ArrayList<Dessert>();
		clavier = Clavier.getInstance();
	}
	
	public void ticketCommande(){
		//int prixTotal = 0;
		for(Dessert cg : listCommande){
			System.out.println("Coupe " + cg.getDescription() + " Prix : " + cg.getPrix());
			//prixTotal += cg.getPrix();			
		}	
		//System.out.println("Total : " + prixTotal + " euros");
	}
	
	public void enregistrerCommande2(){
		Dessert d;
		do{		
			System.out.println("Veuillez choisir une glace fruit rouge (1) ou triple chocolat (autre chiffre)"); 
			if(clavier.lireInt() == 1){
				d = FruitsRouges.getInstance();	
			} else {
				d = TripleChocolat.getInstance();	
			}
			System.out.println("Voulez-vous des topping ? 1 pour oui"); 
			while(clavier.lireInt() == 1){
				d=ajouterSupplement(d);
				System.out.println("Voulez-vous ajouter d'avatanges de topping ? 1 pour oui"); 
			}
			listCommande.add(d);
			System.out.println("Voulez vous commander une autre glace ? 1 pour oui"); 
		}while(clavier.lireInt() == 1);
	}
	
	public Dessert ajouterSupplement(Dessert dessert){
		System.out.println("Pour ajouter de la chantilly (1), sauce chocolat (2), coulis de fraise (3)");
		int reponse = clavier.lireInt();
		switch(reponse){
		case 1:
			dessert = new Chantilly(dessert);	
			break;			
		case 2:
			dessert = new SauceChocolat(dessert);			
			break;			
		case 3:
			dessert = new CoulisFraise(dessert);
			break;	
		default:			
		}
		return dessert;
	}
}
