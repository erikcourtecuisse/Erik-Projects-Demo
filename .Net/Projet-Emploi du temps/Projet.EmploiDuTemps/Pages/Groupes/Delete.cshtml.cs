using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using Projet.EmploiDuTemps.Data;
using Projet.EmploiDuTemps.Models;

namespace Projet.EmploiDuTemps.Pages.Groupes
{
    [Authorize]
    public class DeleteModel : PageModel
    {
        private readonly Projet.EmploiDuTemps.Data.ApplicationDbContext _context;

        public DeleteModel(Projet.EmploiDuTemps.Data.ApplicationDbContext context)
        {
            _context = context;
        }

        [BindProperty]
        public Groupe Groupe { get; set; }

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            Groupe = await _context.Groupe.FirstOrDefaultAsync(m => m.ID == id);

            if (Groupe == null)
            {
                return NotFound();
            }
            return Page();
        }

        public async Task<IActionResult> OnPostAsync(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            Groupe = await _context.Groupe.FindAsync(id);

            if (Groupe != null)
            {
                _context.Groupe.Remove(Groupe);
                await _context.SaveChangesAsync();
            }

            return RedirectToPage("./Index");
        }
    }
}
