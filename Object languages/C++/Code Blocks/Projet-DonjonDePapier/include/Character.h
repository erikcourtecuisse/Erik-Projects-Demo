#ifndef CHARACTER_H
#define CHARACTER_H

#include <ctime>
#include <cstdlib>
#include <iostream>
#include <string>
#include "Item.h"

class Character
{
public:
        Character();
        ~Character();
        Character(std::string nom, int hP, int powerCAC, int powerSort, int powerParade);
        void attaque(Character* &cible,int typeAttaque);
        int attaqueRandom();
        void recevoirDegats(int nbDegats);
        void recupereVie(int pV);
        void afficherEtat();
        bool estVivant();
        std::string getNom();
        int getHP();
        int getHPTotal();

protected:
        std::string m_nom;
        //string m_description;
        int m_hP;
        int m_hPTotal;
        int m_powerCAC;
        int m_powerSort;
        int m_powerParade;

private:

};

#endif // CHARACTER_H
