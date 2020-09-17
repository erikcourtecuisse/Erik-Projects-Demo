#include "Vue.h"

sf::Clock timer;
sf::RenderWindow window;
sf::Texture textureIntro;
sf::Texture textureMenu;
sf::Sprite spriteIntro;
sf::Sprite spriteMenu;
sf::View viewIntroMenu;
sf::Music musicIntro;
sf::Music musicMenu;
int transIntroFin(255);
int transMenu(0);
bool introActive(true);
bool menuActive(false);
bool transitionMenuActive(false);
bool jeuActive(false);
int posViewMenuX(0);
int posViewMenuY(0);

Vue::Vue()
{
    window.create(sf::VideoMode(sf::VideoMode::getDesktopMode().width/2,sf::VideoMode::getDesktopMode().height/2),"Donjon De Papier"); // /2 = moitier de lecran
    //window.create(sf::VideoMode(sf::VideoMode::getDesktopMode().width,sf::VideoMode::getDesktopMode().height),"Donjon De Papier",sf::Style::Fullscreen); // /2 = moitier de lecran
    //window.setPosition(sf::Vector2i(sf::VideoMode::getDesktopMode().width,sf::VideoMode::getDesktopMode().height));
    window.setFramerateLimit(60);
    window.setMouseCursorGrabbed(true); //fixer le cursor dans la fenetre
    posViewMenuX=(window.getSize().x);
    posViewMenuY=(window.getSize().y);

    if(!musicIntro.openFromFile("Musics&Sounds/MusicMenuVocalWav.wav"))
    {
        std::cout << "Error lors du chargement de la musique de l'intro ! " << std::endl;
    }
    if(!musicMenu.openFromFile("Musics&Sounds/MusicMenuMusicWav.wav"))
    {
        std::cout << "Error lors du chargement de la musique du menu ! " << std::endl;
    }
    if(!textureIntro.loadFromFile("Sprites&Textures/IntroBackGround.png"))
    {
        std::cout << "Error lors du chargement de la texture : Sprites&Textures/IntroBackGround.png" << std::endl;
    }
    if(!textureMenu.loadFromFile("Sprites&Textures/MenuBackGround.jpg"))
    {
        std::cout << "Error lors du chargement de la texture : Sprites&Textures/MenuBackGround.jpg" << std::endl;
    }

    musicIntro.play();
    musicMenu.setLoop(true);

    spriteIntro.setTexture(textureIntro);
    spriteMenu.setTexture(textureMenu);

    spriteMenu.setTextureRect(sf::IntRect(0,0,(textureMenu.getSize().x+window.getSize().x),textureMenu.getSize().y));
    //spriteMenu.setScale(1/window.getSize().x+1,1/window.getSize().x+1);
    textureMenu.setRepeated(true);
    int tailleTextureMenu(textureMenu.getSize().x);

    viewIntroMenu.reset(sf::FloatRect(0, 0, textureIntro.getSize().x,textureIntro.getSize().y));
    viewIntroMenu.zoom(0.20f);

    Menu menu(posViewMenuX,posViewMenuY);

    sf::Time tempsEcouleMusic = musicIntro.getPlayingOffset();

    while(window.isOpen())
    {
        ///////////////////////////////BOUCLE INTRO///////////////////////////////
        if(introActive==true)
        {
            sf::Time tempsEcoule = timer.getElapsedTime();
            if(tempsEcoule>=sf::milliseconds(1))
            {
                tempsEcouleMusic = musicIntro.getPlayingOffset();
                if(tempsEcouleMusic>sf::seconds(58))
                {
                    spriteIntro.setColor(sf::Color(255,255,255,transIntroFin--));
                    if(spriteIntro.getColor()==sf::Color(255,255,255,0))
                    {
                        introActive=false;
                    }
                }
                viewIntroMenu.zoom(1.00040f);
                timer.restart();
            }

            sf::Event event;
            while(window.pollEvent(event))
            {
                switch (event.type)
                {
                case sf::Event::KeyReleased:
                    switch (event.key.code)
                    {
                case sf::Keyboard::P:
                        introActive=false;
                        break;
                    }

                        break;
                    case sf::Event::Closed:
                        window.close();

                        break;

                    default:
                        break;
                }
            }

            window.clear();

            window.setView(viewIntroMenu);
            window.draw(spriteIntro);
            window.display();
        }
        ////////////////////////////////////////////////////////////////////////
        ///////////////////////////////BOUCLE Transition Intro/Menu///////////////////////////////
        if(introActive==false && menuActive==false )
        {
            viewIntroMenu.reset(sf::FloatRect(0, 0, posViewMenuX,posViewMenuY));
            musicIntro.stop();
            spriteMenu.setColor(sf::Color(255,255,255,transMenu));
            menuActive=true;
        }
        ////////////////////////////////////////////////////////////////////////
        ///////////////////////////////BOUCLE MENU///////////////////////////////
        if(menuActive==true)
        {
            sf::Time tempsEcoule = timer.getElapsedTime();
            if(tempsEcoule>=sf::milliseconds(1))
            {
                if(transMenu<255)
                {
                    spriteMenu.setColor(sf::Color(255,255,255,transMenu++));
                }
                else if(transitionMenuActive==true)
                {
                    spriteMenu.setColor(sf::Color(255,255,255,transMenu--));
                    if(transMenu==0)
                    {
                        menuActive=false;
                    }
                }
                if(spriteMenu.getPosition().x==-tailleTextureMenu)
                {
                    spriteMenu.setPosition(0,0);
                }
                spriteMenu.setPosition((spriteMenu.getPosition().x-1),spriteMenu.getPosition().y);

                if(musicMenu.getStatus()==sf::SoundSource::Stopped)
                {
                    musicMenu.play();
                }
            }

            sf::Event event;
            while(window.pollEvent(event))
            {
                switch (event.type)
                {
                case sf::Event::KeyReleased:
                    switch (event.key.code)
                    {
                    case sf::Keyboard::Up:
                        menu.MoveUp();
                        break;

                    case sf::Keyboard::Down:
                        menu.MoveDown();
                        break;

                    case sf::Keyboard::Return:
                        switch (menu.GetPressedItem())
                        {
                        case 0:
                            std::cout << "Le joueur veut jouer !! " << std::endl;
                            transitionMenuActive=true;
                            break;
                        case 1:
                            musicMenu.stop();
                            menuActive==false;
                            window.close();
                            break;
                        }
                        break;
                    }

                        break;
                    case sf::Event::Closed:
                        window.close();

                        break;

                    default:
                        break;
                }
            }

            window.clear();
            window.setView(viewIntroMenu);
            window.draw(spriteMenu);
            menu.draw(window);

            window.display();
        }
                ////////////////////////////////////////////////////////////////////////
        ///////////////////////////////BOUCLE Transition Menu/Jeu///////////////////////////////
        if(menuActive==false && jeuActive==false )
        {
            jeuActive==true;
        }
        ////////////////////////////////////////////////////////////////////////
        ///////////////////////////////BOUCLE Jeu///////////////////////////////
        if(jeuActive==true)
        {
            sf::Time tempsEcoule = timer.getElapsedTime();
            if(tempsEcoule>=sf::milliseconds(1))
            {
                //
            }

            sf::Event event;
            while(window.pollEvent(event))
            {
                switch (event.type)
                {
                case sf::Event::KeyReleased:
                    switch (event.key.code)
                    {
                    /*case sf::Keyboard:://
                        //
                        break;*/

                        break;
                    case sf::Event::Closed:
                        window.close();

                        break;

                    default:
                        break;
                    }
                }
            }

            window.clear();

            window.display();
        }
    }
}

Vue::~Vue()
{}

Menu::Menu(float width,float height)
{
    if(!font.loadFromFile("FontPolices/Sketch College.ttf"))
    {
        std::cout << "fontPolice load fail" << std::endl;
    }
    menu[0].setFont(font);
    menu[0].setCharacterSize(150);
    menu[0].setColor(sf::Color::Red);
    menu[0].setString("Jouer");
    menu[0].setPosition(sf::Vector2f(width/2-250,height/(MAX_NUMBER_OF_ITEMS+1)*1-150));

    menu[1].setFont(font);
    menu[1].setCharacterSize(150);
    menu[1].setColor(sf::Color::White);
    menu[1].setString("Quitter");
    menu[1].setPosition(sf::Vector2f(width/2-325,height/(MAX_NUMBER_OF_ITEMS+1)*2-150));

    selectedItemIndex = 0;
}

Menu::~Menu()
{}

void Menu::draw(sf::RenderWindow &window)
{

    for(int i=0; i<MAX_NUMBER_OF_ITEMS; i++)
    {
        window.draw(menu[i]);
    }
}

void Menu::MoveUp()
{

    if(selectedItemIndex - 1 >=0)
    {
       menu[selectedItemIndex].setColor(sf::Color::White);
       selectedItemIndex--;
       menu[selectedItemIndex].setColor(sf::Color::Red);
    }
}

void Menu::MoveDown()
{

    if(selectedItemIndex + 1 < MAX_NUMBER_OF_ITEMS)
    {
       menu[selectedItemIndex].setColor(sf::Color::White);
       selectedItemIndex++;
       menu[selectedItemIndex].setColor(sf::Color::Red);
    }
}
