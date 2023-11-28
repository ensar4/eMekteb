using AutoMapper;
using eMekteb.Services.Database;
using eMekteb.Services.Exceptions;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.ObavijestStateMachine
{
    public class BaseState
    {
        protected eMektebContext _context;
        protected IMapper _mapper { get; set; }

        public IServiceProvider _serviceProvider { get; set; }

        public BaseState(IServiceProvider serviceProvider, eMektebContext eMektebContext, IMapper mapper)
        {
            _context = eMektebContext;
            _mapper = mapper;
            _serviceProvider = serviceProvider;
        }

        public virtual Task<ObavijestM> Insert(ObavijestInsert entity)
        {
            throw new UserExceptions("Not allowed");
        }

        public virtual Task<ObavijestM> Update(int id, ObavijestUpdate entity)
        {
            throw new UserExceptions("Not allowed");
        }

        public virtual Task<ObavijestM> Activate(int id)
        {
            throw new UserExceptions("Not allowed");
        }

        public virtual Task<ObavijestM> Hide(int id)
        {
            throw new UserExceptions("Not allowed");
        }

        public virtual Task<ObavijestM> Delete(int id)
        {
            throw new UserExceptions("Not allowed");
        }

        public BaseState GetState(string status)
        {
            switch (status)
            {
                case "initial":
                case null:
                    return _serviceProvider.GetService<InitialState>();
                    break;
                case "draft":
                    return _serviceProvider.GetService<DraftState>();
                    break;
                case "active":
                    return _serviceProvider.GetService<ActiveState>();
                    break;

                default:
                    throw new UserExceptions("Not allowed");

            }
        }

        public virtual async Task<List<string>> AllowedActions()
        {
            return new List<string>();
        }
    }
}
