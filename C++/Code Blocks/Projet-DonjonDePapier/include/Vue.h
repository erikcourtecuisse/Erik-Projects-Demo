#ifndef VUE_H
#define VUE_H

#include <iostream>
#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Audio.hpp>

#define MAX_NUMBER_OF_ITEMS 2

class Vue
{
public:
    Vue();
    ~Vue();
    void infiniteBackGroundMenu(sf::Texture,sf::Sprite);
    void LoadTexture(sf::Texture texture,std::string pathTexture);
    void LoadMusic(sf::Music music ,std::string pathMusic);

private:

};

class Menu
{
public:
    Menu(float width, float height);
    ~Menu();

    void draw(sf::RenderWindow &window);
    void MoveUp();
    void MoveDown();
    int GetPressedItem() { return selectedItemIndex; }

private:
    int selectedItemIndex;
    sf::Font font;
    sf::Text menu[MAX_NUMBER_OF_ITEMS];

};

#endif // VUE_H
