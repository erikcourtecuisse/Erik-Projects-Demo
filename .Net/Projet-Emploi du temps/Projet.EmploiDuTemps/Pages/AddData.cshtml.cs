using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Authorization;

namespace Projet.EmploiDuTemps.Pages
{
    [Authorize]
    public class AddDataModel : PageModel
    {
        public void OnGet()
        {

        }
    }
}