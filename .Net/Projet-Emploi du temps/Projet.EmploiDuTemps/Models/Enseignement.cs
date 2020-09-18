using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Projet.EmploiDuTemps.Models
{
    public class Enseignement
    {
        public int ID { get; set; }

        public int GroupeID { get; set; }

        public int UEID { get; set; }

        public Groupe Groupe { get; set; }

        public UE UE { get; set; }
    }
}
