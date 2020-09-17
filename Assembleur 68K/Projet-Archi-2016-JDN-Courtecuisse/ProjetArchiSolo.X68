*-----------------------------------------------------------
* Title      :Jeux de Nime Partie Solo Facile
* Written by :Courtecuisse Erik & Goeffrey Caduela
* Description:Projet archi 2016
*-----------------------------------------------------------

JeudeNimeSolo:

    MOVE.l #$03300100,D1        *Agrandissement de la fenetre pour afficher les régles et les scores
    JSR RESOLUTION
    
RebootGameSolo:             *Mise a 0 des des registres et effacement de la partie précédente
    MOVE.l #$00000000,D1
    JSR SET_PEN_COLOR
    
    MOVE.l #$00000000,D1
    JSR SET_FILL_COLOR

EFFACESolo:
    MOVE.l #$00000000,D1
    JSR SET_PEN_COLOR
    
    MOVE.w #340,D1
    MOVE.w #358,D2
    MOVE.w #380,D3
    MOVE.w #380,D4
    JSR DRAW_RECT
    
    MOVE.w #340,D1
    MOVE.w #358,D2
    MOVE.w #382,D3
    MOVE.w #382,D4
    JSR DRAW_RECT
    
    MOVE.w #410,D1
    MOVE.w #358,D2
    MOVE.w #450,D3
    MOVE.w #380,D4
    JSR DRAW_RECT
    
    MOVE.w #410,D1
    MOVE.w #358,D2
    MOVE.w #452,D3
    MOVE.w #382,D4
    JSR DRAW_RECT

    MOVE.b #02,D7
    MOVE.L #ChaineEffacement,A0
   
    MOVE.w #$1018,D1  
    JSR POS_CURS
    MOVE.w #00,D1
CHAINEEFFACESolo:
    MOVE.b (A0),D1
    CMP.b #0,D1
    BEQ FinEFFACESolo
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINEEFFACESolo
FinEFFACESolo

    MOVE.L #$00,D1
    MOVE.L #$00,D2
    MOVE.L #$00,D3
    MOVE.L #$00,D4
    MOVE.L #$00,D5
    MOVE.L #$00,D6
    MOVE.L #$00,D7
    MOVE.L #$00,A1
    MOVE.L #$00,A2

    MOVE.L	#startgame,A1       *Son du départ du jeu
    JSR PLAY_SOUND
    
     **********************     
    MOVE.l #$00FFFFFF,D1        *affichage des régles et du tableau de score
    JSR SET_PEN_COLOR
TABLEAUReglesSolo:
    MOVE.w #520,D1
    MOVE.w #00,D2
    MOVE.w #520,D3
    MOVE.w #500,D4
    JSR DRAW_LINE
    MOVE.w #520,D1
    MOVE.w #230,D2
    MOVE.w #850,D3
    MOVE.w #230,D4
    JSR DRAW_LINE
    MOVE.w #670,D1
    MOVE.w #230,D2
    MOVE.w #670,D3
    MOVE.w #700,D4
    JSR DRAW_LINE
    MOVE.w #670,D1
    MOVE.w #230,D2
    MOVE.w #670,D3
    MOVE.w #700,D4
    JSR DRAW_LINE
    MOVE.w #520,D1
    MOVE.w #255,D2
    MOVE.w #815,D3
    MOVE.w #255,D4
    JSR DRAW_LINE
    MOVE.w #0,D1
    MOVE.w #0,D2
    MOVE.w #815,D3
    MOVE.w #479,D4
    JSR DRAW_RECT
FINTABLEAUReglesSolo

AfficheRegles0Solo:
    MOVE.w #0000,D3
    MOVE.L #Regles0,A0
    MOVE.w #$4207,D1  
    JSR POS_CURS
CHAINEAfficheRegles0Solo:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAfficheRegles0Solo
    MOVE.w D1,D2 
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAfficheRegles0Solo
FinAfficheRegles0Solo
AfficheRegles1Solo:
    MOVE.w #0000,D3
    MOVE.L #Regles1,A0
    MOVE.w #$4209,D1  
    JSR POS_CURS
CHAINEAfficheRegles1Solo:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAfficheRegles1Solo
    MOVE.w D1,D2 
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAfficheRegles1Solo
FinAfficheRegles1Solo
AfficheRegles2Solo:
    MOVE.w #0000,D3
    MOVE.L #Regles2,A0
    MOVE.w #$420A,D1  
    JSR POS_CURS
CHAINEAfficheRegles2Solo:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAfficheRegles2Solo
    MOVE.w D1,D2 
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAfficheRegles2Solo
FinAfficheRegles2Solo
AfficheRegles3Solo:
    MOVE.w #0000,D3
    MOVE.L #Regles3,A0
    MOVE.w #$420B,D1  
    JSR POS_CURS
CHAINEAfficheRegles3Solo:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAfficheRegles3Solo
    MOVE.w D1,D2 
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAfficheRegles3Solo
FinAfficheRegles3Solo
AfficheRegles4Solo:
    MOVE.w #0000,D3
    MOVE.L #Regles4,A0
    MOVE.w #$420C,D1  
    JSR POS_CURS
CHAINEAfficheRegles4Solo:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAfficheRegles4Solo
    MOVE.w D1,D2 
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAfficheRegles4Solo
FinAfficheRegles4Solo

AfficheReglesJ1Solo:
    MOVE.w #0000,D3
    MOVE.L #Joueur1Solo,A0
    MOVE.w #$4610,D1  
    JSR POS_CURS
CHAINEAfficheReglesJ1Solo:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAfficheReglesJ1Solo
    MOVE.w D1,D2 
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAfficheReglesJ1Solo
FinAfficheReglesJ1Solo
AfficheReglesJ2Solo:
    MOVE.w #0000,D3
    MOVE.L #Joueur2Solo,A0
    MOVE.w #$5810,D1  
    JSR POS_CURS
CHAINEAfficheReglesJ2Solo:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAfficheReglesJ2Solo
    MOVE.w D1,D2
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAfficheReglesJ2Solo
FinAfficheReglesJ2Solo

SystemScoreSolo:            *Mise en place du systeme de score permanent 
    CMP.w #$00,A5
    BNE FinSystemScoreSolo

    MOVE.w #$4915,D1 *Systeme score J1
    JSR POS_CURS
    MOVE.w #$30,D1
    JSR AFFCAR
    
    MOVE.w #$4A15,D1  
    JSR POS_CURS
    MOVE #$30,D1
    JSR AFFCAR
    MOVE.w D1,A5
    
    MOVE.w #$5B15,D1 *Systeme score J2
    JSR POS_CURS
    MOVE.w #$30,D1
    JSR AFFCAR
    
    MOVE.w #$5C15,D1  
    JSR POS_CURS
    MOVE.w #$30,D1
    JSR AFFCAR
    MOVE.w D1,A6
FinSystemScoreSolo

********************************    Initialisation des boucles de creation des allumettes
    MOVE.b #$00,D7
    
    MOVE.l #$000000FF,D1
    JSR SET_PEN_COLOR
    
    MOVE.l #$00FFFFFF,D1
    JSR SET_FILL_COLOR
    
    MOVE.w #100,D1
    MOVE.w #100,D2
    MOVE.w #110,D3
    MOVE.w #175,D4
    JSR DRAW_RECT
    
    MOVE.w D1,D5
    MOVE.w D2,D6
    
    MOVE.w #101,D1
    MOVE.w #101,D2
    JSR POT_DE_PEINTURE
    
    MOVE.w D5,D1
    MOVE.w D6,D2
    
    **********************          Creation de la premiere ligne d'allumettes
BOUCLE_BOISSolo:                
    CMP.b #09,D7
    BEQ FIN_BOUCLE_BOISSolo
    
    ADD.w #40,D1
    ADD.w #40,D3
    JSR DRAW_RECT
    
    MOVE.w D1,D5
    MOVE.w D2,D6
    
    ADD.w #1,D1
    ADD.w #1,D2
    JSR POT_DE_PEINTURE
    
    MOVE.w D5,D1
    MOVE.w D6,D2

    *
    ADD.w #01,D7
    BRA BOUCLE_BOISSolo
FIN_BOUCLE_BOISSolo
    **********************

    MOVE.l #$000000FF,D1
    JSR SET_FILL_COLOR
    
    MOVE.w #95,D1
    MOVE.w #75,D2
    MOVE.w #115,D3
    MOVE.w #105,D4
    JSR DRAW_ELLIPSE
    
    MOVE.w D1,D5
    MOVE.w D2,D6
    
    MOVE.w #100,D1
    MOVE.w #90,D2
    JSR POT_DE_PEINTURE
    
    MOVE.w #105,D1
    MOVE.w #104,D2
    JSR POT_DE_PEINTURE
    
    MOVE.w D5,D1
    MOVE.w D6,D2
    
    MOVE.b #00,D7
    
    **********************
BOUCLE_SOUFRESolo:                
    CMP.b #09,D7
    BEQ FIN_BOUCLE_SOUFRESolo
    *
    ADD.w #40,D1
    ADD.w #40,D3
    JSR DRAW_ELLIPSE
    
    MOVE.w D1,D5
    MOVE.w D2,D6
    
    ADD.w #10,D1
    ADD.w #10,D2
    JSR POT_DE_PEINTURE
    
    ADD.w #4,D1
    ADD.w #16,D2
    JSR POT_DE_PEINTURE
    
    MOVE.w D5,D1
    MOVE.w D6,D2
    *
    ADD.w #01,D7
    BRA BOUCLE_SOUFRESolo
FIN_BOUCLE_SOUFRESolo
    **********************      Initialisation de la deuxieme ligne

    MOVE.b #00,D7
    
    MOVE.l #$000000FF,D1
    JSR SET_PEN_COLOR
    
    MOVE.l #$00FFFFFF,D1
    JSR SET_FILL_COLOR
    
    MOVE.w #100,D1
    MOVE.w #250,D2
    MOVE.w #110,D3
    MOVE.w #325,D4
    JSR DRAW_RECT
    
    MOVE.w D1,D5
    MOVE.w D2,D6
    
    MOVE.w #101,D1
    MOVE.w #251,D2
    JSR POT_DE_PEINTURE
    
    MOVE.w D5,D1
    MOVE.w D6,D2
    
    **********************          Creation de la deuxieme ligne
BOUCLE_BOIS2Solo:                
    CMP.b #09,D7
    BEQ FIN_BOUCLE_BOIS2Solo
    
    ADD.w #40,D1
    ADD.w #40,D3
    JSR DRAW_RECT
    
    MOVE.w D1,D5
    MOVE.w D2,D6
    
    ADD.w #1,D1
    ADD.w #1,D2
    JSR POT_DE_PEINTURE
    
    MOVE.w D5,D1
    MOVE.w D6,D2

    ADD.w #01,D7
    BRA BOUCLE_BOIS2Solo
FIN_BOUCLE_BOIS2Solo
    **********************

    MOVE.l #$000000FF,D1
    JSR SET_FILL_COLOR
    
    MOVE.w #95,D1
    MOVE.w #225,D2
    MOVE.w #115,D3
    MOVE.w #255,D4
    JSR DRAW_ELLIPSE
    
    MOVE.w D1,D5
    MOVE.w D2,D6
    
    MOVE.w #100,D1
    MOVE.w #240,D2
    JSR POT_DE_PEINTURE
    
    MOVE.w #105,D1
    MOVE.w #254,D2
    JSR POT_DE_PEINTURE
    
    MOVE.w D5,D1
    MOVE.w D6,D2
    
    MOVE.b #00,D7
    
    **********************
BOUCLE_SOUFRE2Solo:                
    CMP.b #09,D7
    BEQ FIN_BOUCLE_SOUFRE2Solo
    
    ADD.w #40,D1
    ADD.w #40,D3
    JSR DRAW_ELLIPSE
    
    MOVE.w D1,D5
    MOVE.w D2,D6
    
    ADD.w #10,D1
    ADD.w #10,D2
    JSR POT_DE_PEINTURE
    
    ADD.w #4,D1
    ADD.w #16,D2
    JSR POT_DE_PEINTURE
    
    MOVE.w D5,D1
    MOVE.w D6,D2
    
    ADD.w #01,D7
    BRA BOUCLE_SOUFRE2Solo
FIN_BOUCLE_SOUFRE2Solo
********************************initialisation de la boucle principale
    MOVE.L #CHAINE4,A0
    
    MOVE.w #$121A,D1   
    JSR POS_CURS
    
CHAINE1affSolo:
    MOVE.b (A0),D1
    CMP.b #0,D1
    BEQ FINCHAINE1affSolo
    JSR AFFCAR
    ADD.L #1,A0
    
   BRA CHAINE1affSolo
FINCHAINE1affSolo


    MOVE.l #$00000000,D1
    JSR SET_FILL_COLOR
    
    MOVE.b #00,D1

SAUTLIGNESolo:          *Permet de retirer les allumettes de al deuxiéme ligne si il en manque dans la premiére
    CMP.w #505,D1
    BEQ SUPPR1SAUTLIGNESolo
    CMP.w #545,D1
    BEQ SUPPR2SAUTLIGNESolo
    CMP.w #585,D1
    BEQ SUPPR3SAUTLIGNESolo

    MOVE.w #101,D3
    MOVE.w #251,D4
    MOVE.w #105,D5
    MOVE.w #280,D6
    
    CMP.w #465,D1
    BGE BOUCLEGbisSolo
FINSAUTLIGNESolo
    
    MOVE.w #101,D3
    MOVE.w #101,D4
    MOVE.w #105,D5
    MOVE.w #130,D6
    
********************************BOUCLE GENERALE*************************
    MOVE.b #01,D7
AfficheSolo:        *Affichage des joueurs de test du gagnant
    CMP.w #$1D1,D1
    BGE TestDerniereAllumetteSolo
Affiche2Solo:
    MOVE.L	#craqueallumette,A1 
    JSR PLAY_SOUND
    
    CMP.b #01,D7
    BEQ AfficheJ1Solo
    CMP.b #02,D7
    BEQ AfficheJ2Solo

BOUCLEGSolo:        *Test si on passe a la ligne suivante
    MOVE.w #$121B,D1   
    JSR POS_CURS
    MOVE.w A2,D1
    CMP.w #465,D1
    BGT SAUTLIGNESolo
    CMP.b #01,D7
    BEQ ActionOrdiSuite

BOUCLEGbisSolo      *Boucle générale et attente de l'action du joueur

    JSR SAISCAR
    SWAP D7
    MOVE.b D1,D7 *récupére l'action du joueur
    SWAP D7
ActionOrdiSuite:
    SWAP D7
    MOVE.b D7,D1
    SWAP D7
    CMP.b #$E1,D2   * si premiere allumette retiree
    BNE BOUCLEG2Solo
    
SUPPRDEPARTBOUCLESolo:  *Premiére action de jeu 
    CMP.b #$31,D1   
    BEQ SUPPR1DEPARTSolo
    CMP.b #$32,D1   
    BEQ SUPPR2DEPARTSolo
    CMP.b #$33,D1   
    BEQ SUPPR3DEPARTSolo
    CMP.b #$31,D1   
    BNE INUTILESolo
FINSUPPRDEPARTBOUCLESolo
    
BOUCLEG2Solo:       *Suite des actions
    CMP.b #$31,D1   
    BEQ SUPPR1ALLUMETTESolo
    CMP.b #$32,D1   
    BEQ SUPPR2ALLUMETTESolo
    CMP.b #$33,D1   
    BEQ SUPPR3ALLUMETTESolo
    CMP.b #$31,D1   
    BNE INUTILESolo
    BRA BOUCLEGSolo
FINBOUCLEGSolo *********************************************************

SUPPR1DEPARTSolo:       *Suppression des allumettes en fonction de la premiére action
   MOVE.w D3,D1
   MOVE.w D4,D2
   JSR POT_DE_PEINTURE
   
   MOVE.w D5,D1
   MOVE.w D6,D2
   JSR POT_DE_PEINTURE
   
   BRA AfficheSolo
FINSUPPR1DEPARTSolo

SUPPR2DEPARTSolo:
   MOVE.w D3,D1
   MOVE.w D4,D2
   JSR POT_DE_PEINTURE
   
   MOVE.w D5,D1
   MOVE.w D6,D2
   JSR POT_DE_PEINTURE
   
   MOVE.w D3,D1
   MOVE.w D4,D2
   ADD.w #40,D1
   ADD.w #40,D3
   JSR POT_DE_PEINTURE
    
   MOVE.w D5,D1
   MOVE.w D6,D2
   ADD.w #40,D1
   ADD.w #40,D5
   JSR POT_DE_PEINTURE
   
   BRA AfficheSolo
FINSUPPR2DEPARTSolo

SUPPR3DEPARTSolo:
   MOVE.w D3,D1
   MOVE.w D4,D2
   JSR POT_DE_PEINTURE
   
   MOVE.w D5,D1
   MOVE.w D6,D2
   JSR POT_DE_PEINTURE
   
   MOVE.w D3,D1
   MOVE.w D4,D2
   ADD.w #40,D1
   ADD.w #40,D3
   JSR POT_DE_PEINTURE
    
   MOVE.w D5,D1
   MOVE.w D6,D2
   ADD.w #40,D1
   ADD.w #40,D5
   JSR POT_DE_PEINTURE
   
   MOVE.w D3,D1
   MOVE.w D4,D2
   ADD.w #40,D1
   ADD.w #40,D3
   JSR POT_DE_PEINTURE
    
   MOVE.w D5,D1
   MOVE.w D6,D2
   ADD.w #40,D1
   ADD.w #40,D5
   JSR POT_DE_PEINTURE
   
   BRA AfficheSolo
FINSUPPR3DEPARTSolo:

SUPPR1ALLUMETTESolo:            *Suppression des allumettes aprés la premiére action
    MOVE.w D3,D1
    MOVE.w D4,D2
    ADD.w #40,D1
    ADD.w #40,D3
    JSR POT_DE_PEINTURE
 
    MOVE.w D5,D1
    MOVE.w D6,D2
    ADD.w #40,D1
    ADD.w #40,D5
    JSR POT_DE_PEINTURE

    BRA AfficheSolo
FINSUPPR1ALLUMETTESolo

SUPPR2ALLUMETTESolo:
    MOVE.w D3,D1
    MOVE.w D4,D2
    ADD.w #40,D1
    ADD.w #40,D3
    JSR POT_DE_PEINTURE
    
    MOVE.w D5,D1
    MOVE.w D6,D2
    ADD.w #40,D1
    ADD.w #40,D5
    JSR POT_DE_PEINTURE
    
    MOVE.w D3,D1
    MOVE.w D4,D2
    ADD.w #40,D1
    ADD.w #40,D3
    JSR POT_DE_PEINTURE
    
    MOVE.w D5,D1
    MOVE.w D6,D2
    ADD.w #40,D1
    ADD.w #40,D5
    JSR POT_DE_PEINTURE
    
    BRA AfficheSolo
FINSUPPR2ALLUMETTESolo

SUPPR3ALLUMETTESolo:
    MOVE.w D3,D1
    MOVE.w D4,D2
    ADD.w #40,D1
    ADD.w #40,D3
    JSR POT_DE_PEINTURE
    
    MOVE.w D5,D1
    MOVE.w D6,D2
    ADD.w #40,D1
    ADD.w #40,D5
    JSR POT_DE_PEINTURE
    
    MOVE.w D3,D1
    MOVE.w D4,D2
    ADD.w #40,D1
    ADD.w #40,D3
    JSR POT_DE_PEINTURE
    
    MOVE.w D5,D1
    MOVE.w D6,D2
    ADD.w #40,D1
    ADD.w #40,D5
    JSR POT_DE_PEINTURE
    
    MOVE.w D3,D1
    MOVE.w D4,D2
    ADD.w #40,D1
    ADD.w #40,D3
    JSR POT_DE_PEINTURE
    
    MOVE.w D5,D1
    MOVE.w D6,D2
    ADD.w #40,D1
    ADD.w #40,D5
    JSR POT_DE_PEINTURE
    
    BRA AfficheSolo
FINSUPPR3ALLUMETTESolo

SUPPR1SAUTLIGNESolo:            *Suppression des allumettes de la deuxiéme ligne lors du saut de ligne
    MOVE.w #101,D3
    MOVE.w #251,D4
    MOVE.w #105,D5
    MOVE.w #280,D6
    
    MOVE.w D3,D1
    MOVE.w D4,D2
    JSR POT_DE_PEINTURE
   
    MOVE.w D5,D1
    MOVE.w D6,D2
    JSR POT_DE_PEINTURE
    
    CMP.w #465,D1
    BLE BOUCLEGbisSolo
FINSUPPR1SAUTLIGNESolo

SUPPR2SAUTLIGNESolo:
    MOVE.w #101,D3
    MOVE.w #251,D4
    MOVE.w #105,D5
    MOVE.w #280,D6
    
    MOVE.w D3,D1
    MOVE.w D4,D2
    JSR POT_DE_PEINTURE
   
    MOVE.w D5,D1
    MOVE.w D6,D2
    JSR POT_DE_PEINTURE
    
    MOVE.w D3,D1
    MOVE.w D4,D2
    ADD.w #40,D1
    ADD.w #40,D3
    JSR POT_DE_PEINTURE
    
    MOVE.w D5,D1
    MOVE.w D6,D2
    ADD.w #40,D1
    ADD.w #40,D5
    JSR POT_DE_PEINTURE
    
    CMP.w #465,D1
    BLE BOUCLEGbisSolo
FINSUPPR2SAUTLIGNESolo

SUPPR3SAUTLIGNESolo:
    MOVE.w #101,D3
    MOVE.w #251,D4
    MOVE.w #105,D5
    MOVE.w #280,D6
    
    MOVE.w D3,D1
    MOVE.w D4,D2
    JSR POT_DE_PEINTURE
   
    MOVE.w D5,D1
    MOVE.w D6,D2
    JSR POT_DE_PEINTURE
    
    MOVE.w D3,D1
    MOVE.w D4,D2
    ADD.w #40,D1
    ADD.w #40,D3
    JSR POT_DE_PEINTURE
    
    MOVE.w D5,D1
    MOVE.w D6,D2
    ADD.w #40,D1
    ADD.w #40,D5
    JSR POT_DE_PEINTURE
    
    MOVE.w D3,D1
    MOVE.w D4,D2
    ADD.w #40,D1
    ADD.w #40,D3
    JSR POT_DE_PEINTURE
    
    MOVE.w D5,D1
    MOVE.w D6,D2
    ADD.w #40,D1
    ADD.w #40,D5
    JSR POT_DE_PEINTURE
    
    CMP.w #465,D1
    BLE BOUCLEGbisSolo
FINSUPPR3SAUTLIGNESolo

AfficheJ2Solo:                  *Affichage du Joueur 2
    MOVE.b #01,D7
    MOVE.L #CHAINE1Solo,A0
    
    MOVE.w D1,A2
    MOVE.w #$180D,D1  
    JSR POS_CURS
    MOVE.w #00,D1
CHAINEaffJ2Solo:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FINCHAINEaffJ2Solo
    JSR AFFCAR
    ADD.L #1,A0
   
    BRA CHAINEaffJ2Solo
FINCHAINEaffJ2Solo
***********************inclus++*******
*Partie en plus pour la gestion des actions de l'ordinateur
    MOVE.L #00,D1
Patience:
    ADD.L #000001,D1
    CMP.L #$100000,D1 **Gestion du temps
    BEQ ActionOrdi
    BRA Patience
FINPatience

ActionOrdi:
    SWAP D7
    MOVE.b D7,D1
    SWAP D7
    CMP.b #$31,D1
    BEQ retour
    CMP.b #$32,D1
    BEQ retour
    CMP.b #$33,D1
    BEQ retour
FinActionOrdi

retour:               *Effectu les memes actions que le joueur
    BRA BOUCLEGSolo
***********************FINinclus++***

AfficheJ1Solo:              *Affichage du joueur 1
    MOVE.b #02,D7
    MOVE.L #CHAINESolo,A0
    
    MOVE.w D1,A2
    MOVE.w #$180D,D1  
    JSR POS_CURS
    MOVE.w #00,D1
CHAINEaffJ1Solo:
    MOVE.b (A0),D1
    CMP.b #0,D1
    BEQ BOUCLEGSolo
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINEaffJ1Solo
FINCHAINEaffJ1Solo

TestDerniereAllumetteSolo:          *Test si il reste des allumettes
    CMP.w #$118,D2
    BEQ TestGagnantSolo
    BRA Affiche2Solo
FinTestDerniereAllumetteSolo

TestGagnantSolo:                    *Verifie qui est le gagnant
    MOVE.w #$1812,D1  
    JSR POS_CURS
    CMP.b #01,D7
    BEQ GagnantJ2Solo
    CMP.b #02,D7
    BEQ GagnantJ1Solo
    BRA Affiche2Solo
FinTestGagnantSolo:

GagnantJ1Solo:                  *Affiche J1 gagnant
    MOVE.b #02,D7
    MOVE.L #CHAINE5Solo,A0
    
    MOVE.w D1,A2
    MOVE.w #$180D,D1  
    JSR POS_CURS
    MOVE.w #00,D1
CHAINEGagnantJ1Solo:
    MOVE.b (A0),D1
    CMP.b #0,D1
    BEQ ScoreJ1plus1Solo
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINEGagnantJ1Solo
FinGagnantJ1Solo

ScoreJ1plus1Solo:               *Systeme du scoring pour le joueur 1 + affichage
    CMP.w #$39,A5
    BEQ TestScoreJ1Solo
    MOVE.w #$4A15,D1  
    JSR POS_CURS
    MOVE A5,D1
    ADD #01,D1
    JSR AFFCAR
    MOVE D1,A5
    BRA AfficheRecommencerPartieSolo
FinScoreJ1plus1Solo

TestScoreJ1Solo:
    CMP.w #00,A4
    BEQ n10J1Solo
    CMP.w #01,A4
    BEQ n20J1Solo
    CMP.w #02,A4
    BEQ n30J1Solo
    CMP.w #03,A4
    BEQ n40J1Solo
    CMP.w #04,A4
    BEQ n50J1Solo
    CMP.w #05,A4
    BEQ n60J1Solo
    CMP.w #06,A4
    BEQ n70J1Solo
    CMP.w #07,A4
    BEQ n80J1Solo
    CMP.w #08,A4
    BEQ n90J1Solo             
FinTestScoreJ1Solo

n10J1Solo:
    MOVE.w #$4A15,D1  
    JSR POS_CURS
    MOVE #$30,D1
    JSR AFFCAR
    MOVE.w #$4915,D1
    JSR POS_CURS
    MOVE #$31,D1
    JSR AFFCAR
    MOVE.w #01,A4
    MOVE.w #$30,A5
    BRA AfficheRecommencerPartieSolo
Finn10J1Solo

n20J1Solo:
    MOVE.w #$4A15,D1  
    JSR POS_CURS
    MOVE #$30,D1
    JSR AFFCAR
    MOVE.w #$4915,D1
    JSR POS_CURS
    MOVE #$32,D1
    JSR AFFCAR
    MOVE.w #02,A4
    MOVE.w #$30,A5
    BRA AfficheRecommencerPartieSolo
Finn20J1Solo

n30J1Solo:
    MOVE.w #$4A15,D1  
    JSR POS_CURS
    MOVE #$30,D1
    JSR AFFCAR
    MOVE.w #$4915,D1
    JSR POS_CURS
    MOVE #$33,D1
    JSR AFFCAR
    MOVE.w #03,A4
    MOVE.w #$30,A5
    BRA AfficheRecommencerPartieSolo
Finn30J1Solo

n40J1Solo:
    MOVE.w #$4A15,D1  
    JSR POS_CURS
    MOVE #$30,D1
    JSR AFFCAR
    MOVE.w #$4915,D1
    JSR POS_CURS
    MOVE #$34,D1
    JSR AFFCAR
    MOVE.w #04,A4
    MOVE.w #$30,A5
    BRA AfficheRecommencerPartieSolo
Finn40J1Solo

n50J1Solo:
    MOVE.w #$4A15,D1  
    JSR POS_CURS
    MOVE #$30,D1
    JSR AFFCAR
    MOVE.w #$4915,D1
    JSR POS_CURS
    MOVE #$35,D1
    JSR AFFCAR
    MOVE.w #05,A4
    MOVE.w #$30,A5
    BRA AfficheRecommencerPartieSolo
Finn50J1Solo

n60J1Solo:
    MOVE.w #$4A15,D1  
    JSR POS_CURS
    MOVE #$30,D1
    JSR AFFCAR
    MOVE.w #$4915,D1
    JSR POS_CURS
    MOVE #$36,D1
    JSR AFFCAR
    MOVE.w #06,A4
    MOVE.w #$30,A5
    BRA AfficheRecommencerPartieSolo
Finn60J1Solo

n70J1Solo:
    MOVE.w #$4A15,D1  
    JSR POS_CURS
    MOVE #$30,D1
    JSR AFFCAR
    MOVE.w #$4915,D1
    JSR POS_CURS
    MOVE #$37,D1
    JSR AFFCAR
    MOVE.w #07,A4
    MOVE.w #$30,A5
    BRA AfficheRecommencerPartieSolo
Finn70J1Solo

n80J1Solo:
    MOVE.w #$4A15,D1  
    JSR POS_CURS
    MOVE #$30,D1
    JSR AFFCAR
    MOVE.w #$4915,D1
    JSR POS_CURS
    MOVE #$38,D1
    JSR AFFCAR
    MOVE.w #08,A4
    MOVE.w #$30,A5
    BRA AfficheRecommencerPartieSolo
Finn80J1Solo

n90J1Solo:
    MOVE.w #$4A15,D1  
    JSR POS_CURS
    MOVE #$30,D1
    JSR AFFCAR
    MOVE.w #$4915,D1
    JSR POS_CURS
    MOVE #$39,D1
    JSR AFFCAR
    MOVE.w #09,A4
    MOVE.w #$30,A5
    BRA AfficheRecommencerPartieSolo
Finn90J1Solo

GagnantJ2Solo:              ************************Affiche J2 gagnant
    MOVE.b #02,D7
    MOVE.L #CHAINE6Solo,A0
    
    MOVE.w D1,A2
    MOVE.w #$180D,D1  
    JSR POS_CURS
    MOVE.w #00,D1
CHAINEGagnantJ2Solo:
    MOVE.b (A0),D1
    CMP.b #0,D1
    BEQ ScoreJ2plus1Solo
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINEGagnantJ2Solo
FinGagnantJ2Solo

ScoreJ2plus1Solo:                   *Systeme du scoring pour le joueur 1 + affichage
    CMP.w #$39,A6
    BEQ TestScoreJ2Solo
    MOVE.w #$5C15,D1  
    JSR POS_CURS
    MOVE A6,D1
    ADD #01,D1
    JSR AFFCAR
    MOVE D1,A6
    BRA AfficheRecommencerPartieSolo
FinScoreJ2plus1Solo

TestScoreJ2Solo:
    CMP.w #00,A3
    BEQ n10J2Solo
    CMP.w #01,A3
    BEQ n20J2Solo
    CMP.w #02,A3
    BEQ n30J2Solo
    CMP.w #03,A3
    BEQ n40J2Solo
    CMP.w #04,A3
    BEQ n50J2Solo
    CMP.w #05,A3
    BEQ n60J2Solo
    CMP.w #06,A3
    BEQ n70J2Solo
    CMP.w #07,A3
    BEQ n80J2Solo
    CMP.w #08,A3
    BEQ n90J2Solo
    *CMP.w #09,A3
    *BEQ stopaffiche
FinTestScoreJ2Solo

n10J2Solo:
    MOVE.w #$5C15,D1  
    JSR POS_CURS
    MOVE #$30,D1
    JSR AFFCAR
    MOVE.w #$5B15,D1
    JSR POS_CURS
    MOVE #$31,D1
    JSR AFFCAR
    MOVE.w #01,A3
    MOVE.w #$30,A6
    BRA AfficheRecommencerPartieSolo
Finn10J2Solo

n20J2Solo:
    MOVE.w #$5C15,D1  
    JSR POS_CURS
    MOVE #$30,D1
    JSR AFFCAR
    MOVE.w #$5B15,D1
    JSR POS_CURS
    MOVE #$32,D1
    JSR AFFCAR
    MOVE.w #02,A3
    MOVE.w #$30,A6
    BRA AfficheRecommencerPartieSolo
Finn20J2Solo

n30J2Solo:
    MOVE.w #$5C15,D1  
    JSR POS_CURS
    MOVE #$30,D1
    JSR AFFCAR
    MOVE.w #$5B15,D1
    JSR POS_CURS
    MOVE #$33,D1
    JSR AFFCAR
    MOVE.w #03,A3
    MOVE.w #$30,A6
    BRA AfficheRecommencerPartieSolo
Finn30J2Solo

n40J2Solo:
    MOVE.w #$5C15,D1  
    JSR POS_CURS
    MOVE #$30,D1
    JSR AFFCAR
    MOVE.w #$5B15,D1
    JSR POS_CURS
    MOVE #$34,D1
    JSR AFFCAR
    MOVE.w #04,A3
    MOVE.w #$30,A6
    BRA AfficheRecommencerPartieSolo
Finn40J2Solo

n50J2Solo:
    MOVE.w #$5C15,D1  
    JSR POS_CURS
    MOVE #$30,D1
    JSR AFFCAR
    MOVE.w #$5B15,D1
    JSR POS_CURS
    MOVE #$35,D1
    JSR AFFCAR
    MOVE.w #05,A3
    MOVE.w #$30,A6
    BRA AfficheRecommencerPartieSolo
Finn50J2Solo

n60J2Solo:
    MOVE.w #$5C15,D1  
    JSR POS_CURS
    MOVE #$30,D1
    JSR AFFCAR
    MOVE.w #$5B15,D1
    JSR POS_CURS
    MOVE #$36,D1
    JSR AFFCAR
    MOVE.w #06,A3
    MOVE.w #$30,A6
    BRA AfficheRecommencerPartieSolo
Finn60J2Solo

n70J2Solo:
    MOVE.w #$5C15,D1  
    JSR POS_CURS
    MOVE #$30,D1
    JSR AFFCAR
    MOVE.w #$5B15,D1
    JSR POS_CURS
    MOVE #$37,D1
    JSR AFFCAR
    MOVE.w #07,A3
    MOVE.w #$30,A6
    BRA AfficheRecommencerPartieSolo
Finn70J2Solo

n80J2Solo:
    MOVE.w #$5C15,D1  
    JSR POS_CURS
    MOVE #$30,D1
    JSR AFFCAR
    MOVE.w #$5B15,D1
    JSR POS_CURS
    MOVE #$38,D1
    JSR AFFCAR
    MOVE.w #08,A3
    MOVE.w #$30,A6
    BRA AfficheRecommencerPartieSolo
Finn80J2Solo

n90J2Solo:
    MOVE.w #$5C15,D1  
    JSR POS_CURS
    MOVE #$30,D1
    JSR AFFCAR
    MOVE.w #$5B15,D1
    JSR POS_CURS
    MOVE #$39,D1
    JSR AFFCAR
    MOVE.w #09,A3
    MOVE.w #$30,A6
    BRA AfficheRecommencerPartieSolo
Finn90J2Solo

AfficheRecommencerPartieSolo:           *Affichage reboot game
    CMP.b #00,D7
    BNE effaceINUTILESolo
    MOVE.L	#finjeu,A1
    JSR PLAY_SOUND
    
    MOVE.b #02,D7
    MOVE.L #CHAINE2,A0
    
    MOVE.l #$00,D1
    MOVE.w #$1018,D1  
    JSR POS_CURS
    MOVE.w #00,D1
CHAINERecommencerPartieSolo:
    MOVE.b (A0),D1
    CMP.b #0,D1
    BEQ RecommencerPartieSolo
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINERecommencerPartieSolo

RecommencerPartieSolo:
    MOVE.l #$00FFFFFF,D1
    JSR SET_PEN_COLOR
    
    MOVE.w #340,D1
    MOVE.w #358,D2
    MOVE.w #380,D3
    MOVE.w #380,D4
    JSR DRAW_RECT
    
    MOVE.w #340,D1
    MOVE.w #358,D2
    MOVE.w #382,D3
    MOVE.w #382,D4
    JSR DRAW_RECT
    
    MOVE.w #410,D1
    MOVE.w #358,D2
    MOVE.w #450,D3
    MOVE.w #380,D4
    JSR DRAW_RECT
    
    MOVE.w #410,D1
    MOVE.w #358,D2
    MOVE.w #452,D3
    MOVE.w #382,D4
    JSR DRAW_RECT
    
BOUCLESolo:             *Attente de l'action du joueur + zones cliquable 'oui' ou 'non' pour rejouer
    MOVE.w #00,D1
    JSR GET_MOUSE
    CMP.l #%00000001,D0
    BEQ VerifSolo
    BRA BOUCLESolo
FINTANTQUESolo

VerifSolo:
    MOVE.l D1,D7
    CMP.w #0380,D7
    BLT testb1Solo
    CMP.w #0410,D7
    BGT testa1Solo
    BRA BOUCLESolo
testb1Solo:
    CMP.w #0340,D7
    BGT testb2Solo
    BRA BOUCLESolo
testb2Solo:
    SWAP D7
    CMP.w #0358,D7
    BGT testb3Solo
    BRA BOUCLESolo
testb3Solo:
    CMP.w #0380,D7
    BLT RebootgameSolo
    BRA BOUCLESolo
testa1Solo:
    CMP.w #0450,D7
    BLT testa2Solo
    BRA BOUCLESolo
testa2Solo:
    SWAP D7
    CMP.w #0358,D7
    BGT testa3Solo
    BRA BOUCLESolo
testa3Solo:
    CMP.w #0380,D7
    BLT aaurevoirSolo
    BRA BOUCLESolo
FinVerifSolo

aaurevoirSolo:                  *Affichage au revoir si 'non'
    MOVE.L #Aurevoir,A0
    MOVE.w #$1611,D1  
    JSR POS_CURS
CHAINEaurevoirSolo:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FINPROGSolo
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINEaurevoirSolo
FinaaurevoirSolo

INUTILESolo:                    *Message de prévention, empéche le joueur d'appuyer n'importe ou
    MOVE.L #cInutile,A0
    MOVE.w #$0C1D,D1  
    JSR POS_CURS
CHAINEINUTILESolo:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ BOUCLEGSolo
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINEINUTILESolo
FinINUTILESolo

effaceINUTILESolo:              *Enléve le message de prévention
    MOVE.b #00,D7
    MOVE.L #ChaineEffacement,A0
    MOVE.w #$0C1D,D1  
    JSR POS_CURS
CHAINEeffINUTILESolo:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ AfficheRecommencerPartieSolo
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINEeffINUTILESolo
FineffaceINUTILESolo

FINPROGSolo:        *Fin du sous programme
    BRA FINPRG
    RTS
    
    
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
