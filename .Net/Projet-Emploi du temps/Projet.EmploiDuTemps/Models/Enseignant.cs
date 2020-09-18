using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Projet.EmploiDuTemps.Models
{
    public class Enseignant
    {
        public int ID { get; set; }

        public string Nom { get; set; }

        public string Prenom { get; set; }

        public string NomComplet
        {
            get
            {
                return Nom + "  " + Prenom;
            }
        }
    }
}
