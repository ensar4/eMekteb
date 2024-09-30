using eMekteb.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Interfaces
{
    public interface IService<T, TSearch> where TSearch : class
    {
        Task<T>GetById(int id);
        Task<PagedResult<T>> Get(TSearch search = null);
       

    }
}
