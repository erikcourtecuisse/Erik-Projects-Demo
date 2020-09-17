using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using Projet.EmploiDuTemps.Data;
using Projet.EmploiDuTemps.Models;

namespace Projet.EmploiDuTemps.Pages.Seances.EmploiDuTemps
{
    public class IndexModel : PageModel
    {
        private readonly Projet.EmploiDuTemps.Data.ApplicationDbContext _context;

        public List<Seance> LesSeances { get; set; }

        [BindProperty]
        public int NumeroSemaine { get; set; }

        public IndexModel(Projet.EmploiDuTemps.Data.ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task OnGetAsync()
        {
            LesSeances = await GetSeancesAsync();

            ViewData["Semaine"] = GetNumeroSemaine();

            List<Seance> SeancesParSemaine = GetSeancesParNumeroSemaine(LesSeances, NumeroSemaine);

            List<DateTime> joursSemaine = GetJoursSemaine(GetNumeroSemaine());
            ViewData["JoursSemaine"] = joursSemaine;

            ViewData["Seances"] = GetSeancesParNumeroSemaine(LesSeances, GetNumeroSemaine());
        }


        private async Task<List<Seance>> GetSeancesAsync()
        {
            return await _context.Seance
                                .Include(model => model.Enseignement)
                                    .ThenInclude(model => model.UE)
                                .Include(model => model.Enseignement)
                                    .ThenInclude(model => model.Groupe)
                                .Include(model => model.Enseignant)
                                .Include(model => model.TypeSeance)
                                .Include(model => model.Salle)
                                    .ThenInclude(model => model.Batiment)
                                .ToListAsync();
        }

        private List<Seance> GetSeancesParNumeroSemaine(List<Seance> lesSeances, int numeroSemaine)
        {
            List<Seance> mesSeances = new List<Seance>();
            List<DateTime> joursSemaine = GetJoursSemaine(numeroSemaine);

            foreach (Seance seance in lesSeances)
            {
                foreach (DateTime jour in joursSemaine)
                {
                    if (seance.Jour.ToString("d") == jour.ToString("d"))
                    {
                        mesSeances.Add(seance);
                    }
                }
            }

            mesSeances.Sort((x, y) => DateTime.Compare(x.Jour, y.Jour));

            return mesSeances;
        }


        private List<Seance> GetSeancesParJour(List<Seance> lesSeances, DayOfWeek jourSemaine)
        {
            List<Seance> mesSeances = new List<Seance>();

            foreach (Seance seance in lesSeances)
            {
                if (seance.Jour.DayOfWeek == jourSemaine)
                {
                    mesSeances.Add(seance);
                }
            }

            mesSeances.Sort((x, y) => DateTime.Compare(x.Jour, y.Jour));

            return mesSeances;
        }

        private List<DateTime> GetJoursSemaine(int numeroSemaine)
        {
            DateTime premierJour = PremierJour(numeroSemaine);
            List<DateTime> lesJours = new List<DateTime>();
            lesJours.Add(premierJour);
            DateTime jourActuel = premierJour;
            for (int d = 1; d < 5; d++)
            {
                jourActuel = jourActuel.AddDays(1);
                lesJours.Add(jourActuel);
            }

            return lesJours;
        }


        private int GetNumeroSemaine()
        {
            CultureInfo ciCurr = CultureInfo.CurrentCulture;
            int numSem = ciCurr.Calendar.GetWeekOfYear(DateTime.Now, CalendarWeekRule.FirstFourDayWeek, DayOfWeek.Monday);

            return numSem;
        }

        private DateTime PremierJour(int numeroSemaine)
        {
            DateTime premierJanvier = new DateTime(2019, 1, 1);

            int nbJours = (int)CultureInfo.CurrentCulture.DateTimeFormat.FirstDayOfWeek - (int)premierJanvier.DayOfWeek;

            DateTime firstMonday = premierJanvier.AddDays(nbJours);

            int premiereSemaine = CultureInfo.CurrentCulture.Calendar.GetWeekOfYear(premierJanvier, CultureInfo.CurrentCulture.DateTimeFormat.CalendarWeekRule, CultureInfo.CurrentCulture.DateTimeFormat.FirstDayOfWeek);

            if (premiereSemaine <= 1)
            {
                numeroSemaine -= 1;
            }

            return firstMonday.AddDays(numeroSemaine * 7);
        }
    }
}
