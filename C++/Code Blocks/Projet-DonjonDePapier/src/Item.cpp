#include "Item.h"

using namespace std;

string m_nomItem;
string m_descritpionItem;
bool m_equipable;
//std::string m_effet;

Item::Item() :
    m_nomItem("usless"),m_descritpionItem("Usless Item"),m_equipable(false)
{
}

Item::Item(string nom,string descritpion,bool equipable)
{
    m_nomItem = nom;
    m_descritpionItem = descritpion;
    m_equipable = equipable;
}

/*void Item::Utiliser()
{
    //
}*/

Item::~Item()
{}
