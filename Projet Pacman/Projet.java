import java.io.*;

public class Projet{
	
	public static void main(String args[]){
	
	class Jeu{
	InterfacePacman pacman = new InterfacePacman(28, 31);
	int [][] labyrinthe = null;
	
	public Jeu init(){
			Jeu j = new Jeu();
			//FileReader fr = null;
			//BufferedReader br = null;
			//fr = new FileReader("grille.pacman.txt");
			//br = new BufferedReader(fr);
			try {
			BufferedReader br = new BufferedReader(new FileReader("grille.pacman.txt"));
			} catch (FileNotFoundException e){
				System.out.println("File Not Found ");
			}
			String s = br.readLine();
			int l = Integer.parseInt(s.substring(10,12));
			s = br.readLine();
			int h = Integer.parseInt(s.substring(10,12));
			//labyrinthe = new int [l][h];
			//int [][] j.labyrinthe = null;
			s = br.readLine();
			for(int i = 0; i<h; i++){
				s = br.readLine();
				String [] t = s.split(" ");
				for (int k=0; k<l; k++)
					j.labyrinthe[k][i] = Integer.parseInt(t[k]);}
			return j; }
		}
						}
}
