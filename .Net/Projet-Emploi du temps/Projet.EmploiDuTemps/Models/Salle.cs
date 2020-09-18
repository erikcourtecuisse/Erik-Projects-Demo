using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Projet.EmploiDuTemps.Models
{
    public class Salle
    {
        public int ID { get; set; }
        
        public string NomSalle { get; set; }

        public int BatimentID { get; set; }

        public Batiment Batiment { get; set; }
    }
}
