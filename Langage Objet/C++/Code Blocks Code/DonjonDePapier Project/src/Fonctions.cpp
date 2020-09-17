/*#include "Fonctions.h"

int rand_a_b(int a, int b)
{
    if(a<=b)
    {
        return rand()%(b-a+1)+a;
    }
    else
        std::cout << "erreur dans la fonction rand_a_b";
    return 0;
}

void randomDirection(int tabLab[][TAILLELAB],int *hasard_x,int *hasard_y)
{
    *hasard_x = (rand()%(TAILLELAB-2))+1;
    *hasard_y = (rand()%(TAILLELAB-2))+1;
    while(1)
    {
        *hasard_x = (rand()%(TAILLELAB-2))+1;
        *hasard_y = (rand()%(TAILLELAB-2))+1;

        if((tabLab[*hasard_x][*hasard_y]==-1) && (((*hasard_x%2==1) && !(*hasard_y%2==1)) || (!(*hasard_x%2==1) && (*hasard_y%2==1))))
            break;
    }
}

void affichage(int tabLab[][TAILLELAB])
{
    int i(0);
    int j(0);
    for(i=0;i<TAILLELAB;i++)
    {
        for(j=0;j<TAILLELAB;j++)
        {
            if(tabLab[i][j]==-1)
                std::cout << "0 ";
            else if(tabLab[i][j]==0)
                std::cout << "1 ";
            else
                std::cout << tabLab[i][j] << " ";
        }
        std::cout << std::endl;
    }
}
*/
