#include "Character.h"

std::string m_nom;
//string m_description;
int m_hP;
int m_hPTotal;
int m_powerCAC;
int m_powerSort;
int m_powerParade;

Character::Character() :
    m_nom("inconnu"),m_hP(0),m_powerCAC(0),m_powerSort(0),m_powerParade(0)
{
    m_hPTotal=m_hP;
}

Character::Character(std::string nom, int hP, int powerCAC, int powerSort,int powerParade):
    m_nom(nom),m_hP(hP),m_powerCAC(powerCAC),m_powerSort(powerSort),m_powerParade(powerParade)
{
    m_hPTotal=m_hP;
}

void Character::recevoirDegats(int nbDegats)
{
    m_hP -= nbDegats;

    if (m_hP < 0)
    {
        m_hP = 0;
    }
}

void Character::recupereVie(int hP)
{
    m_hP += hP;

    if (m_hP > m_hPTotal)
    {
        m_hP = m_hPTotal;
    }
}

void Character::attaque(Character* &cible,int typeAttaque)
{
    if(typeAttaque==0)
    {
        cible->recevoirDegats(m_powerCAC);
    }
    if(typeAttaque==1)
    {
        cible->recevoirDegats(m_powerSort);
    }
    if(typeAttaque==2)
    {
        cible->recevoirDegats(m_powerParade);
        this->recupereVie(5);
    }
}

void Character::afficherEtat()
{
    std::cout << "---Caracteristiques du personnage : ---" <<std::endl;
    std::cout << "Points de vie : " << m_hP << std::endl;
    std::cout << "Puissance CAC : " << m_powerCAC << std::endl;
    std::cout << "Puissance sort : "<< m_powerSort << std::endl;
    std::cout << "Puissance parade : " << m_powerParade << std::endl;
    std::cout << "------------" << std::endl;
    if(m_hP==m_hPTotal)
        std::cout << m_nom << " est en pleine forme !"<< std::endl;
    else if(m_hP>=(0.75*m_hPTotal) && m_hP<m_hPTotal)
        std::cout << m_nom << " est blesse mais il s'en sort bien !"<< std::endl;
    else if(m_hP>=(0.50*m_hPTotal) && m_hP<(0.75*m_hPTotal))
        std::cout << m_nom << " ressent les effets du combat !"<< std::endl;
    else if(m_hP>=(0.25*m_hPTotal) && m_hP<(0.50*m_hPTotal))
        std::cout << m_nom << " fatigue sérieusement !"<< std::endl;
    else if(m_hP>(0.00*m_hPTotal) && m_hP<(0.25*m_hPTotal))
        std::cout << m_nom << " est a l'article de la mort !"<< std::endl;
    else if(m_hP==0)
        std::cout << m_nom << " est en train de servir de repas aux asticots !"<< std::endl;
}

bool Character::estVivant()
{
    if(m_hP<=0)
        return false;
    else
        return true;
}

std::string Character::getNom()
{
    return m_nom;
}

int Character::getHP()
{
    return m_hP;
}

int Character::getHPTotal()
{
    return m_hPTotal;
}


int Character::attaqueRandom()
{
    /*
    0= CAC
    1= Sort
    2= Parade
    */
    srand(time(0));
    int typeAttaque(0);
    typeAttaque = rand() % 3;
    if(typeAttaque==0)
    {
        std::cout << "CAC" << std::endl;
    }
    if(typeAttaque==1)
    {
        std::cout << "sort" << std::endl;
    }
    if(typeAttaque==2)
    {
        std::cout << "Parade/Esquive" << std::endl;
    }
    return typeAttaque;
}


Character::~Character()
{}





