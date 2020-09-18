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
    public class IndexModel : PageModel
    {
        private readonly Projet.EmploiDuTemps.Data.ApplicationDbContext _context;

        public IndexModel(Projet.EmploiDuTemps.Data.ApplicationDbContext context)
        {
            _context = context;
        }

        public IList<Groupe> Groupe { get;set; }

        public async Task OnGetAsync()
        {
            Groupe = await _context.Groupe.ToListAsync();
        }
    }
}
