﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using Projet.EmploiDuTemps.Data;
using Projet.EmploiDuTemps.Models;

namespace Projet.EmploiDuTemps.Pages.Batiments
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
            return Page();
        }

        [BindProperty]
        public Batiment Batiment { get; set; }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }

            _context.Batiment.Add(Batiment);
            await _context.SaveChangesAsync();

            return RedirectToPage("./Index");
        }
    }
}