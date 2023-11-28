using AutoMapper;
using eMekteb.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.ObavijestStateMachine
{
    public class ActiveState : BaseState
    {
        public ActiveState(IServiceProvider serviceProvider, eMektebContext eMektebContext, IMapper mapper) : base(serviceProvider, eMektebContext, mapper)
        {
        }

        public async override Task<ObavijestM> Hide(int id)
        {
            var set = _context.Set<Obavijest>();

            var entity = await set.FindAsync(id);

            entity.StateMachine = "draft";

            await _context.SaveChangesAsync();

            return _mapper.Map<ObavijestM>(entity);
        }

        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();
            list.Add("Hide");

            return list;
        }
    }
}
