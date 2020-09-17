package display;

import javax.swing.*;
import java.awt.*;
import java.awt.geom.Rectangle2D;
import java.awt.event.*;
import java.io.IOException;
import java.lang.IllegalArgumentException;
import java.util.ArrayList;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import java.io.File;

/** Fen&ecirc;tre pour l'affichage d'objets de type Affichable et l'interaction souris avec ces objets. L'affichage peut se faire sur un fond color&eacute; ou sur une image. */
public class Gui extends JFrame implements MouseListener{
	
	private int offset = 12;
	private float fontSize = 10.5f;
	private Graphic p;
	private Color bg = null;
	private BufferedImage img = null;
	private ArrayList<Displayable> elements;
	private ArrayList<MouseEvent> clics;
	private JTextField jtf;
	
	/** Cr&eacute;e une JFrame permettant d'afficher sur la couleur de fond sp&eacute;cifi&eacute;e des Affichable ayant des coordonn&eacute;es dans [0..largeur,0..hauteur]. */
	public Gui(String title, int width, int height, Color bg){
		super(title);
		this.elements = new ArrayList<Displayable>();
		this.clics = new ArrayList<MouseEvent>();
		this.bg = bg;
		this.setLayout(new BorderLayout());
		this.p = new Graphic();
		this.p.addMouseListener(this);
		this.getContentPane().add(this.p,BorderLayout.CENTER);
		jtf = new JTextField(20);
		this.getContentPane().add(jtf,BorderLayout.SOUTH);
		this.setSize(width,height);
		this.setResizable(false);
		this.setLocation((java.awt.Toolkit.getDefaultToolkit().getScreenSize().width-this.getWidth())/2,(java.awt.Toolkit.getDefaultToolkit().getScreenSize().height-this.getHeight())/2);
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setVisible(true);
	}
	
	/** Cr&eacute;e une JFrame permettant d'afficher des Affichable sur l'image de fond sp&eacute;cifi&eacute;e. 
	  * @throws IOException si le fichier image sp&eacute;cifi&eacute; n'existe pas ou n'est pas une image lisible. */
	public Gui(String title, String imageFile) throws IOException{
		super(title);
		this.elements = new ArrayList<Displayable>();
		this.clics = new ArrayList<MouseEvent>();
		this.bg = Color.BLACK;
		this.img = ImageIO.read(new File(imageFile));
		this.setLayout(new BorderLayout());
		this.p = new Graphic();
		this.p.addMouseListener(this);
		this.getContentPane().add(this.p,BorderLayout.CENTER);
		jtf = new JTextField(20);
		this.getContentPane().add(jtf,BorderLayout.SOUTH);
		this.setSize(img.getWidth(),img.getHeight()+48);
		this.setResizable(false);
		this.setLocation((java.awt.Toolkit.getDefaultToolkit().getScreenSize().width-this.getWidth())/2,(java.awt.Toolkit.getDefaultToolkit().getScreenSize().height-this.getHeight())/2);
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setVisible(true);
	}
	
	/** Ajoute un Affichable &agrave; l'interface et rafraichit l'affichage. */
	public void addDisplayable(Displayable d){
		this.elements.add(d);
		this.p.repaint();
	}
	
	/** Retire un Affichable de l'interface et rafraichit l'affichage. */
	public boolean removeDisplayable(Displayable d){
		if(this.elements.remove(d)){
			this.p.repaint();
			return true;
		}
		else return false;
	}
	
	public void mouseClicked(MouseEvent e){
		this.clics.add(e);
	}
	
	public void mouseEntered(MouseEvent e){}
	
	public void mouseExited(MouseEvent e){}
	
	public void mousePressed(MouseEvent e){}
	
	public void mouseReleased(MouseEvent e){}
	
	/** Retourne un MouseEvent correspondant au dernier clic de l'utilisateur, ou null s'il n'y a plus de clic &agrave; renvoyer. */
	public MouseEvent getClic(){
		if(this.clics.isEmpty()) return null;
		else return this.clics.remove(0);
	}
	
	private class Graphic extends JPanel{
		public void paint(Graphics gr){
			if(Gui.this.bg != null){
				gr.setColor(Gui.this.bg);
				gr.fillRect(0,0,this.getWidth(),this.getHeight());
			}
			if(Gui.this.img != null){
				gr.drawImage(Gui.this.img,0,0,this);
			}
			for(Displayable d:Gui.this.elements){
				gr.setColor(d.getColor());
				Shape sh = d.getShape();
				if(sh instanceof java.awt.geom.Line2D || sh instanceof java.awt.geom.Path2D){
					((Graphics2D) gr).setStroke(new BasicStroke(5.0f));
					((Graphics2D) gr).draw(sh);
				}
				else ((Graphics2D) gr).fill(sh);
				gr.setColor(Color.WHITE);
				Font f = gr.getFont().deriveFont(Font.BOLD);
				f = f.deriveFont(fontSize+2);
				gr.setFont(f);
				Point p = d.getStringPosition();
				String[] s = d.getString().split("\n");
				/*int max = 0;
				for(int i=1;i<s.length;i++){if(s[i].length()>s[max].length()) max = i;}
				Rectangle2D r2d = f.getStringBounds(s[max],((Graphics2D) gr).getFontRenderContext());
				gr.setColor(Color.WHITE);
				gr.fillRect(p.x,p.y,(int) r2d.getWidth(),(int) (r2d.getHeight()*s.length+((s.length-1)*GUI_for_Displayable.this.offset)));
				gr.setColor(Color.BLACK);*/
				for(int i=0;i<s.length;i++) gr.drawString(s[i],p.x,p.y+(i+1)*Gui.this.offset);
			}
		}
	}
	
	/** Affiche le message m dans une boite de dialogue. */
	public void displayMessage(String m){
		JOptionPane.showMessageDialog(this,m);
	}
	
	/** Affiche le texte s dans la zone de texte en bas de la fen&ecirc;tre. */
	public void setBottomFieldText(String s){
		this.jtf.setText(s);
	}	
	
}