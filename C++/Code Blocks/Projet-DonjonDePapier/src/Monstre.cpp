#include "Monstre.h"

Monstre::Monstre() : Character()
{
    m_hPTotal=m_hP;
}

Monstre::Monstre(std::string nom): Character()
{
    m_nom = nom;
    if(m_nom=="Gobelin")
    {
        m_hP=50;
        m_hPTotal=m_hP;
        m_powerCAC=5;
        m_powerSort=1;
        m_powerParade=4;
    }
    else if(m_nom=="Troll")
    {
        m_hP=200;
        m_hPTotal=m_hP;
        m_powerCAC=18;
        m_powerSort=4;
        m_powerParade=12;
    }
    else if(m_nom=="Vampire")
    {
        m_hP=125;
        m_hPTotal=m_hP;
        m_powerCAC=10;
        m_powerSort=22;
        m_powerParade=13;
    }
    else if(m_nom=="Squelette")
    {
        m_hP=70;
        m_hPTotal=m_hP;
        m_powerCAC=7;
        m_powerSort=0;
        m_powerParade=7;
    }
}

/*void Monstre::utiliserSkill(Skill skill)
{
    //
}*/
