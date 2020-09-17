using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Projet.EmploiDuTemps.Models
{
    public class TypeSeance
    {
        public int ID { get; set; }

        public string Intitule { get; set; }

        public ICollection<Seance> LesSeances { get; set; }
    }
}
