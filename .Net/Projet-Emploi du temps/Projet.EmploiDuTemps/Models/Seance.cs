using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace Projet.EmploiDuTemps.Models
{
    public class Seance
    {
        public int ID { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Date")]
        public DateTime Jour { get; set; }

        [Display(Name = "Heure de debut")]
        public int HeureDebut { get; set; }

        [Display(Name = "Duree (en heure)")]
        public int Duree { get; set; }

        [Display(Name = "Type de séance")]
        public int TypeSeanceID { get; set; }

        [Display(Name = "Salle")]
        public int SalleID { get; set; }

        [Display(Name = "Enseignement")]
        public int EnseignementID { get; set; }

        [Display(Name = "Enseignant")]
        public int EnseignantID { get; set; }

        public string Remarque { get; set; }

        [Range(1,52)]
        [Display(Name = "Semaine N°")]
        public int NumeroSemaine { get; set; }

        /// /////////////////////////////
        [Display(Name = "Type de seance")]
        public TypeSeance TypeSeance { get; set; }

        public Salle Salle { get; set; }

        public Enseignement Enseignement { get; set; }

        public Enseignant Enseignant { get; set; }

        public Groupe LeGroupe { get; set; }

        public UE LUE { get; set; }
    }
}
