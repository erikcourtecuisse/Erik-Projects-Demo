#ifndef LABYRINTHE_H
#define LABYRINTHE_H

#define TAILLELAB 21
#define CHEMINSAVELAB "Sauvegardes/SauvegardesLab/"
#define EXTENSIONFILE ".txt"
#define CHEMINTILESET "Sprites&Textures/Tiles.png"
#define RESOLUTIONTILES 32

#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <cstdlib>
#include <time.h>
#include <io.h>
#include <fstream>
#include <string>

class Labyrinthe
{
public:
    Labyrinthe(std::string nameFile);
    int rand_a_b(int a,int b);
    void randomDirection(int tabLab[][TAILLELAB],int *hasard_x,int *hasard_y);
    void affichage(int tabLab[][TAILLELAB]);
    void ecrireLab(std::string nameFile,int tabLab[][TAILLELAB]);
    std::string getNomLab();

protected:
    std::string m_nomLAB;

private:
};

#endif // LABYRINTHE_H
