*-----------------------------------------------------------
* Title      :Jeux de Nime Main (Menu de lancement du jeu)
* Written by :Courtecuisse Erik & Goeffrey Caduela
* Description:Projet archi 2016
*-----------------------------------------------------------
    ORG    $2000            
    
    MOVE.l #$00FFFFFF,D1    *Selection des couleurs
    JSR SET_PEN_COLOR
    
    MOVE.l #$00000000,D1
    JSR RESOLUTION
    
    ***************************************************

    *MOVE.L	#Menumuse,A1        Possibilité de mettre une musique de fond
    *JSR PLAY_SOUND

AffjeudeNime:                   *affichage du menu de choix du mode de jeu
    MOVE.L #JeuDeNime,A0
    MOVE.w #$2209,D1  
    JSR POS_CURS
CHAINEAffjeudeNime:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAffjeudeNime
    MOVE.w D1,D2 
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAffjeudeNime
FinAffjeudeNime

Affsolo:
    MOVE.L #Solo,A0
    MOVE.w #$1012,D1  
    JSR POS_CURS
CHAINEAffsolo:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAffsolo
    MOVE.w D1,D2 
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAffsolo
FinAffsolo

Affmulti:
    MOVE.L #Multi,A0
    MOVE.w #$2B12,D1  
    JSR POS_CURS
CHAINEAffmulti:
    MOVE.b (A0),D1
    CMP.b #00,D1
    BEQ FinAffmulti
    MOVE.w D1,D2 
    MOVE.b #$01,D7
    JSR AFFCAR
    ADD.L #1,A0
    BRA CHAINEAffmulti
FinAffmulti

    MOVE.w #120,D1
    MOVE.w #260,D2
    MOVE.w #245,D3
    MOVE.w #290,D4
    JSR DRAW_RECT
    
    MOVE.w #120,D1
    MOVE.w #260,D2
    MOVE.w #247,D3
    MOVE.w #292,D4
    JSR DRAW_RECT
    
    MOVE.w #340,D1
    MOVE.w #260,D2
    MOVE.w #520,D3
    MOVE.w #290,D4
    JSR DRAW_RECT
    
    MOVE.w #340,D1
    MOVE.w #260,D2
    MOVE.w #522,D3
    MOVE.w #292,D4
    JSR DRAW_RECT


BOUCLEmain:                 *Boucle d'attente de l'action du joueur
    MOVE.w #00,D1
    JSR GET_MOUSE
    CMP.l #%00000001,D0
    BEQ Test
    BRA BOUCLEmain
FINTANTQUEbouclemain

Test:                   *Creation des zones cliquables pour le choix du mode de jeu
    MOVE.l D1,D7
    CMP.w #0245,D7
    BLT verifb1
    CMP.w #0340,D7
    BGT verifa1
    BRA BOUCLEmain
verifb1:
    CMP.w #0120,D7
    BGT verifb2
    BRA BOUCLEmain
verifb2:
    SWAP D7
    CMP.w #0260,D7
    BGT verifb3
    BRA BOUCLEmain
verifb3:
    CMP.w #0290,D7
    BLT SoloMenu
    BRA BOUCLEmain
verifa1:
    CMP.w #0520,D7
    BLT verifa2
    BRA BOUCLEmain
verifa2:
    SWAP D7
    CMP.w #0260,D7
    BGT verifa3
    BRA BOUCLEmain
verifa3:
    CMP.w #0290,D7
    BLT GoMulti
    BRA BOUCLEmain
FinTest

SoloMenu:                   *Effacement du menu pour le remplacer par le choix de la difficulté en solo

    MOVE.l #$00000000,D1
    JSR SET_PEN_COLOR

    MOVE.w #120,D1
    MOVE.w #260,D2
    MOVE.w #245,D3
    MOVE.w #290,D4
    JSR DRAW_RECT
    
    MOVE.w #120,D1
    MOVE.w #260,D2
    MOVE.w #247,D3
    MOVE.w #292,D4
    JSR DRAW_RECT
    
    MOVE.w #340,D1
    MOVE.w #260,D2
    MOVE.w #520,D3
    MOVE.w #290,D4
    JSR DRAW_RECT
    
    MOVE.w #340,D1
    MOVE.w #260,D2
    MOVE.w #522,D3
    MOVE.w #292,D4
    JSR DRAW_RECT

    MOVE.L #ChaineEffacement,A0

    MOVE.w #$1012,D1  
    JSR POS_CURS
    MOVE.w #00,D1
CHAINEEFFACEmenu:
    MOVE.b (A0),D1
    CMP.b #0,D1
    BEQ ChoixDifficulte
    JSR AFFCAR
    ADD.L #1,A0

    BRA CHAINEEFFACEmenu
ChoixDifficulte:                *Creation du menu de choix de difficulté en solo
    
    MOVE.l #$00FFFFFF,D1
    JSR SET_PEN_COLOR

    MOVE.w #120,D1
    MOVE.w #260,D2
    MOVE.w #245,D3
    MOVE.w #290,D4
    JSR DRAW_RECT
    
    MOVE.w #120,D1
    MOVE.w #260,D2
    MOVE.w #247,D3
    MOVE.w #292,D4
    JSR DRAW_RECT
    
    MOVE.w #340,D1
    MOVE.w #260,D2
    MOVE.w #520,D3
    MOVE.w #290,D4
    JSR DRAW_RECT
    
    MOVE.w #340,D1
    MOVE.w #260,D2
    MOVE.w #522,D3
    MOVE.w #292,D4
    JSR DRAW_RECT
    
    MOVE.w #$1412,D1  
    JSR POS_CURS
    MOVE.L #Facile,A0
    MOVE.w #00,D1
AffichedifficulteF:
    MOVE.b (A0),D1
    CMP.b #0,D1
    BEQ Suite
    JSR AFFCAR
    ADD.L #1,A0

    BRA AffichedifficulteF
Suite:
    MOVE.w #$3112,D1  
    JSR POS_CURS
    MOVE.L #Impossible,A0
    MOVE.w #00,D1
AffichedifficulteI:
    MOVE.b (A0),D1
    CMP.b #0,D1
    BEQ FirstPatience
    JSR AFFCAR
    ADD.L #1,A0

    BRA AffichedifficulteI
FinChoixDifficulte
FINSoloMenu

FirstPatience               *Gestion d'un timming pour éviter de selectionner 'facile' automatiquement
    MOVE.L #00,D1
PatienceMain:
    ADD.L #01,D1
    CMP.L #$7F304,D1 **timming
    BEQ BOUCLEmain2
    BRA PatienceMain
FINPatienceMain

BOUCLEmain2:            *Attente de l'action du joueur
    MOVE.w #00,D1
    JSR GET_MOUSE
    CMP.l #%00000001,D0
    BEQ Test2
    BRA BOUCLEmain2
FINTANTQUEbouclemain2

Test2:                  *Zone cliquable du menu de choix de difficulté
    MOVE.l D1,D7
    CMP.w #0245,D7
    BLT verifb1a
    CMP.w #0340,D7
    BGT verifa1a
    BRA BOUCLEmain2
verifb1a:
    CMP.w #0120,D7
    BGT verifb2a
    BRA BOUCLEmain2
verifb2a:
    SWAP D7
    CMP.w #0260,D7
    BGT verifb3a
    BRA BOUCLEmain2
verifb3a:
    CMP.w #0290,D7
    BLT GoSolo
    BRA BOUCLEmain2
verifa1a:
    CMP.w #0520,D7
    BLT verifa2a
    BRA BOUCLEmain2
verifa2a:
    SWAP D7
    CMP.w #0260,D7
    BGT verifa3a
    BRA BOUCLEmain2
verifa3a:
    CMP.w #0290,D7
    BLT GoSoloImpo
    BRA BOUCLEmain2
FinTest2

GoMulti:                    *Direction vers le sous programme selectionné par le joueur
    JSR JeudeNimeMulti
    
GoSolo:
    JSR JeudeNimeSolo
    
GoSoloImpo:
    JSR JeudeNimeSoloImpo

FinPRGMAIN:
    BRA FINPRG
                                        *Enregistrement des chaines de caractére et inclusion des sous programmes
    JeuDeNime:Dc.b	'JEU DE NIME',0
    Solo:Dc.b	'Jouer en solo',0
    Multi:DC.b 'Jouer en multijoueurs',0
    craqueallumette:Dc.b	'craqueallumette.wav',0
    startgame:Dc.b	'startgame.wav',0
    finjeu:DC.b 'endgame.wav',0
    Menumuse:DC.b 'Musiquemenu.wav',0
    CHAINE:DC.b ' Au tour du joueur 1          ',0
    CHAINE1:DC.b ' Au tour du joueur 2           ',0
    CHAINE2:DC.b ' Voulez vous rejouer ?     oui      non',0
    CHAINE4:DC.b ' Combien prenez vous d''allumettes ? ',0
    CHAINE5:DC.b ' Le gagnant est le joueur 1 ',0
    CHAINE6:DC.b ' Le gagnant est le joueur 2 ',0
    ChaineEffacement:DC.b '                                                     ',0
    Aurevoir:DC.b 'Au revoir ! Merci d''avoir joué',0
    cInutile:DC.b 'Inutile d''appuyer sur une autre touche que 1,2 ou 3',0
    Regles0:Dc.b 'JEUX DE NIME regles :',0
    Regles1:Dc.b 'Il y a 20 allumettes, le but',0
    Regles2:Dc.b 'du jeu est de prendre a tour',0
    Regles3:Dc.b 'de role 1, 2 ou 3 allumettes.',0
    Regles4:Dc.b 'Celui qui prend la derniére gagne.',0
    Joueur1:Dc.b 'Joueur 1',0
    Joueur2:Dc.b 'Joueur 2',0
    Joueur1Solo:Dc.b ' Joueur',0
    Joueur2Solo:Dc.b 'Ordinateur',0
    CHAINE5Solo:DC.b ' Vous gagnez felicitation   ',0
    CHAINE6Solo:DC.b ' Le gagnant est l''ordinateur',0
    CHAINESolo:DC.b ' A votre tour                  ',0
    CHAINE1Solo:DC.b 'Au tour de l''ordinateur           ',0
    Facile:DC.b 'Facile',0
    Impossible:DC.b 'Impossible',0

    INCLUDE 'BIBGRAPH.X68'
    INCLUDE 'BIBPERIPH.X68'
    INCLUDE 'BIBLIO.X68'
    INCLUDE 'ProjetArchiMulti.X68'
    INCLUDE 'ProjetArchiSolo.X68'
    INCLUDE 'ProjetArchiSoloImpossible.X68'

    END    $2000











*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
