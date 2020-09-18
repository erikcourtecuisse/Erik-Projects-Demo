using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Projet.EmploiDuTemps.Models;

namespace Projet.EmploiDuTemps.Data
{
    public class ApplicationDbContext : IdentityDbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer(@"Server=(localdb)\mssqllocaldb;Database=EmploiDuTempsDB;Trusted_Connection=True;MultipleActiveResultSets=true");
        }
        public DbSet<Projet.EmploiDuTemps.Models.Seance> Seance { get; set; }
        public DbSet<Projet.EmploiDuTemps.Models.Batiment> Batiment { get; set; }
        public DbSet<Projet.EmploiDuTemps.Models.Enseignement> Enseignement { get; set; }
        public DbSet<Projet.EmploiDuTemps.Models.Groupe> Groupe { get; set; }
        public DbSet<Projet.EmploiDuTemps.Models.Salle> Salle { get; set; }
        public DbSet<Projet.EmploiDuTemps.Models.TypeSeance> TypeSeance { get; set; }
        public DbSet<Projet.EmploiDuTemps.Models.UE> UE { get; set; }
        public DbSet<Projet.EmploiDuTemps.Models.Enseignant> Enseignant { get; set; }
        
    }
}
