#include <iostream>
#include <string>
#include "Character.h"
#include "Monstre.h"
#include "Hero.h"
#include "FightSystem.h"
#include "Labyrinthe.h"
#include "Game.h"

#include <SFML/Graphics.hpp>


int main()
{
    //Labyrinthe* Lab = new Labyrinthe("MonLab1");


    Game* fenetre = new Game();
    delete fenetre;

    /*std:: string choixNomHero("");
    std:: string choixClasseHero("");
    std:: string choixMonstre("");
    std::cout << "Nom du personnage : " << std::endl;
    std::cin >> choixNomHero;
    std::cout << std::endl;
    std::cout << "Classe de : " << choixNomHero << " (Voleur,Guerrier,Mage,Rustre) "<< std::endl;
    std::cin >> choixClasseHero;
    std::cout << std::endl;
    std::cout << "Monstre a affronter (Gobelin,Troll,Vampire,Squelette) : "<< std::endl;
    std::cin >> choixMonstre;
    Hero* hero1 = new Hero(choixNomHero,choixClasseHero);
    Monstre* monstre1 = new Monstre(choixMonstre);
    fightSystem(hero1,monstre1);
    delete hero1;
    delete monstre1;
    std::cin >> choixNomHero;*/

    return EXIT_SUCCESS;

}
