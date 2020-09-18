using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Projet.EmploiDuTemps.Models
{
    public class Groupe
    {
        public int ID { get; set; }

        public string NomGroupe { get; set; }

        public UE LUE { get; set; }
        public ICollection<Seance> LesSeances { get; set; }
    }
}
