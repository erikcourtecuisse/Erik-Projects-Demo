
import static javax.swing.SwingConstants.*;
import java.awt.Color;
import java.io.*;
import java.util.*;
import static java.lang.Math.*;


public class ProjetPacman {

	static int Delai = 200;
	static int Infini = 32000;
	
	public static void main(String[] args) {
	//début de Main
		// Initialisation du jeu
		Jeu JeuPacman = new ProjetPacman.Jeu(); 
		JeuPacman.init();
		
		InterfacePacman PacmanBoard = new InterfacePacman(JeuPacman.largeur, JeuPacman.hauteur);
		DrawBoard(JeuPacman, PacmanBoard);  //Demande la creation du plateau de jeu avec les données lues dans un fichier et stockées dans le tableau labyrinthe
		PacmanBoard.dessinerPacmanOuvert(JeuPacman.CePacman.PosX, JeuPacman.CePacman.PosY, JeuPacman.CePacman.Direction);  // Dessine le pacman en position de depart
		PacmanBoard.afficheTexte("                         SCORE : " + JeuPacman.Score  + "                           Timer : " + JeuPacman.TimerMangeable + "                 Il reste " +  JeuPacman.NbFruitRestant + " fruits");  // Affiche le score sur la ligne de texte inférieure du palteau de jeu
		
		for(int i = 1; i < 5; i++){
			PacmanBoard.dessinerFantome(JeuPacman.Ghosts[i].PosX, JeuPacman.Ghosts[i].PosY, JeuPacman.Ghosts[i].CouleurRVB, JeuPacman.Ghosts[i].LastDir);
		}
		
		InitDistJeu(JeuPacman);
		JeuPacman.FantomeMangeable = false;
		JeuPacman.Timer = 60;
		
		/*Teste la fonction CherchePacman
		int Calc = CherchePacman(JeuPacman, 1, 1, 0);
		*/
		
		int Key = PacmanBoard.toucheAppuyee();
		while (Key != CENTER){
			Attendre(Delai);
			switch (Key){
			case WEST:
				if (JeuPacman.labyrinthe[JeuPacman.CePacman.PosX - 1][JeuPacman.CePacman.PosY].Format != 9){
					MoveToWEST(JeuPacman, PacmanBoard, JeuPacman.CePacman.PosX, JeuPacman.CePacman.PosY);
					}
				break;
			case EAST:
				if (JeuPacman.labyrinthe[JeuPacman.CePacman.PosX + 1][JeuPacman.CePacman.PosY].Format != 9){
					MoveToEAST(JeuPacman, PacmanBoard, JeuPacman.CePacman.PosX, JeuPacman.CePacman.PosY);
					}
				break;	
			case NORTH:
				if (JeuPacman.labyrinthe[JeuPacman.CePacman.PosX][JeuPacman.CePacman.PosY - 1].Format != 9){
					MoveToNORTH(JeuPacman, PacmanBoard, JeuPacman.CePacman.PosX, JeuPacman.CePacman.PosY);
				}
				break;	
			case SOUTH:
				if (JeuPacman.labyrinthe[JeuPacman.CePacman.PosX][JeuPacman.CePacman.PosY + 1].Format != 9){
					MoveToSOUTH(JeuPacman, PacmanBoard, JeuPacman.CePacman.PosX, JeuPacman.CePacman.PosY);
				}
				break;				
			}
			
			// Modification et affichage du score
			if (JeuPacman.labyrinthe[JeuPacman.CePacman.PosX][JeuPacman.CePacman.PosY].Format == 1 | JeuPacman.labyrinthe[JeuPacman.CePacman.PosX][JeuPacman.CePacman.PosY].Format == 3){
				JeuPacman.Score = JeuPacman.Score + 10; 
				JeuPacman.NbFruitRestant--;}
			if (JeuPacman.labyrinthe[JeuPacman.CePacman.PosX][JeuPacman.CePacman.PosY].Format == 2 | JeuPacman.labyrinthe[JeuPacman.CePacman.PosX][JeuPacman.CePacman.PosY].Format == 4){
				JeuPacman.Score = JeuPacman.Score + 500; 
				JeuPacman.NbFruitRestant--;
				JeuPacman.TimerMangeable = 50;   // A partir de là les fantomes sont mangeables pendant 50 cycles
				JeuPacman.FantomeMangeable = true; }
			if (JeuPacman.labyrinthe[JeuPacman.CePacman.PosX][JeuPacman.CePacman.PosY].Format == 1 | JeuPacman.labyrinthe[JeuPacman.CePacman.PosX][JeuPacman.CePacman.PosY].Format == 2){
			JeuPacman.labyrinthe[JeuPacman.CePacman.PosX][JeuPacman.CePacman.PosY].Format = 0; }
			if (JeuPacman.labyrinthe[JeuPacman.CePacman.PosX][JeuPacman.CePacman.PosY].Format == 3 | JeuPacman.labyrinthe[JeuPacman.CePacman.PosX][JeuPacman.CePacman.PosY].Format == 4){
			JeuPacman.labyrinthe[JeuPacman.CePacman.PosX][JeuPacman.CePacman.PosY].Format = 5; }
			PacmanBoard.afficheTexte("                         SCORE : " + JeuPacman.Score + "                           Timer : " + JeuPacman.TimerMangeable + "                 Il reste " + JeuPacman.NbFruitRestant + " fruits");					
			
			//teste la collision Pacman vs fantomes
			for (int i = 1; i < 5; i++){
				if (IsCollision(JeuPacman, i)) Collision (JeuPacman, PacmanBoard, i);
				}
			
			//Fait bouger les fantomes et teste la collision
			MoveGhosts(JeuPacman , PacmanBoard );
			for (int i = 1; i < 5; i++){
				if (IsCollision(JeuPacman, i)) Collision (JeuPacman, PacmanBoard, i);
				}
			
			//Teste si le jeu est fini et gagné (tous les fruits sont mangés et nombre de vies >0 )
			if (JeuPacman.NbFruitRestant == 0) {
				PacmanBoard.afficheMessage("C'est gagné !!!!      Votre score est " + JeuPacman.Score);
				System.exit(0);
			}
			
			// Attendre une nouvelle touche enfoncée;
			if (JeuPacman.Timer != 0) JeuPacman.Timer--;
			if (JeuPacman.TimerMangeable != 0) JeuPacman.TimerMangeable--;
			if (JeuPacman.TimerMangeable == 1) { 
				JeuPacman.FantomeMangeable = false;
				JeuPacman.Timer = 60;
			}
			Key = PacmanBoard.toucheAppuyee();
		}
		PacmanBoard.afficheMessage("GAME OVER");
		System.exit(0);  // Arrete le programme inconditionnellement
	} 	//Fin de main() 
	
	static class Jeu{
/*
 * Initialise le Jeu en mémoire
 * Le labyrinthe est constitué de cellules (Cell) qui indiquent si la case est une case où un choix de direction est à faire pour les fantomes
 * 		d'un format de la case (fruit, bonus, vide, mur) ==> Format
 *      d'un Timer qui declenche les départs des fantomes
 *      d'un TimerMangeable qui se décrémente lorsque les fantomes sont mangeable
 *      et de divers variables pour le calcul du plus court chemin
 * Le jeu contient également une représentation du Pacman, avec sa position en X (PoX) en Y (PosY) sa direction et sont nombre de vies
 * ainsi qu'un tableau de 4 fantomes (Ghost[]), les fantomes étant des enregistrements contenant la position (PosX et PosY), la couleur et la direction
 * D'autre part le Jeu à une hauteur et une largeur de labyrinthe et un score qui se mettra à jour lors des divers action du jeu
 *  
 */
		int hauteur;
		int largeur;
		int Score;
		int NbFruitRestant;
		boolean FantomeMangeable;
		int Timer;
		int TimerMangeable;
		Cell labyrinthe [][] ;		
		Pacman CePacman = new Pacman();
		Fantome [] Ghosts = new Fantome [5];

		
		class Cell{
			int Format;
			boolean IsChoice;
			int SourceDist;
			int ButDist;
			int DistWest;
			int DistNorth;
			int DistEast;
			int DistSouth;
			Boolean EvalEnCours;
		}		
		
		class Pacman{
			int PosX;
			int PosY;
			int Direction;
			int Vies;
		}
		
		class Fantome{
			int PosX;
			int PosY;
			int LastDir;
			Color CouleurRVB;
		}
		
		
		public Jeu init(){
			/*
			 * Initailise le jeu avec les données lues dans un fichier texte
			 */
			try{
				BufferedReader br = null;
				try {
				br = new BufferedReader(new FileReader("C:\\Users\\Alain\\workspace\\Pacman\\src\\grille.pacman.txt"));
				} catch (FileNotFoundException e){
					System.out.println("Fichier introuvable... ");
				}
				String s = br.readLine();
				this.largeur = Integer.parseInt(s.substring(10,12));
				s = br.readLine();
				this.hauteur = Integer.parseInt(s.substring(10,12));
				this.labyrinthe = new Cell [this.largeur][this.hauteur];
				s = br.readLine();
				for(int i = 0; i < this.hauteur; i++){
					s = br.readLine();
					String [] t = s.split(" ");
					for (int k=0; k < this.largeur; k++){
						this.labyrinthe[k][i] = new Cell();
						this.labyrinthe[k][i].Format = Integer.parseInt(t[k]);}}
				
				//Lecture de la ligne contenant les infos du Pacman et initialisation de celui ci
				s = br.readLine();

				this.CePacman.PosX = Integer.parseInt(s.substring(9,11));
				this.CePacman.PosY = Integer.parseInt(s.substring(12,14));
				this.CePacman.Direction = Integer.parseInt(s.substring(15,16));
				this.CePacman.Vies = Integer.parseInt(s.substring(17));
				
				//Lecture des lignes qui décrivent les fantomes et initialisation du tableau les représentant
				for (int i = 1 ; i < 5; i++){
					s = br.readLine();
					this.Ghosts[i] = new Fantome();					
					this.Ghosts[i].PosX = Integer.parseInt(s.substring(12,14));
					this.Ghosts[i].PosY = Integer.parseInt(s.substring(15,17));
					this.Ghosts[i].LastDir = EAST;
					this.Ghosts[i].CouleurRVB = new Color(Integer.parseInt(s.substring(20,23)), Integer.parseInt(s.substring(24,27)), Integer.parseInt(s.substring(28,31)));
					//this.Ghosts[i].Mangeable = false;
				} 
			} // fin de try statement
			catch (IOException e){
				System.out.println("Probleme de declaration de Buffer... ");}
			this.Score = 0;
				return this; }
			} //Fin de la déclaration de la Classe Jeu
	
	static void Attendre(int n){
		/*
		 * Cette procédure perd du temps en fonction ==> n milli-secondes
		 */
		try{Thread.sleep(n);}
		catch(InterruptedException e){}
	}
	
	static void DrawBoard(Jeu Game, InterfacePacman Board){
		/*
		 * Cette procédure dessine la fénêtre du jeu en utilisant le package fourni
		 */
		Game.NbFruitRestant = 0;
		for(int u = 0; u < Game.hauteur; u++){
			for(int v = 0; v < Game.largeur; v++){
			switch (Game.labyrinthe[v][u].Format){
				case 0: {                            //La case est vide
					Board.effaceCase(v, u);
					Game.labyrinthe[v][u].IsChoice = false;
					break;
				}
				case 1: {								//La case contient un fruit
					Board.dessinerFruit(v, u);
					Game.labyrinthe[v][u].IsChoice = false;
					Game.NbFruitRestant++;
					break;
				}
				case 2: {								//La case contient un bonus
					Board.dessinerBonus(v, u);
					Game.labyrinthe[v][u].IsChoice = false;
					Game.NbFruitRestant++;
					break;
				}
				case 3:{
					Board.dessinerFruit(v, u);		//La case contient un fruit
					Game.labyrinthe[v][u].IsChoice = true;     //Cette case provoque un choix dans le mouvement des fantômes
					Game.NbFruitRestant++;
					break;
				}
				case 4:{
					Board.dessinerBonus(v, u);		//La case contient un bonus
					Game.labyrinthe[v][u].IsChoice = true;     //Cette case provoque un choix dans le mouvement des fantômes
					Game.NbFruitRestant++;
					break;
				}
				case 5: {
					Board.effaceCase(v, u);			//La case est vide
					Game.labyrinthe[v][u].IsChoice = true;     //Cette case provoque un choix dans le mouvement des fantômes							
					break;
				}
				case 9:								//La case est un obstacle
					Board.dessinerObstacle(v, u);
					break;
				} } }
	}
	
	static void MoveToWEST(Jeu Game, InterfacePacman Board, int x, int y){
		/*
		 * Cette procédure déplace le Pacman à l'Ouest
		 */
		Board.dessinerPacmanFerme(x, y);
		Attendre(Delai);
		Game.CePacman.PosX = Game.CePacman.PosX -1;
		if (Game.CePacman.PosX == 0){
			Game.CePacman.PosX = Game.largeur -1;
			Game.CePacman.Direction = WEST;
			Board.dessinerPacmanOuvert(Game.CePacman.PosX, Game.CePacman.PosY, Game.CePacman.Direction);
			Board.effaceCase(1, Game.CePacman.PosY);						
		} else {
		Game.CePacman.Direction = WEST;
		Board.dessinerPacmanOuvert(Game.CePacman.PosX, Game.CePacman.PosY, Game.CePacman.Direction);
		Board.effaceCase(Game.CePacman.PosX +1, Game.CePacman.PosY);
	} } 
	
	static void MoveToEAST(Jeu Game, InterfacePacman Board, int x, int y){
		/*
		 * Cette procédure déplace le Pacman à l'Est
		 */
		Board.dessinerPacmanFerme(Game.CePacman.PosX, Game.CePacman.PosY);
		Attendre(Delai);
		Game.CePacman.PosX = Game.CePacman.PosX +1;
		if (Game.CePacman.PosX  == Game.largeur -1){
			Game.CePacman.PosX = 0;
			Game.CePacman.Direction = EAST;
			Board.dessinerPacmanOuvert(Game.CePacman.PosX, Game.CePacman.PosY, Game.CePacman.Direction);
			Board.effaceCase(Game.largeur - 2, Game.CePacman.PosY);						
		} else {					
		Game.CePacman.Direction = EAST;
		Board.dessinerPacmanOuvert(Game.CePacman.PosX, Game.CePacman.PosY, Game.CePacman.Direction);
		Board.effaceCase(Game.CePacman.PosX - 1, Game.CePacman.PosY);
	} }
	
	static void MoveToNORTH(Jeu Game, InterfacePacman Board, int x, int y){
		/*
		 * Cette procédure déplace le Pacman au Nord
		 */
		Board.dessinerPacmanFerme(Game.CePacman.PosX, Game.CePacman.PosY);
		Attendre(Delai);
		Game.CePacman.PosY = Game.CePacman.PosY -1;
		Game.CePacman.Direction = NORTH;
		Board.dessinerPacmanOuvert(Game.CePacman.PosX, Game.CePacman.PosY, Game.CePacman.Direction);
		Board.effaceCase(Game.CePacman.PosX, Game.CePacman.PosY + 1);
	}
	
	static void MoveToSOUTH(Jeu Game, InterfacePacman Board, int x, int y){
		/*
		 * Cette procédure déplace le Pacman au Sud
		 */
		Board.dessinerPacmanFerme(Game.CePacman.PosX, Game.CePacman.PosY);
		Attendre(Delai);
		Game.CePacman.PosY = Game.CePacman.PosY +1;
		Game.CePacman.Direction = SOUTH;
		Board.dessinerPacmanOuvert(Game.CePacman.PosX, Game.CePacman.PosY, Game.CePacman.Direction);
		Board.effaceCase(Game.CePacman.PosX, Game.CePacman.PosY -1);
	}
	
	static void Collision (Jeu Game, InterfacePacman Board , int i){
		/*
		 * Cette procédure gére les collisions.
		 * Si les fantomes sont mangeable ils retournent au placard et le score est incrémenté,
		 * sinon tous les fantomes sont renvoyés au placard, le pacman au lieu de départ, le jeu se pause et indique les vies restantes
		 */
		if (Game.FantomeMangeable) {
			System.out.println("Je le mange !!!");
			Board.effaceCase(Game.Ghosts[i].PosX, Game.Ghosts[i].PosY);
			switch (i){
			case 1 : {
				Game.Ghosts[i].PosX = 11;
				Game.Ghosts[i].PosY = 14;
				Game.Ghosts[i].LastDir = WEST;
				Board.dessinerFantomeMangeable(11, 14);
			} break;
			case 2 : {
				Game.Ghosts[i].PosX = 13;
				Game.Ghosts[i].PosY = 14;
				Game.Ghosts[i].LastDir = WEST;
				Board.dessinerFantomeMangeable(13, 14);
			} break;
			case 3 : {
				Game.Ghosts[i].PosX = 15;
				Game.Ghosts[i].PosY = 14;
				Game.Ghosts[i].LastDir = WEST;
				Board.dessinerFantomeMangeable(15, 14);
			} break;
			case 4 : {
				Game.Ghosts[i].PosX = 13;
				Game.Ghosts[i].PosY = 11;
				Game.Ghosts[i].LastDir = WEST;
				Board.dessinerFantomeMangeable(13, 11);
			} break; }
			Game.Score = Game.Score + 1000;
		} else {
			System.out.println("Le Vilain Fantome me mange !!!");
			Game.CePacman.Vies--;
			if (Game.CePacman.Vies == 0) {
				Board.afficheMessage("GAME OVER");
				System.exit(0);  // arrete le programme inconditionnellement
			} else {
				Board.afficheMessage("Plus que " + Game.CePacman.Vies + " Vies");
				for (int j=1; j < 5; j++) {
					Board.effaceCase(Game.Ghosts[j].PosX, Game.Ghosts[j].PosY);
					switch (j){
					case 1 : {
						Game.Ghosts[j].PosX = 11;
						Game.Ghosts[j].PosY = 14;
						Game.Ghosts[j].LastDir = WEST;
						Board.dessinerFantome(11, 14, Game.Ghosts[j].CouleurRVB, Game.Ghosts[j].LastDir );
					} break;
					case 2 : {
						Game.Ghosts[j].PosX = 13;
						Game.Ghosts[j].PosY = 14;
						Game.Ghosts[j].LastDir = WEST;
						Board.dessinerFantome(13, 14, Game.Ghosts[j].CouleurRVB, Game.Ghosts[j].LastDir );
					} break;
					case 3 : {
						Game.Ghosts[j].PosX = 15;
						Game.Ghosts[j].PosY = 14;
						Game.Ghosts[j].LastDir = WEST;
						Board.dessinerFantome(15, 14, Game.Ghosts[j].CouleurRVB, Game.Ghosts[j].LastDir );
					} break;
					case 4 : {
						Game.Ghosts[j].PosX = 13;
						Game.Ghosts[j].PosY = 11;
						Game.Ghosts[j].LastDir = WEST;
						Board.dessinerFantome(13, 11, Game.Ghosts[j].CouleurRVB, Game.Ghosts[j].LastDir );
					} break; }
					Game.CePacman.PosX = 14;
					Game.CePacman.PosY = 23;
					Board.dessinerPacmanOuvert(14, 23, WEST);
					Game.Timer = 90;
				}
			}
		} }
	
	static int RandomDir(){
		// retourne une valeure parmi l'ensemble (1, 3, 5, 7) qui représente les 4 valeurs des points cardinaux (1=NORTH, 3=EAST, 5=SOUTH, 7=WEST)
		    Random rand = new Random();
		    int randomNum = 2 * rand.nextInt(4) + 1;
		    return randomNum;
	}
	
	static boolean IsFreeGhost (Jeu Game, int i){
		// Verifie que le fantome n'est pas au placard... Renvoie true si le fantome n'est pas en zone de départ
		Boolean Result = true;
		if ((Game.Ghosts[i].PosX >= 10 & Game.Ghosts[i].PosX <= 17) & (Game.Ghosts[i].PosY >= 12 & Game.Ghosts[i].PosY <= 16))
			Result = false;
		return Result;
	}
	
	static void EffaceFantome (Jeu Game, InterfacePacman Board, int X, int Y){
		/*
		 * Efface le fantome et remet la case comme elle était avant l'affichage du fantome
		 */
		if(Game.labyrinthe[X][Y].Format == 0 | Game.labyrinthe[X][Y].Format == 5){
			Board.effaceCase(X, Y); }
		if(Game.labyrinthe[X][Y].Format == 1 | Game.labyrinthe[X][Y].Format == 3){
			Board.dessinerFruit(X, Y); }	
		if(Game.labyrinthe[X][Y].Format == 2 | Game.labyrinthe[X][Y].Format == 4){
			Board.dessinerBonus(X, Y); }
	}
	
	static void GoGhost(Jeu Game, InterfacePacman Board, int i, int Direction){
		/*
		 * Cette procédure gére les déplacements visuels des fantomes dans l'interface
		 */
		switch (Direction) {
		case NORTH: {
			if (Game.labyrinthe[Game.Ghosts[i].PosX][Game.Ghosts[i].PosY - 1].Format != 9){
				//Efface le fantome et remet la case en état
				EffaceFantome(Game, Board, Game.Ghosts[i].PosX, Game.Ghosts[i].PosY);
				//affiche le fantome dans sa nouvelle case
				Game.Ghosts[i].LastDir = NORTH;
				Game.Ghosts[i].PosY = Game.Ghosts[i].PosY - 1;
				if (!Game.FantomeMangeable) {Board.dessinerFantome(Game.Ghosts[i].PosX, Game.Ghosts[i].PosY, Game.Ghosts[i].CouleurRVB, Game.Ghosts[i].LastDir);
				} else {Board.dessinerFantomeMangeable(Game.Ghosts[i].PosX, Game.Ghosts[i].PosY); }
			} }
		break;
		case EAST: {
			if (Game.labyrinthe[Game.Ghosts[i].PosX + 1][Game.Ghosts[i].PosY].Format != 9 & Game.Ghosts[i].PosX + 1 < Game.largeur - 1){
				//Efface le fantome et remet la case en état
				EffaceFantome(Game, Board, Game.Ghosts[i].PosX, Game.Ghosts[i].PosY);
				//affiche le fantome dans sa nouvelle case
				Game.Ghosts[i].LastDir = EAST;
				Game.Ghosts[i].PosX = Game.Ghosts[i].PosX + 1;
				if (!Game.FantomeMangeable) {Board.dessinerFantome(Game.Ghosts[i].PosX, Game.Ghosts[i].PosY, Game.Ghosts[i].CouleurRVB, Game.Ghosts[i].LastDir);
				} else {Board.dessinerFantomeMangeable(Game.Ghosts[i].PosX, Game.Ghosts[i].PosY); }		
			} }
		break;
		case SOUTH: {
			if (Game.labyrinthe[Game.Ghosts[i].PosX][Game.Ghosts[i].PosY + 1].Format != 9){
				//Efface le fantome et remet la case en état
				EffaceFantome(Game, Board, Game.Ghosts[i].PosX, Game.Ghosts[i].PosY);
				//affiche le fantome dans sa nouvelle case
				Game.Ghosts[i].LastDir = SOUTH;
				Game.Ghosts[i].PosY = Game.Ghosts[i].PosY + 1;
				if (!Game.FantomeMangeable) {Board.dessinerFantome(Game.Ghosts[i].PosX, Game.Ghosts[i].PosY, Game.Ghosts[i].CouleurRVB, Game.Ghosts[i].LastDir);
				} else {Board.dessinerFantomeMangeable(Game.Ghosts[i].PosX, Game.Ghosts[i].PosY); }	
			} }
		break;
		case WEST: {
			if (Game.labyrinthe[Game.Ghosts[i].PosX - 1][Game.Ghosts[i].PosY].Format != 9 & Game.Ghosts[i].PosX - 1 > 0){
				//Efface le fantome et remet la case en état
				EffaceFantome(Game, Board, Game.Ghosts[i].PosX, Game.Ghosts[i].PosY);
				//affiche le fantome dans sa nouvelle case
				Game.Ghosts[i].LastDir = WEST;
				Game.Ghosts[i].PosX = Game.Ghosts[i].PosX - 1;
				if (!Game.FantomeMangeable) {Board.dessinerFantome(Game.Ghosts[i].PosX, Game.Ghosts[i].PosY, Game.Ghosts[i].CouleurRVB, Game.Ghosts[i].LastDir);
				} else {Board.dessinerFantomeMangeable(Game.Ghosts[i].PosX, Game.Ghosts[i].PosY); }		
			} } 
		break;
		}
	}
	
	static void MoveGhosts(Jeu Game, InterfacePacman Board){
		/*
		 * cette procédure gére les mouvements des fantomes en mémoire
		 * et appelle la procédure GoGost pour provoquer l'affichage
		 */
		for (int i = 1; i < 5; i++) {
			switch (i) {
				case 1: {
					// Ce fantôme se déplace aléatoirement, si le chemin choisi est impossible il reste immobile
						if(IsFreeGhost(Game, i)){
							if (Game.labyrinthe[Game.Ghosts[i].PosX][Game.Ghosts[i].PosY].IsChoice){
							int Direction = RandomDir();
							GoGhost(Game, Board, i, Direction);
							} else { GoGhost(Game, Board, i, Game.Ghosts[i].LastDir);}
						} else {
								if (Game.Timer == 40){
									Board.effaceCase(Game.Ghosts[i].PosX, Game.Ghosts[i].PosY);
									Game.Ghosts[i].PosX = 13;
									Game.Ghosts[i].PosY = 11;
						} } }
				break;
				case 2:{
					// Ce fantôme se rapproche de Pacman en X de préférence
					if(IsFreeGhost(Game, i)){
						if (Game.labyrinthe[Game.Ghosts[i].PosX][Game.Ghosts[i].PosY].IsChoice){
							/* if(Game.Ghosts[i].PosX >= Game.CePacman.PosX & Game.labyrinthe[Game.Ghosts[i].PosX - 1][Game.Ghosts[i].PosY].Format != 9) 
								GoGhost(Game, Board, i, WEST);
							if (Game.Ghosts[i].PosX >= Game.CePacman.PosX & Game.labyrinthe[Game.Ghosts[i].PosX - 1][Game.Ghosts[i].PosY].Format == 9){
								if (Game.labyrinthe[Game.Ghosts[i].PosX][Game.Ghosts[i].PosY + 1].Format != 9) GoGhost(Game, Board, i, SOUTH); 
								else GoGhost(Game, Board, i, NORTH);}
							if(Game.Ghosts[i].PosX < Game.CePacman.PosX & Game.labyrinthe[Game.Ghosts[i].PosX + 1][Game.Ghosts[i].PosY].Format != 9) 
								GoGhost(Game, Board, i, EAST);
							if (Game.Ghosts[i].PosX < Game.CePacman.PosX & Game.labyrinthe[Game.Ghosts[i].PosX + 1][Game.Ghosts[i].PosY].Format == 9){
								if (Game.labyrinthe[Game.Ghosts[i].PosX][Game.Ghosts[i].PosY + 1].Format != 9) GoGhost(Game, Board, i, SOUTH); 
								else GoGhost(Game, Board, i, NORTH);} */
							int Direction = RandomDir();
							GoGhost(Game, Board, i, Direction);
					} else { GoGhost(Game, Board, i, Game.Ghosts[i].LastDir);}
				} else {
					if (Game.Timer == 20){
						Board.effaceCase(Game.Ghosts[i].PosX, Game.Ghosts[i].PosY);
						Game.Ghosts[i].PosX = 13;
						Game.Ghosts[i].PosY = 11;
				} } }
				break;
				case 3:{
					// Ce fantôme se rapproche de Pacman en Y de préférence
					if(IsFreeGhost(Game, i)){
						if (Game.labyrinthe[Game.Ghosts[i].PosX][Game.Ghosts[i].PosY].IsChoice){
							/* if(Game.Ghosts[i].PosY >= Game.CePacman.PosY & Game.labyrinthe[Game.Ghosts[i].PosY - 1][Game.Ghosts[i].PosY].Format != 9) 
								GoGhost(Game, Board, i, NORTH);
							if (Game.Ghosts[i].PosY >= Game.CePacman.PosX & Game.labyrinthe[Game.Ghosts[i].PosY - 1][Game.Ghosts[i].PosY].Format == 9){
								if (Game.labyrinthe[Game.Ghosts[i].PosX + 1][Game.Ghosts[i].PosY].Format != 9) GoGhost(Game, Board, i, EAST); 
								else GoGhost(Game, Board, i, WEST);}
							if(Game.Ghosts[i].PosY < Game.CePacman.PosX & Game.labyrinthe[Game.Ghosts[i].PosY + 1][Game.Ghosts[i].PosY].Format != 9) 
								GoGhost(Game, Board, i, SOUTH);
							if (Game.Ghosts[i].PosY < Game.CePacman.PosX & Game.labyrinthe[Game.Ghosts[i].PosY + 1][Game.Ghosts[i].PosY].Format == 9){
								if (Game.labyrinthe[Game.Ghosts[i].PosX + 1][Game.Ghosts[i].PosY].Format != 9) GoGhost(Game, Board, i, EAST); 
								else GoGhost(Game, Board, i, WEST);} */
							int Direction = RandomDir();
							GoGhost(Game, Board, i, Direction);
					} else { GoGhost(Game, Board, i, Game.Ghosts[i].LastDir);}
				} else {
					if (Game.Timer == 1){
						Board.effaceCase(Game.Ghosts[i].PosX, Game.Ghosts[i].PosY);
						Game.Ghosts[i].PosX = 13;
						Game.Ghosts[i].PosY = 11;
				} } }
				break;
				case 4: {
					// Ce fantôme cherche le chemin le plus court vers Pacman
					if(IsFreeGhost(Game, i)){
						if (Game.labyrinthe[Game.Ghosts[i].PosX][Game.Ghosts[i].PosY].IsChoice){
						int Direction = RandomDir();
						GoGhost(Game, Board, i, Direction);
						} else { GoGhost(Game, Board, i, Game.Ghosts[i].LastDir);}
					} else {
							if (Game.Timer == 60){
								Board.effaceCase(Game.Ghosts[i].PosX, Game.Ghosts[i].PosY);
								Game.Ghosts[i].PosX = 13;
								Game.Ghosts[i].PosY = 11;
					} } }
				break;		
			} } }
	
	static void InitDistJeu(Jeu Game){
		/*
		 * Cette procédure initialise les variables servant à gérer la recherche du chemin le plus court
		 */
		for(int i = 0; i < Game.hauteur; i++){
			for(int j = 0; j < Game.largeur; j++){
				Game.labyrinthe[j][i].DistWest = 0;
				Game.labyrinthe[j][i].DistNorth = 0;
				Game.labyrinthe[j][i].DistEast = 0;
				Game.labyrinthe[j][i].DistSouth = 0;
				Game.labyrinthe[j][i].SourceDist = 0;
				Game.labyrinthe[j][i].ButDist = 32000;
				Game.labyrinthe[j][i].EvalEnCours = false;				
			} } }
	
	static int CherchePacman(Jeu Game, int PosX, int PosY, int Distance){
		/*
		 * Fonction recursive qui tente de calculer le plus court chemin pour aller d'une case donée en argument au Pacman
		 * 
		 * Si je suis au bord alors infini dans cette direction
		 * si je suis contre un obstacle alors infini dans cette direction
		 * si case suivante déjà en cours d'éval alors infini dans cette direction
		 * si case suivante contient le pacman alors retourne 1
		 * si la case suivante n'a pas été évaluée je lance l'évaluation sur cette case
		 * dans les autres cas
		 * 		si la distance à la source de la case suivante est > à la distance à la source de la case actuelle alors 
		 * 				distance au but = distance au but de la case suivante +1
		 * 		sinon la distance est plus petite par l'autre chemin donc distance au but = infini
		 * 
		 * La fonction renvoie la distance au but
		 */
		int DistanceAuBut = 0;
		Game.labyrinthe[PosX][PosY].SourceDist = Distance + 1;
		Game.labyrinthe[PosX][PosY].EvalEnCours = true;
		
		//cas WEST
		if (PosX - 1 < 0 || Game.labyrinthe[PosX-1][PosY].Format == 9 || Game.labyrinthe[PosX-1][PosY].EvalEnCours){
			Game.labyrinthe[PosX][PosY].DistWest = Infini;
		} else {
			if (Game.CePacman.PosX == PosX-1 & Game.CePacman.PosY == PosY){
				Game.labyrinthe[PosX][PosY].DistWest = 1;
			} else{
				if (Game.labyrinthe[PosX-1][PosY].SourceDist == 0){
					System.out.println("Go " + (PosX-1) + " " + PosY);
					Game.labyrinthe[PosX][PosY].DistWest = CherchePacman(Game, PosX-1, PosY, Game.labyrinthe[PosX][PosY].SourceDist) + 1;
				} else {
					if (Game.labyrinthe[PosX-1][PosY].SourceDist >= Game.labyrinthe[PosX][PosY].SourceDist) {
						Game.labyrinthe[PosX][PosY].DistWest = Game.labyrinthe[PosX-1][PosY].ButDist + 1;
					} else {
						Game.labyrinthe[PosX][PosY].DistWest = Infini;
					}
			} }
		}
		System.out.println(PosX + " " + PosY + " West " + Game.labyrinthe[PosX][PosY].DistWest + " Source: " + Game.labyrinthe[PosX][PosY].SourceDist + " But: " + Game.labyrinthe[PosX][PosY].ButDist);
		
		//Cas NORTH
		if (PosY - 1 < 0 || Game.labyrinthe[PosX][PosY-1].Format == 9 || Game.labyrinthe[PosX][PosY-1].EvalEnCours){
			Game.labyrinthe[PosX][PosY].DistNorth = Infini;
		} else {
			if (Game.CePacman.PosX == PosX & Game.CePacman.PosY == PosY-1){
				Game.labyrinthe[PosX][PosY].DistNorth = 1;
			} else{
				if (Game.labyrinthe[PosX][PosY-1].SourceDist == 0){
					System.out.println("Go " + PosX + " " + (PosY - 1));
					Game.labyrinthe[PosX][PosY].DistNorth = CherchePacman(Game, PosX, PosY-1, Game.labyrinthe[PosX][PosY].SourceDist) + 1;
				} else {
					if (Game.labyrinthe[PosX][PosY-1].SourceDist >= Game.labyrinthe[PosX][PosY].SourceDist) {
						Game.labyrinthe[PosX][PosY].DistNorth = Game.labyrinthe[PosX][PosY-1].ButDist + 1;
					} else {
						Game.labyrinthe[PosX][PosY].DistNorth = Infini;
					}
			} }
		}		
		System.out.println(PosX + " " + PosY + " North " + Game.labyrinthe[PosX][PosY].DistNorth + " Source: " + Game.labyrinthe[PosX][PosY].SourceDist + " But: " + Game.labyrinthe[PosX][PosY].ButDist);
		
		//cas EAST
		if (PosX + 1 >= Game.largeur || Game.labyrinthe[PosX+1][PosY].Format == 9 || Game.labyrinthe[PosX+1][PosY].EvalEnCours){
			Game.labyrinthe[PosX][PosY].DistEast = Infini;
		} else {
			if (Game.CePacman.PosX == PosX+1 & Game.CePacman.PosY == PosY){
				Game.labyrinthe[PosX][PosY].DistEast = 1;
			} else{
				if (Game.labyrinthe[PosX+1][PosY].SourceDist == 0){
					System.out.println("Go " + (PosX+1) + " " + PosY);
					Game.labyrinthe[PosX][PosY].DistEast = CherchePacman(Game, PosX+1, PosY, Game.labyrinthe[PosX][PosY].SourceDist) + 1;
				} else {
					if (Game.labyrinthe[PosX+1][PosY].SourceDist >= Game.labyrinthe[PosX][PosY].SourceDist) {
						Game.labyrinthe[PosX][PosY].DistEast = Game.labyrinthe[PosX+1][PosY].ButDist + 1;
					} else {
						Game.labyrinthe[PosX][PosY].DistEast = Infini;
					}
			} }
		}	
		System.out.println(PosX + " " + PosY + " East " + Game.labyrinthe[PosX][PosY].DistEast + " Source: " + Game.labyrinthe[PosX][PosY].SourceDist + " But: " + Game.labyrinthe[PosX][PosY].ButDist);
		
		//Cas SOUTH
		if (PosY + 1 >= Game.hauteur || Game.labyrinthe[PosX][PosY+1].Format == 9 || Game.labyrinthe[PosX][PosY+1].EvalEnCours){
			Game.labyrinthe[PosX][PosY].DistSouth = Infini;
		} else {
			if (Game.CePacman.PosX == PosX & Game.CePacman.PosY == PosY+1){
				Game.labyrinthe[PosX][PosY].DistSouth = 1;
			} else{
				if (Game.labyrinthe[PosX][PosY+1].SourceDist == 0){
					System.out.println("Go " + PosX + " " + (PosY + 1));
					Game.labyrinthe[PosX][PosY].DistSouth = CherchePacman(Game, PosX, PosY+1, Game.labyrinthe[PosX][PosY].SourceDist) + 1;
				} else {
					if (Game.labyrinthe[PosX][PosY+1].SourceDist >= Game.labyrinthe[PosX][PosY].SourceDist) {
						Game.labyrinthe[PosX][PosY].DistSouth = Game.labyrinthe[PosX][PosY+1].ButDist + 1;
					} else {
						Game.labyrinthe[PosX][PosY].DistSouth = Infini;
					}
			} }
		}		
		DistanceAuBut = min(Game.labyrinthe[PosX][PosY].DistSouth, min(Game.labyrinthe[PosX][PosY].DistEast, min(Game.labyrinthe[PosX][PosY].DistNorth,Game.labyrinthe[PosX][PosY].DistWest)));
		Game.labyrinthe[PosX][PosY].EvalEnCours = false;
		return DistanceAuBut;
	}
	
	static boolean IsCollision (Jeu Game, int i){
		/*
		 * cette fonction vérifie s'il y a collision entre fantome i et pacman, retourne vraie si c'est le cas
		 */
		boolean result = false;
		if ( (Game.Ghosts[i].PosX == Game.CePacman.PosX) & (Game.Ghosts[i].PosY == Game.CePacman.PosY)) {
			result = true;
		}
		return result;
	}
	
	//Fin de la classe ProjetPacman
	}
