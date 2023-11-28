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
    public class UlogaService : BaseCRUDService<UlogaM, Uloga, BaseSearchObject, UlogaInsert, object>, IUlogaService
    {
        public UlogaService(eMektebContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

       



    }
}
