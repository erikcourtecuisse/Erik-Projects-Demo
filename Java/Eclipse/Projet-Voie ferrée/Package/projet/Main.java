package projet;

public class Main{
	/* This is the main method, this instantiate the object Game */
	public static void main (String[] args){
		Game a = new Game();
		
		// Chargement des données du fichier data.xml
		if(a.loadData() == -1){
			System.out.println("Exit with faillure");
		}

		// Génération de la population
		a.createPopulation();
		
		// Lancement du thread game
		try {
			a.runGame();
		} catch (InterruptedException e) {
			System.out.println("Exit with exception : Game.runGame()");
		}
	}
}