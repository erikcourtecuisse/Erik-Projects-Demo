#ifndef ITEM_H
#define ITEM_H

#include <string>

class Item
{
public:
    Item();
    ~Item();
    Item(std::string nom, std::string descritpion, bool equipable /* std::string effet */);
    //void utiliser(this);

private:
    std::string m_nomItem;
    std::string m_descritpionItem;
    bool m_equipable;
    //std::string m_effet;

};

#endif // ITEM_H
