using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Projet.EmploiDuTemps.Models
{
    public class Batiment
    {
        public int ID { get; set; }

        public string NomBatiment { get; set; }
       
        public ICollection<Salle> LesSalles { get; set; }
    }
}
