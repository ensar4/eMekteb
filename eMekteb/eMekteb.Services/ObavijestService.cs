using AutoMapper;
using eMekteb.Model;
using eMekteb.Model.Request;
using eMekteb.Model.SearchObjects;
using eMekteb.Services.Database;
using eMekteb.Services.Interfaces;
using eMekteb.Services.ObavijestStateMachine;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace eMekteb.Services
{
    public class ObavijestService : BaseCRUDService<ObavijestM, Obavijest, ObavijestSearchObject, ObavijestInsert, ObavijestUpdate>, IObavijestService
    {

        BaseState _baseState { get; set; }
        public ObavijestService(BaseState baseState,eMektebContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
            _baseState = baseState;
        }
        public override IQueryable<Obavijest> AddFilter(IQueryable<Obavijest> query, ObavijestSearchObject? search)
        {
            if (!string.IsNullOrWhiteSpace(search?.naziv))
            {
                query = query.Where(y => y.Naslov.StartsWith(search.naziv));
            }

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                query = query.Where(y => y.Naslov.Contains(search.FTS));
            }
            return base.AddFilter(query, search);
        }

        public async Task<PagedResult<ObavijestM>> GetByMektebId(int mektebId)
        {
            var items = await _dbContext.Set<Obavijest>()
                                    .Where(y => y.MektebId == mektebId).OrderByDescending(y=>y.Id)
                                    .ToListAsync();
            PagedResult<ObavijestM> result = new PagedResult<ObavijestM>();
            result.Count = items.Count();


            var tmp = _mapper.Map<List<ObavijestM>>(items);
            result.Result = tmp;

            return result;
        }

        public override Task<ObavijestM> Insert(ObavijestInsert insert)
        {
            var state = _baseState.GetState("initial");

            return state.Insert(insert);
        }

        public override async Task<ObavijestM> Update(int id, ObavijestUpdate update)
        {
            var entity1 = await _dbContext.Obavijest.FindAsync(id);

            var state = _baseState.GetState(entity1?.StateMachine);

            return await state.Update(id, update);
        }

        public async Task<ObavijestM> Activate(int id)
        {
            var entity1 = await _dbContext.Obavijest.FindAsync(id);

            var state = _baseState.GetState(entity1?.StateMachine);

            return await state.Activate(id);
        }

        public async Task<ObavijestM> Hide(int id)
        {
            var entity1 = await _dbContext.Obavijest.FindAsync(id);

            var state = _baseState.GetState(entity1?.StateMachine);

            return await state.Hide(id);
        }

        public async Task<List<string>> AllowedActions(int id)
        {
            var entity1 = await _dbContext.Obavijest.FindAsync(id);

            var state = _baseState.GetState(entity1?.StateMachine ?? "initial");

            return await state.AllowedActions();
        }

    }
}
