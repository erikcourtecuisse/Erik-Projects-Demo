#include "Game.h"

sf::Vector2i screenDimensions(sf::VideoMode::getDesktopMode().width/2,sf::VideoMode::getDesktopMode().height/2);
sf::Clock timer;
sf::RenderWindow window;
sf::Texture textureIntro;
sf::Texture textureMenu;
sf::Texture textureMur1;
sf::Texture textureSol2;
sf::Sprite spriteIntro;
sf::Sprite spriteMenu;
sf::Sprite spriteMur1;
sf::Sprite spriteSol2;
sf::View viewIntroMenu;
sf::Music musicIntro;
sf::Music musicMenu;
sf::Event event;
sf::Vector2i blockDimensions(10,10);
sf::Texture player;
int transIntroFin(255);
int transMenu(0);
bool introActive(false);
bool transitionIntroMenu(false);
bool menuActive(false);
bool transitionMenuGame(false);
bool gameActive(true);
int posViewMenuX(0);
int posViewMenuY(0);
bool labDraw(false);
std::string nomLAB;
sf::Texture tileTexture;
sf::Sprite tiles;
sf::Vector2i map[100][100];
sf::Vector2i loadCounter = sf::Vector2i(0, 0);

Game::Game()
{
    window.create(sf::VideoMode(screenDimensions.x,screenDimensions.y),"Donjon De Papier"); // /2 = moitier de lecran
    //window.create(sf::VideoMode(sf::VideoMode::getDesktopMode().width,sf::VideoMode::getDesktopMode().height),"Donjon De Papier",sf::Style::Fullscreen); // /2 = moitier de lecran
    //window.setPosition(sf::Vector2i(sf::VideoMode::getDesktopMode().width,sf::VideoMode::getDesktopMode().height));
    window.setFramerateLimit(60);
    window.setMouseCursorGrabbed(false); //fixer le cursor dans la fenetre
    posViewMenuX=(window.getSize().x);
    posViewMenuY=(window.getSize().y);

    if(!player.loadFromFile("Sprites&Textures/Actor5.png"))
    {
        std::cout << "Error lors du chargement Actor5 " << std::endl;
    }
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
        if(!textureMur1.loadFromFile("Sprites&Textures/Mur1.png"))
    {
        std::cout << "Error lors du chargement de la texture : Sprites&Textures/Mur1.png" << std::endl;
    }
        if(!textureSol2.loadFromFile("Sprites&Textures/Sol2.jpg"))
    {
        std::cout << "Error lors du chargement de la texture : Sprites&Textures/Sol2.jpg" << std::endl;
    }

    if(introActive==true)
        musicIntro.play();

    musicMenu.setLoop(true);

    spriteIntro.setTexture(textureIntro);
    spriteMenu.setTexture(textureMenu);

    spriteMenu.setTextureRect(sf::IntRect(0,0,(textureMenu.getSize().x+window.getSize().x),textureMenu.getSize().y));
    //spriteMenu.setScale(1/window.getSize().x+1,1/window.getSize().x+1);
    textureMenu.setRepeated(true);
    int tailleTextureMenu(textureMenu.getSize().x);

    spriteMur1.setTexture(textureMur1);
    spriteMur1.setTextureRect(sf::IntRect(0,0,300,300));
    spriteSol2.setTexture(textureSol2);
    spriteSol2.setTextureRect(sf::IntRect(0,0,300,300));

    Hero* Bastrof = new Hero("Bastrof","Guerrier",sf::Vector2f(10, 10),player);
    Hero* Sno1000 = new Hero("Sno","Mage",sf::Vector2f(100, 100),player);

    viewIntroMenu.reset(sf::FloatRect(0, 0, textureIntro.getSize().x,textureIntro.getSize().y));
    viewIntroMenu.zoom(0.20f);

    Menu menu(posViewMenuX,posViewMenuY);

    sf::Time tempsEcouleMusic = musicIntro.getPlayingOffset();
    //introActive=true;
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
                        transitionIntroMenu=true;
                    }
                }
                viewIntroMenu.zoom(1.00040f);
                timer.restart();
            }

            while(window.pollEvent(event))
            {
                switch (event.type)
                {
                case sf::Event::KeyReleased:
                    switch (event.key.code)
                    {
                case sf::Keyboard::P:
                        introActive=false;
                        transitionIntroMenu=true;
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
        if(transitionIntroMenu==true )
        {
            viewIntroMenu.reset(sf::FloatRect(0, 0, posViewMenuX,posViewMenuY));
            musicIntro.stop();
            spriteMenu.setColor(sf::Color(255,255,255,transMenu));
            transitionIntroMenu=false;
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
                else if(transitionMenuGame==true)
                {
                    spriteMenu.setColor(sf::Color(255,255,255,transMenu--));
                    if(transMenu==0)
                    {
                        menuActive=false;
                        transitionMenuGame=true;
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
                            menuActive=false;
                            transitionMenuGame=true;
                            break;
                        case 1:
                            musicMenu.stop();
                            transitionMenuGame=true;
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
        if(transitionMenuGame==true )
        {
            transitionMenuGame=false;
            musicMenu.stop();
            gameActive=true;
        }
        ////////////////////////////////////////////////////////////////////////
        ///////////////////////////////BOUCLE Jeu///////////////////////////////
        if(gameActive==true)
        {
            if(labDraw == false)
            {
                //std::cin >> nomLAB;
                //Labyrinthe Lab(nomLAB);

                std::string nameFile("lol");
                std::ifstream openfile((CHEMINSAVELAB+nameFile+EXTENSIONFILE).c_str());

                if(openfile.is_open())
                {
                    std::string tileLocation;
                    openfile >> tileLocation;
                    tileTexture.loadFromFile(tileLocation);
                    tiles.setTexture(tileTexture);
                    while(!openfile.eof())
                    {
                        std::string str;
                        openfile >> str;
                        char x = str[0], y = str[2];
                        if(!isdigit(x) || !isdigit(y))
                            map[loadCounter.x][loadCounter.y] = sf::Vector2i(-1, -1);
                        else
                            map[loadCounter.x][loadCounter.y] = sf::Vector2i(x - '0', y - '0');

                        if(openfile.peek() == '\n')
                        {
                            loadCounter.x = 0;
                            loadCounter.y++;
                        }
                        else
                            loadCounter.x++;
                    }
                    loadCounter.y++;

                    labDraw = true;
                }
            }
            while(window.pollEvent(event))
            {
                switch (event.type)
                {
                    case sf::Event::Closed:
                        window.close();

                        break;

                    default:
                        break;
                }
            }

            if(sf::Keyboard::isKeyPressed(sf::Keyboard::Right))
                Bastrof->playerTex.move(1.0f, 0);
            else if(sf::Keyboard::isKeyPressed(sf::Keyboard::Left))
                Bastrof->playerTex.move(-1.0f, 0);
            else if(sf::Keyboard::isKeyPressed(sf::Keyboard::Up))
                Bastrof->playerTex.move(0, -1.0f);
            else if(sf::Keyboard::isKeyPressed(sf::Keyboard::Down))
                Bastrof->playerTex.move(0, 1.0f);

            Bastrof->Update();
            Sno1000->Update();

            if(Bastrof->Collision(Sno1000))
                std::cout << "Collision!" << std::endl;

            window.clear();
            //On dessine le labyrinthe en sous couche
            for(int i = 0; i < loadCounter.x; i++)
            {
                for(int j = 0; j < loadCounter.y; j++)
                {
                    if(map[i][j].x != -1 && map[i][j].y != -1)
                    {
                        tiles.setPosition(i * RESOLUTIONTILES, j * RESOLUTIONTILES);
                        tiles.setTextureRect(sf::IntRect(map[i][j].x * RESOLUTIONTILES, map[i][j].y * RESOLUTIONTILES, RESOLUTIONTILES, RESOLUTIONTILES));
                        window.draw(tiles);
                    }
                }
            }


            window.draw(Bastrof->playerTex);
            window.draw(Sno1000->playerTex);
            window.display();
        }
    }
}

Game::~Game()
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
