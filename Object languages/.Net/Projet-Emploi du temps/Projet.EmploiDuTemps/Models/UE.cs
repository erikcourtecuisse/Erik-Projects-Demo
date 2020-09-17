using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Projet.EmploiDuTemps.Models
{
    public class UE
    {
        public int ID { get; set; }

        public string Numero { get; set; }

        public string Intitule { get; set; }

        public string NomComplet
        {
            get
            {
                return Numero + " - " + Intitule;
            }
        }

        public ICollection<Groupe> LesGroupes { get; set; }
        public ICollection<Seance> LesSeances { get; set; }
    }
}
