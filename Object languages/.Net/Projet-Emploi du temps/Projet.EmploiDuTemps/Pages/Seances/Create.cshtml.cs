using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using Projet.EmploiDuTemps.Data;
using Projet.EmploiDuTemps.Models;

namespace Projet.EmploiDuTemps.Pages.Seances
{
    [Authorize]
    public class CreateModel : PageModel
    {
        private readonly Projet.EmploiDuTemps.Data.ApplicationDbContext _context;

        public CreateModel(Projet.EmploiDuTemps.Data.ApplicationDbContext context)
        {
            _context = context;
        }

        public IActionResult OnGet()
        {
            ViewData["TypeSeanceID"] = new SelectList(_context.TypeSeance, "ID", "Intitule");
            ViewData["SalleID"] = new SelectList(_context.Salle, "ID", "NomSalle");
            ViewData["EnseignementID"] = new SelectList(_context.Enseignement, "ID", "ID");
            ViewData["EnseignantID"] = new SelectList(_context.Enseignant, "ID", "NomComplet");
            return Page();
        }

        [BindProperty]
        public Seance Seance { get; set; }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }

            _context.Seance.Add(Seance);
            await _context.SaveChangesAsync();

            return RedirectToPage("./Index");
        }
    }
}