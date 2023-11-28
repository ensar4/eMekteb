using AutoMapper;
using eMekteb.Services.Database;

namespace eMekteb.Services.ObavijestStateMachine
{
    public class DraftState : BaseState
    {
        public DraftState(IServiceProvider serviceProvider, eMektebContext eMektebContext, IMapper mapper) : base(serviceProvider, eMektebContext, mapper)
        {
        }

        public override async Task<ObavijestM> Update(int id, ObavijestUpdate req)
        {
            var set = _context.Set<Obavijest>();

            var entity = await set.FindAsync(id);

            _mapper.Map(req, entity);

            await _context.SaveChangesAsync();

            return _mapper.Map<ObavijestM>(entity);
        }

        public override async Task<ObavijestM> Activate(int id)
        {
            var set = _context.Set<Obavijest>();

            var entity = await set.FindAsync(id);

            entity.StateMachine = "active";

            await _context.SaveChangesAsync();

            return _mapper.Map<ObavijestM>(entity);
        }

        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();
            list.Add("Update");
            list.Add("Activate");

            return list;
        }

    }
}

