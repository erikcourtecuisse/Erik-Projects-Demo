#ifndef FIGHTSYSTEM_H
#define FIGHTSYSTEM_H

#include <iostream>
#include <string>
#include <cstdlib>
#include "Character.h"
#include "Hero.h"

void fightSystem(Character* hero,Character* monstre);
std::string choixAttaqueMonstre(int choixCombatMonstre);
int compareAttaque(int choixCombatHero,int choixCombatMonstre);
void executeRound(Character* hero,Character* monstre,int choixActionHero);

#endif // FIGHTSYSTEM_H
