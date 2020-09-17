#include "Labyrinthe.h"

std::string m_nomLAB;

Labyrinthe::Labyrinthe(std::string nameFile) :
    m_nomLAB(nameFile)
{
    m_nomLAB=nameFile;
    srand((unsigned)time(NULL));

    //int TAILLELAB(11);
    int tabLab[TAILLELAB][TAILLELAB];
    int k(0);
    int i(0);
    int j(0);
    int NbCasesAZero(1);
    int hasard_x(0);
    int hasard_y(0);
    int d(0);
    int m_position(0);
    int placeSortie = rand_a_b(1,3); //definir l'emplacement de la sortie entre 1 et 3
    int placeBossH = rand_a_b(2,TAILLELAB-6); // emplacement de la porte du boss en X entre la 4 et 16 iem lignes comprises
    int placeBossL = rand_a_b(2,TAILLELAB-3);  // emplacement de la porte du boss en Y entre la 2 et la 15 iem colonne comprises

    if(TAILLELAB%2==1 && TAILLELAB>=21)
    {
        // initialisation
        for(i=0;i<TAILLELAB;i++)
        {
            for(j=0;j<TAILLELAB;j++)
            {
                if(i%2==1 && j%2==1) // ou &1 operateur binaire
                {
                    tabLab[i][j]=k;
                    k++;
                }
                else
                {
                    tabLab[i][j]=-1;
                }
            }
        }

        //Construction du labyrinthe
        while(NbCasesAZero<((TAILLELAB/2)*(TAILLELAB/2)))
        {
            randomDirection(tabLab, &hasard_x, &hasard_y);
            if(hasard_x%2==1)
            {
                d=tabLab[hasard_x][hasard_y-1]-tabLab[hasard_x][hasard_y+1];
                if(d>0)
                {
                    tabLab[hasard_x][hasard_y]=tabLab[hasard_x][hasard_y+1];
                    m_position = tabLab[hasard_x][hasard_y-1];
                    for(i=0;i<TAILLELAB;i++)
                    {
                        for(j=0;j<TAILLELAB;j++)
                        {
                            if(tabLab[i][j]==m_position)
                            {
                                tabLab[i][j]==tabLab[hasard_x][hasard_y+1];
                                if((i%2==1) && (j%2==1) && (tabLab[i][j]==0))
                                {
                                    NbCasesAZero++;
                                }
                            }
                        }
                    }
                }
                else if(d<0)
                {
                    tabLab[hasard_x][hasard_y]=tabLab[hasard_x][hasard_y-1];
                    m_position=tabLab[hasard_x][hasard_y+1];
                    for(i=0;i<TAILLELAB;i++)
                    {
                        for(j=0;j<TAILLELAB;j++)
                        {
                            if(tabLab[i][j]==m_position)
                            {
                                tabLab[i][j]=tabLab[hasard_x][hasard_y-1];
                                if((i%2==1)&&(j%2==1)&&(tabLab[i][j]==0))
                                {
                                    NbCasesAZero++;
                                }
                            }
                        }
                    }
                }
            }
                else if(hasard_y%2==1)
                {
                    d=tabLab[hasard_x-1][hasard_y]-tabLab[hasard_x+1][hasard_y];
                    if(d>0)
                    {
                        tabLab[hasard_x][hasard_y] = tabLab[hasard_x+1][hasard_y];
                        m_position=tabLab[hasard_x-1][hasard_y];
                        for(i=0;i<TAILLELAB;i++)
                        {
                            for(j=0;j<TAILLELAB;j++)
                            {
                                if(tabLab[i][j]==m_position)
                                {
                                    tabLab[i][j]=tabLab[hasard_x+1][hasard_y];
                                    if((i%2==1)&&(j%2==1)&&(tabLab[i][j]==0))
                                    {
                                        NbCasesAZero++;
                                    }
                                }
                            }
                        }
                    }

                else if(d<0)
                {
                    tabLab[hasard_x][hasard_y] = tabLab[hasard_x-1][hasard_y];
                    m_position = tabLab[hasard_x+1][hasard_y];
                    for(i=0;i<TAILLELAB;i++)
                    {
                        for(j=0;j<TAILLELAB;j++)
                        {
                            if(tabLab[i][j]==m_position)
                            {
                                tabLab[i][j]=tabLab[hasard_x-1][hasard_y];
                                if((i%2==1) && (j%2==1) && (tabLab[i][j]==0))
                                {
                                    NbCasesAZero++;
                                }
                            }
                        }
                    }
                }
            }
        }

        for(i=0;i<TAILLELAB;i++)
        {
            for(j=0;j<TAILLELAB;j++)
            {
                if(placeSortie==1 && i==TAILLELAB/2 && j==0 //On place les sorties (1=ouest,2=nord,3=est)
                       || (placeSortie==2 && i==0 && j==TAILLELAB/2)
                       || (placeSortie==3 && i==TAILLELAB/2 && j==TAILLELAB-1))
                {
                    tabLab[i][j]=3;
                }
                else if(i==TAILLELAB-1 && j==TAILLELAB/2) //On place l'entrée
                {
                    tabLab[i][j]=2;
                }

                else if((i==TAILLELAB-2 && j==TAILLELAB/2) //On place une cas libre devant l'entrée
                        || (placeSortie==1 && i==TAILLELAB/2 && j==1)//devant la sortie
                        || (placeSortie==2 && i==1 && j==TAILLELAB/2)
                        || (placeSortie==3 && i==TAILLELAB/2 && j==TAILLELAB-2))
                {
                    tabLab[i][j]=1;
                }
                else if (i==placeBossH && j==placeBossL)
                {
                    while(!(tabLab[placeBossH][placeBossL]==-1 //placer le boss sur un mur entouré par deux passages libres
                         && (((tabLab[placeBossH][placeBossL-1]==0 && tabLab[placeBossH][placeBossL+1]==0) && (tabLab[placeBossH-1][placeBossL]==-1 && tabLab[placeBossH+1][placeBossL]==-1))
                         || ((tabLab[placeBossH-1][placeBossL]==0 && tabLab[placeBossH+1][placeBossL]==0) && (tabLab[placeBossH][placeBossL-1]==-1 && tabLab[placeBossH][placeBossL+1]==-1)))))
                    {
                        placeBossH = rand_a_b(2,TAILLELAB-6);
                        placeBossL = rand_a_b(2,TAILLELAB-3);
                    }
                }
            }
        }

        for(i=0;i<TAILLELAB;i++)
        {
            for(j=0;j<TAILLELAB;j++)
            {
                tabLab[placeBossH][placeBossL]=4;
            }
        }
        //affichage(tabLab);
        ecrireLab(nameFile,tabLab);
    }
    else
        std::cout << "La variable de creation du labyrinthe n'est pas impair ou superieur a 21" << std::endl;

}

std::string Labyrinthe::getNomLab()
{
    return m_nomLAB;
}

int Labyrinthe::rand_a_b(int a, int b)
{
    if(a<=b)
    {
        return rand()%(b-a+1)+a;
    }
    else
        std::cout << "erreur dans la fonction rand_a_b";
    return 0;
}

void Labyrinthe::randomDirection(int tabLab[][TAILLELAB],int *hasard_x,int *hasard_y)
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

void Labyrinthe::affichage(int tabLab[][TAILLELAB])
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

void Labyrinthe::ecrireLab(std::string nameFile,int tabLab[][TAILLELAB])
{
    std::ifstream fluxReader((CHEMINSAVELAB+nameFile+EXTENSIONFILE).c_str());  //Ouverture d'un fichier en lecture
    if(fluxReader)
        std::cout << "Ce l'abyrinthe existe deja" << std::endl;
    else
    {
        std::ofstream fluxWritter((CHEMINSAVELAB+nameFile+EXTENSIONFILE).c_str());
        if(fluxWritter)
        {
            std::cout << "Creation du fichier" << std::endl;
            fluxWritter << CHEMINTILESET << std::endl;
            int i(0);
            int j(0);
            for(i=0;i<TAILLELAB;i++)
            {
                for(j=0;j<TAILLELAB;j++)
                {
                    if(j==TAILLELAB-1)
                    {
                        if(tabLab[i][j]==-1)
                            fluxWritter << "1,1";
                        else if(tabLab[i][j]==3)
                            fluxWritter << "0,0";
                    }
                    else
                    {
                        if(tabLab[i][j]==-1)
                            fluxWritter << "1,1 ";
                        else if(tabLab[i][j]==0)
                            fluxWritter << "0,1 ";
                        else if(tabLab[i][j]==2 || tabLab[i][j]==3)
                            fluxWritter << "0,0 ";
                        else if(tabLab[i][j]==4)
                            fluxWritter << "1,0 ";
                        else
                            fluxWritter << "0,1 ";
                    }
                }
                if(!(i==TAILLELAB-1 && j==TAILLELAB))
                    fluxWritter << std::endl;
            }
        }
        else
        {
            std::cout << "Probleme de lecture du flux labyrinthe" << std::endl;
        }
    }
}
