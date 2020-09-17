#ifndef HERO_H
#define HERO_H

#include <SFML/Graphics.hpp>
#include <iostream>
#include <algorithm>
#include "Character.h"
#include "Item.h"

class Hero : public Character
{
public:
    Hero();
    Hero(std::string nom, std::string classe, sf::Vector2f position, sf::Texture &texture);
    void Update();
    bool Collision(Hero* h);
    void ramasserItem(Item item);
    void utiliserItem(Item item);
    void equiperItem(Item itemAEquiper);
    void jeterItem(Item item);
    void checkSac();
    void checkEquipement();
    float bottom,left,right,top;
    sf::Sprite playerTex;
    std::vector<std::vector<bool>> mask;

private:

    std::string m_classe;
    Item m_listItemEquip[3];
    Item m_listItemSac[5];

};

#endif // HERO_H
