#include "Hero.h"

std::string m_classe;
Item m_listItemEquip[3];
Item m_listItemSac[5];
sf::Sprite playerTex;
float bottom,left,right,top;

std::vector<std::vector<bool>> mask;

Hero::Hero() : Character()
{
    m_hPTotal=m_hP;
    m_classe="classeNULL";
}

Hero::Hero(std::string nom, std::string classe, sf::Vector2f position, sf::Texture &texture) : Character()
{
    m_nom = nom;
    m_classe = classe;

    sf::Image image;
    image = texture.copyToImage();

    for(int i = 0; i < image.getSize().x; i++)
    {
        std::vector<bool> tempMask;
        for(int j = 0; j < image.getSize().y; j++)
        {
            if(image.getPixel(i, j).a > 0)
                tempMask.push_back(true);
            else
                tempMask.push_back(false);
        }
        mask.push_back(tempMask);
    }

    playerTex.setTexture(texture);
    playerTex.setPosition(position);

    if(m_classe=="Guerrier")
    {
        m_hP=100;
        m_hPTotal=m_hP;
        m_powerCAC=12;
        m_powerSort=7;
        m_powerParade=11;
    }

    else if(m_classe=="Mage")
    {
        m_hP=100;
        m_hPTotal=m_hP;
        m_powerCAC=8;
        m_powerSort=12;
        m_powerParade=10;
    }

    else if(m_classe=="Voleur")
    {
        m_hP=90;
        m_hPTotal=m_hP;
        m_powerCAC=11;
        m_powerSort=7;
        m_powerParade=13;
    }

    else if(m_classe=="Rustre")
    {
        m_hP=100;
        m_hPTotal=m_hP;
        m_powerCAC=10;
        m_powerSort=10;
        m_powerParade=10;
    }
}

void Hero::Update()
{
    bottom = playerTex.getPosition().y + playerTex.getTextureRect().height;
    left = playerTex.getPosition().x;
    right = playerTex.getPosition().x + playerTex.getTextureRect().width;
    top = playerTex.getPosition().y;
}

bool Hero::Collision(Hero* h)
{
    if(right < h->left || left > h->right || top > h->bottom || bottom < h->top)
    {
    }
    else
    {
        float colBottom, colTop, colLeft, colRight;
        colBottom = std::min(bottom, h->bottom);
        colTop = std::max(top, h->top);
        colLeft = std::max(left, h->left);
        colRight = std::min(right, h->right);

        for(int i = colTop; i<colBottom;i++)
        {
            for(int j = colLeft;j<colRight;j++)
            {
                if(mask[j - left][i - top] && h->mask[j - h->left][i - h->top])
                    return true;
            }
        }
    }
    return false;
}


void Hero::ramasserItem(Item item)
{
    //
}

void Hero::utiliserItem(Item item)
{
    //
}


void Hero::equiperItem(Item itemAEquiper)
{
    //
}

void Hero::jeterItem(Item item)
{
    //
}

void Hero::checkSac()
{
    //
}

void Hero::checkEquipement()
{
    //
}
