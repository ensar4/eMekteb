using AutoMapper;
using eMekteb.Model;
using eMekteb.Model.Request;
using eMekteb.Model.SearchObjects;
using eMekteb.Services.Database;
using eMekteb.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services
{
    public class RazredService : BaseCRUDService<RazredM, Razred, BaseSearchObject, RazredInsert, object>, IRazredService
    {
        public RazredService(eMektebContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }
   


    }
}
