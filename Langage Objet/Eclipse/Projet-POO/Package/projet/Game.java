package projet;

import java.util.ArrayList;
import java.util.Observable;
import java.util.Observer;
import java.awt.Color;
import java.awt.Point;
import java.io.File;
import java.io.IOException;
import java.awt.Shape;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Line2D;
import java.awt.geom.Path2D;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import display.Displayable;
import display.Objet;
import display.Gui;
import models.Contraintes;
import models.Line;
import models.Population;
import models.Stop;
import models.Trajet;
import models.Transport;
import models.TypeLine;
import models.Zone;

/**
 * Cette classe est la classe principale du programme
 * @author PCPack
 */
public class Game{
	private ArrayList<Population> population; // Liste d'une population
	private Line[] lines; // Liste des lignes dans la ville
	private Stop[] stops; // Liste des stops
	private Zone[] zones; // Liste des zones de la ville
	private TypeLine[] typeLine; // Liste des types de lignes
	private Contraintes[] contraintes; 
	private Point mapSize; // Taille de la map
	private ArrayList<Trajet> trajetList;  
	private ArrayList<Transport> transport; 
	private Gui aff; // Objet pour l'affichage
	
	private long time; // Heure en minutes
	private int speed; // Vitesse d'execution
	
	/**
	 * Constructeur unique, initialise les données
	 * Pensez a appeller les methodes suivantes <br>
	 * {@link #loadData()} <br>
	 * {@link #createPopulation()}
	 */
	
	public Game(){
		this.time = 0;
		this.speed = 1;
		this.mapSize = null;
		this.trajetList = new ArrayList<Trajet>();
		this.transport = new ArrayList<Transport>();
	}
	
	/**
	 * Permet de charger les données
	 * @return Code d'erreur, 0 => OK ; -1 FAILED
	 */
	public int loadData(){
		/* loadData() ne charge pas directement les données a partir 
		 * du xml car si on souhaite faire évoluer le programme on pourra
		 * par exemple ici choisir de ne pas charger a partir du xml car l'utilisateur
		 * aura choisi d'entrer ses données via une interface ou encore permettre de charger
		 * a partir d'un autre format comme le txt ou autre
		 */
		
  		System.out.println("Chargement des data");
        System.out.println("-------------------------------------");
  		
		if(loadingDataFromXml() == -1){
			return -1;
		}
		return 0;
	}
	
	/**
	 * Met a jour les donnees affichés
	 */
	private void udpateUI() {
		// Met a jour l'affichage des stops
		for(int i = 0 ; i < stops.length ; i++){
			Stop s = stops[i];
			
			String textToShow = s.getPeople().size() + " En attente";
			
			// Objet qui sera affiché
			Displayable d = (Displayable)new Objet(new Ellipse2D.Float(
					0, 
					0, 
					0, 
					0),
					new Color(213,110,0),
					textToShow,
					new Point((int)s.getZone().getPosition().getX()-20,(int)s.getZone().getPosition().getY() + 35));
			
			// Si un objet était deja affiché on le supprime pour afficher le nouveau
			if(s.getDisplayable() != null){
				this.aff.removeDisplayable(s.getDisplayable());
			}
			
			// Affichage du nouvel objet
			s.setHisDisplayable(d);
			this.aff.addDisplayable(d);
		}
		
		// Met a jour l'affichage des transports en transit
		for(Transport tr : transport){
			String textToShow = tr.getNameLine() + " : " + tr.getTrajetPeople().size() + " passager";
			
			// Objet d'affichage
			Displayable d = (Displayable)new Objet(new Ellipse2D.Float(
					tr.getX(), 
					tr.getY(), 
					20, 
					20),new Color(213,255,0), textToShow, new Point(tr.getX() - 15, tr.getY() - 35));
			
			// Si un objet etait deja afficher on le supprime pour afficher le nouveau
			if(tr.getDisplayable() != null){
				this.aff.removeDisplayable(tr.getDisplayable());
			}
			
			// Affichage du nouvel objet
			tr.setHisDisplayable(d);
			this.aff.addDisplayable(d);
		}
	}

	/**
	 * Affiche les premiers éléments d'affichage (Les points des arret, ..)
	 */
	private void showUIBase() {
		// Stops
		for(int i = 0 ; i < stops.length ; i++){
			Stop l = stops[i];

			Point p = new Point();
			p.x = (int) l.getZone().getPosition().getX() - 20;
			p.y = (int) l.getZone().getPosition().getY() - 20;
			
			// Objet d'affichage
			this.aff.addDisplayable((Displayable) new Objet(new Ellipse2D.Float(
					(float)l.getZone().getPosition().getX(), 
					(float)l.getZone().getPosition().getY(), 
					30, 
					30), new Color(200,0,0),
					l.getName(), p));
		}
		
		// Lines (Ligne entre les stops)
		for(int i = 0 ; i < lines.length ; i++){
			Line l = lines[i];
			Stop[] lineStop = l.getStops();
			
			for(int u = 0 ; u < lineStop.length - 1 ; u++){
				
				// Objet
				this.aff.addDisplayable((Displayable) new Objet(new Line2D.Float(
						(float)lineStop[u].getZone().getPosition().getX()+5, 
						(float)lineStop[u].getZone().getPosition().getY()+5, 
						(float)lineStop[u+1].getZone().getPosition().getX()+5, 
						(float)lineStop[u+1].getZone().getPosition().getY()+5), 
						l.getColor()));
			}
		}
	}

	/**
	 * Distribue les trajets en attente vers les stop a la bonne heure
	 */
	// Met les trajet prévu dans les arret de bus a l'heure demandé
	private void goToStop(){
		ArrayList<Trajet> newTJ = new ArrayList<Trajet>(); // Copie de liste
		
		for(Trajet tj : trajetList){
			// Si l'heure du départ et dépassé
			if(time >= tj.getHeureDebut()){
				tj.setAller();
				//System.out.println("ajout de personne au stop");
				this.stops[tj.getStartStop()].addPeople(tj);
			}
			// Si l'heure de retour est dépassé
			else if(time >= tj.getHeureFin()){
				tj.setRetour();
				this.stops[tj.getEndStop()].addPeople(tj);
			}
			// Sinon il n'y a pas lieu de mettre la personne dans un arret alors on le met dans la nouvelle liste
			else{
				newTJ.add(tj);
			}
		}
		
		// On met la nouvelle liste (Cad avec les gens qui sont parti aux arret en moins)
		this.trajetList = newTJ;
	}
	
	/**
	 * Permet de generer une population suivant les lieu ou elle peut se rendre
	 */
	// Permet de créer la population
	public void createPopulation() {
		population = new ArrayList<Population>();
		
		int contraintesL = contraintes.length;
		int zoneNb = this.zones.length - 1;
		
		// Pour chaque contraintes existantes
		for(int i = 0 ; i < contraintesL ; i++){
			Contraintes c = contraintes[i];
			long nombrePersonne = c.getNombreVisiteur(); // NB de personne pour cette contrainte
			
			// Pour chaque personne création d'une zone de résidence aléatoire
			for(int u = 0 ; u < nombrePersonne ; u++){
				int zoneAleatoire = 0 + (int)(Math.random() * ((zoneNb - 0) + 1));
				int carAleatoire = 0 + (int)(Math.random() * ((100 - 0) + 1));
				
				// Ajout de la personne dans la liste des personnes
				population.add(new Population(
						 this.zones[zoneAleatoire],
						 c,
						 (carAleatoire < 10) ? true : false
				));
			}
		}
		
		System.out.println("Population genere de " + population.size() + " personnes");
	}
	
	/**
	 * Pour chaque personnes qui effectue un trajet a cette heure on les met dans leur arrets
	 */
	public void addPeopleToStop(){
		System.out.println("Population : " + population.size());
		// Pour chaque personne
		for(Population p : population){
			Contraintes ct = p.getOccupation();
	        
			// si elle a bien une occupation et pas de voiture
			if(ct != null && p.getHaveCar() == false){
				Trajet trajetTrouve = null;
        		int pZone = p.getZone().getId();
        		boolean find = false;
        		
        		// Tant que le trajet n'est pas trouvé
	        	while(trajetTrouve == null && pZone > -1){
		        	for(Line l : lines){
		        		Stop[] stops = l.getStops();
		        		Stop stopStart = null;
		        		Stop stopEnd = null;
		        			
			        	for(Stop s : stops){
			        		if(s.getZone().getId() == pZone){
			        			stopStart = s;
			        		}
			        		if(stopStart != null && s.getZone().getId() == ct.getZone().getId()){
			        			stopEnd = s;
			        		}
			        	}
			        			
			        	if(stopStart != null && stopEnd != null){
			        		trajetTrouve = new Trajet(p, stopStart.getId(), stopEnd.getId(), ct.getHeureDebut(), ct.getHeureFin(), l.getName());
			        		break;
			        	}
		        	}
		        			
		        	if(trajetTrouve != null){
		        		trajetList.add(trajetTrouve);
		        	}
		        	else{
		        		if(!find){
		        			pZone=48;
		        			find = true;
		        		}
			        	pZone--;
		        	}
	        	}
	        }
        }	
    }

	/**
	 * Faire tourner la simulation
	 * @throws InterruptedException
	 */
	public void runGame() throws InterruptedException{
		this.aff = new Gui("Projet POO Courtecuisse Divalentin", mapSize.x, mapSize.y, new Color(149, 165, 166));
		
		showUIBase();
		
		// Boucle principale
		while(true){
			// Ralenti
			Thread.sleep(100);
			
			// On met a jour toutes les minutes les personnes qui doivent aller dans les arrets
			if(trajetList.size() != 0){
				goToStop();
			}
			
			// Pour chaque ligne, a chaque fréquence on rajoute un transport
			for(int i = 0 ; i < lines.length ; i++){
				if(time % lines[i].getFrequence() == 0){
					Stop[] s = lines[i].getStops();
					switch(lines[i].getType().getId()){
						case 0 :
							transport.add(new Transport(s[0].getZone().getPosition().x,s[0].getZone().getPosition().y,"Bus x", 15, s, lines[i].getName(), 40));
						break;
						case 1 :
							transport.add(new Transport(s[0].getZone().getPosition().x,s[0].getZone().getPosition().y,"Metro x", 4, s, lines[i].getName(), 90));
						break;
						case 2 :
							transport.add(new Transport(s[0].getZone().getPosition().x,s[0].getZone().getPosition().y,"Train x", 8,  s, lines[i].getName(), 140));
						break;	
					}
					System.out.println("New transport added on line : " + i + " time : " + (time % lines[i].getFrequence())  + " freq : " + lines[i].getFrequence());
				}
			}

			// Mise a jour de la liste des transports
			ArrayList<Transport> newTransport = new ArrayList<Transport>();
			
			// Mouvement des transport, mise a jour des passager
			for(Transport tr : transport){
				Zone s = tr.getStop()[tr.getGoTo()].getZone();
				
				// Le transport est a son arret
				if(tr.getX() == s.getPosition().x && tr.getY() == s.getPosition().y){
					
					// On fait descendre les passager
					ArrayList<Trajet> trajetDescendre = tr.getTrajetPeople();
					for(int pp = 0 ; pp < trajetDescendre.size(); pp++){
						
						Trajet tp = trajetDescendre.get(pp);
						
						if(tp.getEndStop() == tr.getStop()[tr.getGoTo()].getId()){
							trajetDescendre.remove(tp);
						}
					}
					
					// On fait monter les passager
					ArrayList<Trajet> trajetMonter = tr.getStop()[tr.getGoTo()].getPeople();
					for(int pp = 0 ; pp < trajetMonter.size() && tr.getCapaciteMax() > tr.getTrajetPeople().size(); pp++){
						Trajet tp = trajetMonter.get(pp);
						if(tp.getNameLine() == tr.getNameLine()){
							tr.getTrajetPeople().add(tp);
							trajetMonter.remove(tp);
						}
					}
					
					// On l'envoie au prochain arret
					if(tr.getGoTo() == tr.getStop().length - 1){
						this.aff.removeDisplayable(tr.getDisplayable());
						System.out.println("Fin de ligne");
					}
					else{
						newTransport.add(tr);
						tr.goToNextStop();
					}
				}
				else{ // On fait bouger le transport
					int trX = tr.getX();
					int trY = tr.getY();
					int vitesse = tr.getVitesse();
					int toX = s.getPosition().x;
					int toY = s.getPosition().y;
					
					int maxx, minx, maxy, miny;
					
					// Défini le plus proche, x ou y
					if(trX > toX){
						maxx = trX; minx = toX;
					}
					else{
						maxx = toX; minx = trX;
					}

					if(trY < toY){						
						miny = trY;
						maxy = toY;
					}
					else{
						miny = toY;
						maxy = trY;
					}
					
					if(maxx - minx <= maxy - miny){
						// On bouge de Y
						if(trY > toY){
							if(trY - toY - vitesse <= 0){
								tr.updateY(toY);
							}
							else{
								tr.updateY(trY - vitesse);
							}
						}
						else{
							if(toY - trY - vitesse <= 0){
								tr.updateY(toY);
							}
							else{
								tr.updateY(trY + vitesse);
							}
						}
					}
					else{
						// On bouge de X
						if(trX > toX){
							if(trX - toX - vitesse <= 0){
								tr.updateX(toX);
							}
							else{
								tr.updateX(trX - vitesse);
							}
						}
						else{
							if(toX - trX - vitesse <= 0){
								tr.updateX(toX);
							}
							else{
								tr.updateX(trX + vitesse);
							}
						}
					}
					
					newTransport.add(tr);
				}
			}
			this.transport = newTransport;
			
			// Passage des jours
			if(time == 0){
				addPeopleToStop();
			}
			
			if(time >= 1440000){
				time = 0;
			}
			else{
				time+=60*speed;
			}
			
			udpateUI();
		}
	}
	
	/**
	 * Charge les données a partir d'un fichier xml
	 * @return
	 */
	// !!
	private int loadingDataFromXml() {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();

		try {
			DocumentBuilder builder = factory.newDocumentBuilder();
		    File fileXML = new File("src/projet/data.xml");
		    Document xml = builder.parse(fileXML);
		    Element root = xml.getDocumentElement();
		    XPathFactory xpf = XPathFactory.newInstance();
		    XPath path = xpf.newXPath();
		    String expression;
		        
		    // CONFIG
		    expression = "/data/config/mapX";
		    String mapSizeX = (String)path.evaluate(expression, root);
		    expression = "/data/config/mapY";
		    String mapSizeY = (String)path.evaluate(expression, root);
		        
		    this.mapSize = new Point();
		    this.mapSize.x = Integer.parseInt(mapSizeX);
		    this.mapSize.y = Integer.parseInt(mapSizeY);
		        
		    System.out.println("MAP X SIZE : " + this.mapSize.x);
		    System.out.println("MAP Y SIZE : " + this.mapSize.y);
		        

		    // ZONES
		    System.out.println("-------------------------------------");
		    System.out.println("Chargement des Zones");
		    System.out.println("-------------------------------------");
		    
		    expression = "/data/zone/item";
		    NodeList listZones = (NodeList)path.evaluate(expression, root, XPathConstants.NODESET);
		    int listZonesL = listZones.getLength();
		    this.zones = new Zone[listZonesL];
		        
		    //Parcours de la boucle
		    for(int i = 0 ; i < listZonesL; i++){
		    	Node n = listZones.item(i);
			        NamedNodeMap attr = n.getAttributes();
		        	int idZ = Integer.parseInt(attr.getNamedItem("id").getNodeValue());
		        	String nameZ = (String)attr.getNamedItem("name").getNodeValue();
		        	int posX = Integer.parseInt(attr.getNamedItem("posX").getNodeValue());
		        	int posY = Integer.parseInt(attr.getNamedItem("posY").getNodeValue());
		        	Point pos = new Point();
		        	pos.x = posX;
		        	pos.y = posY;
		        	
		        	// Verification de l'ordre
		        	if(idZ != i){
		        		System.out.println("Erreur, les id doivent etre dans l'ordre croissant et se suivre");
		        		return -1;
		        	}
		        	
		        	// Verification que les point sont bien dans la map
		        	if(posX > this.mapSize.getX() || posY > this.mapSize.getY()){
		        		System.out.println("Erreur : La position de la zone est hors limite de la map, voir config node");
		        		return -1;
		        	}
		        	
		        	// Ajout des zones
		        	this.zones[i] = new Zone(idZ, nameZ, pos);
		        	System.out.println("Ajout d'une nouvelle zone : " + this.zones[i].toString());
		        }
		        
		        // TYPES LINES
		        System.out.println("-------------------------------------");
		        System.out.println("Chargement des types de lignes");
		        System.out.println("-------------------------------------");
		        
		        expression = "/data/types/item";
		        NodeList listTypes = (NodeList)path.evaluate(expression, root, XPathConstants.NODESET);
		        int listTypesL = listTypes.getLength();

		        this.typeLine = new TypeLine[listTypesL];
		        
		        //Parcours de la boucle
		        for(int i = 0 ; i < listTypesL; i++){
			        Node n = listTypes.item(i);
			        NamedNodeMap attr = n.getAttributes();
		        	int idT = Integer.parseInt(attr.getNamedItem("id").getNodeValue());
		        	int nombrePersonneMaxParTransport = Integer.parseInt(attr.getNamedItem("nombrePersonneMaxParTransport").getNodeValue());
		        	String nameT = (String)attr.getNamedItem("name").getNodeValue();
		        	
		        	// Verification de l'ordre
		        	if(idT != i){
		        		System.out.println("Erreur, les id doivent etre dans l'ordre croissant et se suivre");
		        		return -1;
		        	}
		        	
		        	// Ajout des zones
		        	this.typeLine[i] = new TypeLine(idT, nameT, nombrePersonneMaxParTransport);
		        	System.out.println("Ajout d'un nouveau type de ligne : " + this.typeLine[i].toString());
		        }
		        
		     // STOPS
		        System.out.println("-------------------------------------");
		        System.out.println("Chargement de la liste des stop");
		        System.out.println("-------------------------------------");
		        
		        expression = "/data/stop/item";
		        NodeList listStop = (NodeList)path.evaluate(expression, root, XPathConstants.NODESET);
		        int listStopL = listStop.getLength();

		        this.stops = new Stop[listStopL];
		        
		        //Parcours de la boucle
		        for(int i = 0 ; i < listStopL; i++){
			        Node n = listStop.item(i);
			        NamedNodeMap attr = n.getAttributes();
		        	int idT = Integer.parseInt(attr.getNamedItem("id").getNodeValue());
		        	String nameT = (String)attr.getNamedItem("name").getNodeValue();
		        	int zone = Integer.parseInt(attr.getNamedItem("zone").getNodeValue());
		        	int type = Integer.parseInt(attr.getNamedItem("type").getNodeValue());
		        	
		        	// Verification de l'ordre
		        	if(idT != i){
		        		System.out.println("Erreur, les id doivent etre dans l'ordre croissant et se suivre");
		        		return -1;
		        	}
		        	
		        	if(zone >= this.zones.length){
		        		System.out.println("Erreur, La zone n'éxiste pas");
		        		return -1;
		        	}
		        	
		        	if(type >= this.typeLine.length){
		        		System.out.println("Erreur, le type de n'existe pas");
		        		return -1;
		        	}
		        	
		        	// Ajout des zones
		        	this.stops[i] = new Stop(idT, nameT, this.zones[zone], this.typeLine[type]);
		        	System.out.println("Ajout d'un nouveau stop : " + this.stops[i].toString());
		        }
		        
		        
		        // LINES // ? non desservi, stop isset, type correspon, type existe
		        System.out.println("-------------------------------------");
		        System.out.println("Chargement de la liste des lignes");
		        System.out.println("-------------------------------------");
		        
		        expression = "/data/line/item";
		        NodeList listLine = (NodeList)path.evaluate(expression, root, XPathConstants.NODESET);
		        int listLineL = listLine.getLength();

		        this.lines = new Line[listLineL];
		        
		        //Parcours de la boucle
		        for(int i = 0 ; i < listLineL; i++){
			        Node n = listLine.item(i);
			        NamedNodeMap attr = n.getAttributes();
		        	int id = Integer.parseInt(attr.getNamedItem("id").getNodeValue());
		        	String name = (String)attr.getNamedItem("name").getNodeValue();
		        	int type = Integer.parseInt(attr.getNamedItem("type").getNodeValue());
		        	int freq = Integer.parseInt(attr.getNamedItem("freq").getNodeValue());
		        	int r = Integer.parseInt(attr.getNamedItem("r").getNodeValue());
		        	int g = Integer.parseInt(attr.getNamedItem("g").getNodeValue());
		        	int b = Integer.parseInt(attr.getNamedItem("b").getNodeValue());
		        	Color color = new Color(r,g,b);
		        	
		        	// Verification de l'ordre
		        	if(id != i){
		        		System.out.println("Erreur, les id doivent etre dans l'ordre croissant et se suivre");
		        		return -1;
		        	}
		        	
		        	if(type >= this.typeLine.length){
		        		System.out.println("Erreur, le type de n'existe pas");
		        		return -1;
		        	}
		        	
		        	// Verification et ajout des stops
		        	
		        	String expression2 = "/data/line/item[@id='"+ i +"']/item";
			        NodeList stopLstXml = (NodeList)path.evaluate(expression2, root, XPathConstants.NODESET);

		        	int stopLstL = stopLstXml.getLength();
		        	System.out.println(i);
		    		Stop[] stopLst = new Stop[stopLstL];
			        
		        	// Parcour de la liste des stop qu'utilise la ligne
		        	for(int u = 0 ; u < stopLstL; u++){
				        Node item = stopLstXml.item(u);
				        NamedNodeMap attrStop = item.getAttributes();
				        
			        	int idStop = Integer.parseInt(attrStop.getNamedItem("id").getNodeValue());
			        			        	
			        	// Verification que le stop existe
			        	if(idStop >= this.stops.length){
			        		System.out.println("Erreur, le stop de n'existe pas ou id erronee");
			        		return -1;
			        	}
			        	
			        	// Verification que le stop et bien du type de la ligne
			        	if(this.stops[idStop].getType().getId() != type){
			        		System.out.println("Erreur, le type de stop est différent du type de ligne " + this.stops[idStop].getType().toString() +  " VS " + this.typeLine[type].toString() + " LINE : " + i);
			        		return -1;
			        	}
			        	
			        	System.out.println("new Stop : " + this.stops[idStop].toString());
			        	// Cporrection des data
			        	// ajout de la liste des stop dans la ligne
			        	
			        	stopLst[u] = this.stops[idStop];
			        }
		        	
		        	// Ajout des lines
		        	this.lines[i] = new Line(id, name, this.typeLine[type], stopLst, freq, color);
		        	System.out.println("Ajout d'une nouvelle ligne : " + this.lines[i].toString());
		        }
		        
		        
		        // CONTRAINTES == LIEUX
		        System.out.println("-------------------------------------");
		        System.out.println("Chargement de la liste des contraintes");
		        System.out.println("-------------------------------------");
		        
		        expression = "/data/contraintes/item";
		        NodeList listContraintes = (NodeList)path.evaluate(expression, root, XPathConstants.NODESET);
		        int listContraintesL = listContraintes.getLength();

		        this.contraintes = new Contraintes[listContraintesL];
		        
		        //Parcours de la boucle
		        for(int i = 0 ; i < listContraintesL; i++){
			        Node n = listContraintes.item(i);
			        NamedNodeMap attr = n.getAttributes();
		        	int idT = Integer.parseInt(attr.getNamedItem("id").getNodeValue());
		        	String name = (String)attr.getNamedItem("zone").getNodeValue();
		        	int zone = Integer.parseInt(attr.getNamedItem("zone").getNodeValue());
		        	long heureDebut = Long.parseLong(attr.getNamedItem("heureDebut").getNodeValue());
		        	long heureFin = Long.parseLong(attr.getNamedItem("heureFin").getNodeValue());
		        	int nombreVisiteur = Integer.parseInt(attr.getNamedItem("nombreVisiteur").getNodeValue());
		        	
		        	// Verification de l'ordre
		        	if(idT != i){
		        		System.out.println("Erreur, les id doivent etre dans l'ordre croissant et se suivre");
		        		return -1;
		        	}
		        	
		        	if(zone >= this.zones.length){
		        		System.out.println("Erreur, La zone n'éxiste pas");
		        		return -1;
		        	}
		        	
		        	// Ajout des zones
		        	this.contraintes[i] = new Contraintes(idT, name, this.zones[zone], heureDebut, heureFin, nombreVisiteur);
		        	System.out.println("Ajout d'un nouveau lieu : " + this.contraintes[i].toString());
		        }
		      } catch (ParserConfigurationException e) {
		    	  System.out.println("Erreur : Forme du fichier XML data");
		         return -1;
		      } catch (SAXException e) {
		    	  System.out.println("Erreur : ");
			     return -1;
		      } catch (IOException e) {
		    	  System.out.println("Erreur : Lecture du fichier DATA, url OK ? " + e.toString());
		    	 return -1;
			  } catch (XPathExpressionException e) {
		    	  System.out.println("Erreur : Expression xPath invaldie");
				 return -1;
			  } catch (Exception e) {
		    	  System.out.println("Erreur non traite !! : " + e.toString());
		    	  e.printStackTrace();
				 return -1;
			  }
			return 0;
		}
}

