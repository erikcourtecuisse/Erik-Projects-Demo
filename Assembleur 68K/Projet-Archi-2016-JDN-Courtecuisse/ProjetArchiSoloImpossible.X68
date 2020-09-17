*-----------------------------------------------------------
* Title      :Jeux de Nime Partie Solo Impossible
* Written by :Courtecuisse Erik & Goeffrey Caduela
* Description:Projet archi 2016
*-----------------------------------------------------------

JeudeNimeSoloImpo:

    MOVE.l #$03300100,D1        *Agrandissement de la fenetre pour afficher les régles et les scores
    JSR RESOLUTION
    
RebootGameSoloImpo:             *Mise a 0 des des registres et effacement de la partie précédente
    MOVE.l #$00000000,D1
    JSR SET_PEN_COLOR
    
    MOVE.l #$00000000,D1
    JSR SET_FILL_COLOR

EFFACESoloImpo:
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
CHAINEEFFACESoloImpo:
    MOVE.b (A0),D1
    CMP.b #0,D1
    BEQ FinEFFACESoloImpo
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINEEFFACESoloImpo
FinEFFACESoloImpo

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
TABLEAUReglesSoloImpo:
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
FINTABLEAUReglesSoloImpo

AfficheRegles0SoloImpo:
    MOVE.w #0000,D3
    MOVE.L #Regles0,A0
    MOVE.w #$4207,D1  
    JSR POS_CURS
CHAINEAfficheRegles0SoloImpo:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAfficheRegles0SoloImpo
    MOVE.w D1,D2 
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAfficheRegles0SoloImpo
FinAfficheRegles0SoloImpo
AfficheRegles1SoloImpo:
    MOVE.w #0000,D3
    MOVE.L #Regles1,A0
    MOVE.w #$4209,D1  
    JSR POS_CURS
CHAINEAfficheRegles1SoloImpo:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAfficheRegles1SoloImpo
    MOVE.w D1,D2 
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAfficheRegles1SoloImpo
FinAfficheRegles1SoloImpo
AfficheRegles2SoloImpo:
    MOVE.w #0000,D3
    MOVE.L #Regles2,A0
    MOVE.w #$420A,D1  
    JSR POS_CURS
CHAINEAfficheRegles2SoloImpo:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAfficheRegles2SoloImpo
    MOVE.w D1,D2 
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAfficheRegles2SoloImpo
FinAfficheRegles2SoloImpo
AfficheRegles3SoloImpo:
    MOVE.w #0000,D3
    MOVE.L #Regles3,A0
    MOVE.w #$420B,D1  
    JSR POS_CURS
CHAINEAfficheRegles3SoloImpo:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAfficheRegles3SoloImpo
    MOVE.w D1,D2 
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAfficheRegles3SoloImpo
FinAfficheRegles3SoloImpo
AfficheRegles4SoloImpo:
    MOVE.w #0000,D3
    MOVE.L #Regles4,A0
    MOVE.w #$420C,D1  
    JSR POS_CURS
CHAINEAfficheRegles4SoloImpo:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAfficheRegles4SoloImpo
    MOVE.w D1,D2 
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAfficheRegles4SoloImpo
FinAfficheRegles4SoloImpo

AfficheReglesJ1SoloImpo:
    MOVE.w #0000,D3
    MOVE.L #Joueur1Solo,A0
    MOVE.w #$4610,D1  
    JSR POS_CURS
CHAINEAfficheReglesJ1SoloImpo:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAfficheReglesJ1SoloImpo
    MOVE.w D1,D2 
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAfficheReglesJ1SoloImpo
FinAfficheReglesJ1SoloImpo
AfficheReglesJ2SoloImpo:
    MOVE.w #0000,D3
    MOVE.L #Joueur2Solo,A0
    MOVE.w #$5810,D1  
    JSR POS_CURS
CHAINEAfficheReglesJ2SoloImpo:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAfficheReglesJ2SoloImpo
    MOVE.w D1,D2
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAfficheReglesJ2SoloImpo
FinAfficheReglesJ2SoloImpo

SystemScoreSoloImpo:            *Mise en place du systeme de score permanent 
    CMP.w #$00,A5
    BNE FinSystemScoreSoloImpo

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
FinSystemScoreSoloImpo

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
BOUCLE_BOISSoloImpo:                
    CMP.b #09,D7
    BEQ FIN_BOUCLE_BOISSoloImpo
    
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
    BRA BOUCLE_BOISSoloImpo
FIN_BOUCLE_BOISSoloImpo
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
BOUCLE_SOUFRESoloImpo:                
    CMP.b #09,D7
    BEQ FIN_BOUCLE_SOUFRESoloImpo
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
    BRA BOUCLE_SOUFRESoloImpo
FIN_BOUCLE_SOUFRESoloImpo
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
BOUCLE_BOIS2SoloImpo:                
    CMP.b #09,D7
    BEQ FIN_BOUCLE_BOIS2SoloImpo
    
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
    BRA BOUCLE_BOIS2SoloImpo
FIN_BOUCLE_BOIS2SoloImpo
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
BOUCLE_SOUFRE2SoloImpo:                
    CMP.b #09,D7
    BEQ FIN_BOUCLE_SOUFRE2SoloImpo
    
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
    BRA BOUCLE_SOUFRE2SoloImpo
FIN_BOUCLE_SOUFRE2SoloImpo
********************************initialisation de la boucle principale
    MOVE.L #CHAINE4,A0
    
    MOVE.w #$121A,D1   
    JSR POS_CURS
    
CHAINE1affSoloImpo:
    MOVE.b (A0),D1
    CMP.b #0,D1
    BEQ FINCHAINE1affSoloImpo
    JSR AFFCAR
    ADD.L #1,A0
    
   BRA CHAINE1affSoloImpo
FINCHAINE1affSoloImpo


    MOVE.l #$00000000,D1
    JSR SET_FILL_COLOR
    
    MOVE.b #00,D1

SAUTLIGNESoloImpo:          *Permet de retirer les allumettes de al deuxiéme ligne si il en manque dans la premiére
    CMP.w #505,D1
    BEQ SUPPR1SAUTLIGNESoloImpo
    CMP.w #545,D1
    BEQ SUPPR2SAUTLIGNESoloImpo
    CMP.w #585,D1
    BEQ SUPPR3SAUTLIGNESoloImpo

    MOVE.w #101,D3
    MOVE.w #251,D4
    MOVE.w #105,D5
    MOVE.w #280,D6
    
    CMP.w #465,D1
    BGE BOUCLEGbisSoloImpo
FINSAUTLIGNESoloImpo
    
    MOVE.w #101,D3
    MOVE.w #101,D4
    MOVE.w #105,D5
    MOVE.w #130,D6
    
********************************BOUCLE GENERALE*************************
    MOVE.b #01,D7
AfficheSoloImpo:        *Affichage des joueurs de test du gagnant
    CMP.w #$1D1,D1
    BGE TestDerniereAllumetteSoloImpo
Affiche2SoloImpo:
    MOVE.L	#craqueallumette,A1 
    JSR PLAY_SOUND
    
    CMP.b #01,D7
    BEQ AfficheJ1SoloImpo
    CMP.b #02,D7
    BEQ AfficheJ2SoloImpo

BOUCLEGSoloImpo:        *Test si on passe a la ligne suivante
    MOVE.w #$121B,D1   
    JSR POS_CURS
    MOVE.w A2,D1
    CMP.w #465,D1
    BGT SAUTLIGNESoloImpo
    

BOUCLEGbisSoloImpo      *Boucle générale et attente de l'action du joueur

    JSR SAISCAR
    SWAP D7
    MOVE.b D1,D7 *récupére l'action du joueur
    SWAP D7
ActionOrdiSuiteImpo:
    CMP.b #$E1,D2   * si premiere allumette retiree
    BNE BOUCLEG2SoloImpo
    
SUPPRDEPARTBOUCLESoloImpo:  *Premiére action de jeu 
    CMP.b #$31,D1   
    BEQ SUPPR1DEPARTSoloImpo
    CMP.b #$32,D1   
    BEQ SUPPR2DEPARTSoloImpo
    CMP.b #$33,D1   
    BEQ SUPPR3DEPARTSoloImpo
    CMP.b #$31,D1   
    BNE INUTILESoloImpo
FINSUPPRDEPARTBOUCLESoloImpo
    
BOUCLEG2SoloImpo:       *Suite des actions
    CMP.b #$31,D1   
    BEQ SUPPR1ALLUMETTESoloImpo
    CMP.b #$32,D1   
    BEQ SUPPR2ALLUMETTESoloImpo
    CMP.b #$33,D1   
    BEQ SUPPR3ALLUMETTESoloImpo
    CMP.b #$31,D1   
    BNE INUTILESoloImpo
    BRA BOUCLEGSoloImpo
FINBOUCLEGSoloImpo *********************************************************

SUPPR1DEPARTSoloImpo:       *Suppression des allumettes en fonction de la premiére action
   MOVE.w D3,D1
   MOVE.w D4,D2
   JSR POT_DE_PEINTURE
   
   MOVE.w D5,D1
   MOVE.w D6,D2
   JSR POT_DE_PEINTURE
   
   BRA AfficheSoloImpo
FINSUPPR1DEPARTSoloImpo

SUPPR2DEPARTSoloImpo:
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
   
   BRA AfficheSoloImpo
FINSUPPR2DEPARTSoloImpo

SUPPR3DEPARTSoloImpo:
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
   
   BRA AfficheSoloImpo
FINSUPPR3DEPARTSoloImpo:

SUPPR1ALLUMETTESoloImpo:            *Suppression des allumettes aprés la premiére action
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

    BRA AfficheSoloImpo
FINSUPPR1ALLUMETTESoloImpo

SUPPR2ALLUMETTESoloImpo:
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
    
    BRA AfficheSoloImpo
FINSUPPR2ALLUMETTESoloImpo

SUPPR3ALLUMETTESoloImpo:
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
    
    BRA AfficheSoloImpo
FINSUPPR3ALLUMETTESoloImpo

SUPPR1SAUTLIGNESoloImpo:            *Suppression des allumettes de la deuxiéme ligne lors du saut de ligne
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
    BLE BOUCLEGbisSoloImpo
FINSUPPR1SAUTLIGNESoloImpo

SUPPR2SAUTLIGNESoloImpo:
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
    BLE BOUCLEGbisSoloImpo
FINSUPPR2SAUTLIGNESoloImpo

SUPPR3SAUTLIGNESoloImpo:
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
    BLE BOUCLEGbisSoloImpo
FINSUPPR3SAUTLIGNESoloImpo

AfficheJ2SoloImpo:                  *Affichage du Joueur 2
    MOVE.b #01,D7
    MOVE.L #CHAINE1Solo,A0
    
    MOVE.w D1,A2
    MOVE.w #$180D,D1  
    JSR POS_CURS
    MOVE.w #00,D1
CHAINEaffJ2SoloImpo:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FINCHAINEaffJ2SoloImpo
    JSR AFFCAR
    ADD.L #1,A0
   
    BRA CHAINEaffJ2SoloImpo
FINCHAINEaffJ2SoloImpo
***********************inclus++*******
*Partie en plus pour la gestion des actions de l'ordinateur
    MOVE.L #00,D1
PatienceImpo:
    ADD.L #000001,D1
    CMP.L #$100000,D1 **Gestion du temps
    BEQ ActionOrdiImpo
    BRA PatienceImpo
FINPatienceImpo

ActionOrdiImpo:
    SWAP D7
    MOVE.b D7,D1
    SWAP D7
    CMP.b #$31,D1
    BEQ ADD2Impo
    CMP.b #$32,D1
    BEQ ADDrienImpo
    CMP.b #$33,D1
    BEQ SUB2Impo
FinActionOrdiImpo

ADD2Impo:               *complement a 4 sur l'action du joueur pour rendre le jeu impossible a gagner
    ADD #02,D1
    BRA ActionOrdiSuiteImpo
SUB2Impo:
    SUB #02,D1
    BRA ActionOrdiSuiteImpo 
ADDrienImpo:
    BRA ActionOrdiSuiteImpo 
***********************FINinclus++***

AfficheJ1SoloImpo:              *Affichage du joueur 1
    MOVE.b #02,D7
    MOVE.L #CHAINESolo,A0
    
    MOVE.w D1,A2
    MOVE.w #$180D,D1  
    JSR POS_CURS
    MOVE.w #00,D1
CHAINEaffJ1SoloImpo:
    MOVE.b (A0),D1
    CMP.b #0,D1
    BEQ BOUCLEGSoloImpo
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINEaffJ1SoloImpo
FINCHAINEaffJ1SoloImpo

TestDerniereAllumetteSoloImpo:          *Test si il reste des allumettes
    CMP.w #$118,D2
    BEQ TestGagnantSoloImpo
    BRA Affiche2SoloImpo
FinTestDerniereAllumetteSoloImpo

TestGagnantSoloImpo:                    *Verifie qui est le gagnant
    MOVE.w #$1812,D1  
    JSR POS_CURS
    CMP.b #01,D7
    BEQ GagnantJ2SoloImpo
    CMP.b #02,D7
    BEQ GagnantJ1SoloImpo
    BRA Affiche2SoloImpo
FinTestGagnantSoloImpo:

GagnantJ1SoloImpo:                  *Affiche J1 gagnant
    MOVE.b #02,D7
    MOVE.L #CHAINE5Solo,A0
    
    MOVE.w D1,A2
    MOVE.w #$180D,D1  
    JSR POS_CURS
    MOVE.w #00,D1
CHAINEGagnantJ1SoloImpo:
    MOVE.b (A0),D1
    CMP.b #0,D1
    BEQ ScoreJ1plus1SoloImpo
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINEGagnantJ1SoloImpo
FinGagnantJ1SoloImpo

ScoreJ1plus1SoloImpo:               *Systeme du scoring pour le joueur 1 + affichage
    CMP.w #$39,A5
    BEQ TestScoreJ1SoloImpo
    MOVE.w #$4A15,D1  
    JSR POS_CURS
    MOVE A5,D1
    ADD #01,D1
    JSR AFFCAR
    MOVE D1,A5
    BRA AfficheRecommencerPartieSoloImpo
FinScoreJ1plus1SoloImpo

TestScoreJ1SoloImpo:
    CMP.w #00,A4
    BEQ n10J1SoloImpo
    CMP.w #01,A4
    BEQ n20J1SoloImpo
    CMP.w #02,A4
    BEQ n30J1SoloImpo
    CMP.w #03,A4
    BEQ n40J1SoloImpo
    CMP.w #04,A4
    BEQ n50J1SoloImpo
    CMP.w #05,A4
    BEQ n60J1SoloImpo
    CMP.w #06,A4
    BEQ n70J1SoloImpo
    CMP.w #07,A4
    BEQ n80J1SoloImpo
    CMP.w #08,A4
    BEQ n90J1SoloImpo             
FinTestScoreJ1SoloImpo

n10J1SoloImpo:
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
    BRA AfficheRecommencerPartieSoloImpo
Finn10J1SoloImpo

n20J1SoloImpo:
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
    BRA AfficheRecommencerPartieSoloImpo
Finn20J1SoloImpo

n30J1SoloImpo:
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
    BRA AfficheRecommencerPartieSoloImpo
Finn30J1SoloImpo

n40J1SoloImpo:
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
    BRA AfficheRecommencerPartieSoloImpo
Finn40J1SoloImpo

n50J1SoloImpo:
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
    BRA AfficheRecommencerPartieSoloImpo
Finn50J1SoloImpo

n60J1SoloImpo:
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
    BRA AfficheRecommencerPartieSoloImpo
Finn60J1SoloImpo

n70J1SoloImpo:
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
    BRA AfficheRecommencerPartieSoloImpo
Finn70J1SoloImpo

n80J1SoloImpo:
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
    BRA AfficheRecommencerPartieSoloImpo
Finn80J1SoloImpo

n90J1SoloImpo:
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
    BRA AfficheRecommencerPartieSoloImpo
Finn90J1SoloImpo

GagnantJ2SoloImpo:              ************************Affiche J2 gagnant
    MOVE.b #02,D7
    MOVE.L #CHAINE6Solo,A0
    
    MOVE.w D1,A2
    MOVE.w #$180D,D1  
    JSR POS_CURS
    MOVE.w #00,D1
CHAINEGagnantJ2SoloImpo:
    MOVE.b (A0),D1
    CMP.b #0,D1
    BEQ ScoreJ2plus1SoloImpo
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINEGagnantJ2SoloImpo
FinGagnantJ2SoloImpo

ScoreJ2plus1SoloImpo:                   *Systeme du scoring pour le joueur 1 + affichage
    CMP.w #$39,A6
    BEQ TestScoreJ2SoloImpo
    MOVE.w #$5C15,D1  
    JSR POS_CURS
    MOVE A6,D1
    ADD #01,D1
    JSR AFFCAR
    MOVE D1,A6
    BRA AfficheRecommencerPartieSoloImpo
FinScoreJ2plus1SoloImpo

TestScoreJ2SoloImpo:
    CMP.w #00,A3
    BEQ n10J2SoloImpo
    CMP.w #01,A3
    BEQ n20J2SoloImpo
    CMP.w #02,A3
    BEQ n30J2SoloImpo
    CMP.w #03,A3
    BEQ n40J2SoloImpo
    CMP.w #04,A3
    BEQ n50J2SoloImpo
    CMP.w #05,A3
    BEQ n60J2SoloImpo
    CMP.w #06,A3
    BEQ n70J2SoloImpo
    CMP.w #07,A3
    BEQ n80J2SoloImpo
    CMP.w #08,A3
    BEQ n90J2SoloImpo
    *CMP.w #09,A3
    *BEQ stopaffiche
FinTestScoreJ2SoloImpo

n10J2SoloImpo:
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
    BRA AfficheRecommencerPartieSoloImpo
Finn10J2SoloImpo

n20J2SoloImpo:
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
    BRA AfficheRecommencerPartieSoloImpo
Finn20J2SoloImpo

n30J2SoloImpo:
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
    BRA AfficheRecommencerPartieSoloImpo
Finn30J2SoloImpo

n40J2SoloImpo:
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
    BRA AfficheRecommencerPartieSoloImpo
Finn40J2SoloImpo

n50J2SoloImpo:
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
    BRA AfficheRecommencerPartieSoloImpo
Finn50J2SoloImpo

n60J2SoloImpo:
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
    BRA AfficheRecommencerPartieSoloImpo
Finn60J2SoloImpo

n70J2SoloImpo:
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
    BRA AfficheRecommencerPartieSoloImpo
Finn70J2SoloImpo

n80J2SoloImpo:
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
    BRA AfficheRecommencerPartieSoloImpo
Finn80J2SoloImpo

n90J2SoloImpo:
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
    BRA AfficheRecommencerPartieSoloImpo
Finn90J2SoloImpo

AfficheRecommencerPartieSoloImpo:           *Affichage reboot game
    CMP.b #00,D7
    BNE effaceINUTILESoloImpo
    MOVE.L	#finjeu,A1
    JSR PLAY_SOUND
    
    MOVE.b #02,D7
    MOVE.L #CHAINE2,A0
    
    MOVE.l #$00,D1
    MOVE.w #$1018,D1  
    JSR POS_CURS
    MOVE.w #00,D1
CHAINERecommencerPartieSoloImpo:
    MOVE.b (A0),D1
    CMP.b #0,D1
    BEQ RecommencerPartieSoloImpo
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINERecommencerPartieSoloImpo

RecommencerPartieSoloImpo:
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
    
BOUCLESoloImpo:             *Attente de l'action du joueur + zones cliquable 'oui' ou 'non' pour rejouer
    MOVE.w #00,D1
    JSR GET_MOUSE
    CMP.l #%00000001,D0
    BEQ VerifSoloImpo
    BRA BOUCLESoloImpo
FINTANTQUESoloImpo

VerifSoloImpo:
    MOVE.l D1,D7
    CMP.w #0380,D7
    BLT testb1SoloImpo
    CMP.w #0410,D7
    BGT testa1SoloImpo
    BRA BOUCLESoloImpo
testb1SoloImpo:
    CMP.w #0340,D7
    BGT testb2SoloImpo
    BRA BOUCLESoloImpo
testb2SoloImpo:
    SWAP D7
    CMP.w #0358,D7
    BGT testb3SoloImpo
    BRA BOUCLESoloImpo
testb3SoloImpo:
    CMP.w #0380,D7
    BLT RebootgameSoloImpo
    BRA BOUCLESoloImpo
testa1SoloImpo:
    CMP.w #0450,D7
    BLT testa2SoloImpo
    BRA BOUCLESoloImpo
testa2SoloImpo:
    SWAP D7
    CMP.w #0358,D7
    BGT testa3SoloImpo
    BRA BOUCLESoloImpo
testa3SoloImpo:
    CMP.w #0380,D7
    BLT aaurevoirSoloImpo
    BRA BOUCLESoloImpo
FinVerifSoloImpo

aaurevoirSoloImpo:                  *Affichage au revoir si 'non'
    MOVE.L #Aurevoir,A0
    MOVE.w #$1611,D1  
    JSR POS_CURS
CHAINEaurevoirSoloImpo:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FINPROGSoloImpo
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINEaurevoirSoloImpo
FinaaurevoirSoloImpo

INUTILESoloImpo:                    *Message de prévention, empéche le joueur d'appuyer n'importe ou
    MOVE.L #cInutile,A0
    MOVE.w #$0C1D,D1  
    JSR POS_CURS
CHAINEINUTILESoloImpo:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ BOUCLEGSoloImpo
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINEINUTILESoloImpo
FinINUTILESoloImpo

effaceINUTILESoloImpo:              *Enléve le message de prévention
    MOVE.b #00,D7
    MOVE.L #ChaineEffacement,A0
    MOVE.w #$0C1D,D1  
    JSR POS_CURS
CHAINEeffINUTILESoloImpo:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ AfficheRecommencerPartieSoloImpo
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINEeffINUTILESoloImpo
FineffaceINUTILESoloImpo

FINPROGSoloImpo:        *Fin du sous programme
    BRA FINPRG
    RTS
    
    
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
