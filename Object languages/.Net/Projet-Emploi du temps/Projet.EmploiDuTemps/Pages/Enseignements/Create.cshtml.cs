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

namespace Projet.EmploiDuTemps.Pages.Enseignements
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
            ViewData["GroupeID"] = new SelectList(_context.Groupe, "ID", "NomGroupe");
            ViewData["UEID"] = new SelectList(_context.UE, "ID", "NomComplet");
            return Page();
        }

        [BindProperty]
        public Enseignement Enseignement { get; set; }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }

            _context.Enseignement.Add(Enseignement);
            await _context.SaveChangesAsync();

            return RedirectToPage("./Index");
        }
    }
}