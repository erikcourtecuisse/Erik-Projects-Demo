*-----------------------------------------------------------
* Title      :Jeux de Nime Partie Multijoueurs
* Written by :Courtecuisse Erik & Goeffrey Caduela
* Description:Projet archi 2016
*-----------------------------------------------------------
JeudeNimeMulti:

    MOVE.l #$03300100,D1    *Agrandissement de la fenetre pour afficher les régles et les scores
    JSR RESOLUTION
    
RebootGame:                 *Mise a 0 des des registres et effacement de la partie précédente
    MOVE.l #$00000000,D1
    JSR SET_PEN_COLOR
    
    MOVE.l #$00000000,D1
    JSR SET_FILL_COLOR

EFFACE:
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
CHAINEEFFACE:
    MOVE.b (A0),D1
    CMP.b #0,D1
    BEQ FinEFFACE
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINEEFFACE
FinEFFACE

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
TABLEAURegles:
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
FINTABLEAURegles

AfficheRegles0:
    MOVE.w #0000,D3
    MOVE.L #Regles0,A0
    MOVE.w #$4207,D1  
    JSR POS_CURS
CHAINEAfficheRegles0:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAfficheRegles0
    MOVE.w D1,D2 
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAfficheRegles0
FinAfficheRegles0
AfficheRegles1:
    MOVE.w #0000,D3
    MOVE.L #Regles1,A0
    MOVE.w #$4209,D1  
    JSR POS_CURS
CHAINEAfficheRegles1:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAfficheRegles1
    MOVE.w D1,D2 
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAfficheRegles1
FinAfficheRegles1
AfficheRegles2:
    MOVE.w #0000,D3
    MOVE.L #Regles2,A0
    MOVE.w #$420A,D1  
    JSR POS_CURS
CHAINEAfficheRegles2:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAfficheRegles2
    MOVE.w D1,D2 
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAfficheRegles2
FinAfficheRegles2
AfficheRegles3:
    MOVE.w #0000,D3
    MOVE.L #Regles3,A0
    MOVE.w #$420B,D1  
    JSR POS_CURS
CHAINEAfficheRegles3:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAfficheRegles3
    MOVE.w D1,D2 
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAfficheRegles3
FinAfficheRegles3
AfficheRegles4:
    MOVE.w #0000,D3
    MOVE.L #Regles4,A0
    MOVE.w #$420C,D1  
    JSR POS_CURS
CHAINEAfficheRegles4:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAfficheRegles4
    MOVE.w D1,D2 
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAfficheRegles4
FinAfficheRegles4

AfficheReglesJ1:
    MOVE.w #0000,D3
    MOVE.L #Joueur1,A0
    MOVE.w #$4610,D1  
    JSR POS_CURS
CHAINEAfficheReglesJ1:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAfficheReglesJ1
    MOVE.w D1,D2 
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAfficheReglesJ1
FinAfficheReglesJ1
AfficheReglesJ2:
    MOVE.w #0000,D3
    MOVE.L #Joueur2,A0
    MOVE.w #$5810,D1  
    JSR POS_CURS
CHAINEAfficheReglesJ2:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAfficheReglesJ2
    MOVE.w D1,D2 
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAfficheReglesJ2
FinAfficheReglesJ2

SystemScore                 *Mise en place du systeme de score permanent
    CMP.w #$00,A5
    BNE FinSystemScore

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
FinSystemScore
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
BOUCLE_BOIS:                
    CMP.b #09,D7
    BEQ FIN_BOUCLE_BOIS
    
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
    BRA BOUCLE_BOIS
FIN_BOUCLE_BOIS
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
BOUCLE_SOUFRE:                
    CMP.b #09,D7
    BEQ FIN_BOUCLE_SOUFRE
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
    BRA BOUCLE_SOUFRE
FIN_BOUCLE_SOUFRE
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
BOUCLE_BOIS2:                
    CMP.b #09,D7
    BEQ FIN_BOUCLE_BOIS2
    
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
    BRA BOUCLE_BOIS2
FIN_BOUCLE_BOIS2
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
BOUCLE_SOUFRE2:                
    CMP.b #09,D7
    BEQ FIN_BOUCLE_SOUFRE2
    
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
    BRA BOUCLE_SOUFRE2
FIN_BOUCLE_SOUFRE2
********************************initialisation de la boucle principale
    MOVE.L #CHAINE4,A0
    
    MOVE.w #$121A,D1   
    JSR POS_CURS
    
CHAINE1aff:
    MOVE.b (A0),D1
    CMP.b #0,D1
    BEQ FINCHAINE1aff
    JSR AFFCAR
    ADD.L #1,A0
    
   BRA CHAINE1aff
FINCHAINE1aff


    MOVE.l #$00000000,D1
    JSR SET_FILL_COLOR
    
    MOVE.b #00,D1

SAUTLIGNE:                  *Permet de retirer les allumettes de al deuxiéme ligne si il en manque dans la premiére
    CMP.w #505,D1
    BEQ SUPPR1SAUTLIGNE
    CMP.w #545,D1
    BEQ SUPPR2SAUTLIGNE
    CMP.w #585,D1
    BEQ SUPPR3SAUTLIGNE

    MOVE.w #101,D3
    MOVE.w #251,D4
    MOVE.w #105,D5
    MOVE.w #280,D6
    
    CMP.w #465,D1
    BGE BOUCLEGbis
FINSAUTLIGNE
    
    MOVE.w #101,D3
    MOVE.w #101,D4
    MOVE.w #105,D5
    MOVE.w #130,D6
    
********************************BOUCLE GENERALE*************************
    MOVE.b #01,D7
Affiche:                        *Affichage des joueurs de test du gagnant
    CMP.w #$1D1,D1
    BGE TestDerniereAllumette
Affiche2:
    MOVE.L	#craqueallumette,A1 
    JSR PLAY_SOUND
    
    CMP.b #01,D7
    BEQ AfficheJ1
    CMP.b #02,D7
    BEQ AfficheJ2

BOUCLEG:                        *Test si on passe a la ligne suivante

    MOVE.w #$121B,D1   
    JSR POS_CURS
    MOVE.w A2,D1
    CMP.w #465,D1
    BGT SAUTLIGNE

BOUCLEGbis                      **Boucle générale et attente de l'action du joueur

    JSR SAISCAR
    
    CMP.b #$E1,D2   * si premiere allumette retiree
    BNE BOUCLEG2
    
SUPPRDEPARTBOUCLE:          *Premiére action de jeu
    CMP.b #$31,D1   
    BEQ SUPPR1DEPART
    CMP.b #$32,D1   
    BEQ SUPPR2DEPART
    CMP.b #$33,D1   
    BEQ SUPPR3DEPART
    CMP.b #$31,D1   
    BNE INUTILE
FINSUPPRDEPARTBOUCLE
    
BOUCLEG2:                   *Suite des actions
    CMP.b #$31,D1   
    BEQ SUPPR1ALLUMETTE
    CMP.b #$32,D1   
    BEQ SUPPR2ALLUMETTE
    CMP.b #$33,D1   
    BEQ SUPPR3ALLUMETTE
    CMP.b #$31,D1   
    BNE INUTILE
    BRA BOUCLEG
FINBOUCLEG *********************************************************

SUPPR1DEPART:                   *Suppression des allumettes en fonction de la premiére action
   MOVE.w D3,D1
   MOVE.w D4,D2
   JSR POT_DE_PEINTURE
   
   MOVE.w D5,D1
   MOVE.w D6,D2
   JSR POT_DE_PEINTURE
   
   BRA Affiche
FINSUPPR1DEPART

SUPPR2DEPART:
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
   
   BRA Affiche
FINSUPPR2DEPART

SUPPR3DEPART:
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
   
   BRA Affiche
FINSUPPR3DEPART:

SUPPR1ALLUMETTE:                *Suppression des allumettes aprés la premiére action
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

    BRA Affiche
FINSUPPR1ALLUMETTE

SUPPR2ALLUMETTE:
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
    
    BRA Affiche
FINSUPPR2ALLUMETTE

SUPPR3ALLUMETTE:
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
    
    BRA Affiche
FINSUPPR3ALLUMETTE

SUPPR1SAUTLIGNE:                    *Suppression des allumettes de la deuxiéme ligne lors du saut de ligne
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
    BLE BOUCLEGbis
FINSUPPR1SAUTLIGNE

SUPPR2SAUTLIGNE:
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
    BLE BOUCLEGbis
FINSUPPR2SAUTLIGNE

SUPPR3SAUTLIGNE:
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
    BLE BOUCLEGbis
FINSUPPR3SAUTLIGNE

AfficheJ2:                          *Affichage du Joueur 2
    MOVE.b #01,D7
    MOVE.L #CHAINE1,A0
    
    MOVE.w D1,A2
    MOVE.w #$180D,D1  
    JSR POS_CURS
    MOVE.w #00,D1
CHAINEaffJ2:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ BOUCLEG
    JSR AFFCAR
    ADD.L #1,A0
   
    BRA CHAINEaffJ2
FINCHAINEaffJ2

AfficheJ1:                      *Affichage du Joueur 1
    MOVE.b #02,D7
    MOVE.L #CHAINE,A0
    
    MOVE.w D1,A2
    MOVE.w #$180D,D1  
    JSR POS_CURS
    MOVE.w #00,D1
CHAINEaffJ1:
    MOVE.b (A0),D1
    CMP.b #0,D1
    BEQ BOUCLEG
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINEaffJ1
FINCHAINEaffJ1

TestDerniereAllumette:                  *Test si il reste des allumettes
    CMP.w #$118,D2
    BEQ TestGagnant
    BRA Affiche2
FinTestDerniereAllumette

TestGagnant:                            *Verifie qui est le gagnant
    MOVE.w #$1812,D1  
    JSR POS_CURS
    CMP.b #01,D7
    BEQ GagnantJ2
    CMP.b #02,D7
    BEQ GagnantJ1
    BRA Affiche2
FinTestGagnant:

GagnantJ1:                              *Affiche J1 gagnant
    MOVE.b #02,D7
    MOVE.L #CHAINE5,A0
    
    MOVE.w D1,A2
    MOVE.w #$180D,D1  
    JSR POS_CURS
    MOVE.w #00,D1
CHAINEGagnantJ1:
    MOVE.b (A0),D1
    CMP.b #0,D1
    BEQ ScoreJ1plus1
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINEGagnantJ1
FinGagnantJ1

ScoreJ1plus1:                       *Systeme du scoring pour le joueur 1 + affichage
    CMP.w #$39,A5
    BEQ TestScoreJ1
    MOVE.w #$4A15,D1  
    JSR POS_CURS
    MOVE A5,D1
    ADD #01,D1
    JSR AFFCAR
    MOVE D1,A5
    BRA AfficheRecommencerPartie
FinScoreJ1plus1

TestScoreJ1:
    CMP.w #00,A4
    BEQ n10J1
    CMP.w #01,A4
    BEQ n20J1
    CMP.w #02,A4
    BEQ n30J1
    CMP.w #03,A4
    BEQ n40J1
    CMP.w #04,A4
    BEQ n50J1
    CMP.w #05,A4
    BEQ n60J1
    CMP.w #06,A4
    BEQ n70J1
    CMP.w #07,A4
    BEQ n80J1
    CMP.w #08,A4
    BEQ n90J1          
FinTestScoreJ1

n10J1:
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
    BRA AfficheRecommencerPartie
Finn10J1

n20J1:
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
    BRA AfficheRecommencerPartie
Finn20J1

n30J1:
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
    BRA AfficheRecommencerPartie
Finn30J1

n40J1:
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
    BRA AfficheRecommencerPartie
Finn40J1

n50J1:
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
    BRA AfficheRecommencerPartie
Finn50J1

n60J1:
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
    BRA AfficheRecommencerPartie
Finn60J1

n70J1:
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
    BRA AfficheRecommencerPartie
Finn70J1

n80J1:
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
    BRA AfficheRecommencerPartie
Finn80J1

n90J1:
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
    BRA AfficheRecommencerPartie
Finn90J1

GagnantJ2:              ************************Affiche J2 gagnant
    MOVE.b #02,D7
    MOVE.L #CHAINE6,A0
    
    MOVE.w D1,A2
    MOVE.w #$180D,D1  
    JSR POS_CURS
    MOVE.w #00,D1
CHAINEGagnantJ2:
    MOVE.b (A0),D1
    CMP.b #0,D1
    BEQ ScoreJ2plus1
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINEGagnantJ2
FinGagnantJ2

ScoreJ2plus1:                   *Systeme du scoring pour le joueur 2 + affichage
    CMP.w #$39,A6
    BEQ TestScoreJ2
    MOVE.w #$5C15,D1  
    JSR POS_CURS
    MOVE A6,D1
    ADD #01,D1
    JSR AFFCAR
    MOVE D1,A6
    BRA AfficheRecommencerPartie
FinScoreJ2plus1

TestScoreJ2:
    CMP.w #00,A3
    BEQ n10J2
    CMP.w #01,A3
    BEQ n20J2
    CMP.w #02,A3
    BEQ n30J2
    CMP.w #03,A3
    BEQ n40J2
    CMP.w #04,A3
    BEQ n50J2
    CMP.w #05,A3
    BEQ n60J2
    CMP.w #06,A3
    BEQ n70J2
    CMP.w #07,A3
    BEQ n80J2
    CMP.w #08,A3
    BEQ n90J2
    *CMP.w #09,A3
    *BEQ stopaffiche
FinTestScoreJ2

n10J2:
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
    BRA AfficheRecommencerPartie
Finn10J2

n20J2:
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
    BRA AfficheRecommencerPartie
Finn20J2

n30J2:
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
    BRA AfficheRecommencerPartie
Finn30J2

n40J2:
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
    BRA AfficheRecommencerPartie
Finn40J2

n50J2:
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
    BRA AfficheRecommencerPartie
Finn50J2

n60J2:
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
    BRA AfficheRecommencerPartie
Finn60J2

n70J2:
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
    BRA AfficheRecommencerPartie
Finn70J2

n80J2:
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
    BRA AfficheRecommencerPartie
Finn80J2

n90J2:
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
    BRA AfficheRecommencerPartie
Finn90J2

AfficheRecommencerPartie:               *Affichage reboot game
    CMP.b #00,D7
    BNE effaceINUTILE
    MOVE.L	#finjeu,A1
    JSR PLAY_SOUND
    
    MOVE.b #02,D7
    MOVE.L #CHAINE2,A0
    
    MOVE.l #$00,D1
    MOVE.w #$1018,D1  
    JSR POS_CURS
    MOVE.w #00,D1
CHAINERecommencerPartie:
    MOVE.b (A0),D1
    CMP.b #0,D1
    BEQ RecommencerPartie
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINERecommencerPartie
FinAfficheRecommencerPartie

RecommencerPartie:
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
    
BOUCLE:                         *Attente de l'action du joueur + zones cliquable 'oui' ou 'non' pour rejouer
    MOVE.w #00,D1
    JSR GET_MOUSE
    CMP.l #%00000001,D0
    BEQ Verif
    BRA BOUCLE
FINTANTQUE

Verif:
    MOVE.l D1,D7
    CMP.w #0380,D7
    BLT testb1
    CMP.w #0410,D7
    BGT testa1
    BRA BOUCLE
testb1:
    CMP.w #0340,D7
    BGT testb2
    BRA BOUCLE
testb2:
    SWAP D7
    CMP.w #0358,D7
    BGT testb3
    BRA BOUCLE
testb3:
    CMP.w #0380,D7
    BLT Rebootgame
    BRA BOUCLE
testa1:
    CMP.w #0450,D7
    BLT testa2
    BRA BOUCLE
testa2:
    SWAP D7
    CMP.w #0358,D7
    BGT testa3
    BRA BOUCLE
testa3:
    CMP.w #0380,D7
    BLT aaurevoir
    BRA BOUCLE
FinVerif

aaurevoir:                          *Affichage au revoir si 'non'
    MOVE.L #Aurevoir,A0
    MOVE.w #$1611,D1  
    JSR POS_CURS
CHAINEaurevoir:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FINPROG
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINEaurevoir
Finaaurevoir

INUTILE:                            *Message de prévention, empéche le joueur d'appuyer n'importe ou
    MOVE.L #cInutile,A0
    MOVE.w #$0C1D,D1  
    JSR POS_CURS
CHAINEINUTILE:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ BOUCLEG
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINEINUTILE
FinINUTILE

effaceINUTILE:                  *Enléve le message de prévention
    MOVE.b #00,D7
    MOVE.L #ChaineEffacement,A0
    MOVE.w #$0C1D,D1  
    JSR POS_CURS
CHAINEeffINUTILE:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ AfficheRecommencerPartie
    JSR AFFCAR
    ADD.L #1,A0
    
    BRA CHAINEeffINUTILE
FineffaceINUTILE

FINPROG:                        *Fin du sous programme
    BRA FINPRG
    RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
