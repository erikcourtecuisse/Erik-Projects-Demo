#include "FightSystem.h"


void executeAttaque(int choixAttaqueHero,int choixAttaqueMonstre,Character* hero,Character* monstre)
{
    /*
    0= CAC
    1= Sort
    2= Parade
    */
    if(choixAttaqueHero==choixAttaqueMonstre)
    {
        std::cout << "Vous avez lance la meme attaque, vos attaques s'annullent !" << std::endl;
        //monstre->recevoirDegats(40);
        //std::cout << monstre->getHP() << std::endl;
    }
    else if (choixAttaqueHero==0 && choixAttaqueMonstre==1)
    {
        std::cout << "Vous avez touche le monstre au CAC !" << std::endl;
        hero->attaque(monstre,choixAttaqueHero);
    }
    else if (choixAttaqueHero==1 && choixAttaqueMonstre==2)
    {
        std::cout << "Vous avez touche le monstre avec un sort !" << std::endl;
        hero->attaque(monstre,choixAttaqueHero);
    }
    else if (choixAttaqueHero==2 && choixAttaqueMonstre==0)
    {
        std::cout << "Vous avez touche le monstre en contre-attaquant !" << std::endl;
        hero->attaque(monstre,choixAttaqueHero);
    }
    else if (choixAttaqueMonstre==0 && choixAttaqueHero==1)
    {
        std::cout << "Le monstre vous a touche au CAC !" << std::endl;
        monstre->attaque(hero,choixAttaqueMonstre);
    }
    else if (choixAttaqueMonstre==1 && choixAttaqueHero==2)
    {
        std::cout << "Le monstre vous a touche avec un sort !" << std::endl;
        monstre->attaque(hero,choixAttaqueMonstre);
    }
    else if (choixAttaqueMonstre==2 && choixAttaqueHero==0)
    {
        std::cout << "Le monstre vous a touche en contre-attaquant !" << std::endl;
        monstre->attaque(hero,choixAttaqueMonstre);
    }
}


void fightSystem(Character* hero,Character* monstre)
{
    std::cout << "--------------------------------------------------" << std::endl;
    std::cout << "---------------Le combat s'engage !---------------" << std::endl;
    std::cout << "--------------------------------------------------" << std::endl;
    std::cout << std::endl << std::endl;
    std::cout << "Vous avez face a vous : " << monstre->getNom() << std::endl;

    while(monstre->estVivant()==true && hero->estVivant()==true)
    {
        int choixActionHero(0);
        int choixActionMonstre(0);
        /*
        0= CAC
        1= Sort
        2= Parade
        */

        std::cout << "Que voulez vous faire ? " << std::endl << std::endl;;
        std::cout << "0 : CAC !" << std::endl;
        std::cout << "1 : Sortilege !" << std::endl;
        std::cout << "2 : Parer/Esquiver !" << std::endl;
        std::cout << "Votre choix : ";
        std::cin >> choixActionHero;
        std::cout << std::endl;


        switch(choixActionHero)
        {
        case 0:
            {
                std::cout << "Vous avez choisi d'attaquer au CAC !" << std::endl;
                executeRound(hero, monstre,choixActionHero);

                break;
            }
        case 1:
            {
                std::cout << "Vous avez choisi d'attaquer en envoyant un sortilege !" << std::endl;
                executeRound(hero, monstre,choixActionHero);

                break;
            }
        case 2:
            {
                std::cout << "Vous avez choisi de parer/essquiver" << std::endl;
                executeRound(hero, monstre,choixActionHero);

                break;
            }
        default :
                std::cout << "Ce choix n'est pas valide, chansissez une action valide !" << std::endl;
        }
    }
    if(monstre->getHP()==0)
        std::cout << "Vous etes venu a bout de : " << monstre->getNom() << std::endl;
    else
        std::cout << "L'ennemi vous a vaincu ... GAME OVER " << std::endl;
}



void executeRound(Character* hero,Character* monstre,int choixActionHero)
{
    int choixActionMonstre(0);
    std::cout << "Le " << monstre->getNom() << " utilise : ";
    choixActionMonstre = monstre->attaqueRandom();
    std::cout << std::endl;
    executeAttaque(choixActionHero,choixActionMonstre,hero,monstre);
    std::cout << "Votre sante est de : " << hero->getHP() << " sur : " << hero->getHPTotal() << " ! " << std::endl;
    std::cout << "La sante du : " << monstre->getNom() << " est de : " << monstre->getHP() << " sur : " << monstre->getHPTotal() << " ! " << std::endl;
    std::cout << "--------------------------------------------------" << std::endl;
    std::cout << std::endl;
}













