using AutoMapper;
using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.ObavijestStateMachine
{
    public class InitialState : BaseState
    {
        public InitialState(IServiceProvider serviceProvider, eMektebContext eMektebContext, IMapper mapper) : base(serviceProvider, eMektebContext, mapper)
        {
        }

        public override async Task<ObavijestM> Insert(ObavijestInsert req)
        {
            var set = _context.Set<Obavijest>();

            var entity = _mapper.Map<Obavijest>(req);
            entity.StateMachine = "draft";

            set.Add(entity);

            await _context.SaveChangesAsync();

            return _mapper.Map<ObavijestM>(entity);
        }

        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();
            list.Add("Insert");

            return list;
        }
    }
}
